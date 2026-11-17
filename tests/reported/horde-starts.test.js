'use strict';
// Player-reported guide fixes: the Horde start zones (Durotar, Mulgore, Tirisfal Glades, the Horde Zephras Isle).
// tests/reported/helpers.js says what the cases check and where a new one goes.

const { test } = require('node:test');
const assert = require('node:assert/strict');
const fs = require('node:fs');
const path = require('node:path');
const {
	allGuides, at, buildSimPack, chainFrom, collects, compiled, dist, dungeonOnly, DUROTARS, everyone, forClass, goals,
	is, located, makeProjector, MULGORE, OFFICIAL_DIR, ORC_DUROTAR, playGuide, questGoalStatus, refData, ROOT, skip,
	SKYBORNE_HORDE, stepView, TIRISFAL, TROLL_DUROTAR, warriorOf, where, yards, ZEPHRAS_HORDE,
} = require('./helpers');

const painInTheNeck = (guide, opts) => questGoalStatus(guide, 96873, warriorOf(guide), opts);

// --- Tirisfal (Fitz, #1046): out of Deathknell the road passes Calvin
// Montague, Deathguard Simmer, the pumpkin fields and Gordo's road before
// Brill. The guide ran past Simmer, Dillinger and Executor Zygand, went back
// to Solliden for A Rogue's Deal and saved the pumpkins for a sweep much
// later. Now what the road in passes is taken and done on it, Brill is
// entered from the west (Dillinger and Bartholomew, Holland, the branches and
// Eleanor, then the square: Zygand before Sevren), Calvin's duel is fought on
// the west loop's way to the Crusader's Outpost, and no step is an along list.
const TIRISFAL_CLASSES = ['WARRIOR', 'ROGUE', 'PRIEST', 'MAGE', 'WARLOCK', 'PALADIN'];

// --- Brill (Fitz, #1046 follow-up): the guide had him hand in outside, go
// into the Gallows' End Tavern, back outside, then into the inn again. Who is
// inside comes from the walking grid's WMO areas: Renee, Coleman, Yvette,
// Austil de Mon and William Pickman downstairs, Gretchen and the four trainers
// upstairs, both captives in the cellar (not the town hall's). On every Brill
// visit the inn is entered once: no goal outside it in Brill between two goals
// inside it, until the walk leaves town.
const BRILL_INN = { map: 1420, x: [61.45, 62.05], y: [51.2, 52.9] };
const BRILL = { map: 1420, x: [56.5, 63.0], y: [47.5, 54.5] };
const inBox = (g, b) => g.map === b.map && g.x >= b.x[0] && g.x <= b.x[1] && g.y >= b.y[0] && g.y <= b.y[1];

