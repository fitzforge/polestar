'use strict';
// Player-reported guide fixes: checks across several Horde guides (a whole route, a band against the next).
// tests/reported/helpers.js says what the cases check and where a new one goes.

const { test } = require('node:test');
const assert = require('node:assert/strict');
const fs = require('node:fs');
const path = require('node:path');
const {
	at, BARRENS, BARRENS_12, chainFrom, compiled, dist, forClass, forRaceOf, goals, H3040, HILLSBRAD_HORDE, is,
	makeProjector, MULGORE, OFFICIAL_DIR, ORC_DUROTAR, refData, ROOT, routes, SILVERPINE, skip, stepTips,
	STONETALON_HORDE, TIRISFAL, TROLL_DUROTAR, where, ZEPHRAS_HORDE,
} = require('./helpers');

// --- Horde quest volume (2026-11-07): quests recorded players take whose givers, work and enders lie on the
// Horde route's walks are taken where the walk passes the giver and handed in on a visit the route makes
// anyway (data/route-fixes.json, overrides.include, "Flow coverage" / "Quest volume").
const HORDE_VOLUME = {
	'forever/horde/undead/01-tirisfal-glades.guide': [445, 99152, 99153], // Delivery to Silverpine Forest; Hilda and Ephram
	'forever/horde/03-silverpine-forest.guide': [422, 1359, 1358], // Arugal's Folly; Zinge's Delivery; Sample for Helbrim
	'forever/horde/02-the-barrens.guide': [4021, 1062, 6548, 6629, 6461], // Counterattack!; Goblin Invaders; Avenge My Village; Kill Grundig Darkcloud; Blood Feeders
	'forever/horde/05-stonetalon-mountains.guide': [494], // Time To Strike
	'forever/horde/30-40/02-thousand-needles.guide': [1111], // Wharfmaster Dizzywig (handed in at Ratchet in 30-40/04)
	// Horde 40-60 (2026-11-08, 0.3.6)
	'forever/horde/30-40/06-badlands.guide': [1137], // News for Fizzle, to the Mirage Raceway on 40-50/02's ride to Tanaris
	'forever/horde/40-50/01-stranglethorn-vale.guide': [95748, 1392, 580], // The Gurubashi Legends of Old; Noboru the Cudgel (0.3.7: its hand-in was optional); Whiskey Slim's Lost Grog (0.3.7: bottles on 40-50/05's beaches, hand-in on 40-50/06's Booty Bay stop)
	'forever/horde/40-50/02-feralas.guide': [1190, 1191, 1194, 2978, 2979], // Keeping Pace; Zamek's Distraction; Rizzle's Schematics; The Gordunni Scroll and Dark Ceremony (0.3.7: their hand-ins were optional)
	'forever/horde/40-50/03-feralas.guide': [1428], // Continued Threat
	'forever/horde/40-50/04-tanaris.guide': [654, 864], // Tanaris Field Sampling; Return to Apothecary Zinge
	'forever/horde/40-50/05-the-hinterlands.guide': [2784, 2621, 2622], // the Fallen Hero of the Horde, Ruag and Bengor
	'forever/horde/40-50/06-azshara.guide': [608], // The Bloodsail Buccaneers, at 50
	'forever/horde/50-60/01-un-goro-crater.guide': [4324], // Yuka Screwspigot
	'forever/horde/50-60/03-winterspring.guide': [5083, 5084], // Winterfall Firewater, Falling to Corruption (0.3.7: the flask drops from one Winterfall in ten)
	'forever/horde/50-60/05-eastern-plaguelands.guide': [5085, 5086, 5241], // Mystery Goo; Toxic Horrors; Uncle Carlin (a message for Light's Hope Chapel)
	'forever/horde/50-60/07-felwood.guide': [5087], // Winterfall Runners
	'forever/horde/50-60/06-silithus.guide': [5234, 5235, 5236, 5238], // the Bulwark cauldrons to Mission Accomplished!
};

// --- Player reports, route-wide (0.3.0 to 0.3.4). Each case states a reported route problem as a property
// of every leveling route of a side, as one character plays it: a start's guides along `next`, with the
// goals that character's race and class get. They are keyed by quests, NPCs and places, never by a guide
// file or a step number, so a route rework that moves zones or renames guides is checked the same way.
// A case that fails on next and passes on the rework that fixes it carries a `todo` naming the issue and
// that pull request; the rework removes it when it lands, and a release ships with none left.

const { greyLevel } = require('../../tools/lib/game/xp');

test('Horde objective follow-ups: camp discovery, Silithyst delivery and cooking point at their actual objective', { skip }, () => {
	for (const [file, quest, map, npc] of [
		['forever/horde/50-60/04-azshara.guide', 3505, 1447, null],
		['forever/horde/50-60/06-silithus.guide', 9422, 1451, 18199],
		['forever/horde/tauren/01-mulgore.guide', 96661, 1412, 3067],
	]) {
		const { goal } = goals(file).find(({ goal }) => goal.t === 'complete' && goal.quest === quest);
		assert.equal(goal.map, map, `${quest}: the unfinished objective has an arrow on its map`);
		const event = npc ? null : refData().quests[quest].objectives.find((o) => o.type === 'event');
		const spawn = npc ? refData().npcs[npc].spawns[map] : null;
		assert.equal(goal.f || 'l', spawn ? spawn.f : event.f, `${quest}: keep the source coordinate frame`);
		assert.equal(goal.x, spawn ? spawn.pts[0][0] : event.x);
		assert.equal(goal.y, spawn ? spawn.pts[0][1] : event.y);
	}
});

test('Horde Call of Fire: hand in the carried trainer lead at Kranal before starting the shared ritual', { skip }, () => {
	const file = 'forever/horde/02-the-barrens.guide';
	for (const [race, durotar, carried] of [['Orc', ORC_DUROTAR, 2983], ['Troll', TROLL_DUROTAR, 2983], ['Tauren', MULGORE, 1523]]) {
		// The Barrens guide is shared since 0.3.1 (only Orc / Troll / Tauren steps). An Orc or Troll
		// Shaman hands Swart's lead (2983) to Kranal on a trip out of Durotar, so the race's Durotar
		// guide comes first.
		const forRace = ({ step, goal }) => [step.only, goal.only].every((o) => !o || !o.races || o.races.includes(race));
		const list = [...(durotar ? goals(durotar) : []), ...goals(file)].filter(forRace).filter(forClass('SHAMAN'));
		const start = list.findIndex(({ goal }) => goal.t === 'accept' && goal.quest === 1524);
		assert.ok(start >= 0, `${race}: the shared ritual is offered`);
		for (const quest of [1522, 1523, 2983, 2984]) {
			const lead = list.slice(0, start).find(({ goal }) => goal.t === 'turnin' && goal.quest === quest);
			assert.ok(lead, `${race}: carried trainer lead ${quest} is handed in before the shared ritual`);
			if (quest !== carried) {
				assert.ok(lead.step.when.some((p) => p.k === 'onquest' && !p.neg && p.q.includes(quest)), `${race}: an uncarried alternative never blocks the route`);
			}
			assert.equal(lead.goal.npc, 5907, `${race}: no trip to a different giver`);
			for (const field of ['map', 'x', 'y']) assert.equal(lead.goal[field], list[start].goal[field], `${race}: the same Kranal stop`);
		}
	}
});

// First-visit flight paths (2026-11-10, Fitz in game at Ratchet): Bragok stands 16 yd from Sputtervalve on the
// first Ratchet stop, and the getfp waited for the fly step after the beach; Omusa Thunderhorn stands 54 yd from
// Kirge Sternhorn, where Tauren leave Mulgore, and the path waited for the Barrens' Camp Taurajo stop.
test("First-visit flight paths: Ratchet's is learned beside Sputtervalve on the first stop, Camp Taurajo's at Kirge for Tauren", { skip }, () => {
	for (const race of ['Orc', 'Troll', 'Tauren', 'Scourge', 'Skyborne']) {
		const forRace = ({ step, goal }) => [step.only, goal.only].every((o) => !o || !o.races || o.races.includes(race));
		const list = goals(BARRENS_12).filter(forRace);
		const fp = at(list, `${race}: getfp Ratchet`, (g) => g.t === 'getfp' && g.location === 'Ratchet');
		assert.equal(list[fp].s, list[at(list, 'accept 894', is('accept', 894))].s, `${race}: on Sputtervalve's step`);
	}
	const mulgore = goals(MULGORE);
	const fp = at(mulgore, 'getfp Camp Taurajo', (g) => g.t === 'getfp' && g.location === 'Camp Taurajo');
	assert.equal(mulgore[fp].s, mulgore[at(mulgore, 'accept 854', is('accept', 854))].s, "on Kirge Sternhorn's step");
});

