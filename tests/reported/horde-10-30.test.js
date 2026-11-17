'use strict';
// Player-reported guide fixes: the Horde leveling guides to 30 (guides/forever/horde/NN-*.guide).
// tests/reported/helpers.js says what the cases check and where a new one goes.

const { test } = require('node:test');
const assert = require('node:assert/strict');
const fs = require('node:fs');
const path = require('node:path');
const {
	allGuides, ASHENVALE_HORDE, at, BARRENS, BARRENS_12, compiled, everyone, flightHops, forClass, forRaceOf, goals,
	HILLSBRAD_HORDE, is, loadCorrections, located, needs, OFFICIAL_DIR, questGoalStatus, refData, ROOT, SILVERPINE, skip,
	stepTips, STONETALON, STONETALON_HORDE, where, yards,
} = require('./helpers');

// --- Flights with nothing to do in between (#1191): a flight to a stop where nothing is left for the
// character to do, then straight on by another flight, is one flight to the second one's end (the game routes
// it through the first stop). The same rule as `forge guide lint`'s (validate.rs, check_flight_hops), per
// race and class: a `when` or any work between keeps the stop, a flight without a flight master to leave from
// (a druid's Moonglade flight) and a walk onto another continent (a boat, a zeppelin) end the check.

const FLIGHT_RACES = { horde: ['Orc', 'Scourge', 'Tauren', 'Troll', 'Skyborne'], alliance: ['Human', 'Dwarf', 'NightElf', 'Gnome', 'Skyborne'] };
const FLIGHT_CLASSES = ['WARRIOR', 'PALADIN', 'HUNTER', 'ROGUE', 'PRIEST', 'SHAMAN', 'MAGE', 'WARLOCK', 'DRUID'];

test('Horde poisons: the mainline contact instructions use the supplied flare gun before saluting Fizzule', { skip }, () => {
	const list = goals(STONETALON);
	const contact = list[at(list, 'contact Fizzule', is('turnin', 2458))].step;
	const flare = contact.note.indexOf('{item:8051}');
	assert.ok(flare >= 0 && flare < contact.note.indexOf('/salute'), 'signal with the quest item before saluting');
	assert.match(contact.note, /\bTWO\b.*flares/i, 'the quest requires two signals');
});

// Hand-in sweep (2026-11-16, after Kerlonian's escort): A Void Path (98252) had the Eye of Kilrogg's flight to the
// road only in the tip, so the window showed the hand-in alone. The step lists the objective before it.
test(`${STONETALON}: A Void Path shows the Eye of Kilrogg's objective before its hand-in`, { skip }, () => {
	const list = goals(STONETALON);
	const accept = at(list, 'accept 98252', is('accept', 98252));
	const work = at(list, 'complete 98252', is('complete', 98252));
	const turnin = at(list, 'turnin 98252', is('turnin', 98252));
	assert.ok(accept < work && work < turnin, 'accept, the objective, then the hand-in');
	assert.equal(list[work].s, list[turnin].s, 'in the hand-in step');
});

// Jackal's report (#2580): Kuray'bin stands where the "Into Ashenvale" walk ends and offers Ashenvale Outrunners
// (6503), which the route leaves for the next Ashenvale guide; a player who took it anyway had no line for the nine
// Outrunners, only a hand-in once they were dead. Whoever carries it gets the kills and the hand-in right after
// Splintertree Post (`when onquest 6503`); nobody else sees them.
test(`${STONETALON}: Jackal's report (#2580): Ashenvale Outrunners taken at Kuray'bin gets its kills, only for whoever carries it`, { skip }, () => {
	const list = goals(STONETALON);
	assert.ok(!list.some(({ goal }) => is('accept', 6503)(goal)), 'the route still leaves it for the next Ashenvale visit');
	const kills = at(list, 'kill 12856 (6503.1)', (g) => g.t === 'kill' && g.quest === 6503 && g.npc === 12856);
	const turnin = at(list, 'turnin 6503', is('turnin', 6503));
	assert.ok(at(list, 'turnin 6382', is('turnin', 6382)) < kills && kills < turnin, 'after Splintertree Post: the kills, then Kuray\'bin');
	assert.ok(turnin < at(list, 'accept 98251', is('accept', 98251)), 'before the walk west to Va\'xug');
	for (const i of [kills, turnin]) {
		assert.ok((list[i].step.when || []).some((p) => p.k === 'onquest' && !p.neg && [].concat(p.q).includes(6503)), `${list[i].goal.t}: only while 6503 is in the log`);
	}
});
test(`${STONETALON}: the Warsong update goals name the scouts who hand them over, from the data`, { skip }, () => {
	const list = goals(STONETALON);
	// The Warsong Reports (6543) is left out since the final route review (route-fixes skip); holds if a build takes it.
	if (!list.some(({ goal }) => goal.quest === 6543)) return;
	for (const [item, npc, name] of [[16764, 12862, 'Warsong Scout'], [16763, 12863, 'Warsong Runner'], [16765, 12864, 'Warsong Outrider']]) {
		const { goal } = list[at(list, `collect ${item} (${name})`, (g) => g.t === 'collect' && g.item === item)];
		assert.deepEqual(goal.fromNpcs, [{ npc, npcName: name }], `${name} is the goal's hand-over NPC`);
	}
});

// Horde 1-30 audit (#1414): a step gated `when group <quest>` holds only players who answered "Do it with a group",
// but a step whose every goal is `optional` is done at once (Engine Own.holds), so those players were walked past the
// accept, the elite and the hand-in with no arrow (WANTED: Bruuz, Aggor the Young, WANTED: Vulgara). Every Horde
// 1-30 guide: no `when group` step of optional goals only (sweep: ~/work/maintainer/group-optional-sweep).
test('Horde 1-30: a `when group` step has a goal that holds it, so a player who chose the group way is led through it (#1414)', () => {
	const GOAL = /^\s+(accept|turnin|kill|collect|interact|use|complete|escort|goto|talk|task|buy|fly|level|train|vendor|enter|die)\b/;
	const files = allGuides().filter((f) => /^forever\/horde\/(0[2-7]-|orc\/|troll\/|tauren\/|undead\/|skyborne\/)/.test(f));
	assert.ok(files.length >= 11, 'the Horde 1-30 guides are found');
	const bad = [];
	for (const f of files) {
		const steps = fs.readFileSync(path.join(OFFICIAL_DIR, f), 'utf8').split(/\n(?=step\b)/);
		for (const s of steps) {
			const lines = s.split('\n');
			const goalLines = lines.filter((l) => GOAL.test(l));
			if (lines.some((l) => /^\s+when\s+group\b/.test(l)) && goalLines.length && goalLines.every((l) => /\boptional\b/.test(l.split('--')[0]))) bad.push(`${f}: ${lines[0]}`);
		}
	}
	assert.deepEqual(bad, []);
});

// Horde 1-30 audit (#1414): the zeppelin starts walk past Brill and Deathguard Linnea's camp on the way to Silverpine;
// Hadric Harlson's Argent quests are done there, before the Sepulcher.
test('forever/horde/03-silverpine-forest.guide: Orcs take the Argent quests in Tirisfal on the way to the Sepulcher (#1414)', { skip }, () => {
	const forOrc = ({ step, goal }) => [step.only, goal.only].every((o) => !o || !o.races || o.races.includes('Orc'));
	const list = goals('forever/horde/03-silverpine-forest.guide').filter(forOrc);
	const sepulcher = at(list, 'getfp The Sepulcher', (g) => g.t === 'getfp' && /Sepulcher/.test(g.location || ''));
	for (const q of [96895, 445, 96897, 96898]) assert.ok(at(list, `accept ${q}`, is('accept', q)) < sepulcher, `${q} is taken before the Sepulcher`);
	for (const q of [96897, 96898]) assert.ok(at(list, `turnin ${q}`, is('turnin', q)) < sepulcher, `${q} is handed in before the Sepulcher`);
	assert.ok(at(list, 'turnin 445', is('turnin', 445)) > sepulcher - 1, 'Renferrel takes the delivery at the Sepulcher');
});

// Horde 1-30 audit (#1414): Undead Paladins at 15 and 22 were sent from Orgrimmar to Thunder Bluff's paladin trainer.
test('Horde 1-30: no Paladin training step waits in Orgrimmar, which has no paladin trainer (#1414)', { skip }, () => {
	for (const guide of ['forever/horde/03-silverpine-forest.guide', 'forever/horde/05-stonetalon-mountains.guide']) {
		const bad = goals(guide).filter(forClass('PALADIN')).filter(({ goal }) => goal.t === 'train' && goal.class && goal.zone === 1454);
		assert.deepEqual(bad.map(({ s }) => s), [], `${guide}: no Paladin train goal on the Orgrimmar map`);
	}
});

// Horde 1-30 audit (#1414): Wrongly Blamed, Justly Corrected's camp is a few steps east of Gann Stonespire.
test('forever/horde/04-the-barrens.guide: Logmar\'s quest is taken in Camp Taurajo, done by Gann\'s camp, handed in on the way back (#1414)', { skip }, () => {
	const list = goals('forever/horde/04-the-barrens.guide');
	const take = at(list, 'accept 97250', is('accept', 97250));
	const kill = at(list, 'kill 268622', (g) => g.t === 'kill' && g.quest === 97250);
	const gann = at(list, 'accept 843', is('accept', 843));
	const back = at(list, 'turnin 97250', is('turnin', 97250));
	assert.ok(take < gann && gann < kill && kill < back, 'Camp Taurajo, Gann, the camp, back');
	assert.ok(Math.hypot(list[kill].goal.x - 48.8, list[kill].goal.y - 77.0) < 1, 'at the recorded camp');
});

test(`forever/horde/02-the-barrens.guide: Orcs and Trolls take the Crossroads quests on the stop they arrive at from Far Watch Post`, { skip }, () => {
	for (const race of ['Orc', 'Troll']) {
		const forRace = ({ step, goal }) => [step.only, goal.only].every((o) => !o || !o.races || o.races.includes(race));
		const list = goals('forever/horde/02-the-barrens.guide').filter(forRace);
		// Far Watch Post (Kargal, Uzzek) comes first on the walk from Orgrimmar; the Crossroads stop takes Meats to Orgrimmar.
		const first = list[at(list, `${race}: accept 6365`, is('accept', 6365))].step;
		assert.ok(list.findIndex(({ goal }) => is('accept', 842)(goal)) < list.findIndex(({ step }) => step === first), `${race}: Far Watch Post (Crossroads Conscription) before the Crossroads`);
		for (const [t, q] of [['accept', 6365], ['turnin', 842], ['accept', 844], ['accept', 869], ['accept', 1492], ['accept', 848], ['turnin', 6365], ['accept', 5041], ['accept', 871], ['accept', 867]]) {
			assert.ok(list.some(({ step, goal }) => step === first && is(t, q)(goal)), `${race}: ${t} ${q} on the first Crossroads stop`);
		}
		assert.ok(list.some(({ step, goal }) => step === first && goal.t === 'getfp' && goal.location === 'Crossroads'), `${race}: the Crossroads flight path on that stop`);
	}
});

test('Hotline\'s report: Walton and Vrang\'s quests come in the order the game offers them', { skip }, () => {
	const list = goals(BARRENS);
	const order = [
		['accept', 95494], ['accept', 95507], ['turnin', 95494], ['turnin', 95507],
		['accept', 95495], ['turnin', 95495], ['accept', 95621], ['turnin', 95621],
		['accept', 95508], ['complete', 95508], ['turnin', 95508],
	].map(([t, q]) => at(list, `${t} ${q}`, is(t, q)));
	assert.deepEqual(order, [...order].sort((a, b) => a - b), 'each goal comes after the one before it in the chain');
});

// #1959 (a level 19 Undead Warlock): Vrang Wildgore's two quests came on a second trip to the Dry Hills, though
// he camps beside the harpies and the raptor-horn spot of the first one. Bruised Pride and Lion Hides and Vrang's
// Game are taken, worked and handed in on the first Dry Hills loop, between the harpies' rings and their hand-in to
// Darsok; the second trip carries Serena Bloodfeather (offered only with that hand-in) and Walton's chain.
test(`${BARRENS}: #1959: Vrang's two quests are done on the first Dry Hills loop, with the harpies`, { skip }, () => {
	const list = goals(BARRENS);
	const rings = at(list, 'collect 875 (Harpy Lieutenants)', is('collect', 875));
	const lieutenants = at(list, 'turnin 875', is('turnin', 875));
	for (const [t, q] of [['accept', 95494], ['accept', 95507], ['collect', 95494], ['collect', 95507], ['turnin', 95494], ['turnin', 95507]]) {
		const i = at(list, `${t} ${q}`, is(t, q));
		assert.ok(rings < i && i < lieutenants, `${t} ${q} is on the harpies' loop (goal ${i}, rings ${rings}, hand-in ${lieutenants})`);
	}
	const serena = at(list, 'collect 876 (Serena Bloodfeather)', is('collect', 876));
	assert.ok(lieutenants < serena, 'Serena comes on the later visit');
	assert.ok(lieutenants < at(list, 'turnin 95495 (Walton)', is('turnin', 95495)), 'Walton too');
});

// --- The Barrens (Fitz, a Scourge Warlock, #70): at the Crossroads the guide
// sent them to Sergra Darkthorn for Jorn Skyseer (3261), which needs The
// Angry Scytheclaws (905), the end of her chain in forever/horde/02-the-barrens.
// Without it the accept and Jorn's turn-in read as skipped from the start, so
// neither the focus nor the arrow goes there; with it they are open.
test(`${BARRENS}: Fitz's report: Jorn Skyseer is passed by while The Angry Scytheclaws is missing, and open once it is done`, { skip }, () => {
	const warlock = { race: 'Scourge', raceName: 'Undead', faction: 'Horde', cls: 'WARLOCK', className: 'Warlock', level: 21 };
	const accept = at(goals(BARRENS), 'accept 3261 (Jorn Skyseer)', is('accept', 3261));
	assert.deepEqual(goals(BARRENS)[accept].goal.pre, [905], 'Jorn Skyseer needs The Angry Scytheclaws');
	// Since the Horde 12-30 re-chain The Angry Scytheclaws is in the same guide, so without it Jorn Skyseer
	// waits (pending) rather than reading as skipped; either way neither goal is open.
	const missing = questGoalStatus(BARRENS, 3261, warlock);
	assert.equal(missing.length, 2);
	assert.ok(missing.every((s) => / (skipped|pending)$/.test(s)), `without 905 Jorn Skyseer is not open: ${missing.join(', ')}`);
	const done = questGoalStatus(BARRENS, 3261, warlock, { skills: 'w.complete({ 905 })' });
	assert.equal(done.length, 2);
	assert.ok(done.every((s) => !s.endsWith(' skipped') && !s.endsWith(' na')), `with 905 done Jorn Skyseer is open: ${done.join(', ')}`);
});

// Miguel Antunes (#592): the Ishamuhale step sent them straight at the raptor,
// but he only comes when a Fresh Zhevra Carcass (10338, looted from a zhevra)
// is used at the Dead Tree (object 164644; the item's Summon Ishamuhale needs
// that spell focus in the Forever client). The carcass is looted, then used at
// the tree, before the Fang.
test(`${BARRENS}: Miguel Antunes's report (#592): loot a zhevra carcass and use it at the Dead Tree before Ishamuhale's Fang`, { skip }, () => {
	const list = goals(BARRENS);
	const carcass = at(list, 'collect 10338 (Fresh Zhevra Carcass)', (g) => g.t === 'collect' && g.item === 10338);
	const use = at(list, 'use 10338 (at the Dead Tree)', (g) => g.t === 'use' && g.item === 10338);
	const fang = at(list, 'collect 5101 (Ishamuhale\'s Fang)', (g) => g.t === 'collect' && g.item === 5101);
	assert.ok(carcass < use && use < fang, 'carcass, then the tree, then the Fang');
	const tree = { map: 1413, x: 59.95, y: 30.21 };
	assert.ok(yards(list[use].goal, tree) <= 20, `the carcass is used at the Dead Tree, not ${Math.round(yards(list[use].goal, tree))} yd off`);
});

// DexeeXI (#907): the guide took Free From the Hold (898) from Gilthares
// Firebough in Northwatch Hold, then sent the escort through the Northwatch
// kills (891), though Gilthares walks straight back to Ratchet. The hold is
// cleared first; the escort is accepted after the last 891 objective and
// nothing else is worked before it ends in Ratchet.
test(`${BARRENS}: DexeeXI's report (#907): Northwatch Hold is cleared before Gilthares's escort, and the escort runs straight to Ratchet`, { skip }, () => {
	const list = goals(BARRENS);
	const accept = at(list, 'accept 898 (Free From the Hold)', is('accept', 898));
	const done = at(list, 'complete 898 (the escort to Ratchet)', is('complete', 898));
	const kills = list.map((e, i) => [e, i]).filter(([{ goal }]) => goal.quest === 891 && ['kill', 'collect'].includes(goal.t));
	assert.equal(kills.length, 4, 'the four Northwatch objectives');
	for (const [{ goal }, i] of kills) assert.ok(i < accept, `${goal.t} ${goal.npc || goal.item} for 891 comes before the escort is accepted`);
	for (const { goal } of list.slice(accept + 1, done)) assert.ok(!goal.quest || goal.quest === 898, `nothing but the escort between its accept and its end (${goal.t} ${goal.quest})`);
});
test(`${BARRENS_12}: Orcs and Trolls learn Ratchet's flight path on the Ratchet visit, with no trip there and back before it`, { skip }, () => {
	for (const race of ['Orc', 'Troll']) {
		const forRace = ({ step, goal }) => [step.only, goal.only].every((o) => !o || !o.races || o.races.includes(race));
		const list = goals(BARRENS_12).filter(forRace);
		const gazlowe = at(list, `${race}: accept 887 (Southsea Freebooters)`, is('accept', 887));
		assert.deepEqual(list.slice(0, gazlowe).filter(({ goal }) => (goal.t === 'getfp' && goal.location === 'Ratchet') || (goal.t === 'goto' && goal.x > 60 && goal.y > 34)).map(({ goal }) => `${goal.t} ${goal.location || goal.text}`), [], `${race}: nothing at Ratchet before its first stop`);
	}
});

