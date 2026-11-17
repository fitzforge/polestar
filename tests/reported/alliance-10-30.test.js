'use strict';
// Player-reported guide fixes: the Alliance leveling guides to 30 (guides/forever/alliance/NN-*.guide).
// tests/reported/helpers.js says what the cases check and where a new one goes.

const { test } = require('node:test');
const assert = require('node:assert/strict');
const fs = require('node:fs');
const path = require('node:path');
const {
	allGuides, ASHENVALE, at, atAuctionHouse, buildSimPack, collects, compiled, DARKSHORE, DARKSHORE_RETURN,
	darkshoreBoth, dist, dungeonOnly, forAllOnly, forClass, forRaceOf, goals, greyInDarkshore, headers, is,
	loadCorrections, located, LOCH_MODAN, makeProjector, notesOf, OFFICIAL_DIR, PLACES, playGuide, questGoalStatus,
	REDRIDGE, refData, ROOT, SIMULATE, skip, stepsHolding, stepTips, THOUSAND_NEEDLES, WESTFALL, WETLANDS, working,
	yards,
} = require('./helpers');

// --- end of Alliance quest volume

// --- Alliance 12-20 zone order (2026-11-07). Darkshore is played in two parts around an Eastern Kingdoms
// loop at 18-20 (03-loch-modan: Loch Modan, Redridge and the Defias chain in Westfall), where those
// zones' 15-20 quests give full XP; before, the route never went to Loch Modan after the starts, did
// Redridge's 15-18 quests at 24 and entered Ashenvale at 20 with a grind there. Dwarves and Gnomes do
// east Elwynn on the walk from Goldshire to Westfall (Humans in their start guide; Night Elves and
// Skyborne arrive at 14.5, where its level 9-10 quests turn grey).
const A1220_LOCH = ['forever/alliance/03-loch-modan.guide', [127, 250, 199, 86614, 436, 297, 298, 301, 86613, 86758, 257, 258, 86585, 244, 246, 98407, 118, 119, 120, 121, 125, 89, 129, 130, 131, 92, 3741, 122, 124, 132, 135, 141, 142, 155, 104]];
const A1220_ELWYNN = [40, 35, 37, 52, 45, 71, 39, 83, 5545, 91732, 91733, 91723, 91725];
const waitsOnVendor = (st) => st.goals.some((g) => g.t === 'vendor' && !g.optional && forAllOnly(g.only)) && st.goals.some((g) => !['vendor', 'note'].includes(g.t) && !g.optional);
// Every compiled point of a goal (its own and its spots), in world yards from a recorded point.
function nearestYards(goal, map, x, y) {
	const pts = [goal, ...(goal.spots || [])].filter((o) => o.x != null);
	return Math.min(...pts.map((o) => yards({ map, x: o.x, y: o.y }, { map, x, y })));
}

// doctor-house's report (#1509): "Route has you walk into the Tower of Azora for no reason". Loch Modan's walk east
// through Elwynn to Redridge pointed at 65.2,69.7, Theocritus's spot inside the tower, ~90 yd north of the road.
// The point is on the road below it (the walking route passes 65.8,74.0), in Elwynn.
test('forever/alliance/03-loch-modan.guide: the road east to Redridge points at the road, not into the Tower of Azora (#1509)', { skip }, () => {
	const list = goals('forever/alliance/03-loch-modan.guide');
	const { goal } = list.find(({ goal }) => goal.t === 'goto' && goal.text === 'The road east to Redridge');
	assert.equal(goal.map, 1429, 'in Elwynn Forest');
	assert.ok(Math.hypot(goal.x - 65.2, goal.y - 69.7) > 3, `not at the tower (${goal.x},${goal.y})`);
	assert.ok(Math.hypot(goal.x - 65.8, goal.y - 74.0) < 0.5, `on the road (${goal.x},${goal.y})`);
});

test('forever/alliance/03-darkshore.guide: Wogi\'s report: with Skip grey quests on, a Human at 20 leaves out the grey quests, keeps the Buzzbox chain, and one on the route\'s level keeps them all', { skip }, () => {
	// At 20, quests of level 13 and below are grey. Buzzbox 827 (983, level
	// 10) and Buzzbox 411 (1001, 12) open Buzzbox 323 and 525, the first
	// Washed Ashore (3524, 13) the second, and the two grey beached remains
	// (4722, 4723) Holy Diver: they stay.
	assert.deepEqual(greyInDarkshore(20).skipped.sort((a, b) => a - b), [953, 954, 955, 956, 957, 958, 98025]);
	// The simulator's Human reaches Darkshore at 16 to 18: Buzzbox 827 is
	// already grey then, and stays for its chain.
	assert.deepEqual(greyInDarkshore(17).skipped, []);
});

test('forever/alliance/03-darkshore.guide: XooVe\'s report (#216): a grey quest Skip grey quests keeps says which quest it opens', { skip }, () => {
	// At 20 Buzzbox 323 (1002, level 14) is the nearest quest still worth
	// doing that 827 and 411 lead to; at 22 only Buzzbox 525 (1003, 16) is.
	const at20 = greyInDarkshore(20).kept;
	assert.deepEqual(at20['983'], [1002, 'Grey, kept: opens “Buzzbox 323”']);
	assert.deepEqual(at20['1001'], [1002, 'Grey, kept: opens “Buzzbox 323”']);
	const at22 = greyInDarkshore(22).kept;
	assert.deepEqual(at22['983'], [1003, 'Grey, kept: opens “Buzzbox 525”']);
	// At 23 the whole chain is grey and left out: nothing kept says so.
	const at23 = greyInDarkshore(23);
	assert.equal(at23.kept['983'], undefined);
	assert.ok(at23.skipped.includes(983));
});

// Floki's report (#1523): from the Greenwarden's Grove the step back to Captain Stoutfist said "Back west along the road",
// about 1.9 km, though the guide binds the Hearthstone at Menethil's Deepwater Tavern and never uses it before. The arrow
// takes the Hearthstone when it saves the walk; the tip now says so too. Sweep (long walks back to the town of the
// guide's own unused bind, Alliance 12-30): 06-ashenvale's walk from Ironbeard's Tomb to Menethil and 05-duskwood's walk
// from Sven's camp to Darkshire (bound on 04's first Darkshire stop).
test(`${WETLANDS}: Floki's report (#1523): long walks back to the bind's town say to hearth`, { skip }, () => {
	for (const [guide, home, quest, says] of [
		[WETLANDS, WETLANDS, 464, /^Hearth back to Menethil Harbor/],
		[ASHENVALE, ASHENVALE, 306, /^Hearth back to Menethil Harbor/],
		['forever/alliance/05-duskwood.guide', REDRIDGE, 262, /^Hearth back to Darkshire/],
	]) {
		const list = goals(guide);
		const hand = at(list, `${guide}: turnin ${quest}`, is('turnin', quest));
		assert.ok(goals(home).some(({ goal }) => goal.t === 'sethome'), `${home} binds the Hearthstone`);
		assert.ok(!list.slice(0, hand).some(({ goal }) => goal.t === 'hearth'), `${guide}: the Hearthstone is not used before`);
		assert.match(list[hand].step.note || '', says, `${guide}: the step says to hearth back`);
	}
});

// Bennistrov (#1354): a Night Elf Druid at 30 had skipped Captain Stoutfist's A Friend of the Family (98190). At
// Stormwind Keep the turn-in read "You skipped this quest", but the guide still sent them to Bolvar for his A
// Friend of the Family (98191), which he offers only once 98190 is handed in to him: the data had no
// prerequisite (correction 98191, from the follow-up sweep of players' recordings).
test(`${WETLANDS}: Bennistrov's report (#1354): Bolvar's A Friend of the Family goes with the skipped one before it`, { skip }, () => {
	const druid = { race: 'NightElf', raceName: 'Night Elf', faction: 'Alliance', cls: 'DRUID', className: 'Druid', level: 30 };
	const skipped = questGoalStatus(WETLANDS, 98191, druid, { after: 'E.SkipQuest(98190)' });
	assert.ok(skipped.length >= 2, `98191's goals: ${skipped.join(', ')}`);
	assert.ok(skipped.every((s) => / (skipped|na)$/.test(s)), `with 98190 skipped, 98191 is not open: ${skipped.join(', ')}`);
	const done = questGoalStatus(WETLANDS, 98191, druid, { skills: 'w.complete({ 98190 })' });
	assert.ok(done.every((s) => !/ (skipped|na)$/.test(s)), `with 98190 handed in, 98191 is open: ${done.join(', ')}`);
	const list = goals(WETLANDS);
	assert.deepEqual(list[at(list, 'accept 98191', is('accept', 98191))].goal.pre, [98190], 'Bolvar\'s A Friend of the Family needs Captain Stoutfist\'s');
});

// --- Wetlands (Bennistrov, #1299): 0.3.5 took This Land Was Their Land (98230) on the first Menethil visit,
// where Captain Stoutfist doesn't offer it. Players' recordings: refused to 9 people who could take it, none of
// whom had handed in Defeat Nek'rosh (474); offered to the one character right after 474's hand-in.
test(`Bennistrov's report: This Land Was Their Land is taken only after Defeat Nek'rosh is handed in, on its group branch (#1299)`, { skip }, () => {
	assert.ok(!goals(WETLANDS).some(({ goal }) => goal.quest === 98230), `${WETLANDS} does not take it on the first Menethil visit`);
	let seen = 0;
	for (const guide of allGuides()) {
		const list = goals(guide);
		for (const { step, goal } of list.filter(({ goal }) => goal.quest === 98230)) {
			seen++;
			assert.ok((step.when || []).some((p) => p.k === 'group' && [p.q].flat().includes(474) && !p.neg), `${guide}: ${goal.t} 98230 is under when group 474`);
		}
		const take = list.findIndex(({ goal }) => is('accept', 98230)(goal));
		if (take < 0) continue;
		assert.ok(at(list, 'turnin 474', is('turnin', 474)) < take, `${guide}: Defeat Nek'rosh is handed in before 98230 is taken`);
		assert.ok(take < at(list, 'turnin 98230', is('turnin', 98230)), `${guide}: handed in to Howin after it is taken`);
	}
	assert.equal(seen, 2, 'one accept and one hand-in');
});

test('Alliance 12-21: Westfall, Darkshore and Loch Modan start where Humans enter them, within one level', () => {
	const all = headers();
	for (const [id, human, top] of [['forever/alliance/02-westfall', 11.35, 17.54], ['forever/alliance/03-darkshore', 15.27, 19.38], ['forever/alliance/03-loch-modan', 17.77, 21.61]]) {
		assert.ok(all[id].min <= human + 1 && all[id].min >= Math.floor(human), `${id} starts at ${all[id].min}; Humans enter at ${human}`);
		assert.ok(all[id].max >= Math.floor(top), `${id} ends at ${all[id].max}; the last start leaves at ${top}`);
	}
});

// --- Wetlands (Bennistrov, #1312): From the Ashes' step pointed at Chieftain Nek'rosh (53.5,54.5), where none of the
// four Attack Plans lie. Players' recordings tick each plan at its own spot in the Dragonmaw camp north of the dig.
test(`${WETLANDS}: Bennistrov's report: From the Ashes points at each of the four Attack Plans, not at Nek'rosh (#1312)`, { skip }, () => {
	const list = goals(WETLANDS).filter(({ goal }) => goal.quest === 98221 && goal.t !== 'accept' && goal.t !== 'turnin');
	const near = (g, x, y) => Math.hypot(g.x - x, g.y - y) < 1;
	for (const [n, x, y] of [[1, 45.6, 42.7], [2, 49.4, 46.8], [3, 45.4, 45.7], [4, 38.5, 46.1]]) {
		const g = list.find(({ goal }) => goal.t === 'interact' && goal.oi === n);
		assert.ok(g && g.goal.map === 1437 && near(g.goal, x, y), `98221.${n} at ${x},${y}`);
	}
	assert.ok(!list.some(({ goal }) => goal.x != null && near(goal, 53.5, 54.5)), 'nothing points at Nek\'rosh');
});

// Thin-data audit (#1317): War Banners' goal had no place, and the banner's drop list includes the elite Forever
// Dragonmaw (29-30) east of the camp; players' recordings tick it on the Raiders and Swamprunners around 45.5,44.7.
test(`${WETLANDS}: thin-data audit: War Banners points at the Raiders' and Swamprunners' camp, not among the elite Dragonmaw (#1317)`, { skip }, () => {
	const list = goals(WETLANDS);
	const { goal } = list[at(list, 'collect 3337 (War Banners)', (g) => g.t === 'collect' && g.quest === 464)];
	assert.equal(goal.map, 1437, 'on the Wetlands map');
	assert.ok(Math.hypot(goal.x - 45.5, goal.y - 44.7) < 1, `at the camp (${goal.x},${goal.y})`);
});

// Thin-data audit (#1317): Uncovering the Past's relics and Loose Soil lie among the elite Goaz Warders (32) Forever
// added at Whelgar's dig; the step mentioned them only for the optional Titanic Keystone.
test(`${WETLANDS}: thin-data audit: Uncovering the Past warns of the elite Goaz Warders among the relics (#1317)`, { skip }, () => {
	const list = goals(WETLANDS);
	const { step } = list[at(list, 'collect 2661 (Loose Soil)', (g) => g.t === 'collect' && g.quest === 299 && g.item === 2661)];
	assert.match([].concat(step.note || []).join(' '), /Goaz Warders \(elite, 32\)/);
});

// --- Westfall (#144, lifted 2026-11-08): Alba Fairmoon's Toxic Soil chain is for
// every Alliance race, Humans included. Players' recordings show Human characters
// taking and handing it in (9 people for Testing the Wells, 7 for Moonbrook
// Espionage), and the server's race mask in players' caches has Human.

test(`${WESTFALL}: Alba Fairmoon's chain is given to Humans too (#144 lifted by players' recordings)`, { skip }, () => {
	const chain = new Set([92742, 92744, 92745, 92747, 92748]);
	const list = goals(WESTFALL).filter(({ goal }) => chain.has(goal.quest));
	assert.ok(list.length > 0, 'the chain is in the guide');
	for (const { step, goal } of list) {
		const races = [step.only, goal.only].flatMap((o) => (o && o.races) || []);
		assert.ok(!races.length || races.includes('Human'), `${goal.t} ${goal.quest} is open to Humans`);
	}
});

// --- Darkshore (XooVe, #213): the first loop walked past a Beached Sea
// Creature from Asterion to Buzzbox 411 and the second loop came back for it.

test(`${DARKSHORE}: XooVe's report: the Beached Sea Creature by Bashal'Aran is taken on the walk from Asterion to Buzzbox 411 (#213)`, { skip }, () => {
	const list = darkshoreBoth();
	const take = at(list, 'accept 4723 (Beached Sea Creature)', is('accept', 4723));
	assert.equal(list[take].step.title, "Bashal'Aran", "it is taken in the Bashal'Aran step");
	assert.ok(at(list, 'accept 957 (Asterion)', is('accept', 957)) < take, 'after Asterion');
	assert.ok(take < at(list, 'turnin 1001 (Buzzbox 411)', is('turnin', 1001)), 'before Buzzbox 411');
	// Handed in at the first hearth, with the Beached Sea Turtle, before the second loop.
	const handIn = at(list, 'turnin 4723', is('turnin', 4723));
	assert.equal(list[handIn].step, list[at(list, 'turnin 4722', is('turnin', 4722))].step, 'handed in with 4722');
	assert.ok(handIn < at(list, 'accept 4728', is('accept', 4728)), 'before the second loop');
});

// --- Darkshire (Yendi, 0.2.3): part 1 of Look to the Stars needs a Bronze Tube.


// nikilok (#1792): the Darkshire buy sent players to Herble Baubbletump, who never had a tube in players' recordings (44
// merchant windows of 28 people). Darkshire has no buy now; the tube comes from the Stormwind Auction House (below) or,
// on the way, from Gearcutter Cogspinner in Tinker Town, on 06-ashenvale's Ironforge stop beside Lomac Gearstrip.
test(`${REDRIDGE}: nikilok's report (#1792): no Bronze Tube from Herble; Gearcutter Cogspinner's on the Ironforge stop before, optional`, { skip }, () => {
	const red = goals(REDRIDGE);
	assert.ok(!red.some(({ goal }) => goal.t === 'buy' && goal.item === 4371), 'no buy in 04-redridge-mountains');
	// (#2243: without a tube the guide passes Viktori's step on its own; see Acrylic's report below.)
	const take = at(red, 'accept 174 (Look to the Stars)', is('accept', 174));
	assert.ok((red[take].step.when || []).some((p) => p.k === 'has' && !p.neg && p.item === 4371), "Viktori's step only with a Bronze Tube");
	const ash = goals('forever/alliance/06-ashenvale.guide');
	const buy = at(ash, 'buy 4371 (Bronze Tube)', (g) => g.t === 'buy' && g.item === 4371);
	assert.equal(ash[buy].goal.npc, 5175, 'from Gearcutter Cogspinner');
	assert.equal(ash[buy].goal.optional, true, 'optional: often sold out, and a player with a tube is not held');
	assert.equal(ash[buy].s, ash[at(ash, 'turnin 1072 (Lomac Gearstrip)', is('turnin', 1072))].s, 'on the Tinker Town stop with Lomac Gearstrip');
});
test(`${REDRIDGE}: uNBEx's report (#1348): the Bronze Tube comes from the Stormwind Auction House before Darkshire`, { skip }, () => {
	const list = goals(REDRIDGE);
	const ah = at(list, 'collect 4371 at the Auction House', (g) => g.t === 'collect' && g.item === 4371);
	assert.ok(atAuctionHouse(list[ah].goal), 'the arrow leads to the Trade District Auction House');
	assert.equal(list[ah].goal.optional, true, 'optional: a player with a tube, or without the money, is not held');
	const take = at(list, 'accept 174 (Look to the Stars)', is('accept', 174));
	assert.ok(list[ah].s < list[take].s, 'on a stop before Darkshire, where Look to the Stars is taken');
});

// Alliance 12-30 bracket review 0.3.6: Dusky Crab Cakes (93, 780 XP) is Chef Grual's follow-up to Jitters' Growling Gut
// (5), handed to him on 04's last Darkshire stop; its Gooey Spider Legs drop from Duskwood's spiders without the quest, so
// many players hand it in at once. Return to Jitters (240, 975 XP) ends at Jitters, on 05's Raven Hill stop.
test(`${REDRIDGE} / 05-duskwood: Dusky Crab Cakes taken with Jitters' Growling Gut's hand-in, Return to Jitters handed in at Raven Hill`, { skip }, () => {
	const red = goals(REDRIDGE);
	const grual = at(red, 'turnin 5', is('turnin', 5));
	const take = at(red, 'accept 93', is('accept', 93));
	assert.ok(take > grual && red[take].s === red[grual].s, 'taken from Chef Grual right after Jitters\' Growling Gut');
	const now = at(red, 'turnin 93', is('turnin', 93));
	assert.ok(red[now].s === red[take].s && red[now].goal.optional, 'handed in at once only when already complete: never holds the stop');
	const onquest = (e, q) => (e.step.when || []).some((p) => p.k === 'onquest' && !p.neg && [].concat(p.q).includes(q));
	const dusk = goals('forever/alliance/05-duskwood.guide');
	const legs = at(dusk, 'collect 2251 quest 93', (g) => g.t === 'collect' && g.item === 2251 && g.quest === 93);
	const hand = at(dusk, 'turnin 93', is('turnin', 93));
	const back = at(dusk, 'accept 240', is('accept', 240));
	const jitters = at(dusk, 'turnin 240', is('turnin', 240));
	assert.ok(onquest(dusk[legs], 93) && onquest(dusk[hand], 93), 'the legs and Chef Grual only for a character carrying it');
	assert.ok(legs < at(dusk, 'turnin 230 (Sven)', is('turnin', 230)), 'the legs on the first west trip, before Sven\'s camp');
	assert.ok(hand > at(dusk, 'turnin 266 (Smitts)', is('turnin', 266)) && hand < at(dusk, 'collect 1598 (Rot Blossoms)', (g) => g.t === 'collect' && g.item === 1598), 'handed to Chef Grual on the next Darkshire stop, in the tavern');
	assert.ok(back > hand && onquest(dusk[jitters], 240), 'Return to Jitters only for a character carrying it');
	assert.ok(jitters > at(dusk, 'turnin 453 (Jitters)', is('turnin', 453)) && jitters < at(dusk, 'turnin 268 (Sven)', is('turnin', 268)), 'handed in on the Raven Hill stop');
});