test(`${MULGORE}: Sharing the Land leads to each gnoll objective and resumes partial progress`, { skip }, () => {
	// The Horde chain runs through the shared Shen'dralas guide since the 0.4.0 level tidy; its Alliance `next` is not in
	// this Horde pack.
	const pack = buildSimPack(allGuides().filter(f => f.startsWith('forever/horde/') || f === 'forever/40-50/shendralas.guide'));
	try {
		assert.deepEqual(pack.diag.errors.filter((e) => !/`next` points to unknown guide "forever\/alliance\//.test(e.message)), []);
		const g = pack.guides.find(g => g.id === MULGORE.slice(0, -6));
		const si = g.steps.findIndex(s => s.goals.some(v => v.quest === 745 && ['kill', 'complete'].includes(v.t))) + 1;
		assert.ok(si > 0);
		for (const cls of ['SHAMAN', 'WARRIOR', 'DRUID']) {
			const [out] = playGuide(pack, g, {
				race: 'Tauren', faction: 'Horde', cls,
				before: 'w.level=12;w.onQuest(745,{{required=10},{required=8},{required=5}})',
				script: `
local E=Polestar.Engine;E.Goto(${si})
local function snap()
 local p=E.GetWaypoint();local v=p and E.GetGuide().steps[p.stepIndex].goals[p.goalIndex]
 return p and {map=p.map,x=p.x,y=p.y,quest=v.quest,npc=v.npc,oi=v.oi}or false
end
local out={snap()}
for _,row in ipairs({{1,9},{1,10},{2,7},{2,8},{3,4}})do w.progress(745,row[1],row[2]);stub.advance(.6);out[#out+1]=snap()end
w.progress(745,3,5);stub.advance(.6)
local done=true;for _,v in ipairs(E.GetStepView(${si}).goals)do if v.quest==745 and v.status~='done'then done=false end end
emit({points=out,done=done})`,
			});
			assert.equal(out.points.length, 6);
			for (const [i, p] of out.points.entries()) {
				assert.ok(p, `${cls}: the active gnoll objective has an arrow`);
				assert.equal(p.map, 1412);
				assert.equal(p.quest, 745);
				// The objectives finished by snapshot i: 2949 (oi 1) after the second, 2950 (oi 2) after the fourth.
				// The arrow leads to an unfinished one, never a finished one (PR #632), in whichever order.
				const open = [[2949, 2950, 2951], [2949, 2950, 2951], [2950, 2951], [2950, 2951], [2951], [2951]][i];
				assert.ok(open.includes(p.npc), `${cls}: arrow ${i} leads to an unfinished objective ${open}, not ${p.npc}`);
				assert.equal(p.oi, [2949, 2950, 2951].indexOf(p.npc) + 1, `${cls}: arrow ${i}'s objective is ${p.npc}'s`);
				assert.equal(typeof p.x, 'number');
				assert.equal(typeof p.y, 'number');
			}
			assert.equal(out.done, true, `${cls}: all three counts finish the work`);
		}
	} finally {
		pack.dispose();
	}
});

// --- Durotar (Tom): Sting of the Scorpid and the cactus apples come along to Sarkoth.

for (const DUROTAR of DUROTARS) test(`${DUROTAR}: Tom's report: Cutting Teeth is turned in and Sting of the Scorpid and Galgar's Cactus Apple Surprise accepted before Sarkoth`, { skip }, () => {
	const list = goals(DUROTAR);
	const sarkoth = at(list, "Sarkoth's Mangled Claw", (g) => g.t === 'collect' && g.quest === 790);
	assert.ok(at(list, 'turnin 788 (Cutting Teeth)', is('turnin', 788)) < sarkoth, 'Cutting Teeth is handed in before Sarkoth');
	assert.ok(at(list, 'accept 789 (Sting of the Scorpid)', is('accept', 789)) < sarkoth, 'Sting of the Scorpid is taken before Sarkoth');
	assert.ok(at(list, "accept 4402 (Galgar's Cactus Apple Surprise)", is('accept', 4402)) < sarkoth, 'the cactus apples are taken before Sarkoth');
	// Their objectives are done on Sarkoth's slope, before going back to the Den.
	const back = at(list, 'turnin 804 (Sarkoth)', is('turnin', 804));
	for (const q of [789, 4402]) assert.ok(at(list, `the objective of ${q}`, (g) => g.t === 'collect' && g.quest === q) < back, `${q}'s objective is done before the Den`);
});

// --- Durotar (tor, #352): Securing the Lines is a level 11 quest, so Rezlak
// and Thunder Ridge come after the south loop, with Fizzle Darkstorm.

for (const DUROTAR of DUROTARS) test(`${DUROTAR}: tor's report: Securing the Lines is taken after the Sen'jin, Echo Isles and Kolkar Crag turn-ins, on Fizzle Darkstorm's visit`, { skip }, () => {
	const list = goals(DUROTAR);
	const securing = at(list, 'accept 835 (Securing the Lines)', is('accept', 835));
	// 835 is level 11 against level 9-10 mobs: the south's level 8 quests are
	// handed in before it is taken, not left waiting for 11.
	for (const q of [817, 818, 826, 808, 786]) {
		assert.ok(at(list, `turnin ${q}`, is('turnin', q)) < securing, `${q} is handed in before Securing the Lines is taken`);
	}
	// Rezlak's pair rides along with Fizzle Darkstorm (806) on the same ridge:
	// taken after 806 is accepted, done before it is handed in.
	assert.ok(at(list, 'accept 806 (Fizzle Darkstorm)', is('accept', 806)) < at(list, 'accept 834 (Rezlak)', is('accept', 834)), '834 is taken after 806');
	assert.ok(at(list, 'turnin 835', is('turnin', 835)) < at(list, 'turnin 806', is('turnin', 806)), '835 is done before 806 is handed in');
});

// --- Durotar (level tidy 0.4.0): the southern Echo Isles were worked straight off the coast at 8 (players'
// 25th percentile 8.3), against Zalazane (10) and Voodoo and Hexed Trolls of 8-9 that killed 13 players there.
// Kolkar Crag and its Sen'jin hand-ins come first, then a top-up to 9 before the southern isles.
for (const DUROTAR of DUROTARS) test(`${DUROTAR}: level tidy: the southern Echo Isles come after Kolkar Crag and a top-up to 9`, { skip }, () => {
	const list = goals(DUROTAR);
	const isles = Math.min(at(list, 'the Loa idols (97225)', (g) => g.t === 'collect' && g.quest === 97225), at(list, "Zalazane's trolls (826)", (g) => g.t === 'kill' && g.quest === 826));
	for (const q of [786, 99123, 818]) assert.ok(at(list, `turnin ${q}`, is('turnin', q)) < isles, `${q} is handed in at Sen'jin before the southern isles`);
	const gate = list.slice(0, isles).findLastIndex(({ goal }) => goal.t === 'level');
	assert.ok(gate >= 0 && list[gate].goal.level >= 9, 'a top-up to 9 comes before the southern isles');
	assert.ok(gate > at(list, 'turnin 786', is('turnin', 786)), 'the top-up is after Kolkar Crag');
	assert.ok(list[gate].goal.grind === 3121, 'the top-up is on the Durotar Tigers (7-8)');
});

// --- Durotar (level tidy 0.4.0): Sarkoth (4) was met at 2.6; he waits for the first Den return's hand-ins and is fought
// on the way north to the Burning Blade Coven.
for (const DUROTAR of DUROTARS) test(`${DUROTAR}: level tidy: Sarkoth after the familiars and the first Den hand-ins`, { skip }, () => {
	const list = goals(DUROTAR);
	const sarkoth = at(list, "Sarkoth's Mangled Claw", (g) => g.t === 'collect' && g.quest === 790);
	assert.ok(at(list, 'the Vile Familiars (792)', (g) => g.t === 'kill' && g.quest === 792) < sarkoth, 'the familiars come first');
	for (const q of [789, 4402]) assert.ok(at(list, `turnin ${q}`, is('turnin', q)) < sarkoth, `${q} is handed in at the Den before Sarkoth`);
	assert.ok(sarkoth < at(list, 'turnin 790 (Hana\'zua)', is('turnin', 790)), 'Hana\'zua takes the claw after Sarkoth');
	assert.ok(at(list, 'turnin 790', is('turnin', 790)) < at(list, "Thazz'ril's Pick", (g) => g.t === 'collect' && g.quest === 6394), 'on the way to the Coven');
});

// --- Level tidy 0.4.0: three field steps whose drops also come from higher mobs point at the low camp.
test('Horde starts: level tidy: Strider Meat, Poison Water and Darkhound goals point at the low camps', { skip }, () => {
	const near = (g, x, y) => g.x != null && Math.abs(g.x - x) < 0.6 && Math.abs(g.y - y) < 0.6;
	const cases = [
		['forever/horde/skyborne/01-zephras-isle.guide', 92553, 2, 38.6, 43.6],
		[MULGORE, 748, 2, 50.2, 67.0],
		[MULGORE, 766, 3, 50.2, 67.0],
		[MULGORE, 766, 1, 49.8, 65.3],
		[MULGORE, 771, 2, 48.7, 64.5],
		[TIRISFAL, 367, 1, 51.1, 50.5],
		[TIRISFAL, 97558, 2, 51.1, 50.5],
		[TIRISFAL, 375, 1, 60.5, 43.1],
		[TIRISFAL, 97558, 1, 60.5, 43.1],
		[TIRISFAL, 368, 1, 60.8, 28.4],
		[TIRISFAL, 97558, 3, 60.8, 28.4],
	];
	for (const [guide, q, oi, x, y] of cases) {
		const list = goals(guide);
		const { goal } = list[at(list, `${q}.${oi}`, (g) => g.t === 'collect' && g.quest === q && g.oi === oi)];
		assert.ok(near(goal, x, y), `${q}.${oi} points at ${x},${y} (got ${goal.x},${goal.y})`);
	}
});

// --- Tirisfal Glades (level tidy 0.4.0): Maggot Eye's poster stands beside Executor Zygand: read with his hand-in.
test(`${TIRISFAL}: level tidy: Maggot Eye's poster with Executor Zygand on the last Brill stop`, { skip }, () => {
	const list = goals(TIRISFAL);
	const poster = at(list, 'accept 398', is('accept', 398));
	assert.ok(poster < at(list, 'turnin 492 (the cellar)', is('turnin', 492)), 'the poster before the inn cellar');
	assert.ok(poster < at(list, 'turnin 99142 (Holland)', is('turnin', 99142)), 'the poster before Holland on the way out');
});

// --- Durotar (level tidy 0.4.0): Fizzle Darkstorm (12) was fought in one step with the lizards at 10-11, before Misha.
// The lizards, Rezlak and Misha come first, then Fizzle's camp just north of Misha's hut.
for (const DUROTAR of DUROTARS) test(`${DUROTAR}: level tidy: Fizzle Darkstorm after the lizards, Rezlak and Misha`, { skip }, () => {
	const list = goals(DUROTAR);
	const fizzle = at(list, 'Fizzle\'s Eye (806)', (g) => g.t === 'collect' && g.quest === 806);
	for (const q of [816, 97282]) assert.ok(at(list, `turnin ${q}`, is('turnin', q)) < fizzle, `${q} is handed in before Fizzle`);
	assert.notEqual(list[fizzle].s, list[at(list, 'the lizards (97282)', (g) => g.t === 'collect' && g.quest === 97282)].s, 'Fizzle has a step of his own');
});

// --- Durotar (level tidy 0.4.0): Lieutenant Benedict (8) was killed at 6.6-7.1; a top-up to 7 on the sailors comes
// after the keep's outskirts and before him.
for (const DUROTAR of DUROTARS) test(`${DUROTAR}: level tidy: a top-up to 7 before Lieutenant Benedict`, { skip }, () => {
	const list = goals(DUROTAR);
	const benedict = at(list, 'Benedict (784.3)', (g) => g.t === 'kill' && g.quest === 784 && g.npc === 3192);
	const gate = list.slice(0, benedict).findLastIndex(({ goal }) => goal.t === 'level');
	assert.ok(gate > at(list, 'the marines (784.2)', (g) => g.t === 'kill' && g.quest === 784 && g.npc === 3129), 'the top-up after the sailors and marines');
	assert.ok(list[gate].goal.level >= 7 && list[gate].goal.grind === 3128, 'a top-up to 7 on the Kul Tiras Sailors');
});

// Hand-in sweep (2026-11-16, after Kerlonian's escort): Sparring Match (99108) was an accept and a hand-in at Krang
// Stonehoof with the Novice Warriors only in the tip, so the window went straight to "Turn in". The kills are a goal.
test(`${MULGORE}: Sparring Match counts the Novice Warriors between the accept and the hand-in`, { skip }, () => {
	const list = goals(MULGORE);
	const accept = at(list, 'accept 99108', is('accept', 99108));
	const kills = at(list, 'kill 10721 (99108.1)', (g) => g.t === 'kill' && g.quest === 99108 && g.npc === 10721);
	const turnin = at(list, 'turnin 99108', is('turnin', 99108));
	assert.ok(accept < kills && kills < turnin, 'accept, the Novice Warriors, then the hand-in');
});

// --- Mulgore (level tidy 0.4.0): the Galak centaurs (8-10, Herak 11) and the Venture Co. Mine (8-10, Fizsprocket
// 12) were worked at 9; they come after northern Mulgore and its Bloodhoof hand-ins, at about 11.
test(`${MULGORE}: level tidy: the Galak centaurs and the Venture Co. Mine after the northern Mulgore hand-ins`, { skip }, () => {
	const list = goals(MULGORE);
	const back = at(list, 'turnin 745 (Sharing the Land)', is('turnin', 745));
	for (const q of [743, 746, 760]) assert.ok(at(list, `turnin ${q}`, is('turnin', q)) < at(list, "Herak's Head (99080)", (g) => g.t === 'collect' && g.quest === 99080), `${q} is handed in before the centaurs`);
	assert.ok(back < at(list, 'the centaurs (99080)', (g) => g.t === 'kill' && g.quest === 99080), 'the centaurs after the Bloodhoof hand-ins');
	assert.ok(back < at(list, 'the mine (764)', (g) => g.t === 'kill' && g.quest === 764), 'the mine after the Bloodhoof hand-ins');
	assert.ok(at(list, 'turnin 99080', is('turnin', 99080)) < at(list, 'accept 833 (Red Rocks)', is('accept', 833)), 'Baine takes the head before Red Rocks');
});

// --- Tirisfal Glades (level tidy 0.4.0): the cult's farm (cultists 10-12, quests 12) was done at 10 on the way out to the
// Balnir Farmstead; it comes on the way back west, after the farmstead.
test(`${TIRISFAL}: level tidy: the Cult of the Damned after the Balnir Farmstead`, { skip }, () => {
	const list = goals(TIRISFAL);
	const balnir = Math.max(...[356, 371, 369].map((q) => at(list, `the objective of ${q}`, (g) => (g.t === 'kill' || g.t === 'collect') && g.quest === q)));
	for (const q of [96897, 96898]) assert.ok(balnir < at(list, `the objective of ${q}`, (g) => (g.t === 'kill' || g.t === 'collect') && g.quest === q), `${q} after the Balnir Farmstead`);
});

// --- Tirisfal Glades (level tidy 0.4.0): Maggot Eye (11) was killed on Brill's north loop at 7-8 (players' 25th
// percentile 8.1). The poster is read on the last Brill stop after the Balnir Farmstead, Garren's Haunt is on the
// walk west to Leonid, and the paw goes to Executor Zygand on the final Brill stop.
test(`${TIRISFAL}: level tidy: Maggot Eye after the Balnir Farmstead, not on the north loop`, { skip }, () => {
	const list = goals(TIRISFAL);
	const paw = at(list, "Maggot Eye's Paw (398)", (g) => g.t === 'collect' && g.quest === 398);
	for (const q of [371, 369, 356]) assert.ok(at(list, `turnin ${q}`, is('turnin', q)) < paw, `${q} is handed in before Maggot Eye`);
	assert.ok(at(list, 'turnin 368 (A New Plague)', is('turnin', 368)) < paw, 'the north loop and its murlocs come first');
	assert.ok(paw < at(list, 'turnin 96899 (Leonid)', is('turnin', 96899)), 'Garren\'s Haunt on the walk west to Leonid');
	assert.ok(at(list, 'turnin 398', is('turnin', 398)) > paw, 'Zygand takes the paw afterwards');
});

// --- Hand-overs (Onrevax, #337): a report an NPC gives you by hand names him,
// so the target button and the step key have someone to target.

test(`${TIRISFAL}: Onrevax's report: each Patience report goal names the NPC who hands it over`, { skip }, () => {
	const list = goals(TIRISFAL);
	for (const [item, npc, name] of [[286200, 1496, 'Deathguard Dillinger'], [286201, 251001, 'Deathguard Kristof'], [286202, 10666, 'Gordo']]) {
		const { goal } = list[at(list, `collect ${item} (${name})`, (g) => g.t === 'collect' && g.item === item)];
		assert.equal(goal.npc, npc, `${name} is named on the goal`);
		assert.equal(goal.npcName, name);
	}
});

// Gordo walks the road between his spawn (43.1,54.7) and the edge of Brill
// (CMaNGOS classic-db's waypoints for him), and you come to him for his report
// from the fields west of Brill.
test(`${TIRISFAL}: yiliev0's report (#674): Gordo's report is searched for along his road, from Brill's side out to his spawn`, { skip }, () => {
	const list = goals(TIRISFAL);
	const { goal } = list[at(list, 'collect 286202 (Gordo)', (g) => g.t === 'collect' && g.item === 286202)];
	const spots = (goal.spots || []).filter((s) => !s.alt);
	assert.ok(spots.length >= 3, `the arrow searches several points of his road: ${JSON.stringify(goal.spots)}`);
	const spawn = { map: 1420, x: 43.06, y: 54.69 };
	const at_ = (s) => ({ map: goal.map, x: s.x, y: s.y });
	assert.ok(yards(at_(spots[0]), spawn) >= 300, `the search starts at Brill's end of his road, not at his spawn: ${JSON.stringify(spots[0])}`);
	assert.ok(yards(at_(spots[spots.length - 1]), spawn) <= 30, 'and ends at his spawn');
});

// --- Caves (Tom): the arrow leads to a cave's mouth before anyone inside it.

// The Den: Kzan Thornslash stands at the back of the cave, behind Gornek just inside it.
for (const DUROTAR of DUROTARS) test(`${DUROTAR}: Tom's report: the arrow's last waypoint before Kzan Thornslash is the Den's mouth`, { skip }, () => {
	const list = goals(DUROTAR);
	const kzan = at(list, 'turnin 97279 (Wayward Weapons)', is('turnin', 97279));
	const last = list.slice(0, kzan).reverse().find(({ goal }) => goal.t === 'goto');
	assert.ok(last, 'a goto comes before Kzan');
	const { map, x, y } = last.goal;
	assert.deepEqual({ map, x, y }, { map: 1411, x: 42.4, y: 68.6 });
	// Whatever the arrow points at between the mouth and Kzan is inside the Den's mouth, not across the hill.
	const between = list.slice(list.indexOf(last) + 1, kzan).filter(located).filter(everyone);
	for (const { goal } of between) assert.ok(yards(goal, last.goal) < 40, `${goal.t} ${goal.quest || ''} lies by the mouth`);
});

// --- Durotar (Gruko, #240): the Burning Blade Coven in one trip. Vile Familiars
// is handed in and Burning Blade Medallion taken first, so Yarrog comes right
// after Thazz'ril's Pick inside the cave instead of a walk back to the Den and in again.
for (const DUROTAR of DUROTARS) test(`${DUROTAR}: Gruko's report (#240): Thazz'ril's Pick and Yarrog are done on one trip into the Burning Blade Coven, for every class`, { skip }, () => {
	const all = goals(DUROTAR);
	for (const cls of ['WARRIOR', 'HUNTER', 'ROGUE', 'PRIEST', 'SHAMAN', 'MAGE', 'WARLOCK']) {
		const list = all.filter(forClass(cls));
		const pick = at(list, "Thazz'ril's Pick", (g) => g.t === 'collect' && g.item === 16332);
		const yarrog = at(list, 'the Burning Blade Medallion', (g) => g.t === 'collect' && g.item === 4859);
		assert.ok(at(list, 'accept 794 (Burning Blade Medallion)', is('accept', 794)) < pick, `${cls}: the Medallion is taken before the cave`);
		assert.ok(pick < yarrog, `${cls}: the pick, then Yarrog`);
		assert.deepEqual(list.slice(pick + 1, yarrog).filter(located).map(({ goal }) => `${goal.t} ${goal.quest || goal.text}`), [], `${cls}: nothing outside the cave between the pick and Yarrog`);
	}
});

// Flow audit, Troll Durotar (#1077): the Troll guide went on to the Crossroads (Meats to Orgrimmar,
// Crossroads Conscription, the flight path), then walked 2,490 yd back to Razor Hill to hand Threat from
// Below to Orgnil, and the Barrens guide walked 2,197 yd back to the Crossroads for the five quests the
// player had stood next to. Razor Hill comes on the walk from Margoz to Far Watch Post, as in Orc's guide;
// both races hand Crossroads Conscription to Sergra on the Barrens guide's first stop, with the five quests.
for (const DUROTAR of DUROTARS) test(`${DUROTAR}: Threat from Below is handed in at Razor Hill on the way to Far Watch Post, and the Crossroads waits for the Barrens guide`, { skip }, () => {
	const list = goals(DUROTAR);
	const threat = at(list, 'the Threat from Below turn-in', is('turnin', 99051));
	// Horde 12-30 re-chain: Durotar ends in Orgrimmar. Warriors hand Conscript of the Horde to Kargal at Far Watch Post
	// before Orgrimmar, after Orgnil; everyone else on the Barrens guide's first stop (0.4.0 start audit).
	const mage = list.filter(forClass('MAGE'));
	assert.ok(at(mage, 'turnin 840', is('turnin', 840)) > at(mage, 'turnin 99051', is('turnin', 99051)), 'Kargal after Orgnil (Shamans hand it in on the way to Kranal)');
	const orgnil = list[threat].goal.npc;
	// Aggor the Young (99052) is a group choice (`when group 99052`): its accept and hand-in at Orgnil are for players who chose it.
	const grouped = ({ step }) => (step.when || []).some((p) => p.k === 'group' && !p.neg);
	assert.deepEqual(list.slice(threat + 1).filter((e) => e.goal.npc === orgnil && !e.goal.optional && !grouped(e) && !is('turnin', 99051)(e.goal)).map(({ goal }) => `${goal.t} ${goal.quest}`), [], 'nothing sends you back to Orgnil afterwards');
	assert.deepEqual(list.filter(({ goal }) => goal.quest === 6365 || is('turnin', 842)(goal) || goal.t === 'getfp').map(({ goal }) => `${goal.t} ${goal.quest || goal.location}`), [], 'the Crossroads stop is the Barrens guide\'s');
});

// Horde 1-30 audit (#1414): Threat from Below's goal led first to a lone Spitelash Attendant spawn by the road north
// of Razor Hill (53.8,34.6), where no recorded player saw or killed a naga; 161 ticks by 17 people lie on the beach
// below Drygulch Ravine, their middle at 58.9,27.0 (data/places.json 1414-durotar-spitelash-beach).
for (const DUROTAR of DUROTARS) test(`${DUROTAR}: Threat from Below's naga spinefins point at the beach below Drygulch Ravine, not the lone spawn by the road (#1414)`, { skip }, () => {
	const list = goals(DUROTAR);
	const { goal } = list[at(list, 'collect 286008 (Naga Spinefin)', (g) => g.t === 'collect' && g.quest === 99051)];
	assert.equal(goal.map, 1411, 'on the Durotar map');
	assert.ok(Math.hypot(goal.x - 58.9, goal.y - 27.0) < 1, `on the beach (${goal.x},${goal.y})`);
});

// Horde 1-30 audit (#1414): Mercy Falls on Deaf Ears' ears drop from the Stormchasers and Footsoldiers of the camp beside
// Vayn Moongaze (70 ticks by 13 people around 63.7,37.1); the item's drop list pointed every spot at the cult's southern
// camps, 200 yd and more away (data/places.json 1414-zephras-alaketh-ears).
test('forever/horde/skyborne/01-zephras-isle.guide: the Al\'Aketh Cultist\'s Ears point at the camp beside Vayn Moongaze (#1414)', { skip }, () => {
	const list = goals('forever/horde/skyborne/01-zephras-isle.guide');
	const { goal } = list[at(list, 'collect 258771 (Al\'Aketh Cultist\'s Ear)', (g) => g.t === 'collect' && g.quest === 93165)];
	assert.equal(goal.map, 2521, 'on the Zephras Isle map');
	assert.ok(Math.hypot(goal.x - 63.7, goal.y - 37.1) < 1, `at Vayn's camp (${goal.x},${goal.y})`);
});

for (const DUROTAR of DUROTARS) test(`${DUROTAR}: no "along the way" lists (Fitz: "They should just be steps")`, { skip }, () => {
	assert.deepEqual(compiled(DUROTAR).steps.filter((step) => step.along && step.goals.some((g) => [789, 4402, 97225, 837].includes(g.quest))).map((step) => step.title), []);
});

// Flow audit, Orc Durotar: Lar Prowltusk stands 21 yd from Master Gadrin on the first Sen'jin stop and offers
// Thwarting Kolkar Aggression at level 5 (11 recorded windows), but the guide walked 1,200 yd back to him from
// Razor Hill after Tiragarde Keep, then north again to the toolboxes east of Razor Hill. He is taken on the
// first stop, and the coast is walked from Razor Hill south; the egg and tiger fur lists are steps.
test(`${ORC_DUROTAR}: Lar Prowltusk on the first Sen'jin stop, the coast walked south from Razor Hill`, { skip }, () => {
	const list = goals(ORC_DUROTAR);
	const lar = at(list, 'accept 786 (Thwarting Kolkar Aggression)', is('accept', 786));
	assert.equal(list[lar].s, list[at(list, 'turnin 805 (Report to Sen\'jin Village)', is('turnin', 805))].s, 'Lar with Master Gadrin on the first Sen\'jin stop');
	const tools = at(list, 'the gnomish toolboxes (825)', (g) => g.quest === 825 && g.t === 'collect');
	const hand = at(list, 'turnin 784 (Vanquish the Betrayers)', is('turnin', 784));
	assert.deepEqual(list.slice(hand, tools).filter(located).filter(({ goal }) => yards(goal, list[lar].goal) < 150).map(({ goal }) => `${goal.t} ${goal.quest}`), [], 'no Sen\'jin stop between Razor Hill and the coast');
	assert.deepEqual(compiled(ORC_DUROTAR).steps.filter((step) => step.along).map((step) => step.title), [], 'no "along the way" lists');
});

test(`${MULGORE}: A Task Unfinished at Antur Fallow starts the cougar hunt, with no walk back into the camp`, { skip }, () => {
	const list = goals(MULGORE);
	const take = at(list, 'accept 1656 (A Task Unfinished)', is('accept', 1656));
	const hunt = at(list, 'the cougar hunt (750)', (g) => g.quest === 750 && g.t !== 'accept' && g.t !== 'turnin');
	assert.ok(take < hunt, 'Antur comes before the hunt');
	assert.equal(list[take].step, list[hunt].step, "Antur's quest opens the hunt's step: the hunt starts at his end of the camp");
	assert.deepEqual(list.slice(take + 1, hunt).filter(located).filter(everyone).map(({ goal }) => `${goal.t} ${goal.quest}`), [], 'the hunt follows Antur straight away');
	assert.ok(hunt < at(list, 'turnin 750', is('turnin', 750)), 'the hunt ends at Grull');
});

// Route review (0.3.7): the cougar hunt went round Seer Graytongue's tent, north to Grull, then back south
// to the Seer. The hunt now goes south to the Seer (her tent stands at the foot of the cougars' hills) and on to the
// shrine's Ritual Fire, then back up to Grull.
test(`${MULGORE}: Seer Graytongue and the shrine during the cougar hunt, no walk back south from Grull`, { skip }, () => {
	const list = goals(MULGORE);
	const antur = at(list, 'accept 1656', is('accept', 1656));
	const seer = at(list, 'turnin 755', is('turnin', 755));
	const shrine = at(list, 'turnin 95805', is('turnin', 95805));
	const grull = at(list, 'turnin 750', is('turnin', 750));
	const boars = at(list, 'Battleboar Snout', (g) => g.t === 'collect' && g.quest === 780);
	assert.ok(antur < seer && seer < shrine && shrine < grull && grull < boars, 'Antur, the Seer, the shrine, Grull, then the battleboars');
	assert.ok(list.slice(antur, seer).some(({ goal }) => goal.t === 'collect' && goal.quest === 750), 'the pelts on the way south to the Seer');
	const pairs = JSON.parse(fs.readFileSync(path.join(ROOT, 'data', 'route-fixes.json'), 'utf8')).deliberate.pairs;
	assert.ok(pairs.some((p) => p.a[0] === 'turnin' && p.a[1] === 95805 && p.b[0] === 'turnin' && p.b[1] === 750), 'a route-fixes pair keeps the order');
});

// Flow audit, Mulgore: the walk passed Bloodhoof's NPCs with finished quests and came back for them
// (Swoop Hunting and Rite of Vision on a later visit, Mazzranache two visits later), walked out to
// Morin Cloudstalker and Longwalker Malah a second time, and took Preparation for Ceremony after the
// whole Thunder Bluff shopping round although Eyahn stands beside Eylah. Each is now handed in or taken
// on the visit that passes it.
test(`${MULGORE}: Bloodhoof's hand-ins and pickups go on the visit that passes them`, { skip }, () => {
	const list = goals(MULGORE);
	const same = (what, a, b) => assert.equal(list[at(list, `${a[0]} ${a[1]}`, is(...a))].s, list[at(list, `${b[0]} ${b[1]}`, is(...b))].s, what);
	same('Swoop Hunting with Poison Water', ['turnin', 761], ['turnin', 748]);
	same('Rite of Vision with Poison Water', ['turnin', 771], ['turnin', 748]);
	same("Morin's caravan at the Winterhoof well", ['accept', 749], ['use', 754]);
	same('Longwalker Malah at the Winterhoof well', ['turnin', 99079], ['use', 754]);
	same('Grim Tidings with Winterhoof Cleansing', ['turnin', 99081], ['turnin', 754]);
	same('Mazzranache with Thunderhorn Totem', ['turnin', 766], ['turnin', 756]);
	same('Preparation for Ceremony beside Eylah', ['accept', 744], ['accept', 97485]);
	assert.deepEqual(compiled(MULGORE).steps.filter((step) => step.along).map((step) => step.title), [], 'no "along the way" lists (Fitz: "They should just be steps")');
});

test(`${TIRISFAL}: Onrevax's report (#365): the Coarse Thread for The Chill of Death is asked for again at the turn-in, from Abigail Shiel`, { skip }, () => {
	const list = goals(TIRISFAL);
	const hand = at(list, 'turnin 375 (The Chill of Death)', is('turnin', 375));
	const thread = list.findIndex(({ goal, s }) => s === list[hand].s && goal.t === 'buy' && goal.item === 2320);
	assert.ok(thread >= 0 && thread < hand, 'the turn-in step buys the thread before Gretchen');
	assert.equal(list[thread].goal.npc, 2118, 'from Abigail Shiel, Trade Supplies in Brill');
});

// --- Bandarion Keep (Mike_, 0.2.3): Hilda the Breaker and Ephram Barbaro offer their quests to Paladins only.

test(`${TIRISFAL}: Mike_'s report: only Paladins are sent to Hilda the Breaker and Ephram Barbaro at Bandarion Keep`, { skip }, () => {
	const list = goals(TIRISFAL);
	const keep = [246389, 259190]; // Hilda the Breaker, Ephram Barbaro
	const mage = list.filter(forClass('MAGE'));
	// Hilda's and Ephram's own quests after A Righteous Cause (99152, 99153) are open to every class: recorded
	// Warlocks, Rogues and Mages took and handed them in (16 and 15 people), so they are regular steps since the
	// 2026-11-07 quest-volume pass. A Mage meets them for those two quests only, never for the Paladin chain.
	assert.deepEqual(mage.filter(({ goal }) => keep.includes(goal.npc) && !goal.optional && ![99152, 99153].includes(goal.quest)).map(({ goal }) => `${goal.t} ${goal.quest} (${goal.npcName})`), [], 'a Mage meets neither giver for the Paladin chain');
	// The Shadowvale elixir bottles stay for everyone (at asserts the goal is there).
	at(mage, 'collect 268801 (Bottle of Whispering Elixir)', (g) => g.t === 'collect' && g.quest === 95314);
	const paladin = list.filter(forClass('PALADIN'));
	for (const q of [99152, 99153]) {
		const take = at(paladin, `accept ${q} for a Paladin`, is('accept', q));
		assert.ok(keep.includes(paladin[take].goal.npc), `a Paladin takes ${q} at the keep`);
		assert.ok(take < at(paladin, `turnin ${q} for a Paladin`, is('turnin', q)));
	}
});

// MadReign_Ltd (CurseForge, Paladin 12, 0.2.5): Hilda and Ephram did not offer their quests at the guide's
// step (a Paladin about level 9 there; both need level 10), and did after A Righteous Cause, at 12.
test(`${TIRISFAL}: MadReign_Ltd's report: a Paladin takes Hilda's and Ephram's quests after A Righteous Cause is handed in`, { skip }, () => {
	const paladin = goals(TIRISFAL).filter(forClass('PALADIN'));
	const cause = at(paladin, 'turnin 96896 (A Righteous Cause)', is('turnin', 96896));
	for (const q of [99152, 99153]) {
		const take = at(paladin, `accept ${q}`, is('accept', q));
		assert.ok(cause < take, `${q} is taken after A Righteous Cause is handed in`);
		const work = at(paladin, `the objective of ${q}`, (g) => g.t === 'collect' && g.quest === q);
		assert.ok(take < work && work < at(paladin, `turnin ${q}`, is('turnin', q)), `${q}: accept, objective, turn-in`);
	}
});

test(`${TIRISFAL}: an3vilmonk3y's report (#345): the class letter is taken at Sarvis with Rattling the Rattlecages, and a Warlock's skulls are collected in the Rattlecage step`, { skip }, () => {
	const SARVIS = 1569;
	const letters = { WARRIOR: 3095, ROGUE: 3096, PRIEST: 3097, MAGE: 3098, WARLOCK: 3099 };
	for (const [cls, letter] of Object.entries(letters)) {
		const list = goals(TIRISFAL).filter(forClass(cls));
		const first = at(list, `accept 3901 for a ${cls}`, is('accept', 3901));
		const take = at(list, `accept ${letter} for a ${cls}`, is('accept', letter));
		assert.ok(take > first, `a ${cls} takes the letter after Rattling the Rattlecages`);
		assert.deepEqual(list.slice(first, take + 1).filter(({ goal }) => goal.npc !== SARVIS).map(({ goal }) => `${goal.t} ${goal.quest}`), [], `nothing from another giver comes between the two accepts of a ${cls}, so Sarvis's window is one visit`);
	}
	const warlock = goals(TIRISFAL).filter(forClass('WARLOCK'));
	const kill = warlock[at(warlock, 'the skeleton kills (3901)', (g) => g.t === 'kill' && g.quest === 3901)];
	const skulls = warlock[at(warlock, 'the Rattlecage Skulls (1470)', (g) => g.t === 'collect' && g.quest === 1470)];
	assert.equal(skulls.s, kill.s, 'the skulls are collected in the step that kills the skeletons');
	const mage = goals(TIRISFAL).filter(forClass('MAGE'));
	assert.deepEqual(mage.filter(({ goal }) => goal.quest === 1470).map(({ goal }) => `${goal.t} ${goal.quest}`), [], 'a Mage has no goal for Piercing the Veil');
});

test(`${TIRISFAL}: an3vilmonk3y's report (#345) and Onrevax's (#120): A Light in the Darkness is taken from Aramis once The Damned is handed in, for every class, and not at Sarvis`, { skip }, () => {
	for (const cls of ['WARRIOR', 'ROGUE', 'PRIEST', 'MAGE', 'WARLOCK', 'PALADIN']) {
		const list = goals(TIRISFAL).filter(forClass(cls));
		const accept = at(list, `accept 98389 for a ${cls}`, is('accept', 98389));
		assert.ok(accept > at(list, `turnin 376 for a ${cls}`, is('turnin', 376)), `a ${cls} takes it after The Damned is handed in`);
		assert.ok(list[accept].s > list[at(list, `accept 3901 for a ${cls}`, is('accept', 3901))].s, `a ${cls} is not sent to Aramis in the step that starts at Sarvis`);
		assert.deepEqual(list[accept].goal.pre, [376], `a ${cls}'s accept needs The Damned`);
	}
});

test(`${TIRISFAL}: Fitz's report (#736): A Light in the Darkness is handed to Aramis in Deathknell before the Scarlet farm, for every class`, { skip }, () => {
	for (const cls of ['WARRIOR', 'ROGUE', 'PRIEST', 'MAGE', 'WARLOCK', 'PALADIN']) {
		const list = goals(TIRISFAL).filter(forClass(cls));
		const farm = at(list, `collect 3266 for a ${cls}`, (g) => g.t === 'collect' && g.quest === 381);
		assert.ok(at(list, `turnin 98389 for a ${cls}`, is('turnin', 98389)) < farm, `a ${cls} hands it in before the Scarlet Armbands`);
	}
});

// WANTED: Maggot Eye needs level 6; Vital Intelligence, handed to Zygand in
// front of the inn, gives it to some (data/route-fixes.json, #801). The
// recordings still reached the poster at 5.94 on a first Brill stop with
// nothing else handed in before it. Since #1046 the pumpkins are done on the
// road in and Fields of Grief (630 XP) is handed to Johaan first on that stop:
// the recorded runs that played this order read the poster there at level 6.
test(`${TIRISFAL}: petllama's report (#801): WANTED: Maggot Eye is taken from the poster after Fields of Grief and Vital Intelligence are handed in`, { skip }, () => {
	for (const cls of ['WARRIOR', 'ROGUE', 'PRIEST', 'MAGE', 'WARLOCK', 'PALADIN']) {
		const list = goals(TIRISFAL).filter(forClass(cls));
		const take = at(list, `accept 398 for a ${cls}`, is('accept', 398));
		const vital = at(list, `turnin 383 for a ${cls}`, is('turnin', 383));
		assert.ok(vital < take, `a ${cls} hands Vital Intelligence in before the Maggot Eye poster`);
		const grief = at(list, `turnin 365 for a ${cls}`, is('turnin', 365));
		const paw = at(list, `collect 3635 for a ${cls}`, (g) => g.t === 'collect' && g.item === 3635);
		assert.ok(grief < take && take < paw, `a ${cls} reads the poster after Fields of Grief's hand-in, before Maggot Eye`);
	}
});

// Desperate Times asks every Skyborne for both leaders, whatever their side: Horde players talk to Elaadrin Evengale,
// who shows hostile to them (recordings: 12 Horde people ticked his line). The Horde guide says so, so the red name
// doesn't look like the guide sending them to the other faction.
test('Zephras Isle (Horde): Desperate Times says the quest needs both leaders, the Alliance one included', { skip }, () => {
	const list = goals('forever/horde/skyborne/01-zephras-isle.guide');
	const elaadrin = at(list, 'Elaadrin', (g) => g.t === 'talk' && g.quest === 92640 && g.npc === 252475);
	const text = [list[elaadrin].step.note, list[elaadrin].step.tip].flat().filter(Boolean).join(' ');
	assert.match(text, /red to you/, 'the step says Elaadrin shows red but talks');
	assert.match(text, /needs both/, 'the step says the quest needs both leaders');
});

test(`Visur's report (#859): no guide asks for a kill the game's objectives do not count, or for a kill of someone it asks you to talk to`, { skip }, () => {
	refData();
	// The Cult of the Damned counts Dark Neophytes and Dark Enforcers only.
	assert.equal(goals(TIRISFAL).filter(({ goal }) => goal.quest === 96897 && goal.npc === 1547).length, 0, 'no Decrepit Darkhound goal for The Cult of the Damned');
	for (const guide of allGuides()) {
		for (const { goal } of goals(guide)) {
			if (goal.t !== 'kill' || !goal.quest || !goal.oi) continue;
			const o = ((refData().quests[goal.quest] || {}).objectives || [])[goal.oi - 1];
			assert.ok(o, `${guide}: ${goal.quest}.${goal.oi} is one of the quest's objectives`);
			assert.notEqual(o.type, 'talk', `${guide}: ${goal.quest}.${goal.oi} is a talk to ${o.text}, not a kill`);
		}
	}
});

// --- Tirisfal (a Scourge Priest): the guide sent them to turn in Discipline
// (99134) without one Deathguard motivated. Its step was only a `goto` to
// Brill, done on arrival, so nothing waited for the quest. The same holds for
// the other event and escort objectives written as a `goto`.

test(`${TIRISFAL}: Pledge-Resupply's report: The Argent Emissary points to Deathguard Terrence at 61.4,53.4`, { skip }, () => {
	const list = goals(TIRISFAL);
	const accept = at(list, 'accept 96895 (The Argent Emissary)', is('accept', 96895));
	const { map, x, y } = list[accept].goal;
	assert.deepEqual({ map, x, y }, { map: 1420, x: 61.4, y: 53.4 });
});

// --- Tirisfal (Hotline, a Scourge Paladin, #408): the guide asked them to
// turn in Rediscovering the Light (90902) without a step to heal the five
// Injured Deathguard first. The quest data had no objective to hold a step.

test(`Hotline's report: a Paladin heals the Injured Deathguard before turning in Rediscovering the Light`, { skip }, () => {
	const list = goals(TIRISFAL).filter(forClass('PALADIN'));
	const accept = at(list, 'accept 90902', is('accept', 90902));
	const complete = at(list, 'complete 90902', is('complete', 90902));
	const turnin = at(list, 'turnin 90902', is('turnin', 90902));
	assert.ok(accept < complete && complete < turnin, 'healing comes between the accept and the turn-in');
	const step = list[complete].step;
	assert.ok(list.some((g) => g.step === step && g.goal.t === 'goto' && located(g)), 'the healing step leads to the Injured Deathguard');
});

// --- Tirisfal (yiliev0, a Scourge Paladin, #672): the arrow for the Injured
// Deathguard pointed 60 yards north of the church, while some lie in front
// of it (Forever's quest data pins 31.6,65.8; a data/forever spawn at 31.59,65.83).

test(`yiliev0's report (#672): the healing step leads to the Injured Deathguard in front of the church`, { skip }, () => {
	const list = goals(TIRISFAL).filter(forClass('PALADIN'));
	const step = list[at(list, 'complete 90902', is('complete', 90902))].step;
	const arrow = list.find((g) => g.step === step && g.goal.t === 'goto');
	const church = list.find(({ goal }) => goal.t === 'turnin' && goal.quest === 98601).goal;
	assert.equal(arrow.goal.map, church.map, 'the same map as Aramis');
	const { point } = makeProjector(refData().mapFrames);
	const where = (g) => point(g.map, g.x, g.y, g.f);
	assert.ok(dist(where(arrow.goal), where(church)) < 40, 'within 40 yards of Aramis Hammerhand at the church');
});

for (const DUROTAR of DUROTARS) test(`${DUROTAR}: AndarKerran's report: A Pain in the Neck is not offered to a Troll Warrior without Enchanting, and is to an enchanter`, { skip }, () => {
	// Pa'zula offers it to enchanters only (QuestieDB: Enchanting 1): every goal carries the profession.
	const pain = goals(DUROTAR).filter(({ goal }) => goal.quest === 96873);
	assert.deepEqual(pain.map(({ goal }) => [goal.t, goal.profLine, goal.profName, goal.profRank]), [
		['accept', 333, 'Enchanting', 1],
		['complete', 333, 'Enchanting', 1],
		['turnin', 333, 'Enchanting', 1],
	]);
	// Hidden ("na", like another class's goals), not offered and then skipped.
	assert.deepEqual(painInTheNeck(DUROTAR), ['accept na', 'complete na', 'turnin na']);
	// An enchanter is offered it. Its accept is optional, so the complete and
	// the turn-in are theirs only once they take it (#221).
	const offered = ['accept pending', 'complete na', 'turnin na'];
	assert.deepEqual(painInTheNeck(DUROTAR, { skills: 'w.skills[333] = { name = "Enchanting", rank = 1, maxRank = 75 }' }), offered);
	// Learning Enchanting during the session brings the accept back.
	assert.deepEqual(painInTheNeck(DUROTAR, { after: 'stub.world.learnSkill(333, "Enchanting", 1, 75)' }), offered);
});

// --- Durotar (defect, #357): The Admiral's Orders (830) starts from the Aged
// Envelope in Benedict's Chest, opened with Benedict's Key. A player who took
// the quest before the route reached Tiragarde Keep holds neither: the
// envelope went into the quest, the key into the chest. Benedict is a kill of
// Riders on the Storm (784.3), so his key needs no goal of its own.
for (const DUROTAR of DUROTARS) test(`${DUROTAR}: defect's report (#357): with The Admiral's Orders taken, Tiragarde Keep waits for neither Benedict's Key nor the Aged Envelope`, { skip }, () => {
	const s = compiled(DUROTAR).steps.findIndex((step) => step.goals.some((g) => g.t === 'accept' && g.quest === 830)) + 1;
	assert.ok(s > 0, 'a step takes 830');
	const view = stepView(DUROTAR, warriorOf(DUROTAR), s, 'w.accept(830, {})');
	const open = view.goals.filter((g) => g.t === 'collect' && !g.quest && g.status !== 'done');
	assert.deepEqual(open, [], 'no bag collect left open once 830 is in the log');
	assert.ok(goals(DUROTAR).some(({ s: n, goal }) => n === s && goal.t === 'kill' && goal.npc === 3192), 'Benedict is still a kill of the step');
});

// petllama (#798) and Fitz (#1046): Gordo's Task is taken on the road from
// Calvin Montague to Brill. Every Undead in the recordings reaches Calvin at
// level 5 or more (the quest's minimum), so it is a step of its own on that
// walk with its Gloom Weed, not an along list from level 5 (Fitz: "the along
// the way quests are doing more harm than good, they should just be steps").
test(`${TIRISFAL}: petllama's request (#798): Gordo's Task is taken on the road to Brill, as a step`, { skip }, () => {
	const { steps } = compiled(TIRISFAL);
	const has = (step, verb, quest) => step.goals.some((g) => is(verb, quest)(g));
	const gordo = steps.findIndex((st) => has(st, 'accept', 5481));
	assert.ok(gordo >= 0, 'Gordo\'s Task is taken');
	const step = steps[gordo];
	assert.ok(!step.along, 'in a step, not an along list');
	assert.ok(step.goals.some((g) => g.t === 'collect' && g.item === 12737 && g.quest === 5481), 'with its Gloom Weed');
	assert.ok(steps.slice(0, gordo).some((st) => has(st, 'accept', 8)), 'after Calvin Montague');
	assert.ok(gordo < steps.findIndex((st) => has(st, 'turnin', 383)), 'before Brill\'s square');
});

test(`${TIRISFAL}: Fitz's report (#1046): the road from Deathknell into Brill takes and does what it passes, in walking order`, { skip }, () => {
	for (const cls of TIRISFAL_CLASSES) {
		const list = goals(TIRISFAL).filter(forClass(cls));
		const vital = at(list, `turnin 383 for a ${cls}`, is('turnin', 383));
		const road = [
			['accept 8 (Calvin Montague)', is('accept', 8)],
			['accept 365 (Deathguard Simmer)', is('accept', 365)],
			['the Tirisfal Pumpkins', collects(2846)],
			["accept 5481 (Gordo)", is('accept', 5481)],
			['the Gloom Weed', collects(12737)],
			['accept 404 (Deathguard Dillinger)', is('accept', 404)],
			['accept 86784 (Deathguard Bartholomew)', is('accept', 86784)],
			['turnin 5481 (Junior Apothecary Holland)', is('turnin', 5481)],
			['the Dry Branches', collects(279991)],
			['turnin 96656 (Eleanor Shackleton)', is('turnin', 96656)],
		].map(([what, pred]) => [what, at(list, `${what} for a ${cls}`, pred)]);
		for (let k = 1; k < road.length; k++) {
			assert.ok(road[k - 1][1] < road[k][1], `a ${cls}: ${road[k - 1][0]} before ${road[k][0]}`);
		}
		assert.ok(road[road.length - 1][1] < vital, `a ${cls}: the road in is done before Brill's square`);
		const square = list[vital].step;
		assert.equal(list[at(list, `turnin 365 for a ${cls}`, is('turnin', 365))].step, square, `a ${cls}: Fields of Grief is handed to Johaan on the first square stop`);
		assert.ok(vital < at(list, `accept 358 for a ${cls}`, is('accept', 358)), `a ${cls}: Executor Zygand before Magistrate Sevren's Graverobbers`);
	}
});

test(`${TIRISFAL}: Fitz's report (#1046): A Rogue's Deal is fought on the west loop's way to the Crusader's Outpost, not on a trip back`, { skip }, () => {
	for (const cls of TIRISFAL_CLASSES) {
		const list = goals(TIRISFAL).filter(forClass(cls));
		const report = at(list, `Gordo's report for a ${cls}`, collects(286202));
		const duel = at(list, `accept 590 for a ${cls}`, is('accept', 590));
		const warriors = at(list, `the Scarlet Warriors for a ${cls}`, (g) => g.t === 'kill' && g.quest === 427);
		assert.ok(report < duel && duel < warriors, `a ${cls}: Gordo's report, then Calvin's duel, then the outpost`);
		const between = list.slice(report + 1, warriors).filter(located).map(({ goal }) => goal.quest);
		assert.deepEqual([...new Set(between)], [590], `a ${cls}: nothing else between Gordo and the outpost`);
	}
});

test(`${TIRISFAL}: Fitz's report (#1046): Hides for the Forsaken is worked with the mobs the loops already kill, and no step is an along list`, { skip }, () => {
	const list = goals(TIRISFAL);
	const step = (pred, what) => list[at(list, what, pred)].step;
	assert.ok(at(list, 'accept 97558', is('accept', 97558)) < at(list, 'the Darkhound Blood', collects(2858)), 'taken before the west loop');
	assert.equal(step(collects(278243), 'the Darkhound Hides'), step(collects(2858), 'the Darkhound Blood'), 'the hides with the blood');
	assert.equal(step(collects(278242), 'the Duskbat Wing Membranes'), step(collects(2876), 'the Duskbat Pelts'), 'the wings with the pelts');
	assert.equal(step(collects(278244), 'the Vile Fin Murloc Skins'), step(collects(2859), 'the Vile Fin Scales'), 'the skins with the scales');
	assert.deepEqual(compiled(TIRISFAL).steps.filter((st) => st.along).map((st) => st.title), [], 'no along-the-way lists');
});
test(`${TIRISFAL}: Fitz's report (#1046 follow-up): each Brill visit enters the Gallows' End Tavern once`, { skip }, () => {
	goals(TIRISFAL); // loads the reference data
	for (const npc of [5688, 1500, 1560, 2131, 265944, 1521, 2128, 2129, 2127, 2130, 1931, 2211]) {
		const spawn = refData().npcs[npc] && refData().npcs[npc].spawns[1420];
		if (spawn) assert.ok(inBox({ map: 1420, x: spawn.pts[0][0], y: spawn.pts[0][1] }, BRILL_INN), `npc ${npc} stands inside the inn's box`);
	}
	for (const npc of [1515, 1499, 1518, 2118, 1652, 1738]) {
		const spawn = refData().npcs[npc].spawns[1420];
		assert.ok(!inBox({ map: 1420, x: spawn.pts[0][0], y: spawn.pts[0][1] }, BRILL_INN), `npc ${npc} stands outside the inn's box`);
	}
	for (const cls of TIRISFAL_CLASSES) {
		let state = 'away';
		let last = null;
		for (const { goal, s } of goals(TIRISFAL).filter(forClass(cls)).filter(located)) {
			const where = inBox(goal, BRILL_INN) ? 'inn' : inBox(goal, BRILL) ? 'town' : 'away';
			if (where === 'away') state = 'away';
			else if (where === 'inn') {
				assert.notEqual(state, 'left-inn', `a ${cls}: step ${s} (${goal.t} ${goal.quest || goal.npc || ''}) goes back into the inn, left at step ${last}`);
				state = 'inn';
				last = s;
			} else if (state === 'inn') state = 'left-inn';
		}
	}
});

// Welcome to Shen'dar Village: talking to Illaya before the step counts.
test(`${ZEPHRAS_HORDE}: Sato's report: Welcome to Shen'dar Village follows its objectives, and is taken before Illaya's talk`, { skip }, () => {
	const list = goals(ZEPHRAS_HORDE);
	assert.ok(at(list, 'accept 92514', is('accept', 92514)) < at(list, 'talk 251902 quest 92595.1 (Illaya)', is('talk', 92595)), 'taken before the talk to Illaya for The Windshapers, which counts for it too');
	// The step with the two talks (the village round's first step; Raan's profession Camping 101s split it, #1559).
	const step = list[at(list, 'talk for 92514', (g) => g.t === 'talk' && g.quest === 92514)].s;
	assert.deepEqual(list.filter(({ s, goal }) => s === step && goal.t === 'talk' && !goal.quest).map(({ goal }) => goal.npc), [], 'no bare talk goal that only counts during the step');
	const objectives = (illaya, coriella) => stepView(ZEPHRAS_HORDE, SKYBORNE_HORDE, step, `w.complete({ 92595 })
		w.onQuest(92514, { { required = 1, fulfilled = ${illaya} }, { required = 1, fulfilled = ${coriella} } })`)
		.goals.filter((g) => g.quest === 92514 && g.t !== 'turnin' && g.t !== 'accept').sort((a, b) => a.oi - b.oi).map((g) => g.status);
	// Objective 1 is Illaya, 2 Coriella, whichever line the step lists first.
	assert.deepEqual(objectives(1, 0).map((st) => st === 'done'), [true, false], 'Illaya done earlier, Coriella still to do');
	assert.ok(objectives(1, 1).every((st) => st === 'done'), 'both done: only the turn-in is left');
});

// --- Encroachment (tor, #351): a level 10 quest whose Razormane go up to
// level 9 was taken at Razor Hill at about 6 and done at 7, before the level
// 7-8 quests of Tiragarde Keep and the Sen'jin loop.

for (const DUROTAR of DUROTARS) test(`${DUROTAR}: tor's report (#351): Encroachment is taken after the Tiragarde Keep and Sen'jin, Echo Isles and Kolkar Crag turn-ins`, { skip }, () => {
	const list = goals(DUROTAR);
	const encroachment = at(list, 'accept 837 (Encroachment)', is('accept', 837));
	for (const q of [96822, 784, 791, 830, 817, 818, 826, 808, 786]) {
		assert.ok(at(list, `turnin ${q}`, is('turnin', q)) < encroachment, `${q} is handed in before Encroachment is taken`);
	}
	// The Razormane are killed after it is taken, before it is handed in.
	const turnin = at(list, 'turnin 837', is('turnin', 837));
	for (const n of [3111, 3112, 3113, 3114]) {
		const kill = at(list, `kill ${n}`, (g) => g.t === 'kill' && g.quest === 837 && g.npc === n);
		assert.ok(encroachment < kill && kill < turnin, `Razormane ${n} is killed between the accept and the turn-in`);
	}
});

test(`${TROLL_DUROTAR}: flow review: Lar Prowltusk on the first Sen'jin stop, Razor Hill once after the keep, eggs and fur on the coast walk`, { skip }, () => {
	const list = goals(TROLL_DUROTAR);
	const stepOf = (t, q) => list[at(list, `${t} ${q}`, is(t, q))].s;
	assert.equal(stepOf('accept', 786), stepOf('turnin', 805), "Lar with Master Gadrin on the first Sen'jin stop");
	assert.equal(stepOf('turnin', 96822), stepOf('turnin', 784), 'Turroc and Gar\'Thok on one Razor Hill visit');
	const coast = list.find(({ goal }) => goal.t === 'collect' && goal.quest === 825).s;
	assert.equal(list.find(({ goal }) => goal.t === 'collect' && goal.quest === 815).s, coast, 'the eggs on the coast walk');
	assert.ok(list.find(({ goal }) => goal.t === 'collect' && goal.quest === 817).s < list.find(({ goal }) => goal.t === 'collect' && goal.quest === 826).s, 'the tiger fur on the first isle, before the southern isles');
});

// Flow review, Tirisfal Glades: Warriors walked past Deathguard Dillinger with The Mills Overrun and came
// back for Ulag the Cleaver.
test(`${TIRISFAL}: flow review: Ulag the Cleaver is taken with The Mills Overrun's hand-in`, { skip }, () => {
	const list = goals(TIRISFAL).filter(forClass('WARRIOR'));
	assert.equal(at(list, 'accept 1819', is('accept', 1819)), at(list, 'turnin 426', is('turnin', 426)) + 1);
});

// Flow review, Zephras Isle (Horde): Hanaa's camp lies on the road south to Shen'dar; the guide went there
// from the den and walked back north to the village for Valreaa and Aetheen.
test('forever/horde/skyborne/01-zephras-isle.guide: flow review: the village hand-ins before Hanaa Nightwind', { skip }, () => {
	const list = goals('forever/horde/skyborne/01-zephras-isle.guide');
	const hanaa = at(list, 'accept 92544', is('accept', 92544));
	assert.ok(at(list, 'turnin 92470', is('turnin', 92470)) < hanaa && at(list, 'turnin 92473', is('turnin', 92473)) < hanaa);
	assert.ok(at(list, 'turnin 92470', is('turnin', 92470)) > at(list, "Urs'anah", (g) => g.t === 'kill' && g.quest === 92470), 'after the den');
});

// Final route review, Horde 1-30 (and the release audit): Tirisfal's first Brill pass walks past Carolai, Coleman and
// Gretchen (level 7) and the pass after the north loop past Terrence (level 10). Players' recordings show players at
// 5-7 on the first pass, so each gets a step gated on its level where the walk passes, and the later visit keeps the
// accept for everyone below it; The Argent Emissary goes to Hadric at Linnea's camp right after when taken.
test('forever/horde/undead/01-tirisfal-glades.guide: final route review: level-gated pickups where the walk passes Carolai, Coleman, Gretchen and Terrence', { skip }, () => {
	const list = goals('forever/horde/undead/01-tirisfal-glades.guide');
	const gate = (step) => (step.when || []).find((p) => p.k === 'level' && p.op === '>=' && !p.neg);
	const accepts = (q) => list.map((e, i) => ({ ...e, i })).filter(({ goal }) => is('accept', q)(goal));
	const renee = at(list, 'turnin 8', is('turnin', 8));
	const linnea = at(list, 'turnin 359', is('turnin', 359));
	for (const [q, n, before] of [[95314, 7, renee], [362, 7, linnea], [354, 7, linnea], [375, 7, linnea], [96895, 10, linnea]]) {
		const [first, ...later] = accepts(q);
		assert.ok(first.i < before && gate(first.step) && gate(first.step).n === n, `${q}: taken where the walk passes, from level ${n}`);
		assert.ok(later.length >= 1 && !gate(later[0].step), `${q}: the later visit keeps the accept for players below ${n}`);
	}
	const hadric = list.find(({ goal }) => is('turnin', 96895)(goal));
	assert.ok(list.indexOf(hadric) > linnea && (hadric.step.when || []).some((p) => p.k === 'onquest'), 'Hadric at Linnea\'s camp when The Argent Emissary is held');
});
// --- end of flights with nothing to do in between

// Horde 12-30 re-chain (2026-11-07): Silverpine Forest 12-15, the Barrens and Stonetalon's road 15-21,
// Ashenvale and the Silverpine ride 21-22, Hillsbrad 22-24, the Barrens and Sun Rock 24-26, Ashenvale and
// Thousand Needles 26-30. A quest whose objectives are not done yet never rides out of the guide (the zone
// stay) that takes it into the next one, for any start: a delivery (also one whose only objective is speaking to
// its ender) or a finished quest may wait for its hand-in, and class quests and optional tours may run on, but zone work is done in its stay. On the old
// chain Troll Charm, Between a Rock and a Thistlefur and Stonetalon Standstill rode from the 23 Ashenvale
// visit through Stonetalon and Hillsbrad to the 27 one.
test('Horde 1-30: no unfinished zone quests carried into the next zone', { skip }, () => {
	const starts = { Orc: ORC_DUROTAR, Troll: TROLL_DUROTAR, Tauren: MULGORE, Undead: TIRISFAL, Skyborne: ZEPHRAS_HORDE };
	const WORK = new Set(['kill', 'collect', 'interact', 'use', 'complete', 'escort', 'talk']);
	for (const [race, start] of Object.entries(starts)) {
		const chain = chainFrom(start).filter((g) => !/\/(30-40|40-50|50-60)\//.test(g));
		assert.deepEqual(chain.slice(1).map((g) => g.replace('forever/horde/', '')), ['03-silverpine-forest.guide', '02-the-barrens.guide', '05-stonetalon-mountains.guide', '06-hillsbrad-foothills.guide', '04-the-barrens.guide', '07-ashenvale.guide'], `${race}: the 12-30 chain`);
		const fits = (o) => !o || !o.races || o.races.includes(race);
		const cls = (o) => o && o.classes;
		// The solo route: a dungeon's quests may ride to its run in the next guide (Razorfen Kraul's tubers from
		// the Barrens' Ratchet stop to the Great Lift road), for a character who runs it.
		const list = chain.flatMap((g) => goals(g).map((e) => ({ ...e, g })))
			.filter(({ step, goal }) => fits(step.only) && fits(goal.only) && !cls(step.only) && !cls(goal.only) && !dungeonOnly(step));
		const classQuest = (q) => !!(refData().quests[q] && refData().quests[q].classes);
		// A delivery whose only objective is speaking to the NPC who takes it (the campfires' profession
		// Camping 101s for the Orgrimmar and Undercity trainers, #1559): its `complete` is the hand-in visit.
		const delivery = (q) => {
			const d = refData().quests[q];
			return !!(d && d.objectives && d.objectives.length && d.objectives.every((o) => o.type === 'kill' && (d.end.npc || []).includes(o.id)));
		};
		// A profession quest whose only objective is a skill level (Camping 101: Skinning, "Raise your skinning skill
		// to 20", #1952): like a class quest it waits for the skill, and the trainer's step turns it in once complete.
		const skillLevel = (q) => {
			const d = refData().quests[q];
			return !!(d && d.skill && d.objectives && d.objectives.length && d.objectives.every((o) => o.type === 'event'));
		};
		const lastWork = new Map();
		list.forEach(({ goal }, i) => { if (WORK.has(goal.t) && goal.quest != null && !goal.optional) lastWork.set(goal.quest, i); });
		// Pick up now, do later (Fitz, 2026-11-16): Egg Hunt is taken on 02's last Crossroads stop and worked on 04's walk.
		const pickedUpEarly = new Set([868]);
		const open = new Map();
		list.forEach(({ goal, g }, i) => {
			if (goal.t === 'accept' && !goal.optional && !classQuest(goal.quest) && !delivery(goal.quest) && !skillLevel(goal.quest) && !pickedUpEarly.has(goal.quest)) open.set(goal.quest, g);
			if (goal.t === 'turnin') open.delete(goal.quest);
			const nextG = list[i + 1] && list[i + 1].g;
			if (nextG && nextG !== g) {
				for (const [q, from] of open) {
					assert.ok(!(lastWork.get(q) > i), `${race}: ${q} (${refData().quests[q] && refData().quests[q].title}) rides from ${from} into ${nextG} with its objectives still to do`);
				}
			}
		});
	}
});

// Final route review (0.3.6): Durotar Warlocks walked from Skull Rock into Orgrimmar for The Binding and back out to
// Margoz, then came back to Orgrimmar at the end of the guide anyway. Gan'rul takes the Tablet of Verga and the
// voidwalker is bound on that last arrival, in the Cleft of Shadow with Neeru Fireblade.
test('Durotar (Orc, Troll) Warlocks: The Binding on the arrival in Orgrimmar at the end, not on a trip from Skull Rock', { skip }, () => {
	for (const guide of ['forever/horde/orc/01-durotar.guide', 'forever/horde/troll/01-durotar.guide']) {
		const list = goals(guide);
		const binding = at(list, `${guide}: turnin 1501`, is('turnin', 1501));
		for (const [what, pred] of [['Margoz', is('turnin', 827)], ['Orgnil', is('turnin', 99051)]]) {
			assert.ok(at(list, `${guide}: ${what}`, pred) < binding, `${guide}: ${what} before Gan'rul`);
		}
		const last = list[list.length - 1];
		assert.ok(last.s === list[binding].s && is('turnin', 1504)(last.goal), `${guide}: the voidwalker is bound in the guide's last step`);
	}
});

// Final route review, Horde 1-30 (0.3.6 leftovers): Troll Durotar read "Back to the Den" twice in a row (Galgar's
// hand-in alone outside the Den, the class trainers, then Gornek inside). Galgar's step is his own; one "Back to the Den".
test('forever/horde/troll/01-durotar.guide: one "Back to the Den" step after the valley loop, Galgar on his own step', { skip }, () => {
	const steps = compiled('forever/horde/troll/01-durotar.guide').steps;
	const dens = steps.filter((st) => st.title === 'Back to the Den');
	assert.ok(dens.length >= 1 && dens[0].goals.some(is('turnin', 789)), 'the first "Back to the Den" is Gornek\'s');
	const list = goals('forever/horde/troll/01-durotar.guide');
	assert.equal(list[at(list, 'turnin 4402', is('turnin', 4402))].step.title, 'Galgar');
});

// Final route review, Horde 1-30 (0.3.6 leftovers): Orc Durotar's first Echo Isles step told the player to wade back
// west to the shore, and the next one to head south through the isles: a bounce in words. Durotar Tigers (3121) roam
// the northern isle too (67-70,70-74 on Durotar's map), so the tigers and the eggs are taken on the isles' way south.
test('forever/horde/orc/01-durotar.guide: the Echo Isles tips walk one way, north isle then south through the isles', { skip }, () => {
	const src = fs.readFileSync(path.join(OFFICIAL_DIR, 'forever/horde/orc/01-durotar.guide'), 'utf8');
	assert.doesNotMatch(src, /tip Wade back west to the shore south of Sen'jin\. Durotar Tigers/);
	const isles = compiled('forever/horde/orc/01-durotar.guide').steps.filter((st) => st.title === 'Echo Isles: kill these as you meet them');
	assert.equal(isles.length, 2);
	assert.ok(isles[0].goals.some((g) => g.t === 'collect' && g.item === 4892), 'tiger furs on the first isles step');
});

// Review (0.3.6): Tauren leave Mulgore by the road through Camp Taurajo to the Crossroads; Kirge Sternhorn
// stands on it with Journey to the Crossroads (854, Tauren only, 230 XP) for Thork, who is on the Crossroads stop the
// guide already makes. 7 of 7 recorded Tauren on that road took it and handed it in; Plainstrider Menace (844) was
// still offered afterwards.
test('Tauren Mulgore: Journey to the Crossroads from Kirge at Camp Taurajo, handed to Thork on the Crossroads stop', { skip }, () => {
	const list = goals('forever/horde/tauren/01-mulgore.guide');
	const take = at(list, 'accept 854', is('accept', 854));
	const into = at(list, 'goto Into The Barrens', (g) => g.t === 'goto' && /Into The Barrens/.test(g.label || g.text || ''));
	const hand = at(list, 'turnin 854', is('turnin', 854));
	assert.ok(into < take && take < hand, 'taken on the road into the Barrens, before the Crossroads');
	assert.equal(list[hand].s, list[at(list, 'turnin 886', is('turnin', 886))].s, 'handed in on the Crossroads stop with Tonga and Sergra');
	assert.ok(everyone(list[take]) && everyone(list[hand]), 'every Tauren class walks this road');
	const rf = JSON.parse(fs.readFileSync(path.join(ROOT, 'data', 'route-fixes.json'), 'utf8')).overrides;
	assert.ok(rf.include.some((e) => e.q === 854), 'the route fixes include Journey to the Crossroads');
});

// Review (0.3.6): the level 5 Priest robe pairs ride on stops the Troll and Undead starts already make, as the
// Alliance starts' do: the trainer's letter at 5, the town trainer's heal-and-fortify quest on a guard by the road,
// the robe on the next town stop. Recorded Priests of both races did them (Troll 2 of 2, Undead 9).
test('Horde starts: the Priest robe quests on stops the Troll and Undead starts already make', { skip }, () => {
	const cases = [
		['forever/horde/troll/01-durotar.guide', 5649, 5648, 12430, 'turnin 6394', is('turnin', 6394), 'turnin 96821', is('turnin', 96821), 'turnin 784', is('turnin', 784)],
		['forever/horde/undead/01-tirisfal-glades.guide', 5651, 5650, 12428, 'turnin 382', is('turnin', 382), 'turnin 407', is('turnin', 407), 'turnin 375', is('turnin', 375)],
	];
	for (const [file, letter, garments, guard, dLabel, dPred, tLabel, tPred, rLabel, rPred] of cases) {
		const list = goals(file);
		const take = at(list, `accept ${letter}`, is('accept', letter));
		assert.ok(at(list, dLabel, dPred) < take, `${file}: the letter comes on the last start-area stop, at 5`);
		const hand = at(list, `turnin ${letter}`, is('turnin', letter));
		assert.equal(list[hand].s, list[at(list, tLabel, tPred)].s, `${file}: handed to the town trainer on the first town stop`);
		const next = at(list, `accept ${garments}`, is('accept', garments));
		const heal = at(list, `heal ${guard}`, (g) => g.t === 'kill' && g.quest === garments && g.npc === guard);
		const robe = at(list, `turnin ${garments}`, is('turnin', garments));
		assert.ok(hand <= next && next < heal && heal < robe, `${file}: letter, guard, robe in order`);
		assert.equal(list[robe].s, list[at(list, rLabel, rPred)].s, `${file}: the robe on the next town stop`);
		for (const i of [take, hand, next, heal, robe]) assert.ok([list[i].step.only, list[i].goal.only].some((o) => o && o.classes && o.classes.length === 1 && o.classes[0] === 'PRIEST'), `${file}: Priests only`);
	}
	const rf = JSON.parse(fs.readFileSync(path.join(ROOT, 'data', 'route-fixes.json'), 'utf8')).overrides;
	for (const q of [5648, 5649, 5650, 5651]) assert.ok(rf.include.some((e) => e.q === q), `the route fixes include ${q}`);
});

// Review (0.3.6): every Horde start campfire also offers a profession Camping 101 (270 XP, needs the skill at
// accept). Each variant is a required accept on a step of its own gated `when skill <Prof> 1` right after the campfire
// (#1559: Automation never takes an optional accept, and the step read done once Cooking was taken); its hand-in a
// required turn-in on a carrier-only step (`when onquest`) where the trainer stands on a stop the route makes
// (Orgrimmar and Undercity trainers: 03-silverpine-forest). Recordings: Tirisfal First Aid 14 accepts, Mining 13,
// Durotar Skinning 12, Mulgore Skinning 7.
test('Horde starts: the profession Camping 101 quests, each on its profession\'s own step after the campfire, handed in on carrier-only steps', { skip }, () => {
	const starts = {
		'forever/horde/tauren/01-mulgore.guide': [96661, [97936, 97934, 97931, 97932, 97933, 97935, 97927, 97928, 97929, 97937], []],
		'forever/horde/orc/01-durotar.guide': [96655, [97907, 97902, 97903], [97908, 97906, 96102, 97905, 97901, 97899]],
		'forever/horde/troll/01-durotar.guide': [96655, [97907, 97902, 97903], [97908, 97906, 96102, 97905, 97901, 97899]],
		'forever/horde/undead/01-tirisfal-glades.guide': [96658, [97955, 97953, 97957, 97951, 97960, 97958, 97961], [97959, 97952, 97954]],
		'forever/horde/skyborne/01-zephras-isle.guide': [96646, [97971, 97965, 97969, 97970, 97963, 97964, 97967], []],
	};
	for (const [file, [cooking, here, later]] of Object.entries(starts)) {
		const list = goals(file);
		const cook = at(list, `accept ${cooking}`, is('accept', cooking));
		for (const q of [...here, ...later]) {
			const take = at(list, `${file}: accept ${q}`, is('accept', q));
			assert.ok(take > cook, `${file}: ${q} after the Cooking variant`);
			assert.ok(!list[take].goal.optional && list[take].goal.profLine, `${file}: ${q} a required accept that carries its profession`);
			assert.ok((list[take].step.when || []).some((p) => p.k === 'skill' && !p.neg && p.skillLine === list[take].goal.profLine), `${file}: ${q} on a step for its profession`);
			const hand = list.findIndex(({ goal }) => goal.t === 'turnin' && goal.quest === q);
			if (here.includes(q)) {
				assert.ok(hand > take && !list[hand].goal.optional, `${file}: ${q} handed in later in the guide, a required turn-in`);
				assert.ok((list[hand].step.when || []).some((p) => p.k === 'onquest' && !p.neg && p.q.includes(q)), `${file}: ${q} handed in on a carrier-only step`);
			}
			else assert.equal(hand, -1, `${file}: ${q} goes to the next guide's trainer`);
		}
	}
});

// Undead Warlocks: Carendin Halgar offers Creature of the Void (1473) only once Halgar's Summons (1478, from Ageron
// Kargal in Brill) is handed in; 4 recorded players carrying it had 1473 refused. The route takes 1478 on the Brill
// stop that trains and hands it in to Carendin right before 1473.
test(`${TIRISFAL}: a Warlock hands Halgar's Summons to Carendin before Creature of the Void`, { skip }, () => {
	const list = goals(TIRISFAL).filter(forClass('WARLOCK'));
	const take = at(list, 'accept 1478', is('accept', 1478));
	const hand = at(list, 'turnin 1478', is('turnin', 1478));
	const creature = at(list, 'accept 1473', is('accept', 1473));
	assert.ok(take < hand && hand < creature, 'taken in Brill, handed in, then Creature of the Void');
	assert.equal(list[hand].s, list[creature].s, 'on the same stop at Carendin');
	const fixes = JSON.parse(fs.readFileSync(path.join(ROOT, 'data', 'route-fixes.json'), 'utf8'));
	assert.ok(fixes.deliberate.pairs.some((p) => `${p.a}` === 'turnin,1478' && `${p.b}` === 'accept,1473'), 'a record the build keeps');
	assert.ok(fixes.overrides.include.some((x) => x.q === 1478), 'the route takes 1478');
});

// jaff's report: "I always have grey quests that are completed in random spots that I haven't handed in". Some
// quests the route takes are handed in only by an `optional` goal: the engine never holds an optional goal, so the
// player walks past the ender carrying the quest. Those hand-ins now hold (hidden for anyone without the quest); a
// quest whose only work is a rare drop has its accept optional too, and a quest carried 18 levels for a tenth of its
// XP is no longer taken.
test("jaff's report: a quest the route takes is handed in by a goal that holds", { skip }, () => {
	const A = (g) => `forever/alliance/${g}.guide`;
	const H = (g) => `forever/horde/${g}.guide`;
	const holds = [
		[A('50-60/06-silithus'), 5845], [H('07-ashenvale'), 2], [H('07-ashenvale'), 23], [H('07-ashenvale'), 24], [DUROTARS[0], 830], [DUROTARS[1], 830],
		[H('03-silverpine-forest'), 832], [H('tauren/01-mulgore'), 781], [H('06-hillsbrad-foothills'), 2479],
	];
	for (const [guide, q] of holds) {
		const t = goals(guide).find(({ goal }) => is('turnin', q)(goal));
		assert.ok(t && !t.goal.optional, `${guide}: turnin ${q} is a goal that holds`);
		assert.ok(!(t.step.when || []).some((p) => p.k === 'group' || (p.k === 'onquest' && !p.neg && ![p.q].flat().includes(q))), `${guide}: turnin ${q} is not behind another quest's or a group's condition`);
	}
	const stv = goals(A('40-50/02-badlands')).find(({ goal }) => is('accept', 706)(goal));
	assert.ok(stv && stv.goal.optional, 'accept 706 (Fiery Blaze Enchantments, a rare drop) is optional');
	for (const file of allGuides().filter((f) => f.startsWith('forever/alliance/'))) {
		const list = goals(file);
		assert.ok(!list.some(({ goal }) => is('accept', 1037)(goal)), `${file}: Velinde Starsong is not taken`);
		// A copy a player still carries is handed in only while it is in the log.
		for (const { step } of list.filter(({ goal }) => is('turnin', 1037)(goal))) {
			assert.ok((step.when || []).some((p) => p.k === 'onquest' && !p.neg && [].concat(p.q).includes(1037)), `${file}: turnin 1037 only while carried`);
		}
	}
	const fixes = JSON.parse(fs.readFileSync(path.join(ROOT, 'data', 'route-fixes.json'), 'utf8'));
	for (const q of [5845, 2479]) assert.ok(fixes.deliberate.keep.some((k) => k.q === q), `keep ${q} is a record`);
	assert.ok(fixes.deliberate.optional.some((k) => k.q === 706), 'optional 706 is a record');
	assert.ok(fixes.overrides.skip.some((k) => k.q === 1037 && k.faction === 'Alliance'), 'skip 1037 is a record');
});

// #1952: a Camping 101 profession quest asks for the profession at 20 before its trainer takes it; at skill 1-5 the
// Horde start guides' trainer step right after the campfire waited for an objective the player could not finish
// there. Each in-zone trainer hand-in step now shows only once the quest is complete (`when complete <q>`), and the
// accept step says the trainer takes it at 20; While-here offers the hand-in on a later pass.
test('#1952: the Horde start guides\' Camping 101 trainer steps wait until the quest is complete', { skip }, () => {
	const starts = [ORC_DUROTAR, TROLL_DUROTAR, MULGORE, TIRISFAL, 'forever/horde/skyborne/01-zephras-isle.guide'];
	const fixes = JSON.parse(fs.readFileSync(path.join(ROOT, 'data', 'guide-fixes.json'), 'utf8')).fixes;
	let n = 0;
	for (const file of starts) {
		const list = goals(file);
		for (const { step, goal } of list) {
			if (goal.t !== 'turnin' || !/^Camping 101: (?!Cooking)/.test(goal.title || '')) continue;
			n += 1;
			const when = step.when || [];
			assert.ok(when.some((p) => p.k === 'complete' && !p.neg && p.q === goal.quest), `${file}: turnin ${goal.quest} waits until the quest is complete`);
			assert.ok(fixes.some((f) => f.at && f.at.quest === goal.quest && f.at.goal === 'turnin' && f.when === `complete ${goal.quest}`), `${goal.quest}: a record the build keeps`);
			const take = list.find((e) => e.goal.t === 'accept' && e.goal.quest === goal.quest);
			assert.match([take.step.note, take.step.tip].flat().filter(Boolean).join(' '), / skill is 20/, `${file}: accept ${goal.quest} says the trainer takes it at 20`);
		}
	}
	assert.ok(n >= 30, `${n} in-zone Camping 101 hand-ins found`);
});

// Horde start audit (0.4.0): 01-mulgore ends with the walk from the Crossroads past Far Watch Post to Orgrimmar. Tauren
// Warriors hand Veteran Uzzek (1505) to Uzzek and gather the Singed Scales on Thunder Ridge on that walk; Shamans hand
// Call of Fire (1523) to Kranal Fiss, take Telf Joolam's 1525 and the Reagent Pouch, instead of walking back into
// Durotar from the Barrens at about 16.
test(`${MULGORE}: Tauren Warriors and Shamans do their level-10 class quests on the walk to Orgrimmar`, { skip }, () => {
	const all = goals(MULGORE);
	const end = all.findIndex(({ step }) => step.title === 'To Orgrimmar');
	const thork = at(all, 'turnin 854', is('turnin', 854));
	assert.ok(end > thork, 'the walk starts at the Crossroads');
	for (const [cls, list] of [
		['WARRIOR', [is('turnin', 1505), is('accept', 1498), (g) => g.t === 'collect' && g.quest === 1498]],
		['SHAMAN', [is('turnin', 1523), is('accept', 1524), is('turnin', 1524), is('accept', 1525), (g) => g.t === 'collect' && g.quest === 1525 && g.oi === 2]],
	]) {
		const mine = all.map((e, i) => ({ ...e, i })).filter(forClass(cls));
		let last = thork;
		for (const pred of list) {
			const hit = mine.find((e) => pred(e.goal) && e.i > thork && e.i < end);
			assert.ok(hit, `${cls}: ${list.indexOf(pred)} is on the walk`);
			assert.ok(hit.i > last, `${cls}: in walking order`);
			last = hit.i;
		}
	}
	const fixes = JSON.parse(fs.readFileSync(path.join(ROOT, 'data', 'route-fixes.json'), 'utf8'));
	for (const a of ['turnin,1505', 'turnin,1523', 'accept,1525', 'task,1525,1']) {
		assert.ok(fixes.deliberate.pairs.some((p) => `${p.a}` === a && `${p.b}` === 'accept,97246'), `${a}: a record the build keeps`);
	}
});

// Horde start audit (0.4.0): Durotar's last walk went Razor Hill -> Far Watch Post -> Orgrimmar only to hand in
// Conscript of the Horde (840); Kargal Battlescar stands at the Barrens guide's first stop anyway. The Far Watch step
// is now only for Warriors (Veteran Uzzek, 1505), and everyone else carries 840 to that stop.
test('Durotar (Orc, Troll): only Warriors walk to Far Watch Post at the end of the guide', { skip }, () => {
	const fixes = JSON.parse(fs.readFileSync(path.join(ROOT, 'data', 'guide-fixes.json'), 'utf8')).fixes;
	for (const guide of DUROTARS) {
		const list = goals(guide);
		const hands = list.filter(({ goal }) => is('turnin', 840)(goal));
		const last = hands[hands.length - 1];
		assert.ok((last.step.when || []).some((p) => p.k === 'onquest' && !p.neg && p.q.includes(1505)), `${guide}: the last Far Watch stop is for whoever carries Veteran Uzzek`);
		assert.ok(list.some(({ step, goal }) => step === last.step && is('turnin', 1505)(goal)), `${guide}: Uzzek takes 1505 on that stop`);
		assert.ok(fixes.some((f) => f.at && f.at.quest === 840 && f.at.guide === guide.slice(0, -6) && f.when === 'onquest 1505'), `${guide}: a record the build keeps`);
	}
});

// Danger at the spot (#1575), Horde start audit (0.4.0): 9 people died inside Skull Rock at about 12, 3 of them to
// Gazz'uz (14); his Eye of Burning Shadow and Burning Shadows (832) are optional, the collars are not.
test('Durotar (Orc, Troll): the Eye of Burning Shadow from Gazz\'uz is optional, the Searing Collars are not', { skip }, () => {
	for (const guide of DUROTARS) {
		const list = goals(guide);
		const eye = list[at(list, 'collect 4903', (g) => g.t === 'collect' && g.item === 4903)];
		const burning = list[at(list, 'accept 832', is('accept', 832))];
		assert.ok(eye.goal.optional && burning.goal.optional, `${guide}: the Eye and its quest are optional`);
		assert.ok(!list[at(list, 'collect 4871', (g) => g.t === 'collect' && g.quest === 827)].goal.optional, `${guide}: the collars hold`);
	}
	const fixes = JSON.parse(fs.readFileSync(path.join(ROOT, 'data', 'guide-fixes.json'), 'utf8')).fixes;
	assert.ok(fixes.some((f) => f.at && f.at.quest === 832 && f.at.goal === 'accept' && f.optional === true), 'a record the build keeps');
});

// #2000 and the 0.4.0 start audit: a flight path is learnt on the walk that passes its master. The Undead casters walk
// down into the Undercity past Michael Garrett, the bat handler, for their class turn-ins at the end of Tirisfal Glades;
// the Skyborne pass Omusa Thunderhorn at Camp Taurajo on the road from Mulgore to the Crossroads. Each step learns it.
test('#2000: the Undercity flight path on the Undead casters\' Undercity stop, Camp Taurajo\'s on the Skyborne walk', { skip }, () => {
	for (const cls of ['WARLOCK', 'PRIEST', 'MAGE']) {
		const list = goals(TIRISFAL).filter(forClass(cls));
		const fp = at(list, `${cls}: getfp Undercity`, (g) => g.t === 'getfp' && g.location === 'Undercity');
		const first = list.findIndex(({ goal }) => goal.map === 1458);
		assert.ok(first >= 0 && list[fp].s === list[first].s, `${cls}: learnt on the first Undercity stop`);
	}
	const sky = goals('forever/horde/skyborne/01-zephras-isle.guide');
	const taurajo = at(sky, 'getfp Camp Taurajo', (g) => g.t === 'getfp' && g.location === 'Camp Taurajo');
	const crossroads = at(sky, 'getfp Crossroads', (g) => g.t === 'getfp' && g.location === 'Crossroads');
	assert.ok(taurajo < crossroads, 'on the walk north, before the Crossroads');
	for (const [file, name] of [['undead/01-tirisfal-glades', 'Undercity'], ['skyborne/01-zephras-isle', 'Camp Taurajo']]) {
		const seed = fs.readFileSync(path.join(ROOT, 'forge', 'seed', 'guides', 'forever', 'horde', `${file}.guide`), 'utf8');
		assert.match(seed, new RegExp(`getfp "${name}"`), `${file}: the seed carries the getfp, so the build writes it where the seed has it`);
	}
});

// 0.4.0 start audit: Durotar's Razor Hill training stop at about 11 sent Mages back to Mai'ah in the Valley of Trials
// (Razor Hill has no mage trainer); no recorded Mage went. Mages train at Sen'jin on the way through at 8-10 and in
// Orgrimmar on the next guide's arrival at about 12.
test('Durotar (Orc, Troll): no Mage trainer step back in the Valley of Trials after Razor Hill', { skip }, () => {
	for (const guide of DUROTARS) {
		const list = goals(guide).filter(forClass('MAGE'));
		const heglan = at(list, 'accept 99049', is('accept', 99049));
		const back = list.slice(heglan).filter(({ goal }) => goal.t === 'train' && goal.npc == null && /Mai'ah/.test(goal.note || '')).length;
		const text = fs.readFileSync(path.join(OFFICIAL_DIR, guide), 'utf8');
		assert.doesNotMatch(text, /train class only Mage -- Mai'ah in Durotar/, `${guide}: no trip back to Mai'ah`);
		assert.equal(back, 0);
	}
});

// #2264 (rhoot, Skyborne Druid 14): the walk from Thunder Bluff to the Barrens went by "Into Mulgore" at 42.1,20.2,
// down the north lift's ramp to the plain north-east of it and back up over the ledge south-east; rhoot stood at a
// spot with nothing there and turned round. On the walking grid the quickest way from Eylah Sunhorn and Ansekhwa
// (Zephras Isle's last stops) is the west lift and the road at its foot (4 s over the free walk; 54 s by 42.1,20.2),
// and from Elder Rise (Mulgore's) the north lift and the ledge east of its foot (0 s; 13 s by 42.1,20.2).
test('#2264: the walk from Thunder Bluff to the Barrens takes the lift on its way, in both start guides and their seeds', () => {
	for (const [rel, at, lift] of [
		['forever/horde/skyborne/01-zephras-isle.guide', '37.6,33.0', /west lift/],
		['forever/horde/tauren/01-mulgore.guide', '42.3,21.7', /north lift/],
	]) {
		for (const file of [path.join(OFFICIAL_DIR, rel), path.join(ROOT, 'forge', 'seed', 'guides', rel)]) {
			const step = fs.readFileSync(file, 'utf8').split(/\n(?=step )/).find((s) => s.startsWith('step Into Mulgore\n'));
			assert.ok(step, `${file}: an Into Mulgore step`);
			assert.ok(step.includes(`\n  goto ${at} "Into Mulgore"\n`), `${file}: Into Mulgore at ${at}`);
			assert.match(step, lift, `${file}: the tip names the lift`);
			assert.doesNotMatch(step, /42\.1,20\.2/, `${file}: not the north lift's ramp`);
		}
	}
});

// #2268's pattern in Durotar (Orc and Troll): A Simmering Storm (97281, from the Dull Storm Orb) and Stormy
// Potential's accept (97282) were optional lines on the Rezlak stop that hands in Securing the Lines (835): once 835
// was in, nothing held the step, and a player carrying the orb's quest walked on without handing it in. Its hand-in
// now holds a step of its own, for carriers only; Stormy Potential stays an optional extra there (#807).
test('Durotar: Rezlak waits for the Dull Storm Orb\'s quest and its follow-up before Thunder Ridge', { skip }, () => {
	for (const guide of ['forever/horde/orc/01-durotar.guide', 'forever/horde/troll/01-durotar.guide']) {
		const list = goals(guide);
		const hand = at(list, 'turnin 97281', is('turnin', 97281));
		const { step } = list[hand];
		assert.ok((step.when || []).some((p) => p.k === 'onquest' && !p.neg && p.q.includes(97281)), `${guide}: only while 97281 is carried`);
		assert.ok(!list[hand].goal.optional, `${guide}: the hand-in holds the step`);
		const take = at(list, 'accept 97282', is('accept', 97282));
		assert.equal(list[take].s, list[hand].s, `${guide}: the follow-up's accept on the same step`);
		assert.ok(list[take].goal.optional, `${guide}: Stormy Potential stays an optional extra (#807)`);
		assert.ok(list[hand].s > list[at(list, 'turnin 835', is('turnin', 835))].s, `${guide}: right after Securing the Lines`);
		assert.ok(hand < at(list, 'Thunder Ridge organs', (g) => g.t === 'collect' && g.quest === 97282), `${guide}: before Thunder Ridge`);
		const back = list[at(list, 'turnin 97282', is('turnin', 97282))].step;
		assert.ok((back.when || []).some((p) => p.k === 'onquest' && !p.neg && p.q.includes(97282)), `${guide}: the hand-in waits for 97282 in the log`);
	}
});

// --- Reports fixed in earlier releases that had no test of their own (regression audit after 0.4.0). Each case
// checks the fix where the 0.4.0 guides hold it.

// haggisbytes (#1084): Rezlak offers Stormy Potential only once Winds in the Desert is handed in; the 0.3.1 guide asked
// for both at once.
test('#1084: Durotar: Stormy Potential is taken after Winds in the Desert is handed in, on both Durotar starts', { skip }, () => {
	for (const guide of DUROTARS) {
		const list = goals(guide);
		assert.ok(at(list, `${guide}: turnin 834`, is('turnin', 834)) < at(list, `${guide}: accept 97282`, is('accept', 97282)), `${guide}: Winds in the Desert first`);
	}
});