// Flow audit, Horde Hillsbrad (#1079): Battle of Hillsbrad was walked out in one visit, Tarren Mill ->
// Hillsbrad Fields -> Tarren Mill five times, the last two for Magistrate Burnside and Foreman Bonds (both
// level 30) at 25-27. Parts 4 and 5 (532, 539) and Dangerous!'s clerk and miner come on the Tarren Mill
// visit at 30-31 (30-40/01-hillsbrad-foothills): the town hall, Tarren Mill, then the mine (level tidy 2026-11-15:
// Helcular's Revenge and the Dalaran crater left this visit, so nothing comes between).
test('forever/horde/06-hillsbrad-foothills.guide: Battle of Hillsbrad parts 4 and 5 wait for the Tarren Mill visit at 32', { skip }, () => {
	const early = goals('forever/horde/06-hillsbrad-foothills.guide');
	assert.deepEqual(early.filter(({ goal }) => [532, 539].includes(goal.quest)).map(({ goal }) => `${goal.t} ${goal.quest}`), [], 'nothing of parts 4 and 5 at 25-27');
	// Since the 0.4.0 level tidy Dangerous! (level 28) waits for the 30-40 visit as a whole: Kalaba and Wilkes come with it.
	assert.deepEqual(early.filter(({ goal }) => goal.quest === 567).map(({ goal }) => `${goal.t} ${goal.npc || ''}`), [], 'nothing of Dangerous! at 23-25');
	const list = goals('forever/horde/30-40/01-hillsbrad-foothills.guide');
	const idx = (what, pred) => at(list, what, pred);
	const accept = idx('accept 532', is('accept', 532));
	const hall = idx('Magistrate Burnside', (g) => g.t === 'kill' && g.quest === 532 && g.npc === 2335);
	const back = idx('turnin 532', is('turnin', 532));
	const bonds = idx('Foreman Bonds', (g) => g.t === 'kill' && g.quest === 539 && g.npc === 2305);
	assert.ok(accept < hall && hall < back && back < bonds, 'Tarren Mill, the town hall, Tarren Mill, the mine');
	for (const q of [539, 567]) assert.ok(idx(`turnin ${q}`, is('turnin', q)) > bonds, `${q} is handed in after the mine`);
});

// Horde 30-40 audit (0.4.0): Bracers of Binding (557) and Dalaran Patrols (545) were taken at Tarren Mill at about 31
// and worked only on the 38-39 visit, carried through four guides; players' recordings show 3 people abandoning
// Bracers of Binding on the way. Since the level tidy (2026-11-15) their openers (556, 544, 93680) are worked on the
// 38-39 visit too: Bel'varil and Voidglare give them on the Tarren Mill stop after the Dalaran crater, before the ruins.
test('forever/horde/30-40: Bracers of Binding and Dalaran Patrols are taken on the 38-39 visit, not carried from 31', { skip }, () => {
	const early = goals('forever/horde/30-40/01-hillsbrad-foothills.guide');
	assert.deepEqual(early.filter(({ goal }) => goal.t === 'accept' && [545, 557].includes(goal.quest)).map(({ goal }) => goal.quest), [], 'not taken at 30-31');
	// "Pick up now, do later" (Fitz, 2026-11-16): their openers are taken on Hillsbrad's last Tarren Mill stop and only worked at 38-39.
	assert.deepEqual([...new Set(early.filter(({ goal }) => [544, 556, 93680].includes(goal.quest)).map(({ goal }) => goal.t))], ['accept'], 'the openers are only taken at 30-31');
	const list = goals('forever/horde/30-40/05-arathi-highlands.guide');
	const crater = at(list, 'the first Bloodstone piece', (g) => g.t === 'collect' && g.quest === 544);
	for (const q of [545, 557]) {
		const acc = at(list, `accept ${q}`, is('accept', q));
		assert.ok(crater < acc, `${q} after the crater`);
		assert.ok(acc < at(list, 'the Dalaran Summoners', (g) => g.t === 'kill' && g.quest === 545), `${q} before the ruins`);
	}
});

// Horde 30-40 audit (0.4.0): Centaur Bounty (1366) was taken at the end of the first Desolace visit (33-35) and worked
// only on the second (38), carried through Stranglethorn; players' recordings show 4 people abandoning it on the way.
// Felgur stands at Ghost Walker Post, where the second visit stops before the Valley of Spears.
test('forever/horde/30-40: Centaur Bounty is taken on the second Desolace visit, before the Valley of Spears', { skip }, () => {
	const first = goals('forever/horde/30-40/02-thousand-needles.guide');
	assert.deepEqual(first.filter(({ goal }) => is('accept', 1366)(goal)).length, 0, 'not taken on the first visit');
	const list = goals('forever/horde/30-40/04-dustwallow-marsh.guide');
	const acc = at(list, 'accept 1366', is('accept', 1366));
	assert.equal(list[acc].step.title, 'Ghost Walker Post', 'at Ghost Walker Post');
	assert.ok(acc < at(list, 'the centaur ears', (g) => g.t === 'collect' && g.quest === 1366), 'before the valley');
});

// Dungeons in the route (0.4.0, the grind-tip rule): a grind step names a dungeon only when its run is in the route
// in the same or the next guide, on the same continent: Razorfen Kraul in Thousand Needles; Scarlet Monastery,
// Blackfathom Deeps and Razorfen Downs are not route dungeons in Horde 30-40. (Hillsbrad has no grind steps since the
// level tidy, 2026-11-15.)
test('forever/horde/30-40: the grind steps name only the dungeons the route runs nearby', { skip }, () => {
	const want = {
		'02-thousand-needles': ['Razorfen Kraul'],
		'03-stranglethorn-vale': [],
		'04-dustwallow-marsh': [],
	};
	for (const [file, names] of Object.entries(want)) {
		const tips = compiled(`forever/horde/30-40/${file}.guide`).steps.filter((step) => step.goals.some((g) => g.t === 'level')).map((step) => [step.note, step.tip].flat().filter(Boolean).join(' '));
		assert.ok(tips.length > 0, `${file}: has grind steps`);
		for (const tip of tips) {
			for (const bad of ['Scarlet Monastery', 'Blackfathom Deeps', 'Razorfen Downs']) assert.ok(!tip.includes(bad), `${file}: no ${bad} in "${tip}"`);
			if (/with a group, run/.test(tip)) assert.ok(names.some((n) => tip.includes(n)), `${file}: names ${names.join(' or ') || 'no dungeon'}: "${tip}"`);
			else assert.equal(names.length, 0, `${file}: names ${names.join(' or ')}`);
		}
	}
});

// Danger at the spot (#1575, release gate #2042), Horde 30-40 audit (0.4.0): where the gate found mobs well above the
// route at a goal and players' recordings confirm them (Kirin Tor Guards and Arcane Sentries, 55, met as hostile by 56
// and 26 Horde players, 11 deaths), or the camp is crowded, the step's tip names them.
test('forever/horde/30-40: the steps warn of the high mobs the danger gate finds at their goals', { skip }, () => {
	for (const [file, quest, names, item] of [
		['01-hillsbrad-foothills', 527, ['Kirin Tor Guard']],
		['05-arathi-highlands', 544, ['Arcane Sentries', 'Kirin Tor Guards']],
		['03-stranglethorn-vale', 213, ['Venture Co. Agents']],
		['05-arathi-highlands', 545, ['Arcane Sentries', 'Kirin Tor Guards']],
		['06-badlands', 2258, ['Malevolent Mirage'], 7847],
		['06-badlands', 711, ['Malevolent Mirage']],
	]) {
		const list = goals(`forever/horde/30-40/${file}.guide`);
		const { step } = list[at(list, `${file}: work for ${quest}`, (g) => ['kill', 'collect', 'use'].includes(g.t) && g.quest === quest && (!item || g.item === item))];
		const tip = [step.note, step.tip].flat().filter(Boolean).join(' ');
		for (const name of names) assert.ok(tip.includes(name), `${file} "${step.title}": the tip names ${name}`);
	}
});

// Flow review, Mulgore: arriving at the Crossroads, the guide handed in to Sergra, went back to Tonga
// at the south gate, then crossed the town twice. Tonga is first, both quests at once, then northward.
// Since the Horde 12-30 re-chain the Tauren pass the Crossroads on the way to Orgrimmar and Silverpine: Tonga
// first, then Sergra; The Forgotten Pools waits for the Barrens guide's Crossroads stop, where it is done.
test(`${MULGORE}: flow review: the Crossroads arrival starts with Tonga, and the Crossroads' own quests wait for the Barrens`, { skip }, () => {
	const list = goals(MULGORE);
	const tonga = at(list, 'turnin 886', is('turnin', 886));
	assert.ok(tonga < at(list, 'turnin 860', is('turnin', 860)), 'before Sergra');
	assert.deepEqual(list.filter(({ goal }) => goal.t === 'accept' && [870, 867, 5041, 871, 844, 869, 848, 1492].includes(goal.quest)).map(({ goal }) => goal.quest), [], 'no Crossroads quest carried through Silverpine');
	const barrens = goals('forever/horde/02-the-barrens.guide').filter(forRaceOf('Tauren'));
	assert.ok(barrens.some(({ goal }) => is('accept', 870)(goal)), 'The Forgotten Pools from Tonga in the Barrens guide');
});

