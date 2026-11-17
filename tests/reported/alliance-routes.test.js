'use strict';
// Player-reported guide fixes: checks across several Alliance guides (a whole route, a band against the next).
// tests/reported/helpers.js says what the cases check and where a new one goes.

const { test } = require('node:test');
const assert = require('node:assert/strict');
const fs = require('node:fs');
const path = require('node:path');
const {
	ARATHI, ASHENVALE, ASHENVALE_30, at, BADLANDS, chainFrom, compiled, compileSources, DARKSHORE, DARKSHORE_RETURN,
	darkshoreBoth, DESOLACE_SOUTH, dist, DUN_MOROGHS, DWARF_DUN_MOROGH, ELWYNN, everyone, forClass, goals,
	HILLSBRAD_ALLIANCE, is, located, lvlOf, makeProjector, MULGORE, NE_DARKSHORE, needs, nightElf, OFFICIAL_DIR,
	REDRIDGE, refData, ROOT, routes, skip, TELDRASSIL, THOUSAND_NEEDLES, UN_GORO_ALLIANCE, WESTFALL, WETLANDS, whenOn,
	where, yards, ZEPHRAS_ALLIANCE,
} = require('./helpers');

// --- Alliance quest volume (2026-11-07): quests whose givers, work and enders lie on visits our route
// already makes (a giver it passes, work on its loops, an ender it reaches later) are in the route
// (data/route-fixes.json, overrides.include, "Quest volume"). Each is taken in the guide named here and
// handed in there or in a guide after it in the chain; ALLIANCE_VOLUME_HANDIN lists the hand-ins of quests
// taken in an earlier guide.

const ALLIANCE_VOLUME = {
	'forever/alliance/02-westfall.guide': [6281, 6261, 6285, 97894], // Continue to Stormwind; Dungar Longdrink; Return to Lewis; Business in Auberdine
	'forever/alliance/04-redridge-mountains.guide': [163, 5], // Raven Hill; Jitters' Growling Gut
	'forever/alliance/06-wetlands.guide': [469], // Daily Delivery
	'forever/alliance/30-40/01-hillsbrad-foothills.guide': [632, 633, 634], // The Thandol Span; The Thandol Span; Plea to the Alliance
	'forever/alliance/30-40/03-ashenvale.guide': [1319, 1320, 1132], // The Black Shield; The Black Shield (on the Theramore crossing since the 30-40 re-order); Fiora Longears
	// 40-50/07: Noggenfogger Elixir (2662) left out in the level tidy 0.4.0 with Sprinkle's Secret Ingredient (2641):
	// The Thirsty Goblin waits for the Un'Goro guide's Gadgetzan landing, after the route's last Hinterlands visit.
	'forever/alliance/dwarf/01-dun-morogh.guide': [414, 224, 267, 416, 418, 1339, 307, 1338, 6387, 6391, 6388, 6661, 6662, 399], // Stout to Kadrell; In Defense of the King's Lands; The Trogg Threat; Rat Catching; Thelsamar Blood Sausages; Mountaineer Stormpike's Task; Filthy Paws; Stormpike's Order; Honor Students; Ride to Ironforge; Gryth Thurden; Deeprun Rat Roundup; Me Brother, Nipsy; Humble Beginnings
	'forever/alliance/gnome/01-dun-morogh.guide': [414, 224, 267, 416, 418, 1339, 307, 1338, 6387, 6391, 6388, 6661, 6662, 399], // Stout to Kadrell; In Defense of the King's Lands; The Trogg Threat; Rat Catching; Thelsamar Blood Sausages; Mountaineer Stormpike's Task; Filthy Paws; Stormpike's Order; Honor Students; Ride to Ironforge; Gryth Thurden; Deeprun Rat Roundup; Me Brother, Nipsy; Humble Beginnings
	'forever/alliance/human/01-elwynn-forest.guide': [1097], // Elmore's Task
	'forever/alliance/nightelf/01-teldrassil.guide': [490, 923, 2519, 2518, 2520, 98067, 938], // Bounty: Gnarlpine Furbolg; Tumors; The Temple of the Moon; Tears of the Moon; Sathrah's Sacrifice; Eyes of the Sentinels; Mist
	'forever/alliance/nightelf/02-darkshore.guide': [399, 97220, 97222], // Humble Beginnings; Philmor's Favor; Gatehouse Goods
	'forever/alliance/skyborne/01-zephras-isle.guide': [399], // Humble Beginnings
};
const ALLIANCE_VOLUME_HANDIN = {
	'forever/alliance/02-westfall.guide': [399, 1097], // Humble Beginnings; Elmore's Task
	'forever/alliance/03-darkshore.guide': [97894], // Business in Auberdine
	'forever/alliance/30-40/05-arathi-highlands.guide': [634], // Plea to the Alliance
};

// --- Bare `complete`s away from the giver (#703): with no place of its own, a
// `complete` leads the arrow to the quest's giver (#303). For these quests the
// work is somewhere else: Coriella Calmbreeze north-west of Shen'dar Village,
// Frankal and Rutgar at Bronzebeard's Encampment while the giver is in
// Cenarion Hold, the Aged Kodos in the Kodo Graveyard. Each objective is its
// own goal with a place, before the turn-in, or the `complete` has a place
// (Ayessa Dawnsinger, as Elaadrin in the Horde guide: the data has her for
// the other faction only, so a `kill` of her reads as an elite to fight).
// (Restored after 0.4.0: the case was lost while the place records, data/places.json's 703-*, still hold.)
const AWAY_FROM_THE_GIVER = [
	[ZEPHRAS_ALLIANCE, 93461], // Welcome to Shen'dar Village
	[ZEPHRAS_ALLIANCE, 92849], // The Missing Scholar
	[ZEPHRAS_ALLIANCE, 92640], // Desperate Times
	['forever/alliance/50-60/06-silithus.guide', 8304], // Dearest Natalia
	['forever/alliance/30-40/02-desolace.guide', 5561], // Kodo Roundup
	[MULGORE, 833], // A Sacred Burial
];

// The offer audit (#1116): Glorin Steelbrow offers Lightforge Ingots only after
// The Lost Ingots (324), which the 20-30 route never does, and our data had
// made it exclusive with 324 instead. Calor (#1114) offers Worgen in the Woods
// from level 23, a level above where the route reaches Darkshire.
test('Offer audit (#1116, #1114): Lightforge Ingots only after The Lost Ingots, and a level 23 gate before Worgen in the Woods', { skip }, () => {
	for (const guide of [ASHENVALE, WETLANDS, THOUSAND_NEEDLES]) {
		const list = goals(guide);
		const take = list.findIndex(({ goal }) => goal.quest === 526);
		if (take < 0) continue;
		assert.ok(at(list, `${guide}: turnin 324`, is('turnin', 324)) < take, `${guide}: Lightforge Ingots comes after The Lost Ingots is handed in`);
	}
	for (const guide of [ASHENVALE, WETLANDS, THOUSAND_NEEDLES, HILLSBRAD_ALLIANCE]) {
		const list = goals(guide);
		if (list.some(({ goal }) => is('turnin', 98240)(goal))) assert.ok(list.some(({ goal }) => is('accept', 98240)(goal)), `${guide}: Crimson Crate Delivery is handed in only where it is taken`);
	}
	// Darkshire's visits open 04-redridge-mountains since the Alliance 20-30 re-order (Duskwood's first loop, then
	// Redridge's first pass): the gate and the accept are read where the accept is.
	const duskwood = ['forever/alliance/04-redridge-mountains.guide', 'forever/alliance/05-duskwood.guide'].map((g) => goals(g)).find((l) => l.some(({ goal }) => is('accept', 173)(goal)));
	const worgen = at(duskwood, 'accept 173', is('accept', 173));
	assert.ok(duskwood.slice(0, worgen).some(({ goal }) => goal.t === 'level' && goal.level >= 23), 'a level 23 gate comes before Worgen in the Woods');
	// The gate holds back only Calor's accept: it is the goal right before it, in its step, and the
	// accept comes on the second Darkshire visit (Sirra Von'Indi's hand-in), not the first.
	assert.ok(duskwood[worgen - 1].goal.t === 'level' && duskwood[worgen - 1].s === duskwood[worgen].s, 'the level 23 gate is the goal right before accept 173, in its step');
	assert.ok(at(duskwood, 'turnin 96139', is('turnin', 96139)) < worgen, 'Worgen in the Woods is taken on the second Darkshire visit');
});