// Alliance 12-30 bracket review 0.3.6: Howling in the Hills (126, 2000 XP) from Verner Osgood on the Lakeshire stop; Yowler
// stands at the top of the Redridge Canyons on the walk up to Render's Valley, Verner on the way back through town.
test(`${REDRIDGE}: Howling in the Hills taken in Lakeshire, Yowler on the walk to Render's Valley, handed in on the way back`, { skip }, () => {
	const list = goals(REDRIDGE);
	const take = at(list, 'accept 126', is('accept', 126));
	assert.equal(list[take].s, list[at(list, 'turnin 150 (Baren)', is('turnin', 150))].s, 'on the Lakeshire stop with Dockmaster Baren');
	const paw = at(list, 'collect 3614 quest 126', (g) => g.t === 'collect' && g.item === 3614 && g.quest === 126);
	assert.ok(located(list[paw]) && list[paw].goal.y < 25, 'Yowler has a point at the top of the canyons');
	assert.ok(paw > take && paw < at(list, 'kill 435 (Render\'s Valley)', (g) => g.t === 'kill' && g.npc === 435), 'on the walk up to Render\'s Valley');
	const hand = at(list, 'turnin 126', is('turnin', 126));
	assert.ok(hand > at(list, 'accept 219 (Keeshan)', is('accept', 219)) && list[hand].s === list[at(list, 'turnin 219', is('turnin', 219))].s, 'handed in on the way back through Lakeshire');
});

// Alliance 12-30 bracket review 0.3.6 (talk-order sweep): on the Duskwood return's last Darkshire stop the Weathered Grave's
// hand-in at Commander Althea (town hall) sat between Sirra Von'Indi's goals (house behind it), one round trip more; it now
// goes with Althea's other hand-in after Sirra.
test(`${THOUSAND_NEEDLES}: the Darkshire stop finishes at Sirra Von'Indi before going back to the town hall`, { skip }, () => {
	const list = goals(THOUSAND_NEEDLES);
	const lastSirra = Math.max(...[251, 225, 96138, 401].map((q) => at(list, `turnin ${q}`, is('turnin', q))), at(list, 'accept 252', is('accept', 252)));
	const grave = at(list, 'turnin 227', is('turnin', 227));
	assert.ok(grave > lastSirra && grave > at(list, 'turnin 252', is('turnin', 252)) && list[grave].s === list[at(list, 'turnin 58', is('turnin', 58))].s, 'Althea\'s Weathered Grave hand-in with The Night Watch, after Sirra');
});

// Level tidy 0.4.0: Worgen in the Woods (222) sent players at Nightbane Tainted Ones (30-31) on 07's first loop south
// of Darkshire, at 29 (recordings: 25th percentile 29.8; 5 people died there). Its kills now come after the west loop
// and Lord Ello's hand-in, right before the flight out, with Calor's hand-in and 223 on the way back to the flight master.
test(`${THOUSAND_NEEDLES}: level tidy 0.4.0: Worgen in the Woods is hunted at the end of the Duskwood visit`, { skip }, () => {
	const list = goals(THOUSAND_NEEDLES);
	const tainted = at(list, 'kill 920 for 222', (g) => g.t === 'kill' && g.quest === 222 && g.npc === 920);
	assert.ok(tainted > at(list, 'turnin 252', is('turnin', 252)), 'after Lord Ello\'s hand-in');
	assert.ok(tainted > at(list, 'turnin 323', is('turnin', 323)), 'after the west loop (Sven)');
	assert.ok(at(list, 'turnin 223', is('turnin', 223)) > tainted && at(list, 'turnin 223', is('turnin', 223)) < at(list, 'fly Menethil', (g) => g.t === 'fly'), 'Calor and Carevin before the flight');
	assert.ok(at(list, 'collect 1946 for 177', (g) => g.t === 'collect' && g.item === 1946) < at(list, 'accept 181', is('accept', 181)), 'the Insane Ghoul stays on the first loop (181 is done at the ogre mound)');
});

// The goals the stray rule moved, checked against their steps (#175 review): the
// Grizzled Scalps are taken where the bears are, and cloth the guide says to buy
// leads to the Auction House, not to the guards and mobs that happen to drop it.

test('forever/alliance/03-darkshore-return.guide: the Grizzled Scalps are collected in the step at the Grove, where the bears are and Buzzbox 525 takes them', { skip }, () => {
	const list = goals(DARKSHORE_RETURN);
	const i = at(working(list), 'Grizzled Scalp', (g) => g.t === 'collect' && g.item === 5414);
	const turnin = at(list, 'turnin 1003', is('turnin', 1003));
	assert.equal(list[i].step, list[turnin].step, 'one step: the bears and Buzzbox 525');
	assert.ok(i < turnin);
	assert.ok(yards(list[i].goal, list[turnin].goal) < 300, `the scalps' point ${list[i].goal.x},${list[i].goal.y} is near Buzzbox 525`);
});

test(`${DARKSHORE}: Twerkjob's report: The Red Crystal leads the arrow to the crystal on the eastern ridge (#241)`, { skip }, () => {
	const list = goals(DARKSHORE);
	const complete = list[at(list, 'complete 4811 (The Red Crystal)', is('complete', 4811))];
	// The step's first placed goal for the quest, past its accept: where the arrow leads.
	const lead = list.find(({ step, goal: g }) => step === complete.step && g.quest === 4811 && g.t !== 'accept' && g.t !== 'turnin' && located({ goal: g }));
	assert.ok(lead, 'the red crystal step has a goal the arrow can lead to');
	// "Locate the large, red crystal on Darkshore's eastern mountain range", the quest's area trigger.
	const crystal = refData().quests[4811].objectives.find((o) => o.type === 'event');
	assert.ok(yards(lead.goal, crystal) < 30, `the arrow leads to the crystal (${lead.goal.x},${lead.goal.y})`);
});

// The Blackwood Corrupted's only objective is the Talisman of Corruption, but
// Xabraxxis' Demon Bag holds it only once the satyr is summoned: the Empty
// Cleansing Bowl filled at the Auberdine Moonwell, a sample from each of the
// Blackwood Nut, Fruit and Grain Stores, and the mixed bowl used by the
// bonfire (the quest's text; its required items in the data).
test(`${DARKSHORE}: XooVe's report (#302): The Blackwood Corrupted fills the bowl and gathers the three samples before the Talisman, and uses the bowl where Xabraxxis comes`, { skip }, () => {
	const list = goals(DARKSHORE);
	const accept = at(list, 'accept 4763 (The Blackwood Corrupted)', is('accept', 4763));
	const talisman = at(list, 'the Talisman of Corruption', (g) => g.t === 'collect' && g.quest === 4763 && g.item === 12355);
	const quest = refData().quests[4763];
	const spawn = (kind, id) => {
		const [x, y] = refData()[kind][id].spawns[1439].pts[0];
		return { map: 1439, x, y };
	};
	// The samples and the filled bowl: what the quest needs beyond the bowl it hands over.
	const needed = quest.requiredItems.filter((item) => item !== quest.sourceItem);
	assert.deepEqual([...needed].sort(), [12341, 12342, 12343, 12347], 'the data lists the three samples and the filled bowl');
	const got = needed.map((item) => {
		const i = at(list, `collect ${item} (${refData().items[item].name})`, (g) => g.t === 'collect' && g.item === item);
		assert.ok(i > accept && i < talisman, `${refData().items[item].name} is collected after the accept and before the Talisman`);
		const [source] = Object.keys(refData().items[item].drops.object);
		assert.ok(located(list[i]) && yards(list[i].goal, spawn('objects', source)) < 5, `${refData().items[item].name} leads to ${refData().objects[source].name}`);
		return i;
	});
	const fill = got[needed.indexOf(12347)];
	assert.equal(list[fill].step, list[accept].step, 'the bowl is filled in Auberdine, where Thundris gives the quest');
	const use = at(list, 'use 12347 (Filled Cleansing Bowl)', (g) => g.t === 'use' && g.item === 12347);
	assert.ok(got.every((i) => i < use) && use < talisman, 'the bowl is used with every sample in the bags, before the Talisman');
	assert.ok(yards(list[use].goal, spawn('npcs', 10373)) < 10, `the bowl is used where Xabraxxis comes (${list[use].goal.x},${list[use].goal.y})`);
});

// --- Hearth advice is the arrow's (Fitz, 0.3.3): the guides never tell the
// player to hearth. The route still plans its hearth legs and the guide binds
// (`sethome`), but the step after leads straight to the next stop; whether to
// hearth there is the arrow's call, by the Hearthstone's cooldown and where it
// is set. Westfall's "Hearth to Sentinel Hill" after Moonbrook was one of 64.
// (This replaces #171's check that every hearth went to an inn the guide bound
// at: there are no hearths left to check.)
test('Fitz (0.3.3): no guide of ours has a hearth goal; Westfall walks from Moonbrook back to Sentinel Hill', { skip }, () => {
	const offenders = [];
	for (const guide of allGuides()) {
		for (const { step, goal } of goals(guide)) {
			if (goal.t === 'hearth') offenders.push(`${guide} (step ${step.title})`);
		}
	}
	assert.deepEqual(offenders, [], 'hearth goals');
	const list = goals(WESTFALL);
	assert.ok(!list.some(({ step }) => /^Hearth to/.test(step.title)), 'no "Hearth to" step');
	assert.ok(list.some(({ goal }) => goal.t === 'sethome' && goal.location === 'Sentinel Hill'), 'the bind at Sentinel Hill stays');
	// #1415 (vW1): the Moonbrook step moved to the 19-20 Westfall walk (03-loch-modan); it still walks on, no hearth.
	const loch = goals(LOCH_MODAN);
	const moonbrook = loch.findIndex(({ step }) => step.title === 'Moonbrook and the Defias hills');
	assert.ok(moonbrook >= 0, 'the Moonbrook step is in 03-loch-modan');
	assert.ok(!loch.some(({ step }) => /^Hearth to/.test(step.title)), 'no "Hearth to" step there');
	const back = loch.slice(moonbrook).findIndex(({ step }) => step.title === 'Sentinel Hill');
	assert.ok(back > 0, 'the walk goes on back to Sentinel Hill');
});

// Avtom (#280): "Kill Ribchaser (rare) or Redridge Brute for Iron Pike" led to
// the Redridge Mongrels' camp, where no Brute stands. Ribchaser, a rare, shares
// the Mongrels' spawn points and drops the quest's Iron Pike and Iron Rivet at
// 80%, the common Brutes, Mystics, Bashers and Drudgers at 65%: the highest
// chance put the rare first and the arrow led to its camp. A rare is passed
// over for the common droppers beside it, as elites are.

test(`${LOCH_MODAN}: Avtom's report (#280): Iron Pike and Iron Rivet lead to the gnolls that drop them, not to the rare Ribchaser's camp among the Mongrels`, { skip }, () => {
	const list = goals(LOCH_MODAN);
	const ribchaser = 14271;
	const camp = refData().spawns('npc', ribchaser).filter((s) => s.map === 1433).flatMap((s) => s.pts);
	assert.ok(camp.length, 'Ribchaser spawns in Redridge Mountains');
	for (const item of [2856, 1013]) {
		const i = at(list, `item ${item}`, (g) => g.t === 'collect' && g.quest === 89 && g.item === item);
		const g = list[i].goal;
		assert.notEqual(g.from, 'Ribchaser', `item ${item} names a common dropper, not the rare`);
		assert.notEqual(g.fromAlso, 'Ribchaser');
		assert.equal(g.fromRank, undefined, `item ${item} names a common dropper (rank ${g.fromRank})`);
		const dropper = new Set(Object.keys(refData().item(item).drops.npc).map(Number).filter((id) => id !== ribchaser));
		const spawns = [...dropper].flatMap((id) => refData().spawns('npc', id).filter((s) => s.map === 1433).flatMap((s) => s.pts));
		const near = (a, pts, r) => pts.some(([x, y]) => yards({ map: 1433, x: a.x, y: a.y }, { map: 1433, x, y }) <= r);
		const points = [g, ...(g.spots || []).filter((s) => !s.alt)];
		for (const p of points) {
			assert.ok(!near(p, camp, 60), `item ${item}: ${p.x},${p.y} is in Ribchaser's camp`);
			assert.ok(near(p, spawns, 120), `item ${item}: ${p.x},${p.y} is by a common dropper`);
		}
	}
});

// nikilok (#1339): "not clickable" two yards from the arrow. The Discarded Fishing Toolbox that
// offers Silver of the Waves lies at one of four places on the loch bed; the data knew one, so a
// player whose toolbox was at another stood at an empty spot with nowhere else to look. The
// correction places all four (players' recordings), and the goal's spawn areas cover each.

test(`${LOCH_MODAN}: nikilok's report (#1339): Silver of the Waves' toolbox is looked for at all four places players took it`, { skip }, (t) => {
	const taken = [[48.06, 39.7], [45.69, 43.36], [48.74, 54.42], [50.63, 53.29]];
	const fix = ((loadCorrections().objects || {})[665289] || {}).addSpawns;
	assert.ok(fix && fix[1432], 'forever-db places the toolbox on the loch bed');
	for (const [x, y] of taken) assert.ok(fix[1432].pts.some(([px, py]) => Math.hypot(px - x, py - y) <= 0.3), `the correction has the place ${x},${y}`);
	const list = goals(LOCH_MODAN);
	const { goal } = list[at(list, 'accept 86614 (Silver of the Waves)', is('accept', 86614))];
	assert.equal(goal.object, 665289, 'the toolbox offers the quest itself');
	const known = refData().spawns('object', 665289).filter((s) => s.map === 1432).flatMap((s) => [...s.pts, ...(s.more || [])]);
	if (known.length < taken.length) return t.skip(`data/forever predates the toolbox correction (${known.length} place): rebuild it`);
	for (const [x, y] of taken) {
		const pt = { map: 1432, x, y };
		assert.ok([goal, ...(goal.spots || [])].some((o) => yards({ map: 1432, x: o.x, y: o.y }, pt) <= (o.r || 15) + 1), `${x},${y} lies in one of the goal's spots: ${JSON.stringify(goal.spots)}`);
	}
});

// scalatrava (#1352): "can't pick up the Twilight Tome". The tome in the Master's Glaive offers
// It's All Fun and Games Until... (98042) only once The Twilight Camp (949) is handed in to it (every
// one of 19 people in the recordings took it seconds after that hand-in), and the step sent players
// to it for 98042 first.

test(`${DARKSHORE_RETURN}: scalatrava's report (#1352): the Twilight Tome's quest is taken after The Twilight Camp is handed in to it`, { skip }, () => {
	const fix = (loadCorrections().quests[98042] || {}).set || {};
	assert.deepEqual([fix.pre, fix.preAny], [[949], [949]], 'forever-db: 98042 comes after 949');
	const list = goals(DARKSHORE_RETURN);
	const accept = at(list, 'accept 98042', is('accept', 98042));
	assert.ok(at(list, 'turnin 949 (the tome)', is('turnin', 949)) < accept, 'The Twilight Camp is handed in to the tome before its next quest is taken');
	const { goal } = list[accept];
	if (refData().quests[98042].pre.includes(949)) assert.ok((goal.pre || []).includes(949), `the accept waits for 949: ${JSON.stringify(goal.pre)}`);
});

// --- Elemental Bracers (Tazul | Robin, #391): the step asked only for the
// Divined Scroll, which the Divining Scroll makes from five Intact Elemental
// Bracers. With no goal for the bracers, the target button had no elementals
// to target and the bracers were not counted. The bracer goal is optional:
// the Divined Scroll holds the step.

test(`Tazul's report: Elemental Bracers counts the five bracers before the Divined Scroll`, { skip }, () => {
	const list = goals(WETLANDS); // 0.4.0 fix round: Elemental Bracers moved from 06-ashenvale to the Krolg leg here
	const bracers = at(list, 'collect 12220', (g) => g.t === 'collect' && g.item === 12220);
	const scroll = at(list, 'collect 5455', (g) => g.t === 'collect' && g.item === 5455 && g.quest === 1016);
	assert.equal(list[bracers].goal.count, 5);
	assert.equal(list[bracers].goal.quest, undefined, 'counted in the bags: the Divining Scroll uses them up');
	assert.equal(list[bracers].goal.optional, true, 'a scroll made before the step does not wait on bracers it used up');
	assert.ok(bracers < scroll && list[bracers].s === list[scroll].s, 'the bracers come first, in the same step');
});

// --- Harvesting the Harvesters (Smuve, #298): the Precessive Autocognition
// Assembly that starts it drops about once in 900 kills of the Molsen Farm
// golems and watchers (Forever's quest data, item 255155: 161 of 187,474 Harvest
// Watchers, 54 of 46,307 Rusty Harvest Golems, checked 2026-10-17). The loot
// and the accept are optional goals of the farm step, so it does not wait for
// a drop most players never see; the turn-in at Saldean's Farm is plain and
// holds only a player who looted it.

test(`${WESTFALL}: Smuve's report (#298): the Molsen Farm step does not wait for the Precessive Autocognition Assembly; with one, it is handed in at Saldean's`, { skip }, () => {
	const pack = buildSimPack([WESTFALL]);
	try {
		const g = pack.guides[0];
		// The simulated player kills the farm's golems for Ozwin's parts (92909).
		// Without the Assembly it never drops; with it, it is looted and
		// right-clicked there. Recorded: the farm step's goals for the Assembly
		// and its quest, and where Harvesting the Harvesters is handed in.
		const watch = (assembly) => `
			local E, w = Polestar.Engine, stub.world
			local farm, turnedIn = false, false
			local addItem, progress, turnIn = w.addItem, w.progress, w.turnIn
			w.addItem = function(item, ...)
				if item == 255155 and not ${assembly} then return end
				return addItem(item, ...)
			end
			w.progress = function(q, ...)
				if q == 92909 and not farm then
					farm = {}
					if ${assembly} then
						addItem(255155, 1)
						w.accept(92910, {}, "Harvesting the Harvesters")
						stub.advance(0.6)
					end
					for _, v in ipairs(E.GetStepView(E.GetStepIndex()).goals) do
						if v.quest == 92910 or v.item == 255155 then farm[#farm + 1] = v.t .. " " .. tostring(v.optional) end
					end
				end
				return progress(q, ...)
			end
			w.turnIn = function(q, ...)
				if q == 92910 then
					turnedIn = E.GetStepView(E.GetStepIndex()).title
					if not w.log[q] then return end
				end
				return turnIn(q, ...)
			end
			${SIMULATE}
			emit({ farm = farm, turnedIn = turnedIn, done = C_QuestLog.IsQuestFlaggedCompleted(92910) })`;
		for (const assembly of [false, true]) {
			const [out, got] = playGuide(pack, g, { race: 'Human', faction: 'Alliance', cls: 'WARRIOR', script: watch(assembly) });
			const who = assembly ? 'with the Assembly' : 'without the Assembly';
			assert.equal(out.stuck, undefined, `${who}: not stuck: ${JSON.stringify(out.stuck)}`);
			assert.ok(out.done, `${who}: plays to the end`);
			assert.deepEqual(got.farm, ['collect true', 'accept true'], `${who}: the Assembly and its accept are optional goals of the farm step`);
			assert.equal(got.done, assembly, `${who}: Harvesting the Harvesters ${assembly ? 'is' : 'is not'} handed in`);
			assert.equal(got.turnedIn, assembly ? "Saldean's Farm" : false, `${who}: ${assembly ? "handed in at the Saldean's Farm step" : 'nothing is handed in'}`);
		}
	} finally {
		pack.dispose();
	}
});