// Final route review, Horde 1-30: Orc and Troll Shamans handed Call of Fire to Kranal Fiss at 10 without taking his
// next part, then walked back from the Crossroads to Kranal, Telf Joolam and northern Durotar for the Reagent Pouch.
test('forever/horde/orc/01-durotar.guide, troll/01-durotar.guide: final route review: Call of Fire to Telf at 10, the pouch in Drygulch Ravine', { skip }, () => {
	for (const file of ['forever/horde/orc/01-durotar.guide', 'forever/horde/troll/01-durotar.guide']) {
		const list = goals(file);
		const kranal = at(list, 'turnin 2983', is('turnin', 2983));
		assert.equal(list[at(list, 'accept 1524', is('accept', 1524))].s, list[kranal].s, `${file}: 1524 taken from Kranal on the same stop`);
		const telf = at(list, 'accept 1525', is('accept', 1525));
		const pouch = at(list, 'collect 6652', (g) => g.t === 'collect' && g.item === 6652);
		assert.ok(kranal < telf && telf < pouch, `${file}: Telf, then the pouch`);
		assert.equal(list[pouch].s, list[at(list, 'kill 3117 quest 835', (g) => g.t === 'kill' && g.npc === 3117)].s, `${file}: the pouch in the Drygulch Ravine step`);
	}
	const barrens = goals('forever/horde/02-the-barrens.guide');
	const orcTroll = ({ step, goal }) => [step.only, goal.only].every((o) => !o || !o.races || o.races.includes('Orc'));
	assert.ok(!barrens.filter(orcTroll).some(({ goal }) => is('accept', 1524)(goal) || is('accept', 1525)(goal) || (goal.t === 'collect' && goal.item === 6652)), 'no walk back to Kranal, Telf and Drygulch for Orcs and Trolls');
	// Conscript of the Horde is handed in once, at the end of the Durotar guides (final route review, 0.3.5): Shamans
	// at Far Watch on the way to Kranal, everyone else before Orgrimmar; the Barrens guide carries none.
	for (const file of ['forever/horde/orc/01-durotar.guide', 'forever/horde/troll/01-durotar.guide']) {
		for (const cls of ['WARRIOR', 'SHAMAN', 'MAGE']) {
			assert.equal(goals(file).filter(forClass(cls)).filter(({ step, goal }) => is('turnin', 840)(goal) && !(cls === 'SHAMAN' && step.when && step.when.length)).length, 1, `${file} ${cls}: 840 handed in once`);
		}
	}
	// 0.4.0 audit: whoever still carries 840 (everyone but Warriors once Durotar's Far Watch stop is theirs alone) hands
	// it to Kargal on the Barrens' Far Watch stop, right before Crossroads Conscription from him.
	const conscript = barrens.filter(({ goal }) => is('turnin', 840)(goal));
	assert.equal(conscript.length, 1, 'the Barrens hand 840 in once');
	assert.ok(conscript[0].step.only && conscript[0].step.only.races.join() === 'Orc,Troll', 'on the Orc and Troll Far Watch stop');
	assert.equal(barrens.indexOf(conscript[0]) + 1, at(barrens, 'accept 842', is('accept', 842)), 'right before Crossroads Conscription');
});

// Final route review before 0.3.5, Horde 1-30: three walks back to a town between two pieces of work on one road
// (Jorn in Camp Taurajo between his thunderhawks and the Field of Giants' eggs south of them; Tarren Mill between the
// bears on the slope down to Hillsbrad Fields and the fields; the Sepulcher and the Decrepit Ferry, a boat the later
// shore walk to Ambermill passes), and texts that sent players the wrong way or to the wrong guide.
test('Final route review (Horde 1-30, 0.3.5): Jorn after the eggs, Lydon after Hillsbrad Fields, the Decrepit Ferry on the shore walk; tips that match the route', { skip }, () => {
	const fixes = JSON.parse(fs.readFileSync(path.join(ROOT, 'data', 'route-fixes.json'), 'utf8'));
	for (const [a, b] of [[['task', 527], ['turnin', 496]], [['task', 91920], ['turnin', 438]], [['turnin', 438], ['task', 479]]]) {
		assert.ok(fixes.overrides.pairs.some((p) => p.faction === 'Horde' && `${p.a}` === `${a}` && `${p.b}` === `${b}`), `pair ${a} before ${b} is a record the build keeps`);
	}
	const barrens = goals(BARRENS);
	const wings = at(barrens, 'collect 5164', (g) => g.t === 'collect' && g.item === 5164);
	const jorn = at(barrens, 'turnin 913', is('turnin', 913));
	// Since the 0.4.0 level tidy the eggs are in 04-the-barrens: the thunderhawks, then Jorn on the way back north.
	assert.ok(wings < jorn, 'the thunderhawks, then Jorn on the way back north');
	const warrior = barrens.filter(forClass('WARRIOR'));
	assert.ok(warrior[at(warrior, 'turnin 1824', is('turnin', 1824))].s < warrior[at(warrior, 'collect 5164', (g) => g.t === 'collect' && g.item === 5164)].s, "Ruga's stop before the thunderhawks");
	// Ingest 2026-11-08: 8 of 14 players abandoned Egg Hunt, taken at 17 and carried to the eggs at 21. Since the 0.4.0 level
	// tidy the eggs are on 04-the-barrens' walk south at 25; Korran gives it on 02's last Crossroads stop (the route walks
	// past him there anyway), so 04's flight from Orgrimmar no longer lands at the Crossroads only for him, and no Crossroads
	// stop comes between the accept and the eggs.
	const later = goals('forever/horde/04-the-barrens.guide');
	const egg = at(barrens, 'accept 868', is('accept', 868));
	const eggs = at(later, 'collect 5058', (g) => g.t === 'collect' && g.item === 5058);
	assert.ok(jorn < egg, 'Egg Hunt on the last Crossroads stop, after the Field of Giants pass');
	assert.ok(!barrens.slice(egg + 1).some(({ goal }) => goal.quest === 868 || goal.npc === 3338), 'no other Crossroads stop in 02 after the accept');
	assert.ok(!later.slice(0, eggs).some(({ goal }) => goal.quest === 868 || goal.npc === barrens[egg].goal.npc || goal.npc === 3338), 'no Crossroads stop (Korran, Sergra) in 04 before the eggs');
	assert.match(barrens[at(barrens, 'accept 855', is('accept', 855))].step.note, /^West to Regthar/, 'Regthar is west of the Crossroads');
	assert.doesNotMatch(barrens[at(barrens, 'accept 1512', is('accept', 1512))].goal.note, /end of this guide/, 'The Binding is on the next guide\'s Orgrimmar stop');
	const hills = goals(HILLSBRAD_HORDE);
	const bears = at(hills, 'collect 3476', (g) => g.t === 'collect' && g.item === 3476);
	const farmers = at(hills, 'kill 2266 quest 527.1', (g) => g.t === 'kill' && g.quest === 527);
	assert.ok(bears < farmers && farmers < at(hills, 'turnin 496', is('turnin', 496)), 'the bears, the fields, then Lydon');
	assert.deepEqual(hills.slice(bears + 1, farmers).filter(({ goal }) => ['accept', 'turnin'].includes(goal.t)).map(({ goal }) => `${goal.t} ${goal.quest}`), [], 'no Tarren Mill stop between the bears and the fields');
	const pine = goals(SILVERPINE);
	const ferry = at(pine, 'turnin 438', is('turnin', 438));
	// Since the 0.4.0 level tidy Ambermill waits for the ride at 22: the boat on the shore walk after the murlocs, then the Sepulcher.
	assert.ok(at(pine, 'collect 730', (g) => g.t === 'collect' && g.item === 730) < ferry, 'the boat after the murlocs');
	assert.equal(pine[at(pine, 'turnin 439', is('turnin', 439))].s, pine[at(pine, 'turnin 91920', is('turnin', 91920))].s, 'Rot Hide Clues on the Sepulcher stop after the shore');
	assert.doesNotMatch(goals(TIRISFAL).find(({ goal }) => is('accept', 86784)(goal)).goal.note, /walks/, 'Bartholomew stays beside Dillinger (#1046)');
	assert.match(goals(ZEPHRAS_HORDE).find(({ goal }) => is('accept', 94913)(goal)).step.note, /forever\/horde\/02-the-barrens/, 'the Cat Form trip is in the Barrens 15-21 guide');
	const grind = compiled('forever/horde/07-ashenvale.guide').steps.find((step) => step.title === 'Level 28');
	assert.match(grind.note, /Or, with a group, run the Blackfathom Deeps dungeon instead\.$/, 'the top-up names the dungeons that fit, in the writer\'s sentence');
	// Razorfen Kraul's floor (30.9, the recorded p25 of boss-killers) is above this guide's ~29: its run left 07 for
	// forever/horde/30-40/02-thousand-needles, so neither top-up names it, and the Barrens' Ratchet stop no longer offers its tubers.
	assert.ok(!compiled('forever/horde/07-ashenvale.guide').steps.some((step) => /Razorfen Kraul|Scarlet Monastery/.test(step.note || '') || step.title === 'Razorfen Kraul'), 'no Razorfen Kraul run or mention in 07');
	assert.ok(!goals('forever/horde/04-the-barrens.guide').some(({ goal }) => goal.quest === 1221), 'no Blueleaf Tubers pick-up in 04');
	// The Warsong Reports: its walks east of Night Run and back to Kadrak cost more than its XP (measured): left out.
	assert.ok(fixes.overrides.skip.some((r) => r.q === 6543 && r.faction === 'Horde'), 'the skip is a record');
	assert.ok(!goals(STONETALON_HORDE).some(({ goal }) => goal.quest === 6543), 'no Warsong Reports in Ashenvale at 21');
});

// Horde 50-60 audit (0.4.0), travel sweep of the Hearthstone binds: Winterspring bound at Everlook and no step hearthed
// back there; the guide leaves Everlook by flight for Camp Mojache, which the Gadgetzan bind (set in the Azshara guide
// at 50 and still in force) makes about 5 minutes shorter (Hearthstone to Gadgetzan, then the flight), and dropping it
// changes nothing outside the guide. The Orgrimmar bind of the next guide stays (its hearth from Valormok).
test('forever/horde/50-60/03-winterspring.guide: no Everlook bind, the Gadgetzan bind carries the trip to Camp Mojache', { skip }, () => {
	assert.ok(!goals('forever/horde/50-60/03-winterspring.guide').some(({ goal }) => goal.t === 'sethome'), 'no bind in the Winterspring guide');
	assert.ok(goals('forever/horde/50-60/04-azshara.guide').some(({ goal }) => goal.t === 'sethome' && goal.location === 'Orgrimmar'), 'Orgrimmar is still bound in the Azshara guide');
	assert.ok(goals('forever/horde/40-50/06-azshara.guide').some(({ goal }) => goal.t === 'sethome' && goal.location === 'Gadgetzan'), 'the Gadgetzan bind it relies on');
});