test(`${BARRENS_12}: Kolkar Leaders is taken, worked and handed in on Regthar's first loop, with Centaur Bracers`, { skip }, () => {
	const list = goals(BARRENS_12);
	const bracers = at(list, 'accept 855', is('accept', 855));
	const accept = at(list, 'accept 850', is('accept', 850));
	assert.equal(list[accept].s, list[bracers].s, 'taken from Regthar with Centaur Bracers');
	const head = at(list, "Barak's head", (g) => g.t === 'collect' && g.quest === 850);
	const turnin = at(list, 'turnin 850', is('turnin', 850));
	assert.equal(list[turnin].s, list[at(list, 'turnin 855', is('turnin', 855))].s, 'handed in with the bracers');
	assert.ok(accept < head && head < turnin && turnin < at(list, 'turnin 870', is('turnin', 870)), "Barak on that loop, before Tonga's Forgotten Pools hand-in");
	// With the Barrens one stay (Horde 12-30 re-chain), Regthar's follow-up Verog the Dervish (851) is taken
	// when Kolkar Leaders is handed in, and Verog is killed later in the same stay.
	assert.equal(list[at(list, 'accept 851', is('accept', 851))].s, list[turnin].s, 'Verog the Dervish taken with the Kolkar Leaders hand-in');
	assert.ok(!goals('forever/horde/04-the-barrens.guide').some(({ goal }) => [850, 851].includes(goal.quest)), 'nothing of Kolkar Leaders or Verog is left for the 24-26 guide');
});

// Background goals (#1135, docs/GUIDE_FORMAT.md "Background goals": the heads and beaks, worked over the stay
// with a finish step before the hand-in) are along steps by design; every other list stays a step.
test(`${BARRENS_12}: no "along the way" lists but the background goals`, { skip }, () => {
	const background = new Set(JSON.parse(fs.readFileSync(path.join(ROOT, 'data', 'guide-fixes.json'), 'utf8')).fixes.filter((r) => r.background).map((r) => `${r.at.quest}.${r.at.objective}`));
	const lists = compiled(BARRENS_12).steps.filter((step) => step.along && !step.goals.every((g) => background.has(`${g.quest}.${g.oi}`)));
	assert.deepEqual(lists.map((step) => step.title), []);
});

test(`${BARRENS}: Raptor Horns is handed to Mebok on the first Ratchet stop when the horns are done`, { skip }, () => {
	const list = goals(BARRENS);
	const early = at(list, 'turnin 865', is('turnin', 865));
	assert.ok(early < at(list, 'accept 891', is('accept', 891)), 'before Northwatch Hold');
	assert.ok(list[early].step.when.some((p) => p.k === 'complete' && !p.neg && p.q === 865), 'only when the horns are done');
});

test(`${BARRENS}: a Warrior hands Speak with Thun'grim to Thun'grim on the last Crossroads loop, not from Camp Taurajo`, { skip }, () => {
	const list = goals(BARRENS).filter(forClass('WARRIOR'));
	const accept = at(list, 'accept 1825', is('accept', 1825));
	const turnin = at(list, 'turnin 1825', is('turnin', 1825));
	assert.notEqual(list[turnin].s, list[accept].s, 'not in the Camp Taurajo step');
	assert.ok(turnin > at(list, 'turnin 880', is('turnin', 880)), 'after the flight back to the Crossroads (Tonga\'s snapjaw shells)');
	assert.ok(turnin > at(list, 'turnin 1824', is('turnin', 1824)), "after Ruga's hand-in at Camp Taurajo");
});

// Timed-quest check (2026-11-08, #1319's pattern): Trial at the Field of Giants runs for 30 minutes. Warriors took it on
// the first Camp Taurajo stop and did the thunder lizards, the thunderhawks and the eggs before the antennae; it is taken
// on Jorn's stop after the thunder lizards, with a tip naming the limit.
test(`${BARRENS}: a Warrior takes Trial at the Field of Giants (30 minutes) on Jorn's stop, after the thunder lizards`, { skip }, () => {
	const list = goals(BARRENS).filter(forClass('WARRIOR'));
	const accept = at(list, 'accept 1824', is('accept', 1824));
	assert.equal(list[accept].s, list[at(list, 'turnin 907', is('turnin', 907))].s, "on Jorn's stop that hands in the thunder lizards");
	assert.ok(accept > at(list, 'collect 5143', (g) => g.t === 'collect' && g.item === 5143), 'after the thunder lizards');
	assert.ok(accept < at(list, 'collect 5164', (g) => g.t === 'collect' && g.item === 5164), 'before the thunderhawks');
	assert.ok(accept < at(list, 'collect 7119', (g) => g.t === 'collect' && g.item === 7119), 'before the antennae');
	assert.ok([list[accept].step.note, list[accept].step.tip].flat().filter(Boolean).join(' ').includes('30 minutes'), 'the step names the time limit');
	assert.equal(list.filter(({ goal }) => is('accept', 1824)(goal)).length, 1, 'one accept');
});

// Trial at the Field of Giants (1824, Warrior, 30 minutes), from #1833's sweep of timed quests: the thunderhawks flew
// between the accept and the antennae, so the timer ran during them (players' recordings on 0.3.5 and later: 6
// accepts, 2 hand-ins, 2 fails, 2 abandons). The eggs and the antennae share the Field of Giants' mounds and come
// first, then Ruga, then the thunderhawks.
test(`${BARRENS}: Trial at the Field of Giants: the antennae go straight to Ruga, the thunderhawks after`, { skip }, () => {
	const list = goals(BARRENS).filter(forClass('WARRIOR'));
	const take = at(list, 'accept 1824', is('accept', 1824));
	const back = at(list, 'turnin 1824', is('turnin', 1824));
	assert.ok(take < back, 'taken before it is handed in');
	const work = list.slice(take + 1, back).filter(({ goal }) => ['kill', 'collect', 'interact', 'use'].includes(goal.t) && goal.quest !== 1824);
	// Since the 0.4.0 level tidy the Silithid eggs (Egg Hunt, level 22) are in 04-the-barrens at 25: nothing else runs with the trial.
	assert.deepEqual([...new Set(work.map(({ goal }) => goal.quest))], [], 'only the antennae while the trial runs');
	assert.ok(back < at(list, 'collect 5164 (Cry of the Thunderhawk)', (g) => g.t === 'collect' && g.item === 5164), 'the thunderhawks after the hand-in');
	const fixes = JSON.parse(fs.readFileSync(path.join(ROOT, 'data', 'route-fixes.json'), 'utf8'));
	assert.ok(fixes.deliberate.pairs.some((p) => p.faction === 'Horde' && `${p.a}` === 'turnin,1824' && `${p.b}` === 'task,913'), 'a record the build keeps');
});

test(`${BARRENS}: Rohkin's report (#957): Mankrik's tusks are collected with Tribes at War, not before it`, { skip }, () => {
	const list = goals(BARRENS);
	const accept = at(list, 'accept 878 (Tribes at War)', is('accept', 878));
	const tusks = list.map((e, i) => [e, i]).filter(([{ goal }]) => goal.quest === 899 && goal.t === 'collect');
	assert.ok(tusks.length > 0, 'the tusks have a goal');
	const kills = new Set(list.filter(({ goal }) => goal.quest === 878 && goal.t === 'kill').map(({ s }) => s));
	assert.equal(kills.size, 1, 'the Tribes at War kills share one step');
	for (const [{ s }, i] of tusks) {
		assert.ok(i > accept, 'the tusks come after Tribes at War is taken');
		assert.ok(kills.has(s), `the tusks are on the Tribes at War step ${[...kills][0]}, not step ${s}`);
	}
	const wife = at(list, 'Lost in Battle (4921)', (g) => g.quest === 4921 && g.t !== 'accept' && g.t !== 'turnin');
	assert.ok(wife < accept, 'Mankrik\'s wife is found on the walk south, before Camp Taurajo');
});

// Flow audit, Silverpine: the south loop came back to the Sepulcher, walked 1,100 yd east to grind on the
// lake shore, then 1,100 yd back to the Sepulcher for Journey to Hillsbrad alone. With Silverpine at 12-15
// (Horde 12-30 re-chain) the walk runs south along the lake shore from the Yoricks' house to Ambermill, one
// Sepulcher stop hands in everything, and the level 19-21 quests (Journey to Hillsbrad, Beren's Peril,
// Watching the Roads) ride with the Sepulcher stop of the ride to Hillsbrad at 22. Fenris Isle's Rot Hide
// gnolls (15-17, the keep 18-22) are left out at 12-15. The Decrepit Ferry's boat on that shore is handed in on
// the walk (final route review, 0.3.5): a hand-in to an object there is no Sepulcher stop.
test(`${SILVERPINE}: one Sepulcher stop after the south loop; the level 19-21 quests on the ride to Hillsbrad, no Fenris Isle at 12-15`, { skip }, () => {
	const list = goals(SILVERPINE);
	const stop = list[at(list, 'accept 91921 (Return to Quinn (Again))', is('accept', 91921))].s;
	for (const [t, q] of [['turnin', 91920], ['turnin', 422], ['turnin', 439]]) {
		assert.equal(list[at(list, `${t} ${q}`, is(t, q))].s, stop, `${t} ${q} on the Sepulcher stop after the south loop`);
	}
	// Since the 0.4.0 level tidy Ambermill (479: Mages with Serpents, Conjurors 17-18, Ataeric 22) waits for the ride at 22.
	assert.deepEqual(list.filter(({ goal }) => [443, 460, 461, 479, 493, 516, 95981].includes(goal.quest)).map(({ goal }) => `${goal.t} ${goal.quest}`), [], 'no Fenris Isle, no Ambermill, and the level 19-21 quests wait for the ride to Hillsbrad');
	const ride = goals(STONETALON);
	const sep = ride[at(ride, 'accept 493', is('accept', 493))].s;
	for (const q of [516, 95981, 479]) assert.equal(ride[at(ride, `accept ${q}`, is('accept', q))].s, sep, `${q} on the ride's Sepulcher stop`);
	assert.equal(goals(HILLSBRAD_HORDE).filter(({ goal }) => is('turnin', 479)(goal)).length, 1, 'Ambermill handed to Allister when the Hillsbrad guide flies back to the Sepulcher');
	assert.deepEqual(compiled(SILVERPINE).steps.filter((step) => step.along).map((step) => step.title), [], 'no "along the way" lists');
});