// Final route review 0.3.6: Report to Gryan Stoutmantle (109) is for every Alliance race, and Farmer Furlbrow gives it on the
// road in; Night Elves and Skyborne passed him without it (Humans have it from Deputy Rainer, Dwarves and Gnomes from Marshal
// Dughan). Every race takes it before its first Sentinel Hill stop and hands it to Gryan there.
test(`${WESTFALL}: Report to Gryan Stoutmantle for every race, Night Elves and Skyborne from Farmer Furlbrow`, { skip }, () => {
	for (const race of ['Human', 'Dwarf', 'Gnome', 'NightElf', 'Skyborne']) {
		const mine = goals(WESTFALL).filter(({ step, goal }) => [step.only, goal.only].every((o) => !o || !o.races || o.races.includes(race)));
		const take = mine.findIndex(({ goal }) => is('accept', 109)(goal));
		const hand = mine.findIndex(({ goal }) => is('turnin', 109)(goal));
		assert.ok(take >= 0 && hand > take, `${race}: takes it, then hands it in`);
		assert.equal(mine[hand].goal.npc, 234, `${race}: to Gryan Stoutmantle`);
		assert.ok(mine.slice(0, hand).every(({ goal }) => goal.npc !== 234), `${race}: on the first Sentinel Hill stop`);
		if (race === 'NightElf' || race === 'Skyborne') assert.equal(mine[take].goal.npc, 237, `${race}: from Farmer Furlbrow`);
	}
});

// Final route review 0.3.6: Stormpike's Delivery (353, 1050 XP) follows Elmore's Task (1097) at Grimand Elmore, whom Humans
// visit before the boat; its ender, Mountaineer Stormpike, is on 03-loch-modan's first Algaz Station stop.
test(`${WESTFALL} / ${LOCH_MODAN}: Stormpike's Delivery taken with Elmore's Task's hand-in, handed to Stormpike at the Algaz Station`, { skip }, () => {
	const west = goals(WESTFALL);
	const elmore = at(west, 'turnin 1097', is('turnin', 1097));
	const take = at(west, 'accept 353', is('accept', 353));
	assert.ok(take > elmore && west[take].s === west[elmore].s, 'taken from Grimand Elmore right after Elmore\'s Task');
	const loch = goals(LOCH_MODAN);
	const hand = at(loch, 'turnin 353', is('turnin', 353));
	assert.ok((loch[hand].step.when || []).some((p) => p.k === 'onquest' && !p.neg), 'only for a character carrying it');
	assert.ok(hand < at(loch, 'turnin 307 (Filthy Paws)', is('turnin', 307)), 'on the first Algaz Station stop');
});

// Alliance 12-30 bracket review 0.3.6: Keeper of the Flame (103, 1150 XP): its Flasks of Oil drop from Westfall's Harvest
// Watchers without the quest; 02-westfall says to keep five, 03-loch-modan's lighthouse stop takes and hands it in at
// once, only for a player carrying them.
test(`${WESTFALL} / ${LOCH_MODAN}: Keeper of the Flame's flasks kept from the Harvest Watchers, handed to Captain Grayson on the lighthouse stop`, { skip }, () => {
	const west = goals(WESTFALL);
	const keep = at(west, 'collect 814', (g) => g.t === 'collect' && g.item === 814);
	assert.ok(west[keep].goal.optional && west[keep].s === west[at(west, 'kill 114', (g) => g.t === 'kill' && g.npc === 114)].s, 'an optional keep-five line on the Harvest Watchers step');
	const loch = goals(LOCH_MODAN);
	const take = at(loch, 'accept 103', is('accept', 103));
	const hand = at(loch, 'turnin 103', is('turnin', 103));
	assert.ok(loch[take].s === loch[hand].s && take < hand, 'taken and handed in on one step');
	assert.ok((loch[hand].step.when || []).some((p) => p.k === 'has' && !p.neg && p.item === 814), 'only for a player carrying the flasks');
	assert.equal(loch[hand].s, loch[at(loch, 'turnin 104', is('turnin', 104))].s + 1, 'right after Old Murk-Eye, at the lighthouse');
});

// Alliance 12-30 bracket review 0.3.6: Thor's free flight takes Humans to Stormwind at about 13 for Osric Strang in Old Town,
// where Ilsa Corbin, Harry Burlguard and Bartleby stand, and back past Cathedral Square, where High Priestess Laurena is.
// Human Warriors' Defensive Stance and Human Priests' Divine Grace are done on that visit, not on a detour at about 16.
test(`${WESTFALL}: Human Warriors' Defensive Stance and Human Priests' Divine Grace on the Thor flight's Stormwind visit`, { skip }, () => {
	const list = goals(WESTFALL);
	const osric = at(list, 'turnin 6281', is('turnin', 6281));
	const dungar = at(list, 'turnin 6261', is('turnin', 6261));
	const stance = at(list, 'turnin 1665', is('turnin', 1665));
	const grace = at(list, 'turnin 94774', is('turnin', 94774));
	assert.ok(osric < stance && stance < at(list, 'accept 399 (Baros)', is('accept', 399)), 'Defensive Stance in Old Town, right after Osric');
	assert.ok(at(list, 'accept 399 (Baros)', is('accept', 399)) < grace && grace < dungar, 'Divine Grace on Cathedral Square, before the gryphon back');
	assert.equal(list.filter(({ goal }) => is('turnin', 1665)(goal)).length, 1, 'no second Defensive Stance stop at the end of the guide');
});

// --- Handful of Oats (Xaden Ryan, #621): the oats were the first step's last
// goal, unplaced, so before Saldean's the arrow searched every Sack of Oats
// in the zone, down to Moonbrook, and the far sacks were empty. They are
// gathered on the return to the Jansen Stead, in its fields, beside the
// turn-in. This compile (tools/lib/dsl) has no players' recorded areas, which
// once grew the farms into one zone-wide search in the shipped pack: forge's
// recorded_areas keeps the author's point at a farm players use (forge-guide
// recorded_areas.rs, #621), and the forge-judge seed of this case checks it.
test(`${WESTFALL}: Xaden Ryan's report (#621): the oats are gathered in the Jansen Stead's fields on the way back, not searched over the zone on the road in`, { skip }, () => {
	const list = goals(WESTFALL);
	const oats = at(list, 'collect 1528', (g) => g.t === 'collect' && g.item === 1528);
	const turnin = at(list, 'turnin 151', is('turnin', 151));
	assert.ok(oats > at(list, 'turnin 109', is('turnin', 109)), 'the oats are not gathered on the road in, before Sentinel Hill');
	assert.ok(oats < turnin && list[oats].step === list[turnin].step, 'the oats are gathered on the turn-in stop, before Verna');
	const { goal } = list[oats];
	assert.ok(located(list[oats]) && !goal.spread, 'the oats have a point and are no zone-wide search');
	assert.ok(yards(goal, list[turnin].goal) < 250, `the oats lead into the Jansen Stead's fields (${goal.x},${goal.y})`);
});

// --- Flow audit (2026-11-07): Westfall's north loop came back to Saldean's
// in its middle for two hand-ins, then went west for the livers and the
// vulture meat, north again, and back to Saldean's a second time; Dwarves,
// Gnomes, Night Elves and Skyborne walked up to the Jansen Stead's well alone
// before the loop. Now one loop from Sentinel Hill: the Molsen Farm fields
// (watchers, okra, livers, snouts, vulture meat), the Defias by Jangolode
// Mine, the north hills and coast, the Jansen Stead (oats and well), then
// every Saldean's hand-in at once on the way back to the hill.
// Route review (2026-11-08, W3; #1415): the loop's two long "kill these as you meet them" lists (twelve goals,
// then five) made players flip between the two steps to find what came next (the most frequent manual moves on
// 0.3.4, 32 people). The same walk is now one target per step in walking order: the Defias fields, Molsen Farm's
// well, the gnoll hills, the murloc coast, Furlbrow's Wardrobe, the Jansen Stead, then the Harvest Watchers.
// Level tidy 0.4.0: the Harvest Watchers (14-15) came right after the well, where players were at 13 (recordings:
// 25th percentile 13.3, 18 people died there); their biggest field lies between the Jansen Stead and Saldean's Farm,
// so they are killed on the walk back south, after the loop's other quests, at about 14 (25th percentile 14.3-14.5).
// The livers, the vulture meat and the bandanas, which drop all over the loop, are worked in the background with a
// finish step before their hand-in.
test(`${WESTFALL}: flow audit: one north loop, one target per step in walking order, Saldean's handed in once on the way back`, { skip }, () => {
	const list = working(goals(WESTFALL));
	const collects = (item) => (g) => g.t === 'collect' && g.item === item;
	const paws = at(list, 'the Gnoll Paws', collects(725));
	for (const [what, item] of [['the Goretusk Snouts', 731], ['the Okra', 732]]) {
		assert.ok(list.filter(({ goal }) => collects(item)(goal)).length === 1, `${what} listed once`);
	}
	assert.ok(at(list, 'the Goretusk Snouts', collects(731)) < paws, 'the Goretusk Snouts before the north hills');
	const watchers = at(list, 'the Harvest Watchers', (g) => g.t === 'kill' && g.quest === 9);
	assert.equal(list[at(list, 'the Okra', collects(732))].step, list[watchers].step, 'the Okra with the Harvest Watchers');
	const order = [
		['the Defias Trappers', (g) => g.t === 'kill' && g.quest === 12 && g.npc === 504],
		["Molsen Farm's well", collects(254547)],
		['the Gnoll Paws', collects(725)],
		['the murloc gills', collects(254548)],
		["Furlbrow's Wardrobe", collects(841)],
		['the oats', collects(1528)],
		['the Harvest Watchers', (g) => g.t === 'kill' && g.quest === 9],
	].map(([what, pred]) => [what, at(list, what, pred)]);
	order.forEach(([what, i], k) => k && assert.ok(i > order[k - 1][1] && list[i].step !== list[order[k - 1][1]].step, `${what} in its own step after ${order[k - 1][0]}`));
	const steps = compiled(WESTFALL).steps;
	const background = new Set(JSON.parse(fs.readFileSync(path.join(ROOT, 'data', 'guide-fixes.json'), 'utf8')).fixes.filter((r) => r.background).map((r) => `${r.at.quest}.${r.at.objective}`));
	for (const [item, quest] of [[723, 22], [729, 38], [829, 153]]) {
		const bg = steps.find((st) => st.along && st.goals.some((g) => g.t === 'collect' && g.item === item));
		assert.ok(bg && bg.goals.every((g) => background.has(`${g.quest}.${g.oi}`)), `item ${item} is worked in the background (data/guide-fixes.json)`);
		const finish = at(list, `the finish step of ${item}`, collects(item));
		assert.ok(finish < at(list, `turnin ${quest}`, is('turnin', quest)), `item ${item} has a finish step before quest ${quest}'s hand-in`);
	}
	const oats = order.at(-2)[1];
	const saldean = list[at(list, 'turnin 9', is('turnin', 9))].step;
	for (const q of [9, 92909, 38, 22]) {
		const i = at(list, `turnin ${q}`, is('turnin', q));
		assert.ok(i > oats, `turnin ${q} after the Jansen Stead`);
		assert.equal(list[i].step, saldean, `turnin ${q} on the one Saldean's stop after the loop`);
	}
	assert.ok(at(list, 'turnin 9', is('turnin', 9)) < at(list, 'turnin 12', is('turnin', 12)), 'then Sentinel Hill');
	assert.equal(list[at(list, 'the Jansen Stead well', collects(254546))].step, list[oats].step, 'the well vial with the oats');
	assert.deepEqual(steps.filter((st) => st.along && !st.goals.every((g) => background.has(`${g.quest}.${g.oi}`))).map((st) => st.title), [], 'no along-the-way lists but the background ones');
});

// --- Battleworn Axe (Tazul | Robin, #340): the axes were collected east of
// Alther's Mill, about ten normal Blackrock spawns that Tazul found too few
// and too slow to respawn. The camps at the south end of Galardell Valley,
// east of Stonewatch Keep, hold some forty, with no elite among them. The
// arrow leads there, on the way south-east from the mill, not to the mill.
// Galardell Valley's own gnolls (Solomon's Law, Fangore) are out of the route
// since #979: 22-26 at about 21 (#977).
test(`${REDRIDGE}: Tazul's report (#340): the Battleworn Axes lead to the Blackrock camps east of Stonewatch Keep, not to Alther's Mill`, { skip }, () => {
	refData();
	const { point } = makeProjector(refData().mapFrames);
	const list = goals(REDRIDGE);
	const axes = at(list, 'Battleworn Axe', (g) => g.t === 'collect' && g.item === 3014);
	const { goal } = list[axes];
	assert.ok(at(list, "Alther's Mill tarantulas", is('kill', 98386)) < axes, "after Alther's Mill, on the way south-east");
	// Galardell Valley comes after the camps, on the way back west (Redridge is entered at about 24.5 since
	// Duskwood's first loop comes first, 2026-11-07); Fangore at the valley's north end on the same loop.
	assert.ok(!list[axes].step.goals.some((g) => g.t === 'level'), 'no top-up at the camps');
	assert.ok(list.every(({ goal: g }, i) => g.quest !== 91 || g.t === 'accept' || i > axes), "Solomon's Law's pendants after the camps");
	assert.ok(list.every(({ goal: g }, i) => g.quest !== 180 || g.t === 'accept' || i > axes), "Fangore's paw after the camps");
	const here = point(goal.map, goal.x, goal.y, goal.f || 'l');
	const near = { normal: 0, elite: 0 };
	for (const id of Object.keys(refData().item(3014).drops.npc)) {
		const npc = refData().npc(Number(id));
		for (const s of refData().spawns('npc', Number(id)).filter((sp) => sp.map === goal.map)) {
			for (const p of s.pts) {
				const q = point(s.map, p[0], p[1], s.f);
				if (Math.hypot(q.wx - here.wx, q.wy - here.wy) < 150) near[npc && npc.rank ? 'elite' : 'normal']++;
			}
		}
	}
	assert.equal(near.elite, 0, 'no elite axe carrier within 150 yd of the arrow');
	assert.ok(near.normal >= 20, `at least 20 normal axe carriers within 150 yd (${near.normal})`);
});

// --- Making Do (Nittepitte, #453): Baros Alexston offers Making Do only to a
// player who handed him Expanding Horizons (97914), taken at the end of
// Darkshore. The project data has no prerequisite for it, and the sources
// disagree, so the accept and its turn-in in Auberdine (on 06-wetlands' boat
// trip to Ashenvale since the 2026-11-07 Alliance 20-30 re-order) are
// optional: a player without Expanding Horizons is not held at Baros or
// Thundris.
test(`Nittepitte's report (#453): Making Do is optional in Redridge and on the way back through Auberdine, and taken only after Expanding Horizons is handed in`, { skip }, () => {
	const list = goals(ASHENVALE);
	const take = at(list, 'accept 97926', is('accept', 97926));
	assert.ok(list[take].goal.optional, 'accept 97926 is optional');
	assert.ok(at(list, 'turnin 97914', is('turnin', 97914)) < take, 'Expanding Horizons is handed in first');
	const auberdine = goals(WETLANDS);
	const back = auberdine[at(auberdine, 'turnin 97926', is('turnin', 97926))];
	assert.ok(back.goal.optional || (back.step.when || []).some((p) => p.k === 'onquest'), 'turnin 97926 holds nobody without it (optional, or only with it in the log: #1415)');
});

// Ioney (#524): "quest not available from Tarrel Rockweaver until completing
// 'Unrequited Love' first, which was in the questlog from earlier." Hollee's
// note (98461, Forever) is handed to Tarrel before he gives In Search of the
// Excavation Team (305); both are optional, so a player without the note is
// not held.

test(`${ASHENVALE}: Ioney's report (#524): Unrequited Love is handed to Tarrel Rockweaver before In Search of the Excavation Team, and taken in Auberdine before the boat`, { skip }, () => {
	// Hollee's note is taken in Auberdine on the Darkshore guide and carried through Ashenvale to
	// Menethil: the list is the chain from Darkshore.
	const list = ['03-darkshore', '03-loch-modan', '03-darkshore-return', '06-ashenvale'].flatMap((g) => goals(`forever/alliance/${g}.guide`));
	const take = at(list, 'accept 98461', is('accept', 98461));
	assert.equal(list[take].step, list[at(list, 'turnin 731 (Hollee in Auberdine)', is('turnin', 731))].step, 'taken from Hollee on the Auberdine stop');
	const give = at(list, 'turnin 98461', is('turnin', 98461));
	const excavation = at(list, 'accept 305', is('accept', 305));
	assert.ok(take < give && give < excavation, 'the note is taken, then handed in, then 305 is taken');
	assert.equal(list[give].step, list[excavation].step, 'the hand-in is in the same Menethil step as 305');
	assert.ok(list[take].goal.optional && list[give].goal.optional, 'both goals are optional');
});

// Ioney (#614): "No Oozes at the two spots in the east". Digging Through the
// Ooze sends the player to the oozes at Ironbeard's Tomb (its quest text), but
// the step searched every ooze spawn of the Wetlands, 21 spots from Menethil
// to the eastern hills, and started in the east. The arrow now takes the tomb.

test(`${ASHENVALE}: Ioney's report (#614): Sida's Bag is searched for at Ironbeard's Tomb, not at the oozes across the Wetlands`, { skip }, () => {
	const list = goals(ASHENVALE);
	// The step that searches for the bag, not the passive `along` list before it.
	const { goal } = list[at(working(list), 'collect 3349', (g) => g.t === 'collect' && g.item === 3349 && g.quest === 470)];
	const tomb = ({ x, y }) => x >= 42 && x <= 49 && y >= 23 && y <= 30;
	assert.ok(goal.map === 1437 && tomb(goal), `the point ${goal.x},${goal.y} is at Ironbeard's Tomb`);
	const arrow = (goal.spots || []).filter((s) => !s.alt);
	assert.ok(arrow.length && arrow.every(tomb), `the arrow picks only the tomb: ${JSON.stringify(goal.spots)}`);
});

// Ioney (#617): "guide wants me to grind till level 28, i just reached level
// 27". The grind to 28 for Pilot Longbeard's quest (1179, from level 28) came
// at the Dragonmaw camp before the hearth to Menethil, so the hand-ins there
// (about 7,200 XP) never counted towards it. It now comes after them, at the
// same camp on the walk east to Dun Algaz.