// The offer audit: A Warrior's Training (1638) is open to every Alliance
// warrior, but it shares an exclusive group with Muren Stormpike, Elanaria and
// the Defensive Stance chains' first quests, and it only leads to Harry
// Burlguard, who gives Bartleby the Drunk (1639) without it (players'
// recordings: a Human and a Night Elf took 1639 straight from Harry). So the
// Dwarf, Gnome and Human warrior steps never hold Bartleby behind it, and tell
// the player to go straight to Harry if Ilsa Corbin doesn't offer it.
test('Offer audit: Bartleby the Drunk never waits on A Warrior\'s Training, and the step says to go to Harry if Ilsa doesn\'t offer it', { skip }, () => {
	for (const guide of [...DUN_MOROGHS, WESTFALL]) {
		const list = goals(guide);
		const take = at(list, `${guide}: accept 1638`, is('accept', 1638));
		const bartleby = at(list, `${guide}: accept 1639`, is('accept', 1639));
		assert.ok(!(list[bartleby].goal.pre || []).includes(1638), `${guide}: accept 1639 needs nothing before it`);
		assert.equal(list[bartleby].goal.npc, 6089, `${guide}: Bartleby the Drunk comes from Harry Burlguard`);
		assert.match(list[take].step.note || '', /If Ilsa doesn't offer A Warrior's Training, go straight to Harry/, `${guide}: the step says what to do if Ilsa doesn't offer it`);
		// Westfall's Warrior step rides the Thor flight's Old Town stop (Alliance 12-30 bracket review 0.3.6): it says where
		// Ilsa and Harry stand from Osric's shop.
		assert.match(list[take].step.note || '', guide === WESTFALL ? /near Osric's shop/ : /the tram from Ironforge arrives in the Dwarven District/, `${guide}: the step keeps its own travel line`);
	}
	// A build writes the guide-fixes record's tip over every Alliance warrior's step: it must carry the
	// Dwarf and Gnome tram line and Westfall's Old Town line (Humans land there for Osric on Thor's flight since
	// 0.3.6), so a rebuild loses neither hand fix; Westfall's step is the record's tip word for word.
	const fixes = JSON.parse(fs.readFileSync(path.join(ROOT, 'data', 'guide-fixes.json'), 'utf8')).fixes;
	const tips = fixes.filter((r) => r.at && r.at.quest === 1638 && r.at.goal === 'accept' && r.tip).map((r) => r.tip);
	assert.equal(tips.length, 1, 'one tip record for the Defensive Stance step');
	for (const want of [/the tram from Ironforge arrives in the Dwarven District/, /near Osric's shop/, /go straight to Harry/]) assert.match(tips[0], want);
	const west = goals(WESTFALL);
	assert.equal(west[at(west, 'accept 1638', is('accept', 1638))].step.note, tips[0], 'Westfall\'s step carries the record\'s tip');
});

test(`${HILLSBRAD_ALLIANCE}: Lou-Saydus's report: Nek'rosh's Gambit, taken after From the Ashes in ${WETLANDS}, is handed in on the Wetlands loop (#225)`, { skip }, () => {
	const needles = goals(WETLANDS);
	assert.equal(needles.findIndex(({ goal }) => is('turnin', 465)(goal)), -1, 'the catapult is not lit in the guide that takes the quest');
	const plans = needles.filter(({ goal }) => is('interact', 98221)(goal));
	assert.equal(plans.length, 4, 'one goal per Attack Plan (#1312)');
	assert.ok(plans.every(located), 'each attack plan has a place');
	const list = goals(HILLSBRAD_ALLIANCE);
	assert.equal(list.findIndex(({ goal }) => is('accept', 98221)(goal)), -1, 'From the Ashes is not taken again');
	at(list, 'turnin 465', is('turnin', 465));
});

// --- Quest data checked against players' recordings and EG Link (2026-11-08, 0.3.6 round 3): Kerlonian's escort ends
// at his bag in southern Darkshore, Slimy Menace's lines are Murloc x7 then Streamrunner x4, Desperate Prayer goes to
// High Priest Rohan in Ironforge, and Frostmane Hold is explored at the cave's far end.
test('round 3 data: Kerlonian ends at his bag, Slimy Menace line order, Desperate Prayer to Rohan, Frostmane Hold point', { skip }, () => {
	const ash = goals(ASHENVALE);
	const note = ash.find(({ goal }) => is('accept', 5321)(goal));
	const said = [note && note.step.note, note && note.step.tip].flat().filter(Boolean).join(' ');
	assert.ok(/southern edge of Darkshore/.test(said), 'the Kerlonian step says the escort ends at his bag in Darkshore');
	assert.ok(!/Maestra's Post in Ashenvale/.test(said), "not to Maestra's Post in Ashenvale");
	const elw = goals(ELWYNN);
	const oi = (npc) => elw.find(({ goal }) => goal.t === 'kill' && goal.quest === 99128 && goal.npc === npc).goal.oi;
	assert.deepEqual([oi(285), oi(735)], [1, 2], 'Murloc is line 1, Murloc Streamrunner line 2');
	// Fix round 2 (0.4.0): Dwarf Priests take Rohan's own copy (5639) on the Ironforge stop instead of Maxan Anvol's letter.
	const hand = goals(DUN_MOROGHS[0]).find(({ goal }) => is('turnin', 5639)(goal));
	assert.ok(hand && hand.goal.npc === 11406, 'Desperate Prayer to High Priest Rohan');
	assert.ok(!/Stormwind/.test(JSON.stringify(hand.step.zone || '')), 'in Ironforge, not Stormwind');
	for (const file of DUN_MOROGHS) {
		const go = goals(file).find(({ goal }) => goal.t === 'goto' && goal.x != null && goal.x < 24 && goal.y > 50 && goal.y < 56);
		assert.ok(go && Math.hypot(go.goal.x - 21.3, go.goal.y - 54.2) < 0.5, `${file}: the Frostmane Hold point at 21.3,54.2`);
	}
});

// --- The walk into Westfall (Pynte, #416): every start guide reaches
// Westfall on foot down the road from Elwynn, past the Jansen Stead and
// Saldean's Farm. The guide went to Sentinel Hill first and then back north
// to those farms. Their quests and Report to Gryan Stoutmantle are taken on
// the way south, so the hill is reached with them and the road in is walked
// one way; Elwynn ends at Deputy Rainer on that road, not at the hill.

test(`${WESTFALL}: Pynte's report (#416): the farm quests and Report to Gryan Stoutmantle are taken on the road in, before Sentinel Hill`, { skip }, () => {
	const list = goals(WESTFALL);
	const report = at(list, 'turnin 109', is('turnin', 109));
	const hill = list[report];
	assert.equal(hill.goal.npc, 234, 'Report to Gryan Stoutmantle is handed to Gryan');
	assert.equal(hill.step, list[at(list, "Gryan's first goal", (g) => g.npc === 234)].step, 'Report to Gryan Stoutmantle is handed in on the first Sentinel Hill stop');
	for (const q of [109, 36, 151, 64, 9, 22, 92909]) {
		// On Westfall's map: Dwarves and Gnomes take Report to Gryan Stoutmantle from Deputy Rainer at the end of east Elwynn.
		const i = at(list, `accept ${q}`, (g) => is('accept', q)(g) && g.map === hill.goal.map);
		assert.ok(i < report, `${q} is taken before Sentinel Hill`);
		assert.ok(list[i].goal.y < hill.goal.y - 10, `${q} is taken north of the hill, on the road in`);
	}
	assert.ok(at(list, 'turnin 36', is('turnin', 36)) < report && at(list, 'accept 38', is('accept', 38)) < report, 'Westfall Stew is handed to Salma on the way south');
	// The road in runs south: no step before the hill sends the arrow back north.
	const before = list.slice(0, report).filter(located).filter(everyone);
	before.forEach((g, i) => i && g.step !== before[i - 1].step && assert.ok(g.goal.y >= before[i - 1].goal.y - 3, `${g.step.title} is not north of ${before[i - 1].step.title}`));
	const elwynn = goals(ELWYNN).filter(everyone);
	const rainer = elwynn[at(elwynn, 'accept 109 from Deputy Rainer', (g) => g.t === 'accept' && g.quest === 109 && g.npc === 963)].goal;
	// Elwynn's last stop is the Westbrook Garrison on the road west (Deputy Rainer, or Sergeant De Vries beside him).
	const last = elwynn.filter(located).at(-1).goal;
	assert.ok(yards(last, rainer) < 50, `Elwynn ends by Deputy Rainer on the road west, not at the hill: ${last.t} ${last.quest} at ${last.npcName || last.npc}`);
	assert.ok(!elwynn.some(({ goal }) => goal.t === 'getfp' && goal.node === hill.step.goals.find((g) => g.t === 'getfp').node), 'Elwynn leaves the Sentinel Hill flight path to Westfall');
});

// A bare `complete` that opens its step has no place of its own and nothing
// placed before it, so the arrow showed nothing until the quest was done
// (#303's leftovers; #632 and #646 place the Horde ones). Each now leads to
// its objective: the bears, the Faulk brothers (their `use` of the Symbol of
// Life since #956). Wandering Shay (2845, Rockbiter's camp) is out of the 44 Feralas
// guide since #979: Shay wanders among the level 49 harpies, at about 44 (#977). Since
// 2026-11-08 both quests are done on the late Feralas stop (50-60/04, about 56).
test('Alliance: a quest objective that opens its step leads the arrow to the objective (#303 leftovers)', { skip }, () => {
	refData();
	const feralas = 'forever/alliance/40-50/03-feralas.guide';
	assert.ok(!goals(feralas).some(({ goal }) => goal.quest === 2845 || goal.quest === 2844), 'Wandering Shay and The Giant Guardian are out of the 44 Feralas guide');
	assert.match(fs.readFileSync(path.join(OFFICIAL_DIR, feralas), 'utf8'), /^# Left out: .*The Giant Guardian \(2844\) and Wandering Shay \(2845\) come on the later Feralas stop/m, 'the header says where they went');
	assert.ok(JSON.parse(fs.readFileSync(path.join(ROOT, 'data', 'route-fixes.json'), 'utf8')).overrides.include.some((s) => s.q === 2845 && /harpies|Giant Guardian/.test(s.reason)), 'the route fixes take Wandering Shay on the later stop, saying why');
	const late = goals('forever/alliance/50-60/04-western-plaguelands.guide');
	assert.ok(late.some(({ goal }) => goal.t === 'turnin' && goal.quest === 2845), 'Wandering Shay is handed in on the late Feralas stop');
	const work = (quest) => (g) => g.quest === quest && ['complete', 'use'].includes(g.t);
	for (const [file, quest, target] of [
		['forever/alliance/03-darkshore.guide', 2118, { npc: 2164 }], // Plagued Lands: Rabid Thistle Bears
		[DWARF_DUN_MOROGH, 1783, { npc: 6177 }], // The Tome of Divinity: Narm Faulk
		[REDRIDGE, 1786, { npc: 6172 }], // The Tome of Divinity: Henze Faulk, on the road east to Redridge
	]) {
		const list = goals(file);
		const { goal } = list[at(list, `the objective of ${quest}`, work(quest))];
		assert.ok(located({ goal }), `${file}: ${goal.t} ${quest} has a place for the arrow`);
		const places = target.npc
			? refData().npcs[target.npc].spawns[goal.map].pts.map(([x, y]) => ({ map: goal.map, x, y }))
			: refData().quests[target.event].objectives.filter((o) => o.type === 'event').map((o) => ({ map: o.map, x: o.x, y: o.y }));
		const near = Math.min(...places.map((p) => yards(goal, p)));
		assert.ok(near < 30, `${file}: ${goal.t} ${quest} leads to its objective (${near.toFixed(0)} yd away)`);
	}
});

// Dingus's report (#844): Josetta does not offer Desperate Prayer to Human priests; they take Divine Grace.
test(`${ELWYNN}: no Desperate Prayer for a Human priest (#844)`, { skip }, () => {
	for (const g of [ELWYNN, 'forever/alliance/02-westfall.guide']) {
		const list = goals(g).filter(forClass('PRIEST'));
		assert.equal(list.findIndex(({ goal }) => goal.quest === 5635), -1, `${g}: no 5635`);
	}
	assert.ok(goals(ELWYNN).filter(forClass('PRIEST')).some(({ goal }) => is('accept', 94774)(goal)), 'Divine Grace is still taken from Josetta');
});

// Fitz's in-game check (2026-11-06): Wizbang Cranktoggle (Buzzbox 827) stands
// upstairs in Auberdine's inn; the arrow has no height and counted the ground
// floor as arrived. The step that offers his quest says he is upstairs, and his
// goal keeps the upper floor's height.
test("Fitz's in-game check (2026-11-06): Darkshore's step offering Buzzbox 827 says Wizbang Cranktoggle is upstairs in the inn", { skip: skip || needs('spawnz.json') }, () => {
	for (const guide of [DARKSHORE, 'forever/alliance/nightelf/02-darkshore.guide']) {
		const step = compiled(guide).steps.find((st) => st.goals.some((g) => g.t === 'accept' && g.quest === 983));
		assert.ok(step, `${guide}: Buzzbox 827 is offered`);
		const tip = [].concat(step.note || []).join(' ');
		assert.match(tip, /Wizbang Cranktoggle stands upstairs in the inn/, `${guide}: ${tip}`);
		assert.match(tip, /The boat docks west of the village/, `${guide}: the old tip is kept`);
		const goal = step.goals.find((g) => g.t === 'accept' && g.quest === 983);
		assert.ok(Math.abs(goal.z - 24) < 3, `${guide}: z ${goal.z} is the inn's upper floor`);
	}
});

// Final route review 0.3.6 (Alliance 40-60): a class's walk to a hand-in of a class quest carried from an earlier
// guide sent every player of that class there, with or without the quest (a Warrior without The Islander to Fray
// Island, a Warlock without Summon Felsteed to Ratchet, Priests and Mages across Azshara). Each such walk waits
// for the quest in the log.
test('Alliance 40-60: a class walk to a carried class quest waits for that quest in the log', { skip }, () => {
	for (const [guide, quest] of [
		['forever/alliance/40-50/01-stranglethorn-vale.guide', 1718],
		['forever/alliance/40-50/02-badlands.guide', 4488],
		['forever/alliance/50-60/01-burning-steppes.guide', 8254],
		['forever/alliance/50-60/01-burning-steppes.guide', 8255],
		['forever/alliance/50-60/01-burning-steppes.guide', 8251],
	]) {
		const steps = compiled(guide).steps;
		const hand = steps.findIndex((st) => st.goals.some(is('turnin', quest)));
		assert.ok(hand > 0, `${guide}: turnin ${quest} is in the guide`);
		let k = hand - 1;
		const walks = [];
		while (k >= 0 && steps[k].only && steps[k].goals.length && steps[k].goals.every((g) => g.t === 'goto')) walks.push(steps[k--]);
		assert.ok(walks.length > 0, `${guide}: a class walk leads to turnin ${quest}`);
		for (const st of walks) assert.ok((st.when || []).some((p) => p.k === 'onquest' && !p.neg && [].concat(p.q).includes(quest)), `${guide}: "${st.title}" waits for ${quest} in the log`);
	}
});

// Final route review 0.3.6 (Alliance 40-60, with the Horde reviewer): objectives the game credits as a "kill" of a
// friendly NPC you only listen to or question read "Kill Velarok Windblade", "Kill Tirion Fordring". They are talk
// goals now; the ones done with Umi's Mechanical Yeti say so, as Quixxil's already did.
test('Alliance 40-60: listening and questioning are talk goals, the yeti scares say what they are', { skip }, () => {
	const listen = [
		['forever/alliance/40-50/06-searing-gorge.guide', 8436, 3377],
		['forever/alliance/40-50/06-searing-gorge.guide', 8479, 3441],
		['forever/alliance/50-60/01-burning-steppes.guide', 8879, 3702],
		['forever/alliance/50-60/04-western-plaguelands.guide', 1855, 5742],
		['forever/alliance/50-60/06-silithus.guide', 15171, 8304],
		['forever/alliance/50-60/06-silithus.guide', 15170, 8304],
	];
	for (const [guide, npc, quest] of listen) {
		const list = goals(guide);
		at(list, `${guide}: talk ${npc} for ${quest}`, (g) => g.t === 'talk' && g.npc === npc && g.quest === quest);
		assert.ok(!list.some(({ goal }) => goal.t === 'kill' && goal.npc === npc), `${guide}: no "Kill" of ${npc}`);
	}
	for (const [file, npc] of [['alliance/50-60/03-winterspring', 10978], ['alliance/50-60/04-western-plaguelands', 7583]]) {
		const text = fs.readFileSync(path.join(OFFICIAL_DIR, 'forever', `${file}.guide`), 'utf8');
		assert.match(text, new RegExp(`kill ${npc} quest 5163\\.\\d[^\\n]*"Scare [^"]+ with Umi's Mechanical Yeti"`), `${file}: the scare of ${npc} says what it is`);
	}
});

// Final route review 0.3.6 (Alliance 40-60): tips that sent the player the wrong way or to the wrong place. Linken
// stands in Marshal's Refuge (npc 8737 at 44.66,8.1), not by the tar pits west of it; the Hive'Ashi tower is in
// Southwind Village, south-west of Layo Starstrike, not east; A-Me 01 (67.7,16.8) is east of the northern pylon (since
// the 0.4.0 fix round, A-Me 01 is found on the Western Plaguelands guide's Un'Goro visit, right after that pylon).
// Cortello's scroll (object 2554) lies inside one of the three Bloodsail ships among 42-45 crews at about level 42:
// optional, as on the Horde side, under its own title instead of "The Bloodsail captains", who come at 48.
test('Alliance 40-60: tips point the right way (Linken, the Hive\'Ashi tower, A-Me 01, Cortello\'s scroll)', { skip }, () => {
	const tipOf = (guide, pred) => {
		const list = goals(guide);
		return [].concat(list[at(list, guide, pred)].step.note || []).join(' ');
	};
	const wpl = 'forever/alliance/50-60/04-western-plaguelands.guide';
	const linken = tipOf(wpl, is('turnin', 3914));
	assert.match(linken, /back of the refuge/);
	assert.doesNotMatch(linken, /Tar Pits/);
	assert.match(tipOf(wpl, (g) => g.t === 'collect' && g.item === 17346), /south-west/);
	const wplList = goals(wpl);
	const ame = wplList[at(wplList, 'turnin 4243', is('turnin', 4243))];
	assert.match([].concat(ame.step.note || []).join(' '), /^Ride east/);
	assert.equal(ame.s, wplList[at(wplList, 'the Northern Pylon', (g) => g.quest === 4285 && g.t === 'interact')].s + 1, 'A-Me 01 right after the northern pylon');
	const stv = goals('forever/alliance/40-50/01-stranglethorn-vale.guide');
	const scroll = stv[at(stv, 'accept 624', is('accept', 624))];
	assert.ok(scroll.goal.optional, '624 optional');
	assert.doesNotMatch(scroll.step.title, /captains/);
	assert.doesNotMatch([].concat(scroll.step.note || []).join(' '), /wreck by the shore/);
});

// Final route review 0.3.6 (Alliance 40-60): two travel labels still read a bare zone name (#1450 gave the rest the
// place they lead to), and a bind's note said "the last guide binds here" where the last guide binds in Stormwind.
test('Alliance 40-60: travel labels name the place, bind notes do not claim an earlier bind', () => {
	const dir = path.join(OFFICIAL_DIR, 'forever', 'alliance');
	const files = ['40-50', '50-60'].flatMap((band) => fs.readdirSync(path.join(dir, band)).filter((f) => f.endsWith('.guide')).map((f) => path.join(dir, band, f)));
	const zones = new Set(files.flatMap((f) => [...fs.readFileSync(f, 'utf8').matchAll(/^\s*zone (.+)$/gm)].map((m) => m[1].trim())));
	for (const file of files) {
		const text = fs.readFileSync(file, 'utf8');
		for (const m of text.matchAll(/^\s*goto [\d.,]+(?: map \d+)? "([^"]+)"/gm)) assert.ok(!zones.has(m[1]), `${path.basename(file)}: goto labelled "${m[1]}", a zone`);
		assert.doesNotMatch(text, /the last guide binds here/, `${path.basename(file)}: no "the last guide binds here"`);
	}
});

// Final route review 0.3.6 (Alliance 48-52, from the Horde 1-30 reviewer's sweep of accepts waiting on a mob's drop):
// The Horn of the Beast (3181) starts from Margol the Rager's horn, on a step only players who chose the group quest
// see (all-optional goals there would leave them without an arrow, lint). The Burning Steppes guide's walk to
// Mountaineer Pebblebitty in Loch Modan waits for 3181 in the log, so a grouped player who never got the horn
// is not sent there.
test('Alliance 48-52: the walk to Pebblebitty only with The Horn of the Beast in the log', { skip }, () => {
	const sg = goals('forever/alliance/40-50/06-searing-gorge.guide');
	assert.ok((sg[at(sg, 'accept 3181', is('accept', 3181))].step.when || []).some((p) => p.k === 'group' && !p.neg), '3181 is a group quest');
	const steps = compiled('forever/alliance/50-60/01-burning-steppes.guide').steps;
	const hand = steps.findIndex((st) => st.goals.some(is('turnin', 3181)));
	assert.ok(hand > 0 && steps[hand - 1].goals.every((g) => g.t === 'goto'), 'a walk leads to Pebblebitty');
	assert.ok((steps[hand - 1].when || []).some((p) => p.k === 'onquest' && !p.neg && [].concat(p.q).includes(3181)), 'the walk waits for 3181 in the log');
});

// #1550: the ore is mined with Mining 75 or obtained from another player, not looted from kobolds.
// These generated guides pick up the checkout records on the maintainer's next Forge build.
test("Fyurie's report (#1550): Favor for Krazek never holds the route, while Myzrael still does", { skip }, () => {
	const guides = [
		'forever/alliance/30-40/04b-stranglethorn-vale.guide',
		'forever/alliance/30-40/05-arathi-highlands.guide',
		'forever/alliance/40-50/01-stranglethorn-vale.guide',
	];
	for (const guide of guides) {
		const krazek = goals(guide).filter(({ goal }) => goal.quest === 627);
		assert.ok(krazek.length, `${guide}: Favor for Krazek remains available`);
		assert.ok(krazek.every(({ goal }) => goal.optional), `${guide}: taking, collecting and handing in the ore never hold the route`);
	}
	const gorge = goals(guides[1]);
	const ore = gorge.find(({ goal }) => goal.t === 'collect' && goal.item === 4278 && goal.quest === 627);
	const motes = gorge.find(({ goal }) => goal.t === 'collect' && goal.item === 4435 && goal.quest === 642);
	assert.ok(ore && motes && ore.s === motes.s, 'ore and motes stay on the same gorge visit');
	assert.ok(!motes.goal.optional, 'collecting the Motes of Myzrael still holds the step');
});

// --- Alliance 20-30 re-order (Fitz, 2026-11-07: "Grinding from 21 to 23 purely sounds ridiculous"). The
// order the zones' quest levels fit: Ashenvale & Stonetalon 20-23, Wetlands 23, Duskwood & Redridge
// together 23-27, Wetlands 27-28, Ashenvale 28-29, then the Duskwood return at 29. Ashenvale's 27-32 quests now follow the 27-29 Wetlands visit by boat from Menethil (they were in
// 30-40/03 at 33-34), Making Do goes to Thundris on that trip, Pilot Longbeard comes after them with no
// top-up to 28, and the Thandol Span chain is worked on 30-40/01's Dun Modr visit instead of a walk back
// onto the span from 30-40/05 at 37-39.
test('Alliance 20-30 re-order: Wetlands 27-29 then Ashenvale 29-30 in 06-wetlands, Menethil and Stormwind in one pass each', { skip }, () => {
	const wet = goals(WETLANDS);
	const idx = (what, t, q) => at(wet, what, is(t, q));
	const ashes = idx('turnin 98221 (From the Ashes)', 'turnin', 98221);
	const making = idx('turnin 97926 (Making Do)', 'turnin', 97926);
	const shindrell = idx('accept 4581', 'accept', 4581);
	const branch = idx('turnin 1031', 'turnin', 1031);
	const pilot = idx('accept 1179', 'accept', 1179);
	assert.ok(ashes < making && making < shindrell && shindrell < branch && branch < pilot, 'Menethil, Thundris, Ashenvale, then Pilot Longbeard');
	// From the Ashes is taken with War Banners, its plans on the walk east from the dig, both handed in on one stop.
	const takeAshes = idx('accept 98221', 'accept', 98221);
	assert.equal(wet[takeAshes].s, wet[idx('accept 464', 'accept', 464)].s, 'From the Ashes taken with War Banners');
	assert.ok(idx('interact 98221 (plans)', 'interact', 98221) < idx('turnin 277 (Rethiel)', 'turnin', 277), 'the plans on the walk east, before Rethiel');
	assert.equal(wet[ashes].s, wet[idx('turnin 464', 'turnin', 464)].s, 'War Banners and From the Ashes handed in on one stop');
	assert.equal(wet[ashes].s, wet[idx('accept 465', 'accept', 465)].s, "and Nek'rosh's Gambit taken there");
	// Claws from the Deep and Spoils of War go in on 06-ashenvale's last Menethil stop, not on walks back for one hand-in.
	const low = goals(ASHENVALE);
	const lowIdx = (what, t, q) => at(low, what, is(t, q));
	for (const q of [279, 98197]) assert.equal(low[lowIdx(`turnin ${q}`, 'turnin', q)].s, low[lowIdx('turnin 484', 'turnin', 484)].s, `${q} handed in with the other Menethil hand-ins`);
	for (const q of [1026, 1035, 1046, 1022, 1140]) assert.ok(wet.some(({ goal }) => goal.t === 'turnin' && goal.quest === q), `${q} is handed in on the Ashenvale trip`);
	// The only written top-up is the fresh starter's (`when level<28`, Alliance 20-30 audit): the route player never stops.
	assert.ok(!wet.some(({ step, goal }) => goal.t === 'level' && !(step.when || []).some((p) => p.k === 'level')), 'no top-up the route player stops for in 06-wetlands');
	assert.ok(!wet.some(({ goal }) => goal.quest === 526), 'Lightforge Ingots (526, needs 324) is not taken at 27');
	const late = goals(ASHENVALE_30);
	assert.ok(!late.some(({ goal }) => [1026, 1035, 1046, 1022, 1140, 1031].includes(goal.quest)), '30-40/03 no longer carries the Ashenvale quests');
	const hills = goals(HILLSBRAD_ALLIANCE);
	assert.ok(!hills.some(({ goal }) => goal.quest === 97926), 'Thundris is not visited again for Making Do');
	// Level tidy 0.4.0: Lifting the Curse's chain (290 -> 292 -> 293) left 06-wetlands (Captain Halyndor 30 at a player's
	// 28) for 30-40/01's Menethil stop at about 31, which hands Cleansing the Eye to Benedictus on its own Stormwind stop.
	assert.ok(!wet.some(({ goal }) => [290, 292, 293].includes(goal.quest)), 'Lifting the Curse and its follow-ups are not in 06-wetlands');
});

// Town visits for one quest (2026-11-07, Alliance 20-30): Volcor's escort went to Auberdine on a walk north and back
// south for Kerlonian, Fall of Dun Modr took a walk north to Dun Modr and back, Astranaar had a stop for three hand-ins
// between two others, Ormer's dig a stop for one hand-in, and Lakeshire a stop for Keeshan after the other hand-ins.
test('Alliance 20-30: no town stop for one quest where the route comes back anyway', { skip }, () => {
	const dark = darkshoreBoth();
	assert.ok(!dark.filter(forClass('WARRIOR')).some(({ goal }) => goal.t === 'turnin' && goal.quest === 994), 'Volcor\'s escort is not taken back to Auberdine from Darkshore (Druids excepted)');
	const wet = goals(WETLANDS);
	const wetStep = (t, q) => wet[at(wet, `${t} ${q}`, is(t, q))].s;
	assert.ok(wet.some(({ goal }) => is('turnin', 994)(goal)), 'Volcor\'s escort to Terenthis on the Auberdine stop');
	// #1415: Selarin offers Trek to Ashenvale with no escort done (recordings: 17 people at 15-22), so it is taken on
	// 03-darkshore-return's first Auberdine stop and handed to Raene on 06-ashenvale's first Astranaar stop.
	// (06-wetlands keeps a hand-in to Raene only for a character still carrying it, `when onquest`, Alliance 20-30 audit.)
	// #1811: a player who missed Selarin there (she comes only for a few minutes) gets her offer again right after their
	// own escort hand-in to Terenthis; that optional accept is the only other 990 goal before Raene's `when onquest` step.
	assert.ok(!wet.some(({ step, goal, s }) => goal.quest === 990 && !(step.when || []).some((p) => p.k === 'onquest' && !p.neg) && !(goal.t === 'accept' && goal.optional && wet.some((e) => e.s === s && e.goal.t === 'turnin' && e.goal.quest === 994))), 'Trek to Ashenvale is no longer carried to 28');
	const dret = goals(DARKSHORE_RETURN);
	assert.equal(dret[at(dret, 'accept 990', is('accept', 990))].s, 1, 'taken on the first Auberdine stop of 03-darkshore-return');
	const ash0 = goals(ASHENVALE);
	assert.ok(!ash0[at(ash0, 'turnin 990', is('turnin', 990))].goal.only, 'handed to Raene by everyone on 06-ashenvale');
	assert.ok(!wet.some(({ goal }) => goal.t === 'turnin' && goal.quest === 472), 'Fall of Dun Modr is handed in on 30-40/01\'s Dun Modr stop');
	const hills = goals(HILLSBRAD_ALLIANCE);
	assert.ok(hills.some(({ goal }) => goal.t === 'turnin' && goal.quest === 472), 'Longbraid takes it there');
	// #1415 (flow audit: passed enders at 11-22 yd): Fallen Sky Lake and the Gleaming Crescent Necklace are done before
	// the Astranaar stop for Raene's next part (1029 -> 1030), so they go in there, not on the last stop.
	for (const q of [1035, 98027]) assert.equal(wetStep('turnin', q), wetStep('turnin', 1029), `${q} handed in on the Astranaar stop of 1029`);
	assert.ok(wetStep('turnin', 1029) < wetStep('accept', 1045) && wetStep('accept', 1045) < wetStep('turnin', 1046), 'two Astranaar stops: before Krolg and at the end of the Ashenvale trip');
	const ash = goals(ASHENVALE);
	const ashStep = (t, q) => ash[at(ash, `${t} ${q}`, is(t, q))].s;
	// Alliance 12-30 bracket review 0.3.6: the walk back west to Ilkrud runs through Astranaar, so Pelturas's ready hand-in
	// goes in on that pass; the last stop, needed anyway for the flight, is Shindrell's alone.
	assert.ok(ashStep('turnin', 1034) > ashStep('turnin', 1024) && ashStep('turnin', 1034) < ash[at(ash, 'collect 5533 (Ilkrud)', (g) => g.t === 'collect' && g.item === 5533)].s, '1034 handed in on the pass through Astranaar between Shael\'dryn and Ilkrud');
	// Level tidy 0.4.0: the Foulweald's Den Watcher and Ursas (24-25) and Dal Bloodclaw (25) were 2 over players here
	// (recordings: 25th percentile 23.3-23.5). Raene gives both on 06-wetlands' Astranaar stop for 1029 at about 29: the
	// Foulweald on the way to Krolg, Dal on the way back from Maestra's Post, both handed in with 1046.
	assert.ok(!ash.some(({ goal }) => [1025, 1054].includes(goal.quest)), 'An Aggressive Defense and Culling the Threat are not in 06-ashenvale');
	for (const q of [1025, 1054]) {
		assert.equal(wetStep('accept', q), wetStep('turnin', 1029), `${q} taken on Raene's 1029 stop`);
		assert.equal(wetStep('turnin', q), wetStep('turnin', 1046), `${q} handed in with 1046 on the last Astranaar stop`);
	}
	assert.ok(wetStep('turnin', 1029) < wet[at(wet, 'Foulweald kills', (g) => g.t === 'kill' && g.quest === 1025)].s && wet[at(wet, 'Foulweald kills', (g) => g.t === 'kill' && g.quest === 1025)].s < wetStep('turnin', 1030), 'the Foulweald on the way to Krolg');
	assert.ok(wetStep('turnin', 1140) < wet[at(wet, 'Dal Bloodclaw', (g) => g.t === 'collect' && g.item === 5544)].s, 'Dal Bloodclaw after Maestra\'s Post');
	assert.ok(ashStep('turnin', 1008) > ash[at(ash, 'collect 5490 (Wrathtail Heads)', (g) => g.t === 'collect' && g.item === 5490)].s, 'The Zoram Strand handed to Shindrell on the last stop, by the flight master');
	assert.equal(ashStep('turnin', 294), ashStep('accept', 295), 'Ormer\'s second quest taken with the first hand-in');
	assert.ok(!ash.some(({ goal }) => goal.quest === 343), 'no walk into Stormwind Keep for Speaking of Fortitude');
	const red = goals('forever/alliance/04-redridge-mountains.guide');
	const redStep = (t, q) => red[at(red, `${t} ${q}`, is(t, q))].s;
	assert.equal(redStep('turnin', 219), redStep('turnin', 20), 'Keeshan and the rest of Lakeshire\'s hand-ins on one stop');
	assert.ok(red.some(({ goal }) => is('turnin', 34)(goal)) && !red.some(({ goal }) => goal.quest === 130), 'Bellygrub to Martie at 24; her own errand was done at 20 (03-loch-modan)');
});

// Flow review (2026-11-07): Alliance Stranglethorn 40-50 flew in to Darkshire 60 yards from Watchmaster Sorigal with
// Vital Supplies and carried it to the next guide, whose Darkshire stop then took the Crate of Power Stones about
// thirty steps before Nethergarde Keep: the crate lasts an hour.
test('forever/alliance/40-50: flow re-order: Vital Supplies handed in at Darkshire on the way into the swamp, the crate taken on the way to Nethergarde', { skip }, () => {
	const stv = goals('forever/alliance/40-50/01-stranglethorn-vale.guide');
	const s = (list, t, q) => list[at(list, `${t} ${q}`, is(t, q))].s;
	assert.ok(s(stv, 'turnin', 1477) < s(stv, 'accept', 1398), 'handed to Sorigal before Watcher Biggs');
	const hin = goals('forever/alliance/40-50/05-the-hinterlands.guide');
	assert.ok(!hin.some(({ goal }) => is('turnin', 1477)(goal)), 'not carried into the next guide');
	const accept = s(hin, 'accept', 1395);
	// Since the 0.4.0 audit (B26) Darnassus closes the Tanaris guide, before the Hinterlands guide.
	assert.ok(goals('forever/alliance/40-50/04-tanaris.guide').some(({ goal }) => is('turnin', 3763)(goal)), 'Darnassus before this guide');
	assert.ok(s(hin, 'turnin', 1395) - accept <= 4, 'the crate straight to Nethergarde Keep');
});

// Final route review, Alliance 40-60: the pylon loop clockwise as the seed has it (the order crossed the crater from
// the north-east to the south-west and back east); Ironforge round the ring: Tymor before Archesonus. Since the 0.4.0
// fix round the pylons and the expedition's crate, hive and bones are worked on the Western Plaguelands guide's Un'Goro
// visit (about 57; their mobs are 51-55): the loop runs one way round there.
test("forever/alliance/40-50/07-un-goro-crater.guide: final review: the pylon loop one way round, Ironforge in walking order", { skip }, () => {
	const first = goals('forever/alliance/40-50/07-un-goro-crater.guide');
	assert.ok(!first.some(({ goal }) => [4287, 4288, 3881, 3882, 3883].includes(goal.quest)), 'no pylon or expedition work on the first visit');
	const list = goals('forever/alliance/50-60/04-western-plaguelands.guide');
	const stepOf = (what, pred) => list[at(list, what, pred)].s;
	const loop = [
		stepOf('the crate', (g) => g.t === 'collect' && g.quest === 3881 && g.item === 11113),
		stepOf('the Eastern Pylon', (g) => g.quest === 4287 && g.t !== 'accept' && g.t !== 'turnin'),
		stepOf('the hive wall', (g) => g.t === 'collect' && g.quest === 3883),
		stepOf('the bones', (g) => g.t === 'collect' && g.quest === 3882),
		stepOf('the Western Pylon', (g) => g.quest === 4288 && g.t !== 'accept' && g.t !== 'turnin'),
	];
	assert.deepEqual([...loop].sort((a, b) => a - b), loop, 'east side, south, south-west, west');
	// Archesonus' The Smoldering Ruins of Thaurissan is taken on the Ironforge stop before the Burning Steppes since the
	// Alliance 40-60 order (#1228): Tymor's hand-in first there.
	const bs = goals('forever/alliance/50-60/01-burning-steppes.guide');
	assert.ok(at(bs, 'turnin 3461', is('turnin', 3461)) < at(bs, 'accept 3702', is('accept', 3702)), 'Tymor before Archesonus');
});
// Final route review, 30-40 (2026-11-07): Alliance Badlands 30-40 gathered the buzzard wings, then walked past Rigglefuzz
// from the Ancient Chest to Theldurin; he waited for the 40-50 Badlands guide. (Martek's Indurium is left out with
// Martek the Exiled, which Fizzle never offers on the route: Hardened Shells is skipped.)
test('forever/alliance/30-40/06-badlands.guide: final review: Rigglefuzz on the walk from the Ancient Chest to Theldurin', { skip }, () => {
	const list = goals('forever/alliance/30-40/06-badlands.guide');
	const chest = at(list, 'collect 4631', (g) => g.t === 'collect' && g.item === 4631);
	const theldurin = at(list, 'turnin 709', is('turnin', 709));
	for (const q of [703]) {
		const i = at(list, `turnin ${q}`, is('turnin', q));
		assert.ok(chest < i && i < theldurin, `turnin ${q} between the chest and Theldurin`);
	}
	assert.ok(!goals('forever/alliance/40-50/02-badlands.guide').some(({ goal }) => is('turnin', 1108)(goal) || is('turnin', 703)(goal)), 'not carried to 40-50');
});

// --- Alliance 30-40 re-order (2026-11-07, zone order the quest levels fit): Wetlands & Hillsbrad 30-32, then one
// crossing to Theramore for the Mirage Raceway and the Shady Rest quests (33-34; the Raceway was a crossing of its own
// at 30 in 07-thousand-needles), Stranglethorn's first loop, Desolace's first visit (it was at 32, where the route
// grinded for The Karnitol Shipwreck), Stranglethorn's northern loop (04b), then the Swamp of Sorrows, Arathi &
// Alterac and the Badlands with Desolace's south loop. High accepts wait for the visit that works them.
test('Alliance 30-40 re-order: the Mirage Raceway on the Theramore crossing, Desolace between the Stranglethorn loops, no early accepts of high quests', { skip }, () => {
	const chain = ['07-thousand-needles', '30-40/01-hillsbrad-foothills', '30-40/03-ashenvale', '30-40/04-stranglethorn-vale', '30-40/02-desolace', '30-40/04b-stranglethorn-vale', '30-40/05-arathi-highlands', '30-40/06-badlands', '30-40/06b-desolace', '40-50/01-stranglethorn-vale'];
	for (let i = 0; i + 1 < chain.length; i++) assert.equal(compiled(`forever/alliance/${chain[i]}.guide`).next, `forever/alliance/${chain[i + 1]}`, `${chain[i]} leads to ${chain[i + 1]}`);
	const dust = goals('forever/alliance/30-40/03-ashenvale.guide');
	for (const q of [1302, 1264, 1284, 1253, 1319, 1320, 1110, 1104, 1105, 1176, 1135]) assert.ok(dust.some(({ goal }) => is('turnin', q)(goal)), `30-40/03 hands in ${q}`);
	assert.ok(!dust.some(({ goal }) => goal.quest === 1175), 'A Bump in the Road\'s Saltstone Gazers (34-35) are left out at 32-33 (level tidy)');
	assert.equal(dust.filter(({ goal }) => goal.t === 'goto' && /Boat to/.test(goal.text || goal.location || '')).length, 2, 'one crossing: the boat there and the boat back');
	assert.ok(!goals(THOUSAND_NEEDLES).some(({ goal }) => [1110, 1104, 1179, 5762, 1106].includes(goal.quest)), '07 no longer crosses to the Mirage Raceway');
	// Martek the Exiled (1106) needs both 1104 and 1105 handed in (preAll): taken after them at the Raceway, worked in
	// the Badlands at the end of 30-40, and News for Fizzle (1137) handed in on 40-50/04's Raceway stop.
	assert.ok(at(dust, 'turnin 1105', is('turnin', 1105)) < at(dust, 'accept 1106', is('accept', 1106)) && at(dust, 'turnin 1104', is('turnin', 1104)) < at(dust, 'accept 1106', is('accept', 1106)), 'Martek the Exiled after Salt Flat Venom and Hardened Shells');
	const bad = goals(BADLANDS);
	const badStep = (t, q) => bad[at(bad, `${t} ${q}`, is(t, q))].s;
	assert.equal(badStep('turnin', 1106), badStep('accept', 703), 'Martek on the first Valley of Fangs stop, with Rigglefuzz');
	assert.equal(badStep('turnin', 1108), badStep('turnin', 703), 'Indurium handed in on the second, with Rigglefuzz');
	assert.ok(goals('forever/alliance/40-50/04-tanaris.guide').some(({ goal }) => is('turnin', 1137)(goal)), 'News for Fizzle handed in at the Raceway in 40-50/04');
	const late = goals('forever/alliance/40-50/01-stranglethorn-vale.guide');
	for (const q of [1284, 1253, 1319, 1320]) assert.ok(!late.some(({ goal }) => goal.quest === q), `40-50/01 no longer carries ${q}`);
	assert.ok(late.some(({ goal }) => is('accept', 1265)(goal)), '40-50/01 takes The Missing Diplomat on at Theramore');
	// Accepts more than four levels over the quest's band wait for the visit that works them (the level model ground for them).
	// Review (0.3.6): The Karnitol Shipwreck (39) is the exception: its first two parts are a chest beside Azore's
	// tower and a talk to Kreldig, nothing to fight, so the first Desolace visit takes them; the satchel dive (1456) waits for the south loop.
	assert.ok(goals('forever/alliance/30-40/02-desolace.guide').some(({ goal }) => is('turnin', 1455)(goal)), 'The Karnitol Shipwreck\'s chest and report on the first Desolace visit');
	assert.ok(goals(DESOLACE_SOUTH).some(({ goal }) => goal.t === 'collect' && goal.quest === 1456), 'the satchel on the south loop');
	assert.ok(!goals(HILLSBRAD_ALLIANCE).some(({ goal }) => is('accept', 707)(goal)), 'Ironband Wants You! (37) is not taken at 32');
	assert.ok(goals(ARATHI).some(({ goal }) => is('accept', 707)(goal)), 'it is taken on the Ironforge stop before Loch Modan');
	assert.ok(!goals('forever/alliance/30-40/04b-stranglethorn-vale.guide').some(({ goal }) => is('accept', 209)(goal)), 'Skullsplitter Tusks (42) is not taken at 37');
	assert.ok(at(late, 'accept 209', is('accept', 209)) < at(late, 'turnin 209', is('turnin', 209)), 'it is taken in 40-50/01 before its trolls');
	for (const g of ['30-40/02-desolace', '30-40/03-ashenvale', '30-40/04b-stranglethorn-vale']) assert.deepEqual(compiled(`forever/alliance/${g}.guide`).steps.filter((st) => st.along).map((st) => st.title), [], `${g}: no along steps`);
});

for (const [guide, quests] of Object.entries(ALLIANCE_VOLUME)) test(`${guide}: Alliance quest volume: the quests on its visits are taken there and handed in`, { skip }, () => {
	const here = goals(guide);
	const later = chainFrom(guide).flatMap((g) => goals(g));
	for (const q of quests) {
		// (A quest handed in on the spot, #1699, has no accept: its direct hand-in takes it.)
		assert.ok(here.some(({ goal }) => (goal.t === 'accept' || (goal.t === 'turnin' && goal.direct)) && goal.quest === q && !goal.optional), `accept ${q} is in ${guide}`);
		assert.ok(later.some(({ goal }) => goal.t === 'turnin' && goal.quest === q && !goal.optional), `turnin ${q} is in ${guide} or a guide after it`);
	}
});

for (const [guide, quests] of Object.entries(ALLIANCE_VOLUME_HANDIN)) test(`${guide}: Alliance quest volume: the quests taken earlier in the chain are handed in here`, { skip }, () => {
	const here = goals(guide);
	for (const q of quests) assert.ok(here.some(({ goal }) => goal.t === 'turnin' && goal.quest === q && !goal.optional), `turnin ${q} is in ${guide}`);
});

test('Alliance quest volume: every added quest has its include record in the route fixes', () => {
	const inc = JSON.parse(fs.readFileSync(path.join(ROOT, 'data', 'route-fixes.json'), 'utf8')).overrides.include;
	for (const q of new Set(Object.values(ALLIANCE_VOLUME).flat())) assert.ok(inc.some((e) => e.q === q && /Quest volume/.test(e.reason)), `include ${q} is recorded`);
});

// Calor (#1114): Calor offers Worgen in the Woods from level 23; the guide asked a level 22 character for it.
test('Every Alliance route (#1114): Worgen in the Woods is accepted only behind a level 23 gate', { skip }, () => {
	const gate = ({ goal, step }) => (goal.t === 'level' && goal.level >= 23) || (step.when || []).some((p) => p.k === 'level' && !p.neg && ['>=', '>'].includes(p.op) && p.n >= 23);
	for (const { who, list } of routes('Alliance')) {
		list.forEach((e, i) => {
			if (is('accept', 173)(e.goal)) assert.ok(gate(e) || list.slice(0, i).some(gate), `${who}: ${where(e)} takes Worgen in the Woods with no level 23 gate before it`);
		});
	}
});

// Bennistrov (#1191): the guide brought a Night Elf Druid back to Astranaar from the west only to fly to
// Auberdine. A flight out of Astranaar is taken on a visit that does something there.
test('Every Alliance route (#1191): Astranaar is never walked to only for a flight out of it', { skip }, () => {
	const { point } = makeProjector(refData().mapFrames);
	const spawn = refData().spawns('npc', 4267).find((sp) => sp.map === 1440);
	const fm = point(1440, spawn.pts[0][0], spawn.pts[0][1], spawn.f === 'e' ? 'e' : 'l');
	const yd = ({ goal }) => {
		if (goal.map == null || goal.x == null) return Infinity;
		const p = point(goal.map, goal.x, goal.y, goal.f === 'e' ? 'e' : 'l');
		return p.c === fm.c ? dist(p, fm) : Infinity;
	};
	for (const { who, list } of routes('Alliance')) {
		list.forEach((e, i) => {
			if (e.goal.t !== 'fly') return;
			const before = list.slice(0, i).reverse();
			const from = before.find((x) => x.goal.map != null && x.goal.x != null);
			if (!from || yd(from) > 60) return;
			const work = before.find(({ goal }) => goal.quest != null);
			assert.ok(work && yd(work) <= 250, `${who}: ${where(e)} flies out of Astranaar after walking there from ${work ? where(work) : 'nowhere'} (${work ? Math.round(yd(work)) : '?'} yd away) with nothing done in it`);
		});
	}
});

// Fyurie (#977): Redridge "suddenly jumped from level 20/21 mobs to Fangore and a bunch of 24-25 mobs".
// WANTED: Lieutenant Fangore (Fangore 26) and Solomon's Law (Shadowhide gnolls, a median 24) were worked at
// about 21. Work more than two levels above the player waits until the route reaches it.
test('Every Alliance route (Fyurie, #977): Fangore and the Shadowhide gnolls of Solomon\'s Law are worked only from level 22', { skip }, () => {
	const gate = ({ goal, step }) => (goal.t === 'level' && goal.level >= 22) || (step.when || []).some((p) => p.k === 'level' && !p.neg && ['>=', '>'].includes(p.op) && p.n >= 22);
	for (const { who, list } of routes('Alliance')) {
		list.forEach((e, i) => {
			if (![180, 91].includes(e.goal.quest) || !['kill', 'collect'].includes(e.goal.t)) return;
			assert.ok(compiled(e.guide).minLevel >= 22 || gate(e) || list.slice(0, i).some(gate), `${who}: ${where(e)} works ${e.goal.t} ${e.goal.quest} with nothing holding it to level 22`);
		});
	}
});

test('Wetlands (#1184, #1206): Whelgar\'s and Rethiel\'s chain quests come after the hand-in that opens them', { skip }, () => {
	const wet = goals('forever/alliance/06-wetlands.guide');
	const hb = goals('forever/alliance/30-40/01-hillsbrad-foothills.guide');
	const idx = (list, t, q) => at(list, `${t} ${q}`, (g) => g.t === t && g.quest === q);
	assert.ok(idx(wet, 'turnin', 299) < idx(wet, 'accept', 98216), 'Understanding Our Present after Uncovering the Past (#1206)');
	for (const t of ['collect', 'turnin']) {
		const g = wet.find(({ goal }) => goal.t === t && goal.quest === 98216);
		// #1415: the hand-in waits for the quest to be complete (an onquest gate held an incomplete keystone run there).
		assert.ok((g.step.when || []).some((p) => ['onquest', 'complete'].includes(p.k) && [].concat(p.q).includes(98216)), `the keystone's ${t} only with 98216 in the log`);
	}
	assert.ok(idx(wet, 'turnin', 98216) < idx(wet, 'accept', 98310), 'Gleaning Our Future after Understanding Our Present');
	assert.ok(wet[idx(wet, 'accept', 98310)].step.when.some((p) => p.k === 'turnedin' && [].concat(p.q).includes(98216)), 'Gleaning Our Future only once 98216 is handed in (98216 is optional)');
	assert.ok(idx(wet, 'turnin', 275) < idx(wet, 'accept', 98283), 'Carnage after Fen Creeper');
	assert.ok(!wet.some(({ goal }) => goal.t === 'accept' && goal.quest === 98313), 'For Further Study is not taken on the first dig visit');
	assert.ok(idx(hb, 'turnin', 98310) < idx(hb, 'accept', 98313), 'For Further Study after Gleaning Our Future');
	assert.ok(idx(hb, 'turnin', 637) < idx(hb, 'accept', 683), "Sara Balloo's Plea after Sully Balloo's Letter");
});

// --- Alliance 40-60 order (2026-11-08): a first Western Plaguelands stop at ~51 between the Hinterlands and the Burning
// Steppes, and every accept the level model ground for (a quest 5+ levels above, or under its minimum level) taken on a
// later visit to the same giver, with the work and the hand-in where the route already goes.
test('Alliance 40-60 order: the first Western Plaguelands stop before the Burning Steppes, high accepts on the later visit', { skip }, () => {
	const A = (g) => `forever/alliance/${g}.guide`;
	const bs = goals(A('50-60/01-burning-steppes'));
	const pos = (list, t, q) => at(list, `${t} ${q}`, is(t, q));
	// Fix round 2 (0.4.0): Felstone Field's cauldron (Bilemaw 53, Jabbering Ghouls 54) is taken here and done from the
	// Winterspring guide's Chillwind stop at about 55.6, before MacDonnell's next cauldron quest.
	assert.ok(pos(bs, 'accept', 5216) < pos(bs, 'accept', 3823), 'the cauldron quest taken at Chillwind Camp before Morgan\'s Vigil');
	assert.ok(!bs.some(({ goal }) => goal.quest === 5216 && goal.t !== 'accept'), 'the cauldron is not worked at 51-52');
	const ws3 = goals(A('50-60/03-winterspring'));
	assert.ok(pos(ws3, 'turnin', 5217) < pos(ws3, 'accept', 5219), 'the cauldron done from the Winterspring guide\'s Chillwind stop, before Dalson\'s Tears');
	// The Wildkin Feathers (3661) are collected in 40-50/05's Hinterlands loop since the 0.4.0 audit (B26): 01 flies
	// Ironforge -> Southshore straight to Chillwind Camp.
	assert.ok(!bs.some(({ goal }) => goal.t === 'collect' && goal.quest === 3661), 'no feather stop in the Burning Steppes guide');
	assert.ok(pos(bs, 'accept', 3702) < pos(bs, 'accept', 3823), 'Archesonus on the Ironforge stop before the Steppes');
	assert.ok(!goals(A('40-50/07-un-goro-crater')).some(({ goal }) => goal.quest === 3702 || goal.quest === 3701 || goal.quest === 4504), 'no 54s taken at 49 in Un\'Goro\'s guide');
	const wpl = goals(A('50-60/04-western-plaguelands'));
	assert.ok(pos(wpl, 'turnin', 4493) <= pos(wpl, 'accept', 4504), 'Super Sticky from Tran\'rek on the 57 Gadgetzan stop');
	// To Winterspring! (5249) is handed to Wynd Nightchaser in the 53-55 guide since the 0.4.0 audit, right before The
	// Ruins of Kel'Theril (its own case below).
	assert.ok(!goals(A('50-60/03-winterspring')).some(({ goal }) => [6604, 4861, 4863, 4864, 5281].includes(goal.quest)), 'Jaron\'s chain and The Restless Souls are not in the 53-55 Winterspring guide');
	const last = goals(A('50-60/06-silithus'));
	assert.ok(pos(last, 'turnin', 6604) < pos(last, 'turnin', 4864), 'Jaron\'s chain on the 58-59 Winterspring visit');
	assert.ok(pos(last, 'turnin', 5181) <= pos(last, 'accept', 5281), 'The Restless Souls from Caretaker Alen on the Light\'s Hope stop');
	assert.ok(pos(last, 'turnin', 5281) >= 0, 'and handed to Egan in Terrordale');
	assert.ok(!goals(A('40-50/02-badlands')).some(({ goal }) => is('accept', 2877)(goal)), 'Skulk Rock Clean-up not at 42.6');
	assert.ok(goals(A('40-50/04-tanaris')).some(({ goal }) => is('accept', 2877)(goal)), 'but on the Aerie Peak landing after Tanaris');
});

test('Alliance 40-60 order: the quests the route passes are taken (... and Bugs, the Western Plaguelands givers on the way east)', { skip }, () => {
	const A = (g) => `forever/alliance/${g}.guide`;
	const stv = goals(A('40-50/01-stranglethorn-vale'));
	assert.ok(at(stv, 'turnin 1204', is('turnin', 1204)) <= at(stv, 'accept 1258', is('accept', 1258)), '... and Bugs with Mudrock Soup');
	assert.ok(stv.some(({ goal }) => goal.t === 'collect' && goal.quest === 1258), 'the crawler legs on the Swamp of Sorrows shore');
	assert.ok(goals(A('40-50/02-badlands')).some(({ goal }) => is('turnin', 1258)(goal)), 'back to Morgan Stern at Theramore');
	const ws = goals(A('50-60/03-winterspring'));
	for (const q of [5097, 5219, 4984]) assert.ok(ws.some(({ goal }) => is('accept', q)(goal)), `${q} taken where the Winterspring guide passes its giver on the way to the Eastern Plaguelands`);
});

// --- Alliance quest volume, flow follow-up (2026-11-08): the stops the added quests cost are folded
// into walks the route makes anyway (the release audit's flow findings on the quest-volume batch).
test('Alliance quest volume follow-up: the added quests ride on walks the route already makes', { skip }, () => {
	const first = (list, pred) => list.findIndex(({ goal }) => pred(goal));
	const tel = goals('forever/alliance/nightelf/01-teldrassil.guide');
	const shayla = first(tel, is('turnin', 490));
	assert.ok(shayla > first(tel, is('turnin', 98398)) && shayla < first(tel, (g) => g.t === 'kill' && g.quest === 486), 'Teldrassil: the fang bounty is handed to Shayla on the walk south from the Oracle Glade to Ursal');
	assert.ok(first(tel, is('accept', 931)) < first(tel, (g) => g.t === 'collect' && g.quest === 2518), 'Teldrassil: the Strange Fronded Plant is taken on the walk north to Lady Sathrah');
	const owl = first(tel, (g) => g.t === 'use' && g.quest === 98067 && g.oi === 1);
	assert.ok(owl > first(tel, is('accept', 98046)) && owl < first(tel, is('turnin', 923)), 'Darnassus: the tunnel-mouth owl is placed on the walk south from the Enclave');
	const wet = goals('forever/alliance/06-wetlands.guide');
	assert.ok(first(wet, is('turnin', 469)) > first(wet, is('accept', 465)), 'Wetlands: Halloran after Stoutfist');
});

// Ingest report (2026-11-08): 7 of the 13 players who took The Family and the Fishing Pole (1141) on 0.3.4 abandoned it
// at 13-24; the accept said "only with Fishing" but was offered to everyone. It is a step of its own for characters
// with Fishing now.
test('Auberdine: The Family and the Fishing Pole is offered only to characters with Fishing', { skip }, () => {
	for (const guide of ['forever/alliance/nightelf/01-teldrassil.guide', 'forever/alliance/03-darkshore.guide']) {
		const list = goals(guide);
		const { step } = list[at(list, 'accept 1141', is('accept', 1141))];
		assert.ok((step.when || []).some((p) => p.k === 'skill' && !p.neg && /fishing/i.test(JSON.stringify(p))), `${guide}: under when skill Fishing`);
		assert.ok(step.goals.every((g) => g.quest === 1141), `${guide}: nothing else waits on the gate`);
	}
});

// Final route review before 0.3.5, Alliance 40-60: texts from an older order. Vital Supplies was "for Nethergarde
// Keep, keep it" though Watchmaster Sorigal in Darkshire takes it a few steps later; the Ironforge stop opened with
// the tram ride already taken and said the next guide flies to Thelsamar (this one does); Sigrun Ironhew's dig was two
// steps with the way in on the second; Feralas said you end at the dock with Thalanaar still to come; Felwood said
// to ride out of Astranaar on its second stop; Un'Goro's "Bind and train" binds nowhere. Since the 0.4.0 fix round
// Scrounging (733) is handed to Sigrun on 30-40/06, where it is taken (40-50/02 handed it in a second time): the
// Badlands guide's one Sigrun stop is Fiery Blaze Enchantments' accept, with the way in.
test('alliance 40-60: final review: travel tips, notes and titles match where the player is', { skip }, () => {
	const texts = ({ step, goal }) => [step.note || '', goal.note || '', goal.t === 'note' ? goal.text : ''].join(' ');
	const stv = goals('forever/alliance/40-50/01-stranglethorn-vale.guide');
	const supplies = stv[at(stv, 'accept 1477', is('accept', 1477))];
	assert.ok(stv.some(({ goal }) => goal.t === 'turnin' && goal.quest === 1477), 'Vital Supplies is handed in on this guide');
	assert.doesNotMatch(supplies.goal.note || '', /Nethergarde/, 'so it is not "for Nethergarde Keep"');
	const roetten = stv[at(stv, 'turnin 1467', is('turnin', 1467))];
	assert.doesNotMatch(roetten.step.note || '', /Tram|next guide/, 'the Ironforge stop starts in Ironforge');
	const badlands = goals('forever/alliance/40-50/02-badlands.guide');
	assert.ok(!badlands.some(({ goal }) => goal.quest === 733), 'no second Scrounging hand-in');
	const b30 = goals('forever/alliance/30-40/06-badlands.guide');
	assert.ok(at(b30, 'accept 733', is('accept', 733)) < at(b30, 'turnin 733', is('turnin', 733)), 'Scrounging taken and handed in on 30-40/06');
	const sigrun = badlands.filter(({ goal }) => goal.quest === 706 && goal.t === 'accept');
	assert.equal(sigrun.length, 1, 'one stop at Sigrun Ironhew');
	assert.match(sigrun[0].step.note || '', /Badlands/, 'with the way in');
	const feralas = goals('forever/alliance/40-50/03-feralas.guide');
	const last = feralas[at(feralas, 'turnin 4281', is('turnin', 4281))];
	assert.ok(!feralas.some((e) => e.s < last.s && /You end at/.test(texts(e))), 'no "you end here" before Thalanaar');
	const felwood = goals('forever/alliance/50-60/02-felwood.guide');
	const firstNote = felwood.find(({ step }) => step.note);
	assert.match(firstNote.step.note, /Astranaar/, 'Felwood\'s way in is on its first stop');
	assert.equal(felwood.filter(({ step }, i, a) => /Astranaar/.test(step.note || '') && (i === 0 || a[i - 1].step !== step)).length, 1, 'and only there');
	const ungoro = compiled('forever/alliance/40-50/07-un-goro-crater.guide');
	for (const step of ungoro.steps.filter((st) => /\bBind\b/.test(st.title))) assert.ok(step.goals.some((g) => g.t === 'sethome'), `"${step.title}" binds`);
});

// A step gated on a quest whose goals are all optional is done at once (the Alliance 30-40 audit's sweep): the Goaz Warders and
// Whelgar's hand-in (the elite keystone behind `when group`, the hand-in once complete), and the Gol'Bolar smith's
// hand-in (12 Copper Bars: gated on the quest being complete); Elwynn's and Zephras Isle's `when group` steps.
test('#1415: no quest- or group-gated step in the Alliance 1-30 guides is made only of optional goals', { skip }, () => {
	for (const guide of [WETLANDS, ...DUN_MOROGHS, ELWYNN, ZEPHRAS_ALLIANCE, REDRIDGE]) {
		for (const s of fs.readFileSync(path.join(OFFICIAL_DIR, guide), 'utf8').split(/\n(?=step )/)) {
			if (!/^\s+when (onquest|complete|group) \d+$/m.test(s)) continue;
			const g = s.split('\n').filter((l) => /^\s+(accept|turnin|collect|kill|interact|complete|talk|use)\b/.test(l));
			assert.ok(!g.length || g.some((l) => !/\boptional\b/.test(l)), `${guide}: ${s.split('\n')[0]} has a goal that holds it`);
		}
	}
});

test('Alliance Un\'Goro, second visit: the Scent of Lar\'korwi, the Bait and The Apes of Un\'Goro are one Torwa stop', { skip }, () => {
	const second = goals('forever/alliance/50-60/04-western-plaguelands.guide');
	const torwa = [is('turnin', 4291), is('accept', 4292), is('accept', 4289)].map((p, k) => second[at(second, `Torwa ${k}`, p)].s);
	assert.equal(new Set(torwa).size, 1, 'one stop at Torwa');
	const first = goals('forever/alliance/40-50/07-un-goro-crater.guide');
	// Since the 0.3.6 flow review 07 takes it (min level 47) and keeps it: the pelts are taken at 56 on 04's pass by
	// Ironstone Plateau, so Torwa's first stop there hands it in (see the 'gorilla pelts on the northern pass' test).
	assert.ok(first.some(({ goal }) => goal.t === 'accept' && goal.quest === 4289), '07 takes The Apes of Un\'Goro, for 56');
});

test('Alliance Winterspring and Feralas: the long top-ups are split onto the quest mobs', { skip }, () => {
	const ws = goals('forever/alliance/50-60/03-winterspring.guide');
	const k = at(ws, 'kill for 5082', (x) => x.t === 'kill' && x.quest === 5082);
	// Level tidy 0.4.0: the Frostfire camp's Den Watchers are 55-56, so the top-up on its Pathfinders (53-54) goes to 55
	// in its own step right before the kills, on the same camp.
	assert.ok(ws.some(({ goal, s }) => goal.t === 'level' && lvlOf(goal) >= 55 && goal.grind === 7442 && s === ws[k].s - 1), '03: the Frostfire top-up on the Pathfinders right before the kills for Donova');
	// Feralas: since Bennistrov's report (#1999) the level-45 grind is on the Feral Scar yetis (43-45); since the level
	// tidy (0.4.0) the Rage Scar yetis' hides (46-49) are left out (see that case).
	const fe = goals('forever/alliance/40-50/03-feralas.guide');
	assert.ok(fe.some(({ goal }) => goal.t === 'level' && goal.grind === 5292), '03-feralas: the level-45 grind on the Feral Scar yetis');
});

// Alliance 40-60 flow pass (0.3.7): quest givers and hand-ins the route walked past and came back to later.
test('forever/alliance 40-60: givers and hand-ins taken when the route passes them', { skip }, () => {
	const stv = goals('forever/alliance/40-50/01-stranglethorn-vale.guide');
	const boat = at(stv, 'the Theramore boat', (g) => g.t === 'goto' && g.x === 71.6 && g.y === 56.4);
	const vimes = at(stv, 'turnin 1287', is('turnin', 1287));
	assert.ok(vimes < boat && stv[vimes].step.only, 'Humans report to Vimes before the Theramore boat');
	const thyntel = at(stv, 'turnin 1037', is('turnin', 1037));
	assert.ok(thyntel < at(stv, 'the walk to the riding trainer', (g) => g.t === 'goto' && g.x === 38.7 && g.y === 15.8), 'Night Elves see Thyn\'tel on the way in');
	const sg = 'forever/alliance/40-50/06-searing-gorge.guide';
	assert.ok(!/Kalaran/.test(fs.readFileSync(path.join(OFFICIAL_DIR, sg), 'utf8')), 'the Searing Gorge NPC is Velarok Windblade in Forever');
	const g6 = goals(sg);
	const s6 = (what, pred) => g6[at(g6, what, pred)].s;
	assert.ok(s6('turnin 3442', is('turnin', 3442)) < s6('dagger', (g) => g.t === 'collect' && g.quest === 3443), 'the dagger is hunted with Forging the Shaft in the log');
	assert.equal(s6('turnin 3443', is('turnin', 3443)), s6('dagger', (g) => g.t === 'collect' && g.quest === 3443) + 1, 'handed in right after');
	const ws = goals('forever/alliance/50-60/03-winterspring.guide');
	assert.ok(!ws.some(({ goal }) => goal.quest === 5211), 'Corin\'s Crossing left out (level tidy 0.4.0: its Scourge are 57-60 at 55)');
	const wpl = goals('forever/alliance/50-60/04-western-plaguelands.guide');
	const sp = (what, pred) => wpl[at(wpl, what, pred)].s;
	assert.ok(sp('turnin 978', is('turnin', 978)) < sp('accept 1047', is('accept', 1047)), 'Erelas before the portal up to Darnassus');
	assert.ok(sp('turnin 1124', is('turnin', 1124)) < sp('accept 8277', is('accept', 8277)), 'Layo where the pass comes out, before Cenarion Hold');
	// Fix round 2 (0.4.0): Torrig and Larksbane are taken on the Silithus guide's first Cenarion Hold stop, a stop the
	// route makes anyway where their work and hand-ins are, instead of here: carried from here they rode through Mount
	// Hyjal, whose quest log reached 36-37 (asserted with the Silithus guide below).
	for (const q of [9415, 8284]) assert.ok(!wpl.some(({ goal }) => is('accept', q)(goal)), `${q} not carried from here`);
	// Bor Wildmane's Secret Communication (minimum level 57): the level model is just under 57 on this guide's Cenarion
	// Hold stops, so since the 0.4.0 fix round he gives it on the Silithus guide's first Cenarion Hold stop (about 58).
	assert.ok(!wpl.some(({ goal }) => goal.quest === 8318), 'no Secret Communication under level 57');
	const si = goals('forever/alliance/50-60/06-silithus.guide');
	const ss = (what, pred) => si[at(si, what, pred)].s;
	// Fix round 1 (0.4.0): the first Cenarion Hold stop of the Silithus guide is at about 58.4, over Dearest Natalia's
	// minimum (58): Mar'alith gives it there, with Beetix's and Windcaller Proudhorn's quests (the flow audit had the
	// route walk past him and come back for it).
	assert.equal(ss('accept 8304', is('accept', 8304)), ss('accept 8278', is('accept', 8278)), 'Mar\'alith on the first Cenarion Hold stop');
	assert.equal(ss('accept 8318', is('accept', 8318)), ss('accept 8278', is('accept', 8278)), 'Bor Wildmane on the first Cenarion Hold stop of the Silithus guide');
	assert.equal(ss('accept 9415', is('accept', 9415)), ss('accept 8278', is('accept', 8278)), 'Torrig on the first Cenarion Hold stop of the Silithus guide');
	assert.equal(ss('accept 8284', is('accept', 8284)), ss('accept 8278', is('accept', 8278)), 'Larksbane on the first Cenarion Hold stop of the Silithus guide');
});


// Travel sweep (0.3.6): four gotos on maps whose Era and live frames differ (Redridge, Stormwind, the Eastern
// Plaguelands) were typed with the live coordinates of their NPC but read as Era: the Lakeshire flight master
// 110 yd off (03-loch-modan, 05-duskwood), the Cathedral of Light 214 yd off (05-duskwood), Egan 219 yd off
// (50-60/06-silithus). They are marked `live`; Egan's, which then sat on Egan's own spot, is dropped: the turn-in leads there.
test('Alliance: gotos typed with an NPC\'s live coordinates are live-frame', { skip }, () => {
	const cases = [
		['forever/alliance/03-loch-modan.guide', 25.5, 59.4],
		['forever/alliance/05-duskwood.guide', 25.5, 59.4],
		['forever/alliance/05-duskwood.guide', 50.5, 47.5],
	];
	for (const [guide, x, y] of cases) {
		const hit = goals(guide).find(({ goal }) => goal.t === 'goto' && goal.x === x && goal.y === y);
		assert.ok(hit, `${guide}: goto ${x},${y}`);
		assert.notEqual(hit.goal.f, 'e', `${guide}: goto ${x},${y} is in the live frame`);
	}
	const egan = goals('forever/alliance/50-60/06-silithus.guide').find(({ goal }) => goal.t === 'goto' && goal.x === 11.4 && goal.y === 26.6);
	assert.ok(!egan || egan.goal.f !== 'e', 'no Era-read goto beside Egan');
});

// Review (0.3.6): Krolg (Raene's Cleansing 1030) only speaks to a furbolg; the step names Dartol's Rod. Pilot
// Xiggs (Arcane Runes 3449) comes on the flare gun; the step names it.
test('Ashenvale and Azshara: the Krolg and Ravencrest steps name the rod and the flare gun', { skip }, () => {
	const src = fs.readFileSync(path.join(OFFICIAL_DIR, 'forever/alliance/06-wetlands.guide'), 'utf8');
	assert.match(src, /step Krolg\n  tip [^\n]*Dartol's Rod of Transformation/);
	assert.match(fs.readFileSync(path.join(OFFICIAL_DIR, 'forever/alliance/50-60/01-burning-steppes.guide'), 'utf8'), /step Ravencrest Monument\n  tip [^\n]*Standard Issue Flare Gun/);
});

// Flow review, Alliance 49-51 (0.3.6): the Searing Gorge guide ends in Ironforge, where the Un'Goro guide's last stop
// came back for Curator Thorius (3368), Karnik/Tymor/Xiggs (3448-3451) and Laris (4512), all open at 48, after a hearth
// to Thelsamar and before Menethil, the boat and Auberdine to Astranaar. Those are now handed in and taken on the Searing
// Gorge guide's Ironforge stop, and only Priests and Mages (Cenarion Aid 8254, Magecraft 8250: level 50) still go back;
// everyone else flies from Marshal's Refuge to Astranaar and trains on the next guide's Ironforge stop.
test('Searing Gorge and Un\'Goro (Alliance 49-50): the Ironforge quests on the first Ironforge stop, a flight to Astranaar after Un\'Goro', { skip }, () => {
	const sg = goals('forever/alliance/40-50/06-searing-gorge.guide');
	const flyIF = at(sg, 'fly to Ironforge', (g) => g.t === 'fly' && g.location === 'Ironforge');
	for (const [t, q] of [['turnin', 3368], ['accept', 3448], ['accept', 4512], ['turnin', 3448], ['accept', 3449], ['turnin', 3451]]) {
		assert.ok(at(sg, `${t} ${q}`, is(t, q)) > flyIF, `${t} ${q} on the Ironforge stop`);
	}
	const ug = goals('forever/alliance/40-50/07-un-goro-crater.guide');
	assert.ok(!ug.some(({ goal }) => [3368, 3448, 3449, 3450, 3451, 4512].includes(goal.quest)), 'none left for Un\'Goro');
	const warrior = ug.filter(forClass('WARRIOR'));
	const astra = warrior.findIndex(({ goal }) => goal.t === 'fly' && goal.location === 'Astranaar');
	const refuge = warrior.findIndex(({ goal }) => goal.t === 'turnin' && goal.quest === 4321);
	assert.ok(astra > refuge, 'Warriors fly to Astranaar after the refuge');
	assert.ok(!warrior.slice(refuge, astra).some(({ goal }) => ['fly', 'hearth'].includes(goal.t) || goal.text === 'Stoutlager Inn'), 'with no hearth or Ironforge trip before it');
	const priest = ug.filter(forClass('PRIEST'));
	assert.ok(priest.some(({ goal }) => goal.t === 'accept' && goal.quest === 8254) && priest.some(({ goal }) => goal.t === 'train'), 'Priests still go to Ironforge for Cenarion Aid and train');
	const bs = goals('forever/alliance/50-60/01-burning-steppes.guide').filter(forClass('WARRIOR'));
	const train = bs.findIndex(({ goal }) => goal.t === 'train');
	assert.ok(train > bs.findIndex(({ goal }) => goal.t === 'fly' && goal.location === 'Ironforge'), 'Warriors train on the Burning Steppes guide\'s Ironforge stop');
});

// Flow review, Alliance 49/56 (0.3.6): The Apes of Un'Goro is taken on the first Torwa visit (40-50/07), the pelts on
// the second visit's pass by Ironstone Plateau next to the Northern Pylon, and it is handed in on the first Torwa stop
// there, so the guide rides to the plateau once (for U'cha), not twice. A player without 4289 still gets the pelts trip.
test('Un\'Goro (Alliance 56): the gorilla pelts on the northern pass, one ride from Torwa to the plateau', { skip }, () => {
	const first = goals('forever/alliance/40-50/07-un-goro-crater.guide');
	assert.equal(first[at(first, 'accept 4289', is('accept', 4289))].step, first[at(first, 'accept 4291', is('accept', 4291))].step, 'taken with The Scent of Lar\'korwi');
	const list = goals('forever/alliance/50-60/04-western-plaguelands.guide');
	const pelts = list.findIndex(({ goal }) => goal.t === 'collect' && goal.quest === 4289);
	assert.ok(pelts > at(list, 'pterrordax at the pylon', (g) => g.t === 'kill' && g.quest === 4501) && pelts < at(list, 'turnin 4501', is('turnin', 4501)), 'pelts between the pylon and the refuge');
	const hand = at(list, 'turnin 4289', is('turnin', 4289));
	assert.ok((list[hand].step.when || []).some((p) => p.k === 'complete' && !p.neg), 'handed in on the first Torwa stop once done');
	assert.ok(hand < at(list, 'U\'cha', (g) => g.t === 'collect' && g.quest === 4301), 'before the ride to U\'cha');
	const fallback = list.filter(({ goal, step }) => goal.t === 'collect' && goal.quest === 4289 && (step.when || []).some((p) => p.k === 'onquest' && !p.neg));
	assert.ok(fallback.length >= 6, 'both pelt steps wait for 4289 in the log');
});


// Route review (0.3.7), label vs quest levels: Un'Goro Crater is labelled 49-50 but works level 51-53
// quests (the calibrated level model: Lar'korwi, the pylons and the expedition at +3.3 to +4.0), and Stranglethorn's
// second visit 35-36 works Troll Witchery (40) at 36. The label stays the route's character level; the guide says
// up front why its quests run higher and how hard the mobs hit (as Horde Hillsbrad & Arathi).
test('Alliance Un\'Goro and Stranglethorn 35-36: the guide says why its quests run above its label', { skip }, () => {
	for (const [file, lo, hi, levels] of [
		// 0.4.0: the label follows the route's level model, arrival to exit (fix round 1: the first Un'Goro visit 49.31 ->
		// 50.40; fix round 2, the model without accept-time grinding: Stranglethorn's second visit 35.03 -> 35.90).
		['forever/alliance/40-50/07-un-goro-crater.guide', 49, 50, /51-53/],
		['forever/alliance/30-40/04b-stranglethorn-vale.guide', 35, 36, /37-38/],
	]) {
		const g = compiled(file);
		assert.deepEqual([g.minLevel, g.maxLevel], [lo, hi], `${file}: the label stays the route's character levels`);
		assert.match(g.pitch || '', levels, `${file}: the pitch names the quest levels`);
		assert.match(g.pitch || '', /one at a time/);
	}
});

// Alliance 1-12 audit (0.4.0, #2025, bind points the route never hearths back to): the Night Elves' first Auberdine
// bind (nightelf/02-darkshore) is gone. 02-westfall binds Sentinel Hill before any return to Darkshore, and
// 03-darkshore binds Auberdine itself; in players' recordings (Polestar 0.3.5 and later) 1 of 6 people who bound there
// ever hearthed back to it. Teldrassil's Dolanaar bind stays the Night Elves' bind until Sentinel Hill.
test(`${NE_DARKSHORE}: no bind before Westfall's Sentinel Hill; Teldrassil's Dolanaar bind stays`, { skip }, () => {
	assert.deepEqual(goals(NE_DARKSHORE).filter(({ goal }) => goal.t === 'sethome').map(({ goal }) => goal.location), [], 'no sethome in the Night Elf Darkshore');
	assert.ok(goals(TELDRASSIL).some(({ goal }) => goal.t === 'sethome' && goal.location === 'Dolanaar'), 'Teldrassil binds Dolanaar');
	assert.ok(goals(WESTFALL).some(({ goal }) => goal.t === 'sethome' && goal.location === 'Sentinel Hill'), 'Westfall binds Sentinel Hill');
});

// 0.4.0 route audit (Refs #2025): Alliance 30-40/06 was the Badlands and then Desolace's south loop in one guide. It is
// split at Thelsamar, where the Badlands loop ends on Ghak Healtouch's hand-in: 06-badlands, then 06b-desolace (the
// south loop, unchanged), so Riverglades can join the route there as a choice. Every quest is in one of the two guides,
// once, and the chain still reaches 40-50/01 at Theramore.
test(`${BADLANDS}: split at Thelsamar: the Badlands, then Desolace's south loop as its own guide`, { skip }, () => {
	const bad = goals(BADLANDS);
	const south = goals(DESOLACE_SOUTH);
	const last = bad[bad.length - 1];
	assert.ok(is('turnin', 2500)(last.goal), 'the Badlands guide ends on Ghak Healtouch in Thelsamar');
	assert.equal(compiled(BADLANDS).next, 'forever/alliance/30-40/06b-desolace', 'the south loop is the default next guide');
	assert.equal(compiled(DESOLACE_SOUTH).next, 'forever/alliance/40-50/01-stranglethorn-vale', 'and 40-50/01 follows it');
	assert.equal(south[0].goal.t, 'goto', 'the south loop opens with the walk to the Thelsamar flight master');
	assert.ok(south.some(({ goal }) => goal.t === 'fly' && /Nijel's Point/.test(goal.location || goal.text || '')), "the flight to Nijel's Point");
	for (const q of [6141, 261, 1466, 5501, 6132, 6134, 6161, 6027, 1456]) {
		assert.ok(south.some(({ goal }) => is('turnin', q)(goal)), `06b hands in ${q}`);
		assert.ok(!bad.some(({ goal }) => goal.quest === q), `06 no longer has ${q}`);
	}
	for (const q of [718, 719, 720, 1106, 738, 703, 1108, 710, 711, 2500]) assert.ok(bad.some(({ goal }) => is('turnin', q)(goal)), `06 still hands in ${q}`);
	const fly = south.filter(({ goal }) => goal.t === 'fly').map(({ goal }) => goal.location || goal.text);
	assert.equal(fly[fly.length - 1], 'Theramore', 'the south loop ends on the Theramore flight, where 40-50/01 starts');
});

// Alliance level tidy (0.4.0): never sent at mobs two or more levels over the player. The 30-40 spots that were:
// the Syndicate camp at 32 (Thieves 33-34, Wizards 34-35), the Saltstone Gazers at 32-33 (34-35), Sin'Dall (37) and
// the Lashtails (35-36) at 34, the Shadowmaw Panthers (37-38) and Skullsplitters (39-42, #2365) at 35-36, Vardus and
// Nagaz (40) at 38, Faldir's Cove (naga 38-40, water elementals 40) at 38, the Greater Rock Elementals (42-44) at 39.
test('Alliance level tidy 30-40: no solo quest sends players at mobs two levels over them', { skip }, () => {
	const g = (f) => goals(`forever/alliance/30-40/${f}.guide`);
	const has = (list, q) => list.some(({ goal }) => goal.quest === q);
	const hills = g('01-hillsbrad-foothills');
	const arathi = g('05-arathi-highlands');
	for (const q of [505, 510, 511, 514]) assert.ok(!hills.some(({ goal }) => goal.quest === q && !is('accept', 505)(goal)), `01: no ${q} work`);
	const shore = hills[at(hills, 'getfp Southshore', (x) => x.t === 'getfp' && /Southshore/.test(x.location || ''))].s;
	assert.equal(hills[at(hills, 'accept 505', is('accept', 505))].s, shore, '01: Maleb gives Syndicate Assassins on the Southshore stop (pick up now, work later)');
	const camp = at(arathi, 'kill 2241 quest 505', (x) => x.t === 'kill' && x.quest === 505);
	assert.ok(at(arathi, 'accept 505', is('accept', 505)) < camp && camp < at(arathi, 'getfp Refuge Pointe', (x) => x.t === 'getfp' && /Refuge Pointe/.test(x.location || '')), '05: the camp on the road from Southshore to Refuge Pointe');
	assert.ok(at(arathi, 'turnin 510', is('turnin', 510)) < at(arathi, 'collect 3505', (x) => x.t === 'collect' && x.quest === 512), '05: Noble Deaths taken before Strahnbrad');
	assert.ok(!has(g('03-ashenvale'), 1175), '03: no A Bump in the Road');
	const stv = g('04-stranglethorn-vale');
	const stv2 = g('04b-stranglethorn-vale');
	for (const q of [188, 195]) {
		assert.ok(!stv.some(({ goal }) => goal.quest === q && !['accept', 'turnin'].includes(goal.t)), `04: ${q} not worked at 34`);
		assert.ok(stv.some(({ goal }) => is('accept', q)(goal)), `04: ${q} taken where its giver hands in the elder tigers and raptors`);
		// Fix round 2 (0.4.0): Sin'Dall (188, 37) is worked on 40-50/01 at about 41 (players reach 04b's hill at about 35.5).
		if (q === 195) assert.ok(at(stv2, `accept ${q}`, is('accept', q)) < at(stv2, `turnin ${q}`, is('turnin', q)), `04b: ${q} taken and handed in`);
		else assert.ok(!stv2.some(({ goal }) => goal.quest === q && goal.t !== 'accept'), `04b: ${q} not worked at 35`);
	}
	const level = stv.filter(({ goal }) => goal.t === 'level').at(-1).goal;
	assert.notEqual(level.npc, 1085, '04: the top-up to 34 is not on the elder tigers (34-35)');
	for (const q of [192, 205]) assert.ok(!stv2.some(({ goal }) => goal.quest === q && goal.t !== 'accept'), `04b: no ${q} work`);
	assert.ok(stv.some(({ goal }) => is('accept', 192)(goal)), '04: Erlgadin gives Panther Mastery on the Panthers hand-in');
	assert.equal(stv2[at(stv2, 'accept 205', is('accept', 205))].s, stv2[at(stv2, 'turnin 207', is('turnin', 207))].s, '04b: Nimetz gives Troll Witchery on the Kurzen hand-in');
	const jungle = goals('forever/alliance/40-50/01-stranglethorn-vale.guide');
	for (const [q, giver] of [[192, 196], [205, 622], [188, 196]]) {
		const work = jungle.findIndex(({ goal }) => goal.quest === q && ['kill', 'collect'].includes(goal.t));
		assert.ok(work >= 0 && work < at(jungle, `turnin ${q}`, is('turnin', q)), `40-50/01: ${q} worked before its hand-in`);
		assert.ok(Math.abs(jungle[at(jungle, `turnin ${q}`, is('turnin', q))].s - jungle[at(jungle, `turnin ${giver}`, is('turnin', giver))].s) <= 1, `40-50/01: ${q} handed in with ${giver}, on the ride north`);
	}
	assert.ok(g('02-desolace').some(({ goal }) => is('accept', 6161)(goal)), "02: Rackmore's Log taken beside Karnitol's Chest");
	const bad = g('06-badlands');
	assert.ok(at(bad, 'accept 97617', is('accept', 97617)) < at(bad, 'accept 719', is('accept', 719)), '06: Dorgaron gives Safety Checks at the foot of the pass');
	assert.ok(!bad.some(({ goal }) => goal.t === 'collect' && goal.item === 278404), "06: no Pristine Mattock among Agmond's End's Shamans and Murdaloc");
	const badlands2 = goals('forever/alliance/40-50/02-badlands.guide');
	const mattock = badlands2.findIndex(({ goal }) => goal.t === 'collect' && goal.item === 278404);
	assert.ok(mattock >= 0 && badlands2[mattock].s === badlands2[at(badlands2, 'kill quest 739', (x) => x.t === 'kill' && x.quest === 739)].s, '40-50/02: the mattock with Murdaloc');
	assert.ok(mattock < at(badlands2, 'turnin 97617', is('turnin', 97617)), '40-50/02: Dorgaron takes Safety Checks on the ride north');
	for (const q of [662, 664, 665, 666]) {
		for (const { step } of arathi.filter(({ goal }) => goal.quest === q)) assert.ok(whenOn(step, 'group', 665), `05: ${q} only on the Faldir's Cove group choice`);
	}
	for (const q of [523, 537, 551]) assert.ok(!has(arathi, q), `05: no ${q}`);
	const scrap = g('06-badlands').find(({ goal }) => goal.t === 'collect' && goal.quest === 733).goal;
	assert.ok(scrap.x < 35, `06: the scrap from the Dustbelcher Ogres west of Agmond's End (${scrap.x},${scrap.y})`);
	const rf = JSON.parse(fs.readFileSync(path.join(ROOT, 'data', 'route-fixes.json'), 'utf8'));
	for (const q of [1175, 523, 537, 551]) assert.ok(rf.overrides.skip.some((e) => e.q === q), `route-fixes skips ${q}`);
	assert.ok(rf.deliberate.group.some((e) => e.q === 665), 'Faldir\'s Cove is a group record');
});

// Fix round 1 (0.4.0 Alliance audit): the Cook in the Cage's key drops only from Kurzen's Subchiefs (35-36, three beside
// Colonel Kurzen, a 39-40 elite) and Elites (36-37), two over players on 04b at about 35: Wendel's quest is taken at his
// cage there and worked on 40-50/01's Rebel Camp stop at about 41, Returning to Port handed to Captain Aransas on its
// Booty Bay stop.
test('Alliance 30-40/40-50: The Cook in the Cage taken on 04b, worked from 40-50/01\'s Rebel Camp, Returning to Port at Booty Bay', { skip }, () => {
	const b = goals('forever/alliance/30-40/04b-stranglethorn-vale.guide');
	const take = at(b, 'accept 97047', is('accept', 97047));
	assert.ok(at(b, 'accept 574', is('accept', 574)) < take && take < at(b, 'kill 938', (g) => g.t === 'kill' && g.npc === 938), 'taken with Special Forces, at Wendel\'s cage');
	assert.ok(!b.some(({ goal }) => goal.quest === 97047 && goal.t !== 'accept'), 'no key, uniform or hand-in on 04b');
	const s = goals('forever/alliance/40-50/01-stranglethorn-vale.guide');
	const key = at(s, 'collect 216616', (g) => g.t === 'collect' && g.item === 216616);
	assert.ok(at(s, 'turnin 622 (Rebel Camp)', is('turnin', 622)) < key, 'after the Rebel Camp hand-in');
	const done = at(s, 'turnin 97047', is('turnin', 97047));
	assert.ok(key < done && done < at(s, 'accept 97048', is('accept', 97048)) && at(s, 'accept 97048', is('accept', 97048)) < at(s, 'turnin 97048', is('turnin', 97048)), 'Wendel freed, then Captain Aransas on the Booty Bay stop');
});

// 0.4.0 route audit (B26), Alliance 45-48: the Tanaris guide ended Gadgetzan -> Theramore -> boat -> Aerie Peak, and the
// Hinterlands guide went on Ironforge -> Stormwind -> Lakeshire -> Morgan's Vigil (a flight path only) -> Thelsamar (a
// bind only) -> Menethil -> boat -> Auberdine -> Darnassus -> boat -> Stormwind. Now Darnassus comes first, from
// Gadgetzan by the flight to Auberdine, then the boat to Menethil and Aerie Peak; Favored of Elune? (3661), taken in
// Rut'theran, has its Wildkin Feathers picked up in the Hinterlands visit; the hearth is set in Ironforge. Since the
// 0.4.0 fix round the Noxious Lair chain (Centipaar 48-50) is worked on the Un'Goro guide's Gadgetzan landing at about
// 49.5, so Rise of the Silithid (162) goes to Gracina on the next Darnassus stop, at the end of the Burning Steppes guide.
test('Tanaris and the Hinterlands (Alliance 45-48): Darnassus before the Hinterlands, the feathers in the Hinterlands, the hearth in Ironforge (0.4.0 audit)', { skip }, () => {
	const tan = goals('forever/alliance/40-50/04-tanaris.guide');
	const flyAub = at(tan, 'fly Auberdine', (g) => g.t === 'fly' && g.location === 'Auberdine');
	for (const [t, q] of [['turnin', 2939], ['turnin', 3022], ['accept', 3661], ['turnin', 2972], ['turnin', 4267], ['accept', 3764]]) {
		const i = at(tan, `${t} ${q}`, is(t, q));
		assert.ok(i > flyAub, `${t} ${q} after the flight to Auberdine`);
		assert.ok(i < at(tan, 'accept 2989', is('accept', 2989)), `${t} ${q} before Aerie Peak`);
	}
	assert.ok(!tan.some(({ goal }) => goal.quest === 162), 'no Noxious Lair chain at about 47');
	const ug = goals('forever/alliance/40-50/07-un-goro-crater.guide');
	assert.ok(at(ug, 'accept 162', is('accept', 162)) >= 0, 'Rise of the Silithid taken on the Un\'Goro guide\'s Gadgetzan landing');
	const bs = goals('forever/alliance/50-60/01-burning-steppes.guide');
	assert.ok(at(bs, 'turnin 162', is('turnin', 162)) > at(bs, 'Portal to Darnassus', (g) => g.t === 'goto' && /Darnassus/.test(g.text || g.label || '')), 'and handed to Gracina on the Burning Steppes guide\'s Darnassus stop');
	assert.ok(!tan.some(({ goal }) => goal.t === 'fly' && goal.location === 'Theramore'), 'no flight back to Theramore');
	const hin = goals('forever/alliance/40-50/05-the-hinterlands.guide');
	const feathers = at(hin, 'collect 10819', (g) => g.t === 'collect' && g.quest === 3661);
	assert.ok(feathers < at(hin, 'turnin 2877', is('turnin', 2877)), 'the feathers before Aerie Peak');
	assert.ok(!hin.some(({ goal }) => goal.t === 'getfp' && /Morgan/.test(goal.location || '')), "no Morgan's Vigil detour");
	assert.ok(!hin.some(({ goal }) => [2939, 3022, 2972, 162, 3763].includes(goal.quest)), 'no Darnassus stop left in the Hinterlands guide');
	assert.ok(!hin.some(({ goal }) => goal.t === 'sethome' && /Stoutlager/.test(JSON.stringify(goal))), 'no Thelsamar bind');
	const sg = goals('forever/alliance/40-50/06-searing-gorge.guide');
	assert.ok(sg.findIndex(({ goal }) => goal.t === 'fly' && goal.location === 'Thelsamar') >= 0, 'the Searing Gorge guide flies Ironforge -> Thelsamar');
});

// Level tidy (0.4.0): For Love Eternal's (963) Anaya Dawnrunner is level 16, and Night Elf Darkshore reaches
// Ameth'Aran at about 13 (recorded 25th percentile 13.5): 3 levels above the player. The quest stays with
// 03-darkshore, which hands it in at about 17; Night Elf Darkshore no longer takes it (this replaces the #2025
// case that took it on the pier).
test(`${NE_DARKSHORE}: For Love Eternal waits for 03-darkshore, where Anaya Dawnrunner (16) is at the player's level`, { skip }, () => {
	const ne = goals(NE_DARKSHORE).filter(nightElf);
	assert.ok(!ne.some(({ goal }) => goal.quest === 963), 'no For Love Eternal goal in Night Elf Darkshore');
	const shared = goals(DARKSHORE);
	const take = at(shared, 'accept 963', is('accept', 963));
	const pendant = at(shared, 'collect 5382', (g) => g.t === 'collect' && g.item === 5382);
	assert.ok(take < pendant && pendant < at(shared, 'turnin 963', is('turnin', 963)), '03-darkshore takes, does and hands it in');
});

// 0.4.0 audit (route-feel, Mount Hyjal): the game's quest log holds 40. An Alliance character who takes Mount Hyjal
// after the Western Plaguelands guide carries about 28 quests in from the 50-60 guides, and the zone's second and
// third stretches took up to 42 at once: the Shrine of Aviana's three quests on top of two breadcrumbs for Dae'gun and
// the Summit picked up in the Cradle. Walk the default Human Warrior chain into the Mount Hyjal guide and count the
// log (accepts in, hand-ins out, optional and group goals left aside, as the route-feel audit counts them): it never
// goes over 40.
test('Alliance Mount Hyjal: the quest log never holds more than 40 with what the 50-60 guides carry in', { skip }, () => {
	const exp = (g) => {
		const file = path.join(ROOT, 'experimental', 'guides', `${g}.guide`);
		refData();
		const { guides } = compileSources([{ file, text: fs.readFileSync(file, 'utf8') }], refData());
		return guides[0];
	};
	const chain = chainFrom('forever/alliance/human/01-elwynn-forest.guide');
	const end = chain.indexOf('forever/alliance/50-60/04-western-plaguelands.guide');
	assert.ok(end > 0, 'the chain reaches the Western Plaguelands guide');
	const route = [...chain.slice(0, end + 1).map((g) => [g, compiled(g)]), ['hyjal-1', exp('hyjal-1')]];
	const fits = (o) => !o || ((!o.races || o.races.includes('Human')) && (!o.classes || o.classes.includes('WARRIOR')) && (!o.factions || o.factions.includes('Alliance')));
	const solo = (st) => !(st.when || []).some((p) => !p.neg && (p.k === 'group' || p.k === 'dungeon'));
	const log = new Set();
	let peak = 0;
	let where = '';
	for (const [id, g] of route) {
		for (const st of g.steps) {
			if (!fits(st.only) || !solo(st)) continue;
			for (const goal of st.goals) {
				if (!fits(goal.only) || goal.optional) continue;
				if (goal.t === 'accept') log.add(goal.quest);
				else if (goal.t === 'turnin') log.delete(goal.quest);
				if (log.size > peak) [peak, where] = [log.size, `${id} "${st.title}"`];
			}
		}
	}
	assert.ok(peak <= 40, `the log peaks at ${peak} (${where})`);
});

// #2327 (kevintm1011, Human Priest 36): Stranglethorn Vale (Alliance 30-40) ended on "The road to Nijel's Point", a
// goto at 33.7,72.8 in the Charred Vale, about 100 yards east of the road players walk (their positions run down x
// 31-31.5 at y 72-74 and through the pass at 30.0, 76-77.5, 21-26 people per half-unit cell). Past it at Nijel's
// Point, the guide sent the player back to it, and Desolace's first step then sent them back to Nijel's Point. The
// goto now stands in the pass, and like #2082's boat back to Auberdine the step drops once the player is in the next
// guide's zone. The same pattern, a guide's last step a lone goto into another zone with no such gate: Desolace's
// boat to Stormwind Harbor and Ashenvale's boat to Menethil Harbor (Alliance 30-40).
test('#2327: a leveling guide that ends on the way into another zone drops that step once you are there', { skip }, () => {
	for (const [guide, zone] of [
		['forever/alliance/30-40/04-stranglethorn-vale.guide', 'Desolace'],
		['forever/alliance/30-40/02-desolace.guide', 'Stormwind City'],
		['forever/alliance/30-40/03-ashenvale.guide', 'Wetlands'],
		['forever/alliance/03-loch-modan.guide', 'Darkshore'],
	]) {
		const steps = compiled(guide).steps;
		const last = steps[steps.length - 1];
		assert.ok(last.goals.every((g) => g.t === 'goto'), `${guide}: ends on a travel step (${last.title})`);
		assert.ok((last.when || []).some((p) => p.k === 'zone' && p.neg && p.name === zone), `${guide}: \`when !zone "${zone}"\` on ${last.title}`);
	}
	const steps = compiled('forever/alliance/30-40/04-stranglethorn-vale.guide').steps;
	const road = steps[steps.length - 1].goals[0];
	assert.equal(road.map, 1442, 'the road to Nijel\'s Point is in the Stonetalon Mountains');
	assert.ok(Math.hypot(road.x - 30.0, road.y - 76.5) < 0.05, `the pass players walk through, 30.0,76.5 (got ${road.x},${road.y})`);
});

// Fyurie (#2490, #2491): Chasing A-Me 01 and Alien Ecology were on the Alliance's first Un'Goro visit at about 50, among
// mobs up to 53. Both are taken on the Western Plaguelands guide's Un'Goro visit at about 57.
test('#2490, #2491: Alliance: A-Me 01 and Alien Ecology wait for the later Un\'Goro visit', { skip }, () => {
	const first = goals(UN_GORO_ALLIANCE);
	for (const q of [4243, 3883]) assert.ok(!first.some(({ goal }) => is('accept', q)(goal)), `no accept ${q} on the first visit`);
	const wpl = goals('forever/alliance/50-60/04-western-plaguelands.guide');
	for (const q of [4243, 3883]) assert.ok(at(wpl, `accept ${q}`, is('accept', q)) < at(wpl, `turnin ${q}`, is('turnin', q)), `${q} taken and handed in on the later visit`);
});

// Fyurie (#1544): My Little Friends' critters are caught with the Entomology Starter Kit, not killed: each is a collect
// of its specimen, shown only with the quest in the log.
test('#1544: Alliance: My Little Friends\' specimens are collects, shown with the quest in the log', { skip }, () => {
	for (const [guide, item] of [[ARATHI, 213568], ['forever/alliance/40-50/01-stranglethorn-vale.guide', 213566]]) {
		const list = goals(guide);
		const { step } = list[at(list, `${guide}: collect ${item}`, (g) => g.t === 'collect' && g.item === item)];
		assert.ok((step.when || []).some((p) => p.k === 'onquest' && !p.neg && [p.q].flat().includes(93176)), `${guide}: when onquest 93176`);
		assert.ok(!step.goals.some((g) => g.t === 'kill'), `${guide}: no kill on the specimen step`);
	}
});

// #2563 (Kiber_Mazai, 0.4.0): Harlo Barnaby stops offering Fall of Dun Modr (472) once A Grim Task (304) is handed
// in, and no prerequisite, exclusive group or breadcrumb in the quest data says so. The accept shared the Menethil
// Harbor step, which then waited on a quest nobody could take. It is a step of its own, shown only while A Grim Task
// is not handed in; every other Menethil goal stays where it was, ungated. The Dun Modr hand-in (30-40/01) needs no
// gate: a hand-in of a quest never taken does not apply.
test('#2563: Wetlands (Alliance): Fall of Dun Modr is taken on its own step, only while A Grim Task is not handed in', { skip }, () => {
	const wet = goals('forever/alliance/06-wetlands.guide');
	const grim = (step) => (step.when || []).some((p) => p.k === 'turnedin' && p.neg && [p.q].flat().includes(304));
	const harlo = wet[at(wet, 'accept 472', is('accept', 472))];
	assert.ok(grim(harlo.step), 'accept 472 only while 304 is not handed in');
	assert.deepEqual(wet.filter(({ s }) => s === harlo.s).map(({ goal }) => `${goal.t} ${goal.quest}`), ['accept 472'], 'Harlo\'s step holds Fall of Dun Modr alone');
	const menethil = wet[at(wet, 'accept 288', is('accept', 288))];
	assert.equal(menethil.s + 1, harlo.s, 'right after the Menethil Harbor step');
	for (const q of [288, 289, 464, 98221, 281, 471, 98208]) {
		const e = wet[at(wet, `accept ${q}`, is('accept', q))];
		assert.equal(e.s, menethil.s, `accept ${q} stays on the Menethil Harbor step`);
		assert.ok(!grim(e.step), `accept ${q} is not gated on A Grim Task`);
	}
	const hills = goals('forever/alliance/30-40/01-hillsbrad-foothills.guide');
	assert.ok(at(hills, 'turnin 472', is('turnin', 472)) >= 0, 'Longbraid still takes it on the Dun Modr stop');
});

test('#703: quests whose objectives are away from the giver lead to each objective', { skip }, () => {
	refData();
	for (const [guide, quest] of AWAY_FROM_THE_GIVER) {
		const list = goals(guide);
		const take = at(list, `${guide}: accept ${quest}`, is('accept', quest));
		const give = at(list, `${guide}: turnin ${quest}`, is('turnin', quest));
		const between = list.slice(take + 1, give).filter(({ goal }) => goal.quest === quest);
		assert.deepEqual(between.filter((x) => !located(x)).map(({ goal }) => goal.t), [], `${guide}: every goal of ${quest} has a place for the arrow`);
		const objectives = refData().quest(quest).objectives.map((_, i) => i + 1);
		const placedComplete = between.some(({ goal }) => goal.t === 'complete');
		assert.deepEqual(placedComplete ? [] : objectives.filter((oi) => !between.some(({ goal }) => goal.oi === oi)), [], `${guide}: every objective of ${quest} has its goal before the turn-in`);
	}
});