// Corey's report (#2479): the Verog step said he walks among the Kolkar, so players waited for him. He comes out when
// the Stagnant Oasis' Kolkar are killed (recordings: 63 of 76 Verog kills a median 25 s after a Kolkar kill).
test("The Barrens (Horde): Verog's step says he comes out when you kill the Kolkar (#2479)", { skip }, () => {
	const list = goals('forever/horde/02-the-barrens.guide');
	const verog = list[at(list, 'collect 5023 quest 851', (g) => g.t === 'collect' && g.quest === 851)];
	const text = [verog.step.note, verog.step.tip].flat().filter(Boolean).join(' ');
	assert.match(text, /doesn't wander on his own/, 'not a wandering spawn');
	assert.match(text, /kill the Kolkar centaurs/, 'killing the Kolkar brings him out');
	assert.doesNotMatch(text, /Verog walks among/, 'the old wording is gone');
	const mech = JSON.parse(fs.readFileSync(path.join(ROOT, 'data', 'mechanics-public.json'), 'utf8')).quests['851'];
	assert.ok(mech && /Kolkar/.test(mech.note), 'the mechanic is recorded');
});

test(`${STONETALON_HORDE}: #246: Kadrak's goals are on the Barrens' map, and the Ashenvale steps after them on Ashenvale's`, { skip }, () => {
	const list = goals(STONETALON_HORDE);
	// (The Warsong Reports, 6543, is left out since the final route review; Kadrak keeps Report to Kadrak.)
	const kadrak = list[at(list, 'turnin 6541', is('turnin', 6541))].goal;
	assert.equal(kadrak.map, 1413, `${kadrak.t} ${kadrak.quest} is on The Barrens (1413), not ${kadrak.map}`);
	// (Ashenvale Outrunners, the old anchor here, waits for the 26 visit since 0.3.7.)
	const senani = list[at(list, 'turnin 6382', is('turnin', 6382))].goal;
	assert.equal(senani.map, 1440, 'Senani at Splintertree is still in Ashenvale');
});

// --- The Barrens (Fitz, #273): Savannah Lion Hides drop from the Patriarchs
// in the Dry Hills and from the Matriarchs by Ratchet, but the Sprung Traps
// the same step needs are all in the Dry Hills. The hide arrow stays there;
// the alternatives (alt) are only marked on the map, never picked by the arrow
// (a lone Patriarch spawns by Ratchet too), and never the Matriarchs.
test('forever/horde/02-the-barrens.guide: Fitz\'s report (#273): the Savannah Lion Hide arrow stays in the Dry Hills with the traps, never by Ratchet', { skip }, () => {
	const list = goals('forever/horde/02-the-barrens.guide');
	for (const quest of [95494, 95507]) {
		const { goal } = list[at(list, `the Dry Hills collect for ${quest}`, is('collect', quest))];
		for (const p of [goal, ...(goal.spots || []).filter((s) => !s.alt)]) {
			const where = `${goal.itemName} at ${p.x},${p.y}`;
			assert.ok(p.x >= 40 && p.x <= 52 && p.y >= 10 && p.y <= 22, `${where} is in the Dry Hills`);
			assert.ok(Math.hypot(p.x - 60, p.y - 33) > 10, `${where} is not near Ratchet's Matriarchs (60,33)`);
		}
		const matriarchs = (goal.spots || []).filter((s) => s.n > 1 && Math.hypot(s.x - 60, s.y - 33) <= 10);
		assert.deepEqual(matriarchs, [], `${goal.itemName}: no mark at the Matriarchs' camp`);
	}
});

// Fitz's report (#274): Sunscale Scytheclaws roam the Dry Hills among the
// lions, but the step there did not remind you of Raptor Horns (865) when the
// horns were still short. The step carries the horns too, in the Dry Hills;
// a horn goal already met is done, and one for a quest never taken drops out.

test('forever/horde/02-the-barrens.guide: Fitz\'s report (#274): the Dry Hills step also collects the Raptor Horns, in the Dry Hills, before the Ratchet turn-in', { skip }, () => {
	const list = goals('forever/horde/02-the-barrens.guide');
	// The Dry Hills visit after Raptor Horns is taken at Ratchet: Serena Bloodfeather's harpies, above the lions
	// (Vrang's own hides come on the first loop since #1959, before the horns are offered).
	const hills = list.findIndex(({ goal }) => is('collect', 876)(goal));
	assert.ok(hills >= 0, 'the Dry Hills step is in the guide');
	const horns = list.findIndex(({ s, goal }) => s === list[hills].s && is('collect', 865)(goal));
	assert.ok(horns >= 0, 'the Dry Hills step collects the Raptor Horns');
	const { goal } = list[horns];
	assert.equal(goal.item, 5055, 'Intact Raptor Horn');
	// The arrow's spots; the alternatives (alt) are only marked on the map.
	for (const p of [goal, ...(goal.spots || []).filter((spot) => !spot.alt)]) {
		assert.ok(p.x >= 40 && p.x <= 52 && p.y >= 10 && p.y <= 22, `the horns' arrow at ${p.x},${p.y} is in the Dry Hills`);
	}
	// The first Ratchet stop hands the horns in only when they are done (#1078); the unconditional
	// hand-in, on the second pass, comes after the Dry Hills.
	const last = list.map(({ goal }, i) => [goal, i]).filter(([g]) => is('turnin', 865)(g)).pop()[1];
	assert.ok(horns < last, 'before the horns are handed in at Ratchet');
	for (const [{ step }, i] of list.map((e, i) => [e, i]).filter(([{ goal }], i) => is('turnin', 865)(goal) && i < horns)) {
		assert.ok(step.when.some((p) => p.k === 'complete' && !p.neg && p.q === 865), `the hand-in at goal ${i}, before the Dry Hills, waits for the horns to be done`);
	}
});

// Rohkin (#947): after Regthar, a Warlock walked into Stonetalon Mountains and straight back to the
// Barrens with nothing to do there. Their Ken'zigla quests in Malaka'jin come later in the guide.
test(`${BARRENS}: Rohkin's report (#947): a Warlock is never sent into another zone and straight back with nothing done there`, { skip }, () => {
	const forUndeadWarlock = ({ only }) => !only || ((!only.classes || only.classes.includes('WARLOCK')) && (!only.races || only.races.includes('Undead')));
	const steps = compiled(BARRENS).steps.filter(forUndeadWarlock).filter((step) => step.goals.length);
	const travel = (step) => step.goals.every((g) => g.t === 'goto' || g.t === 'fly');
	const mapOf = (step) => step.goals.at(-1).map;
	for (let i = 1; i < steps.length; i++) {
		const from = mapOf(steps[i - 1]);
		if (!travel(steps[i]) || mapOf(steps[i]) === from) continue;
		for (let j = i + 1; j < steps.length && travel(steps[j]); j++) {
			assert.notEqual(mapOf(steps[j]), from, `"${steps[i].title}" to "${steps[j].title}": into map ${mapOf(steps[i])} and back to map ${from} with no goal there`);
		}
	}
});

// --- The Warsong Reports (Hotline, #278): the Warsong Scout, Runner and
// Outrider each give their update for a Warsong Report, which comes only out
// of the Bundle of Reports Kadrak hands out. The Kadrak step holds until a
// report is in the bags, so nobody reaches the scout with the bundle unopened.
// (Idea and test from PRDesrochers on #293.)

test('forever/horde/05-stonetalon-mountains.guide: Hotline\'s report (#278): the Bundle of Reports is opened at Kadrak, before the Warsong Scout', { skip }, () => {
	const guide = 'forever/horde/05-stonetalon-mountains.guide';
	const list = goals(guide);
	// Left out since the final route review (route-fixes skip 6543); holds whenever a build takes it again.
	if (!list.some(({ goal }) => is('accept', 6543)(goal))) return;
	const reports = at(list, 'the Warsong Reports', (g) => g.t === 'collect' && g.item === 16746 && !g.quest);
	assert.equal(list[reports].goal.count || 1, 1, 'any report in the bags shows the bundle was opened');
	assert.equal(list[reports].step, list[at(list, 'accept 6543', is('accept', 6543))].step, 'opened on the Kadrak step');
	for (const update of [16764, 16765, 16763]) assert.ok(reports < at(list, `update ${update}`, (g) => g.t === 'collect' && g.item === update), `a report is in the bags before update ${update}`);
});

// The Tauren and Skyborne Druids took the zeppelin to Orgrimmar for their Thunder Bluff training at 16,
// then walked about 2,400 yards to Ratchet's flight master and back to the zeppelin afterwards. Since the
// Horde 12-30 re-chain (Silverpine first, the Barrens at 15-21) they fly from the Crossroads stop after
// Echeyakee to Thunder Bluff, and from there straight on to Ratchet, where everyone flies next: no stop at
// the Crossroads with nothing to do between two flights, and no zeppelin round trip from the Sepulcher.
test('Flight path sweep (#964): Druids fly to Thunder Bluff from the Crossroads at 16 and on to Ratchet, not by zeppelin', { skip }, () => {
	for (const race of ['Tauren', 'Skyborne']) {
		const barrens = goals('forever/horde/02-the-barrens.guide').filter(forRaceOf(race)).filter(forClass('DRUID'));
		const mura = at(barrens, `${race}: the Crossroads stop after Echeyakee`, is('turnin', 881));
		const trip = barrens.slice(mura).map(({ goal }) => goal);
		const out = trip.findIndex((g) => g.t === 'fly' && g.location === 'Thunder Bluff');
		assert.ok(out >= 0 && trip.slice(out).some((g) => g.t === 'train'), `${race}: flies to Thunder Bluff and trains`);
		const next = trip.slice(out + 1).find((g) => g.t === 'fly' && g.location !== 'Thunder Bluff');
		assert.equal(next && next.location, 'Ratchet', `${race}: flies from Thunder Bluff straight on to Ratchet`);
		const silverpine = goals('forever/horde/03-silverpine-forest.guide').filter(forRaceOf(race)).filter(forClass('DRUID'));
		const sepulcher = silverpine.findIndex(({ goal }) => is('accept', 477)(goal));
		assert.ok(sepulcher > 0 && !silverpine.slice(0, sepulcher + 20).some(({ goal }) => goal.t === 'fly' || (goal.t === 'goto' && goal.text === 'Zeppelin to Orgrimmar')), `${race}: no zeppelin back from the Sepulcher`);
	}
});

// After the route's Thunder Bluff training, the Druids' own step walked them to Tal and flew them to
// Thunder Bluff, where they already stood, to train again. They train once and go on with everyone.
test(`${ASHENVALE_HORDE}: Flight path sweep (#964): the Druids train in Thunder Bluff once, with no flight to where they stand`, { skip }, () => {
	for (const race of ['Tauren', 'Skyborne']) {
		const list = goals(ASHENVALE_HORDE).filter(forRaceOf(race)).filter(forClass('DRUID'));
		const train = at(list, `${race}: the Thunder Bluff training`, (g) => g.t === 'train');
		assert.deepEqual(list.slice(train).filter(({ goal }) => goal.t === 'train' && !goal.npc).map(({ s }) => s), [list[train].s], `${race}: one class training in Thunder Bluff`);
		const next = list.slice(train).find(({ goal }) => goal.t === 'fly');
		assert.equal(next && next.goal.location, 'Camp Taurajo', `${race}: the next flight leaves Thunder Bluff`);
	}
});

// Flow audit, Horde Ashenvale & Thousand Needles: Shamans filled Brine's waterskin by walking from Alonso back
// to the Zoram'gar flight master (2,666 yd) and on to the Ruins of Stardust fountain (2,496 yd), beside
// Ursangous; and they handed it to Brine on a flight from Freewind Post to Camp Taurajo and back, although the
// walk from Camp Taurajo down to the Great Lift passes his hut. (The same audit left Stonetalon Standstill out
// for its walk back to Mystral Lake; #1346 brought it back, see the #1346 test below.)
test(`${ASHENVALE_HORDE}: the Shaman's waterskin beside Ursangous and to Brine on the road to the Great Lift`, { skip }, () => {
	const list = goals(ASHENVALE_HORDE);
	const shaman = list.filter(forRaceOf('Orc')).filter(forClass('SHAMAN'));
	const fountain = at(shaman, 'the fountain (1534)', (g) => g.quest === 1534 && g.t === 'collect');
	assert.ok(fountain < at(shaman, 'Ursangous\'s paw (23)', is('accept', 23)), 'the fountain before Ursangous, in his ruins');
	assert.deepEqual(shaman.slice(fountain, at(shaman, 'accept 1918', is('accept', 1918))).filter(({ goal }) => goal.t === 'goto' && goal.x != null && goal.x < 20).map(({ s }) => s), [], 'no walk back to Zoram\'gar for the fountain');
	const brine = at(shaman, 'turnin 1534 (Call of Water)', is('turnin', 1534));
	assert.ok(brine < at(shaman, 'accept 4767 (Wind Rider)', is('accept', 4767)), 'Brine before Freewind Post');
	// #1414 (Bonesavv77's report #1424): from Zoram'gar the Earthen Ring is reached as travel (the flight the character has),
	// so the one Camp Taurajo flight is the one from Thunder Bluff; none from Freewind Post.
	assert.equal(shaman.filter(({ goal }) => goal.t === 'fly' && goal.location === 'Camp Taurajo').length, 1, 'one flight to Camp Taurajo (from Thunder Bluff), none from Zoram\'gar or Freewind Post');
});

// Maazias's report (#1333): The Tear of the Moons is a level 30 quest; its strongbox stands beside
// General Twinbraid (30) and his Officers (26). Done with Gann Stonespire's Bael Modan quests in the
// Barrens 24-26 it came at 26 for every Horde start, and the guide frame told everyone to reach 28
// first. It was then taken on the road from Camp Taurajo to the Great Lift at about 28; since the 0.4.0 level tidy
// (players there at 28.8, recorded 25th percentile; 12 recorded deaths at the fortress) it is left out: no Horde pass
// of Bael Modan comes at 30.
test(`${ASHENVALE_HORDE}: Maazias's report: The Tear of the Moons is not sent at players two levels under it (#1333)`, { skip }, () => {
	for (const g of ['forever/horde/04-the-barrens.guide', ASHENVALE_HORDE]) {
		assert.deepEqual(goals(g).filter(({ goal }) => goal.quest === 857).map(({ goal }) => goal.t), [], `${g}: no Tear of the Moons`);
	}
	const fixes = JSON.parse(fs.readFileSync(path.join(ROOT, 'data', 'route-fixes.json'), 'utf8'));
	assert.ok(fixes.overrides.skip.some((r) => r.q === 857 && r.faction === 'Horde'), 'the skip is a record');
});

// #1346: Tideress drops the Befouled Water Globe (16408, which starts The Befouled Element 1918) only for a
// player with Stonetalon Standstill (25) in the log or handed in (players' recordings: the 7 people who took
// 1918 all had 25, 2 people without it got no globe). The guide hunted Tideress on the way in, before
// Splintertree, where Mastok gives 25, and since 0.3.5 left 25 out. Every guide that takes 1918 takes 25 first.
test('#1346: Tideress (The Befouled Element) comes after Stonetalon Standstill is taken, in every guide', { skip }, () => {
	const takers = allGuides().filter((g) => goals(g).some(({ goal }) => goal.t === 'accept' && goal.quest === 1918));
	assert.ok(takers.includes(ASHENVALE_HORDE), `${ASHENVALE_HORDE} takes The Befouled Element`);
	for (const guide of takers) {
		const list = goals(guide);
		const take = at(list, `${guide}: accept 25`, is('accept', 25));
		const globe = at(list, `${guide}: Tideress's globe`, (g) => g.t === 'collect' && g.item === 16408);
		assert.ok(take < globe, `${guide}: Stonetalon Standstill (step ${list[take].s}) before Tideress (step ${list[globe].s})`);
		assert.ok(globe < at(list, `${guide}: accept 1918`, is('accept', 1918)), `${guide}: the globe starts 1918`);
	}
	const list = goals(ASHENVALE_HORDE);
	const done25 = at(list, 'complete 25', is('complete', 25));
	assert.ok(done25 < at(list, 'turnin 25', is('turnin', 25)), 'Stonetalon Standstill handed in after the lake');
	const in1918 = at(list, 'turnin 1918', is('turnin', 1918));
	assert.ok(at(list, 'accept 1918', is('accept', 1918)) < in1918 && in1918 < at(list, 'accept 824', is('accept', 824)), 'The Befouled Element handed in, then Je\'neu of the Earthen Ring');
});

// The same pattern at Orgrimmar: the Warriors' (and the other classes') training step flew them to
// Orgrimmar from Orgrimmar's flight master, after the Crossroads flight there (Stonetalon) or the walk
// there from Boulder Lode Mine (the Barrens). They train where they stand.
test('Flight path sweep (#964): the Orgrimmar training steps of the Barrens and Stonetalon do not fly to Orgrimmar from Orgrimmar', { skip }, () => {
	for (const [file, race] of [['forever/horde/02-the-barrens.guide', 'Tauren'], ['forever/horde/02-the-barrens.guide', 'Orc'], [STONETALON, 'Undead']]) {
		const list = goals(file).filter(forRaceOf(race)).filter(forClass('WARRIOR'));
		const train = list.findIndex(({ goal, step }) => goal.t === 'train' && !goal.npc && step.title === 'Orgrimmar');
		assert.ok(train > 0, `${file} ${race}: the Orgrimmar training`);
		const last = list.slice(0, train + 1).reverse().find(({ goal }) => ['fly', 'goto'].includes(goal.t));
		assert.ok(last && (last.goal.t === 'fly' ? last.goal.location === 'Orgrimmar' && last.s < list[train].s : last.goal.map === 1454), `${file} ${race}: they reach Orgrimmar before the training step, which flies nowhere`);
	}
});

test('Level fit (#977): the Rogues\' Venture Co. tower (drones 25, Gallywix a 23 elite) shows from level 23, not at the route\'s 20', { skip }, () => {
	// Horde 12-30 re-chain: Fizzule is visited at 21 on the walk north to Kadrak; the tower work itself is left
	// to the Class guide Poisons (Horde). Any tower work in a leveling guide shows from 23.
	for (const file of ['forever/horde/02-the-barrens.guide', 'forever/horde/04-the-barrens.guide', STONETALON]) {
		for (const { step } of goals(file).filter(({ goal }) => goal.quest === 2478 && ['kill', 'collect'].includes(goal.t))) {
			assert.ok([].concat(step.when || []).some((w) => w.k === 'level' && w.op === '>=' && w.n >= 23), `${file}: "${step.title}" shows before level 23`);
		}
	}
	const list = goals(STONETALON);
	assert.ok(list.some(({ goal }) => is('turnin', 2458)(goal)), 'Deep Cover goes to Fizzule on the walk north');
});

// Bill (#1004): at Ratchet the guide sent you up to the inn to bind, then back
// to Mebok Mizzyrix, who stands by the WANTED poster you had just read. The
// bind comes after the givers next to the ones before it; the same sweep found
// the inn wedged between two goals at one NPC at the Crossroads (Mankrik), Sun
// Rock (Maggran Earthbinder) and Tarren Mill (Apothecary Lydon).
test("Bill's report (#1004): a town's bind never sends you back to the giver you just left", { skip }, () => {
	for (const [guide, place, before] of [
		// (Sun Rock Retreat's bind left the Barrens & Stonetalon guide with the Horde 21-30 audit: Stonetalon is its last half.)
		['forever/horde/06-hillsbrad-foothills.guide', 'Tarren Mill', [496, 493]],
	]) {
		const list = goals(guide);
		const visit = list.find(({ goal }) => ['accept', 'turnin'].includes(goal.t) && goal.quest === before[before.length - 1]);
		assert.ok(visit, `${guide}: quest ${before[before.length - 1]} is in the guide`);
		const bind = list.findIndex(({ step, goal }) => step === visit.step && goal.t === 'sethome' && goal.location === place);
		assert.ok(bind >= 0, `${guide}: the bind at ${place} is in the step of quest ${before[before.length - 1]}`);
		const bindStep = visit.step;
		for (const q of before) {
			const i = list.findIndex(({ step, goal }) => step === bindStep && goal.t !== 'sethome' && goal.quest === q && ['accept', 'turnin'].includes(goal.t));
			assert.ok(i >= 0 && i < bind, `${guide}: quest ${q} at ${place} comes before the bind there`);
		}
		// No NPC on both sides of the bind in its step.
		const inStep = list.map((e, i) => [e, i]).filter(([{ step }]) => step === bindStep);
		const npcsBefore = new Set(inStep.filter(([, i]) => i < bind).map(([{ goal }]) => goal.npc).filter(Boolean));
		const back = inStep.filter(([, i]) => i > bind).map(([{ goal }]) => goal).filter((g) => g.npc && npcsBefore.has(g.npc));
		assert.deepEqual(back.map((g) => `${g.t} ${g.quest} (${g.npcName})`), [], `${guide}: back to an NPC of the step after binding at ${place}`);
	}
});

// 0.4.0 route audit, Horde 12-21 (travel sweep with the addon's planner, recorded hearths): Ratchet's bind was never
// hearthed back to inside its window, the second Crossroads line rebound the inn the player was already bound to, and
// Camp Taurajo's one planned hearth lands at the Crossroads just as well. The Barrens keep their first Crossroads bind,
// taken after Sergra's first quest and before the givers further on.
test('The Barrens (Horde 14-21): one bind, at the Crossroads; Ratchet and Camp Taurajo are not bound (0.4.0 audit)', { skip }, () => {
	const list = goals(BARRENS);
	const binds = list.filter(({ goal }) => goal.t === 'sethome');
	assert.deepEqual(binds.map(({ goal }) => goal.location), ['The Crossroads'], 'the guide binds once, at the Crossroads');
	const inStep = list.filter(({ step }) => step === binds[0].step);
	const k = inStep.indexOf(binds[0]);
	const SERGRA = 3338;
	assert.ok(inStep.slice(0, k).some(({ goal }) => goal.npc === SERGRA), 'Sergra before the bind');
	assert.ok(!inStep.slice(k + 1).some(({ goal }) => goal.npc === SERGRA), 'no walk back to Sergra after the bind');
});

// 0.4.0 route audit, Horde 12-21: Orcs, Trolls, Tauren and Skyborne arrive in Orgrimmar from their starts still bound
// at Razor Hill, Bloodhoof Village or Valanaar, inns no later step comes back to. Silverpine's first Orgrimmar stop binds
// them at Gryshka's inn, after the flight path: the travel planner's hearth home from Silverpine Forest then lands beside
// the zeppelin towers and the road to the Barrens (-4.3 min a branch for Orcs and Trolls, -6.6 for Tauren and Skyborne).
test('Silverpine Forest (Horde 12-15): the starts that come by Orgrimmar bind there on arrival, after its flight path (0.4.0 audit)', { skip }, () => {
	const list = goals(SILVERPINE);
	const fp = at(list, 'getfp Orgrimmar', (g) => g.t === 'getfp' && g.location === 'Orgrimmar');
	const bind = at(list, 'sethome Orgrimmar', (g) => g.t === 'sethome' && g.location === 'Orgrimmar');
	assert.equal(list[bind].step, list[fp].step, 'the bind is on the arrival step');
	assert.ok(bind > fp, 'after the flight path');
	assert.deepEqual([...list[bind].step.only.races].sort(), ['Orc', 'Skyborne', 'Tauren', 'Troll'], 'not for the Undead, who keep Brill');
	assert.equal(list.filter(({ goal }) => goal.t === 'sethome').length, 1, 'the guide binds once');
});

// 0.4.0 route audit, Horde 12-21: Silverpine's arrival trainer in Orgrimmar listed every Orgrimmar class but Mage, so a
// Troll Mage (last trained at Sen'jin, around 8-9) waited until the end of the guide; Troll Priests carried Hex of Weakness
// to the Barrens' Orgrimmar trip at 20 although Ur'kyo, their trainer, is the one who takes it. The last Orgrimmar stop
// trained twice, at the trainer step and again on the Valley of Wisdom step.
test('Silverpine Forest (Horde 12-15): Troll Mages train and Troll Priests hand in Hex of Weakness on the Orgrimmar arrival; the last stop trains once (0.4.0 audit)', { skip }, () => {
	const list = goals(SILVERPINE);
	const fits = (o, race, cls) => !o || ((!o.races || o.races.includes(race)) && (!o.classes || o.classes.includes(cls)));
	const as = (race, cls) => list.filter(({ step, goal }) => fits(step.only, race, cls) && fits(goal.only, race, cls));
	const before = (l, title) => l.slice(0, l.findIndex(({ step }) => step.title === title));
	const after = (l, title) => l.slice(l.findIndex(({ step }) => step.title === title));
	const classTrain = ({ goal }) => goal.t === 'train' && goal.class;
	assert.ok(before(as('Troll', 'MAGE'), 'Zeppelin to Undercity').some(classTrain), 'a Troll Mage trains before the zeppelin');
	assert.ok(before(as('Troll', 'PRIEST'), 'Zeppelin to Undercity').some(({ goal }) => is('turnin', 5654)(goal)), 'Hex of Weakness on arrival');
	for (const cls of ['WARRIOR', 'MAGE', 'PRIEST']) {
		assert.equal(after(as('Undead', cls), 'Zeppelin to Orgrimmar').filter(classTrain).length, 1, `${cls}: one class training on the last Orgrimmar stop`);
	}
});

// 0.4.0 route audit, Horde 12-21: Paladins coming by the zeppelin walked Brill -> Hadric's camp by the towers -> the
// cultists -> Hadric -> back north to Brill for Shari Stilwell -> south to Silverpine (~570 yd against ~200). They train
// on the first Brill stop, with Terrence and Johaan.
test('Silverpine Forest (Horde 12-15): Paladins train on the first Brill stop, no walk back to Brill after the cultists (0.4.0 audit)', { skip }, () => {
	const list = goals(SILVERPINE);
	const brill = list.filter(({ step, goal }) => goal.t === 'train' && goal.class && step.title === 'Brill');
	assert.equal(brill.length, 1, 'one Brill training');
	assert.equal(brill[0].s, list[at(list, 'accept 445', is('accept', 445))].s, 'with Apothecary Johaan');
	assert.ok(brill[0].goal.only && brill[0].goal.only.classes.join() === 'PALADIN', 'for Paladins');
});

// 0.4.0 route audit, Horde 12-21 (danger-at-the-spot gate, #1980, players' recordings): the steps where players of the
// band die name what kills them: the Apprentices at the Dalaran Crate, Nightlash's level and when she rises, Ambermill's
// Mages with their Serpents and Ataeric's level, Chol'aruk beside the Razormane supply crates, the rare Silithid
// Harvester at the Field of Giants' mounds, and the level 60 Territorial Terrans in the Stormrage Barrow Dens. Each step
// keeps one tip, with its record.
test('Silverpine Forest and the Barrens (Horde): the band\'s dangerous steps say what is there (#1980, 0.4.0 audit)', { skip }, () => {
	const fixes = JSON.parse(fs.readFileSync(path.join(ROOT, 'data', 'guide-fixes.json'), 'utf8')).fixes;
	for (const [guide, title, re] of [
		[SILVERPINE, 'Border Crossings', /Dalaran Apprentices \(13\)/],
		[SILVERPINE, 'The Dead Field', /Nightlash \(14\) rises/],
		[STONETALON, 'Ambermill', /Dalaran Serpent \(15\).*Archmage Ataeric \(22\)/], // since the 0.4.0 level tidy on the ride at 22
		[BARRENS, 'The Disruption Ends', /Chol'aruk \(20, elite\)/],
		[BARRENS, 'Twitching Antennae', /Silithid Harvester \(24, rare\)/],
		[BARRENS, 'The Stormrage Barrow Dens', /Territorial Terrans \(level 60\)/],
	]) {
		// The guide's own tip lines (a compiled step folds its tips into `note`, with names turned into tokens).
		const src = fs.readFileSync(path.join(OFFICIAL_DIR, guide), 'utf8');
		const block = src.split('\nstep ').find((s) => s.split('\n')[0] === title);
		assert.ok(block, `${guide}: step "${title}"`);
		const tips = block.split('\n').filter((l) => l.startsWith('  tip ')).map((l) => l.slice(6));
		assert.equal(tips.length, 1, `${title}: one tip`);
		assert.match(tips[0], re, `${title}: names the danger`);
		assert.ok(fixes.some((f) => f.tip === tips[0]), `${title}: a record the build keeps`);
	}
});

// 0.4.0 route audit, Horde 12-21: Neeru Fireblade offers Ak'Zeloth (809) on the Orcs' and Trolls' Cleft of Shadow stop
// once Neeru Fireblade (829) is handed in, and Ak'Zeloth stands beside Kargal at Far Watch Post, the Barrens' first stop
// for them: taken on the one, handed in on the other, no walk of its own.
test("Silverpine Forest and the Barrens (Horde): Ak'Zeloth from Neeru to Far Watch Post (0.4.0 audit)", { skip }, () => {
	const silverpine = goals(SILVERPINE);
	const take = at(silverpine, 'accept 809', is('accept', 809));
	assert.equal(silverpine[take].s, silverpine[at(silverpine, 'turnin 829', is('turnin', 829))].s, 'on the Neeru stop');
	assert.ok(take > at(silverpine, 'turnin 829', is('turnin', 829)), 'after Neeru Fireblade');
	const barrens = goals(BARRENS);
	const give = at(barrens, 'turnin 809', is('turnin', 809));
	assert.equal(barrens[give].s, barrens[at(barrens, 'accept 842', is('accept', 842))].s, 'on the Far Watch stop with Kargal');
	assert.equal(barrens[give].goal.npc, 3521, "Ak'Zeloth");
});

// 0.4.0 route audit, Horde 1-21 (with Mulgore's half): Tauren Warriors and Shamans now take their level-10 class quests on
// Mulgore's walk past Far Watch Post to Orgrimmar. In the Barrens, Warriors hand Path of Defense to Uzzek on the walk from
// Orgrimmar and Shamans share the Orcs' and Trolls' Fire Tar, Telf and Kranal steps; no Tauren-only trip into Durotar
// from the Crossroads is left (it was ~3,160 yd for Warriors and two trips for Shamans).
test('The Barrens (Horde): Tauren Warriors and Shamans finish Path of Defense and Call of Fire on the Orcs\' steps, no Durotar trip of their own (0.4.0 audit)', { skip }, () => {
	const list = goals(BARRENS);
	const fits = (o, cls) => !o || ((!o.races || o.races.includes('Tauren')) && (!o.classes || o.classes.includes(cls)));
	const as = (cls) => list.filter(({ step, goal }) => fits(step.only, cls) && fits(goal.only, cls));
	const war = as('WARRIOR');
	const uzzek = war[at(war, 'turnin 1498', is('turnin', 1498))];
	assert.ok((uzzek.step.when || []).some((p) => p.k === 'onquest' && !p.neg && [].concat(p.q).includes(1498)), 'Uzzek only for a Warrior carrying Path of Defense');
	assert.ok(at(war, 'turnin 1503', is('turnin', 1503)) < at(war, 'accept 844', is('accept', 844)), 'Forged Steel before the Crossroads quests');
	const sham = as('SHAMAN');
	assert.equal(sham.filter(({ goal }) => is('turnin', 1525)(goal)).length, 1, 'one Telf hand-in');
	assert.ok(!sham.some(({ goal }) => is('accept', 1524)(goal) || is('accept', 1525)(goal) || (goal.t === 'collect' && goal.item === 6652)), 'Kranal\'s and Telf\'s first parts are Mulgore\'s');
	for (const cls of ['WARRIOR', 'SHAMAN']) {
		const own = as(cls).filter(({ step }) => step.only && step.only.races && step.only.races.join() === 'Tauren' && step.goals.some((g) => g.zone === 1411 || g.map === 1411));
		assert.deepEqual(own.map(({ step }) => step.title), [], `${cls}: no Tauren-only Durotar step`);
	}
});

// 0.4.0 route audit, Horde 1-21: the walk back from Telf Joolam to Kranal Fiss for Call of Fire's last part was a goto
// named "Kranal Fiss" at 61.4,21.1, Uzzek's spot at Far Watch Post; Kranal stands alone on the ridge at 56.0,19.9.
test('The Barrens (Horde): the goto back to Kranal Fiss points at Kranal, not at Uzzek (0.4.0 audit)', { skip }, () => {
	const list = goals(BARRENS);
	const hand = at(list, 'turnin 1527', is('turnin', 1527));
	const walk = list.slice(0, hand).reverse().find(({ goal }) => goal.t === 'goto');
	assert.equal(list[hand].goal.npc, 5907, 'Kranal Fiss takes it');
	assert.ok(Math.hypot(walk.goal.x - list[hand].goal.x, walk.goal.y - list[hand].goal.y) < 1, `the goto at ${walk.goal.x},${walk.goal.y} is at Kranal (${list[hand].goal.x},${list[hand].goal.y})`);
});

// 0.4.0 route audit, Horde 12-21: Chol'aruk the Ravener (Forever, 4,100 XP) comes from Gur'ak at the Crossroads, and its
// boar (level 20, elite) sits in the cave of the Razormane camp the route clears for The Disruption Ends. A group choice
// like WANTED: Bruuz: taken at the Crossroads before the camp, done there, handed in on the next Crossroads stop.
test("The Barrens (Horde): Chol'aruk the Ravener is a group choice on the Razormane camp's second visit (0.4.0 audit)", { skip }, () => {
	const list = goals(BARRENS);
	const mine = list.filter(({ goal }) => goal.quest === 97003);
	assert.ok(mine.length >= 3, 'accept, objective and hand-in');
	for (const { step, goal } of mine) assert.ok((step.when || []).some((p) => p.k === 'group' && !p.neg), `${goal.t} 97003: only for a group`);
	const take = at(list, 'accept 97003', is('accept', 97003));
	const kreenig = at(list, 'collect 872', (g) => g.t === 'collect' && g.quest === 872);
	const boar = at(list, 'collect 97003', (g) => g.t === 'collect' && g.quest === 97003);
	const give = at(list, 'turnin 97003', is('turnin', 97003));
	assert.ok(take < kreenig && kreenig < boar && boar < give, 'Crossroads, the camp, Crossroads');
	const group = JSON.parse(fs.readFileSync(path.join(ROOT, 'data', 'route-fixes.json'), 'utf8')).deliberate.group;
	assert.ok(group.some((g) => g.q === 97003 && g.size >= 2), 'a group record the build keeps');
});

// 0.4.0 route audit, Horde 12-21 (players' recordings, 0.3.7: both Druids who reached it flew Crossroads -> Orgrimmar
// for Rilli Greasygob, then on to Thunder Bluff): Druids and Paladins have no trainer in Orgrimmar. They take Thunder
// Bluff in the Orgrimmar trip's place (Paladins learn its flight path by Camp Taurajo), Druids with Cat Form and Cure
// Poison on the same trip, and fly on to Ratchet; nobody makes a second Thunder Bluff trip after Counterattack!.
// The chain's `level 20` hold: every Druid recorded at that stop was over 20 (0.3.7: 22.05 and 22.2; 0.3.6: 21.0). The
// calibrated level model, which runs about two levels under players in this band, reaches it at 19.7 and grinds there.
test('The Barrens (Horde): Druids and Paladins train in Thunder Bluff in the Orgrimmar trip\'s place, once (0.4.0 audit)', { skip }, () => {
	const list = goals(BARRENS);
	const fits = (o, cls) => !o || !o.classes || o.classes.includes(cls);
	const as = (cls) => list.filter(({ step, goal }) => fits(step.only, cls) && fits(goal.only, cls));
	for (const cls of ['DRUID', 'PALADIN']) {
		const l = as(cls);
		const egg = at(l, 'accept 95774', is('accept', 95774));
		const ratchet = at(l, 'turnin 896', is('turnin', 896));
		assert.ok(!l.slice(egg, ratchet).some(({ goal }) => goal.t === 'fly' && goal.location === 'Orgrimmar'), `${cls}: no flight to Orgrimmar`);
		assert.ok(!l.some(({ goal }) => is('turnin', 3923)(goal) || is('accept', 3923)(goal)), `${cls}: Rilli Greasygob's errand is not taken`);
		const trains = l.map((e, i) => [e, i]).filter(([{ goal }, i]) => i > egg && goal.t === 'train' && goal.class);
		assert.equal(trains.length, 1, `${cls}: one class training after the Bristlebacks`);
		assert.ok(trains[0][1] < ratchet, `${cls}: before the Ratchet stop`);
		assert.equal(trains[0][0].goal.zone, 1456, `${cls}: in Thunder Bluff`);
	}
	const druid = as('DRUID');
	const ratchet = at(druid, 'turnin 896', is('turnin', 896));
	for (const q of [98362, 6130]) assert.ok(at(druid, `turnin ${q}`, is('turnin', q)) < ratchet, `${q} on the same trip, before Ratchet`);
});

// Rohkin's report (#1123): Mountain Lion Blood's few, contested lions were a stop of their own on the way down to
// Hillsbrad Fields. They stand between the fields and Tarren Mill: the blood comes after the farmers, on the walk
// back to Tarren Mill, where both are handed in (route-fixes pair task 527 before task 501, Horde).
test("Rohkin's report (#1123): Mountain Lion Blood on the walk back from Hillsbrad Fields, before Tarren Mill", { skip }, () => {
	const fixes = JSON.parse(fs.readFileSync(path.join(ROOT, 'data', 'route-fixes.json'), 'utf8'));
	assert.ok(fixes.overrides.pairs.some((p) => p.a[0] === 'task' && p.a[1] === 527 && p.b[0] === 'task' && p.b[1] === 501 && p.faction === 'Horde'), 'the order is a record the build keeps');
	const list = goals('forever/horde/06-hillsbrad-foothills.guide');
	const farmers = at(list, 'kill 2266 quest 527.1', (g) => g.t === 'kill' && g.quest === 527);
	const blood = at(list, 'collect 3496 quest 501.1', (g) => g.t === 'collect' && g.quest === 501);
	const turnin = at(list, 'turnin 501', is('turnin', 501));
	assert.ok(farmers < blood && blood < turnin, 'the farmers, then the blood, then Lydon');
	assert.ok(!list.slice(blood + 1, turnin).some(({ goal }) => goal.quest === 527 && goal.t === 'kill'), 'no trip back to the fields after the blood');
});

// #1135 (Fitz, Undead Warlock 12): the Raptor Heads and Plainstrider Beaks sat in a step of their own right
// after the Crossroads accepts, the arrow on the plainstriders, and he spent an hour there. Players'
// recordings: about one plainstrider in four drops a beak (a median 21 kills for seven, up to 49); the heads
// drop from three raptors in four, but the raptors are sparse and contested (a median 77 s between raptor
// kills, 447 s at p90). Both are background goals (docs/GUIDE_FORMAT.md, "Background goals"): listed on the
// way from the Crossroads until a later stop that hands them in (the beaks after the Razormane camp, the
// heads after Echeyakee), each with a finish step right before it that only a player still short gets.
test("Fitz's report (#1135): the Raptor Heads and Plainstrider Beaks are worked on the way to later hand-ins, each with a finish step before it", { skip }, () => {
	const file = 'forever/horde/02-the-barrens.guide';
	const g = compiled(file);
	const list = goals(file);
	const crossroads = g.steps.findIndex((s) => s.label === 'crossroads');
	assert.ok(crossroads >= 0, 'the shared Crossroads step');
	for (const [quest, item, count, what, after, afterWhat] of [
		[844, 5087, 7, 'beaks', (goal) => goal.t === 'kill' && goal.quest === 871 && goal.oi === 3, 'the Razormane camp'],
		[869, 5062, 12, 'heads', (goal) => goal.quest === 881 && goal.oi === 1, 'Echeyakee'],
	]) {
		const mine = (goal) => goal.t === 'collect' && goal.item === item && goal.quest === quest && goal.oi === 1;
		const handIn = at(list, `turnin ${quest}`, is('turnin', quest));
		const turnStep = list[handIn].step;
		const along = g.steps.findIndex((s) => s.along && s.goals.some(mine));
		assert.ok(along > crossroads && along <= crossroads + 2, `the ${what} are listed on the way right after the Crossroads accepts`);
		assert.equal(g.steps[along].along, turnStep.label, `the ${what}: until the step that hands them in`);
		const workers = list.filter(({ step, goal }) => mine(goal) && !step.along);
		assert.equal(workers.length, 1, `one step of the route works the ${what}: the finish step`);
		const finish = workers[0];
		assert.equal(g.steps.indexOf(finish.step) + 1, g.steps.indexOf(turnStep), `the ${what}' finish step comes right before the hand-in`);
		assert.ok(located(finish), `the ${what}' finish step leads to the mobs`);
		assert.ok(finish.step.when.some((p) => p.k === 'has' && p.neg), `the ${what}' finish step is only for a player still short of ${count}`);
		assert.ok(at(list, afterWhat, after) < handIn, `the ${what} are handed in after ${afterWhat}`);
	}
});

// Konky88's report (#1150; soockee's #1051): Valuable Vantages was handed back to Deathstalker Masoj in the step
// that took it, before its three vials were placed: the data had no objectives. The correction gives the three
// lines with the peaks players placed them on. Since the 0.4.0 level tidy the quest is left out of the solo route
// (its western peak sits among Ferocious Yetis 31-32, five levels over Hillsbrad's 22-25 and still over at 30):
// 'Every Horde route (#1051, #1150)' keeps guarding the vials-before-hand-in order should a guide take it again.
test("Konky88's report (#1150): Valuable Vantages' three vials come before its hand-in, not in the step that takes it", { skip }, () => {
	assert.equal(refData().questObjectives(98095).length, 3, 'the three vial objectives are in the data');
	const list = goals('forever/horde/06-hillsbrad-foothills.guide');
	for (const q of [98094, 98095]) assert.ok(!list.some(({ goal }) => goal.quest === q), `${q} left out at 23-25 (western peak yetis 31-32)`);
});

// Flow review, The Barrens 12-16: after the camp loop the guide walked north of the Crossroads for the zhevra,
// back to Sergra, then east to the Razormane camp for the prowlers, and Echeyakee sat between the Sludge Fen
// console and Ratchet. Now the zhevra on the road out to Ratchet, the prowlers on the west loop by Regthar,
// and the last loop goes round once, Lushwater to the Dry Hills to Wenikee, ending at Echeyakee on the way
// home (the raptor heads after him, #1135).
test(`${BARRENS_12}: flow review: the zhevra toward Ratchet, the prowlers by Regthar, one last loop ending at Echeyakee`, { skip }, () => {
	const list = goals(BARRENS_12);
	const stepOf = (t, q) => list[at(list, `${t} ${q}`, is(t, q))].s;
	const work = (q) => list.find(({ step, goal }) => !step.along && goal.t === 'collect' && goal.quest === q).s;
	const zhevra = work(845);
	assert.ok(stepOf('accept', 845) < zhevra && zhevra < stepOf('accept', 887), 'the zhevra between the camp loop and Ratchet');
	assert.ok(!list.filter(everyone).some(({ s, goal }) => s > zhevra && s < stepOf('accept', 887) && goal.t === 'turnin' && goal.npc === 3338), 'no visit to Sergra on the way');
	assert.ok(stepOf('turnin', 845) > stepOf('turnin', 892) && stepOf('accept', 903) === stepOf('turnin', 845), 'The Zhevra handed in and Prowlers taken on the return from Ratchet');
	assert.ok(work(903) > stepOf('accept', 855), 'the prowlers on the west loop');
	const eche = work(881);
	// Since #1644 (0.3.7) Tonga's seed test waits for the Verog pass (the Crossroads stop after the Dry Hills loop
	// takes no 877), and the snapjaws for Altered Beings go with Hezrul at Lushwater: see the #1644 test below.
	assert.ok(stepOf('accept', 877) < work(875) && work(875) < eche, 'the Dry Hills, then Echeyakee');
	// Since the Horde 12-30 re-chain Samophlange waits for the Ratchet stop at 18 (no walk from the Sludge Fen
	// to Ratchet and back to the Razormane camp), and Wenikee's Nugget Slugs go with the second Sludge Fen visit.
	const fen = stepOf('accept', 858);
	assert.ok(stepOf('turnin', 902) < stepOf('turnin', 3921) && stepOf('turnin', 3921) < fen && fen < work(3922) && work(3922) < stepOf('turnin', 3922), 'Samophlange at Ratchet, Wenikee around the second Sludge Fen visit');
	const last = stepOf('turnin', 869);
	assert.ok(eche < last, 'the raptor heads after Echeyakee');
	for (const [t, q] of [['turnin', 881], ['turnin', 875]]) assert.equal(stepOf(t, q), last, `${t} ${q} on the final Crossroads visit`);
});

// #1644 (0.3.6, a Scourge Warlock at 17): from the Crossroads the guide walked south-east to the Stagnant Oasis
// for Tonga's seed test alone, then turned back north-west to the Witchwing Slayers in the Dry Hills (about
// 1,800 yd out and back). The seed test now goes with Verog, whose Kolkar walk the same oasis on the way south
// to the Bristlebacks; Tonga takes it on the next Crossroads stop and gives Altered Beings, whose snapjaws are
// collected at Lushwater Oasis with Hezrul (15 of their 24 spawns), handed in on the stop before Counterattack!.
test(`${BARRENS_12}: #1644: no oasis trip for the seed test alone; the seed test with Verog, the snapjaws with Hezrul`, { skip }, () => {
	const list = goals(BARRENS_12);
	const stepOf = (t, q) => list[at(list, `${t} ${q}`, is(t, q))].s;
	const task = (t, q) => list[at(list, `${t} quest ${q}`, (g) => g.t === t && g.quest === q)].s;
	const seed = task('interact', 877);
	assert.equal(seed, task('collect', 851), 'the seed test on the Verog step');
	assert.ok(stepOf('accept', 877) < task('collect', 875) && task('collect', 875) < seed, 'the Dry Hills before the seed test');
	const turnin = stepOf('turnin', 877);
	assert.ok(seed < turnin && turnin === stepOf('accept', 880), 'Tonga takes the seeds and gives Altered Beings on the next Crossroads stop');
	const shells = task('collect', 880);
	assert.equal(shells, task('collect', 852), 'the snapjaws with Hezrul at Lushwater');
	assert.ok(shells < stepOf('turnin', 880) && stepOf('turnin', 880) === stepOf('turnin', 95774), 'handed to Tonga on the Crossroads stop with Mankrik');
	assert.ok(!list.some(({ s, goal }) => s > stepOf('accept', 877) && s < task('collect', 875) && goal.t === 'interact' && goal.quest === 877), 'no seed test on the way to the Dry Hills');
});

// Flow review, Durotar: Warriors walked past Kargal Battlescar, 3 yd from Uzzek, to the thunder lizards
// and back for Conscript of the Horde. Troll Durotar: Lar Prowltusk on the first Sen'jin stop (as the
// Orc guide), Razor Hill once after Tiragarde Keep, the eggs and tiger fur where the coast walk meets them.
// Since the final route review (0.3.5) that Far Watch stop ends the Durotar guide: Kargal and Uzzek together, the
// lizards on Thunder Ridge on the road north to Orgrimmar, Path of Defense to Uzzek when the Barrens guide passes.
for (const race of ['Orc', 'Troll']) test(`forever/horde/${race.toLowerCase()}/01-durotar.guide: flow review: ${race} Warriors hand Conscript of the Horde to Kargal with Uzzek`, { skip }, () => {
	const list = goals(`forever/horde/${race.toLowerCase()}/01-durotar.guide`).filter(forClass('WARRIOR'));
	assert.equal(list[at(list, 'turnin 840', is('turnin', 840))].s, list[at(list, 'turnin 1505', is('turnin', 1505))].s, 'with Uzzek, before the lizards');
	assert.equal(list.filter(({ goal }) => is('turnin', 840)(goal)).length, 1, 'handed in once');
	assert.ok(at(list, 'turnin 1505', is('turnin', 1505)) < at(list, 'collect 6486', (g) => g.t === 'collect' && g.item === 6486), 'the lizards after Uzzek');
	const barrens = goals('forever/horde/02-the-barrens.guide').filter(forRaceOf(race)).filter(forClass('WARRIOR'));
	assert.ok(at(barrens, 'turnin 1498', is('turnin', 1498)) < at(barrens, 'accept 6365', is('accept', 6365)), 'Path of Defense to Uzzek on the way to the Crossroads');
});

// Final route review, Horde 1-30: Silverpine's Orgrimmar training came after the steps that walk to the zeppelin and
// into Silverpine; Paladins went from the Sepulcher back north to Brill, and Druids rode the zeppelin back from the
// Sepulcher to fly to Thunder Bluff. Now: train, zeppelin, Brill on the way, the Druid trip from the Crossroads.
test('forever/horde/03-silverpine-forest.guide: final route review: train before the zeppelin, Brill on the way in, Druids from the Crossroads', { skip }, () => {
	const list = goals('forever/horde/03-silverpine-forest.guide');
	const train = list.findIndex(({ step, goal }) => goal.t === 'train' && goal.class && step.title === 'Class trainer');
	const zeppelin = list.findIndex(({ goal }) => goal.t === 'goto' && goal.text === 'Zeppelin to Undercity');
	const brill = list.findIndex(({ step, goal }) => goal.t === 'train' && step.title === 'Brill');
	const sepulcher = at(list, 'accept 477', is('accept', 477));
	assert.ok(train >= 0 && train < zeppelin, 'Orgrimmar training before the zeppelin');
	assert.ok(zeppelin < brill && brill < sepulcher, 'Paladins train in Brill on the way to the Sepulcher');
	assert.ok(!list.some(({ goal }) => is('accept', 27)(goal) || is('turnin', 28)(goal) || goal.t === 'fly'), 'no flight or Druid trip from Silverpine');
	assert.ok(!list[sepulcher].step.note || !/swim/i.test(list[sepulcher].step.note), 'no swimming tip at the Sepulcher');
	const sayoc = list.findIndex(({ step }) => step.title === 'Sayoc');
	assert.ok(sayoc >= 0 && sayoc < at(list, 'turnin 97242', is('turnin', 97242)), 'Sayoc on the Valley of Honor stop');
	const barrens = goals('forever/horde/02-the-barrens.guide');
	const mura = at(barrens, 'turnin 881 (the Crossroads stop after Echeyakee)', is('turnin', 881));
	const lake = at(barrens, 'turnin 28', is('turnin', 28));
	const back = barrens.findIndex(({ step, goal }) => goal.t === 'fly' && goal.location === 'Ratchet' && step.only && step.only.classes && step.only.classes.join() === 'DRUID');
	assert.ok(mura < at(barrens, 'accept 27', is('accept', 27)) && lake > mura && back > lake, 'Druids train and do the Moonglade trial from the Crossroads, then fly on to Ratchet');
});

// Final route review, Horde 1-30: the flight lands in Ratchet beside Sputtervalve, who came after the grind south and
// back; the Silithid eggs lie on the road south to Gann but were done on a walk back north from Gann, and Sulhasa's
// Field to Clear (beside Gann) was taken after Blackthorn Ridge, whose plain holds its lizards and stalkers.
test('forever/horde/02-the-barrens.guide, 04-the-barrens.guide: final route review: Ratchet in walking order, the eggs with Jorn\'s hunt, Field to Clear with Blackthorn Ridge', { skip }, () => {
	// Horde 12-30 re-chain: the Ratchet stops are in the Barrens' 15-21 stay (02), Gann Stonespire and Blackthorn Ridge in
	// its 24-26 return (04). Since the 0.4.0 level tidy Northwatch Hold waits for the Ratchet stop after the Orgrimmar trip
	// (Fairmount 20), and the Silithid eggs (Egg Hunt, level 22) for 04's walk south from Camp Taurajo to Gann at 25.
	const early = goals('forever/horde/02-the-barrens.guide');
	const thalo = at(early, 'accept 891', is('accept', 891));
	assert.ok(at(early, 'accept 1483', is('accept', 1483)) < thalo && at(early, 'turnin 819', is('turnin', 819)) < thalo, 'Sputtervalve and Drohn before Thalo\'thas');
	assert.ok(at(early, 'accept 95774', is('accept', 95774)) < thalo, 'Northwatch after the Orgrimmar trip (Mankrik\'s last Crossroads stop before it)');
	const wings = at(early, 'collect 5164', (g) => g.t === 'collect' && g.item === 5164);
	assert.ok(wings < at(early, 'turnin 913', is('turnin', 913)), 'Jorn\'s thunderhawks before his hand-in');
	assert.ok(at(early, 'accept 865', is('accept', 865)) < at(early, 'collect 5055', (g) => g.t === 'collect' && g.item === 5055), 'Raptor Horns taken before its horns');
	const later = goals('forever/horde/04-the-barrens.guide');
	const eggs = at(later, 'collect 5058', (g) => g.t === 'collect' && g.item === 5058);
	assert.ok(at(early, 'accept 868', is('accept', 868)) >= 0 && eggs < at(later, 'accept 843', is('accept', 843)) && eggs < at(later, 'turnin 868', is('turnin', 868)), 'the eggs on the road south to Gann (Egg Hunt from 02\'s last Crossroads stop), Korran after');
	const list = goals('forever/horde/04-the-barrens.guide');
	const gann = at(list, 'accept 843', is('accept', 843));
	assert.equal(list[at(list, 'accept 98093', is('accept', 98093))].s, list[gann].s, 'Sulhasa with Gann\'s first quest');
	const stalkers = at(list, 'kill 4128', (g) => g.t === 'kill' && g.npc === 4128);
	const ridge = at(list, 'collect 5093', (g) => g.t === 'collect' && g.item === 5093);
	const back = at(list, 'turnin 843', is('turnin', 843));
	assert.ok(ridge < stalkers && stalkers < back, 'the plain on the way back from the ridge');
	assert.equal(list[at(list, 'turnin 98093', is('turnin', 98093))].s, list[back].s, 'Field to Clear handed in on that Gann stop');
});

// Final route review, Horde 1-30: the Offering Stone offers The Tortured Soul only once the Note Scrap is handed in
// there (players' recordings: every offer came on that hand-in), and The Offering of Blood after it; the guide asked for
// The Tortured Soul first. Malaka'jin's tip sent players from Seereth, at the canyon's mouth, back to the Crossroads.
test('forever/horde/05-stonetalon-mountains.guide: final route review: the Note Scrap first at the Offering Stone, Malaka\'jin from Seereth', { skip }, () => {
	const list = goals('forever/horde/05-stonetalon-mountains.guide');
	const scrap = at(list, 'turnin 95884', is('turnin', 95884));
	const soul = at(list, 'accept 95883', is('accept', 95883));
	assert.ok(scrap < soul && at(list, 'turnin 95883', is('turnin', 95883)) < at(list, 'accept 95885', is('accept', 95885)), 'Note Scrap, Tortured Soul, then the Offering of Blood');
	const sunrock = goals('forever/horde/04-the-barrens.guide');
	const jinzil = sunrock[at(sunrock, 'accept 1058', is('accept', 1058))].step;
	assert.ok(!/back to the Crossroads/.test(jinzil.note || ''), 'no walk back to the Crossroads');
});

// Discord reports (2026-11-08, 2026-11-09): "Ashenvale & Silverpine is labeled 21-22 but the steps tell me I'm behind for
// not being level 24". Ashenvale Outrunners (level 24, its Outrunners 23-24) was the first Ashenvale step at 21, then
// (0.3.6) the step after Ruul's hand-in at 22-23, still 1-1.5 levels under it on the level model. 0.3.7:
// it waits for the second Ashenvale visit at 26, at Kuray'bin's lumber camp between Torek's assault and Sharptalon's
// woods, and is handed in on the spot before Splintertree. (#2580: a player who takes it from Kuray'bin on the first
// visit anyway gets its kills and hand-in there, behind `when onquest 6503`; the route itself still doesn't take it.)
test(`${STONETALON}: Discord reports: Ashenvale Outrunners waits for the 26 Ashenvale visit, taken by Torek and Sharptalon`, { skip }, () => {
	const first = goals(STONETALON).filter(({ goal }) => goal.quest === 6503);
	assert.ok(!first.some(({ goal }) => goal.t === 'accept'), 'not taken on the first Ashenvale visit at 21');
	assert.ok(first.every(({ step }) => (step.when || []).some((p) => p.k === 'onquest' && !p.neg && [].concat(p.q).includes(6503))), 'its lines there only for whoever carries it');
	const list = goals(ASHENVALE_HORDE);
	const torek = at(list, 'accept 6544', is('accept', 6544));
	const take = at(list, 'accept 6503', is('accept', 6503));
	const kill = list.findIndex(({ goal }) => goal.t === 'kill' && goal.quest === 6503);
	const claw = at(list, 'collect 16305', (g) => g.t === 'collect' && g.item === 16305);
	const hand = at(list, 'turnin 6503', is('turnin', 6503));
	const ertog = at(list, 'turnin 6544', is('turnin', 6544));
	assert.ok(torek < take && take < kill && kill < hand && hand < ertog, 'Torek, Kuray\'bin, the Outrunners, Kuray\'bin, then Splintertree');
	// (Sharptalon's claw comes on the later pass since the Horde 21-30 audit: she is level 31, #2025.)
	assert.ok(hand < claw, 'Sharptalon after the Outrunners, on the walk back from Mystral Lake');
	const pairs = JSON.parse(fs.readFileSync(path.join(ROOT, 'data', 'route-fixes.json'), 'utf8')).deliberate.pairs;
	const pair = (a, b) => pairs.some((p) => p.a[0] === a[0] && p.a[1] === a[1] && p.b[0] === b[0] && p.b[1] === b[1]);
	assert.ok(pair(['accept', 6544], ['accept', 6503]) && pair(['turnin', 6503], ['turnin', 6544]), 'route-fixes pairs keep the order');
	assert.ok(!pair(['turnin', 6482], ['accept', 6503]) && !pair(['turnin', 6503], ['accept', 493]), 'no pair holds it on the first visit');
});

// Thin-data audit (#1317): The Offering of Blood's quest log has three lines, Willingly offer blood, Release Tortured
// Soul, then the elite Tortured Soul's kill (players' recordings, 12 people: the kill ticks line 3). The data had only
// the kill, as line 1, so the guide's goal waited on the wrong line; the Tortured Soul the stone hands over is used
// beside the stone to summon the elite.
test(`${STONETALON}: thin-data audit: The Offering of Blood uses the Tortured Soul at the stone and waits on the kill's own line (#1317)`, { skip }, () => {
	const objectives = loadCorrections().quests['95885'].set.objectives;
	assert.equal(objectives.length, 3, 'three objective lines');
	assert.equal(objectives[2].id, 212753, 'the kill is line 3');
	const list = goals(STONETALON);
	const take = at(list, 'accept 95885', is('accept', 95885));
	const use = list.findIndex(({ goal }, i) => i > take && goal.t === 'use' && goal.item === 210713);
	assert.ok(use > take, 'the Tortured Soul is used after the accept');
	assert.ok(list[use].goal.map === 1421 && Math.hypot(list[use].goal.x - 58.1, list[use].goal.y - 69.8) < 1, 'beside the Offering Stone');
	const kill = list.findIndex(({ goal }) => goal.t === 'kill' && goal.quest === 95885);
	assert.ok(kill > use, 'then the kill');
	assert.equal(list[kill].goal.oi, 3, 'on line 3');
});

// Thin-data audit (#1317): the Tortured Souls' Ravenclaws stand around the Offering Stone, where another player's
// elite Tortured Soul (20) often waits (players' recordings: 9 kills of it with no offering of the player's own;
// 5 deaths of 3 people at 19-24 by the stone).
test(`${STONETALON}: thin-data audit: The Tortured Soul's step says to pull the Ravenclaws away from the stone (#1317)`, { skip }, () => {
	const list = goals(STONETALON);
	const { step } = list[at(list, 'collect 271350 (95883.1)', (g) => g.t === 'collect' && g.quest === 95883)];
	assert.match([].concat(step.note || []).join(' '), /elite spirit \(20\).*pull the Ravenclaws away from the stone/);
});

// Final route review, Horde 1-30: a second Tarren Mill bind step (from the arrival at the end of the previous guide)
// stood between Lydon's hand-ins and Hillsbrad Fields, and the Undercity step told Skyborne to fly from the Crossroads.
test('forever/horde/06-hillsbrad-foothills.guide: final route review: one Tarren Mill bind, the Undercity tip fits the trip', { skip }, () => {
	const list = goals('forever/horde/06-hillsbrad-foothills.guide');
	assert.equal(list.filter(({ goal }) => goal.t === 'sethome' && goal.location === 'Tarren Mill').length, 1, 'one bind at Tarren Mill');
	// Alessandro Luca and Doctor Martin Felben (beside Faranell) are both on the Undercity visit: the guide walked past
	// Luca and left Prompt Potion Runner for a visit thirty levels later.
	// Since the Horde 12-30 re-chain this Undercity visit, Sylvanas with it, is at the end of the Silverpine stay (03).
	const uc = goals('forever/horde/03-silverpine-forest.guide');
	const sylvanas = uc[at(uc, 'Sylvanas', (g) => g.t === 'talk' && g.npc === 10181)].step;
	assert.ok(!/Crossroads/.test(sylvanas.note || ''), 'no Crossroads in the Undercity tip');
	assert.ok(at(uc, 'accept 97891', is('accept', 97891)) < at(uc, 'turnin 97891', is('turnin', 97891)), 'Prompt Potion Runner taken and handed in');
	assert.equal(uc[at(uc, 'turnin 97891', is('turnin', 97891))].s, uc[at(uc, 'turnin 441', is('turnin', 441))].s, 'on the one Undercity stop, with Raleigh');
});

// Final route review, Horde 1-30: Sharptalon prowls between Torek's fight and Splintertree but was hunted on a walk
// back south from the town; Tauren and Skyborne, who know the Thunder Bluff flight path, flew to Camp Taurajo and rode
// across Mulgore; and the guide asked for Test of Strength, which Dorn offers only once Test of Endurance is in.
test('forever/horde/07-ashenvale.guide: final route review: Sharptalon on the way in, Thunder Bluff by air, Test of Strength after Test of Endurance', { skip }, () => {
	const list = goals(ASHENVALE_HORDE);
	// (Sharptalon's Claw moved to the later pass with the Horde 21-30 audit: she is level 31, #2025.)
	assert.ok(at(list, 'turnin 6544', is('turnin', 6544)) < at(list, 'accept 2', is('accept', 2)), 'Sharptalon on the walk back from Mystral Lake');
	const tb = list.find(({ goal }) => goal.t === 'fly' && goal.location === 'Thunder Bluff' && !goal.only);
	// Since the 0.3.6 bracket review the Barrens & Stonetalon guide teaches every race the path, so the flight is everyone's.
	assert.ok(tb && (!tb.step.only || (tb.step.only.races.includes('Tauren') && tb.step.only.races.includes('Skyborne'))), 'Tauren and Skyborne fly to Thunder Bluff from Zoram\'gar');
	// #1424: no forced Camp Taurajo flight from Zoram'gar; the others reach the Earthen Ring as travel, and every Camp
	// Taurajo flight comes after its quests (the one from Thunder Bluff).
	const ring = at(list, 'accept 96260', is('accept', 96260));
	assert.deepEqual(list.filter(({ goal }) => goal.t === 'fly' && goal.location === 'Camp Taurajo').filter((e) => list.indexOf(e) < ring).map(({ s }) => s), [], 'no Camp Taurajo flight before the Earthen Ring');
	// Since the 0.4.0 level tidy Test of Endurance (Grenka, 31) is worked on the next Freewind visit at 31 (taken here at
	// Dorn's mesa, where the route stands) and Test of Strength (Rok'Alim, elite) is left out. Dorn may only ever offer
	// Test of Strength after Test of Endurance's hand-in.
	assert.ok(!list.some(({ goal }) => goal.t === 'accept' && goal.quest === 1151), '1151 not taken at 29');
	assert.ok(!list.some(({ goal }) => goal.quest === 1150 && ['collect', 'kill', 'turnin'].includes(goal.t)), 'Grenka not fought or handed in at 29');
	const t1150 = list.findIndex(({ goal }) => goal.t === 'turnin' && goal.quest === 1150);
	const a1151 = list.findIndex(({ goal }) => goal.t === 'accept' && goal.quest === 1151);
	assert.ok(a1151 === -1 || (t1150 !== -1 && t1150 < a1151), 'Test of Strength after Test of Endurance');
	for (const { step, goal } of list.filter(({ goal }) => goal.quest === 96261)) {
		assert.ok((step.when || []).some((p) => p.k === 'group' && p.q === 96261 && !p.neg), `${goal.t} 96261: Broodmother Valraxx is elite, asked as a group quest`);
	}
});

// Kolbi's report (#1563, Skyborne Druid 28): the first Freewind Post stop ended on the bind; leaving for the canyon
// without it, the guide held that step and sent him back up the lift for the bind alone, while Pacify the Centaur's
// hand-in waited for the later stop. The canyon work (the Alien Egg, the Galak camps, Splithoof Hold, Dorn's mesa)
// all lies around Freewind and uses no hearthstone, so the bind comes on the return, with the hand-ins, before
// the walk west to Darkcloud and Whitereach.
test(`${ASHENVALE_HORDE}: Kolbi's report (#1563): Freewind Post's bind comes on the return with the Galak hand-in, not on the first stop`, { skip }, () => {
	const list = goals(ASHENVALE_HORDE);
	const binds = list.filter(({ goal }) => goal.t === 'sethome' && goal.location === 'Freewind Post');
	assert.equal(binds.length, 1, 'one Freewind Post bind');
	const handIn = at(list, 'turnin 4841', is('turnin', 4841));
	assert.equal(binds[0].s, list[handIn].s, 'the bind is on the stop that hands in Pacify the Centaur');
	assert.ok(at(list, 'accept 4841', is('accept', 4841)) < list.indexOf(binds[0]), 'after the first stop');
	for (const q of [4094, 4093, 4096]) assert.ok(list.findIndex(({ goal }) => goal.t === 'kill' && goal.npc === q) < list.indexOf(binds[0]), `the Galak kills (${q}) before the bind`);
	assert.ok(list.indexOf(binds[0]) < at(list, 'Document Chest (5064)', (g) => g.quest === 5064 && g.t === 'interact'), 'the bind before the walk west to Darkcloud');
});

// Barrens carry-over (2026-11-07, re-chained the same day): the Barrens are two stays, 15-21
// (02-the-barrens, with Stonetalon's road) and 24-26 (04-the-barrens, with Sun Rock); each accepts
// the quests it works where their giver stands on its walk before the work, and 02 hands in Chen's keg
// and the raptor horns before it leaves.
test('forever/horde/04-the-barrens.guide: Barrens carry-over: each Barrens stay accepts the quests it works, and 02 hands in Chen\'s keg before leaving', { skip }, () => {
	const g02 = goals('forever/horde/02-the-barrens.guide');
	const g04 = goals('forever/horde/04-the-barrens.guide');
	// Egg Hunt (868) is taken on 02's last Crossroads stop, where the route stands beside Korran, and worked on 04's walk
	// south (pick up now, do later: Fitz, 2026-11-16).
	for (const [here, other, qs] of [[g02, g04, [896, 876, 4921, 899, 858, 3281, 905, 851]], [g04, g02, [893, 879, 1058, 843]]]) {
		for (const q of qs) {
			assert.ok(!other.some(({ goal }) => goal.t === 'accept' && goal.quest === q), `${q} accepted in one Barrens stay only`);
			const a = here.findIndex(({ goal }) => goal.t === 'accept' && goal.quest === q);
			const w = here.findIndex(({ goal }) => goal.quest === q && goal.t !== 'accept');
			assert.ok(a >= 0 && a < w, `${q} accepted before its work, in the stay that works it`);
		}
	}
	assert.ok(g02.some(({ goal }) => goal.t === 'turnin' && goal.quest === 819), "Chen's Empty Keg handed in in 02");
	assert.ok(g02.some(({ goal }) => goal.t === 'turnin' && goal.quest === 865), 'Raptor Horns handed in in 02');
	assert.ok(g02.some(({ goal }) => is('accept', 868)(goal)) && !g04.some(({ goal }) => is('accept', 868)(goal)), 'Egg Hunt taken in 02 only');
	assert.ok(g04.some(({ goal }) => goal.t === 'collect' && goal.quest === 868) && !g02.some(({ goal }) => goal.t === 'collect' && goal.quest === 868), 'its eggs on 04\'s walk south');
});

test('Leveling guides: no flight to a stop with nothing to do followed by another flight, for any race and class (#1191)', { skip: skip || needs('travel.json') }, () => {
	compiled(STONETALON); // loads the data
	const found = [];
	for (const guide of allGuides().filter((g) => /^forever\/(horde|alliance)\//.test(g))) {
		const side = guide.split('/')[1];
		for (const race of FLIGHT_RACES[side]) {
			for (const cls of FLIGHT_CLASSES) {
				for (const hop of flightHops(guide, race, cls)) found.push(`${guide}: ${race} ${cls}: ${hop}`);
			}
		}
	}
	assert.deepEqual(found, []);
});

// Since the Horde 12-30 re-chain the Barrens are one stay at 15-21: Brewmaster Drohn's keg is handed in on the
// Ratchet stop before Northwatch Hold. Since the flow follow-up (2026-11-08) Gilthares's escort ends that loop in
// Ratchet and the route flies to the Crossroads for Sergra's nests and Gazrog's silver; the flight after that is
// the level 20 training trip. #1191's point stands: no flight lands where nothing is done before the next one.
test('The Barrens (Horde 15-21): after Brewmaster Drohn the flight to the Crossroads has work there before the training trip; Druids train in Thunder Bluff, the others in Orgrimmar (#1191)', { skip }, () => {
	const WORK = new Set(['accept', 'turnin', 'kill', 'collect', 'interact', 'use', 'complete', 'talk']);
	for (const [cls, to] of [['DRUID', 'Thunder Bluff'], ['SHAMAN', 'Orgrimmar']]) {
		const list = goals('forever/horde/02-the-barrens.guide').filter(forClass(cls));
		const drohn = at(list, 'turnin 819', is('turnin', 819));
		const flights = list.map((e, i) => [e, i]).filter(([{ goal }], i) => i > drohn && goal.t === 'fly');
		assert.deepEqual(flights.slice(0, 2).map(([{ goal }]) => goal.location), ['Crossroads', to], `${cls}: the flights after Brewmaster Drohn`);
		const between = list.slice(flights[0][1] + 1, flights[1][1]);
		assert.ok(between.some(({ goal }) => goal.quest != null && WORK.has(goal.t)), `${cls}: nothing done at the Crossroads before the training flight`);
	}
});

// Fitz's report (#2372): Thistlefur Village and Hold (216, 6462, 6482, level 24; furbolg packs 23-24, Shamans that flee
// for help, two scripted ambushes in the hold) were done at 22 on the first Ashenvale visit. They wait for the
// Zoram'gar stop of the second visit at about 26.5, before King of the Foulweald (6621), which needs 216's hand-in.
test("Fitz's report (#2372): Thistlefur on the second Ashenvale visit, before King of the Foulweald", { skip }, () => {
	const first = goals('forever/horde/05-stonetalon-mountains.guide');
	for (const q of [216, 6462, 6482]) assert.ok(!first.some(({ goal }) => goal.quest === q), `${q} not on the first visit at 22`);
	const list = goals(ASHENVALE_HORDE);
	const idx = (t, q) => at(list, `${t} ${q}`, is(t, q));
	for (const q of [216, 6462]) assert.ok(idx('accept', q) < idx('turnin', q), `${q} taken and handed in on the 26 visit`);
	assert.equal(list[idx('turnin', 216)].s, list[idx('accept', 6621)].s, 'King of the Foulweald from Karang on the same stop');
	assert.equal(list[idx('turnin', 6462)].s, list[idx('turnin', 6563)].s, 'with the Sapphires, one Zoram\'gar stop');
	assert.ok(idx('turnin', 6482) > idx('accept', 6482), 'Ruul handed to Yama later in the guide');
	assert.ok(idx('accept', 6621) < list.findIndex(({ goal }) => goal.quest === 6621 && goal.t !== 'accept'), 'the banner after the accept');
});

// GuardMoony's report (#1070): Hezrul Bloodmark walks the west shore of Lushwater Oasis (players' recordings see
// him from 46,36 to 46,42), so the step's arrow at his spawn isn't always where he is. The step says he walks
// that shore, and the guide-fixes record carries the same tip so a Forge round keeps it.
test("GuardMoony's report (#1070): Hezrul Bloodmark's step says he walks the oasis shore", { skip }, () => {
	// Whichever Barrens guide holds Hezrul (02 since the Horde 12-30 rework, #1210; 04 before it).
	const holds = (g) => g.t === 'collect' && g.quest === 852;
	const guide = ['forever/horde/02-the-barrens.guide', 'forever/horde/04-the-barrens.guide'].find((f) => goals(f).some(({ goal }) => holds(goal)));
	assert.ok(guide, 'a Barrens guide takes Hezrul\'s Head');
	const list = goals(guide);
	const { step } = list[at(list, "Hezrul's Head", holds)];
	assert.match(step.note || '', /walks that shore, from about 46,36 in the north to 46,42 in the south/);
	const fixes = JSON.parse(fs.readFileSync(path.join(ROOT, 'data', 'guide-fixes.json'), 'utf8')).fixes;
	const rec = fixes.find((f) => f.at && f.at.quest === 852 && f.at.goal === 'objective');
	assert.ok(rec && /walks that shore/.test(rec.tip), 'the guide-fixes record holds the tip');
});

// --- Triage round 5 (2026-11-08) ---

// Bonesavv77's report (#1241, Orc Warrior 24): Sun Rock Retreat took Braelyn Firehand and the flight path
// before Tammra Windfield, a walk back east across the town. Arriving from the south (Tsunaman, Maggran),
// Tammra comes first, then Braelyn outside the gate and the flight master beside her on the way out
// (route-fixes after: accept 6301 before accept 1087, Horde).
test("Bonesavv77's report (#1241): Sun Rock Retreat takes Tammra Windfield before Braelyn Firehand and the flight path", { skip }, () => {
	const fixes = JSON.parse(fs.readFileSync(path.join(ROOT, 'data', 'route-fixes.json'), 'utf8'));
	assert.ok(fixes.deliberate.after.some((p) => p.a[0] === 'accept' && p.a[1] === 6301 && p.b[0] === 'accept' && p.b[1] === 1087), 'the order is a record the build keeps');
	const list = goals('forever/horde/04-the-barrens.guide');
	const tammra = at(list, 'accept 6301', is('accept', 6301));
	const braelyn = at(list, 'accept 1087', is('accept', 1087));
	const fp = at(list, 'getfp Sun Rock Retreat', (g) => g.t === 'getfp' && /Sun Rock/.test(g.location || ''));
	assert.ok(tammra < braelyn && braelyn < fp, 'Tammra, then Braelyn, then the flight master');
	assert.equal(list[tammra].step, list[fp].step, 'one Sun Rock stop');
});

// Ash's report (#1386, Tauren Druid 13): Silverpine Forest at 12-15 sent Tauren Druids to the Strange Lockbox
// off the Dead Field's coast for the Half Pendant of Aquatic Endurance, but its half pendant drops only while
// Trial of the Sea Lion (30, from level 16, taken in the Barrens guide after it) is in the log: items.json has it
// as a quest item, and in players' recordings every Strange Lockbox loot (4 people, all four boxes) came with 30
// or 272 open. The Barrens' Moonglade hand-in then waited for a half no one had. Now 30 is carried from the
// Barrens: the Silverpine box on the ride to Hillsbrad at 21, on the way, the pendant joined and handed
// in from the Undercity at the end of Hillsbrad, Aquatic Form at Turak. The sweep: no class step in a leveling
// guide collects or uses a quest-only item without its quest gated or accepted before it in the same guide.
test("Ash's report (#1386): a class step collects a quest-only item only with its quest in the log; the Tauren Sea Lion chain runs accept, halves, hand-in", { skip }, () => {
	const needed = new Map(); // item -> quests that need it (objective or required item)
	refData();
	for (const q of Object.values(refData().quests)) {
		for (const o of q.objectives || []) if (o.type === 'item' && o.id) needed.set(o.id, [...(needed.get(o.id) || []), q.id]);
		for (const i of q.requiredItems || []) needed.set(i, [...(needed.get(i) || []), q.id]);
	}
	const startItems = new Set(Object.values(refData().quests).flatMap((q) => (q.start && q.start.item) || []));
	const classOnly = ({ step, goal }) => [step.only, goal.only].some((o) => o && o.classes && o.classes.length);
	let checked = 0;
	for (const file of allGuides().filter((f) => /^forever\/(alliance|horde)\//.test(f))) {
		const list = goals(file);
		list.forEach(({ step, goal }, i) => {
			if (!['collect', 'use'].includes(goal.t) || goal.quest || !classOnly(list[i])) return;
			const item = refData().items[goal.item];
			const qs = needed.get(goal.item);
			if (!item || !item.questItem || startItems.has(goal.item) || !qs) return;
			checked++;
			const gated = (step.when || []).some((p) => ['onquest', 'complete'].includes(p.k) && !p.neg && [p.q].flat().some((q) => qs.includes(q)));
			const before = list.slice(0, i).some(({ goal: g }) => g.t === 'accept' && qs.includes(g.quest));
			assert.ok(gated || before, `${file} "${step.title}": ${goal.t} ${goal.item} (${item.name}) drops only for quest ${qs.join('/')}: gate the step on it`);
		});
	}
	assert.ok(checked >= 6, `the class steps with quest items are found (${checked})`);

	// The Tauren Druid's route through the chain, guide after guide.
	const route = ['forever/horde/03-silverpine-forest.guide', 'forever/horde/02-the-barrens.guide', STONETALON, 'forever/horde/06-hillsbrad-foothills.guide'];
	const tauren = ({ step, goal }) => [step.only, goal.only].every((o) => !o || !o.races || o.races.includes('Tauren'));
	const list = route.flatMap((f) => goals(f).map((e) => ({ ...e, file: f }))).filter(tauren).filter(forClass('DRUID'));
	const take = at(list, 'accept 30', is('accept', 30));
	const agility = at(list, 'collect 15883', (g) => g.t === 'collect' && g.item === 15883);
	const endurance = at(list, 'collect 15882', (g) => g.t === 'collect' && g.item === 15882);
	const join = at(list, 'collect 15885 quest 30.1', (g) => g.t === 'collect' && g.item === 15885 && g.quest === 30);
	const hand = at(list, 'turnin 30', is('turnin', 30));
	const form = at(list, 'accept 31', is('accept', 31));
	const turak = at(list, 'turnin 31', is('turnin', 31));
	assert.ok(take < agility && take < endurance && agility < join && endurance < join && join < hand && hand < form && form < turak, 'accept, both halves, join, hand in, Aquatic Form');
	assert.equal(list.filter(({ goal }) => goal.t === 'collect' && goal.item === 15882).length, 1, 'one Silverpine lockbox step');
	assert.equal(list[endurance].file, STONETALON, 'the Silverpine half on the ride to Hillsbrad');
	for (const i of [agility, endurance, join, hand]) {
		assert.ok(list[i].step.when.some((p) => p.k === 'onquest' && !p.neg && [p.q].flat().includes(30)), `${list[i].goal.t} ${list[i].goal.item || list[i].goal.quest}: only with 30 in the log`);
	}
	// The hand-in leaves from the Undercity: the zeppelin steps are for everyone but a Druid who just took Aquatic Form.
	const hills = goals('forever/horde/06-hillsbrad-foothills.guide');
	for (const title of ['Zeppelin to Orgrimmar', 'Orgrimmar']) {
		const { step } = hills.find(({ step, goal }) => step.title === title && goal.t === 'goto');
		assert.ok(step.when.some((p) => p.k === 'turnedin' && p.neg && [p.q].flat().includes(31)), `${title}: not after Aquatic Form`);
	}
	const fixes = JSON.parse(fs.readFileSync(path.join(ROOT, 'data', 'guide-fixes.json'), 'utf8')).fixes;
	assert.deepEqual(stepTips('forever/horde/06-hillsbrad-foothills.guide', /^\s+turnin 30\b/), [fixes.find((f) => f.id === 'upstairs-dendrite-starblaze-turnin-30').tip], 'the hand-in step carries the record tip');
	assert.deepEqual(stepTips('forever/horde/02-the-barrens.guide', /^\s+turnin 6129\b/), [fixes.find((f) => f.id === 'upstairs-dendrite-starblaze-turnin-6129').tip], "the Barrens' Moonglade step carries its record tip");
});

// Discord question (2026-11-09, Horde Thousand Needles): the Galak centaurs step waited for the Galak Messenger, a lone
// roaming centaur, because his plot (12564) and the quest it starts (4881) were required goals. Both are optional now,
// and Kanati's hand-in and the assassin defence (4966, which needs 4881) apply only to a player carrying the plot.
test('Horde Thousand Needles: the Galak Messenger never holds the centaur step', { skip }, () => {
	const guide = 'forever/horde/07-ashenvale.guide';
	const list = goals(guide);
	for (const pred of [(g) => g.t === 'collect' && g.item === 12564, is('accept', 4881)]) {
		const { goal } = list[at(list, 'the Galak Messenger goals', pred)];
		assert.ok(goal.optional, `${goal.t} ${goal.quest || goal.item} is optional`);
	}
	for (const { step, goal } of list.filter(({ goal }) => goal.quest === 4966 || (goal.t === 'turnin' && goal.quest === 4881))) {
		assert.ok((step.when || []).some((p) => p.k === 'onquest' && !p.neg), `${goal.t} ${goal.quest}: only while the plot's quest chain is in the log`);
	}
	// The decision is kept in records (a rebuild writes it back), and the step says not to wait for him.
	const optional = JSON.parse(fs.readFileSync(path.join(ROOT, 'data', 'route-fixes.json'), 'utf8')).deliberate.optional;
	assert.ok(optional.some((o) => o.q === 4881), 'a route-fixes record keeps 4881 optional');
	const fixes = JSON.parse(fs.readFileSync(path.join(ROOT, 'data', 'guide-fixes.json'), 'utf8')).fixes;
	assert.ok(fixes.some((f) => f.at && f.at.quest === 4841 && /Don't wait for him/.test(f.tip || '')), 'the tip is a guide-fixes record');
	const { step } = list[at(list, 'the Galak camps', (g) => g.t === 'kill' && g.quest === 4841)];
	assert.match([step.note, step.tip].flat().filter(Boolean).join(' '), /Don't wait for him/);
});

// Final route review (0.3.6) put Masoj before the Mudsnout Blossoms and the southern peak after them. Since the 0.4.0
// level tidy none of that loop is in Hillsbrad 22-25: Elixir of Agony (509, level 28, Mudsnout gnolls 27-28) goes with
// Battle of Hillsbrad 529 and Dangerous! to the Tarren Mill visit at about 30, and Valuable Vantages is left out.
test('Hillsbrad (Horde 22-25): the quests two or more levels over wait for the visit at 30', { skip }, () => {
	const list = goals('forever/horde/06-hillsbrad-foothills.guide');
	for (const q of [509, 513, 529, 567, 98094, 98095]) assert.ok(!list.some(({ goal }) => goal.quest === q), `${q} not taken at 23-25`);
	for (const q of [527, 528, 546, 498, 549]) assert.ok(list.some(({ goal }) => is('turnin', q)(goal)), `${q} still done and handed in`);
});

// Final route review, Horde 1-30 (0.3.6 leftovers): the Sepulcher step after the Strange Lockbox (Tauren Druids with
// Trial of the Sea Lion) began "From the zeppelin towers" for everyone; the Druids come from the coast.
test('forever/horde/05-stonetalon-mountains.guide: the Sepulcher tip reads right for Druids coming from the Strange Lockbox', { skip }, () => {
	const steps = compiled('forever/horde/05-stonetalon-mountains.guide').steps;
	const box = steps.findIndex((st) => st.title === 'Strange Lockbox');
	const sep = steps.findIndex((st) => st.goals.some(is('accept', 493)));
	assert.ok(box >= 0 && sep === box + 1, 'the Sepulcher step comes right after the lockbox');
	const tip = [].concat(steps[sep].note || []).join(' ');
	assert.match(tip, /Strange Lockbox|\{object:177844\}/);
	assert.doesNotMatch(tip, /^From the zeppelin towers/);
});

// Detour-from-tip sweep (0.3.6 leftovers): Kadrak's step, right after the Rogues' Taskmaster Fizzule (55.44,5.56,
// just east of Kadrak at 48.12,5.42), said "From Seereth's camp head north-east" to everyone.
test('forever/horde/05-stonetalon-mountains.guide: the Kadrak tip gives Rogues coming from Fizzule their way', { skip }, () => {
	const steps = compiled('forever/horde/05-stonetalon-mountains.guide').steps;
	const fiz = steps.findIndex((st) => st.goals.some(is('turnin', 2458)));
	const kad = steps.findIndex((st) => st.goals.some(is('turnin', 6541)));
	assert.ok(fiz >= 0 && kad === fiz + 1, 'Kadrak right after Fizzule');
	assert.match([].concat(steps[kad].note || []).join(' '), /Rogues coming from .*tower head west/);
});

// Players' recordings (0.3.6): Further Instructions (1094, 830 XP) was skipped as "a hand-in on a stop
// of its own" at Ratchet, but Ziz Fizziks offers it on the Super Reaper 6000 hand-in at the end of 02-the-barrens and
// Sputtervalve stands 5 yd from Ratchet's flight master, where 04-the-barrens lands for Mahren. 21 recorded people took
// it, 16 handed it in.
test('Horde Barrens: Further Instructions from Ziz, handed to Sputtervalve on the Ratchet landing', { skip }, () => {
	const b2 = goals('forever/horde/02-the-barrens.guide');
	const acc = at(b2, 'accept 1094', is('accept', 1094));
	assert.equal(b2[acc].s, b2[at(b2, 'turnin 1093', is('turnin', 1093))].s, 'offered by Ziz on the Super Reaper 6000 hand-in');
	const b4 = goals('forever/horde/04-the-barrens.guide');
	const fly = at(b4, 'fly Ratchet', (g) => g.t === 'fly' && g.location === 'Ratchet');
	const tin = at(b4, 'turnin 1094', is('turnin', 1094));
	assert.ok(fly < tin && tin < at(b4, 'turnin 874', is('turnin', 874)), 'on landing in Ratchet, before Mahren');
	assert.ok(b4[tin].step.when.some((p) => p.k === 'onquest' && !p.neg && p.q.includes(1094)), 'only while carried: a fresh loader never sees it');
});

// Players' recordings (0.3.6): Darkcloud Pinnacle's Document Chests were listed north-west first, so the
// arrow led from Freewind past the two southern Grimtotem camps to the north-west one and back south (8 of 9 people
// on 0.3.5+ walked it so). From Freewind the chests go south-east, south-west, north-west, and the top-up and the climb
// to Lakota start from the north.
test('Horde Thousand Needles: Darkcloud chests south-east, south-west, north-west from Freewind', { skip }, () => {
	const list = goals('forever/horde/07-ashenvale.guide');
	const chest = (o) => at(list, `interact ${o}`, (g) => g.t === 'interact' && g.object === o);
	assert.ok(chest(190484) < chest(190483) && chest(190483) < chest(176344), 'south-east, south-west, north-west');
	const spot = list.find(({ step, goal }) => step.title === 'Level 28' && goal.t === 'goto').goal;
	assert.ok(spot.y < 35, `the top-up is in the northern camps (${spot.x},${spot.y}), not back at the south-west chest`);
});

// Horde 12-30 bracket review (0.3.6): Kaya Flathoof waits in Grundig Darkcloud's hut on the Webwinder Path, which the
// Barrens guide walks past going up and coming back down; her escort to Camp Aparaje runs on the way down, before
// Xen'Zilla at Malaka'jin, Makaba takes it on the last Seereth stop, and Tammra takes Kaya's Alive at Sun Rock only for
// a player who carries it.
test('Horde Barrens 15-21: Protect Kaya on the way down the Webwinder Path, Kaya\'s Alive at Sun Rock', { skip }, () => {
	const list = goals('forever/horde/02-the-barrens.guide');
	const ziz = at(list, 'Further Instructions from Ziz', is('accept', 1094));
	const take = at(list, 'Protect Kaya', is('accept', 6523));
	const done = at(list, 'the escort', (g) => g.t === 'complete' && g.quest === 6523);
	const xen = at(list, "Xen'Zilla", is('turnin', 6461));
	assert.ok(ziz < take && take < done && done < xen, 'Kaya after Ziz, her escort before Xen\'Zilla on the way down');
	assert.equal(list[take].goal.npc, 11856);
	const makaba = at(list, 'Makaba takes Protect Kaya', is('turnin', 6523));
	assert.ok(makaba > xen && makaba < at(list, "Kaya's Alive", is('accept', 6401)), "Makaba hands out Kaya's Alive after the escort");
	const sun = goals('forever/horde/04-the-barrens.guide');
	const { step, goal } = sun[at(sun, 'Tammra takes Kaya\'s Alive', is('turnin', 6401))];
	assert.equal(goal.npc, 11864);
	assert.ok((step.when || []).some((p) => p.k === 'onquest' && !p.neg && p.q.includes(6401)), "only for a player carrying Kaya's Alive");
});



// Horde 12-30 bracket review (0.3.6): Supplying the Sepulcher (Undead only) runs on stops the Silverpine guide already
// makes: Podrig and Karos at the first Sepulcher stop, Gordon Wendham and Michael Garrett on the Undercity stop at the
// end, Return to Podrig on the ride through the Sepulcher in the next Silverpine visit, shown only to a carrier.
test('Horde Silverpine: Supplying the Sepulcher on the Sepulcher and Undercity stops, Undead only', { skip }, () => {
	const list = goals('forever/horde/03-silverpine-forest.guide');
	const order = [is('accept', 6321), is('turnin', 6321), is('accept', 6323), is('turnin', 6323), is('accept', 6322), is('turnin', 6322), is('accept', 6324)];
	let last = -1;
	for (const pred of order) {
		const i = at(list, 'Supplying the Sepulcher chain', pred);
		assert.ok(i > last, 'the chain in order');
		const { step, goal } = list[i];
		assert.deepEqual((goal.only || step.only).races, ['Scourge'], `${goal.t} ${goal.quest}: Undead only`);
		last = i;
	}
	const sepulcher = list[at(list, 'first Sepulcher stop', is('accept', 6321))].step;
	assert.ok(sepulcher.goals.some((g) => g.t === 'getfp'), 'Podrig on the Sepulcher flight path stop');
	const uc = list[at(list, 'Undercity stop', is('turnin', 6323))].step;
	assert.ok(uc.goals.some((g) => g.t === 'turnin' && g.quest === 441), 'Gordon on the Undercity stop with Raleigh');
	const ride = goals('forever/horde/05-stonetalon-mountains.guide');
	const { step } = ride[at(ride, 'Return to Podrig', is('turnin', 6324))];
	assert.ok((step.when || []).some((p) => p.k === 'onquest' && !p.neg && p.q.includes(6324)), 'only for a player carrying the crate');
});

// Horde 12-30 bracket review (0.3.6), #1559: the start campfires' Camping 101 profession quests (Brakk in Durotar,
// Eleanor Shackleton in Tirisfal) end at trainers on the Silverpine guide's Orgrimmar walk and Undercity stop. Optional
// goals are not taken by auto accept / auto turn-in once the rest of their step is done (#1559), so each hand-in is a
// plain turn-in on a step of its own, shown only while that quest is in the log: the live step's goal, which auto
// turn-in hands in at the trainer, and nothing for a player without the quest.
test('Horde Silverpine: Camping 101 hand-ins as plain turn-ins on carrier-only steps beside the trainers\' stops (#1559)', { skip }, () => {
	const list = goals('forever/horde/03-silverpine-forest.guide');
	for (const [quest, npc, race] of [
		[97905, 3404, 'Orc'], [97901, 11066, 'Orc'], [97908, 7088, 'Orc'], [97906, 3365, 'Orc'],
		[96102, 2855, 'Orc'], [97899, 11046, 'Orc'], [97959, 4598, 'Scourge'], [97952, 4605, 'Scourge'], [97954, 4586, 'Scourge'],
	]) {
		const { step, goal } = list[at(list, `Camping 101 ${quest}`, is('turnin', quest))];
		assert.equal(goal.npc, npc, `${quest}: its trainer`);
		assert.ok(!goal.optional, `${quest}: a plain turn-in, which auto turn-in takes (#1559)`);
		assert.deepEqual(step.goals.map((g) => g.t), ['complete', 'turnin'], `${quest}: a step of its own, talk to the trainer then hand in`);
		assert.ok((step.when || []).some((p) => p.k === 'onquest' && !p.neg && [].concat(p.q).includes(quest)), `${quest}: only for a carrier`);
		assert.ok(step.only.races.includes(race), `${quest}: for the race whose campfire gives it`);
	}
});

// Horde 12-30 bracket review (0.3.6, measured): Thunder Bluff at the start of the Barrens & Stonetalon guide gives
// Pigments for Paints and The Sacred Flame, worked on walks the route already makes (Mirkfallon Lake by Sun Rock;
// Raynewood and the moonwell before Mystral Lake; Splithoof Hold by the Galak camps) and handed in on Ashenvale &
// Thousand Needles' Thunder Bluff and Freewind stops. Druids take them at the end of Hillsbrad, already in Thunder
// Bluff. Every work and hand-in step after the stop is shown only to a carrier. Shredding Machines rides the same
// opening: Seereth on the road west, the XT robots by Ziz, Seereth again on the way back east.
test('Horde 24-30: Thunder Bluff stop for Pigments and The Sacred Flame, carriers only after it; Shredding Machines on the Webwinder road', { skip }, () => {
	const b = goals('forever/horde/04-the-barrens.guide');
	const tb = at(b, 'the Thunder Bluff stop', is('accept', 1195));
	assert.equal(b[tb].goal.npc, 4721);
	// Level tidy 0.4.0: the guide now opens with a Crossroads landing for Korran's Egg Hunt; the flight that matters
	// is the next one to the Crossroads after the Thunder Bluff stop.
	const onward = b.findIndex(({ goal }, i) => i > tb && goal.t === 'fly' && /Crossroads/.test(goal.dest || goal.name || goal.to || JSON.stringify(goal)));
	assert.ok(onward > tb && at(b, 'Tah', is('accept', 97538)) < onward, 'both quests before the flight to the Crossroads');
	const carrier = (list, i, q) => assert.ok((list[i].step.when || []).some((p) => (p.k === 'onquest' || p.k === 'complete') && !p.neg && [].concat(p.q).includes(q)), `${list[i].goal.t} ${q}: only for a carrier`);
	carrier(b, at(b, 'Mirkweed Pods', (g) => g.t === 'collect' && g.item === 278201), 97538);
	assert.ok(at(b, 'Mirkweed Pods', (g) => g.t === 'collect' && g.item === 278201) > at(b, 'Gaea Seeds', (g) => g.t === 'collect' && g.item === 16205), 'the pods with the Gaea Seeds\' shore');
	const s1 = at(b, 'Seereth gives 1068', is('accept', 1068));
	const xt = at(b, 'XT:9', (g) => g.t === 'kill' && g.npc === 4074);
	const s2 = at(b, 'Seereth takes 1068', is('turnin', 1068));
	// Since the 0.4.0 audit the XT robots come on the way back down from Sun Rock, with Gerenzo: one Windshear Crag trip.
	assert.ok(s1 < at(b, "Jin'Zil", is('accept', 1058)) && xt > at(b, 'Sun Rock', is('turnin', 6393)) && xt < at(b, "Jin'Zil's hand-in", is('turnin', 1058)) && s2 > at(b, "Jin'Zil's hand-in", is('turnin', 1058)), 'Seereth on the way in, the XTs on the way down, Seereth on the way out');
	const a = goals('forever/horde/07-ashenvale.guide');
	const phial = at(a, 'the moonwell', (g) => g.t === 'collect' && g.item === 5868);
	assert.ok(at(a, 'Shadumbra', (g) => g.t === 'collect' && g.item === 16304) < phial && phial < at(a, 'Tideress', (g) => g.t === 'collect' && g.item === 16408), 'the phial between Raynewood and Mystral Lake');
	carrier(a, phial, 1195);
	for (const [q, what] of [[1195, 'turnin'], [97538, 'turnin'], [1196, 'turnin'], [1197, 'turnin']]) carrier(a, at(a, `${what} ${q}`, is(what, q)), q);
	carrier(a, at(a, 'the Cloven Hoof', (g) => g.t === 'collect' && g.item === 5869), 1197);
	const h = goals('forever/horde/06-hillsbrad-foothills.guide');
	const { step } = h[at(h, 'Druids in Thunder Bluff', is('accept', 1195))];
	assert.ok(step.only && step.only.classes && step.only.classes.includes('DRUID'), 'Druids, already in Thunder Bluff');
});

// #1531 (Discord, Undead Warlock 27): Ursangous, Sharptalon and Shadumbra drop their trophies only once The Ashenvale
// Hunt (6383) is handed in (loot conditions); a player who skipped the Ashenvale & Silverpine guide's Splintertree stop
// was sent hunting for nothing. The hunt steps now wait for 6383, Senani gives it on the first Splintertree stop to a
// player without it, and the two hunts passed before that stop come round again near Mystral Lake and on the way back.
test('#1531: the Ashenvale hunt trophies only after The Ashenvale Hunt, offered at Splintertree to a player without it', { skip }, () => {
	const list = goals(ASHENVALE_HORDE);
	const hunt = (q) => list.filter(({ goal }) => goal.t === 'collect' && goal.item === q);
	for (const item of [16303, 16305, 16304]) {
		const found = hunt(item);
		assert.ok(found.length >= 1, `${item} is hunted`);
		for (const { step } of found) assert.ok((step.when || []).some((p) => p.k === 'turnedin' && !p.neg && [].concat(p.q).includes(6383)), `${item}: only once The Ashenvale Hunt is handed in`);
	}
	// Handed in on the spot (#1699): Senani's window takes it straight back.
	const senani = at(list, 'Senani hands it in', (g) => is('turnin', 6383)(g) && g.direct);
	assert.ok((list[senani].step.when || []).some((p) => p.k === 'turnedin' && p.neg && [].concat(p.q).includes(6383)), 'only for a player without it');
	assert.ok(senani < at(list, 'Shadumbra', (g) => g.t === 'collect' && g.item === 16304), 'before Shadumbra');
	const late = hunt(16303).map((e) => list.indexOf(e)).filter((i) => i > senani);
	assert.ok(late.length === 1 && late[0] < at(list, 'the hunts handed in', is('turnin', 2)), 'Ursangous comes round again after Splintertree, before the hand-in');
});

// Offered-timed sweep (2026-11-10, Apothecary Zamah reported in play with 42:00 left): Helbrim offers Apothecary Zamah (853,
// 45 minutes, to Zamah in Thunder Bluff's Pools of Vision) on the Fungal Spores hand-in, and the shared Barrens route
// never goes to Thunder Bluff (0.3.5+ recordings: 4 took it, none handed it in). Druids fly there from the next
// Crossroads stop: they take it on that stop and hand it in first thing on the Thunder Bluff step right after it;
// nobody else takes it, and the Fungal Spores stop says to leave it.
test('Horde Barrens 15-21: Apothecary Zamah only for Druids, taken right before their Thunder Bluff flight', { skip }, () => {
	const list = goals('forever/horde/02-the-barrens.guide');
	const spores = list[at(list, 'the Fungal Spores hand-in', is('turnin', 848))];
	assert.ok([spores.step.tip, spores.step.note].flat().filter(Boolean).join(' ').includes('Apothecary Zamah'), 'the Fungal Spores stop says to leave it');
	const druid = list.filter(forClass('DRUID'));
	const take = at(druid, 'Apothecary Zamah for Druids', is('accept', 853));
	const hand = at(druid, 'Zamah takes the spores', is('turnin', 853));
	assert.ok(take > druid.findIndex(({ goal }) => goal === spores.goal), 'taken after Fungal Spores, not on its stop');
	assert.equal(druid[take].goal.npc, 3390, 'from Apothecary Helbrim');
	assert.equal(druid[hand].goal.npc, 3419, 'to Apothecary Zamah');
	assert.equal(druid[hand].s, druid[take].s + 1, 'handed in on the step right after the stop that takes it');
	const first = druid.findIndex(({ s }) => s === druid[hand].s);
	assert.ok(druid.slice(first, hand).every(({ goal }) => goal.t === 'fly'), 'Zamah first on the Thunder Bluff step, before the trainer');
	for (const cls of ['WARRIOR', 'PALADIN', 'HUNTER', 'ROGUE', 'PRIEST', 'SHAMAN', 'MAGE', 'WARLOCK']) {
		assert.ok(!list.filter(forClass(cls)).some(({ goal }) => goal.quest === 853), `${cls}: no Apothecary Zamah`);
	}
});

// SpydaPablo's report (#1676, 0.3.6, Undead Paladin 26): the Barrens & Stonetalon guide ends with a flight
// to Ratchet for Sputtervalve (1094) and Mahren Skyseer (874, then Isha Awak 873); with none of them in
// the log the player flew there for nothing and back through the Crossroads for the next guide's flight to
// Zoram'gar. The flight shows only while one of them is in the log; the guide-fixes record keeps it.
test("SpydaPablo's report (#1676): the Barrens' last flight to Ratchet is only for its quests", { skip }, () => {
	const guide = 'forever/horde/04-the-barrens.guide';
	const step = compiled(guide).steps.find((st) => st.goals.some((g) => g.t === 'fly' && /Ratchet/.test(g.location || '')));
	assert.ok(step, 'the flight to Ratchet');
	const gate = (step.when || []).find((p) => p.k === 'onquest' && !p.neg);
	assert.deepEqual(gate && [].concat(gate.q).sort((a, b) => a - b), [873, 874, 1094]);
	const fixes = JSON.parse(fs.readFileSync(path.join(ROOT, 'data', 'guide-fixes.json'), 'utf8')).fixes;
	assert.ok(fixes.some((f) => f.at && f.at.goal === 'fly' && f.at.guide === 'forever/horde/04-the-barrens' && f.at.fly === 'Ratchet' && f.when === 'onquest 1094,874,873'), 'the gate is a guide-fixes record');
});

// #1952, the Silverpine half (0.4.0 route audit): the Orcs' and Trolls' Camping 101 hand-ins to the Orgrimmar trainers on
// Silverpine's arrival stop, and the Undead's to the Undercity trainers on its Undercity stop, sent the player there
// whatever the profession's skill; they wait for the quest to be complete too, each with its record.
test('#1952: Silverpine Forest\'s Orgrimmar and Undercity Camping 101 trainer steps wait until the quest is complete', { skip }, () => {
	const fixes = JSON.parse(fs.readFileSync(path.join(ROOT, 'data', 'guide-fixes.json'), 'utf8')).fixes;
	const hand = goals(SILVERPINE).filter(({ goal }) => goal.t === 'turnin' && /^Camping 101: (?!Cooking)/.test(goal.title || ''));
	assert.deepEqual(hand.map(({ goal }) => goal.quest).sort(), [96102, 97899, 97901, 97905, 97906, 97908, 97952, 97954, 97959], 'the nine trainer hand-ins');
	for (const { step, goal } of hand) {
		assert.ok((step.when || []).some((p) => p.k === 'complete' && !p.neg && p.q === goal.quest), `turnin ${goal.quest} waits until the quest is complete`);
		assert.ok(fixes.some((f) => f.at && f.at.quest === goal.quest && f.at.goal === 'turnin' && f.when === `complete ${goal.quest}`), `${goal.quest}: a record the build keeps`);
	}
});

// Horde 21-30 audit (0.4.0, #2025): the Barrens & Stonetalon guide worked Stonetalon first, then walked Sun Rock ->
// Malaka'jin -> Seereth -> Camp Taurajo (about 4.7 km) for the southern Barrens and back up from the Great Lift, and
// flew to Ratchet only at the end, so Sputtervalve's new orders (1095) and Gerenzo Wrenchwhistle (1096), both for Ziz
// Fizziks on the Webwinder Path, were never offered. The southern Barrens and Ratchet now come first, Stonetalon last;
// Grish Longrunner's letter (5881) and Brave Moonhorn's message (4542) are done on the Ashenvale & Thousand Needles
// guide's own Great Lift step. Calibrated level model: 0.10-0.15 h sooner to 60 on every Horde branch.
test('forever/horde/04-the-barrens.guide: Horde 21-30 audit: the southern Barrens and Ratchet before Stonetalon, Gerenzo on the Webwinder Path (#2025)', { skip }, () => {
	const list = goals('forever/horde/04-the-barrens.guide');
	const gann = at(list, 'turnin 849', is('turnin', 849));
	const ratchet = at(list, 'turnin 1094', is('turnin', 1094));
	const jinzil = at(list, 'accept 1058', is('accept', 1058));
	assert.ok(gann < ratchet && ratchet < jinzil, 'Gann, then Ratchet, then Malaka\'jin');
	assert.ok(at(list, 'turnin 873', is('turnin', 873)) < jinzil, 'Isha Awak before the walk west');
	const orders = at(list, 'accept 1095', is('accept', 1095));
	const ziz = at(list, 'turnin 1095', is('turnin', 1095));
	const arm = at(list, 'collect 5736', (g) => g.t === 'collect' && g.item === 5736);
	const back = at(list, 'turnin 1096', is('turnin', 1096));
	assert.ok(ratchet <= orders && orders < ziz && ziz < arm && arm < back, 'Sputtervalve, Ziz, Gerenzo, Ziz');
	// Since the 0.4.0 level tidy Gerenzo (27) is taken from Ziz on the way back down from Sun Rock, about a level later.
	assert.ok(arm > at(list, 'turnin 6393', is('turnin', 6393)) && back < at(list, 'turnin 1058', is('turnin', 1058)), 'Gerenzo after Sun Rock, before Malaka\'jin');
	assert.ok(!list.some(({ goal }) => goal.quest === 4542 || (goal.t === 'turnin' && goal.quest === 5881)), 'the Great Lift errands are the next guide\'s');
	assert.deepEqual(list.filter(({ goal }) => goal.t === 'sethome').map(({ goal }) => goal.location), ['Camp Taurajo'], 'one bind, Camp Taurajo (no Sun Rock bind: the hearth ends the guide)');
	const next = goals(ASHENVALE_HORDE);
	const lift = at(next, 'turnin 5881', is('turnin', 5881));
	assert.equal(next[at(next, 'accept 4542', is('accept', 4542))].s, next[lift].s, 'Grish and Moonhorn on one Great Lift step');
	assert.ok(lift < at(next, 'turnin 4542', is('turnin', 4542)), 'before Freewind (The Tear of the Moons is left out since the 0.4.0 level tidy)');
	const first = next[0];
	assert.ok(first.goal.t === 'goto' && Math.abs(first.goal.x - 51.5) < 0.5 && Math.abs(first.goal.y - 30.4) < 0.5, 'Ashenvale opens at the Crossroads\' flight master, the walk east from Seereth');
});

// Horde 21-30 audit (0.4.0, #2025): Faranell's Elixir of Agony (515) needs a Lesser Troll's Blood Elixir (3388), an
// Alchemy potion no vendor sells, and its hand-in waits six levels for the Hillsbrad coast in the 30-40 guide. The
// Hillsbrad 22-25 guide told everyone to take it and keep it; players' recordings: 2 people took it, 1 handed it in (at
// 38.8), 2 abandoned it. Since the level tidy (2026-11-15) the Horde route leaves 515 out (route-fixes skip 515).
test('forever/horde/06-hillsbrad-foothills.guide: Horde 21-30 audit: Elixir of Agony is not carried from Hillsbrad 22-25 (#2025)', { skip }, () => {
	assert.ok(!goals('forever/horde/06-hillsbrad-foothills.guide').some(({ goal }) => goal.quest === 515), 'no Elixir of Agony in the 22-25 guide');
	const fixes = JSON.parse(fs.readFileSync(path.join(ROOT, 'data', 'route-fixes.json'), 'utf8'));
	assert.ok(fixes.overrides.skip.some((s) => s.q === 515 && s.faction === 'Horde'), 'the skip is a route-fixes record');
});

// Horde 21-30 audit (0.4.0, #2025): Thunder Bluff has Warrior and Hunter trainers, but the Ashenvale & Thousand Needles
// stop trained only Paladins, Priests, Shamans, Mages and Druids, so Warriors and Hunters went from their training at the
// end of the Hillsbrad guide (about 26) to the 30-40 guide's Orgrimmar stop (about 31) without their rank 28 spells.
test(`${ASHENVALE_HORDE}: Horde 21-30 audit: Warriors and Hunters train on the Thunder Bluff stop (#2025)`, { skip }, () => {
	const step = compiled(ASHENVALE_HORDE).steps.find((s) => s.title === 'Class trainer' && s.goals.some((g) => g.t === 'train'));
	assert.ok(step, 'the Thunder Bluff training step');
	const classes = (step.only && step.only.classes) || [];
	for (const cl of ['WARRIOR', 'HUNTER', 'PALADIN', 'PRIEST', 'SHAMAN', 'MAGE', 'DRUID']) assert.ok(classes.map((c) => c.toUpperCase()).includes(cl), `${cl} trains there`);
});

// thadude3's report (#2013, Orc Warlock 28): from Camp Taurajo, with nothing to do in Thunder Bluff, the guide sent
// him up to the central rise for its flight path and flew him straight back to Camp Taurajo. The rise steps are
// for a player with an errand beside the rise (The Sacred Flame, Pigments for Paints); the flight to Camp Taurajo after
// them is done for a player already there.
test(`${ASHENVALE_HORDE}: thadude3's report (#2013): no Thunder Bluff bounce from Camp Taurajo`, { skip }, () => {
	const steps = compiled(ASHENVALE_HORDE).steps.filter((s) => s.title === 'Thunder Bluff' && s.goals.some((g) => g.t === 'goto' || g.t === 'getfp'));
	assert.equal(steps.length, 2, 'the walk to the central rise and the flight path');
	for (const s of steps) assert.ok((s.when || []).some((p) => p.k === 'onquest' && !p.neg && [].concat(p.q).includes(1195) && [].concat(p.q).includes(97538)), `${s.goals.map((g) => g.t).join(',')}: only with an errand beside the rise`);
});

// Discord report (Fitz's relay, #2025): Sharptalon's Claw (2) is a level 30 quest and Sharptalon a level 31 nightsaber;
// the first pass sent players after her at 27 (recordings: most kills at 27, 3 deaths near her). The claw is taken on
// the later pass only, on the way back to Splintertree from Mystral Lake, with her level in the tip.
test(`${ASHENVALE_HORDE}: Discord report: Sharptalon's Claw on the later pass, with her level named (#2025)`, { skip }, () => {
	const list = goals(ASHENVALE_HORDE);
	const claws = list.filter(({ goal }) => goal.t === 'collect' && goal.item === 16305);
	assert.equal(claws.length, 1, 'one Sharptalon step');
	assert.ok(at(list, 'kill 3917', (g) => g.t === 'kill' && g.npc === 3917) < list.indexOf(claws[0]), 'after Mystral Lake');
	assert.match([claws[0].step.note, claws[0].step.tip].flat().filter(Boolean).join(' '), /level 31/, 'the tip names her level');
});

// Horde 21-30 audit (0.4.0, danger gate #1575, #2025): the band's spots with mobs well above the player (players'
// recordings and Forever's spawn data) say so on the step: who stands there, their level, what to do.
test('Horde 21-30 audit: steps beside dangerous mobs name them (#1575, #2025)', { skip }, () => {
	for (const [guide, title, re] of [
		['forever/horde/05-stonetalon-mountains.guide', 'Silverpine Forest: kill these as you meet them', /High Order Mages \(30\)/],
		['forever/horde/04-the-barrens.guide', 'Field to Clear', /Qiraji Lieutenants \(28, elite\)/],
		['forever/horde/04-the-barrens.guide', "Bael'dun fortress", /General Twinbraid \(30\)/],
		['forever/horde/04-the-barrens.guide', 'The Charred Vale: kill these as you meet them', /level 27/],
		['forever/horde/07-ashenvale.guide', 'Felmusk satyrs', /stealth/],
		['forever/horde/07-ashenvale.guide', 'Gloomrise: kill these as you meet them', /Broodmother Valraxx \(30, elite\)/],
		['forever/horde/07-ashenvale.guide', 'Galak centaurs', /Stormheart \(30\).*Ravaging Tempests \(40\).*Ailgrha Splittusk \(38\)/],
	]) {
		const step = compiled(guide).steps.find((s) => s.title === title);
		assert.ok(step, `${guide}: ${title}`);
		assert.match([step.tip, step.note].flat().filter(Boolean).join(' '), re, `${guide}: ${title}`);
	}
	const take = goals(ASHENVALE_HORDE).find(({ goal }) => goal.t === 'accept' && goal.quest === 6621);
	assert.match(take.goal.note || '', /banner defence/, 'King of the Foulweald says what it asks');
});

// Horde 21-30 audit (danger gate #1575): Kirin Tor Guards (55) stand at Hillsbrad Fields' northern edge (players' recordings: 26
// Horde people met them as hostile there); the fields step says where.
test('forever/horde/06-hillsbrad-foothills.guide: Horde 21-30 audit: the fields step names the Kirin Tor Guards (#1575)', { skip }, () => {
	const step = compiled('forever/horde/06-hillsbrad-foothills.guide').steps.find((s) => s.title === 'Hillsbrad Fields');
	assert.match([step.tip, step.note].flat().filter(Boolean).join(' '), /Kirin Tor Guards \(55\)/);
});

// HaruSoul (#2459): the Great Lift step pointed at the lift's top landing, so after riding down the arrow kept sending
// the player back up. The step is the two NPCs at the top; the next step goes on to Freewind Post's lift.
test('#2459: Horde Ashenvale & Thousand Needles: the Great Lift step has no goto at the lift, the next step leads on', { skip }, () => {
	const list = goals(ASHENVALE_HORDE);
	const top = list.filter(({ step }) => step.title === 'The Great Lift');
	assert.deepEqual(top.map(({ goal }) => `${goal.t} ${goal.quest}`), ['turnin 5881', 'accept 4542'], 'Grish and Brave Moonhorn only');
	const next = list.find(({ s }) => s === top[0].s + 1);
	assert.ok(next && next.goal.t === 'goto' && /Freewind Post/.test(next.goal.text || ''), 'then on to Freewind Post');
});

// Phokopi (#2458): The Hunt Completed is handed in without an accept, only after the hunts it asks for; the guide asked
// for it with a hunt missing. Its hand-in is direct and waits for Sharptalon's Claw.
test('#2458: Horde Ashenvale: The Hunt Completed is a direct hand-in that waits for Sharptalon\'s Claw', { skip }, () => {
	const list = goals(ASHENVALE_HORDE);
	const { step, goal } = list[at(list, 'turnin 247', is('turnin', 247))];
	assert.ok(goal.direct, 'a direct hand-in');
	assert.ok((step.when || []).some((p) => p.k === 'turnedin' && !p.neg && [p.q].flat().includes(2)), 'waits for 2 handed in');
	assert.ok(!list.some(({ goal: g }) => is('accept', 247)(g)), 'no accept');
});

// #2615 (xstevan, 0.4.0, Horde Ashenvale & Thousand Needles): Test of Faith puts the player on a high cliff far west
// of Dorn Plainstalker; the leap counts only from the end of the wooden planks there. The complete goal had no
// point, so the arrow led back to Dorn, 1,250 yd away, and the player jumped from the wrong spot and died.
test('#2615: Thousand Needles (Horde): Test of Faith\'s leap points at the end of the planks', { skip }, () => {
	const list = goals('forever/horde/07-ashenvale.guide');
	const { goal, step } = list[at(list, 'complete 1149', is('complete', 1149))];
	assert.equal(goal.map, 1441);
	assert.ok(Math.abs(goal.x - 26.43) < 0.2 && Math.abs(goal.y - 32.93) < 0.2, `the planks, not Dorn: ${goal.x},${goal.y}`);
	assert.match(step.note || '', /end of the wooden planks/, 'the tip says where to step off');
});