test(`${WETLANDS}: Ioney's report (#617): Pilot Longbeard (level 28) is taken after the Wetlands hand-ins, a top-up to 28 only between them, and the 20-24 guide has no grind for it`, { skip }, () => {
	const low = goals(ASHENVALE);
	assert.ok(!low.some(({ goal }) => is('accept', 1179)(goal)), 'Pilot Longbeard is not in the 20-24 guide');
	assert.ok(!low.some(({ goal }) => goal.t === 'level' && goal.level >= 25), 'the 20-24 guide has no grind to 25 or more');
	const list = goals(WETLANDS);
	const take = at(list, 'accept 1179', is('accept', 1179));
	const home = at(list, 'turnin 98221', is('turnin', 98221));
	assert.ok(home < take, 'the Wetlands hand-ins count before Pilot Longbeard');
	const grind = list.findIndex(({ goal }) => goal.t === 'level' && goal.level === 28);
	if (grind >= 0) assert.ok(home < grind && grind < take, 'a top-up to 28 comes after the Wetlands hand-ins, before Pilot Longbeard');
});

// Deadshot (#560): "Location for the furbolg camp showing way off of the
// location needed to satisfy the quest." QuestieDB lists four furbolg camps
// for How Big a Threat? (984); the data build kept the first, at 50.9,34.7
// north-east of Auberdine, so the quest's map marker sat 1,200 yards from the
// camp by the bears where the report completed it (39.77,57.07), and the
// guide's bare `complete 984` had no place of its own. The data now keeps the
// camp nearest the giver (data-questie.test.js) and the guide places the goal
// at that camp (39.9,53.9; pfQuest's area trigger 232).

test('forever/alliance/03-darkshore.guide: Deadshot\'s report (#560): How Big a Threat? points at the furbolg camp by the bears, not the one north-east of Auberdine', { skip }, () => {
	const list = goals(DARKSHORE);
	const { goal } = list[at(list, 'complete 984', is('complete', 984))];
	const completed = { map: 1439, x: 39.77, y: 57.07 };
	assert.equal(goal.map, 1439, 'the goal is on Darkshore');
	assert.ok(yards(goal, completed) <= 200, `the arrow at ${goal.x},${goal.y} is by the camp the report completed at, not ${Math.round(yards(goal, completed))} yd off`);
});

// #424 sent players to Kerlonian's Chest for the Horn of Awakening. Since Blizzard's 2026-11-06 hotfix the quest hands
// the horn over on accept and its one objective is the escort (recordings: every objective list uploaded from
// 2026-11-06 23:08 on), so a `collect 13536` would name a line the quest no longer has and send players to the chest.
test(`${ASHENVALE}: The Sleeper Has Awakened gives the Horn of Awakening on accept: no chest step (2026-11-06 hotfix)`, { skip }, () => {
	const list = goals(ASHENVALE);
	assert.ok(!list.some(({ goal }) => goal.item === 13536), 'no goal for the Horn of Awakening');
	const accept = at(list, 'accept 5321 (Kerlonian Evershade)', is('accept', 5321));
	const said = [list[accept].step.tip, list[accept].step.note].flat().filter(Boolean).join(' ');
	assert.ok(/quest: it gives you the Horn of Awakening/.test(said), 'the tip says the quest gives the horn');
	assert.ok(!/chest/i.test(said), 'and no longer sends you to his chest');
});

// Thin-data audit (#1317): Elemental Bracers' Divined Scroll is made where the elementals are; the goal pointed at the
// lake's west edge, ~70 yd from every recorded tick (7 people, middle at 49.6,71.3).
test(`${WETLANDS}: thin-data audit: Elemental Bracers points where players make the Divined Scroll (#1317)`, { skip }, () => {
	const list = goals(WETLANDS);
	const { goal } = list[at(list, 'collect 5455 (1016)', (g) => g.t === 'collect' && g.quest === 1016)];
	assert.equal(goal.map, 1440, 'Ashenvale');
	assert.ok(Math.hypot(goal.x - 49.6, goal.y - 71.3) < 1, `among the elementals (${goal.x},${goal.y})`);
});

// Fyurie (#920): The Sleeper Has Awakened (5321) was taken from Kerlonian
// Evershade on the Darkshore visit at about 19, but his escort waits for the
// Ashenvale guide at about 26, so players carried a timed escort for hours.
// The Horn of Awakening lasts 25 minutes (item 13536, duration 1500 s). The
// quest is taken from Kerlonian in the Ashenvale guide's Grove step, right
// before the escort, and no step waits for it in the log first.
test(`${ASHENVALE}: Fyurie's report (#920): The Sleeper Has Awakened is taken from Kerlonian right before the escort, not on the Darkshore visit`, { skip }, () => {
	assert.ok(!goals(DARKSHORE).some(({ goal }) => goal.quest === 5321), 'the Darkshore visit leaves Kerlonian alone');
	const list = goals(ASHENVALE);
	const accept = at(list, 'accept 5321 (Kerlonian Evershade)', is('accept', 5321));
	const turnin = at(list, 'turnin 5321', is('turnin', 5321));
	assert.ok(accept < turnin, 'accept at the Grove, then the hand-in at Maestra\'s Post');
	assert.ok(!(list[accept].step.when || []).some((p) => p.k === 'onquest' && [].concat(p.q).includes(5321)), 'the step does not wait for 5321 in the quest log');
	assert.equal(list[accept].goal.npc, 11218, 'from Kerlonian Evershade');
});

// A player's report (2026-11-16): right after taking The Sleeper Has Awakened (5321), the guide window sent them
// on to Maestra's Post and the hand-in, with the escort not done. The Kerlonian step held the accept, a goto at his
// spot and a note, so it was done on the accept; the escort was a goal nowhere. The step now waits for the escort
// (`complete 5321`), which leads to his bag on the road south, and the hand-in comes after it.
test(`${ASHENVALE}: Kerlonian's step waits for the escort before the hand-in at Maestra's Post`, { skip }, () => {
	const list = goals(ASHENVALE);
	const accept = at(list, 'accept 5321 (Kerlonian Evershade)', is('accept', 5321));
	const escort = at(list, 'complete 5321', is('complete', 5321));
	const turnin = at(list, 'turnin 5321', is('turnin', 5321));
	assert.ok(accept < escort && escort < turnin, 'accept, the escort, then the hand-in');
	assert.equal(list[escort].s, list[accept].s, "in Kerlonian's own step");
	const { goal } = list[escort];
	assert.equal(goal.escort, true, 'marked as an escort');
	assert.ok(goal.map === 1439 && Math.hypot(goal.x - 41.6, goal.y - 89.9) < 1, `leads to his bag in southern Darkshore (${goal.map} ${goal.x},${goal.y})`);
});

// Alliance 12-30 bracket review 0.3.6: Human Paladins do Henze Faulk on 03-loch-modan's walk east through Elwynn (the same
// road 04 walks at about 23) and learn Redemption at the Cathedral on 03's last Stormwind stop, about five levels earlier;
// 04's and 05's steps stay only for a Paladin still carrying the quests.
test(`${LOCH_MODAN}: Human Paladins' Tome of Divinity on the Elwynn walk, Redemption on the last Stormwind stop`, { skip }, () => {
	const list = goals(LOCH_MODAN);
	const carried = (e, qs) => (e.step.when || []).some((p) => p.k === 'onquest' && !p.neg && qs.every((q) => [].concat(p.q).includes(q)));
	const henze = at(list, 'use 6866 quest 1786.1', (g) => g.t === 'use' && g.quest === 1786);
	assert.ok(henze > at(list, 'goto the road east to Redridge', (g) => g.t === 'goto' && Math.abs(g.x - 65.8) < 0.1 && Math.abs(g.y - 74.0) < 0.1) && henze < at(list, 'accept 244 (Three Corners)', is('accept', 244)), 'on the walk east through Elwynn, before Three Corners');
	assert.ok(carried(list[henze], [1786, 1787]) && list[at(list, 'collect 6846', (g) => g.t === 'collect' && g.item === 6846)].s === list[henze].s, 'the script on the same step, shown while 1786 or 1787 is carried');
	const gazin = at(list, 'turnin 1788', is('turnin', 1788));
	assert.ok(carried(list[gazin], [1787, 1788]) && gazin > at(list, 'turnin 97914 (Baros)', is('turnin', 97914)), 'Redemption on the last Stormwind stop, after Baros on Cathedral Square');
	const red = goals(REDRIDGE);
	assert.ok(carried(red[at(red, 'use 6866', (g) => g.t === 'use' && g.quest === 1786)], [1786, 1787]), '04\'s Henze step only for a Paladin still carrying it');
	const dusk = goals('forever/alliance/05-duskwood.guide');
	assert.ok(carried(dusk[at(dusk, 'turnin 1788', is('turnin', 1788))], [1787, 1788]), '05\'s Cathedral step only for a Paladin still carrying it');
});

// --- TP1186's route report (#727). The Westfall and Darkshore seeds carry
// the order into the built routes: Sentinel Hill's tower before Thor's
// flight path and the inn at its foot, and no boat goto in Darkshore before
// the Druids' Cat Form trip (the route's own boat step follows it).
test("TP1186's report (#727): Sentinel Hill's tower before its flight path and inn; no boat to Stormwind before Darkshore's Druid trip", { skip }, () => {
	const westfall = goals(WESTFALL);
	const danuvin = at(westfall, 'accept 102', is('accept', 102));
	for (const t of ['getfp', 'sethome']) {
		assert.ok(at(westfall, `${t} Sentinel Hill`, (g) => g.t === t && g.location === 'Sentinel Hill') > danuvin, `${t} after the tower quests`);
	}
	const darkshore = darkshoreBoth();
	const cat = at(darkshore, 'turnin 98397', is('turnin', 98397));
	assert.ok(!darkshore.slice(0, cat).some(({ goal }) => goal.t === 'goto' && /Boat to Stormwind/.test(goal.text)), 'no boat to Stormwind before Cat Form');
});

test("Fitz's report: Darkshore's Fine Crab Chunks are a goal at Cliffspring Falls, by the crabs that drop them, not a list along ten stops", { skip }, () => {
	// Only Reef Crawlers and Encrusted Tide Crawlers drop the chunks, on the north coast and the far
	// south. Listed along the way, the chunks were open for ten stops of which three had crabs; the
	// stop with most of them near is Cliffspring Falls, where they are collected, the note saying where.
	const steps = compiled('forever/alliance/03-darkshore.guide').steps;
	assert.ok(!steps.some((s) => s.along && s.goals.some(is('collect', 1138))), 'no along step lists the chunks');
	const accept = steps.findIndex((s) => s.goals.some(is('accept', 1138)));
	const falls = steps.findIndex((s) => s.title === 'Cliffspring Falls');
	assert.ok(accept >= 0 && falls > accept, 'Fruit of the Sea is taken before Cliffspring Falls');
	const goal = steps[falls].goals.find(is('collect', 1138));
	assert.ok(goal && goal.item === 12237, 'Cliffspring Falls collects the Fine Crab Chunks');
	assert.match(goal.note || '', /Reef Crawler/, 'its note names the crabs and where they are');
	const { point } = makeProjector(refData().mapFrames);
	const crabs = Object.keys(refData().items[12237].drops.npc).flatMap((npc) => {
		const sp = refData().npcs[npc].spawns[1439];
		return sp ? sp.pts.map(([x, y]) => point(1439, x, y, sp.f)) : [];
	});
	const here = steps[falls].goals.filter((g) => located({ goal: g }) && g !== goal);
	const nearest = Math.min(...here.flatMap((g) => crabs.map((c) => dist(point(g.map, g.x, g.y, g.f || 'l'), c))));
	assert.ok(nearest <= 200, `Cliffspring Falls is ${Math.round(nearest)} yd from the nearest crab that drops the chunks`);
});

// --- Flow audit (2026-11-07, Duskwood; geezki on Discord: "back and forth with one quest"): the guide
// walked back north into Darkshire from the Tranquil Gardens Cemetery for The Night Watch alone before
// the road west, carried Look to the Stars ready past Viktori until the Duskwood return, sent the
// player back west from the Yorgen Farmstead for the Totem's spider venom, and had three along lists.
// Now: The Night Watch is handed in on the big visit after the first loop (its Horrors with the Rot
// Blossoms, its Fiends on the cemetery walk to Jitters, handed in on the return where 58 starts), Look to
// the Stars is handed in on the first visit and 175 at Blind Mary on the Embalmer chain's visit, the
// venom drops from the Hushed Bank's spiders, and the level-27 worgen wait for the return. Since the
// Alliance 20-30 re-order (2026-11-07) the first loop opens 04-redridge-mountains and the second
// loop opens 05-duskwood.
test(`05-duskwood: flow audit: no walk back into Darkshire for The Night Watch, Look to the Stars on the first visit, no along lists`, { skip }, () => {
	const FIRST = 'forever/alliance/04-redridge-mountains.guide';
	const DUSK = 'forever/alliance/05-duskwood.guide';
	const one = goals(FIRST);
	const list = goals(DUSK);
	const stepIn = (l, what, t, q) => l[at(l, what, is(t, q))].s;
	const stepOf = (what, t, q) => stepIn(list, what, t, q);
	const first = stepIn(one, 'accept 101', 'accept', 101);
	// (#2243: Viktori's goals are steps of their own right after the main Darkshire step, gated on the Bronze Tube.)
	const viktori = stepIn(one, 'turnin 174', 'turnin', 174);
	assert.equal(viktori, first + 1, 'Look to the Stars handed in on the first Darkshire visit, right after its main step');
	assert.equal(stepIn(one, 'accept 175', 'accept', 175), viktori + 1, 'and its second part taken there');
	assert.equal(stepOf('turnin 175', 'turnin', 175), stepOf('turnin 149', 'turnin', 149), '175 handed to Blind Mary with Ghost Hair Thread');
	const big = stepIn(one, 'turnin 101', 'turnin', 101);
	assert.equal(stepIn(one, 'turnin 56', 'turnin', 56), big - 1, 'The Night Watch handed in on the Darkshire visit with the Totem of Infliction (the town hall, then Madame Eva)');
	assert.equal(stepIn(one, 'accept 57', 'accept', 57), big - 1, 'and 57 taken there');
	const venom = one.find(({ goal }) => goal.t === 'collect' && goal.item === 1130);
	const spiders = one.find(({ goal }) => goal.t === 'kill' && goal.quest === 245);
	assert.equal(venom.s, spiders.s, 'the spider venom with the Pygmy Venom Web Spiders');
	const horrors = list.filter(({ goal }) => goal.t === 'kill' && goal.quest === 57 && goal.npc === 202);
	assert.ok(horrors.length >= 1 && horrors[0].s === list.find(({ goal }) => goal.t === 'collect' && goal.item === 1598).s, "57's Horrors with the Rot Blossoms");
	const fiends = list.find(({ goal }) => goal.t === 'kill' && goal.quest === 57 && goal.npc === 531);
	assert.ok(fiends.s > stepOf('turnin 133', 'turnin', 133) && fiends.s < stepOf('turnin 453', 'turnin', 453), "57's Fiends between Abercrombie's effigy and Jitters");
	assert.ok(![...one, ...list].some(({ goal }) => goal.quest === 173 && goal.t === 'kill'), 'the level-27 Shadow Weavers wait for the Duskwood return');
	for (const g of [FIRST, DUSK]) assert.deepEqual(compiled(g).steps.filter((st) => st.along).map((st) => st.title), [], `${g}: no along-the-way lists`);
	const ret = goals('forever/alliance/07-thousand-needles.guide');
	assert.ok(at(ret, 'turnin 57 on the return', is('turnin', 57)) < at(ret, 'accept 58', is('accept', 58)), '57 handed in on the return before 58');
	assert.ok(!ret.some(({ goal }) => goal.quest === 174 || goal.quest === 175), 'the return no longer carries 174/175');
});

// Darkshore: Fruit of the Sea's crab chunks come with Cliffspring Falls; the walk passed Gubber Blump with them
// on the next Auberdine visit and handed them in a loop later.
test(`${DARKSHORE}: flow re-order: Fruit of the Sea handed in on the Auberdine visit after Cliffspring Falls`, { skip }, () => {
	const list = goals(DARKSHORE);
	const idx = (t, q) => at(list, `${t} ${q}`, is(t, q));
	assert.equal(list[idx('turnin', 1138)].s, list[idx('turnin', 4762)].s, 'with the Cliffspring River sample');
	assert.ok(idx('turnin', 1138) < idx('turnin', 1001), 'before the north loop');
});

// --- A player's Discord report (PR #1052): "on a 20-24 guide, almost at the end, still 3 levels to
// go". Redridge's quests ended at about 21.6 while Duskwood's start at 24. Since the Alliance 20-30
// re-order (2026-11-07) Ashenvale, Stonetalon and the first Wetlands visit come first (20-23),
// then Duskwood and Redridge together, so Redridge comes at 23+: Duskwood's first loop,
// Redridge with its elites and Fangore on the same loop through the Blackrock camps, Galardell Valley and
// Stonewatch Keep (04-redridge-mountains), then Duskwood's second loop (05-duskwood). Redridge is
// entered at about 24.5, so Galardell Valley, Fangore and Bellygrub need no written top-up.
test('Redridge level gap (PR #1052): Duskwood\'s first loop comes before Redridge\'s first pass, and Galardell Valley and Bellygrub need no top-up', { skip }, () => {
	const list = goals('forever/alliance/04-redridge-mountains.guide');
	const loop = at(list, 'turnin 148 (Darkshire, end of the first loop)', is('turnin', 148));
	assert.ok(loop < at(list, 'accept 128 (Guard Howe, by the Lakeshire gryphons)', is('accept', 128)), 'Duskwood\'s first loop before Redridge\'s first pass');
	const worgen = at(list, 'accept 173', is('accept', 173));
	assert.ok(list.slice(0, worgen).some(({ goal }) => goal.t === 'level' && goal.level >= 23), 'a level 23 gate comes before Worgen in the Woods');
	assert.ok(!list.some(({ goal }, i) => goal.t === 'level' && i > loop), 'no written top-up on Redridge\'s first pass');
	for (const q of [91, 94, 248, 34, 98387]) assert.ok(list.some(({ goal }) => goal.t === 'turnin' && goal.quest === q), `${q} is handed in`);
});

test('Redridge level gap (PR #1052): Redridge\'s Gath\'Ilzogg, Gar\'im and Fangore on its one loop, Duskwood\'s second loop after it', { skip }, () => {
	const list = goals('forever/alliance/04-redridge-mountains.guide');
	const camps = at(list, 'Battleworn Axe', (g) => g.t === 'collect' && g.item === 3014);
	const back = at(list, 'turnin 20 (Back to Lakeshire)', is('turnin', 20));
	for (const q of [169, 95999, 180]) {
		assert.ok(at(list, `accept ${q}`, is('accept', q)) < camps, `${q} is taken in Lakeshire before the camps`);
		// #1415: the elite posters' hand-ins are steps of their own behind the group choice, right before that stop.
		const ts = list[at(list, `turnin ${q}`, is('turnin', q))].s;
		assert.ok(ts <= list[back].s && list[back].s - ts <= 2, `${q} is handed in on the stop back in Lakeshire (${ts} vs ${list[back].s})`);
	}
	const dusk = goals('forever/alliance/05-duskwood.guide');
	assert.ok(!dusk.some(({ goal }) => goal.quest === 101 || goal.quest === 174), 'the first loop is in 04-redridge-mountains');
	assert.ok(!dusk.some(({ goal }) => [19, 115, 169, 95999, 180].includes(goal.quest)), 'no second Redridge pass (19 and 115 are left out)');
});