// Final route review, Horde 40-60: each race learns to ride where the route already passes its trainer's city:
// Trolls from the Orgrimmar stop (not a flight and boat from Stonard to Durotar and back), Undead on the next
// guide's Undercity stop (not Gadgetzan -> Orgrimmar -> Brill -> Gadgetzan), Taurens, Druids, Paladins and Warlocks
// from Orgrimmar on the way out (not a flight back from Gadgetzan).
test('forever/horde/40-50: final review: riding at 40 and class trips where the route already passes', { skip }, () => {
	const stv = goals('forever/horde/40-50/01-stranglethorn-vale.guide');
	// Since the 0.4.0 audit every race may learn to ride from the Grom'gol stop at about 41, by zeppelin, before the
	// Riverglades; still never from the Swamp of Sorrows.
	const swamp = at(stv, 'Into the Swamp of Sorrows', is('accept', 1389));
	assert.ok(!stv.slice(swamp).some(({ goal }) => goal.t === 'train' && goal.npc === 7953), 'no Troll riding trip from the Swamp of Sorrows');
	const fer = goals('forever/horde/40-50/02-feralas.guide');
	const gadgetzan = at(fer, 'getfp Gadgetzan', (g) => g.t === 'getfp' && g.location === 'Gadgetzan');
	for (const [what, pred] of [['Troll riding', (g) => g.t === 'train' && g.npc === 7953], ['Tauren riding', (g) => g.t === 'train' && g.npc === 3690], ['the Felsteed', is('turnin', 3631)]]) {
		assert.ok(at(fer, what, pred) < gadgetzan, `${what} before Gadgetzan`);
	}
	assert.deepEqual(fer.slice(gadgetzan).filter(({ goal }) => goal.t === 'fly' && /Thunder Bluff|Ratchet/.test(goal.location || goal.text || '')).map(({ step }) => step.title), [], 'no flight back from Gadgetzan to Thunder Bluff or Ratchet');
	assert.ok(!fer.some(({ goal }) => goal.t === 'train' && goal.npc === 4773), 'no Undead riding loop in this guide');
	const uc = goals('forever/horde/40-50/03-feralas.guide');
	assert.ok(at(uc, 'Undead riding', (g) => g.t === 'train' && g.npc === 4773) < at(uc, 'Zeppelin to Grom\'gol', (g) => g.t === 'goto' && /Grom'gol/.test(g.text || '')), 'Undead ride from the Undercity stop');
});

// Final route review, Horde 40-60: Cortello's Riddle's scroll lies on the Bloodsail ships (crews 42-45) at level 41:
// optional, its later parts only with the part before. The Gorishi Hive Queen is not elite in Forever (Fitz, in game):
// no elite warning on Pawn Captures Queen.
test('forever/horde/40-50: final review: Cortello\'s Riddle optional, no elite warning for the Hive Queen', { skip }, () => {
	const stv = goals('forever/horde/40-50/01-stranglethorn-vale.guide');
	// Since the 0.4.0 audit the scroll is a group step (`when group 624`: decks of 42-45 pirates, captains 45-48).
	assert.ok((stv[at(stv, 'accept 624', is('accept', 624))].step.when || []).some((p) => p.k === 'group' && !p.neg), '624 a group step');
	const fer = goals('forever/horde/40-50/03-feralas.guide');
	for (const [q, pre] of [[625, 624], [626, 625]]) {
		const a = fer[at(fer, `accept ${q}`, is('accept', q))];
		assert.ok(a.goal.optional && a.step.when.some((p) => p.k === 'onquest' && p.q.includes(pre)), `${q} only with ${pre}`);
	}
	const sil = goals('forever/horde/50-60/06-silithus.guide');
	assert.doesNotMatch(sil[at(sil, 'use 11833', (g) => g.t === 'use' && g.item === 11833)].step.note || '', /elite/);
});

for (const [guide, quests] of Object.entries(HORDE_VOLUME)) test(`${guide}: Horde quest volume: quests on the walk are taken there and handed in, not optional`, { skip }, () => {
	const here = goals(guide);
	const later = chainFrom(guide).flatMap((g) => goals(g));
	for (const q of quests) {
		// (A quest handed in on the spot, #1699, has no accept: its direct hand-in takes it.)
		assert.ok(here.some(({ goal }) => (goal.t === 'accept' || (goal.t === 'turnin' && goal.direct)) && goal.quest === q && !goal.optional), `accept ${q} is in ${guide}`);
		assert.ok(later.some(({ goal }) => goal.t === 'turnin' && goal.quest === q && !goal.optional), `turnin ${q} is in ${guide} or a guide after it`);
	}
});

// --- Horde 40-60 flow pass (0.3.7, Fitz: "none of this running past quest givers"): a giver or ender the route walks
// past (the flow audit's walked-past list) is visited then, not on a later trip.
test('Horde 40-60 flow pass: givers and enders are visited when the route passes them', { skip }, () => {
	const H = (g) => `forever/horde/${g}.guide`;
	const before = (g, a, b, why) => {
		const list = goals(H(g));
		assert.ok(at(list, `${a[0]} ${a[1]}`, is(a[0], a[1])) < at(list, `${b[0]} ${b[1]}`, (x) => x.t === b[0] && (x.quest === b[1] || x.item === b[1])), `${g}: ${a.join(' ')} before ${b.join(' ')} (${why})`);
	};
	// Gan'zulah and the Fate of Yenniku are done on 40-50/02's Grom'gol stop at about 45 since the 0.4.0 audit.
	const stv = goals(H('40-50/02-feralas'));
	assert.equal(stv[at(stv, 'accept 588', is('accept', 588))].s, stv[at(stv, 'turnin 586', is('turnin', 586))].s, "The Fate of Yenniku at the cauldron with 586's hand-in");
	assert.ok(stv.some(({ goal }) => goal.t === 'turnin' && goal.quest === 588), '588 handed in in Stranglethorn');
	assert.ok(!goals(H('40-50/06-azshara')).some(({ goal }) => goal.quest === 588), 'no Fate of Yenniku stop left in 06');
	const az = goals(H('40-50/06-azshara'));
	// Deliver to MacKinley (2874) is handed in on 40-50/03's Booty Bay stop since the 0.4.0 level tidy.
	assert.equal(az[at(az, 'turnin 580', is('turnin', 580))].s, az[at(az, 'accept 608', is('accept', 608))].s, "Whiskey Slim on the first Booty Bay stop");
	// Since the fresh-start pass the Marshal's Refuge landing ends 50-60/05 (Valor's Rest and Southwind with it).
	const epl = goals(H('50-60/05-eastern-plaguelands'));
	const refuge = epl[at(epl, 'accept 4492', is('accept', 4492))].s;
	// Beware of Pterrordax: its Pterrordax (50-52) on the crater's first loop, its Frenzied Pterrordax (51-54) on the
	// pylon loop at about 52 since the 0.4.0 level tidy, handed in to Spraggle with J.D. Collie's pylons.
	const ug = goals(H('50-60/01-un-goro-crater'));
	assert.ok(at(ug, 'accept 4501', is('accept', 4501)) < at(ug, 'turnin 4501', is('turnin', 4501)), 'Beware of Pterrordax in 50-60/01');
	assert.ok(at(ug, 'turnin 4285', is('turnin', 4285)) - at(ug, 'kill 9167', (x) => x.t === 'kill' && x.quest === 4501) > 0, 'the Frenzied Pterrordax before the pylons\' hand-in');
	assert.equal(ug[at(ug, 'turnin 4501', is('turnin', 4501))].s, ug[at(ug, 'turnin 4285', is('turnin', 4285))].s, "with J.D. Collie's pylons");
	for (const n of ['50-60/05-eastern-plaguelands', '50-60/06-silithus']) assert.ok(!goals(H(n)).some(({ goal }) => goal.quest === 4501), `no Beware of Pterrordax in ${n}`);
	assert.ok(at(epl, 'accept 4492', is('accept', 4492)) < at(epl, 'turnin 1124', is('turnin', 1124)), 'Lost! too');
	assert.equal(epl[at(epl, 'turnin 3914', is('turnin', 3914))].s, refuge, "Linken's Sword to Linken on the same landing");
	// The rest of the flow pass (0.3.7).
	assert.equal(stv[at(stv, 'accept 589', is('accept', 589))].s, stv[at(stv, 'turnin 588', is('turnin', 588))].s, "The Singing Crystals with The Fate of Yenniku");
	assert.equal(stv[at(stv, 'turnin 589', is('turnin', 589))].s, stv[at(stv, 'turnin 573', is('turnin', 573))].s, 'the basilisks on the ride south to Booty Bay, handed in at Grom\'gol before the flight to Stonard');
	assert.ok(!az.some(({ goal }) => goal.quest === 589), 'no Singing Crystals left in 06');
	before('40-50/04-tanaris', ['accept', 5863], ['turnin', 992], 'Gadgetzan on landing, before Sandsorrow Watch');
	before('40-50/04-tanaris', ['turnin', 3442], ['turnin', 7729], 'Velarok on the way back north to Thorium Point');
	before('50-60/03-winterspring', ['turnin', 5082], ['accept', 3783], 'Winterspring west to east');
	assert.ok(!goals(H('50-60/03-winterspring')).some(({ goal }) => goal.quest === 6603), "no Everlook pointer to Donova");
	const sil = goals(H('50-60/06-silithus'));
	const barrel = at(sil, 'turnin 5902', is('turnin', 5902));
	// Since the 0.4.0 level tidy Kirsta's Scarlets (6004) are done here: the barrel goes into the lumber mill on that trip,
	// still before Radley's hand-in to Kirsta (the flow audit's backtrack to the mill after Radley is gone).
	assert.equal(sil[barrel].s, sil[at(sil, 'kill 6004', (x) => x.t === 'kill' && x.quest === 6004)].s, 'the termite barrel on the Northridge Scarlet trip');
	assert.ok(barrel < at(sil, 'turnin 6023', is('turnin', 6023)), 'before Radley goes back to Kirsta');
	assert.equal(sil[at(sil, 'turnin 6390', is('turnin', 6390))].s, sil[at(sil, 'turnin 5230', is('turnin', 5230))].s, 'Mickey on the next Bulwark stop');
	const mound = at(sil, 'turnin 6024', is('turnin', 6024));
	assert.ok(!sil.slice(at(sil, 'turnin 5845', is('turnin', 5845)), mound).some(({ goal }) => goal.t === 'goto'), "straight from Tirion to Hameya's mound");
	// Encrypted Twilight Texts: one source says they drop without the quest, the item data marks them quest items, and no
	// recording settles it: the guide asks for them only once Secret Communication is in the log (safe either way).
	const accept8318 = at(sil, 'accept 8318', is('accept', 8318));
	for (const [i, e] of sil.entries()) {
		if (e.goal.t === 'collect' && e.goal.item === 20404) assert.ok(i > accept8318 && (e.goal.quest || (e.step.when || []).length), `Encrypted Twilight Texts collected after ${8318} and gated (step ${e.s})`);
	}
	assert.ok(at(sil, 'turnin 8318', is('turnin', 8318)) > accept8318, 'Bor Wildmane hand-in after the accept');
	assert.ok(!compiled(H('40-50/04-tanaris')).steps.some((step) => /Kalaran/.test(step.title)), "NPC 8479 is Velarok Windblade in Forever's data");
});

// --- Every guide stands on its own (Fitz, 2026-11-08), Horde 40-60 (0.3.7): a player loading a guide at its level
// with no quest from our earlier guides meets no blocked accept in its first steps. The fixes: a later stop at the
// same giver, a cheap feeder at the hub the guide opens in, or the guide boundary moved to a self-contained hub.
test('Horde 40-60 fresh start: the guides open at hubs that stand on their own', { skip }, () => {
	const H = (g) => `forever/horde/${g}.guide`;
	const g = (n) => goals(H(n));
	const stv = g('40-50/01-stranglethorn-vale');
	assert.equal(stv[at(stv, 'accept 598', is('accept', 598))].s, stv[at(stv, 'turnin 584', is('turnin', 584))].s, 'Split Bone Necklace on the later Grom\'gol stop');
	// Horde 0.4.0 audit (round 2): Kebok offers the tusks on the first Booty Bay stop to a player who handed in Bloodscalp
	// Ears (the route's players); the second stop keeps it for one who starts here.
	const tusks = stv.filter(({ goal }) => is('accept', 209)(goal));
	assert.equal(tusks.at(-1).s, stv[at(stv, 'turnin 600', is('turnin', 600))].s, 'Skullsplitter Tusks on the second Booty Bay stop');
	assert.ok(tusks.slice(0, -1).every(({ step }) => (step.when || []).some((p) => p.k === 'turnedin' && [p.q].flat().includes(189))), 'an earlier take only after Bloodscalp Ears');
	const fer = g('40-50/03-feralas');
	assert.ok(at(fer, 'accept 698', is('accept', 698)) < at(fer, 'turnin 698', is('turnin', 698)), "Dar's quests on the Stonard landing");
	const az = g('50-60/04-azshara');
	assert.ok(!az.some(({ goal }) => goal.quest === 3504), '#2390: Betrayed starts at Ag\'tor (3505); Belgrom no longer offers 3504');
	assert.ok(at(az, 'accept 3505', is('accept', 3505)) < at(az, 'turnin 3505', is('turnin', 3505)), '#2390: 3505 taken at Ag\'tor before the base camp');
	assert.equal(az[az.length - 1].goal.quest, 5051, 'the Bulwark and Felstone Farm close the Azshara guide');
	const epl = g('50-60/05-eastern-plaguelands');
	assert.equal(epl.find(({ goal }) => goal.t === 'getfp').goal.location, "Light's Hope Chapel", "the Eastern Plaguelands guide opens at Light's Hope Chapel and learns its flight path");
	assert.deepEqual(epl.filter(({ goal }) => goal.t === 'accept').slice(0, 4).map(({ goal }) => goal.quest), [5542, 5543, 5544, 5281], "Tirion's hunts on the ride east (where their work is), then the chapel");
	assert.equal(g('50-60/06-silithus').find(({ goal }) => goal.t === 'accept').goal.quest, 8277, 'Silithus opens at Cenarion Hold');
	const fel = g('50-60/02-felwood');
	assert.ok(!fel.some(({ goal }) => [5402, 5403].includes(goal.quest)), "no Alliance Scourgestone turn-ins at Chillwind Camp");
	for (const q of [5202, 5203, 5204, 5385]) assert.ok(fel.filter(({ goal }) => goal.quest === q).every(({ step }) => (step.when || []).length), `${q}: only for players with the key`);
});

test('Horde quest volume: every added quest has its include record in the route fixes', () => {
	const ov = JSON.parse(fs.readFileSync(path.join(ROOT, 'data', 'route-fixes.json'), 'utf8')).overrides;
	// A quest the Alliance route skips can't be included for both sides (include has no faction): its Horde
	// record is a Horde pair that places it.
	const horde = (q) => ov.pairs.some((p) => p.faction === 'Horde' && p.b[1] === q && /Quest volume|take and do it there/.test(p.why));
	for (const q of new Set(Object.values(HORDE_VOLUME).flat())) assert.ok(ov.include.some((e) => e.q === q && /Flow coverage|Quest volume|Route grind review/.test(e.reason)) || horde(q), `include ${q} is recorded`);
});

// poro (#1065): Escorting Erland, a level 11 quest, came in the 16-19 Silverpine guide after a level 16.51
// target. Players run about a level above the route's targets (their recordings), so the level reached is
// rounded up: at 17 the quest is grey. It is taken while it still gives experience.
test('Every Horde route (#1065): Escorting Erland is taken before the route reaches the level at which it is grey', { skip }, () => {
	const qlvl = refData().quest(435).level;
	for (const { who, list } of routes('Horde')) {
		list.forEach((e, i) => {
			if (!is('accept', 435)(e.goal)) return;
			const targets = list.slice(0, i).filter(({ goal }) => goal.t === 'level').map(({ goal }) => goal.level + (goal.frac || 0));
			const reached = Math.max(compiled(e.guide).minLevel || 0, ...targets);
			assert.ok(greyLevel(Math.ceil(reached)) < qlvl, `${who}: ${where(e)} takes Escorting Erland (level ${qlvl}) at level ${reached}, where it is grey`);
		});
	}
});

// DexeeXI (#907): Gilthares Firebough walks straight back to Ratchet, so Northwatch Hold's kills come before
// his escort is accepted, and nothing else is worked between the accept and its end.
test("Every Horde route (DexeeXI, #907): Northwatch Hold is cleared before Gilthares's escort, which runs straight to Ratchet", { skip }, () => {
	for (const { who, list } of routes('Horde')) {
		list.forEach((e, i) => {
			if (!is('accept', 898)(e.goal)) return;
			const late = list.slice(i).find(({ goal }) => goal.quest === 891 && ['kill', 'collect'].includes(goal.t));
			assert.ok(!late, `${who}: ${late && where(late)} works Northwatch Hold (891) after the escort is taken at ${where(e)}`);
			const end = list.findIndex(({ goal }, j) => j > i && goal.quest === 898 && ['complete', 'turnin'].includes(goal.t));
			assert.ok(end > i, `${who}: the escort taken at ${where(e)} has an end`);
			for (const x of list.slice(i + 1, end)) assert.ok(!x.goal.quest || x.goal.quest === 898, `${who}: ${where(x)} works ${x.goal.t} ${x.goal.quest} during the escort`);
		});
	}
});

// Rohkin (#957), aVikingTrex (#1040): Mankrik's tusks were collected in the Bristleback camps before Tribes
// at War, then the same camps cleared again for it. Every Bristleback it asks for drops the tusks.
test('Every Horde route (Rohkin, #957): the Bristleback tusks are collected on the Tribes at War kills, never before it', { skip }, () => {
	for (const { who, list } of routes('Horde')) {
		const accept = list.findIndex(({ goal }) => is('accept', 878)(goal));
		if (accept < 0) continue;
		list.forEach((e, i) => {
			if (e.goal.quest !== 899 || e.goal.t !== 'collect') return;
			assert.ok(i > accept, `${who}: ${where(e)} collects the tusks before Tribes at War is taken at ${where(list[accept])}`);
			assert.ok(list.some((x) => x.guide === e.guide && x.s === e.s && x.goal.quest === 878 && x.goal.t === 'kill'), `${who}: ${where(e)} collects the tusks on a step without the Tribes at War kills`);
		});
	}
});

// soockee (#1051), Konky88 (#1150): Valuable Vantages was handed back in the step that took it, before its
// three vials were placed.
test('Every Horde route (#1051, #1150): Valuable Vantages is handed in only after each of its vials is placed', { skip }, () => {
	const objectives = refData().questObjectives(98095).map((o) => o.index);
	assert.equal(objectives.length, 3, 'the three vial objectives are in the data');
	for (const { who, list } of routes('Horde')) {
		list.forEach((e, i) => {
			if (!is('turnin', 98095)(e.goal)) return;
			const accept = list.slice(0, i).findLastIndex(({ goal }) => is('accept', 98095)(goal));
			assert.ok(accept >= 0, `${who}: ${where(e)} hands in Valuable Vantages that was never taken`);
			assert.ok(!(list[accept].guide === e.guide && list[accept].s === e.s), `${who}: ${where(e)} hands it in on the step that takes it`);
			for (const oi of objectives) assert.ok(list.slice(accept + 1, i).some(({ goal }) => goal.quest === 98095 && goal.oi === oi), `${who}: ${where(e)} hands it in with vial ${oi} never placed`);
		});
	}
});

// Konky88 (#1212): from Zoram'gar the guide flew a Troll Shaman to Camp Taurajo and walked on into Mulgore,
// for the Earthen Ring and Thunder Bluff. A character who knows Thunder Bluff's flight path flies there.
test('Every Horde route (#1212): no flight to Camp Taurajo on the way to Mulgore or Thunder Bluff when Thunder Bluff\'s flight path is known', { skip }, () => {
	const hops = [];
	for (const { who, list } of routes('Horde')) {
		const known = new Set();
		list.forEach((e, i) => {
			const { goal } = e;
			if (goal.t === 'fly' && goal.location === 'Camp Taurajo' && known.has('Thunder Bluff')) {
				const next = list.slice(i + 1).find((x) => x.goal.map != null && x.goal.t !== 'fly');
				if (next && [1412, 1456].includes(next.goal.map)) hops.push(`${who}: ${where(e)} flies to Camp Taurajo and then walks to ${where(next)} (map ${next.goal.map}), though Thunder Bluff's flight path is known`);
			}
			// Only a learnt path counts: a druid's flight from Nighthaven to Thunder Bluff teaches none.
			if (goal.t === 'getfp') known.add(goal.location);
		});
	}
	assert.deepEqual(hops, []);
});

// Bill (#1004): at Ratchet the guide sent you up to the inn to bind, then back down to Mebok Mizzyrix, who
// stands by the WANTED poster you had just read. The bind never splits two stops that stand side by side.
test('Every Horde route (Bill, #1004): the Ratchet bind never sends you back to where you stood before it', { skip }, () => {
	const { point } = makeProjector(refData().mapFrames);
	const pos = ({ goal }) => (goal.map != null && goal.x != null ? point(goal.map, goal.x, goal.y, goal.f === 'e' ? 'e' : 'l') : null);
	const yd = (a, b) => (a && b && a.c === b.c ? dist(a, b) : Infinity);
	for (const { who, list } of routes('Horde')) {
		list.forEach((e, i) => {
			if (e.goal.t !== 'sethome' || e.goal.location !== 'Ratchet') return;
			const prev = list.slice(0, i).reverse().find(pos);
			const next = list.slice(i + 1).find(pos);
			const bind = pos(e);
			if (!prev || !next || !bind) return;
			const back = yd(pos(prev), pos(next)) <= 40 && yd(pos(prev), bind) > 40;
			assert.ok(!back, `${who}: ${where(e)} binds at Ratchet's inn between ${prev.goal.t} ${prev.goal.quest || ''} and ${next.goal.t} ${next.goal.quest || ''}, which stand side by side`);
		});
	}
});

// Rohkin (#947), Darian (#992): after Regthar a Warlock walked into Stonetalon Mountains and straight back to
// the Barrens with nothing to do there. The same sweep found Tauren Druids walked from the Moonkin Stone to the
// Crossroads, back into Mulgore and out to the Crossroads again.
test('Every Horde route (Rohkin, #947): nobody is sent into another zone and straight back with nothing done there', { skip }, () => {
	const back = new Set();
	for (const { who, list } of routes('Horde')) {
		const steps = [];
		for (const e of list) {
			const last = steps.at(-1);
			if (last && last.guide === e.guide && last.s === e.s) last.goals.push(e.goal);
			else steps.push({ guide: e.guide, s: e.s, goals: [e.goal] });
		}
		const travel = (step) => step.goals.every((g) => g.t === 'goto' || g.t === 'fly');
		const mapOf = (step) => (step.goals.findLast((g) => g.map != null) || {}).map;
		for (let i = 1; i < steps.length; i++) {
			const from = mapOf(steps[i - 1]);
			if (from == null || mapOf(steps[i]) == null || !travel(steps[i]) || mapOf(steps[i]) === from) continue;
			for (let j = i + 1; j < steps.length && travel(steps[j]); j++) {
				if (mapOf(steps[j]) === from) back.add(`${who}: ${where(steps[i])} to ${where(steps[j])}: into map ${mapOf(steps[i])} and back to map ${from} with nothing done there`);
			}
		}
	}
	assert.deepEqual([...back], []);
});
test('Horde 30-40 re-order: the chain runs Hillsbrad, the Flats and Desolace, Stranglethorn, Dustwallow, Alterac and Arathi, the Badlands', { skip }, () => {
	const header = (g) => fs.readFileSync(path.join(ROOT, 'guides', g), 'utf8');
	const nextOf = (g) => (header(g).match(/^next (.*)$/m) || [])[1];
	assert.equal(nextOf('forever/horde/07-ashenvale.guide'), 'forever/horde/30-40/01-hillsbrad-foothills');
	for (let i = 0; i < H3040.length - 1; i++) assert.equal(nextOf(H3040[i]), H3040[i + 1].replace(/\.guide$/, ''), `${H3040[i]} leads to the next zone`);
	assert.equal(nextOf(H3040[5]), 'forever/horde/40-50/01-stranglethorn-vale');
	const retired = JSON.parse(fs.readFileSync(path.join(ROOT, 'guides', 'retired.json'), 'utf8'));
	for (const id of ['01-desolace', '02-stranglethorn-vale', '03-arathi-highlands']) assert.ok(retired.includes(`forever/horde/30-40/${id}`), `${id} is retired`);
	const [hills, tn, , dust, alterac] = H3040.map((g) => goals(g));
	const has = (list, t, q) => list.some(({ goal }) => goal.t === t && goal.quest === q);
	// Level tidy (2026-11-15): Hillsbrad keeps its 26-30 quests at 30; Tarren Mill's 33-36 quests and Hammerfall's chain
	// come on the 38-39 visit; the Hand of Iruxos goes with the portals on the second Desolace stop.
	for (const q of [529, 532, 539, 567]) assert.ok(has(hills, 'turnin', q), `${q} in the 29-31 guide`);
	assert.ok(!has(hills, 'turnin', 1434) && has(tn, 'turnin', 1434), 'Desolace is not entered at 30'); // Khan Dez'hepah (1365) moved to the 36-38 visit in the level tidy
	for (const q of [1105, 1176, 1175, 1147, 5361, 1150, 98070]) assert.ok(has(tn, 'turnin', q), `${q} with the Flats and Desolace`);
	for (const q of [5581, 5381]) assert.ok(has(dust, 'turnin', q) && !has(tn, 'turnin', q), `${q} on the second Desolace stop, at 38`);
	for (const q of [503, 533, 544, 651, 677, 97539]) assert.ok(has(alterac, 'turnin', q), `${q} on the 38-39 Alterac and Arathi visit`);
	const shells = at(tn, 'turnin 1105', is('turnin', 1105));
	assert.ok(shells < at(tn, 'accept 1106', is('accept', 1106)), 'Martek the Exiled taken after Hardened Shells');
	assert.ok(!has(goals('forever/horde/07-ashenvale.guide'), 'accept', 1106), 'not after Salt Flat Venom alone');
	// Short written grind steps (2026-11-07, Fitz): each skipped once the player is at its level, none above the next zone's quests.
	for (const g of H3040) {
		for (const { step, goal } of goals(g).filter(({ goal }) => goal.t === 'level')) {
			const want = (goal.level || 0) + (goal.frac || 0);
			assert.ok((step.when || []).some((p) => p.k === 'level' && p.op === '<' && !p.neg && Math.abs((p.n || 0) + (p.frac || 0) - want) < 0.6), `${g}: "${step.title}" is skipped at level ${want}`);
			assert.ok(want <= 37.5, `${g}: "${step.title}" stays a short top-up (${want})`);
		}
	}
	assert.ok(!dust.some(({ goal }) => [1166, 1168, 1169].includes(goal.quest) && goal.t === 'accept'), 'the level-43 Brackenwall quests are left for the 40-50 Dustwallow visit');
});

// Since the 0.4.0 level tidy Jandia's two harpy quests are worked on the next Freewind visit at about 31 (30-40/02)
// (Roguefeather Den's harpies 28-30 and Grenka 31 were met at 29 in 07-ashenvale); since the 0.4.0 audit 07 takes them on
// its last Freewind stop, where the route stands beside Jandia: the pairing holds where they are taken and worked.
test('Horde: Stolen Freewind Supplies with Stop the Screeching, in the same harpy den', { skip }, () => {
	const guides = ['forever/horde/07-ashenvale.guide', 'forever/horde/30-40/01-hillsbrad-foothills.guide', 'forever/horde/30-40/02-thousand-needles.guide'];
	const ga = guides.find((f) => goals(f).some(({ goal }) => goal.t === 'accept' && goal.quest === 98070));
	const g = guides.find((f) => goals(f).some(({ goal }) => goal.t === 'kill' && goal.quest === 98070));
	assert.ok(ga && g, 'a Horde guide takes Stop the Screeching and one works it');
	assert.ok(!goals('forever/horde/07-ashenvale.guide').some(({ goal }) => [98069, 98070].includes(goal.quest) && goal.t !== 'accept'), 'not worked at 29 in 07-ashenvale');
	const al = goals(ga);
	assert.equal(al[at(al, 'accept 98069', is('accept', 98069))].s, al[at(al, 'accept 98070', is('accept', 98070))].s, 'taken from Jandia with Stop the Screeching');
	const list = goals(g);
	const step = (t, q) => list[at(list, `${t} ${q}`, is(t, q))].s;
	assert.equal(list[at(list, 'collect 279383', (x) => x.t === 'collect' && x.quest === 98069)].s, list[at(list, 'kill 4101', (x) => x.t === 'kill' && x.quest === 98070)].s, 'the supplies in the Screeching Canyon step');
	assert.equal(step('turnin', 98069), step('turnin', 98070), 'handed in with it');
});

// --- Horde 40-60 accept levels (2026-11-08). The level model ground before accepts it could not take at the route's
// level (a minimum level above it, or a quest 5+ levels over): 1,287 minutes for an Orc Warrior, 409 of them in Feralas
// at 46 for The Strength of Corruption (minimum 47). Each is now taken on a later stop at the same giver, or a written
// top-up at the spot before it brings the level.
test('Horde 40-60 accept levels: quests are taken where the route reaches their level', { skip }, () => {
	const g = (n) => goals(`forever/horde/${n}.guide`);
	const step = (list, t, q) => list[at(list, `${t} ${q}`, is(t, q))].s;
	const stv = g('40-50/01-stranglethorn-vale');
	// #2102 (0.4.0 audit): the Wild Shore pass moved after the Cape coast. Horde 0.4.0 audit (round 2): Stranglethorn
	// Fever is offered from level 40 and the route reaches the cove's Booty Bay stop at 39.9 (level model), so it is
	// taken on the second Booty Bay stop with Shaky Phillipe; Mistvale's gorilla fangs are kept in the bags before it.
	assert.equal(step(stv, 'accept', 348), step(stv, 'turnin', 606), 'Stranglethorn Fever on the second Booty Bay stop');
	// Since the 0.4.0 audit Tran'rek and Kebok's tusks are on 40-50/02's Booty Bay call (Stranglethorn after the
	// Riverglades), and Speaking with Gan'zulah (level 46) is taken at the cauldron there, right before its
	// Skullsplitters, so no top-up to 41 at Zul'Kunda.
	for (const q of [348, 2872]) assert.ok(step(stv, 'accept', q) > step(stv, 'turnin', 595), `${q} not on arrival`);
	assert.ok(!stv.some(({ goal }) => is('accept', 586)(goal) || is('accept', 2864)(goal)), "586 and Tran'rek are not taken at 40-42");
	const fer2 = g('40-50/02-feralas');
	assert.equal(step(fer2, 'accept', 2864), step(fer2, 'turnin', 209), "Tran'rek with Kebok's tusks");
	assert.ok(at(fer2, 'accept 586', is('accept', 586)) < at(fer2, 'kill 586', (x) => x.t === 'kill' && x.quest === 586), '586 taken before its Skullsplitters');
	assert.ok(!g('40-50/03-feralas').some(({ goal }) => is('accept', 4120)(goal)), 'The Strength of Corruption is not taken at 46');
	const azs = g('40-50/06-azshara');
	assert.equal(step(azs, 'accept', 4120), step(azs, 'turnin', 3123), "The Strength of Corruption from Talo on the Mojache stop at 49-50");
	// Since the 0.4.0 level tidy there is no grind to 50 in Azshara for one delivery: March of the Silithid is taken in
	// Orgrimmar only once you are 50 (50-60/04's Orgrimmar stop offers it again).
	const t50z = azs.findIndex(({ goal }) => goal.t === 'level' && goal.level === 50);
	assert.ok(t50z < 0 || t50z > at(azs, 'accept 4494', is('accept', 4494)), 'no top-up to 50 before the Orgrimmar stop');
	assert.ok(azs[at(azs, 'accept 4494', is('accept', 4494))].step.when.some((p) => p.k === 'level'), 'March of the Silithid only once level 50');
	const ung = g('50-60/01-un-goro-crater');
	const top = ung.findIndex(({ goal }) => goal.t === 'level' && goal.level === 51);
	assert.ok(top >= 0 && top < at(ung, 'kill 4501.1', (x) => x.t === 'kill' && x.quest === 4501), "Un'Goro's top-up reaches 51 before the crater's loop (Pterrordax and Flayers up to 52)");
	const sil = g('50-60/06-silithus');
	const t58 = sil.findIndex(({ goal }) => goal.t === 'level' && goal.level === 58);
	assert.ok(t58 >= 0 && t58 < at(sil, 'accept 8304', is('accept', 8304)), 'a top-up to 58 before Dearest Natalia');
	// Since 0.3.7 the texts are gathered once Secret Communication (minimum 57) is in the log: the accept comes after the top-up.
	assert.ok(t58 < at(sil, 'accept 8318', is('accept', 8318)), 'Secret Communication taken at 58');
});

// Tips that pointed the wrong way: the Ironjaw Basilisks lie north of Booty Bay on the road back to Grom'gol ("follow
// the road south"); the Altar of Zul is south-west of Valorwind Lake ("on the way back east"); Rogue Vale opens just
// north of Zorbin's dock ("ride west into the middle of Feralas"); Felstone Farm is reached from the Bulwark, where the
// step before ends ("leave the Undercity"). Marvon's step had the same direction twice.
test('Horde 40-60 final review: tips point the way the route goes', { skip }, () => {
	const H = (n) => `forever/horde/${n}.guide`;
	// The Singing Crystals are done on 40-50/02's Grom'gol stop since the 0.4.0 audit, on the ride south to Booty Bay.
	const basilisks = stepTips(H('40-50/02-feralas'), /collect 3911 quest 589/).join(' ');
	assert.match(basilisks, /Ride south along the road towards Booty Bay/);
	assert.doesNotMatch(basilisks, /north out of Booty Bay/);
	assert.equal(stepTips(H('40-50/06-azshara'), /turnin 3380/).length, 1, "one tip at Marvon's camp");
	assert.doesNotMatch(stepTips(H('40-50/05-the-hinterlands'), /kill 2925 quest 7828/).join(' '), /back east/);
	assert.doesNotMatch(stepTips(H('40-50/03-feralas'), /(kill|talk) 8612 quest 3520/).join(' '), /Ride west/);
	assert.doesNotMatch(stepTips(H('50-60/01-un-goro-crater'), /accept 5021/).join(' '), /Leave the Undercity/);
});

// Main's grind policy (2026-11-08): every written grind step ("Level N" top-ups and solo fallbacks) ends its tip with
// the dungeons whose band holds N ("Or, with a group, run the <Name> dungeon instead."), the sentence the forge writer writes from the next build. Horde 40-60 by hand.
// 0.4.0 audit: Horde 40-50's grind steps follow the dungeons-in-the-route rule instead (a dungeon only when its run is in
// the same or the next guide on that continent: "Horde 40-50: grind tips name a dungeon only when its run is..."), so
// this checks 50-60.
test('Horde 50-60: every grind step offers the dungeons at its level', { skip }, () => {
	const files = fs.readdirSync(path.join(OFFICIAL_DIR, 'forever/horde/50-60')).map((f) => `forever/horde/50-60/${f}`);
	let n = 0;
	for (const file of files) {
		const lines = fs.readFileSync(path.join(OFFICIAL_DIR, file), 'utf8').split('\n');
		lines.forEach((l, i) => {
			const m = l.match(/^step Level ([\d.]+)$/);
			if (!m) return;
			n++;
			const tips = stepTips(file, new RegExp(`^step Level ${m[1].replace('.', '\\.')}$`)).join(' ');
			assert.match(tips, /Or, with a group, run the [A-Z][^.]* dungeon( \([A-Za-z ]+\))? instead\.$/, `${file}:${i + 1}`);
			if (Math.floor(+m[1]) >= 58) assert.match(tips, /Scholomance/, `${file}:${i + 1}: a 58-60 dungeon`);
		});
	}
	// 0.3.7 folded six stand-alone top-ups into the quest steps beside them (the test below checks those tips); the 0.4.0
	// level tidy dropped the Felwood guide's 52.63 and 53 and the Winterspring guide's 55.04 (seven left in 50-60), and
	// the Horde 0.4.0 audit (round 2) made Felwood's fractional top-ups two whole levels: 54 in the Irontree Woods quest
	// step (checked by "grind steps sit on mobs an open quest needs") and a stand-alone 55 (six left).
	assert.ok(n >= 6, `the grind steps are found (${n})`);
});

// Final route review (0.3.6): the Tauren Shaman's first Telf Joolam step said he waits on the riverbank; he keeps his
// shrine at the top of a narrow mountain trail on the Durotar side, as every other Telf step says.
test('Horde Call of Fire: every Telf Joolam step sends the player up the mountain trail, never to a riverbank', { skip }, () => {
	for (const f of ['forever/horde/02-the-barrens.guide', 'forever/horde/orc/01-durotar.guide', 'forever/horde/troll/01-durotar.guide']) {
		const src = fs.readFileSync(path.join(OFFICIAL_DIR, f), 'utf8');
		assert.doesNotMatch(src, /Telf waits on the riverbank/, `${f}: no riverbank Telf`);
	}
	const src = fs.readFileSync(path.join(OFFICIAL_DIR, MULGORE), 'utf8');
	const first = src.split('\nstep ').find((s) => s.startsWith('Telf Joolam') && /turnin 1524/.test(s));
	assert.match(first, /trail climbs the mountain/, 'the Tauren Shaman is told about the trail');
});

// Final route review, Horde 40-60 (0.3.6): a quest ready to hand in is handed in on the city stop that walks past its
// ender. A Grim Discovery (2976) went to Belgrom in the Valley of Honor five levels later, and Bone-Bladed Weapons
// (4300, ravasaur claws from Un'Goro) to Jes'rimon three levels later, though the route trains in Orgrimmar first.
test('Horde 45 and 53 Orgrimmar stops: Belgrom and Jes\'rimon take their ready hand-ins on the way through', { skip }, () => {
	const fer = goals('forever/horde/40-50/03-feralas.guide');
	const grim = fer[at(fer, 'turnin 2976', is('turnin', 2976))].s;
	assert.equal(grim, fer[at(fer, 'turnin 7732', is('turnin', 7732))].s, 'Belgrom on the Orgrimmar stop after Feralas');
	assert.equal(grim, fer[at(fer, 'turnin 3121', is('turnin', 3121))].s, 'with Neeru, same stop');
	const fel = goals('forever/horde/50-60/02-felwood.guide');
	const jes = fel[at(fel, 'turnin 4300', is('turnin', 4300))];
	assert.ok(jes.step.when.some((p) => p.k === 'onquest' && !p.neg), 'only with the claws\' quest in the log');
	assert.ok(jes.s < fel[at(fel, 'fly Splintertree Post', (g) => g.t === 'fly')].s, 'before the flight out of Orgrimmar');
});

// Final route review, Horde 40-60 (0.3.6): an objective that is listening to or questioning a friendly NPC was
// written as a kill goal, so the window read "Kill Velarok Windblade", "Kill Fallen Hero of the Horde", "Kill Frankal
// Stonebridge". They are talk goals.
test('Horde 40-60: listen and question objectives say Talk to, never Kill', { skip }, () => {
	for (const [file, quest, npcs] of [
		['forever/horde/40-50/04-tanaris.guide', 3441, [8479]],
		['forever/horde/40-50/05-the-hinterlands.guide', 2784, [7572]],
		['forever/horde/50-60/06-silithus.guide', 8304, [15171, 15170]],
	]) {
		const list = goals(file);
		assert.ok(!list.some(({ goal }) => goal.t === 'kill' && goal.quest === quest), `${file}: no kill goal for ${quest}`);
		for (const npc of npcs) at(list, `${file}: talk ${npc} quest ${quest}`, (g) => g.t === 'talk' && g.npc === npc && g.quest === quest);
	}
});

// Final route review, Horde 40-60 (0.3.6): a bare walk to a stop that only some players have work at. The walk to
// the Musty Scroll (Cortello's Riddle, optional) and the walk to Orgrimmar's flight master ahead of the Runecloth
// hand-ins sent everyone there; each now holds only for the players the stop is for.
test('Horde 40-60: walks to an optional stop are gated like the stop', { skip }, () => {
	const fer = compiled('forever/horde/40-50/03-feralas.guide').steps;
	const scroll = fer.find((st) => st.goals.some((g) => g.t === 'goto' && g.x === 31.1 && g.y === 66.1));
	assert.ok(scroll && (scroll.when || []).some((p) => p.k === 'onquest' && !p.neg), 'the Musty Scroll walk only with Cortello\'s Riddle in the log');
	const fw = compiled('forever/horde/50-60/07-felwood.guide').steps;
	const walk = fw.findIndex((st) => st.goals.length === 1 && st.goals[0].t === 'goto' && st.goals[0].x === 45.3 && st.goals[0].y === 63.7);
	// (The Runecloth donations are handed in on the spot, #1699: ready means the bags hold the sixty Runecloth.)
	assert.ok(walk >= 0 && (fw[walk].when || []).some((p) => p.k === 'has' && p.neg), 'the walk to the flight master is skipped when a Runecloth hand-in is ready');
});

// Fresh-start sweep (0.3.6, every guide stands on its own): a Horde player loading 40-50/06 Azshara or
// 50-60/04 Azshara fresh, without March of the Silithid (4494, from the Feralas guides' Rise of the Silithid) or
// Better Late Than Never (5023, from 50-60/01), was shown "Requires ..." on Bungle in the Jungle (4496) and on
// Good Luck Charm and Two Halves Become One (5050, 5051). Each accept now waits for its quest to be available, and
// the hand-ins and the charm's work for it to be in the log, as 50-60/02 Felwood does for Arko'narin.
test('Horde Azshara guides: chain accepts from an earlier guide wait until the quest is available', { skip }, () => {
	const holds = (steps, q, k) => steps.some((st) => st.goals.some((g) => g.quest === q && g.t === 'accept') && (st.when || []).some((p) => p.k === k && !p.neg && [].concat(p.q).includes(q)));
	const az = compiled('forever/horde/40-50/06-azshara.guide').steps;
	assert.ok(holds(az, 4496, 'available'), 'Bungle in the Jungle only when available');
	const az2 = compiled('forever/horde/50-60/04-azshara.guide').steps;
	for (const q of [5049, 5050, 5051]) assert.ok(holds(az2, q, 'available'), `${q} only when available`);
	const work = az2.find((st) => st.goals.some((g) => g.t === 'turnin' && g.quest === 5051));
	assert.ok((work.when || []).some((p) => p.k === 'onquest' && !p.neg && [].concat(p.q).includes(5051)), 'the charm\'s work only with 5051 in the log');
});

// Final route review leftovers, Horde 40-60 (0.3.6): The Super Egg-O-Matic (2741, level 47) was taken at about 56.5 in
// 50-60/05 (about a fifth of its 4200 XP there) with a Camp Mojache -> southern nests -> Camp Mojache ride. 40-50/04
// passes the Egg-O-Matic at 47 and 40-50/06 kills the Frayfeather hippogryphs a short ride north of the nests, then
// flies to Gadgetzan: taken, worked and handed in there, the 50-60/05 nests step is only for a character still carrying it.
test('Horde 40-50: The Super Egg-O-Matic is taken in Tanaris at 47 and finished in 40-50/06, not with a Feralas ride at 56', { skip }, () => {
	const tan = goals('forever/horde/40-50/04-tanaris.guide');
	assert.ok(!tan.some(({ goal }) => is('accept', 2741)(goal)), 'handed in on the spot (#1699): nothing to take in Tanaris');
	const az = goals('forever/horde/40-50/06-azshara.guide');
	const fray = at(az, 'the Frayfeather hippogryphs', (g) => g.t === 'use' && g.quest === 3124);
	const egg = at(az, 'the Hippogryph Egg', (g) => g.t === 'collect' && g.item === 8564);
	const uzeri = at(az, "turnin 3124 (Uzer'i)", is('turnin', 3124));
	assert.ok(fray < egg && egg < uzeri, 'the nests right after the hippogryphs, before Camp Mojache');
	assert.ok((az[egg].step.when || []).some((p) => p.k === 'available' && !p.neg), 'the nests only while the Egg-O-Matic takes an egg');
	const tin = az[at(az, 'turnin 2741', is('turnin', 2741))];
	// The Gadgetzan stop is split in steps (Pestlezugg's `when available` accept is its own step since the E1 sweep,
	// the Egg-O-Matic's hand-in its own since #2561's sweep): the hand-in is on the stop that hands March of the
	// Silithid to Pestlezugg, at most three steps after it, with no travel in between.
	const march = az[at(az, 'turnin 4494', is('turnin', 4494))];
	assert.ok(tin.s >= march.s && tin.s - march.s <= 3, 'on the Gadgetzan stop');
	const between = compiled('forever/horde/40-50/06-azshara.guide').steps.slice(march.s - 1, tin.s);
	assert.ok(between.every((st) => !st.goals.some((g) => ['fly', 'goto', 'hearth'].includes(g.t))), 'no travel between Pestlezugg and the Egg-O-Matic');
	const epl = goals('forever/horde/50-60/05-eastern-plaguelands.guide');
	assert.ok(!epl.some(({ goal }) => is('accept', 2741)(goal)), '50-60/05 no longer takes it');
	assert.ok(!epl.some(({ goal }) => goal.t === 'collect' && goal.item === 8564), 'no nests step in 50-60/05');
});

// The danger gate's grind rule (#2207): a top-up whose camp stands 2+ levels over the player when it starts. Five Horde
// top-ups move to a camp at most a level over the player, at the same place or a short ride off; the top-up on the
// Diseased Grizzlies (55-56) becomes one to 53 on the Carrion Lurkers (52-53) on the way to Mulgris, who sends you to
// the bears, so they are fought at 53. (Level tidy 0.4.0: Ashenvale's top-up to 29.49 on the Screeching Harpies left
// with Roguefeather Den, which Thousand Needles' first Freewind visit now does at 31.)
test('Horde grind top-ups stand on camps at most a level over the player (#2207)', { skip }, () => {
	for (const [guide, title, npc] of [
		['forever/horde/30-40/02-thousand-needles.guide', 'Level 32', 4140],
		// The 0.4.0 level tidy dropped the Felwood guide's top-up to 53 and the Winterspring guide's to 55 (Careful tips at
		// range-top camps instead); the crater's top-up to 51 and the Plaguelands' to 56 stand on camps under the player.
		['forever/horde/50-60/01-un-goro-crater.guide', 'Level 51', 6511],
		['forever/horde/50-60/05-eastern-plaguelands.guide', 'Level 56', 8601],
		['forever/horde/50-60/06-silithus.guide', 'Level 58', 11741],
	]) {
		const step = compiled(guide).steps.find((s) => s.title === title);
		assert.ok(step, `${guide}: ${title}`);
		const goal = step.goals.find((g) => g.t === 'level');
		assert.equal(goal && goal.grind, npc, `${guide}: ${title} grinds on npc ${npc}`);
	}
	// Since the 0.4.0 level tidy Mulgris' Diseased Grizzlies (55-56) wait for the Silithus guide's Writhing Haunt stop (about 59).
	const fel = compiled('forever/horde/50-60/02-felwood.guide').steps;
	assert.ok(!fel.some((s) => s.goals.some((g) => g.quest === 4985)), 'no Diseased Grizzlies in 02');
	assert.ok(goals('forever/horde/50-60/06-silithus.guide').some(({ goal }) => is('turnin', 4985)(goal)), 'handed in on the Silithus guide');
});