// --- Flow audit (2026-11-07, Redridge): after Lakeshire's accepts at the west end of town the guide swam
// east for the Sunken Chest, walked back west past the town to Three Corners and the gnoll hills, then
// went Martie (west end) -> Foreman Oslow (bridge) -> south over the bridge to Deputy Feldon -> north to
// the Brutes. Now: the gnoll hills, Feldon, the chest on the way back, Oslow, Martie, and the Brutes
// just north of her garden; no along list for the Spotted Sunfish.
// Since the Alliance 12-20 re-order (2026-11-07) the gnoll hills, Feldon, the chest, Oslow and Martie are Redridge's
// first visit at 19-20 (03-loch-modan); the murlocs, Baren, Bellygrub and Martie's second errand stay at 24.
test(`${LOCH_MODAN}: flow audit: the Sunken Chest on the way from Feldon, Lakeshire crossed east to west once, no along lists`, { skip }, () => {
	const list = goals(LOCH_MODAN);
	const idx = (what, pred) => at(list, what, pred);
	const feldon = idx('turnin 246', is('turnin', 246));
	const chest = idx('the Sunken Chest', (g) => g.t === 'collect' && g.item === 1309);
	const oslow = idx('turnin 125', is('turnin', 125));
	const martie = idx('turnin 130', is('turnin', 130));
	assert.ok(feldon < chest && chest < oslow && oslow < martie, 'Feldon, the chest, Oslow, then Martie');
	assert.equal(list[oslow].s, list[martie].s, 'Oslow and Martie on one pass through town');
	assert.ok(idx('the gnolls', is('kill', 246)) < feldon, 'the gnoll hills before Feldon');
	const red = goals(REDRIDGE);
	const fins = red.find(({ goal }) => goal.t === 'collect' && goal.item === 1468);
	const baren = at(red, 'turnin 150', is('turnin', 150));
	assert.ok(fins.s < red[baren].s && baren < at(red, 'turnin 34 (Martie)', is('turnin', 34)), 'the murlocs, Baren, then Martie');
	const sun = at(list, 'the Spotted Sunfish', (g) => g.t === 'collect' && g.item === 1467);
	assert.equal(list[sun].s, list[chest].s, 'Selling Fish\'s sunfish with the Sunken Chest at 20');
	assert.equal(list[at(list, 'turnin 127', is('turnin', 127))].s, list[oslow].s, 'Selling Fish handed to Baren on the pass through town');
	for (const g of [LOCH_MODAN, REDRIDGE]) assert.deepEqual(compiled(g).steps.filter((st) => st.along).map((st) => st.title), [], `${g}: no along-the-way lists`);
});

// Westfall's Stormwind stop: Fishin' Time's Nightcrawlers are bought with the Shiny Bauble from Catherine Leland in one
// stop, after Woo Ping; they were bought in a stop of their own before Woo Ping and the walk came back for the bauble.
test(`${WESTFALL}: flow re-order: the Nightcrawlers bought once, with the Shiny Bauble`, { skip }, () => {
	const list = goals(WESTFALL);
	const crawlers = list.filter(({ goal }) => goal.t === 'buy' && goal.item === 6530);
	assert.equal(crawlers.length, 1, 'one Nightcrawlers purchase');
	const bauble = at(list, 'buy 6529', (g) => g.t === 'buy' && g.item === 6529);
	assert.equal(crawlers[0].s, list[bauble].s, 'in the Shiny Bauble\'s stop');
	assert.ok(list.findLastIndex(({ step }) => step.title === 'Woo Ping') < bauble, 'after Woo Ping');
});

// Final route review, Alliance 1-20 (2026-11-07): Auberdine's first visit starts at the pier the boat lands on
// (Cerellean), goes up to Hollee and Thundris at the north end and down the main street to the inn, Gwennyth and
// Gubber, by the beach the next step starts on; it crossed to Thundris first and came back from the pier to Hollee.
// Since the Alliance 12-20 re-order (2026-11-07) Hollee's prospector (729) is taken on the return
// (03-darkshore-return), where its work is.
test(`${DARKSHORE}: flow re-order: Auberdine's first visit from the pier, Thundris at the north end, Gubber last`, { skip }, () => {
	const list = goals(DARKSHORE);
	const idx = (t, q) => at(list, `${t} ${q}`, is(t, q));
	const visit = list[idx('accept', 963)].s;
	for (const q of [954, 983, 3524, 1138]) assert.equal(list[idx('accept', q)].s, visit, `accept ${q} on the same visit`);
	assert.ok(idx('accept', 963) < idx('accept', 954), 'Cerellean, then Thundris');
	assert.ok(!list.some(({ goal }) => is('accept', 729)(goal)), 'Hollee\'s prospector is taken on the return');
	assert.ok(idx('accept', 954) < idx('accept', 984) && idx('accept', 984) < idx('accept', 983), 'the north end, then down the main street to the inn');
	assert.ok(idx('accept', 3524) < idx('accept', 1138), 'Gubber Blump last, by the beach');
	assert.ok(list.every(({ goal, s }, i) => s !== visit || goal.t !== 'accept' || i <= idx('accept', 1141)), 'nothing taken after Gubber');
});

// The Auberdine visit after Bashal'Aran: Terenthis by the road in, Thundris and the moonwell, Glynda, Gwennyth, and
// Gubber on the pier on the way out to Mist's Edge; it went Gwennyth, Glynda, up to Thundris, back to the moonwell.
test(`${DARKSHORE}: flow re-order: the Auberdine visit after Bashal'Aran in walking order, Gubber last`, { skip }, () => {
	const list = goals(DARKSHORE);
	const idx = (t, q) => at(list, `${t} ${q}`, is(t, q));
	const order = [['turnin', 985], ['turnin', 4762], ['turnin', 4813], ['turnin', 4727], ['turnin', 1138]].map(([t, q]) => idx(t, q));
	for (const i of order) assert.equal(list[i].s, list[order[0]].s, `${list[i].goal.t} ${list[i].goal.quest} on the same visit`);
	order.slice(1).forEach((i, k) => assert.ok(order[k] < i, `${list[order[k]].goal.quest} before ${list[i].goal.quest}`));
	const bowl = at(list, 'the Filled Cleansing Bowl', (g) => g.t === 'collect' && g.item === 12347);
	assert.ok(idx('turnin', 4762) < bowl && bowl < idx('turnin', 4813), 'the moonwell between Thundris and Glynda');
});

// The Beached Sea Creatures at 32.7,80.8 and 36.0,70.9 are taken on the fourth loop, with the remains past Remtravel's
// Excavation and on the walk north from the Grove; the second loop walked down the coast to them and back north.
test(`${DARKSHORE}: flow re-order: Beached Sea Creatures 4730 and 4728 on the fourth loop, no second-loop walk down the coast`, { skip }, () => {
	const list = darkshoreBoth();
	const idx = (t, q) => at(list, `${t} ${q}`, is(t, q));
	assert.equal(list[idx('accept', 4730)].s, list[idx('accept', 4731)].s, '4730 with the remains past Remtravel\'s Excavation');
	assert.ok(idx('accept', 4730) < at(list, 'Murkdeep', (g) => g.t === 'kill' && g.quest === 4740), 'on the way to Murkdeep\'s camp');
	assert.ok(idx('accept', 98013) < idx('accept', 4728) && idx('accept', 4728) < idx('turnin', 4731), '4728 on the walk north from the Grove');
	assert.ok(idx('turnin', 1138) < idx('accept', 4730) && idx('turnin', 1138) < idx('accept', 4728), 'neither before the third loop');
	assert.equal(list[idx('turnin', 4730)].s, list[idx('accept', 87760)].s, 'handed in on the Holy Diver visit');
	assert.equal(list[idx('turnin', 4728)].s, list[idx('accept', 87760)].s, 'handed in on the Holy Diver visit');
});

test('Alliance 12-20 zone order: Darkshore, the Eastern Kingdoms loop, Darkshore again, then Ashenvale', { skip }, () => {
	const next = (g) => String(compiled(g).next).replace(/\.guide$/, '');
	assert.equal(next('forever/alliance/02-westfall.guide'), 'forever/alliance/03-darkshore');
	assert.equal(next('forever/alliance/03-darkshore.guide'), 'forever/alliance/03-loch-modan');
	assert.equal(next('forever/alliance/03-loch-modan.guide'), 'forever/alliance/03-darkshore-return');
	assert.equal(next('forever/alliance/03-darkshore-return.guide'), 'forever/alliance/06-ashenvale');
});

test('forever/alliance/03-loch-modan.guide: Alliance 12-20 zone order: Loch Modan, Redridge and the Defias chain are taken and handed in on the loop', { skip }, () => {
	const [guide, quests] = A1220_LOCH;
	const list = goals(guide);
	for (const q of quests) {
		assert.ok(list.some(({ goal }) => is('accept', q)(goal) && !goal.optional), `accept ${q}`);
		assert.ok(list.some(({ goal }) => is('turnin', q)(goal) && !goal.optional), `turnin ${q}`);
	}
	assert.ok(list.some(({ goal }) => is('turnin', 65)(goal)), 'The Defias Brotherhood (65, from Westfall) goes to Wiley the Black here');
	for (const race of ['Human', 'NightElf', 'Skyborne']) assert.ok(list.filter(forRaceOf(race)).some(({ goal }) => is('turnin', 307)(goal)), `${race}: Filthy Paws at the Algaz Station`);
	for (const race of ['Dwarf', 'Gnome']) assert.ok(!list.filter(forRaceOf(race)).some(({ goal }) => is('accept', 307)(goal)), `${race}: Filthy Paws was done in Dun Morogh`);
});

test('forever/alliance/04-redridge-mountains.guide: Alliance 12-20 zone order: Redridge\'s 15-20 quests are no longer taken at 24; Murloc Poachers comes with you from the first visit, the Blackrock quests are taken on this visit (Alliance 20-30 audit)', { skip }, () => {
	const list = goals('forever/alliance/04-redridge-mountains.guide');
	for (const q of [244, 246, 98407, 125, 89, 129, 130, 131, 92, 65, 127]) assert.ok(!list.some(({ goal }) => goal.quest === q && (goal.t === 'accept' || goal.t === 'turnin')), `${q} is not in 04-redridge-mountains`);
	const first = goals(LOCH_MODAN);
	// Murloc Poachers is taken from Baren at 20: its murlocs come before this visit's Lakeshire stop.
	assert.ok(first.some(({ goal }) => is('accept', 150)(goal)), 'accept 150 at 20');
	assert.ok(!list.some(({ goal }) => is('accept', 150)(goal)) && list.some(({ goal }) => is('turnin', 150)(goal)), '150 handed in at 24');
	// Alliance 20-30 audit (0.4.0, #2025): Marshal Marris's Blackrock quests and Alther's Mill are taken on this visit's
	// Lakeshire stop, on the way to their camps, instead of being carried for four hours from the first visit.
	const lakeshire = list.find(({ goal }) => is('turnin', 150)(goal)).s;
	for (const q of [20, 98387, 98386]) {
		assert.ok(!first.some(({ goal }) => is('accept', q)(goal)), `${q} is not taken at 20`);
		const acc = list.find(({ goal }) => is('accept', q)(goal));
		assert.ok(acc && acc.s === lakeshire, `accept ${q} on the Lakeshire stop`);
		assert.ok(list.findIndex(({ goal }) => is('accept', q)(goal)) < list.findIndex(({ goal }) => is('turnin', q)(goal)), `${q} handed in after`);
	}
	const fins = list.find(({ goal }) => goal.t === 'collect' && goal.item === 1468);
	const baren = list.find(({ goal }) => is('turnin', 150)(goal));
	const howe = list.find(({ goal }) => is('accept', 128)(goal));
	assert.ok(howe.s < fins.s && fins.s < baren.s && baren.s === list.find(({ goal }) => is('accept', 91)(goal)).s, 'the murlocs on the way in, Baren on the first Lakeshire stop');
});

test('forever/alliance/02-westfall.guide: Alliance 12-20 zone order: Dwarves and Gnomes do east Elwynn on the way to Westfall, the later starts don\'t', { skip }, () => {
	const list = goals('forever/alliance/02-westfall.guide');
	for (const race of ['Dwarf', 'Gnome']) {
		const mine = list.filter(forRaceOf(race));
		for (const q of A1220_ELWYNN.filter((q) => q !== 91723 && q !== 91732)) assert.ok(mine.some(({ goal }) => is('turnin', q)(goal)), `${race}: turnin ${q}`);
		// The Jasperlode Mine (76) needs The Fargodeep Mine (62), which they never take (players' recordings): not asked for.
		// 0.4.0 audit: Delicate Instruments and Good Steel (91723, 91732: level 7-8 at about 14.5) and their mine are left out.
		for (const q of [76, 239, 11, 91723, 91732]) assert.ok(!mine.some(({ goal }) => goal.quest === q), `${race}: no ${q}`);
		assert.ok(!mine.some(({ goal }) => goal.t === 'goto' && goal.map === 1429 && Math.abs(goal.x - 61.6) < 0.5 && Math.abs(goal.y - 54.1) < 0.5), `${race}: no trip into the Jasperlode Mine`);
		const goldshire = mine.filter(({ goal }) => goal.npc === 240).map(({ s }) => s);
		assert.equal(new Set(goldshire).size, 2, `${race}: Marshal Dughan on the way in and on the way west, nowhere else`);
		const elwynnEnd = mine.findIndex(({ goal }) => is('accept', 109)(goal));
		const jansen = mine.findIndex(({ goal }) => is('accept', 36)(goal));
		assert.ok(elwynnEnd >= 0 && elwynnEnd < jansen, `${race}: east Elwynn before the Jansen Stead`);
	}
	for (const race of ['Human', 'NightElf', 'Skyborne']) {
		const mine = list.filter(forRaceOf(race));
		for (const q of A1220_ELWYNN.filter((q) => q !== 35 && q !== 40)) assert.ok(!mine.some(({ goal }) => goal.quest === q), `${race}: no ${q}`);
	}
});

test('forever/alliance/03-darkshore-return.guide: Alliance 12-20 zone order: the southern loops\' quests are taken on the return, not carried through the Eastern Kingdoms', { skip }, () => {
	const first = goals('forever/alliance/03-darkshore.guide');
	const back = goals('forever/alliance/03-darkshore-return.guide');
	for (const q of [986, 729, 4740]) {
		assert.ok(!first.some(({ goal }) => is('accept', q)(goal)), `${q} is not taken on the first visit`);
		assert.ok(back.some(({ goal }) => is('accept', q)(goal)) && back.some(({ goal }) => is('turnin', q)(goal)), `${q} is taken and handed in on the return`);
	}
	// Onu is offered with Cave Mushrooms' hand-in: taken from Barithras there, handed to Onu on the return.
	const mush = first.find(({ goal }) => is('turnin', 947)(goal));
	assert.ok(mush && first.some(({ goal, s }) => is('accept', 948)(goal) && s === mush.s) && back.some(({ goal }) => is('turnin', 948)(goal)), 'Onu taken with Cave Mushrooms');
	// The Tower of Althalaxx stands by Buzzbox 323 on the north loop: done there, Delgren's letter carried to Ashenvale.
	const buzz = at(first, 'turnin 1002 (Buzzbox 323)', is('turnin', 1002));
	const tower = at(first, 'turnin 966', is('turnin', 966));
	assert.ok(buzz < tower && tower < at(first, 'turnin 4763', is('turnin', 4763)), 'the tower between Buzzbox 323 and the northern Blackwood camp');
	assert.ok(!back.some(({ goal }) => goal.quest === 965 || goal.quest === 966), 'the return does not walk to the tower');
});

test('Alliance 12-20 zone order: every quest the Eastern Kingdoms loop adds has its include record', () => {
	const inc = JSON.parse(fs.readFileSync(path.join(ROOT, 'data', 'route-fixes.json'), 'utf8')).overrides.include;
	for (const q of [127, 250, 199, 86614, 436, 297, 298, 301, 86613, 86758, 257, 258, 86585, 118, 119, 122, 124, 120, 121, 3741, 132, 135, 141, 142, 155, 104]) {
		assert.ok(inc.some((e) => e.q === q && /Alliance 12-20 re-order/.test(e.reason)), `include ${q} is recorded`);
	}
});

test('Alliance 12-20 zone order: no step waits on a vendor visit once its real goals are done', { skip }, () => {
	const offenders = [];
	for (const guide of ['02-westfall', '03-darkshore', '03-loch-modan', '03-darkshore-return', '04-redridge-mountains'].map((g) => `forever/alliance/${g}.guide`)) {
		for (const st of compiled(guide).steps) if (forAllOnly(st.only) && waitsOnVendor(st)) offenders.push(`${guide}: ${st.title}`);
	}
	assert.deepEqual(offenders, [], 'steps holding on a vendor visit');
});

// Flow (Alliance 12-20, 2026-11-07): players reach the 22-24 Wetlands visit about two levels higher since the
// Eastern Kingdoms loop, so Rethiel's Fire Taboo (level 23) is taken when Tramping Paws is handed in, its flint
// from the Fenrunners on the walk to Ironbeard's Tomb, and handed in on the first Rethiel stop at 27-29 with
// Blisters on the Land: no second Rethiel stop for it.
test('Alliance 12-20: Fire Taboo is taken from Rethiel at 22-24, its flint on the way to the tomb, handed in on the first Rethiel stop at 27-29', { skip }, () => {
	const low = goals(ASHENVALE);
	const paws = low.find(({ goal }) => is('turnin', 276)(goal));
	assert.ok(low.some(({ goal, s }) => is('accept', 277)(goal) && s === paws.s), 'taken with Tramping Paws');
	const flint = low.find(({ goal }) => goal.t === 'collect' && goal.item === 2611);
	const bag = low.find(({ goal }) => goal.t === 'collect' && goal.item === 3349);
	assert.ok(flint && bag && flint.s === bag.s, 'the flint on the walk to Ironbeard\'s Tomb');
	const wet = goals(WETLANDS);
	const hand = wet.find(({ goal }) => is('turnin', 277)(goal));
	assert.ok(hand && wet.some(({ goal, s }) => is('accept', 275)(goal) && s === hand.s), 'handed in with Blisters on the Land taken');
	assert.ok(!wet.some(({ goal }) => (goal.t === 'collect' && goal.item === 2611) || is('accept', 277)(goal)), 'not taken or worked again at 27-29');
	assert.equal(wet.filter(({ step, goal }) => goal.npc === 1244 && !dungeonOnly(step)).map(({ s }) => s).filter((v, i, a) => a.indexOf(v) === i).length, 2, 'Rethiel on two stops of the solo route (Fire Taboo and Blisters in, Blisters out)');
});

// Flow (2026-11-08, Alliance 12-20): A Watchful Eye and the Rogues' Mathias and the Defias (both from level 20) are
// not taken on the Eastern Kingdoms loop: players pass Theocritus and SI:7 at 19-20 there, and a level 20 step on
// those stops cost the level model a grind (#1219's round on 60c8c38dc). They stay at 24 and on 06-ashenvale.
test('forever/alliance/03-loch-modan.guide: A Watchful Eye and Mathias and the Defias wait for the 24 visit and Ashenvale\'s Stormwind stop', { skip }, () => {
	const list = goals(LOCH_MODAN);
	for (const q of [94, 2360]) assert.ok(!list.some(({ goal }) => is('accept', q)(goal)), `${q} is not taken on the loop`);
	assert.ok(goals(REDRIDGE).some(({ goal }) => is('accept', 94)(goal)), 'A Watchful Eye at 24');
	assert.ok(goals('forever/alliance/06-ashenvale.guide').some(({ goal }) => is('accept', 2360)(goal)), 'Mathias and the Defias on 06-ashenvale');
});

// #1257 (Dwarf Shaman 24, Duskwood): the arrow sought the Pygmy Venom Web Spiders by Sven's camp in the
// north, where few spawn among the wolves and bigger spiders, and the tip put them east of the cemetery.
// Half their western spawns lie on the Hushed Bank west of Raven Hill: the arrow goes there (places
// record) and the tip says so (guide-fixes record).
test('#1257: Duskwood\'s Pygmy Venom Web Spiders are sought on the Hushed Bank west of Raven Hill', { skip }, () => {
	const guide = 'forever/alliance/04-redridge-mountains.guide';
	const place = JSON.parse(fs.readFileSync(path.join(ROOT, 'data', 'places.json'), 'utf8')).places.find((p) => p.quest === 245 && p.objective === 1);
	assert.ok(place, 'the spot is a record');
	const { goal } = goals(guide)[at(goals(guide), 'kill 539 quest 245', (g) => g.t === 'kill' && g.quest === 245)];
	assert.equal(goal.map, 1431);
	assert.ok(Math.abs(goal.x - place.at.x) < 0.5 && Math.abs(goal.y - place.at.y) < 0.5, `the arrow goes to ${place.at.x},${place.at.y}, not ${goal.x},${goal.y}`);
	const spawns = refData().npcs[539].spawns[1431];
	const near = [...spawns.pts, ...(spawns.more || [])].filter((p) => Math.hypot(p[0] - goal.x, p[1] - goal.y) < 7).length;
	assert.ok(near >= 8, `most western spawns are near the spot (${near})`);
	const rec = JSON.parse(fs.readFileSync(path.join(ROOT, 'data', 'guide-fixes.json'), 'utf8')).fixes.find((f) => f.at.quest === 245 && f.tip);
	assert.ok(rec, 'the tip is a record');
	assert.deepEqual(stepTips(guide, /kill 539 quest 245/), [rec.tip]);
	assert.doesNotMatch(rec.tip, /east of the cemetery/);
});

// Final route review, Alliance 1-30 (2026-11-08): Night Elves took Further Concerns (35) from Marshal Dughan at the
// end of their Darkshore guide (level 14) and handed it to Guard Thomas on 03-loch-modan's Elwynn road at about 21:
// a level 10 quest carried through two guides for a fraction of its XP. 0.4.0 route audit (B5): nightelf/02-darkshore
// no longer takes it, and neither 03-loch-modan nor 04-redridge-mountains waits for it.
test('forever/alliance/03-loch-modan.guide: Further Concerns is no longer carried to the Elwynn road for Night Elves', { skip }, () => {
	for (const g of ['forever/alliance/03-loch-modan.guide', 'forever/alliance/04-redridge-mountains.guide']) {
		assert.ok(!goals(g).some(({ goal }) => goal.quest === 35), `${g}: no Further Concerns`);
	}
});

// Final route review, Alliance 1-30 (2026-11-08): 06-ashenvale walked from Menethil Harbor through Dun Algaz, Loch
// Modan and the North Gate pass to Ironforge for Lomac Gearstrip, though every Alliance character has had both the
// Menethil Harbor and the Ironforge flight paths since 03-loch-modan (06-wetlands flies the same leg).
test('forever/alliance/06-ashenvale.guide: final review: Menethil Harbor to Ironforge by gryphon', { skip }, () => {
	const list = goals('forever/alliance/06-ashenvale.guide');
	const boran = at(list, 'turnin 279', is('turnin', 279));
	const lomac = at(list, 'turnin 1072', is('turnin', 1072));
	const between = list.slice(boran + 1, lomac).map(({ goal }) => goal);
	assert.ok(between.some((g) => g.t === 'fly'), 'a flight to Ironforge');
	assert.ok(!between.some((g) => g.t === 'goto' && (g.map === 1432 || g.map === 1426)), 'no walk through Loch Modan or Dun Morogh');
});

// Final route review, Alliance 1-30 (2026-11-08): in 06-ashenvale the walk into Stonetalon ("Head south past Mystral
// Lake into the Talondeep Path") was the tip of the Kaela and Gaxim step, after Piznik's mine, and Ziz Fizziks' hand-in
// and his next quest were two steps at one hut.
test('forever/alliance/06-ashenvale.guide: final review: the Talondeep Path tip before Piznik, Ziz Fizziks in one step', { skip }, () => {
	const guide = 'forever/alliance/06-ashenvale.guide';
	const list = goals(guide);
	at(list, 'accept 1090', is('accept', 1090));
	const lines = fs.readFileSync(path.join(OFFICIAL_DIR, guide), 'utf8');
	assert.ok(lines.indexOf('Talondeep Path tunnel') >= 0 && lines.indexOf('Talondeep Path tunnel') < lines.indexOf('accept 1090'), 'the tunnel tip comes before Piznik');
	assert.ok(!stepTips(guide, /turnin 1070/).some((t) => /Talondeep/.test(t)), 'not on the Kaela and Gaxim step');
	// #1370: the hand-in of Gerenzo's Orders (1092) is a group-quest step of its own, right before the Super Reaper
	// step: still one stop at Ziz Fizziks.
	const ziz = at(list, 'turnin 1092', is('turnin', 1092));
	const reaper = at(list, 'accept 1093', is('accept', 1093));
	assert.ok(list[reaper].s - list[ziz].s <= 1 && list[reaper].s >= list[ziz].s, 'one stop at Ziz Fizziks');
});

// Final route review, Alliance 1-30 (2026-11-08): The Weathered Grave (225) and Morgan Ladimore (227) are talk-only
// (level 35, from 28) and the Duskwood return walks past the grave at 29-30, but an old race filter offered them to
// Dwarves and Skyborne only. Every race takes them (optional, offered from 28).
test('forever/alliance/07-thousand-needles.guide: final review: The Weathered Grave for every race from 28', { skip }, () => {
	const list = goals('forever/alliance/07-thousand-needles.guide');
	for (const [t, q] of [['accept', 225], ['turnin', 225], ['accept', 227], ['turnin', 227]]) {
		const { step, goal } = list[at(list, `${t} ${q}`, is(t, q))];
		assert.ok(!(goal.only && goal.only.races) && !(step.only && step.only.races), `${t} ${q} has no race filter`);
	}
	assert.ok(list[at(list, 'accept 225', is('accept', 225))].goal.optional, 'optional: offered from 28');
});

// --- Raene's Cleansing (1045, 2026-11-08): kill four Bloodtooth Guards and bring Ran
// Bloodtooth's Skull (players' recordings and the server's quest record agree); the
// guide asked for four kills of Ran Bloodtooth himself.
test(`${WETLANDS}: Raene's Cleansing asks for four Bloodtooth Guards and Ran Bloodtooth's Skull, not four Ran Bloodtooths`, { skip }, () => {
	const list = goals(WETLANDS);
	at(list, 'kill 3932 quest 1045.1 (Bloodtooth Guard)', (g) => g.t === 'kill' && g.quest === 1045 && g.npc === 3932);
	at(list, "collect 5388 quest 1045.2 (Ran Bloodtooth's Skull)", (g) => g.t === 'collect' && g.quest === 1045 && g.item === 5388);
	assert.ok(!list.some(({ goal }) => goal.t === 'kill' && goal.quest === 1045 && goal.npc === 3696), 'no kill goal for Ran Bloodtooth x4');
});

// vW1: People's Militia part 2 and Moonbrook Espionage left 02-westfall's second half (Sentinel -> Moonbrook ->
// Sentinel at 16) for 03-loch-modan's 19-20 Westfall walk, where the messenger and the traitor already go to Moonbrook.
test(`${WESTFALL} / ${LOCH_MODAN}: #1415 (vW1): People's Militia part 2 and Alba's crates ride on the 19-20 Moonbrook walk`, { skip }, () => {
	const west = goals(WESTFALL);
	for (const q of [14, 92747, 92748]) assert.ok(!west.some(({ goal }) => goal.quest === q), `02-westfall no longer has ${q}`);
	for (const q of [13, 92745]) assert.ok(west.some(({ goal }) => is('turnin', q)(goal)), `02-westfall still hands in ${q}`);
	const loch = goals(LOCH_MODAN);
	const i = (what, t, q) => at(loch, what, is(t, q));
	assert.equal(loch[i('accept 14', 'accept', 14)].step, loch[i('turnin 132', 'turnin', 132)].step, '14 taken with Wiley\'s report at Sentinel Hill');
	assert.equal(loch[i('accept 92747', 'accept', 92747)].step, loch[i('turnin 132', 'turnin', 132)].step, '92747 taken there too');
	const work = at(loch, "14's Defias", (g) => g.t === 'kill' && g.quest === 14);
	assert.ok(work < at(loch, 'the messenger', (g) => g.t === 'collect' && g.quest === 142), 'Moonbrook before the messenger');
	assert.equal(loch[i('turnin 14', 'turnin', 14)].step, loch[i('accept 155', 'accept', 155)].step, 'handed in when the traitor is taken');
	assert.ok(i('turnin 92748', 'turnin', 92748) > i('turnin 155', 'turnin', 155), 'Sprite Jumpsprocket on the Stormwind stop before the boat');
});

// vLM1: Crocolisk Hunting (385) with Twisting the Knife at the Farstrider Lodge (Loch Crocolisks drop its meat and
// skins: recordings show 5 people looting skins in Loch Modan). vLM2: a player without The Defias Brotherhood (65) from
// 02-westfall never sees Wiley's chain, so the Westfall stretch is gated on it and the fresh starter goes from
// Goldshire to General Marcus at Stormwind's gate and flies back to Lakeshire.
test(`${LOCH_MODAN}: #1415 (vLM1, vLM2): Crocolisk Hunting at the lodge; the Westfall stretch only with The Defias Brotherhood`, { skip }, () => {
	const list = goals(LOCH_MODAN);
	const take = at(list, 'accept 385', is('accept', 385));
	assert.equal(list[take].step, list[at(list, 'accept 86758', is('accept', 86758))].step, '385 with Twisting the Knife');
	for (const item of [2924, 2925]) assert.equal(list[at(list, `collect ${item}`, (g) => g.t === 'collect' && g.item === item)].step, list[at(list, 'Daggerfang', (g) => g.quest === 86758 && g.t === 'collect')].step, `item ${item} with Daggerfang`);
	assert.equal(list[at(list, 'turnin 385', is('turnin', 385))].step, list[at(list, 'turnin 86758', is('turnin', 86758))].step, 'handed in with Twisting the Knife');
	const text = fs.readFileSync(path.join(OFFICIAL_DIR, LOCH_MODAN), 'utf8').split(/\n(?=step )/);
	const westfall = text.filter((s) => /^\s+zone Westfall/m.test(s) || /quest (14|92747|142|155)\b|accept (104|14)\b|turnin (132|141|142|155)\b/.test(s));
	assert.ok(westfall.length >= 8, 'the Westfall stretch is there');
	for (const s of westfall) assert.match(s, /^\s+when turnedin 65$/m, `gated on 65: ${s.split('\n')[0]}`);
	const fresh = text.filter((s) => /^\s+when !turnedin 65$/m.test(s));
	assert.ok(fresh.some((s) => /turnin 120\b/.test(s)) && fresh.some((s) => /fly "Lakeshire"/.test(s)), 'the fresh starter hands Solomon\'s letter to Marcus and flies back');
});

// Recorded spots (2026-11-09): Old Murk-Eye is killed on the beach by the lighthouse (5 people), not at his one spawn
// point 240 yd north; the gills come from the whole north coast (31 people), not only its west end.
test(`${LOCH_MODAN} / ${WESTFALL}: #1415: Old Murk-Eye and the murloc gills where players get them`, { skip }, () => {
	const loch = goals(LOCH_MODAN);
	const scale = loch[at(loch, 'collect 3636', (g) => g.t === 'collect' && g.item === 3636)].goal;
	assert.ok(nearestYards(scale, 1436, 33.7, 83.9) < 60, `the scale leads to the lighthouse beach (${scale.x},${scale.y})`);
	assert.ok(PLACES().some((p) => p.id === 'westfall-old-murk-eye'), 'data/places.json keeps it');
	const gills = PLACES().find((p) => p.quest === 92744 && p.objective === 1);
	assert.ok(gills && gills.path && gills.path.points.length >= 4, 'the gill place walks the coast');
	const xs = gills.path.points.map(([x]) => x);
	assert.ok(Math.min(...xs) <= 43 && Math.max(...xs) >= 55, 'from the mine to the Jansen Stead');
});

// vWL4: Insane Druids (the Dor'Danil Barrow Den, Kayneth before and after) is optional (#1336 and #1341 promised its
// barrow-entrance step publicly); Trying Times with Razormaw Needling at Howin; the Fen Creepers along the river.
// (The Eye of Paleth, which this case also pinned to the last Menethil stop, moved to 30-40/01 with Lifting the Curse in
// the 0.4.0 level tidy.)
test(`${WETLANDS}: #1415 (vWL4): Insane Druids optional, Trying Times at Howin, creepers on the river`, { skip }, () => {
	const list = goals(WETLANDS);
	const druids = list.filter(({ goal }) => goal.quest === 1012);
	assert.ok(druids.length >= 5 && druids.find(({ goal }) => goal.t === 'accept').goal.optional, 'Insane Druids is there, its accept optional');
	assert.ok(druids.filter(({ goal }) => goal.t !== 'accept').every(({ step }) => (step.when || []).some((p) => p.k === 'onquest' && !p.neg && [].concat(p.q).includes(1012))), 'its steps only for those who took it');
	assert.equal(list[at(list, 'accept 98246', is('accept', 98246))].step, list[at(list, 'accept 98245', is('accept', 98245))].step, 'Trying Times with Razormaw Needling');
	const creepers = PLACES().find((p) => p.id === '610-wetlands-fen-creepers');
	assert.ok(creepers.path && creepers.path.points[0][0] > 45, 'the creeper place starts on the river by Einar');
	const kill = list[at(list, 'kill 1040', (g) => g.t === 'kill' && g.quest === 275)];
	assert.ok(nearestYards(kill.goal, 1437, 40.6, 32.9) < 150, `the creepers lead along the river (${kill.goal.x},${kill.goal.y})`);
});

// Level tidy 0.4.0: Geltharis (The Branch of Cenarius, 1031) and the three Insane Druids (1012) are level 32, three
// over a player at 06-wetlands' Xavian and Forest Song stretch (recordings: 25th percentile about 29). No later visit
// fits them, so both are group choices: their offers never hold a step, and their work waits for "Do it with a group".
// Fix round 1 (0.4.0): a solo player who took either anyway is told to abandon it, on a step only for the solo branch.
test(`${WETLANDS}: level tidy 0.4.0: The Branch of Cenarius and Insane Druids are group choices, never solo work at 29`, { skip }, () => {
	const list = goals(WETLANDS);
	const grouped = (step, q) => (step.when || []).some((p) => p.k === 'group' && !p.neg && [].concat(p.q).includes(q));
	for (const q of [1031, 1012]) {
		const mine = list.filter(({ goal }) => goal.quest === q);
		assert.ok(mine.length > 0, `${q} is in the guide`);
		assert.ok(mine.filter(({ goal }) => goal.t === 'accept').every(({ goal }) => goal.optional), `${q}: the accept is optional`);
		const work = mine.filter(({ goal }) => !['accept', 'turnin', 'abandon'].includes(goal.t));
		assert.ok(work.length > 0 && work.every(({ step }) => grouped(step, q)), `${q}: its objectives are on the group branch`);
		const drop = mine.filter(({ goal }) => goal.t === 'abandon');
		assert.ok(drop.every(({ goal, step }) => goal.optional && (step.when || []).some((p) => p.k === 'group' && p.neg && [].concat(p.q).includes(q))), `${q}: the abandon only on the solo branch`);
		assert.ok(mine.filter(({ goal }) => goal.t === 'turnin').every(({ step }) => grouped(step, q) || (step.when || []).some((p) => p.k === 'complete' && !p.neg)), `${q}: handed in only after the group work`);
	}
});

// #1386 sweep (Plan line, 0.3.7): a Night Elf Druid loading 06-wetlands fresh without Trial of the Sea Lion (272) was
// sent to Moonglade for a pendant they can't make. Split by quest state, as horde/06-hillsbrad-foothills does. The
// steps are for Skyborne Druids too (#1775: Forever opens the chain to them): the same gates hold for both.
test(`${WETLANDS}: #1415: the Night Elf and Skyborne Druid Moonglade opening only with Trial of the Sea Lion or Aquatic Form in hand`, { skip }, () => {
	const text = fs.readFileSync(path.join(OFFICIAL_DIR, WETLANDS), 'utf8').split(/\n(?=step )/);
	const druid = text.filter((s) => /only NightElf,Skyborne,Druid\n/.test(s) && /Moonglade|Darnassus/.test(s) && !/Boat to/.test(s));
	assert.ok(druid.length >= 4, `the Druid Moonglade and Darnassus steps, for Night Elves and Skyborne (${druid.length})`);
	assert.ok(!text.some((s) => /only NightElf,Druid\n/.test(s) && /Moonglade|Darnassus/.test(s)), 'none of them leaves Skyborne Druids out');
	for (const s of druid) assert.match(s, /^\s+when (onquest 272|turnedin 272|onquest 5061)$/m, `gated: ${s.split('\n')[0]}`);
	const pendant = text.find((s) => /turnin 272\b/.test(s));
	assert.ok(!/accept 5061/.test(pendant), 'the Aquatic Form accept is its own step (a when onquest 272 turns false at the hand-in)');
	assert.match(pendant, /Shrine of Remulos/, 'the halves are joined at the shrine (recordings: Moonglade 36,41-42), not in Stormwind');
});

// Redridge's elite Wanted posters (169, 95999): their steps were all-optional and ungated, so the route passed them at
// once and nobody was led to Gar'im's cave or the keep (players' recordings: 14-15 people handed each in, most at
// 22-23). Now the player opts in with "Do it with a group" and the step holds until the head and the staff are in.
test(`${REDRIDGE}: #1415: Gath'Ilzogg and Incinerator Gar'im are steps the player opts into, not steps passed at once`, { skip }, () => {
	const text = fs.readFileSync(path.join(OFFICIAL_DIR, REDRIDGE), 'utf8').split(/\n(?=step )/);
	for (const [q, item] of [[169, 3633], [95999, 271872]]) {
		const s = text.find((t) => new RegExp(`collect ${item} quest ${q}\\b`).test(t));
		assert.ok(s, `the ${item} step is there`);
		assert.match(s, new RegExp(`^\\s+when group ${q}$`, 'm'), `${q}'s step waits for the player's choice`);
		assert.ok(!new RegExp(`collect ${item} quest ${q} optional`).test(s), `${q}'s collect holds the step`);
	}
});

// Alther's Mill (98386) asks for 12 Greater Tarantulas AND 6 Tarantula Eggs (an object objective in the data since the
// Forge cutover); the step listed only the spiders, so the eggs had no goal and the hand-in at Oslow waited on them
// unannounced. Players' recordings: 32 people clicked the eggs around the mill (46-49,38-45). Sweep over every leveling
// guide (an objective of a handed-in quest with no goal anywhere on the faction's route): no other real case (the
// rest are bought items: buy goals).
test(`${REDRIDGE}: #1415: Alther's Mill's Tarantula Eggs have their goal beside the spiders`, { skip }, () => {
	const list = goals(REDRIDGE);
	const spiders = at(list, 'kill 505 (98386)', (g) => g.t === 'kill' && g.quest === 98386);
	const eggs = at(list, 'the Tarantula Eggs', (g) => g.t === 'interact' && g.quest === 98386 && g.object === 673101);
	assert.equal(list[eggs].step, list[spiders].step, 'eggs and spiders in one step');
	assert.ok(eggs < at(list, 'turnin 98386', is('turnin', 98386)), 'before the hand-in');
});

// Expanding Horizons (97914) is taken from Thundris at 15-16 and was handed to Baros on 06-ashenvale's Stormwind stop
// at ~25, its reply (97926) back to Thundris on 06-wetlands' Auberdine stop at ~28: two guides of carry each. The route
// passes Baros on 03-loch-modan's last Stormwind stop, right before the boat that lands at Thundris (03-darkshore-return):
// both go in there now (#1415, flow audit: a passed ender at 86 yd). 06-ashenvale and 06-wetlands keep optional fallbacks.
test(`${LOCH_MODAN} / ${DARKSHORE_RETURN}: #1415: Expanding Horizons goes to Baros before the boat, Making Do to Thundris where it lands`, { skip }, () => {
	const loch = goals(LOCH_MODAN);
	const baros = at(loch, 'turnin 97914', is('turnin', 97914));
	const boat = loch.findLastIndex(({ goal }) => goal.t === 'goto' && /Boat to/.test(goal.text || ''));
	assert.ok(boat > 0 && baros < boat, 'Baros before the last boat, back to Auberdine');
	assert.ok(loch[at(loch, 'accept 97926', is('accept', 97926))].goal.optional, 'Making Do taken there, optional (#453)');
	const dark = goals(DARKSHORE_RETURN);
	assert.equal(dark[at(dark, 'turnin 97926', is('turnin', 97926))].s, 1, 'Making Do handed to Thundris on the first Auberdine stop');
	const ash = goals(ASHENVALE);
	assert.ok(ash[at(ash, 'turnin 97914', is('turnin', 97914))].step.when.some((p) => p.k === 'onquest'), '06-ashenvale keeps only a fallback for a character still carrying it');
});

// doctor-house (#1429): a Night Elf Hunter who had just trained in the Dwarven District was sent to "Go to Stormwind
// City", a point in the Trade District, then back to the Dwarven District for the errands. The goto was a zone-entry
// line the route had placed after the training step, when every class but the Shaman is already in the city.
// It is gone; the Shaman's return from Ironforge ends where the tram comes out.
test(`${WESTFALL}: doctor-house's report (#1429): no "Go to Stormwind City" after training in Stormwind`, { skip }, () => {
	const list = goals(WESTFALL);
	const train = list.findIndex(({ step, goal }) => goal.t === 'train' && step.title === 'Stormwind' && !(step.only && step.only.classes && step.only.classes.join() === 'SHAMAN'));
	assert.ok(train >= 0, 'the Stormwind training step is in the guide');
	const next = list.slice(train + 1).find(({ step }) => step !== list[train].step && !(step.only && step.only.classes && step.only.classes.includes('SHAMAN') && step.only.classes.length === 1));
	assert.notEqual(next.goal.t, 'goto', `the step after the training is the errands, not a goto: ${next.step.title}`);
	for (const { step, goal } of list) if (goal.t === 'goto' && goal.map === 1453 && step.only && step.only.classes && step.only.classes.join() === 'SHAMAN' && /Stormwind City/.test(goal.text || '') && goal.x < 70) assert.ok(goal.y < 15, `the Shaman's tram return ends at the tram (${goal.x},${goal.y})`);
});

// frostyends (#1442): a level-17 Night Elf Hunter on 03-darkshore could not take the Beached Sea Turtle (4727): the
// turtles offer their quests only once Washed Ashore (4681) is handed in (players' recordings: 30 of 32 accepts by
// characters with 4681 done, no recorded offer without it). 03-darkshore had Gwennyth's two quests for every race but
// Night Elves, who get them in Teldrassil and their own Darkshore guide; a Night Elf without them (a skipped step, or
// the guide loaded fresh) was sent to a turtle that offers nothing. Now everyone without them takes them in Auberdine,
// beside the steps that need them; a Night Elf who has them passes the goals as done.
test(`${DARKSHORE}: frostyends's report (#1442): Washed Ashore is on the Auberdine stop for every race before the Beached Sea Turtles`, { skip }, () => {
	const list = goals(DARKSHORE);
	for (const [t, q] of [['accept', 3524], ['turnin', 3524], ['accept', 4681], ['turnin', 4681]]) {
		const { step, goal } = list[at(list, `${t} ${q}`, is(t, q))];
		assert.ok(![step.only, goal.only].some((o) => o && o.races && !o.races.includes('NightElf')), `${t} ${q} applies to Night Elves too`);
	}
	for (const q of [4727, 4725]) assert.ok(at(list, 'turnin 4681', is('turnin', 4681)) < at(list, `accept ${q}`, is('accept', q)), `Washed Ashore is handed in before ${q}`);
});
// #1508/#1518 (0.3.6): after the tunnel post, 03-loch-modan sent everyone through the tunnel into Dun Morogh, a
// waypoint for players who walk to Ironforge. Dwarves and Gnomes have the Ironforge flight path from their Dun Morogh
// guide, so the arrow then turned them back to Thelsamar to fly. 0.4.0 (#2025): the flight is for whoever knows the
// Ironforge flight path, whatever the race (players' recordings: Humans, Night Elves and Skyborne who had it flew),
// and the tunnel walk for whoever doesn't, a Dwarf or Gnome without it included.
test('forever/alliance/03-loch-modan.guide: the flight to Ironforge goes by the Ironforge flight path, the tunnel walk for the rest (#1508, #1518)', { skip }, () => {
	const list = goals('forever/alliance/03-loch-modan.guide');
	const post = at(list, 'turnin 86585', is('turnin', 86585));
	const stormpike = at(list, 'turnin 301', is('turnin', 301));
	const between = list.slice(post + 1, stormpike).filter(({ step }) => !dungeonOnly(step));
	const taxi = (step, neg) => (step.when || []).some((p) => p.k === 'taxi' && !!p.neg === neg && /Ironforge/.test(p.name || p.location || JSON.stringify(p)));
	const fly = between.find(({ goal }) => goal.t === 'fly');
	assert.ok(fly, 'a flight to Ironforge');
	assert.ok(taxi(fly.step, false), 'the flight step is `when taxi "Ironforge"`');
	assert.ok(!fly.step.only || !fly.step.only.races, 'for every race');
	const walks = between.filter(({ goal }) => goal.t === 'goto' && (goal.map === 1426 || goal.map === 1455));
	assert.ok(walks.some(({ goal }) => goal.map === 1426), 'the tunnel into Dun Morogh');
	for (const { step } of walks) {
		assert.ok(taxi(step, true), `${step.title}: \`when !taxi "Ironforge"\``);
		assert.ok(!step.only || !step.only.races, `${step.title}: for every race`);
	}
});

// #1508 follow-up (0.3.6): about half of the Humans, Night Elves and Skyborne recorded on 03-loch-modan (0.3.5) also
// had the Ironforge flight path and flew Thelsamar -> Ironforge from the tunnel waypoints; landing in the Great
// Forge, "Into Ironforge" (the city gate) then led them back out. The two walking waypoints drop in Ironforge.
test('forever/alliance/03-loch-modan.guide: the tunnel and gate waypoints drop once the player is in Ironforge (#1508)', { skip }, () => {
	const steps = compiled('forever/alliance/03-loch-modan.guide').steps.filter((st) => st.goals.some((g) => g.t === 'goto' && (g.map === 1426 || (g.map === 1455 && g.x === 21.6))));
	assert.equal(steps.length, 2, 'Into Dun Morogh and Into Ironforge');
	for (const st of steps) assert.ok((st.when || []).some((p) => p.k === 'zone' && p.neg && /Ironforge/.test(p.name)), `${st.title}: when !zone "Ironforge"`);
});

// Players' route (0.3.6): Bloom of the Heavens (98208, 98209; 2950 XP) is taken from Sylessa
// Duskwhisper by Menethil's docks on 06-wetlands' first Menethil stop, Nord'el picked up on the shore just south of
// the town (players' recorded spot), handed in on the next Menethil stop, and the follow-up handed to Thundris
// Windweaver in Auberdine when the boat lands there.
test(`${WETLANDS}: Bloom of the Heavens rides on the Menethil stops and the boat to Auberdine`, { skip }, () => {
	const list = goals(WETLANDS);
	const take = at(list, 'accept 98208', is('accept', 98208));
	assert.equal(list[take].s, list[at(list, 'accept 471', is('accept', 471))].s, 'taken on the first Menethil stop, beside James Halloran');
	const nordel = at(list, "collect Nord'el", (g) => g.t === 'collect' && g.quest === 98208);
	assert.ok(take < nordel && nordel < at(list, 'turnin 281', is('turnin', 281)), "Nord'el before the walk north to the hovels");
	assert.ok(located(list[nordel]) && yards(list[nordel].goal, { map: 1437, x: 12.2, y: 63.8 }) < 30, "the arrow leads to the recorded spot");
	const back = at(list, 'turnin 98208', is('turnin', 98208));
	const next = at(list, 'accept 98209', is('accept', 98209));
	assert.ok(back < next && list[back].s === list[at(list, 'turnin 471', is('turnin', 471))].s, 'handed in on the next Menethil stop, then the follow-up taken');
	const thundris = at(list, 'turnin 98209', is('turnin', 98209));
	assert.ok(thundris > at(list, 'goto Boat to Auberdine', (g) => g.t === 'goto' && g.x === 4.5 && g.y === 56.7), 'in Auberdine, after the boat');
	assert.ok(thundris < at(list, 'turnin 994', is('turnin', 994)), 'on the Auberdine stop, before Terenthis and the flight to Astranaar');
	assert.ok((list[thundris].step.when || []).some((p) => p.k === 'onquest' && !p.neg), 'only for a character carrying it');
});

// Players' route (0.3.6): Vengeful Trail (98417, 1700 XP) is taken from Maseara Autumnmoon on the first
// Forest Song stop; Satyrnaar (the Circle of Imprisonment, Kurothel's Knapsack beside it) is walked between Fallen Sky
// Lake and Kayneth Stillwind's hand-in, where the scroll goes to Maseara. Shared Fury (98418) is not taken.
test(`${WETLANDS}: Vengeful Trail's scroll is picked up at Satyrnaar on the way back to Forest Song`, { skip }, () => {
	const list = goals(WETLANDS);
	const take = at(list, 'accept 98417', is('accept', 98417));
	assert.equal(list[take].s, list[at(list, 'turnin 4581', is('turnin', 4581))].s, 'taken on the first Forest Song stop');
	const lake = at(list, 'collect 5508 (Fallen Moonstone)', (g) => g.t === 'collect' && g.quest === 1035);
	const scroll = at(list, 'collect Vine-Wrapped Scroll', (g) => g.t === 'collect' && g.quest === 98417);
	const circle = at(list, "Satyrnaar's circle", (g) => g.t === 'interact' && g.quest === 1140 && g.oi === 2);
	const kayneth = at(list, 'turnin 1011', is('turnin', 1011));
	assert.ok(lake < circle && circle < kayneth && list[scroll].s === list[circle].s, 'Satyrnaar between Fallen Sky Lake and Kayneth, the scroll with the circle');
	assert.ok(located(list[scroll]) && yards(list[scroll].goal, { map: 1440, x: 81.7, y: 49.2 }) < 30, 'the arrow leads to the recorded knapsack');
	assert.equal(list[at(list, 'turnin 98417', is('turnin', 98417))].s, list[kayneth].s, "handed to Maseara on Kayneth's stop");
	assert.ok(!list.some(({ goal }) => goal.quest === 98418), 'Shared Fury is left out');
});

// #1556: Dartol's Rod's Wooden Key (5475) drops only from the Crazed (3834, 44%) and Withered Ancients (3919, 45%)
// north of the moonwell, and its line named neither: the compiler named a source only when it drops the item at 50%
// or more. An item only one or two located sources of one kind drop, each at 20% or more, names them both now.
test('Alliance Wetlands & Ashenvale: the Wooden Key line names the Ancients that drop it (#1556)', { skip }, () => {
	const list = goals('forever/alliance/06-wetlands.guide');
	const { goal } = list[at(list, 'collect 5475', (g) => g.t === 'collect' && g.item === 5475)];
	assert.deepEqual([goal.fromId, goal.fromAlsoId].sort((a, b) => a - b), [3834, 3919], 'both Ancients are named');
	assert.equal(goal.fromKind, 'npc');
});

// #1833 (Ami2, NightElf Druid 19, 0.3.7): A Hunter's Challenge (258) must be back at Daryl the Youngling within 12
// minutes, and the boars' step also carried Crocolisk Hunting's crocolisks and Daggerfang, so the timer ran on the
// shore (recordings on 0.3.5+: 3 fails at 12:00 in 17 accepts). Now the boars come alone, 258 goes straight back to
// Daryl, then the shore.
test(`${LOCH_MODAN}: #1833: A Hunter's Challenge is handed in before the crocolisks and Daggerfang`, { skip }, () => {
	const list = goals(LOCH_MODAN);
	const take = at(list, 'accept 258', is('accept', 258));
	const back = at(list, 'turnin 258', is('turnin', 258));
	assert.ok(take < back, 'taken before it is handed in');
	assert.ok(list.slice(take + 1, back).every(({ goal }) => !['kill', 'collect', 'interact', 'use'].includes(goal.t) || goal.quest === 258), 'no other quest\'s field work while A Hunter\'s Challenge runs');
	assert.ok(back < at(list, 'Crocolisk Meat', (g) => g.t === 'collect' && g.item === 2924), 'the crocolisks after the hand-in');
	assert.ok(back < at(list, "Marek's Croc-Hunting Knife", (g) => g.t === 'collect' && g.item === 279591), 'Daggerfang after the hand-in');
});

// #1866 (ǝxǝ.ozuǝɹnɐๅ, NightElf Druid 28, 0.3.7): the Tome of Mel'Thandris (The Howling Vale, 1022) was read on the
// first visit to Shael'dryn's moonwell, among the Terrowulf packs (28-30) and their rare Packlord (32), with no warning
// (players' recordings: reads at 28-32, median 29; 2 deaths in the vale at 28 and 29). It is read on the later visit,
// after the Hidden Shrine (1055 handed in at 29-30), and the step warns of the packs and the Packlord.
test(`${WETLANDS}: #1866: the Tome of Mel'Thandris is read on the later moonwell visit, with a warning`, { skip }, () => {
	const list = goals(WETLANDS);
	const tome = at(list, 'interact 19027 (Tome of Mel\'Thandris)', (g) => g.t === 'interact' && g.object === 19027 && g.quest === 1022);
	assert.ok(tome > at(list, 'turnin 1055 (the Hidden Shrine)', is('turnin', 1055)), 'after the Hidden Shrine, on the later moonwell visit');
	assert.ok(tome > at(list, 'turnin 1026', is('turnin', 1026)), 'not on the first visit');
	assert.ok(tome < at(list, 'turnin 1022', is('turnin', 1022)), 'before Melyria takes it');
	const tip = [].concat(list[tome].step.note || []).join(' ');
	assert.match(tip, /Careful:.*Packlord/, tip);
	assert.match(tip, /tunnel/, tip);
	const fixes = JSON.parse(fs.readFileSync(path.join(ROOT, 'data', 'route-fixes.json'), 'utf8'));
	assert.ok(fixes.deliberate.pairs.some((p) => p.faction === 'Alliance' && `${p.a}` === 'turnin,1055' && `${p.b}` === 'task,1022'), 'a record the build keeps');
});

// 大地瓜 (#1089), mrdick47 (#1811), CircusCyaneus (#2413): Sentinel Selarin, who gives Trek to Ashenvale in Auberdine,
// was not beside Terenthis. She isn't killed and respawning: she stays only a few minutes, after someone hands in
// Volcor's escort (caltman24 watched her come and leave about 5 minutes later; players' recordings: 19 of 27 players on
// the 0.3.6+ route left the step without her quest, some after 12-45 minutes, and players who handed in the escort
// themselves took it within 1-3 minutes). So every step that takes it says she comes and goes, never holds the player
// (optional), and a second chance follows the player's own hand-in of Escape Through Force (994).
test('Trek to Ashenvale (#1089, #1811): Sentinel Selarin comes and goes; her quest never holds a step and is offered again after the escort', { skip }, () => {
	assert.equal(refData().npc(3694).name, 'Sentinel Selarin');
	const held = stepsHolding((g) => g.t === 'accept' && g.quest === 990);
	assert.ok(held.length > 0, 'the route takes Trek to Ashenvale');
	const bad = held
		.filter(({ step, goal }) => !goal.optional || !/\b(few minutes|once she comes|comes)\b/i.test(notesOf(step, goal)) || /\brespawns?\b/i.test(notesOf(step, goal)))
		.map(({ guide, step }) => `${guide} "${step.title}": accept 990 holds the step, or says she respawns, or doesn't say she comes and goes`);
	assert.deepEqual(bad, []);
	const afterEscort = held.filter(({ step, goal }) => {
		const i = step.goals.indexOf(goal);
		return i > 0 && step.goals[i - 1].t === 'turnin' && step.goals[i - 1].quest === 994;
	});
	assert.ok(afterEscort.some(({ guide }) => guide === ASHENVALE), '06-ashenvale offers it right after the escort hand-in to Terenthis');
});

// 0.4.0 route audit, Alliance 12-21 (B1): Humans trained at Goldshire (about 11) and next at the Stormwind
// stop before the boat (about 16); the Thor flight's Stormwind visit at about 13 passes Old Town, Cathedral
// Square and the Mage Quarter, so the level 12 spells are learned there.
test(`${WESTFALL}: Humans train on the Thor flight's Stormwind visit`, { skip }, () => {
	const list = goals(WESTFALL).filter(forRaceOf('Human'));
	const osric = at(list, 'turnin 6281', is('turnin', 6281));
	const back = at(list, 'fly back to Sentinel Hill', (g) => g.t === 'fly' && g.location === 'Sentinel Hill');
	const train = list.findIndex(({ goal }, i) => i > osric && i < back && goal.t === 'train' && goal.class);
	assert.ok(train > 0, 'a class training goal between Osric Strang and the flight back');
	for (const cls of ['WARRIOR', 'PALADIN', 'HUNTER', 'ROGUE', 'PRIEST', 'MAGE', 'WARLOCK']) assert.ok(forClass(cls)(list[train]), `${cls} trains there`);
});

// 0.4.0 route audit, Alliance 12-21 (B7): after the last Westfall hand-ins the guide said to walk to Stormwind
// (about 2,300 yd). Every start knows both flight paths by then; players' recordings (0.3.5+): of 19 people
// measured there, 15 flew Sentinel Hill -> Stormwind and 4 used the Hearthstone, none walked.
test(`${WESTFALL}: the last Sentinel Hill stop flies to Stormwind`, { skip }, () => {
	const list = goals(WESTFALL);
	const last = at(list, 'turnin 92745', is('turnin', 92745));
	const fly = list.findIndex(({ goal }, i) => i > last && goal.t === 'fly');
	assert.ok(fly > last && list[fly].step === list[last].step, 'the flight is on the Sentinel Hill stop');
	assert.equal(list[fly].goal.location, 'Stormwind');
	assert.ok(!compiled(WESTFALL).steps.some((st) => /Walk to Stormwind/.test(st.note || '')), 'no tip says to walk there');
});

// 0.4.0 route audit, Alliance 12-21 (B9, #2082): a player with the Hearthstone in Auberdine hearthed at the end of
// 03-loch-modan and the guide still sent him to the Stormwind dock. The gryphon, the Stormwind errands and the boat
// stay the default way back (the level model reads the end without them as slower), and every step of it drops once
// the player is in Darkshore; training is added to that stop (the next train step was 06-ashenvale's, at 25-27).
test(`${LOCH_MODAN}: #2082: the way back to Auberdine drops once in Darkshore, with training on the way`, { skip }, () => {
	const list = goals(LOCH_MODAN);
	const lastLakeshire = list.findLastIndex(({ goal }) => is('turnin', 89)(goal));
	const back = list.slice(lastLakeshire + 1).filter(({ step }) => step !== list[lastLakeshire].step);
	assert.ok(back.some(({ goal }) => goal.t === 'goto' && /Boat to Auberdine/.test(goal.text || goal.label || '')), 'the boat is the default way back');
	for (const { step } of back) assert.ok((step.when || []).some((p) => p.k === 'zone' && p.neg && /Darkshore/.test(p.name)), `${step.title}: \`when !zone "Darkshore"\``);
	const train = back.find(({ goal }) => goal.t === 'train' && goal.class);
	assert.ok(train, 'a training stop in Stormwind before the boat');
	for (const cls of ['WARRIOR', 'PALADIN', 'HUNTER', 'ROGUE', 'PRIEST', 'MAGE', 'WARLOCK']) assert.ok(forClass(cls)(train), `${cls} trains there`);
	for (const q of [92748, 97914, 1788]) assert.ok(back.some(({ goal }) => is('turnin', q)(goal)), `turnin ${q} on that stop`);
});

// 0.4.0 route audit, Alliance 12-21 (F2, with 03-darkshore-return's Cat Form trip): Night Elf and Skyborne Druids
// took Trial of the Sea Lion (272) at about 17 and fetched the Westfall half on a gryphon of its own to Sentinel Hill
// in 04-redridge-mountains (about 25), then joined the halves on a Moonglade trip of its own in 06-wetlands (about
// 28). The Westfall stretch of 03-loch-modan passes the Gold Coast Quarry, close to the Strange Lockbox (Westfall
// 17.9,33.2): the half is collected there, so the Cat Form trip can finish 272 and Aquatic Form at about 22.
test(`${LOCH_MODAN}: Druids collect the Westfall half pendant on the Westfall stretch`, { skip }, () => {
	const list = goals(LOCH_MODAN);
	const half = at(list, 'collect 15882', (g) => g.t === 'collect' && g.item === 15882);
	const { step } = list[half];
	assert.ok(step.when.some((p) => p.k === 'onquest' && !p.neg && [p.q].flat().includes(272)), 'only with Trial of the Sea Lion in the log');
	assert.ok(forClass('DRUID')(list[half]) && !forClass('WARRIOR')(list[half]), 'Druids only');
	assert.ok(half > at(list, 'the Defias Messenger', (g) => g.t === 'collect' && g.quest === 142) && half < at(list, 'accept 104', is('accept', 104)), 'between the messenger\'s road and the lighthouse');
});

// 0.4.0 route audit (B9, with the 21-30 audit's numbers): the Menethil tip said the Wetlands visit comes "at about 22"; it
// comes after Ashenvale and the Stonetalon Mountains, where players are 24-27.
test(`${LOCH_MODAN}: the Menethil tip names when the Wetlands visit comes, not a wrong level`, { skip }, () => {
	const step = compiled(LOCH_MODAN).steps.find((st) => st.title === 'Menethil Harbor');
	assert.ok(step && /after Ashenvale/.test(step.note || ''), 'the tip says the Wetlands come after Ashenvale');
	assert.ok(!/about 22/.test(step.note || ''), 'no "about 22"');
});

// 0.4.0 route audit (B2/B3, with the start guides): Gnome Warlocks took Surena's Choker on a walk of its own from
// Stormwind to the Brackwell Pumpkin Patch and back at the end of Dun Morogh; 02-westfall's east Elwynn loop walks
// past her (the Downstream river). The choker is taken there, The Binding on a Goldshire -> Stormwind hop before Westfall.
test(`${WESTFALL}: Gnome Warlocks take Surena's Choker on the east Elwynn loop and summon the voidwalker before Westfall`, { skip }, () => {
	const list = goals(WESTFALL).filter(forRaceOf('Gnome')).filter(forClass('WARLOCK'));
	const choker = at(list, 'collect 6810', (g) => g.t === 'collect' && g.item === 6810);
	const goldshire = at(list, 'turnin 39 (Goldshire)', is('turnin', 39));
	const binding = at(list, 'turnin 1689', is('turnin', 1689));
	assert.ok(at(list, 'Downstream', (g) => g.t === 'collect' && g.quest === 91733) < choker && choker < goldshire, 'the choker after Downstream, before Goldshire');
	assert.ok(goldshire < at(list, 'turnin 1688', is('turnin', 1688)) && binding < at(list, 'accept 36 (the Jansen Stead)', is('accept', 36)), 'the summoning after Goldshire, before Westfall');
	for (const i of [choker, binding]) assert.ok(list[i].step.when.some((p) => p.k === 'onquest' && !p.neg), `${list[i].step.title}: only while The Binding is carried`);
	assert.ok(!goals(WESTFALL).filter(forClass('WARRIOR')).some(({ goal }) => goal.quest === 1688 || goal.quest === 1689), 'Warlocks only');
});

// Alliance 20-30 audit (0.4.0, #2025): 06-wetlands bound at the Deepwater Tavern on its first Menethil stop and again at
// Astranaar on the Ashenvale visit. With the Astranaar bind gone the Hearthstone stays on Menethil, where the guide
// goes after Ashenvale (the flight to Auberdine and the boat): the addon's route planner over nine race and class runs
// finds it 1.5 minutes shorter per run, the Deepwater hearths taking the place of the Astranaar ones one for one.
test(`${WETLANDS}: the last bind before the Duskwood return is the Deepwater Tavern (Alliance 20-30 audit)`, { skip }, () => {
	const binds = goals(WETLANDS).filter(({ goal }) => goal.t === 'sethome');
	assert.ok(binds.length >= 1, 'the guide binds the Hearthstone');
	assert.equal(binds[binds.length - 1].goal.location, 'Deepwater Tavern', 'the last bind is the Deepwater Tavern');
	assert.ok(!binds.some(({ goal }) => goal.location === 'Astranaar'), 'no bind at Astranaar');
	assert.ok(goals(ASHENVALE).some(({ goal }) => goal.t === 'sethome' && goal.location === 'Astranaar'), "06-ashenvale's Astranaar bind stays");
});

// Alliance 20-30 audit (0.4.0, #2025): Gathering the Cure's Lunar Fungal Blooms grow in the moonkin caves just east
// of Auberdine, on the way south; 03-darkshore-return went to Onu at the Grove first and walked back north for them.
test(`${DARKSHORE_RETURN}: the Lunar Fungus is picked on the way south, before Onu (Alliance 20-30 audit)`, { skip }, () => {
	const list = goals(DARKSHORE_RETURN);
	const fungus = at(list, 'Lunar Fungus (6123)', (g) => g.t === 'collect' && g.quest === 6123 && g.item === 15851);
	const onu = at(list, 'Onu (948)', is('turnin', 948));
	assert.ok(fungus < onu, 'the blooms come before Onu');
});

// Alliance 20-30 audit (0.4.0, #2025): 06-ashenvale trains every class but Druids in Ironforge and rides the tram to
// Stormwind, where 04-redridge-mountains begins; its Shaman steps sent Shamans back on the tram to the same trainer,
// at the same level, and back again.
test(`${REDRIDGE}: no tram back to Ironforge for Shamans trained there on 06-ashenvale's last stops (Alliance 20-30 audit)`, { skip }, () => {
	const ironforge = goals(ASHENVALE).find(({ step, goal }) => goal.t === 'train' && goal.class && ((goal.only && goal.only.classes) || (step.only && step.only.classes) || []).includes('SHAMAN'));
	assert.ok(ironforge, "06-ashenvale's Ironforge stop trains Shamans");
	const back = compiled(REDRIDGE).steps.filter((st) => /Tram to Ironforge|Shaman training/.test(st.title));
	assert.deepEqual(back.map((st) => st.title), [], 'no Shaman tram steps');
});

// Alliance 20-30 audit (0.4.0, #2025): Druids end 03-darkshore-return at Mathrengyl Bearwalker in Darnassus, a Druid
// trainer, at about 22-23; their next training was 04-redridge-mountains' Stormwind stop at about 25.
test(`${DARKSHORE_RETURN}: Druids train at Mathrengyl Bearwalker on the Cat Form hand-in (Alliance 20-30 audit)`, { skip }, () => {
	const list = goals(DARKSHORE_RETURN);
	const catForm = at(list, 'Cat Form (98397) to Mathrengyl', is('turnin', 98397));
	const step = list[catForm].step;
	assert.ok(step.goals.some((g) => g.t === 'train' && g.class), 'the Mathrengyl step trains the class');
	assert.ok(step.only && step.only.classes && step.only.classes.join() === 'DRUID', 'a Druid step');
});

// Alliance 20-30 audit (0.4.0, #2025): Escape Through Force (994) is finished at the end of 03-darkshore-return and
// was handed in only on 06-wetlands' Auberdine stop, six levels on; 06-ashenvale lands at Auberdine's flight master,
// beside Terenthis, on its way to the Menethil boat.
test(`${ASHENVALE}: Escape Through Force goes to Terenthis on the Auberdine landing, before Menethil (Alliance 20-30 audit)`, { skip }, () => {
	const list = goals(ASHENVALE);
	const fly = at(list, 'the flight to Auberdine', (g) => g.t === 'fly' && g.location === 'Auberdine');
	const terenthis = at(list, 'Escape Through Force (994)', is('turnin', 994));
	const menethil = at(list, "Karl Boran's Claws from the Deep (279)", is('accept', 279));
	assert.ok(fly < terenthis && terenthis < menethil, 'flight, Terenthis, then Menethil');
	assert.ok(goals(WETLANDS).some(({ goal }) => goal.t === 'turnin' && goal.quest === 994), "06-wetlands keeps a hand-in for carriers");
});

// Alliance 20-30 audit (0.4.0, #2025; first made for the 0.3.7 stranded-quests plan): four Darkshore and Stormwind
// quests that a character from an older route or a guide left early still carries are handed in on stops 06-wetlands
// already makes at their enders, each only while carried.
test(`${WETLANDS}: carried Darkshore quests are handed in on the stops at their enders (Alliance 20-30 audit)`, { skip }, () => {
	const steps = compiled(WETLANDS).steps;
	for (const q of [990, 945, 967, 97914]) {
		const st = steps.find((s) => s.goals.some((g) => g.t === 'turnin' && g.quest === q));
		assert.ok(st, `${q} is handed in`);
		assert.ok((st.when || []).some((p) => p.k === 'onquest' && !p.neg), `${q}: only while carried (when onquest)`);
	}
});

// Alliance 20-30 audit (0.4.0, #2025): with both half pendants of Trial of the Sea Lion in the bags, Night Elf and
// Skyborne Druids join them and take Aquatic Form on 03-darkshore-return's Cat Form trip to Moonglade and Darnassus,
// at about 22, instead of on 06-wetlands' own trip at about 28 (which stays for a Druid still on 272).
test(`${DARKSHORE_RETURN}: Trial of the Sea Lion and Aquatic Form on the Cat Form trip (Alliance 20-30 audit)`, { skip }, () => {
	const list = goals(DARKSHORE_RETURN);
	const sea = at(list, 'Trial of the Sea Lion (272) to Dendrite', is('turnin', 272));
	const aquatic = at(list, 'Aquatic Form (5061) to Mathrengyl', is('turnin', 5061));
	const catForm = at(list, 'Cat Form (98397) to Mathrengyl', is('turnin', 98397));
	assert.ok(sea < aquatic && aquatic < catForm, '272 at Dendrite, then 5061 and Cat Form at Mathrengyl');
	const when = list[sea].step.when || [];
	for (const item of [15882, 15883]) assert.ok(when.some((p) => p.k === 'has' && !p.neg && p.item === item), `only with half pendant ${item}`);
	assert.ok(goals(WETLANDS).some(({ goal }) => goal.t === 'turnin' && goal.quest === 272), "06-wetlands keeps its trip for a Druid still on 272");
});

// Alliance 20-30 audit (0.4.0, #2025): at Mystral Lake, Tideress (27) killed 4 people and the Befouled Water
// Elementals 5 at about 23 (players' recordings). Fix round 1: the quest moved to 06-wetlands' Krolg leg at about 29.7,
// where Tideress is two under the player; the step still names her, and 06-ashenvale has no Mystral Lake step.
test(`${WETLANDS}: Elemental Bracers is done at about 29 on the Krolg leg, and the step names Tideress`, { skip }, () => {
	assert.ok(!goals(ASHENVALE).some(({ goal }) => goal.quest === 1016), `${ASHENVALE} no longer works Elemental Bracers at 23-24`);
	const list = goals(WETLANDS);
	assert.ok(at(list, 'turnin 1016', is('turnin', 1016)) < at(list, 'turnin 1030 (Krolg)', is('turnin', 1030)), 'on the way to Krolg');
	const { step } = list[at(list, 'Elemental Bracers (1016)', is('accept', 1016))];
	assert.match([step.tip, step.note].flat().filter(Boolean).join(' '), /Tideress, a level 27 water elemental/);
});

// Alliance 20-30 audit (0.4.0, #2025, with the Alliance 30-40 slice): Retrieval for Mauren (1078) was taken on
// 06-ashenvale's Stormwind stop at about 25 and carried thirteen levels to its scales in Thousand Needles; it is taken
// on 30-40/01-hillsbrad-foothills' Mage Quarter stop (Collin Mauren is in the Slaughtered Lamb there), right before.
test(`${ASHENVALE}: Retrieval for Mauren is no longer taken at 25 (Alliance 20-30 audit)`, { skip }, () => {
	assert.ok(!goals(ASHENVALE).some(({ goal }) => is('accept', 1078)(goal)), 'no accept 1078 in 06-ashenvale');
	assert.ok(goals(ASHENVALE).some(({ goal }) => is('turnin', 1075)(goal)), 'A Scroll from Mauren still goes to Collin Mauren');
});

// Alliance 20-30 audit (0.4.0, #2025; first made for the 0.3.7 fresh-start plan): a character starting 06-wetlands
// without 06-ashenvale's quests tops up to 28 by Menethil before the boat to Ashenvale's 28-32 quests; the route
// player, past 28 there, never stops.
test(`${WETLANDS}: a fresh starter tops up to 28 by Menethil before the boat to Auberdine (Alliance 20-30 audit)`, { skip }, () => {
	const list = goals(WETLANDS);
	const top = at(list, 'level 28', (g) => g.t === 'level' && g.level === 28);
	const step = list[top].step;
	assert.ok((step.when || []).some((p) => p.k === 'level'), 'only below 28 (when level<28)');
	assert.ok(at(list, 'Daily Delivery hand-in (469)', is('turnin', 469)) < top, 'after the last Menethil hand-in');
	// (A Night Elf Priest's Darnassus detour at the guide's start has its own "Boat to Auberdine" in Stormwind.)
	const boat = list.findIndex(({ goal }, i) => i > top && goal.t === 'goto' && /Boat to Auberdine/.test(goal.text || ''));
	assert.ok(boat > top && boat < at(list, 'Bloom of the Heavens to Thundris (98209)', is('turnin', 98209)), 'before the boat to Auberdine');
});

// Alliance 20-30 audit (0.4.0, #2025): 03-loch-modan's last Stormwind stop is skipped by a player who hearths to
// Auberdine, so Explosive Consultation (92748) goes to Sprite Jumpsprocket when 06-ashenvale's tram comes in at the
// Dwarven District, only while carried.
test(`${ASHENVALE}: Sprite Jumpsprocket takes Explosive Consultation when the tram comes in (Alliance 20-30 audit)`, { skip }, () => {
	const list = goals(ASHENVALE);
	const sprite = at(list, 'Explosive Consultation (92748)', is('turnin', 92748));
	assert.ok((list[sprite].step.when || []).some((p) => p.k === 'onquest' && !p.neg), 'only while carried');
	assert.ok(at(list, 'the tram to Stormwind', (g) => g.t === 'goto' && /Tram to Stormwind/.test(g.text || '')) < sprite, 'after the tram');
});

// Acrylic (#2243, Gnome Warlock 26) and one more player: 04-redridge-mountains' first Darkshire stop held them on Look
// to the Stars' hand-in (174, a Bronze Tube) and told them to skip it by hand; Herble had no tube in 44 merchant windows
// of 28 people (#1792) and the Auction House buy before Darkshire is optional. Viktori's goals are a step of their own,
// shown only with a tube (174) or once 174 is handed in (175); without it the chain's later goals in 05-duskwood and
// 07-thousand-needles don't hold either.
test(`${REDRIDGE}: Acrylic's report (#2243): Look to the Stars is a step of its own, only with a Bronze Tube; the chain drops out without one`, { skip }, () => {
	const red = goals(REDRIDGE);
	const take = at(red, 'accept 174', is('accept', 174));
	const part2 = at(red, 'accept 175', is('accept', 175));
	assert.notEqual(red[take].s, red[at(red, 'accept 163', is('accept', 163))].s, "not on the main Darkshire step");
	assert.ok((red[take].step.when || []).some((p) => p.k === 'has' && !p.neg && p.item === 4371), 'only with a Bronze Tube');
	assert.equal(red[at(red, 'turnin 174', is('turnin', 174))].s, red[take].s, 'handed in on the same step');
	assert.ok((red[part2].step.when || []).some((p) => p.k === 'turnedin' && !p.neg), '175 only once 174 is handed in');
	const warlock = { race: 'Gnome', raceName: 'Gnome', faction: 'Alliance', cls: 'WARLOCK', className: 'Warlock', level: 26 };
	const without = questGoalStatus(REDRIDGE, 174, warlock);
	assert.ok(without.length >= 2 && without.every((s) => / (skipped|na)$/.test(s)), `without a tube 174 is passed: ${without.join(', ')}`);
	const withTube = questGoalStatus(REDRIDGE, 174, warlock, { skills: 'w.addItem(4371, 1)' });
	assert.ok(withTube.every((s) => !/ (skipped|na)$/.test(s)), `with a tube 174 is open: ${withTube.join(', ')}`);
	for (const [guide, q] of [['forever/alliance/05-duskwood.guide', 175], ['forever/alliance/05-duskwood.guide', 177], [THOUSAND_NEEDLES, 177], [THOUSAND_NEEDLES, 181]]) {
		const st = questGoalStatus(guide, q, { ...warlock, level: q === 181 ? 30 : 27 });
		assert.ok(st.length >= 1 && st.every((s) => / (skipped|na)$/.test(s)), `${guide}: ${q} drops out without the chain: ${st.join(', ')}`);
	}
});
