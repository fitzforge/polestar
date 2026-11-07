'use strict';
// Player-reported guide fixes, pinned so a route refresh (re-applying a new
// simulator route to the hand-written guides) cannot silently undo them.
// Each case names the report it protects and checks behaviour on the guide
// compiled with the real reference data: goal order and where the arrow
// leads, not the guide's wording. The timed quest items have their own lint
// rule (tests/lint-timed.test.js); the Fargodeep Mine and Blackfathom Deeps
// mouths are in tests/guides-caves.test.js.
//
// Needs data/forever (forge data build); skips without it.

const { test } = require('node:test');
const assert = require('node:assert/strict');
const fs = require('node:fs');
const path = require('node:path');
const { needs } = require('./helpers/data');
const { compileSources, OFFICIAL_DIR } = require('../tools/lib/dsl/project');
const { loadData } = require('../tools/lib/dsl/data');
const { parseGuide } = require('../tools/lib/dsl/parse');
const { Diagnostics } = require('../tools/lib/dsl/diag');
const { loadCorrections } = require('../tools/lib/data/corrections');
const { DATA, SOURCES } = require('../tools/lib/paths');
const { loadWeb } = require('../tools/lib/codex/web');
const { runAddon } = require('./helpers/lua');
const { writeTestPack } = require('./helpers/dsl');
const { buildSimPack, playGuide, SIMULATE } = require('../tools/lib/playtest');
const { makeProjector, dist } = require('../tools/lib/route/geo');

const skip = needs('quests.json', 'npcs.json', 'objects.json', 'map-frames.json');

test("Tyr's Watch: Tanis Alderwood's goals carry his Undercity floor's height, from the Forever TDB when classic-db lacks him (#855)", { skip: skip || needs('spawnz.json') }, () => {
	const list = goals('forever/class/paladin/tyrs-watch.guide');
	for (const pred of [is('turnin', 94434), is('accept', 94435)]) {
		const { goal } = list[at(list, 'Tanis Alderwood', pred)];
		assert.equal(goal.npc, 257648);
		assert.ok(Math.abs(goal.z - -43) < 3, `${goal.t} ${goal.quest}: z ${goal.z} is the city level, not the ruins above`);
	}
});

test('Horde objective follow-ups: camp discovery, Silithyst delivery and cooking point at their actual objective', { skip }, () => {
	for (const [file, quest, map, npc] of [
		['forever/horde/50-60/04-azshara.guide', 3505, 1447, null],
		['forever/horde/50-60/06-silithus.guide', 9422, 1451, 18199],
		['forever/horde/tauren/01-mulgore.guide', 96661, 1412, 3067],
	]) {
		const { goal } = goals(file).find(({ goal }) => goal.t === 'complete' && goal.quest === quest);
		assert.equal(goal.map, map, `${quest}: the unfinished objective has an arrow on its map`);
		const event = npc ? null : data.quests[quest].objectives.find((o) => o.type === 'event');
		const spawn = npc ? data.npcs[npc].spawns[map] : null;
		assert.equal(goal.f || 'l', spawn ? spawn.f : event.f, `${quest}: keep the source coordinate frame`);
		assert.equal(goal.x, spawn ? spawn.pts[0][0] : event.x);
		assert.equal(goal.y, spawn ? spawn.pts[0][1] : event.y);
	}
});

test('Horde Call of Fire: hand in the carried trainer lead at Kranal before starting the shared ritual', { skip }, () => {
	const file = 'forever/horde/02-the-barrens.guide';
	for (const [race, durotar, carried] of [['Orc', ORC_DUROTAR, 2983], ['Troll', TROLL_DUROTAR, 2983], ['Tauren', null, 1523]]) {
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

// The starts two races share publish one guide per race (docs/forge/routes.md, "Publishing every
// start"): a report on the shared folder's guide holds on each race's copy.
const DUROTARS = ['forever/horde/orc/01-durotar.guide', 'forever/horde/troll/01-durotar.guide'];
const DUN_MOROGHS = ['forever/alliance/dwarf/01-dun-morogh.guide', 'forever/alliance/gnome/01-dun-morogh.guide'];
const [ORC_DUROTAR, TROLL_DUROTAR] = DUROTARS;
const [DWARF_DUN_MOROGH] = DUN_MOROGHS;
const TELDRASSIL = 'forever/alliance/nightelf/01-teldrassil.guide';
const ELWYNN = 'forever/alliance/human/01-elwynn-forest.guide';
const MULGORE = 'forever/horde/tauren/01-mulgore.guide';
const TIRISFAL = 'forever/horde/undead/01-tirisfal-glades.guide';
const STONETALON = 'forever/horde/05-stonetalon-mountains.guide';
const ASHENVALE = 'forever/alliance/06-ashenvale.guide';
const ASHENVALE_HORDE = 'forever/horde/07-ashenvale.guide';

let data;
const memo = new Map();
// The guide compiled with the reference data (its parse tree is `_ast`).
function compiled(guide) {
	if (!memo.has(guide)) {
		data = data || loadData(DATA);
		const file = path.join(OFFICIAL_DIR, guide);
		const { guides } = compileSources([{ file, text: fs.readFileSync(file, 'utf8') }], data);
		assert.equal(guides.length, 1, `${guide} compiles`);
		memo.set(guide, guides[0]);
	}
	return memo.get(guide);
}
// The guide's goals in order, as { step, goal, s } (`s`: the step's number, as the Engine counts them).
function goals(guide) {
	return compiled(guide).steps.flatMap((step, s) => step.goals.map((goal) => ({ step, goal, s: s + 1 })));
}
// Every guide of ours, as paths relative to guides/ with forward slashes.
function allGuides() {
	const walk = (dir) => fs.readdirSync(dir, { withFileTypes: true }).flatMap((e) => (e.isDirectory() ? walk(path.join(dir, e.name)) : e.name.endsWith('.guide') ? [path.join(dir, e.name)] : []));
	return walk(path.join(OFFICIAL_DIR, 'forever')).map((file) => path.relative(OFFICIAL_DIR, file).split(path.sep).join('/'));
}

// Index of the first goal matching, asserted present.
function at(list, what, pred) {
	const i = list.findIndex(({ goal }) => pred(goal));
	assert.ok(i >= 0, `${what} is in the guide`);
	return i;
}
const is = (t, quest) => (g) => g.t === t && g.quest === quest;
// The list with the goals of `along` steps blanked, indices kept: such a step only lists what to pick
// up on the way until its label; the step that does the work is the labelled one.
const working = (list) => list.map((e) => (e.step.along ? { ...e, goal: {} } : e));
const located = ({ goal }) => goal.map != null && goal.x != null;
// Goals every character of the guide does (no `only` on the goal or its step).
const everyone = ({ step, goal }) => !step.only && !goal.only;
// Goals a character of this class does (an `only` naming classes on the goal or its step must list it).
const forClass = (cls) => ({ step, goal }) => [step.only, goal.only].every((o) => !o || !o.classes || o.classes.includes(cls));

test(`${MULGORE}: Sharing the Land leads to each gnoll objective and resumes partial progress`, { skip }, () => {
	const pack = buildSimPack(allGuides().filter(f => f.startsWith('forever/horde/')));
	try {
		assert.deepEqual(pack.diag.errors, []);
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

test('Horde poisons: the mainline contact instructions use the supplied flare gun before saluting Fizzule', { skip }, () => {
	const list = goals('forever/horde/04-the-barrens.guide');
	const contact = list[at(list, 'contact Fizzule', is('turnin', 2458))].step;
	const flare = contact.note.indexOf('{item:8051}');
	assert.ok(flare >= 0 && flare < contact.note.indexOf('/salute'), 'signal with the quest item before saluting');
	assert.match(contact.note, /\bTWO\b.*flares/i, 'the quest requires two signals');
});

// Yards between two compiled points on one map (Era frame).
function yards(a, b) {
	const f = data.eraFrame(a.map);
	assert.ok(f && a.map === b.map, `points on one map with an Era frame (${a.map}, ${b.map})`);
	return Math.hypot(((f.right - f.left) * (a.x - b.x)) / 100, ((f.bottom - f.top) * (a.y - b.y)) / 100);
}

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

test(`${STONETALON}: the Warsong update goals name the scouts who hand them over, from the data`, { skip }, () => {
	const list = goals(STONETALON);
	for (const [item, npc, name] of [[16764, 12862, 'Warsong Scout'], [16763, 12863, 'Warsong Runner'], [16765, 12864, 'Warsong Outrider']]) {
		const { goal } = list[at(list, `collect ${item} (${name})`, (g) => g.t === 'collect' && g.item === item)];
		assert.deepEqual(goal.fromNpcs, [{ npc, npcName: name }], `${name} is the goal's hand-over NPC`);
	}
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

const CAVES = [
	// Thazz'ril's Pick and Yarrog Baneshadow: "Go in the cave (45 56)".
	...DUROTARS.flatMap((guide) => [
		{ cave: 'the Burning Blade Coven (the pick)', guide, target: (g) => g.t === 'collect' && g.item === 16332, mouth: { map: 1411, x: 45, y: 56 } },
		{ cave: 'Skull Rock', guide, target: (g) => g.t === 'collect' && g.item === 4871, mouth: { map: 1411, x: 55, y: 10 } },
	]),
	...DUN_MOROGHS.flatMap((guide) => [
		// The troll cave's mouth as marked in game (thmastin, PR #16); players' reports put it near 26,79.
		{ cave: 'the Coldridge troll cave', guide, target: (g) => g.t === 'collect' && g.item === 2004, mouth: { map: 1426, x: 26.93, y: 80.03 } },
		// The Grizzled Den's mouth as marked in game (thmastin); Flintfire's shipments lie inside.
		{ cave: 'the Grizzled Den', guide, target: (g) => g.t === 'collect' && g.item === 280413, mouth: { map: 1426, x: 42.57, y: 54.68 } },
		// Frosthowl, at the back of the same den, on the second visit from Brewnall.
		{ cave: 'the Grizzled Den (Frosthowl)', guide, target: (g) => g.t === 'collect' && g.item === 280426, mouth: { map: 1426, x: 42.57, y: 54.68 } },
		// Frostmane Hold's mouth as marked in game (thmastin); its Headhunters guard the way in.
		{ cave: 'Frostmane Hold', guide, target: (g) => g.t === 'kill' && g.quest === 287, mouth: { map: 1426, x: 25.1, y: 50.94 } },
	]),
	// The Mining Tools lie along the tunnel from the entrance: the first goal inside (#612).
	{ cave: 'the Jasperlode Mine', guide: ELWYNN, target: (g) => g.t === 'collect' && g.item === 247816, mouth: { map: 1429, x: 61.6, y: 54.1 } },
	// Pynte (#328): both mouths where the walk in reaches the cave's floor on the navigation grid, not a Classic comment's point beside it.
	{ cave: 'Shadowthread Cave', guide: TELDRASSIL, target: (g) => g.t === 'collect' && g.item === 5167, mouth: { map: 1438, x: 56.69, y: 31.29 } },
	{ cave: 'Fel Rock', guide: TELDRASSIL, target: (g) => g.t === 'collect' && g.item === 5221, mouth: { map: 1438, x: 54.59, y: 52.12 } },
	// The Webbed Forsaken are freed inside the cave: the cocoons' kill goal (#735).
	{ cave: "Night Web's Hollow", guide: TIRISFAL, target: (g) => g.t === 'kill' && g.npc === 271961, mouth: { map: 1420, x: 26, y: 60 } },
];

for (const c of CAVES) {
	test(`${c.guide}: Tom's report: the arrow reaches ${c.cave} through its mouth at ${c.mouth.x},${c.mouth.y}`, { skip }, () => {
		const list = goals(c.guide);
		const i = at(list, c.cave, c.target);
		const before = list.slice(0, i).reverse().find(located);
		assert.ok(before, 'a located goal comes before the target');
		const { t, map, x, y } = before.goal;
		assert.deepEqual({ t, map, x, y }, { t: 'goto', ...c.mouth }, `the waypoint before "${list[i].step.title}" is the mouth`);
	});
}

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

// --- The starting glens: one delivery quest no longer sends you off and back.

test(`${TELDRASSIL}: Dolanaar Delivery is taken from Porthannius after the Shadowglen quests, on the way out to Dolanaar`, { skip }, () => {
	const list = goals(TELDRASSIL);
	const take = at(list, 'accept 2159 (Dolanaar Delivery)', is('accept', 2159));
	// Shadowglen's last turn-ins: Crown of the Earth at Tenaron, Iverron's Antidote.
	for (const q of [921, 3522, 917, 457, 456]) assert.ok(at(list, `turnin ${q}`, is('turnin', q)) < take, `turnin ${q} comes before the delivery`);
	const keldamyr = list[at(list, 'turnin 2159', is('turnin', 2159))].goal;
	const tenaron = list[at(list, 'turnin 921', is('turnin', 921))].goal;
	const porthannius = list[take].goal;
	// Porthannius stands between the tree and Dolanaar, and the next stop is Dolanaar.
	assert.ok(yards(porthannius, keldamyr) < yards(tenaron, keldamyr), 'Porthannius is on the way down to Dolanaar');
	const next = list.slice(take + 1).filter(located).find(everyone);
	assert.ok(yards(next.goal, keldamyr) < yards(next.goal, tenaron), `the next stop (${next.goal.t} ${next.goal.quest}) is in Dolanaar`);
});

test(`${TELDRASSIL}: Pynte's report (#647): Teldrassil is taken from the Oracle Tree Bark on The Oracle Tree's turn-in and handed to Fandral with Crown of the Earth`, { skip }, () => {
	const list = goals(TELDRASSIL);
	const bark = at(list, 'turnin 98398 (The Oracle Tree)', is('turnin', 98398));
	const take = at(list, 'accept 940 (Teldrassil)', is('accept', 940));
	assert.equal(take, bark + 1, 'taken straight after The Oracle Tree is handed in');
	assert.ok(everyone(list[take]), 'for every class');
	assert.ok(yards(list[take].goal, list[bark].goal) < 5, 'at the same Oracle Tree Bark, not back at Arynia');
	const fandral = at(list, 'turnin 935 (Crown of the Earth)', is('turnin', 935));
	const hand = at(list, 'turnin 940 (Teldrassil)', is('turnin', 940));
	assert.equal(list[hand].step, list[fandral].step, 'handed in on the Darnassus visit that already goes to Fandral');
	assert.ok(yards(list[hand].goal, list[fandral].goal) < 5, 'to Fandral himself');
});

for (const DUN_MOROGH of DUN_MOROGHS) test(`${DUN_MOROGH}: Supplies to Tannok is taken from Hands Springsprocket at the tunnel, leaving Coldridge Valley`, { skip }, () => {
	const list = goals(DUN_MOROGH);
	const take = at(list, 'accept 2160 (Supplies to Tannok)', is('accept', 2160));
	// After the valley's last quests (Bring Back the Mug at Nori, the journal at Grelin).
	for (const q of [3365, 218, 170, 183]) assert.ok(at(list, `turnin ${q}`, is('turnin', q)) < take, `turnin ${q} comes before Supplies to Tannok`);
	// Beside Mountaineer Thalos at the tunnel's mouth.
	const thalos = list[at(list, 'turnin 282 (Mountaineer Thalos)', is('turnin', 282))].goal;
	assert.ok(yards(list[take].goal, thalos) < 40, 'Hands Springsprocket is taken at the tunnel, beside Thalos');
	const before = list.slice(0, take).reverse().filter(located).find(everyone);
	assert.ok(yards(before.goal, thalos) < 40, 'the stop before it is at the tunnel too');
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

test(`${TIRISFAL}: Onrevax's report (#365): the Coarse Thread for The Chill of Death is asked for again at the turn-in, from Abigail Shiel`, { skip }, () => {
	const list = goals(TIRISFAL);
	const hand = at(list, 'turnin 375 (The Chill of Death)', is('turnin', 375));
	const thread = list.findIndex(({ goal, s }) => s === list[hand].s && goal.t === 'buy' && goal.item === 2320);
	assert.ok(thread >= 0 && thread < hand, 'the turn-in step buys the thread before Gretchen');
	assert.equal(list[thread].goal.npc, 2118, 'from Abigail Shiel, Trade Supplies in Brill');
});

// The same pattern as #365: a quest item bought steps before its turn-in is
// asked for again on the turn-in step, from the same vendor (`nearest`: a
// vendor of the guide's faction), so a player who passed the first buy is
// not sent to the giver empty-handed. Done at once with the item in the bags.
// A buy earlier in the same town visit (every stop from it to the giver
// within a town's reach, no flight or hearth), or a tip on the turn-in step
// saying where to buy another, does the same.
const TOWN_YARDS = 200;
const BUY_AT_TURNIN = [
	// [guide, quest, item, count, vendor npc or 'H' for `nearest` on the Horde, what]
	['forever/alliance/30-40/01-hillsbrad-foothills.guide', 555, 3713, 1, 2381, 'the Soothing Spices for Chef Jessen'],
	['forever/alliance/40-50/01-stranglethorn-vale.guide', 1218, 3713, 3, 4897, 'the Soothing Spices for "Swamp Eye" Jarl, from Theramore'],
	['forever/horde/30-40/04-dustwallow-marsh.guide', 1218, 3713, 3, 'H', 'the Soothing Spices for "Swamp Eye" Jarl, bought in Ratchet in the Arathi guide'],
	[TELDRASSIL, 99050, 3371, 1, 3614, 'the Empty Vial for Byancie'],
	[TELDRASSIL, 99050, 159, 1, 6736, 'the Refreshing Spring Water for Byancie'],
	['forever/collectibles/mounts/alliance/paladin-charger.guide', 7645, 13724, 20, 10857, 'the Enriched Manna Biscuits for Merideth Carlson, from Chillwind Camp'],
	['forever/collectibles/mounts/neutral/warlock-dreadsteed.guide', 7625, 18687, 1, 14522, "the Xorothian Stardust for Gorzeeki Wildeyes, from Ur'dan in Felwood"],
];
for (const [guide, quest, item, count, vendor, what] of BUY_AT_TURNIN) {
	test(`${guide}: the same pattern as #365, ${what}: asked for again on the step that hands in ${quest}`, { skip }, () => {
		const list = goals(guide);
		const hand = at(list, `turnin ${quest}`, is('turnin', quest));
		const buy = list.slice(0, hand).findLastIndex(({ goal }) => goal.t === 'buy' && goal.item === item);
		assert.ok(buy >= 0, `item ${item} is bought before handing in ${quest}`);
		const sameVisit = list.slice(buy, hand + 1).every(({ goal }) => !['fly', 'hearth'].includes(goal.t)
			&& (!['accept', 'turnin', 'buy', 'goto', 'train'].includes(goal.t) || !located({ goal })
				|| (goal.map === list[hand].goal.map && yards(goal, list[hand].goal) < TOWN_YARDS)));
		const tip = typeof list[hand].step.note === 'string' && /\bbuy\b/i.test(list[hand].step.note);
		assert.ok(list[buy].s === list[hand].s || sameVisit || tip, `the turn-in step, its town visit or its tip buys item ${item} before handing in ${quest}`);
		const { goal } = list[buy];
		assert.ok((goal.count || 1) >= count, `at least the ${count} the quest needs`);
		if (vendor === 'H') {
			assert.ok(goal.candidates && goal.candidates.length > 0, 'vendors to pick the nearest from');
			assert.ok(goal.candidates.some((c) => c.faction && c.faction.includes('H')), 'some of them sell to the Horde');
		} else {
			assert.equal(goal.npc, vendor, `from npc ${vendor}`);
		}
	});
}

// --- Bandarion Keep (Mike_, 0.2.3): Hilda the Breaker and Ephram Barbaro offer their quests to Paladins only.

test(`${TIRISFAL}: Mike_'s report: only Paladins are sent to Hilda the Breaker and Ephram Barbaro at Bandarion Keep`, { skip }, () => {
	const list = goals(TIRISFAL);
	const keep = [246389, 259190]; // Hilda the Breaker, Ephram Barbaro
	const mage = list.filter(forClass('MAGE'));
	// Only required goals: Hilda's and Ephram's optional accepts after A Righteous Cause are open to
	// every class, and a Mage is never required to meet them (5e6b42b2a).
	assert.deepEqual(mage.filter(({ goal }) => keep.includes(goal.npc) && !goal.optional).map(({ goal }) => `${goal.t} ${goal.quest} (${goal.npcName})`), [], 'a Mage meets neither giver');
	// Their bones and crystal are quest-tagged collects in Shadowvale's step for everyone: they count only
	// for a player holding the quest, so with no required accept or hand-in a Mage never does them.
	assert.deepEqual(mage.filter(({ goal }) => (goal.quest === 99152 || goal.quest === 99153) && !goal.optional && ['accept', 'turnin'].includes(goal.t)).map(({ goal }) => `${goal.t} ${goal.quest}`), [], 'nor any required goal of their quests');
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
// recordings still reach the poster at 5.94 on the first Brill stop, so it is
// read on the second, after A Putrid Task, before Maggot Eye's camp.
test(`${TIRISFAL}: petllama's report (#801): WANTED: Maggot Eye is taken from the poster after Vital Intelligence is handed in`, { skip }, () => {
	for (const cls of ['WARRIOR', 'ROGUE', 'PRIEST', 'MAGE', 'WARLOCK', 'PALADIN']) {
		const list = goals(TIRISFAL).filter(forClass(cls));
		const take = at(list, `accept 398 for a ${cls}`, is('accept', 398));
		const vital = at(list, `turnin 383 for a ${cls}`, is('turnin', 383));
		assert.ok(vital < take, `a ${cls} hands Vital Intelligence in before the Maggot Eye poster`);
		const second = at(list, `turnin 404 for a ${cls}`, is('turnin', 404));
		const paw = at(list, `collect 3635 for a ${cls}`, (g) => g.t === 'collect' && g.item === 3635);
		assert.ok(second < take && take < paw, `a ${cls} reads the poster on the second Brill visit, before Maggot Eye`);
	}
});

// --- Coldridge Valley (thmastin, PR #16): the valley is never walked back to.

for (const DUN_MOROGH of DUN_MOROGHS) test(`${DUN_MOROGH}: thmastin's report: Grik'nir comes after Anvilmar, and the journal and Nori's mug are handed in on one camp visit`, { skip }, () => {
	const list = goals(DUN_MOROGH);
	const griknir = at(list, "Grelin Whitebeard's Journal (Grik'nir)", (g) => g.t === 'collect' && g.item === 2004);
	assert.ok(at(list, 'turnin 3364 (Scalding Mornbrew Delivery, Anvilmar)', is('turnin', 3364)) < griknir, 'Anvilmar comes before Grik\'nir');
	const journal = at(list, 'turnin 218 (The Stolen Journal)', is('turnin', 218));
	const mug = at(list, 'turnin 3365 (Bring Back the Mug)', is('turnin', 3365));
	assert.ok(griknir < journal && griknir < mug, 'both are handed in after Grik\'nir');
	assert.equal(list[journal].step, list[mug].step, 'the journal and the mug are handed in on one visit to Grelin\'s camp');
	// Grund and Gozwin is done in the valley, before the troll cave, not on a return after Rumbleshot.
	assert.ok(at(list, 'turnin 97277 (Grund and Gozwin)', is('turnin', 97277)) < griknir, 'Grund and Gozwin is handed in before the troll cave');
});

for (const DUN_MOROGH of DUN_MOROGHS) test(`${DUN_MOROGH}: thmastin's report: The Adventurer is taken from Thalos at the tunnel and turned in at Eric before The Great Outdoors`, { skip }, () => {
	const list = goals(DUN_MOROGH);
	const take = at(list, 'accept 96628 (The Adventurer)', is('accept', 96628));
	const thalos = at(list, 'turnin 282 (Senir\'s Observations, Thalos)', is('turnin', 282));
	assert.equal(list[take].step, list[thalos].step, 'taken at the tunnel, on the way out of the valley');
	const give = at(list, 'turnin 96628 (The Adventurer)', is('turnin', 96628));
	assert.equal(list[give].goal.npcName, 'Eric Brighthammer', 'turned in at Eric');
	assert.ok(give < at(list, 'accept 96608 (The Great Outdoors)', is('accept', 96608)), 'before The Great Outdoors, which it leads to');
});

// --- Kharanos to Brewnall (thmastin, recorded runs): no NPC is walked away from and back to.

const LETTERS = [3106, 3112, 3107, 3108, 3109, 3113, 3110, 98574, 98581, 3114, 3115];

for (const DUN_MOROGH of DUN_MOROGHS) test(`${DUN_MOROGH}: thmastin's report: Sten's quests and the class letter are taken before Balir, then Anvilmar is entered once`, { skip }, () => {
	const list = goals(DUN_MOROGH);
	const balir = at(list, 'accept 170 (A New Threat, Balir)', is('accept', 170));
	assert.ok(at(list, 'accept 233 (Coldridge Valley Mail Delivery, Sten)', is('accept', 233)) < balir, 'the mail delivery before Balir');
	// The race's own letters (Forever's race mask: Dwarf 4, Gnome 64).
	data = data || loadData(DATA);
	const mask = DUN_MOROGH === DWARF_DUN_MOROGH ? 4 : 64;
	for (const q of LETTERS.filter((q) => data.quests[q].races & mask)) {
		const take = at(list, `accept ${q} (class letter)`, is('accept', q));
		const give = at(list, `turnin ${q} (class letter)`, is('turnin', q));
		assert.ok(take < balir && balir < give, `letter ${q}: taken from Sten before Balir, handed in inside after him`);
		assert.equal(list[take].step, list[balir].step, `letter ${q} on the same visit`);
	}
});

for (const DUN_MOROGH of DUN_MOROGHS) test(`${DUN_MOROGH}: thmastin's report: Bring Back the Mug is taken from Durnan with the Mornbrew, before Felix`, { skip }, () => {
	const list = goals(DUN_MOROGH);
	const mornbrew = at(list, 'turnin 3364 (Scalding Mornbrew Delivery)', is('turnin', 3364));
	assert.equal(at(list, 'accept 3365 (Bring Back the Mug)', is('accept', 3365)), mornbrew + 1, 'Durnan\'s follow-up right after the Mornbrew');
	assert.ok(mornbrew < at(list, 'turnin 3361 (A Refugee\'s Quandary, Felix)', is('turnin', 3361)), 'Felix after Durnan, at the door');
});

for (const DUN_MOROGH of DUN_MOROGHS) test(`${DUN_MOROGH}: thmastin's report: Kharanos is done outside first (Eric before Tharek), then the distillery, training last`, { skip }, () => {
	const list = goals(DUN_MOROGH);
	const eric = at(list, 'turnin 96628 (The Adventurer, Eric)', is('turnin', 96628));
	const tharek = at(list, 'accept 400 (Tools for Steelgrill, Tharek)', is('accept', 400));
	const tannok = at(list, 'turnin 2160 (Supplies to Tannok)', is('turnin', 2160));
	assert.ok(eric < tharek && tharek < tannok, 'Eric\'s campfire, then Tharek\'s forge, then inside');
	const inside = list.filter(({ step }) => step === list[tannok].step);
	assert.equal(inside[inside.length - 1].goal.t, 'train', 'class training is the last goal of the distillery visit');
	// The bind is made on a Kharanos visit (the first or the return), for the arrow's hearth back to it.
	const bind = at(list, 'sethome (the Thunderbrew Distillery)', (g) => g.t === 'sethome');
	assert.ok(located(list[bind]), 'the bind leads to the innkeeper');
	assert.ok(tannok < bind, 'bound in Kharanos');
});

for (const DUN_MOROGH of DUN_MOROGHS) test(`${DUN_MOROGH}: thmastin's report: Camping 101: Cooking waits for the return to Kharanos, the lesson before the turn-in`, { skip }, () => {
	const list = goals(DUN_MOROGH);
	const lesson = at(list, 'train Cooking', (g) => g.t === 'train' && g.skillLine === 185);
	const camping = at(list, 'turnin 96629 (Camping 101: Cooking)', is('turnin', 96629));
	assert.ok(lesson < camping, 'Gremlock teaches Cooking before taking the quest');
	assert.ok(at(list, 'Crag Boar Rib', (g) => g.t === 'collect' && g.item === 2886) < lesson, 'on the return with the ribs, not on arrival');
	assert.equal(list[camping].step, list[at(list, 'turnin 384 (Beer Basted Boar Ribs)', is('turnin', 384))].step, 'on the same visit as the ribs');
});

test(`EpicTibbles's report (#532): an objective that is talking to someone reads "Talk to", not "Kill": the Skyborne visits to the Horde leaders`, { skip }, () => {
	// Where the data counts these as kill credit on the NPC, the goal stays a `kill` tracking the
	// objective and its text is what the guide window shows; where the game's own objective list
	// makes them talks (#859), the goal is a `talk` tracking the objective, which reads "Talk to".
	const talks = [
		// (Zarrin's Camping 101: Cooking is now done by training Cooking from him: #743.)
		['forever/horde/03-silverpine-forest.guide', 93739, 1, 'Nazgrel'],
		['forever/horde/03-silverpine-forest.guide', 93739, 2, "Vol'jin"],
		// (Sylvanas is talked to on the Undercity trip of the Hillsbrad guide.)
		['forever/horde/06-hillsbrad-foothills.guide', 93739, 4, 'Lady Sylvanas Windrunner'],
		[ASHENVALE_HORDE, 93739, 3, 'Cairne Bloodhoof'],
		// Visur (#802): the Alliance Skyborne's Welcome to Shen'dar Village and The Missing Scholar.
		['forever/alliance/skyborne/01-zephras-isle.guide', 93461, 1, 'Rathiril Sunlance'],
		['forever/alliance/skyborne/01-zephras-isle.guide', 93461, 2, 'Coriella Calmbreeze'],
		['forever/alliance/skyborne/01-zephras-isle.guide', 92849, 1, 'Fillion Flamebreeze'],
	];
	for (const [guide, quest, oi, name] of talks) {
		const { goal } = goals(guide)[at(goals(guide), `${quest}.${oi} (${name})`, (g) => (g.t === 'kill' || g.t === 'talk') && g.quest === quest && g.oi === oi)];
		if (goal.t === 'talk') assert.equal(goal.npcName, name, `${guide}: ${name}`);
		else assert.equal(goal.text, `Talk to ${name}`, `${guide}: ${name}`);
	}
	// Every kill goal whose note says to speak with someone says so itself.
	for (const guide of allGuides()) {
		for (const { goal } of goals(guide)) {
			if (goal.t === 'kill' && /^Speak with /.test(goal.note || '')) {
				assert.match(goal.text || '', /^Talk to /, `${guide}: ${goal.note}`);
			}
		}
	}
});

test(`Visur's report (#859): Desperate Times talks to Valennia, Ayessa and Elaadrin, in the order the game reveals them, on both Zephras Isle guides`, { skip }, () => {
	// The game lists one objective at the accept and reveals the next as each talk counts; the
	// data counted the three talks as kills.
	for (const guide of ['forever/alliance/skyborne/01-zephras-isle.guide', 'forever/horde/skyborne/01-zephras-isle.guide']) {
		const list = goals(guide);
		assert.equal(list.filter(({ goal }) => goal.t === 'kill' && goal.quest === 92640).length, 0, `${guide}: no kill goal for Desperate Times`);
		const valennia = at(list, `${guide}: 92640.1 (Valennia)`, (g) => g.t === 'talk' && g.quest === 92640 && g.oi === 1 && g.npc === 252383);
		const ayessa = at(list, `${guide}: 92640.2 (Ayessa)`, (g) => g.t === 'talk' && g.quest === 92640 && g.oi === 2 && g.npc === 251968);
		// (Desperate Times' own talk: A Grand Adventure talks to Elaadrin before it, #956.)
		const elaadrin = at(list, `${guide}: Elaadrin`, (g) => g.t === 'talk' && g.quest === 92640 && g.npc === 252475);
		assert.ok(valennia < ayessa && ayessa < elaadrin, `${guide}: Valennia, then Ayessa, then Elaadrin`);
		assert.ok(located(list[ayessa]), `${guide}: the arrow leads to Ayessa, west of town`);
	}
});

test(`Visur's report (#859): no guide asks for a kill the game's objectives do not count, or for a kill of someone it asks you to talk to`, { skip }, () => {
	data = data || loadData(DATA);
	// The Cult of the Damned counts Dark Neophytes and Dark Enforcers only.
	assert.equal(goals(TIRISFAL).filter(({ goal }) => goal.quest === 96897 && goal.npc === 1547).length, 0, 'no Decrepit Darkhound goal for The Cult of the Damned');
	for (const guide of allGuides()) {
		for (const { goal } of goals(guide)) {
			if (goal.t !== 'kill' || !goal.quest || !goal.oi) continue;
			const o = ((data.quests[goal.quest] || {}).objectives || [])[goal.oi - 1];
			assert.ok(o, `${guide}: ${goal.quest}.${goal.oi} is one of the quest's objectives`);
			assert.notEqual(o.type, 'talk', `${guide}: ${goal.quest}.${goal.oi} is a talk to ${o.text}, not a kill`);
		}
	}
});

test(`EpicTibbles's report (#565): a Hunter's Taming the Beast beast reads "Tame", not "Kill", in every guide`, { skip }, () => {
	// The data counts the tame as kill credit on the beast, so the goal stays
	// a `kill` tracking the objective; its text is what the guide window shows.
	data = data || loadData(DATA);
	const tames = [
		[TELDRASSIL, 6063, 'Webwood Lurker'],
		[DWARF_DUN_MOROGH, 6064, 'Large Crag Boar'],
		[ELWYNN, 94792, 'Rockhide Boar'],
		['forever/alliance/skyborne/01-zephras-isle.guide', 94978, 'Windsong Crawler'],
		[MULGORE, 6061, 'Adult Plainstrider'],
		...DUROTARS.map((guide) => [guide, 6062, 'Dire Mottled Boar']),
	];
	for (const [guide, quest, name] of tames) {
		const { goal } = goals(guide)[at(goals(guide), `${quest}.1 (${name})`, (g) => g.t === 'kill' && g.quest === quest && g.oi === 1)];
		assert.equal(goal.text, `Tame ${name}`, `${guide}: ${name}`);
	}
	// Every kill goal on a Taming Rod objective says so itself.
	let seen = 0;
	for (const guide of allGuides()) {
		for (const { goal } of goals(guide)) {
			const q = goal.t === 'kill' && goal.quest && data.quests[goal.quest];
			if (q && /Taming Rod to tame/.test(q.objectiveText || '')) {
				assert.match(goal.text || '', /^Tame /, `${guide}: ${goal.quest}.${goal.oi}`);
				seen++;
			}
		}
	}
	assert.ok(seen >= 21, `the seven Hunter starting guides' 21 tames (found ${seen})`);
});

// The data counts the salve's cure and the yeti's fright as kill credit, so the goal stays a `kill`
// tracking the objective; its text says what to do. The hand-written druid guide says it itself; the
// generated leveling guides get it from data/places.json on the next build.
const USE_ITEM_873 = {
	'6124.1': 'Use the Curative Animal Salve on Sickly Deer',
	'6129.1': 'Use the Curative Animal Salve on Sickly Gazelles',
	'5163.1': "Use Umi's Mechanical Yeti beside Legacki",
	'5163.2': "Use Umi's Mechanical Yeti beside Sprinkle",
	'5163.3': "Use Umi's Mechanical Yeti beside Quixxil",
};

test(`#873: data/places.json labels the Curing the Sick and Are We There, Yeti? objectives with the item use, not "Kill"`, () => {
	const { places } = JSON.parse(fs.readFileSync(path.join(__dirname, '..', 'data', 'places.json'), 'utf8'));
	for (const [key, label] of Object.entries(USE_ITEM_873)) {
		const [quest, objective] = key.split('.').map(Number);
		assert.equal(places.find((p) => p.quest === quest && p.objective === objective && p.label)?.label, label, `data/places.json labels ${key}`);
	}
});

test(`#873: the druid Cure Poison guide's Curing the Sick goal reads the salve use, not "Kill"`, { skip }, () => {
	for (const quest of [6124, 6129]) {
		const list = goals('forever/class/druid/cure-poison.guide');
		const { goal } = list[at(list, `${quest}.1`, (g) => g.t === 'kill' && g.quest === quest && g.oi === 1)];
		assert.equal(goal.text, USE_ITEM_873[`${quest}.1`]);
	}
});

// #978: Alfina Nightgaze (270459), beside the Skyborne Portal west of Dalaran, does not give Lessons
// Anew (6121): players' recordings show her window at level 14 listing Child of Nature and never
// Lessons Anew for Alliance Skyborne Druids, and the game's quest starter data lists only Mathrengyl
// Bearwalker (4217) in Darnassus. The guide sent Alliance Skyborne at 14 through level 30-40 country
// to her.
test(`#978: the druid Cure Poison guide sends Alliance Skyborne to Mathrengyl Bearwalker in Darnassus for Lessons Anew, not Alfina Nightgaze in Alterac`, { skip }, () => {
	const fix = loadCorrections().quests['6121'];
	assert.deepEqual(fix && fix.set.start && fix.set.start.npc, [4217], 'the correction leaves Mathrengyl Bearwalker as the only giver');
	const fits = (o, race) => !o || ((!o.races || o.races.includes(race)) && (!o.factions || o.factions.includes('Alliance')));
	for (const race of ['NightElf', 'Skyborne']) {
		const list = goals('forever/class/druid/cure-poison.guide').filter(({ step, goal }) => fits(step.only, race) && fits(goal.only, race));
		const accepts = list.filter(({ goal }) => is('accept', 6121)(goal));
		assert.equal(accepts.length, 1, `${race}: one Lessons Anew accept`);
		assert.equal(accepts[0].goal.npc, 4217, `${race}: from Mathrengyl Bearwalker`);
		assert.equal(accepts[0].goal.map, 1457, `${race}: in Darnassus`);
	}
});

for (const DUN_MOROGH of DUN_MOROGHS) test(`${DUN_MOROGH}: thmastin's report: The Reports is taken from Senir with Frostmane Hold and handed to the senator on the way to the tram`, { skip }, () => {
	const list = goals(DUN_MOROGH);
	const accept = at(list, 'accept 291 (The Reports)', is('accept', 291));
	assert.equal(accept, at(list, 'turnin 287 (Frostmane Hold)', is('turnin', 287)) + 1, 'taken right after Frostmane Hold is handed in');
	const turnin = at(list, 'turnin 291 (Senator Barin Redstone)', is('turnin', 291));
	assert.ok(turnin > accept, 'handed in later');
	assert.equal(list[turnin].step, list[at(list, 'goto Deeprun Tram', (g) => g.t === 'goto' && g.text === 'Deeprun Tram')].step, 'in the Deeprun Tram step');
});

for (const DUN_MOROGH of DUN_MOROGHS) test(`${DUN_MOROGH}: thmastin's report: kills on the way are counted on the way and finished after`, { skip }, () => {
	const list = goals(DUN_MOROGH);
	for (const [quest, npc, along, name] of [
		[99160, 276003, (g) => g.t === 'collect' && g.quest === 99162, "Rime's Wrath's elementals, with Treacherous Cold's rifles"],
		[319, 1196, (g) => g.t === 'goto' && g.text === 'Frostmane Hold', "A Favor for Evershine's bears, on the walk to Frostmane Hold"],
	]) {
		const kills = list.filter(({ goal }) => (goal.t === 'kill' || goal.t === 'collect') && goal.quest === quest && goal.npc === npc);
		const early = kills.find(({ goal }) => goal.optional);
		assert.ok(early, `${name}: an optional kill goal`);
		// Counted on the way: in that step, or in an `along` list open through it (from before it to its label after it).
		const there = at(list, name, along);
		const until = early.step.along && list.findIndex(({ step }) => step.label === early.step.along);
		assert.ok(early.step === list[there].step || (early.step.along && list.indexOf(early) < there && until > there), `${name}: in that step, or listed along the way through it`);
		const later = kills.find(({ goal }) => !goal.optional);
		assert.ok(later && later.step !== early.step && !later.step.along && list.indexOf(later) > list.indexOf(early), `${name}: a required kill goal in a later step finishes it`);
	}
});

for (const DUN_MOROGH of DUN_MOROGHS) test(`${DUN_MOROGH}: thmastin's report: Ammo for Rumbleshot is taken beside Beldin and handed in before the walk back to Kharanos`, { skip }, () => {
	const list = goals(DUN_MOROGH);
	assert.equal(at(list, 'accept 5541 (Loslor Rudge)', is('accept', 5541)), at(list, 'turnin 400 (Beldin)', is('turnin', 400)) + 1, 'Loslor right after Beldin');
	assert.ok(at(list, 'turnin 5541 (Hegnar Rumbleshot)', is('turnin', 5541)) < at(list, 'turnin 98321 (Tognus Flintfire)', is('turnin', 98321)), 'Hegnar before the walk back to Kharanos');
});

for (const DUN_MOROGH of DUN_MOROGHS) test(`${DUN_MOROGH}: thmastin's report: Gretchen comes first and the Grizzled Den is walked once for the shipments and Cornelius`, { skip }, () => {
	const list = goals(DUN_MOROGH);
	const shipments = at(list, "Flintfire's Shipment", (g) => g.t === 'collect' && g.item === 280413);
	assert.ok(at(list, 'accept 98319 (Secure the Mountain, Gretchen)', is('accept', 98319)) < shipments, 'Gretchen before the den');
	assert.equal(list[at(list, 'complete 98319 (Cornelius)', is('complete', 98319))].step, list[shipments].step, 'Cornelius on the same trip');
});

for (const DUN_MOROGH of DUN_MOROGHS) test(`${DUN_MOROGH}: thmastin's report: at Brewnall Gretta's dock comes first, and the village before Frostmane Hold`, { skip }, () => {
	const list = goals(DUN_MOROGH);
	const rejold = at(list, 'turnin 318 (Evershine, Rejold)', is('turnin', 318));
	const village = list.filter(({ step }) => step === list[rejold].step);
	assert.deepEqual([village[0].goal.t, village[0].goal.quest], ['accept', 98326], 'Gretta\'s Frosthowl first');
	assert.ok(at(list, 'accept 319 (A Favor for Evershine)', is('accept', 319)) < at(list, 'Frostmane Headhunter', (g) => g.t === 'kill' && g.target === 'Frostmane Headhunter'), 'Evershine\'s animals are in the log on the way to the Hold');
});

// --- Darkshore (Wogi): a Human at 20 was sent to grey quests.

// Darkshore and the guides after it, played by the Engine for a level-`level`
// Human with "Skip grey quests" on: the accepts it leaves out as grey
// (`skipped`), and each grey accept it keeps with the quest it says it opens
// and that line (`kept`).
function greyInDarkshore(level) {
	data = data || loadData(DATA);
	const files = ['03-darkshore', '04-redridge-mountains', '05-duskwood', '06-ashenvale', '07-thousand-needles']
		.map((n) => path.join(OFFICIAL_DIR, 'forever/alliance', `${n}.guide`));
	const { guides } = compileSources(files.map((file) => ({ file, text: fs.readFileSync(file, 'utf8') })), data);
	const { dir, scripts } = writeTestPack(guides, data);
	try {
		const loads = scripts.map((f) => `assert(loadfile(${JSON.stringify(f)}))("Polestar_Guides", ns)`).join('\n');
		const { emitted } = runAddon({
			stubs: ['stub_world.lua'],
			before: `local w = stub.world
				w.race, w.raceName, w.faction, w.class, w.className = "Human", "Human", "Alliance", "WARRIOR", "Warrior"
				w.level = ${level}`,
			addons: [{ name: 'Polestar', files: ['Core/Core.xml'] }],
			saved: { Polestar: 'PolestarDB = { schema = 1, settings = { behavior = { skipGrey = true, autoSelectGuide = false } } }' },
			script: `do local ns = {}
				${loads}
				end
				stub.login(); stub.advance(0.5)
				local E = Polestar.Engine
				E.SetGuide("forever/alliance/03-darkshore")
				local skipped, kept = {}, {}
				for i = 1, #E.GetGuide().steps do
					for _, g in ipairs(E.GetStepView(i).goals) do
						if g.skippedGrey then skipped[#skipped + 1] = g.quest end
						if g.keptGrey then kept[tostring(g.quest)] = { g.keptGrey, g.keptGreyText } end
					end
				end
				emit({ skipped = skipped, kept = kept })`,
		});
		// An empty Lua table comes back as {}.
		const { skipped, kept } = emitted[0];
		return { skipped: Object.values(skipped), kept };
	} finally {
		fs.rmSync(dir, { recursive: true, force: true });
	}
}

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
	assert.deepEqual(at20['983'], [1002, 'Grey, kept: opens Buzzbox 323']);
	assert.deepEqual(at20['1001'], [1002, 'Grey, kept: opens Buzzbox 323']);
	const at22 = greyInDarkshore(22).kept;
	assert.deepEqual(at22['983'], [1003, 'Grey, kept: opens Buzzbox 525']);
	// At 23 the whole chain is grey and left out: nothing kept says so.
	const at23 = greyInDarkshore(23);
	assert.equal(at23.kept['983'], undefined);
	assert.ok(at23.skipped.includes(983));
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

test(`a Priest's report: an event or escort objective holds its step until the quest is complete`, { skip }, () => {
	// (A Light in the Darkness, 98389, frees the Webbed Forsaken with a kill goal of the cocoons: #735.)
	for (const [guide, quest] of [[TIRISFAL, 99134], [TIRISFAL, 99144], ...DUROTARS.map((guide) => [guide, 99123]), [TELDRASSIL, 99053]]) {
		const list = goals(guide);
		const accept = at(list, `${guide}: accept ${quest}`, is('accept', quest));
		const complete = at(list, `${guide}: complete ${quest}`, is('complete', quest));
		const turnin = at(list, `${guide}: turnin ${quest}`, is('turnin', quest));
		assert.ok(accept < complete && complete < turnin, `${guide}: ${quest} is completed between its accept and its turn-in`);
	}
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
	const { point } = makeProjector(data.mapFrames);
	const where = (g) => point(g.map, g.x, g.y, g.f);
	assert.ok(dist(where(arrow.goal), where(church)) < 40, 'within 40 yards of Aramis Hammerhand at the church');
});

// --- Durotar (AndarKerran): A Pain in the Neck (96873) is for enchanters.

// A guide played by the Engine for one character (`who`: race, raceName,
// faction, cls, className, level), with `before` (Lua, `w` the stub world)
// run before login and `after` once the guide is open: what `script` (Lua,
// `E` the Engine) emits.
function engineRun(guide, who, { before = '', after = '', script }) {
	data = data || loadData(DATA);
	const file = path.join(OFFICIAL_DIR, guide);
	const { guides } = compileSources([{ file, text: fs.readFileSync(file, 'utf8') }], data);
	const { dir, scripts } = writeTestPack(guides, data);
	try {
		const loads = scripts.map((f) => `assert(loadfile(${JSON.stringify(f)}))("Polestar_Guides", ns)`).join('\n');
		const { emitted } = runAddon({
			stubs: ['stub_world.lua'],
			before: `local w = stub.world
				w.race, w.raceName, w.faction, w.class, w.className = "${who.race}", "${who.raceName}", "${who.faction}", "${who.cls}", "${who.className}"
				w.level = ${who.level}
				${before}`,
			addons: [{ name: 'Polestar', files: ['Core/Core.xml'] }],
			saved: { Polestar: 'PolestarDB = { schema = 1, settings = { behavior = { autoSelectGuide = false } } }' },
			script: `do local ns = {}
				${loads}
				end
				stub.login(); stub.advance(0.5)
				local E = Polestar.Engine
				E.SetGuide("${guide.replace(/\.guide$/, '')}")
				${after}
				stub.advance(0.5)
				${script}`,
		});
		return emitted[0];
	} finally {
		fs.rmSync(dir, { recursive: true, force: true });
	}
}

// The status of each goal of `quest` ("accept na", ...), with `skills` (Lua)
// set before login and `after` run once the guide is open.
function questGoalStatus(guide, quest, who, { skills = '', after = '' } = {}) {
	return Object.values(engineRun(guide, who, {
		before: skills,
		after,
		script: `local out = {}
			for i = 1, #E.GetGuide().steps do
				for _, g in ipairs(E.GetStepView(i).goals) do
					if g.quest == ${quest} then out[#out + 1] = g.t .. " " .. g.status end
				end
			end
			emit(out)`,
	})); // an empty Lua table comes back as {}
}

// What the guide window shows for step `s`: its goals ({ t, quest, status,
// text, optional }) and its groups (the goal numbers of each, in order), with
// `before` (Lua) setting up the world before login.
function stepView(guide, who, s, before = '') {
	const v = engineRun(guide, who, {
		before,
		script: `local v = E.GetStepView(${s})
			local out = { groups = {}, goals = {} }
			for k, grp in ipairs(v.groups) do out.groups[k] = grp.goals end
			for k, g in ipairs(v.goals) do
				out.goals[k] = { t = g.t, quest = g.quest or 0, oi = g.oi or 0, status = g.status, text = g.text or "", optional = g.optional }
			end
			emit(out)`,
	});
	return { goals: v.goals, groups: v.groups };
}

const TROLL_WARRIOR = { race: 'Troll', raceName: 'Troll', faction: 'Horde', cls: 'WARRIOR', className: 'Warrior', level: 12 };
const ORC_WARRIOR = { ...TROLL_WARRIOR, race: 'Orc', raceName: 'Orc' };
// A Warrior of the Durotar copy's own race.
const warriorOf = (guide) => (guide === TROLL_DUROTAR ? TROLL_WARRIOR : ORC_WARRIOR);
const painInTheNeck = (guide, opts) => questGoalStatus(guide, 96873, warriorOf(guide), opts);

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

// Recipe of the Kaldorei (4161) is offered to cooks only (QuestieDB's Forever
// store: Cooking 1): Teldrassil teaches Cooking at Zarrin's door first.
test(`${TELDRASSIL}: Recipe of the Kaldorei is taken after the guide teaches Cooking`, { skip }, () => {
	const list = goals(TELDRASSIL);
	const take = at(list, 'accept 4161', is('accept', 4161));
	assert.equal(list[take].goal.profName, 'Cooking', '4161 needs Cooking');
	assert.ok(at(list, 'turnin 96634 (Camping 101: Cooking)', is('turnin', 96634)) < take, '4161 after the cooking lesson');
	assert.ok(at(list, 'train Cooking', (g) => g.t === 'train' && g.skillLine === 185) < take, '4161 after training Cooking');
});

// --- Dun Morogh (thmastin): Beer Basted Boar Ribs (384) is for everyone.

// Ragnar Thunderbrew offers it to a Dwarf Paladin without Cooking (Camping
// 101: Cooking still in the log). QuestieDB's Forever store lists no skill for
// it; only pfQuest's Classic data lists Cooking, which does not gate.
for (const DUN_MOROGH of DUN_MOROGHS) test(`${DUN_MOROGH}: thmastin's report: Beer Basted Boar Ribs is offered without Cooking, on arrival in Kharanos`, { skip }, () => {
	const list = goals(DUN_MOROGH);
	const ribs = list.filter(({ goal }) => goal.quest === 384);
	assert.deepEqual(ribs.map(({ goal }) => [goal.t, goal.profLine]), [
		['accept', undefined],
		['collect', undefined],
		['turnin', undefined],
	]);
	const take = at(list, 'accept 384', is('accept', 384));
	assert.ok(take < at(list, 'turnin 96629 (Camping 101: Cooking)', is('turnin', 96629)), '384 is taken before the cooking lesson');
	// A Dwarf Paladin; Gnomes have no Paladins, so a Gnome Warrior.
	const who = DUN_MOROGH === DWARF_DUN_MOROGH
		? { race: 'Dwarf', raceName: 'Dwarf', faction: 'Alliance', cls: 'PALADIN', className: 'Paladin', level: 6 }
		: { race: 'Gnome', raceName: 'Gnome', faction: 'Alliance', cls: 'WARRIOR', className: 'Warrior', level: 6 };
	const status = questGoalStatus(DUN_MOROGH, 384, who);
	assert.equal(status.length, 3);
	assert.ok(status.every((s) => !s.endsWith(' na')), `a ${who.race} without Cooking sees 384: ${status.join(', ')}`);
});

// --- The Barrens (Hotline, a Scourge Mage): Walton offered neither Unwelcome
// Guests nor Trouble in the Valley, and Vrang no Hermit Tanner. They are one
// chain: Vrang's Bruised Pride and Lion Hides and Vrang's Game, then The
// Hermit Tanner up to Walton, then Trouble in the Valley, then Unwelcome Guests.

const BARRENS = 'forever/horde/04-the-barrens.guide';

test('Hotline\'s report: Walton and Vrang\'s quests come in the order the game offers them', { skip }, () => {
	const list = goals(BARRENS);
	const order = [
		['accept', 95494], ['accept', 95507], ['turnin', 95494], ['turnin', 95507],
		['accept', 95495], ['turnin', 95495], ['accept', 95621], ['turnin', 95621],
		['accept', 95508], ['complete', 95508], ['turnin', 95508],
	].map(([t, q]) => at(list, `${t} ${q}`, is(t, q)));
	assert.deepEqual(order, [...order].sort((a, b) => a - b), 'each goal comes after the one before it in the chain');
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
	const missing = questGoalStatus(BARRENS, 3261, warlock);
	assert.deepEqual(missing, ['accept skipped', 'turnin skipped']);
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

// Rohkin (#957): the Bristleback camps step collected Mankrik's tusks
// (Consumed by Hatred, 899) before Camp Taurajo, then the guide sent them back
// into the same camps for Tribes at War (878) from Mangletooth. Every
// Bristleback 878 asks for drops tusks, so the tusks are collected on 878's
// step, after its accept; Mankrik's wife (Lost in Battle, 4921) stays on the
// walk south.
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

// --- Forever chains the quest data has no prerequisite for, so the guide took
// a follow-up at the same visit as the quest before it and the giver did not
// offer it: Baine's chain in Mulgore (Kori, #112) and Mull's report (#51),
// Bandarion Keep (whiteswag, #128) and Linnea's second Rear Guard Patrol (#51)
// in Tirisfal, Alther's Mill in Redridge (#126's report), The State of the
// Mines in Westfall (SouthernStyleSims, #143), Scout Support in Hillsbrad
// (Taako, #148) and Stopping the Cycle in the Wetlands (#51). The #128 sweep
// against the Forever quest chains found Quinn's potions in Silverpine (Wild
// Eyes and Return to Quinn (Again) after Return to Quinn) and, at 30-40, Bloom
// of the Heavens, Sentiments of the Lost, Shared Fury and Friend of the Kirin
// Tor, each taken without the part before it. Each accept comes after every
// quest it follows is handed in; the optional ones may be left out, never
// taken early.

const WESTFALL = 'forever/alliance/02-westfall.guide';
const REDRIDGE = 'forever/alliance/04-redridge-mountains.guide';
const HILLSBRAD_HORDE = 'forever/horde/06-hillsbrad-foothills.guide';
const SILVERPINE = 'forever/horde/03-silverpine-forest.guide';
const HILLSBRAD_ALLIANCE = 'forever/alliance/30-40/01-hillsbrad-foothills.guide';
const ASHENVALE_30 = 'forever/alliance/30-40/03-ashenvale.guide';
const ARATHI = 'forever/alliance/30-40/05-arathi-highlands.guide';
const DARKSHORE = 'forever/alliance/03-darkshore.guide';
const THOUSAND_NEEDLES = 'forever/alliance/07-thousand-needles.guide';

test('Forever follow-ups are taken only once the quests before them are handed in', { skip }, () => {
	for (const [guide, quest, after, optional] of [
		[MULGORE, 99081, [99079]],
		[MULGORE, 99101, [99081]],
		[MULGORE, 99080, [99101]],
		[MULGORE, 99082, [99080]],
		[MULGORE, 98435, [760]],
		[TIRISFAL, 96899, [96897, 96898]],
		[TIRISFAL, 99156, [356], true],
		[REDRIDGE, 98386, [89]],
		[WESTFALL, 92745, [92742, 92744]],
		[WESTFALL, 92747, [92745, 92744]],
		[HILLSBRAD_HORDE, 98094, [528]],
		[SILVERPINE, 91920, [430]],
		[SILVERPINE, 91921, [91920], true],
		[HILLSBRAD_ALLIANCE, 98209, [98208], true],
		[HILLSBRAD_ALLIANCE, 88758, [88757], true],
		[HILLSBRAD_ALLIANCE, 98297, [98291], true],
		[ASHENVALE_30, 98418, [98417], true],
		[ARATHI, 92459, [92458], true],
		// The #51 sweep: Holy Diver after all nine beached remains, Ivar the
		// Foul after Return to Quinn (Again); 92911 and 98298 are left out.
		[DARKSHORE, 87760, [4722, 4723, 4725, 4727, 4728, 4730, 4731, 4732, 4733]],
		[SILVERPINE, 425, [91921]],
		[SILVERPINE, 98298, [99], true],
		[WESTFALL, 92911, [92910], true],
		// Lou-Saydus (#225): Forever puts From the Ashes between War Banners
		// and Nek'rosh's Gambit, so Captain Stoutfist did not offer 465 when
		// War Banners was handed in.
		[THOUSAND_NEEDLES, 98221, [464]],
		[THOUSAND_NEEDLES, 465, [98221]],
		// mtbhuskies, Soulevoker and mcclaskiem (#792): Executor Arren did not
		// offer The Adventurer at level 4 with Night Web's Hollow still open.
		[TIRISFAL, 96656, [382]],
		// Livnthedream (#800): Apothecary Holland offers Tomb Weed once Doom
		// Weed is handed in; the recordings show Sarvis giving the Paladin's
		// A Difficult Path only after The Mindless Ones.
		[TIRISFAL, 99142, [5482]],
		[TIRISFAL, 98601, [364]],
		// kieran1188 (#796): Master Vornal offers Forgotten Loa Idols once
		// Report to Sen'jin Village is handed in. Rohkin (#807): Rezlak offers
		// Stormy Potential once A Simmering Storm (the Dull Storm Orb's) is
		// handed in, so it is an optional extra.
		...DUROTARS.map((g) => [g, 97225, [805]]),
		...[...DUROTARS, 'forever/reputation/orgrimmar.guide', 'forever/reputation/darkspear-trolls.guide'].map((g) => [g, 97282, [97281], true]),
		// DexeeXI (#872): Shadow Priest Allister offers Watching the Roads only
		// once Dalaran's Intentions is handed in to him.
		[SILVERPINE, 95981, [482]],
		// DexeeXI (#891): Yelmak offers Whuut's the Rush once Yelmak's Medley
		// is handed in to Kor'geld beside him.
		[SILVERPINE, 97275, [97242]],
		// The #872 sweep: James Halloran's Crocs of the Sky is his last favor
		// after Apprentice's Duties, and Lord Grayson Shadowbreaker's The
		// Shamed Lieutenant thanks you for the statuette A Friend of the Family
		// brings him.
		[ASHENVALE, 98072, [471], true],
		[THOUSAND_NEEDLES, 98072, [471]],
		[ASHENVALE, 98219, [98191]],
		// soockee (#1002) and jiskim (#984): Va'xug Firefure offers A Void Path
		// only once Never Coming Back is handed in to him.
		[STONETALON, 98252, [98251]],
	]) {
		const list = goals(guide);
		const take = list.findIndex(({ goal }) => is('accept', quest)(goal));
		if (take < 0 && optional) continue;
		assert.ok(take >= 0, `${guide}: accept ${quest} is in the guide`);
		for (const pre of after) {
			assert.ok(at(list, `${guide}: turnin ${pre}`, is('turnin', pre)) < take, `${guide}: ${quest} is taken after ${pre} is handed in`);
		}
	}
});

// Rohkin (#807): Stormy Potential follows A Simmering Storm, which only a
// chance drop (the Storm Witches' Dull Storm Orb) starts: never a must-do, and
// its hand-in at Rezlak only for those who took it.
test('Rohkin\'s report (#807): Stormy Potential is an optional extra after the Dull Storm Orb\'s quest', { skip }, () => {
	for (const guide of [...DUROTARS, 'forever/reputation/orgrimmar.guide', 'forever/reputation/darkspear-trolls.guide']) {
		const accepts = goals(guide).filter(({ goal }) => is('accept', 97282)(goal));
		assert.ok(accepts.length > 0, `${guide}: Stormy Potential is offered`);
		for (const { goal } of accepts) assert.equal(goal.optional, true, `${guide}: accept 97282 is optional`);
		assert.ok(goals(guide).some(({ goal }) => is('accept', 97281)(goal) && goal.optional), `${guide}: the orb's quest is optional too`);
	}
});

// petllama (#798): from level 5, Gordo's Task is listed on the road from
// Calvin Montague to Brill, until the later Gordo step that takes it for
// everyone else (data/guide-fixes.json, 798-gordo-on-the-road-to-brill).
test(`${TIRISFAL}: petllama's request (#798): Gordo's Task is taken on the road to Brill from level 5`, { skip }, () => {
	const { steps } = compiled(TIRISFAL);
	const has = (step, verb, quest) => step.goals.some((g) => is(verb, quest)(g));
	const early = steps.findIndex((st) => st.along && has(st, 'accept', 5481));
	assert.ok(early >= 0, 'an along step takes Gordo\'s Task');
	const step = steps[early];
	assert.deepEqual(step.when, [{ k: 'level', op: '>=', n: 5 }], 'from level 5 only');
	assert.ok(step.goals.some((g) => g.t === 'collect' && g.item === 12737 && g.quest === 5481), 'with its Gloom Weed');
	assert.ok(has(steps[early - 1], 'accept', 8), 'right after Calvin Montague');
	const until = steps.findIndex((st) => st.label === step.along);
	assert.ok(until > early && has(steps[until], 'accept', 5481) && !steps[until].along, 'until Gordo\'s own step, which still takes it');
});

// Onrevax (#820) and bob (#823): the Applejack Still (91736) never enters the
// quest log: clicking it with four Shiny Red Apples hands it in on the spot
// and gives the Thunder Applejack, which Sergeant De Vries needs for An Apple
// Treat. The still comes once, after Homer Stonefield sells the apples, and no
// step waits on `when onquest 91736`, which never holds.
test(`${ELWYNN}: Onrevax's and bob's reports (#820, #823): the Applejack Still comes once, after the Stonefield apples and before De Vries`, { skip }, () => {
	const { steps } = compiled(ELWYNN);
	const has = (st, pred) => st.goals.some(pred);
	const still = steps.map((st, i) => [st, i]).filter(([st]) => has(st, (g) => g.quest === 91736));
	assert.equal(still.length, 1, 'one step for the still');
	const [step, at] = still[0];
	assert.ok(has(step, is('accept', 91736)) && has(step, is('turnin', 91736)) && has(step, (g) => g.t === 'collect' && g.item === 247824), 'the still hands in and gives the Applejack in that step');
	for (const st of steps) assert.ok(!(st.when || []).some((p) => p.k === 'onquest' && [].concat(p.q).includes(91736)), 'no step waits for 91736 in the quest log');
	const apples = steps.findIndex((st) => has(st, (g) => g.t === 'buy' && g.item === 4536));
	const deVries = steps.findIndex((st) => has(st, is('accept', 91738)));
	assert.ok(steps.findIndex((st) => has(st, is('turnin', 87))) <= apples && apples < at && at < deVries, 'Stonefield apples, the still, then De Vries');
});

// Croaky (level 11 elite) killed players 4 times at levels 8-9 on the Downstream
// step (players' recordings; 12 deaths in the archive by #977). His head stays an
// optional extra (#221), collected only in the steps for players who group for it
// (#979); the river step everyone plays still says he is an elite and to leave him
// without a group or below level 10.
test(`${ELWYNN}: Croaky's Head is collected only by groups, and the river step warns he is a level 11 elite, for a group or from level 10`, { skip }, () => {
	const steps = compiled(ELWYNN).steps;
	const heads = steps.filter((st) => st.goals.some((g) => g.t === 'collect' && g.item === 247826));
	assert.ok(heads.length > 0, 'the head is still an optional goal');
	for (const st of heads) assert.ok((st.when || []).some((p) => p.k === 'group'), `"${st.title}" collects the head without asking for a group`);
	const river = steps.find((st) => !(st.when || []).length && st.goals.some(is('collect', 91733)));
	assert.ok(river, "the river step of Ormin Pelford's Waterlogged tools");
	const tip = [].concat(river.note || []).join(' ');
	assert.match(tip, /level 11 elite/, tip);
	assert.match(tip, /with a group or once you're level 10/, tip);
});

// Swelling Forces (98013, level 20 naga) needs Return to Onu (950), which only
// the shared Darkshore hands in: the Night Elf start's own Darkshore left it
// unoffered at about 13 and walked to the naga for it.
test('Night Elf Darkshore: Swelling Forces waits for the shared Darkshore visit, after Return to Onu', { skip }, () => {
	assert.ok(!goals('forever/alliance/nightelf/02-darkshore.guide').some(({ goal }) => goal.quest === 98013), 'not in the Night Elf start\'s own Darkshore');
	const list = goals(DARKSHORE);
	assert.ok(at(list, 'turnin 950', is('turnin', 950)) < at(list, 'accept 98013', is('accept', 98013)), 'the shared Darkshore takes it after Return to Onu');
});

// A Last Request (93927): the game's objective 1 is the Bloody Note ("Collect
// and read the note"), 2 is Skypriest Aanders (players' recordings, Forever's
// quest data). Written swapped, the note goal followed Aanders' line and stayed
// open after the note was read.
test('Zephras Isle: A Last Request\'s note and Skypriest Aanders count the objectives the game gives them (#825)', { skip }, () => {
	const order = fs.readFileSync(path.join(__dirname, '..', 'forever-db', 'data', 'quest_objective.jsonl'), 'utf8').split('\n').filter(Boolean).map((l) => JSON.parse(l)).filter((o) => o.quest === 93927);
	const n = (target) => order.find((o) => o.target === target).n;
	assert.deepEqual([n(254871), n(256966)], [1, 2], 'Forever\'s quest data: the note first, Aanders second');
	for (const guide of ['forever/alliance/skyborne/01-zephras-isle.guide', 'forever/horde/skyborne/01-zephras-isle.guide']) {
		const list = goals(guide);
		const note = list[at(list, `${guide}: the Bloody Note`, (g) => g.t === 'collect' && g.item === 254871 && g.quest === 93927)].goal;
		const aanders = list[at(list, `${guide}: Skypriest Aanders`, (g) => g.t === 'kill' && g.npc === 256966 && g.quest === 93927)].goal;
		assert.deepEqual([note.oi, aanders.oi], [n(254871), n(256966)], guide);
	}
});

// Objective numbers written against an older objective list: A Moon-Kissed
// Blade (95036) has four lines, Trevan's notes first; The Tarnished (91317)
// lists Rudolph Gelhardt's Head first; both copies of Storm, Earth, and Fire
// (79358, 79361) list the Water, Earth, Fire and Air totems; Defending the
// Dead (96259) lists the Hatchlings first (players' recordings, Forever's
// quest data). A goal on another line's number ticks with that line. Read
// from the guide text, so it runs without data/forever.
test('Objective numbers point at the line the game counts for each target: A Moon-Kissed Blade, The Tarnished, Storm, Earth, and Fire, Defending the Dead', () => {
	const QUESTS = [95036, 91317, 79358, 79361, 96259];
	const order = fs.readFileSync(path.join(__dirname, '..', 'forever-db', 'data', 'quest_objective.jsonl'), 'utf8').split('\n').filter(Boolean).map((l) => JSON.parse(l)).filter((o) => QUESTS.includes(o.quest));
	const n = (quest, target) => (order.find((o) => o.quest === quest && o.target === target) || {}).n;
	assert.deepEqual([n(95036, 267454), n(95036, 6994), n(95036, 267361), n(95036, 272448)], [1, 2, 3, 4], "Forever's quest data: the notes, the lumber, the ingot, the gem");
	assert.deepEqual([n(91317, 270435), n(91317, 259434), n(91317, 259433)], [1, 2, 3], "Forever's quest data: the head, the Drudges, the Zealots");
	for (const q of [79358, 79361]) assert.deepEqual([n(q, 274046), n(q, 274045), n(q, 274044), n(q, 274047)], [1, 2, 3, 4], `Forever's quest data: ${q} lists water, earth, fire, air`);
	assert.deepEqual([n(96259, 264079), n(96259, 264083)], [1, 2], "Forever's quest data: the Hatchlings, then the Soldiers");
	const target = { kill: 'npc', talk: 'npc', collect: 'item', interact: 'object' };
	const wrong = [];
	let checked = 0;
	const root = path.join(OFFICIAL_DIR, 'forever');
	for (const rel of fs.readdirSync(root, { recursive: true }).filter((f) => f.endsWith('.guide')).sort()) {
		const guide = parseGuide(fs.readFileSync(path.join(root, rel), 'utf8'), rel, new Diagnostics());
		for (const g of guide.steps.flatMap((s) => s.goals)) {
			if (!QUESTS.includes(g.quest) || g.oi === undefined || !target[g.verb]) continue;
			checked++;
			const want = n(g.quest, g[target[g.verb]]);
			if (g.oi !== want) wrong.push(`forever/${rel}:${g.line} quest ${g.quest}.${g.oi} for ${target[g.verb]} ${g[target[g.verb]]}: the game counts it on ${g.quest}.${want}`);
		}
	}
	assert.deepEqual(wrong, []);
	assert.equal(checked, 17, 'the lines of every guide that number these objectives');
});

// --- Silverpine (Wyatt R, #161; Rupert, #229): Dalar Dawnweaver did not offer
// Stop the Spread to an Undead at 19 or a Tauren at 21 on the route, though
// the data gives it to every Horde race with no prerequisite.

test(`Rupert's and Wyatt R's reports: no guide sends you to Dalar Dawnweaver or the refugees for Stop the Spread (#229, #161)`, { skip }, () => {
	for (const guide of allGuides()) {
		const asked = goals(guide).filter(({ goal }) => goal.quest === 98299);
		assert.deepEqual(asked.map(({ goal }) => goal.t), [], `${guide} has no goal for 98299`);
	}
});

test(`${HILLSBRAD_ALLIANCE}: Lou-Saydus's report: Nek'rosh's Gambit, taken after From the Ashes in ${THOUSAND_NEEDLES}, is handed in on the Wetlands loop (#225)`, { skip }, () => {
	const needles = goals(THOUSAND_NEEDLES);
	assert.equal(needles.findIndex(({ goal }) => is('turnin', 465)(goal)), -1, 'the catapult is not lit in the guide that takes the quest');
	const done = at(needles, 'complete 98221', is('complete', 98221));
	assert.ok(located(needles[done]), 'the attack plans have a place');
	const list = goals(HILLSBRAD_ALLIANCE);
	assert.equal(list.findIndex(({ goal }) => is('accept', 98221)(goal)), -1, 'From the Ashes is not taken again');
	const lit = at(list, 'turnin 465', is('turnin', 465));
	assert.ok(at(list, 'turnin 98230', is('turnin', 98230)) < lit, 'after Howin');
	assert.ok(lit < at(list, 'accept 98223', is('accept', 98223)), 'before the Tattered Spellbook');
});

// --- Westfall (#144): Alba Fairmoon's Toxic Soil chain is not for Humans on
// Forever (Forever's quest data: Dwarf, Night Elf, Gnome, Skyborne).

test(`${WESTFALL}: Alba Fairmoon's chain is not given to Humans (#144)`, { skip }, () => {
	const chain = new Set([92742, 92744, 92745, 92747, 92748]);
	const list = goals(WESTFALL).filter(({ goal }) => chain.has(goal.quest));
	assert.ok(list.length > 0, 'the chain is in the guide');
	for (const { step, goal } of list) {
		const races = [step.only, goal.only].flatMap((o) => (o && o.races) || []);
		assert.ok(races.length && !races.includes('Human'), `${goal.t} ${goal.quest} is for its races only, not Humans`);
	}
});

// --- Darkshore (XooVe, #213): the first loop walked past a Beached Sea
// Creature from Asterion to Buzzbox 411 and the second loop came back for it.

test(`${DARKSHORE}: XooVe's report: the Beached Sea Creature by Bashal'Aran is taken on the walk from Asterion to Buzzbox 411 (#213)`, { skip }, () => {
	const list = goals(DARKSHORE);
	const take = at(list, 'accept 4723 (Beached Sea Creature)', is('accept', 4723));
	assert.equal(list[take].step.title, "Bashal'Aran", "it is taken in the Bashal'Aran step");
	assert.ok(at(list, 'accept 957 (Asterion)', is('accept', 957)) < take, 'after Asterion');
	assert.ok(take < at(list, 'turnin 1001 (Buzzbox 411)', is('turnin', 1001)), 'before Buzzbox 411');
	// Handed in at the first hearth, with the Beached Sea Turtle, before the second loop.
	const handIn = at(list, 'turnin 4723', is('turnin', 4723));
	assert.equal(list[handIn].step, list[at(list, 'turnin 4722', is('turnin', 4722))].step, 'handed in with 4722');
	assert.ok(handIn < at(list, 'accept 4728', is('accept', 4728)), 'before the second loop');
});

// --- Darkshore (lax, #924): "Level 20" said "grind on Elder Darkshore
// Thresher" but its arrow led to 33.3,40.7 by Auberdine, a camp of the lower
// Darkshore Threshers (both drop the Thresher Eyes worked there). The Elders
// spawn only on the south and north coasts; players' recordings see them only
// there. The same pattern everywhere: a grind's arrow is at the mob it names.

test(`lax's report (#924): every grind's arrow leads to a spawn of the mob it names`, { skip }, () => {
	data = data || loadData(DATA);
	const byName = new Map();
	for (const n of Object.values(data.npcs)) if (n.name) byName.set(n.name, [...(byName.get(n.name) || []), n.id]);
	const world = (map, x, y, f) => {
		const fr = (f === 'e' ? data.mapFrames.era : data.mapFrames.forever || {})[map] || data.eraFrame(map);
		return fr && { c: fr.c, wx: fr.top + ((fr.bottom - fr.top) * y) / 100, wy: fr.left + ((fr.right - fr.left) * x) / 100 };
	};
	const offenders = [];
	let grinds = 0;
	for (const guide of allGuides().filter((g) => /^forever\/(alliance|horde)\//.test(g))) {
		for (const step of compiled(guide).steps) {
			step.goals.forEach((goal, i) => {
				const next = step.goals[i + 1];
				if (goal.t !== 'goto' || goal.map == null || !next || next.t !== 'level' || next.note !== `grind on ${goal.text}`) return;
				grinds++;
				const g = world(goal.map, goal.x, goal.y, goal.f);
				const yd = Math.min(...(byName.get(goal.text) || []).flatMap((id) => data.spawns('npc', id)).flatMap((s) => s.pts.map((p) => {
					const w = world(s.map, p[0], p[1], s.f);
					return w && g && w.c === g.c ? Math.hypot(w.wx - g.wx, w.wy - g.wy) : Infinity;
				})));
				if (!(yd <= 400)) offenders.push(`${guide} step ${step.title}: ${goal.text} at ${goal.x},${goal.y} map ${goal.map} (${Math.round(yd)} yd off)`);
			});
		}
	}
	assert.ok(grinds > 20, 'the grinds are found');
	assert.deepEqual(offenders, [], 'grind arrows away from the mob they name');
});

test(`${TELDRASSIL}: Pynte's report: Zenn's Bidding is taken on the walk down to Dolanaar that passes Zenn (#89)`, { skip }, () => {
	const list = goals(TELDRASSIL);
	const take = at(list, "accept 488 (Zenn's Bidding)", is('accept', 488));
	assert.ok(at(list, 'accept 2159 (Porthannius, leaving Shadowglen)', is('accept', 2159)) < take, 'after Porthannius');
	assert.ok(take < at(list, 'turnin 96630 (Lyreena Duskblade in Dolanaar)', is('turnin', 96630)), 'before the first Dolanaar stop');
});

const BADLANDS = 'forever/alliance/30-40/06-badlands.guide';
test(`${BADLANDS}: the same pattern as #89: Book of the Ancients is taken from Azore on the way to Karnitol's Chest, not on a walk back from it`, { skip }, () => {
	// Nijel's Point (1454) is taken from Kreldig Ungor on the first Desolace visit and carried
	// through the guides between to the chest: the list is the chain from that guide.
	const list = ['02-desolace', '03-ashenvale', '04-stranglethorn-vale', '05-arathi-highlands', '06-badlands'].flatMap((g) => goals(`forever/alliance/30-40/${g}.guide`));
	const take = at(list, 'accept 6027 (Book of the Ancients)', is('accept', 6027));
	assert.ok(at(list, 'accept 1454 (Nijel\'s Point)', is('accept', 1454)) < take, 'after Nijel\'s Point');
	assert.ok(take < at(list, "turnin 1454 (Karnitol's Chest)", is('turnin', 1454)), 'before the chest');
});

// The same pattern elsewhere: a quest taken where the route already stands,
// instead of on a walk back to its giver later.
const STRANGLETHORN_HORDE = 'forever/horde/30-40/02-stranglethorn-vale.guide';
const TANARIS_ALLIANCE = 'forever/alliance/40-50/04-tanaris.guide';

test('#213: quests whose giver the route already stands at are taken there, not on a walk back', { skip }, () => {
	// Each case: the quest, and the goals of a step at its giver the route stands at, any one of which may
	// hold its accept. Simmer stands beside Calvin at Solliden: Fields of Grief at either pass by him.
	for (const [guide, quest, withGoals, what] of [
		[TIRISFAL, 365, [is('accept', 590), is('accept', 8)], "Calvin's duel at Solliden or Calvin's letter on the walk in from Deathknell"],
		[TANARIS_ALLIANCE, 2781, [is('accept', 2875)], "Andre Firebeard's poster at Steamwheedle Port"],
		[STRANGLETHORN_HORDE, 192, [is('turnin', 191)], "Panther Mastery's second turn-in"],
	]) {
		const list = goals(guide);
		const take = at(list, `${guide}: accept ${quest}`, is('accept', quest));
		const steps = withGoals.map((p) => list.findIndex(({ goal }) => p(goal))).filter((i) => i >= 0).map((i) => list[i].step);
		assert.ok(steps.length > 0, `${guide}: ${what} is in the guide`);
		assert.ok(steps.includes(list[take].step), `${guide}: ${quest} is taken at ${what}`);
	}
});

// --- Sweep from Rohkin's #957 (PR #970): an item collected from mobs before the
// quest that kills the same mobs is taken, then those mobs cleared again for it.
// Badlands: Hammertoe's Digsite asked for the Rock Elemental Shards (Badlands
// Reagent Run, 2500.3), whose only droppers are rock elementals far from the dig;
// the Dustbowl's Lesser Rock Elementals are killed after Lotwil's Study of the
// Elements: Rock (710) at Agmond's End. Stranglethorn (Horde): Nesingwary's step
// asked for all 25 Bloody Bone Necklaces (596) from the Bloodscalps that Bloodscalp
// Ears (189) and Headhunting (582) kill again later; the Ruins of Zul'Kunda step,
// before the hand-in, finishes them.
test('Sweep from #957: a drop is collected with the later quest that kills the same mobs, not in a clear before it', { skip }, () => {
	for (const [guide, item, quest, take, what] of [
		[BADLANDS, 7848, 2500, 710, "Rock Elemental Shards after Lotwil's Study of the Elements: Rock"],
		[STRANGLETHORN_HORDE, 3915, 596, 582, "Bloody Bone Necklaces after Nimboya's Headhunting"],
	]) {
		const list = working(goals(guide));
		const accept = at(list, `${guide}: accept ${take}`, is('accept', take));
		const work = list.map((e, i) => [e, i]).filter(([{ goal }]) => goal.t === 'collect' && goal.quest === quest && goal.item === item);
		assert.ok(work.length > 0, `${guide}: the ${what} have a goal`);
		for (const [{ step }, i] of work) assert.ok(i > accept, `${guide}: ${what}, not in "${step.title}"`);
	}
});

// Every leveling guide with a profession quest still plays to the end for a
// character who already has the profession (tests/guides.test.js plays them
// all without one).
test('the leveling guides with profession quests play to the end for a character with the profession', { skip }, () => {
	const pack = buildSimPack([...DUROTARS, ...DUN_MOROGHS, TELDRASSIL, ELWYNN]);
	try {
		const learn = (line, name) => `w.skills[${line}] = { name = "${name}", rank = 1, maxRank = 75 }`;
		const cook = `${learn(185, 'Cooking')} ${learn(164, 'Blacksmithing')}`;
		for (const [guide, race, faction, skills, quest] of [
			[ORC_DUROTAR, 'Orc', 'Horde', learn(333, 'Enchanting'), null],
			[TROLL_DUROTAR, 'Troll', 'Horde', learn(333, 'Enchanting'), null],
			[DUN_MOROGHS[0], 'Dwarf', 'Alliance', cook, 384],
			[DUN_MOROGHS[1], 'Gnome', 'Alliance', cook, 384],
			[TELDRASSIL, 'NightElf', 'Alliance', learn(185, 'Cooking'), 4161],
			[ELWYNN, 'Human', 'Alliance', learn(393, 'Skinning'), null],
		]) {
			const g = pack.guides.find((x) => `${x.id}.guide` === guide);
			assert.ok(g, `${guide} compiles`);
			const [out, done] = playGuide(pack, g, { race, faction, cls: 'WARRIOR', before: skills, script: `${SIMULATE}\nemit({ quest = ${quest || 0} > 0 and C_QuestLog.IsQuestFlaggedCompleted(${quest || 0}) or false })` });
			assert.equal(out.stuck, undefined, `${guide} (${race}) is not stuck: ${JSON.stringify(out.stuck)}`);
			assert.ok(out.done, `${guide} (${race}) plays to the end`);
			if (quest) assert.equal(done.quest, true, `${guide}: a cook does ${quest}`);
		}
	} finally {
		pack.dispose();
	}
});

// --- Quests the guide accepted and turned in with nothing between waiting for
// their objectives, so the guide moved on to the turn-in with the quest
// unfinished: Camping 101: Cooking in Mulgore and Dun Morogh (speak with the
// cook) and, for the Alliance, It's a Secret to Everybody in Un'Goro (the
// Horde guide collects the compass, map and key).

const UN_GORO_ALLIANCE = 'forever/alliance/40-50/07-un-goro-crater.guide';

test('a quest with objectives is completed or collected between its accept and its turn-in', { skip }, () => {
	for (const [guide, quest, t, count] of [
		[MULGORE, 96661, 'complete', 1],
		...DUN_MOROGHS.map((guide) => [guide, 96629, 'complete', 1]),
		[UN_GORO_ALLIANCE, 3845, 'collect', 3],
	]) {
		const list = goals(guide);
		const accept = at(list, `${guide}: accept ${quest}`, is('accept', quest));
		const turnin = at(list, `${guide}: turnin ${quest}`, is('turnin', quest));
		const between = list.slice(accept + 1, turnin).filter(({ goal }) => is(t, quest)(goal));
		assert.equal(between.length, count, `${guide}: ${count} ${t} goal(s) for ${quest} between its accept and its turn-in`);
	}
});

// --- Shadowglen (Pynte, 0.2.4): the first pickups, the totems and the class sigils.

// Conservator Ilthalaine stands beside the start, on the line from Melithar
// down to Tarindrella: the guide no longer sends you past him first.
test(`${TELDRASSIL}: Pynte's report: Conservator Ilthalaine's quest is taken before Melithar's`, { skip }, () => {
	const list = goals(TELDRASSIL);
	const ilthalaine = at(list, 'accept 456 (The Balance of Nature)', is('accept', 456));
	const melithar = at(list, 'accept 458 (The Woodland Protector)', is('accept', 458));
	assert.equal(list[ilthalaine].s, 1, 'taken in the opening step');
	assert.ok(ilthalaine < melithar, 'Ilthalaine before Melithar');
	assert.equal(list.find(located).goal.npc, 2079, 'the arrow first leads to Conservator Ilthalaine');
});

// The Gnarlpine Totems are collected in the field like the Fel Moss, from
// both totem objects, so the window shows them with the kills, not after.
test(`${TELDRASSIL}: Pynte's report: the Gnarlpine Totems are open together with the kills and the Fel Moss, at both totem objects`, { skip }, () => {
	const list = goals(TELDRASSIL);
	const totems = list[at(list, 'the Gnarlpine Totems (97977)', (g) => g.quest === 97977 && g.t !== 'accept' && g.t !== 'turnin')];
	const spots = totems.goal.spots || [];
	for (const object of [668482, 668493]) {
		for (const sp of data.spawns('object', object).filter((x) => x.map === 1438)) {
			for (const [x, y] of [...sp.pts, ...sp.more]) {
				const pt = { map: 1438, x, y };
				assert.ok(spots.some((o) => yards({ map: 1438, x: o.x, y: o.y }, pt) <= o.r + 1), `the totem ${object} at ${x},${y} lies in one of the goal's spots`);
			}
		}
	}
	// The report's state: one boar kill left to do, the boars and the moss done, one totem of four.
	const nightElf = { race: 'NightElf', raceName: 'Night Elf', faction: 'Alliance', cls: 'ROGUE', className: 'Rogue', level: 2 };
	const view = stepView(TELDRASSIL, nightElf, totems.s, `w.complete({ 458 })
		w.onQuest(456, { { required = 7, fulfilled = 3 }, { required = 4, fulfilled = 4 } })
		w.onQuest(459, { { required = 8, fulfilled = 8 } })
		w.onQuest(97977, { { required = 4, fulfilled = 1 } })`);
	assert.equal(view.groups.length, 1, `the step is one group: ${JSON.stringify(view.groups)}`);
	const open = view.goals.filter((g) => g.status === 'active').map((g) => g.quest);
	assert.deepEqual(open, [456, 97977], 'the Nightsabers and the totems are open at the same time');
});

// The sigil is taken once The Balance of Nature is in, and handed to the
// trainer on the visit after Shadowthread Cave, with the class training.
test(`${TELDRASSIL}: Pynte's report: each class's sigil is handed to its trainer at the training stop after Shadowthread Cave`, { skip }, () => {
	for (const [quest, cls] of [[3116, 'WARRIOR'], [3117, 'HUNTER'], [3118, 'ROGUE'], [3119, 'PRIEST'], [3120, 'DRUID']]) {
		const list = goals(TELDRASSIL).filter(forClass(cls));
		const take = at(list, `accept ${quest} (${cls})`, is('accept', quest));
		const give = at(list, `turnin ${quest} (${cls})`, is('turnin', quest));
		assert.ok(at(list, 'turnin 456 (The Balance of Nature)', is('turnin', 456)) < take, `${cls}: the sigil is taken once The Balance of Nature is handed in`);
		assert.ok(take < at(list, 'Webwood Venom Sacs (916)', (g) => g.t === 'collect' && g.quest === 916), `${cls}: taken before the cave`);
		assert.ok(at(list, 'turnin 916 (Webwood Venom)', is('turnin', 916)) < give, `${cls}: handed in after the cave`);
		const train = list.findIndex(({ goal }, i) => i > give && goal.t === 'train' && goal.class);
		assert.ok(train > give && list[train].s === list[give].s, `${cls}: handed in on the training stop, before the training`);
		assert.ok(!list.slice(take, give).some(({ goal }) => goal.t === 'train' && goal.class), `${cls}: no class training between the sigil's accept and its turn-in`);
	}
});

// Escaping Ban'ethil is an escort: taken first, Lynessa sets off before the
// den is done. It is taken once the relics and The Sleeping Druid's chain are.
test(`${TELDRASSIL}: Pynte's report: Escaping Ban'ethil is taken after the relics and The Sleeping Druid's chain (#334)`, { skip }, () => {
	const list = goals(TELDRASSIL);
	const escort = at(list, "accept 99053 (Escaping Ban'ethil)", is('accept', 99053));
	assert.ok(at(list, 'accept 2541 (The Sleeping Druid)', is('accept', 2541)) < escort, 'The Sleeping Druid is taken first');
	assert.ok(at(list, 'turnin 2561 (Druid of the Claw)', is('turnin', 2561)) < escort, 'the chain is handed in before the escort');
	for (const item of [3405, 3406, 3407, 3408]) assert.ok(at(list, `relic ${item}`, (g) => g.t === 'collect' && g.item === item) < escort, `relic ${item} before the escort`);
	assert.ok(escort < at(list, 'complete 99053', is('complete', 99053)), 'taken before the walk out');
});

// --- Darkshire (Yendi, 0.2.3): part 1 of Look to the Stars needs a Bronze Tube.

const NEEDLES = 'forever/alliance/07-thousand-needles.guide';

test(`${NEEDLES}: Yendi's report: Herble's Bronze Tube is offered before Look to the Stars is handed in, without holding the step`, { skip }, () => {
	const list = goals(NEEDLES);
	const give = at(list, 'turnin 174 (Look to the Stars)', is('turnin', 174));
	const buy = at(list, 'buy 4371 (Bronze Tube)', (g) => g.t === 'buy' && g.item === 4371);
	assert.ok(buy < give && list[buy].s === list[give].s, 'bought on the same stop, before the turn-in');
	assert.equal(list[buy].goal.npc, 3133, 'from Herble Baubbletump, beside Viktori');
	// A player who has the tube, or who already handed it in, is not held by it.
	assert.equal(list[buy].goal.optional, true, 'the buy is optional');
});

// --- Zephras Isle (Sato, 0.2.3).

const ZEPHRAS_HORDE = 'forever/horde/skyborne/01-zephras-isle.guide';
const ZEPHRAS_ALLIANCE = 'forever/alliance/skyborne/01-zephras-isle.guide';
const SKYBORNE_HORDE = { race: 'Skyborne', raceName: 'Skyborne', faction: 'Horde', cls: 'ROGUE', className: 'Rogue', level: 6 };
const SKYBORNE_ALLIANCE = { race: 'Skyborne', raceName: 'Skyborne', faction: 'Alliance', cls: 'ROGUE', className: 'Rogue', level: 4 };
// Zephras Isle has no Era frame: points compare in map percent.
const close = (a, b, pct) => a.map === b.map && Math.hypot(a.x - b.x, a.y - b.y) <= pct;

// Visur's report (#848): Valanaar turn-ins sent the player to Dondallion Whisperwind for The
// Missing Scholar (92850), but only Fillion Flamebreeze (253285), who stands beside him, takes it.
// A correction had added Dondallion as a second ender; with the corrections applied, as
// `data build` does, the hand-in leads to Fillion.
test(`${ZEPHRAS_ALLIANCE}: Visur's report (#848): The Missing Scholar is handed in to Fillion Flamebreeze, not Dondallion Whisperwind`, { skip }, () => {
	const corrected = loadData(DATA);
	const fix = loadCorrections().quests['92850'];
	if (fix) Object.assign(corrected.quest(92850), fix.set);
	assert.deepEqual(corrected.quest(92850).end.npc, [253285], 'Fillion Flamebreeze is the only ender');
	const file = path.join(OFFICIAL_DIR, ZEPHRAS_ALLIANCE);
	const { guides } = compileSources([{ file, text: fs.readFileSync(file, 'utf8') }], corrected);
	const turnin = guides[0].steps.flatMap((step) => step.goals).find(is('turnin', 92850));
	assert.ok(turnin, 'The Missing Scholar is handed in');
	assert.equal(turnin.npc, 253285, 'handed in to Fillion Flamebreeze');
});

// The Great Outdoors: /sit by Raan's campfire for Boosted Rest; nothing to click.
test('Sato\'s report: The Great Outdoors on Zephras Isle is done by sitting at Raan\'s campfire, not by clicking it', { skip }, () => {
	data = data || loadData(DATA);
	const fire = data.spawns('object', 460003).find((x) => x.map === 2521);
	for (const guide of [ZEPHRAS_HORDE, ZEPHRAS_ALLIANCE]) {
		const list = goals(guide);
		assert.deepEqual(list.filter(({ goal }) => goal.quest === 96101 && goal.t === 'interact').map(({ s }) => s), [], `${guide}: no click goal`);
		const take = at(list, `${guide}: accept 96101`, is('accept', 96101));
		const sit = at(list, `${guide}: complete 96101`, is('complete', 96101));
		assert.ok(take < sit && sit < at(list, `${guide}: turnin 96101`, is('turnin', 96101)), `${guide}: done between its accept and its turn-in`);
		assert.ok(close(list[sit].goal, { map: 2521, x: fire.pts[0][0], y: fire.pts[0][1] }, 0.3), `${guide}: the arrow leads to Raan's campfire`);
	}
});

// The Gift of Skysight and Reading the Ley Lines are the racial spells cast
// at the place: the line says so, and still counts from the quest log.
test('Sato\'s report: the Skysight and Read Ley Line objectives tell you to cast the racial, and tick from the quest log', { skip }, () => {
	for (const [guide, who, quest, spell] of [[ZEPHRAS_HORDE, SKYBORNE_HORDE, 92598, 'Skysight'], [ZEPHRAS_ALLIANCE, SKYBORNE_ALLIANCE, 92597, 'Read Leyline']]) {
		const list = goals(guide);
		const i = at(list, `${guide}: the objective of ${quest}`, (g) => g.quest === quest && g.oi === 1);
		const view = stepView(guide, who, list[i].s, `w.onQuest(${quest}, { { required = 1, fulfilled = 1 } })`);
		const line = view.goals.find((g) => g.quest === quest && g.t !== 'accept' && g.t !== 'turnin');
		assert.ok(!/^Click\b/.test(line.text) && line.text.includes(spell), `${guide}: "${line.text}" names ${spell}, not a click`);
		assert.equal(line.status, 'done', `${guide}: ticked once the quest log counts it`);
	}
});

// Welcome to Shen'dar Village: talking to Illaya before the step counts.
test(`${ZEPHRAS_HORDE}: Sato's report: Welcome to Shen'dar Village follows its objectives, and is taken before Illaya's talk`, { skip }, () => {
	const list = goals(ZEPHRAS_HORDE);
	assert.ok(at(list, 'accept 92514', is('accept', 92514)) < at(list, 'talk 251902 quest 92595.1 (Illaya)', is('talk', 92595)), 'taken before the talk to Illaya for The Windshapers, which counts for it too');
	const step = list[at(list, 'turnin 92514', is('turnin', 92514))].s;
	assert.deepEqual(list.filter(({ s, goal }) => s === step && goal.t === 'talk' && !goal.quest).map(({ goal }) => goal.npc), [], 'no bare talk goal that only counts during the step');
	const objectives = (illaya, coriella) => stepView(ZEPHRAS_HORDE, SKYBORNE_HORDE, step, `w.complete({ 92595 })
		w.onQuest(92514, { { required = 1, fulfilled = ${illaya} }, { required = 1, fulfilled = ${coriella} } })`)
		.goals.filter((g) => g.quest === 92514 && g.t !== 'turnin').sort((a, b) => a.oi - b.oi).map((g) => g.status);
	// Objective 1 is Illaya, 2 Coriella, whichever line the step lists first.
	assert.deepEqual(objectives(1, 0).map((st) => st === 'done'), [true, false], 'Illaya done earlier, Coriella still to do');
	assert.ok(objectives(1, 1).every((st) => st === 'done'), 'both done: only the turn-in is left');
});

// Aggressive Encroachment: the Scrawny Ursera are on the slope west of
// Thendal Village (Forever's quest data), not in the village. That spawn fix is
// in the private corrections overlay, so this needs it.
test('Sato\'s report: the Scrawny Ursera step leads to the slope west of Thendal Village', { skip }, (t) => {
	const fix = (loadCorrections().npcs[250926] || {}).addSpawns;
	if (!fix) return t.skip('needs the private corrections overlay (data/local/corrections-private.json)');
	const fixed = fix[2521].pts;
	assert.ok(fixed.every(([x]) => x <= 41.6), 'the corrected spawns are all west of the village');
	for (const guide of [ZEPHRAS_HORDE, ZEPHRAS_ALLIANCE]) {
		const list = goals(guide);
		const { goal } = list[at(list, `${guide}: Scrawny Ursera Claw`, (g) => g.t === 'collect' && g.item === 251918)];
		assert.ok(fixed.some(([x, y]) => close(goal, { map: 2521, x, y }, 0.3)), `${guide}: the arrow's point ${goal.x},${goal.y} is at a Scrawny Ursera spawn`);
		for (const sp of (goal.spots || []).filter((o) => !o.alt)) assert.ok(sp.x <= 41.7, `${guide}: the spot ${sp.x},${sp.y} is west of the village`);
	}
});

// --- Strays (#175, Phear): a mob or two on their own, hundreds of yards from the camp
// that holds the rest, drew the point and the arrow away from the camp the step is about.

test('Phear\'s report: a kill or collect leads to the camp that holds its mobs, not a stray one or two far from it', { skip }, () => {
	// [guide, the goal, the camp's x and y range (map percent)]
	const cases = [
		...DUN_MOROGHS.map((guide) => [guide, 'Frostmane Headhunter (Frostmane Hold)', (g) => g.t === 'kill' && g.npc === 1123 && g.quest === 287, [20, 27, 49, 56]]),
		['forever/alliance/03-darkshore.guide', 'Grizzled Scalp', (g) => g.t === 'collect' && g.item === 5414, [37, 46, 69, 83]],
		['forever/alliance/50-60/02-felwood.guide', 'Jadefire Hellcaller (Jadefire Run)', (g) => g.t === 'kill' && g.npc === 7111, [38, 44, 13, 23]],
		['forever/horde/05-stonetalon-mountains.guide', 'Stonetalon Sap', (g) => g.t === 'collect' && g.item === 5582, [32, 41, 9, 21]],
		['forever/horde/50-60/01-un-goro-crater.guide', 'Bloodpetal Lasher (east side)', (g) => g.t === 'kill' && g.npc === 6509, [55, 77, 20, 50]],
		['forever/horde/50-60/01-un-goro-crater.guide', 'Bloodpetal Thresher (east side)', (g) => g.t === 'kill' && g.npc === 6511, [55, 77, 20, 50]],
		['forever/horde/40-50/03-feralas.guide', 'Marsh Flesheater (huts on the western shore)', (g) => g.t === 'kill' && g.npc === 751, [60, 75, 75, 100]],
	];
	const inCamp = ([x0, x1, y0, y1]) => (p) => p.x >= x0 && p.x <= x1 && p.y >= y0 && p.y <= y1;
	for (const [guide, what, pred, camp] of cases) {
		for (const { goal } of goals(guide).filter(({ goal }) => pred(goal))) {
			assert.ok(inCamp(camp)(goal), `${guide}: ${what}: the point ${goal.x},${goal.y} is at the camp`);
			const arrow = goal.spots.filter((s) => !s.alt);
			assert.ok(arrow.length && arrow.every(inCamp(camp)), `${guide}: ${what}: the arrow picks only the camp: ${JSON.stringify(goal.spots)}`);
			assert.ok(goal.spots.some((s) => s.alt && !inCamp(camp)(s)), `${guide}: ${what}: the strays stay alternatives`);
		}
		assert.ok(goals(guide).some(({ goal }) => pred(goal)), `${guide}: ${what} is in the guide`);
	}
	// Not strays: a sparse trail of single spawns (the Lingering Highborne through the ruins), spawns all
	// over a zone (Scourgestones, the OOX beacon) and a target with six spawns or fewer (Pristine Black
	// Diamond). The walk still starts at the spawn nearest the previous goal, a spot the arrow searches.
	const kept = [
		['forever/alliance/50-60/01-burning-steppes.guide', 7972],
		['forever/class/priest/blood-of-morphaz.guide', 7972],
		['forever/alliance/50-60/03-winterspring.guide', 12840],
		['forever/horde/50-60/01-un-goro-crater.guide', 12840],
		['forever/horde/40-50/02-feralas.guide', 8705],
		['forever/class/shaman/darkreaver.guide', 18335],
	];
	for (const [guide, item] of kept) {
		const list = goals(guide);
		const { goal } = list[at(list, `${guide}: collect ${item}`, (g) => g.t === 'collect' && g.item === item)];
		const first = goal.spots[0];
		assert.ok(!first.alt && first.n === 1 && Math.hypot(first.x - goal.x, first.y - goal.y) <= 0.1, `${guide}: collect ${item}: the walk starts at the point ${goal.x},${goal.y}: ${JSON.stringify(first)}`);
	}
	const ichor = goals('forever/alliance/50-60/01-burning-steppes.guide').find(({ goal }) => goal.item === 7972).goal;
	const trail = ichor.spots.filter((s) => s.x >= 34 && s.x <= 41 && s.y >= 45 && s.y <= 62);
	assert.equal(trail.length, 6, JSON.stringify(ichor.spots));
	assert.ok(trail.every((s) => !s.alt), 'every spot of the Highborne trail is searched');
});

// The goals the stray rule moved, checked against their steps (#175 review): the
// Grizzled Scalps are taken where the bears are, and cloth the guide says to buy
// leads to the Auction House, not to the guards and mobs that happen to drop it.

test('forever/alliance/03-darkshore.guide: the Grizzled Scalps are collected in the step at the Grove, where the bears are and Buzzbox 525 takes them', { skip }, () => {
	const list = goals(DARKSHORE);
	const i = at(working(list), 'Grizzled Scalp', (g) => g.t === 'collect' && g.item === 5414);
	const turnin = at(list, 'turnin 1003', is('turnin', 1003));
	assert.equal(list[i].step, list[turnin].step, 'one step: the bears and Buzzbox 525');
	assert.ok(i < turnin);
	assert.ok(yards(list[i].goal, list[turnin].goal) < 300, `the scalps' point ${list[i].goal.x},${list[i].goal.y} is near Buzzbox 525`);
});

test('the cloth the guides tell you to buy leads to the Auction House: the capitals\' cloth donations and Grimand\'s Runecloth', { skip }, () => {
	// The auctioneers: Stormwind's Trade District (live frame) and Ironforge's (Era frame).
	const ah = { 1453: { x: 61.2, y: 71.3 }, 1455: { x: 24.2, y: 74.7 } };
	const cases = [
		['forever/alliance/50-60/06-silithus.guide', [7793, 7794, 7795, 7807, 7808, 7809, 7811, 7802, 7803, 7804, 7805]],
		['forever/collectibles/mounts/alliance/paladin-charger.guide', [7642]],
	];
	for (const [guide, quests] of cases) {
		for (const quest of quests) {
			const list = goals(guide).filter(({ goal }) => goal.t === 'collect' && goal.quest === quest && [2592, 4306, 4338, 14047].includes(goal.item));
			assert.ok(list.length, `${guide}: the cloth of ${quest}`);
			for (const { goal } of list) {
				const at_ = ah[goal.map];
				assert.ok(at_ && goal.x === at_.x && goal.y === at_.y, `${guide}: ${quest} ${goal.itemName}: the point ${goal.map} ${goal.x},${goal.y} is the Auction House`);
				for (const s of (goal.spots || []).filter((o) => !o.alt)) assert.deepEqual([s.x, s.y], [at_.x, at_.y], `${guide}: ${quest}: the arrow picks only the Auction House`);
			}
		}
	}
});

// --- Steps the arrow cannot lead (rikette, #140): an objective step written
// only as bare `complete` lines has no place, so the arrow points nowhere.
// The objectives go on kill, collect and interact goals (or a placed
// `complete` for a place to reach), which the data locates.

for (const DUN_MOROGH of DUN_MOROGHS) test(`${DUN_MOROGH}: rikette's report: the Grizzled Den leads the arrow to the wendigo cave`, { skip }, () => {
	const list = goals(DUN_MOROGH);
	const den = list.filter(({ step }) => step.title === 'The Grizzled Den');
	assert.ok(den.length, 'the Grizzled Den step is in the guide');
	for (const quest of [98321, 313]) {
		const goal = den.find(({ goal: g }) => g.quest === quest && g.t === 'collect');
		assert.ok(goal && located(goal), `the den's objective of ${quest} has a place`);
		// The cave lies south-west of Kharanos (46,51), around 41-44,47-50.
		assert.ok(yards(goal.goal, { map: goal.goal.map, x: 42, y: 48.5 }) < 250, `${quest} leads into the den (${goal.goal.x},${goal.goal.y})`);
	}
});

// Escorts and events start at their NPC in the step before and follow it, so
// a bare `complete` is right there: the arrow has the NPC to lead to.
const FOLLOWS_AN_NPC = new Set([
	5821, // Bodyguard for Hire: the Gizelton caravan escort (Desolace)
	665, // Sunken Treasure: escort Doctor Draxlegauge (Arathi Highlands)
	660, // Hints of a New Plague?: escort Kinelory (Arathi Highlands)
	4491, // A Little Help From My Friends: escort Ringo (Un'Goro Crater)
	863, // The Escape: escort Wizzlecrank (The Barrens)
	7622, // The Balance of Light and Shadow: the event at Eris Havenfire
]);

test('every step with a quest objective to do has a goal the arrow can lead to', { skip }, () => {
	const offenders = [];
	for (const guide of allGuides()) {
		const steps = [...new Set(goals(guide).map(({ step }) => step))];
		steps.forEach((step, i) => {
			const open = step.goals.filter((g) => g.t === 'complete' && !FOLLOWS_AN_NPC.has(g.quest));
			if (open.length && !step.goals.some((g) => g.map != null && g.x != null)) offenders.push(`${guide} step ${i + 1} (${step.title}): complete ${open.map((g) => g.quest).join(', ')}`);
		});
	}
	assert.deepEqual(offenders, [], 'steps whose objectives have no place');
});

// A turn-in's place does not lead to the objective (Dun Morogh, Rumbleshot's
// Ammo: the arrow sent players to Hegnar while the Ammo Crate stands by
// Mountaineer Gretchen). When the data knows where every objective of a quest
// is (an item that drops from a spawned NPC or object, an object to use, or a
// place to reach: an area trigger with a position, like The Red Crystal's
// "Locate the large, red crystal", #241), a bare `complete` is not enough: the
// step needs a placed goal of its own for that quest (`collect <item> quest
// <id>.<n>`, `interact`, `complete <id> @x,y`) or a questless one (`goto`,
// `use @x,y`).
const OBJECTIVE_WITHOUT_A_PLACE = new Set([
	339, 340, 341, 342, // Green Hills of Stranglethorn: pages drop at random across the zone
	96605, 96608, // The Great Outdoors: the campfire is built with a spell, not clicked
	6134, // Ghost-o-plasm Round Up: the spectres come to the Ghost Magnets in the Kodo Graveyard, not their data spawn
	1149, // Test of Faith: the leap is from the planks beside Dorn Plainstalker (54,41.5); the data's trigger lies at 26.4,32.9, far from him
	1699, // The Rethban Gauntlet: the trigger is at the first fork inside the Rethban Caverns, and its mouth is not marked yet (tests/guides-caves.test.js)
]);

test('Rumbleshot\'s Ammo, The Red Crystal: every objective the data can place has a goal of its own, not only the turn-in', { skip }, () => {
	const placed = (g) => g.map != null && g.x != null;
	const spawned = (x) => !!x && Object.keys(x.spawns || {}).length > 0;
	const knownPlace = (o) =>
		o.type === 'item'
			? Object.keys(data.items[o.id]?.drops?.npc || {}).some((n) => spawned(data.npcs[n])) || Object.keys(data.items[o.id]?.drops?.object || {}).some((n) => spawned(data.objects[n]))
			: o.type === 'object'
				? spawned(data.objects[o.id])
				: o.type === 'event' && o.id != null && placed(o); // an area trigger; an escort's or a script's event has no id
	const offenders = [];
	for (const guide of allGuides()) {
		compiled(guide).steps.forEach((step, i) => {
			for (const g of step.goals) {
				if (g.t !== 'complete' || placed(g) || OBJECTIVE_WITHOUT_A_PLACE.has(g.quest)) continue;
				const objectives = data.quests[g.quest]?.objectives || [];
				if (!objectives.length || !objectives.every(knownPlace)) continue;
				const leads = (o) => placed(o) && (o.quest === g.quest ? o.t !== 'accept' && o.t !== 'turnin' : o.quest == null && (o.t === 'goto' || o.t === 'use'));
				if (step.goals.some(leads)) continue;
				offenders.push(`${guide} step ${i + 1} (${step.title}): complete ${g.quest}`);
			}
		});
	}
	assert.deepEqual(offenders, [], 'objectives led to only by their turn-in, or not at all');
});

test(`${DARKSHORE}: Twerkjob's report: The Red Crystal leads the arrow to the crystal on the eastern ridge (#241)`, { skip }, () => {
	const list = goals(DARKSHORE);
	const complete = list[at(list, 'complete 4811 (The Red Crystal)', is('complete', 4811))];
	// The step's first placed goal for the quest, past its accept: where the arrow leads.
	const lead = list.find(({ step, goal: g }) => step === complete.step && g.quest === 4811 && g.t !== 'accept' && g.t !== 'turnin' && located({ goal: g }));
	assert.ok(lead, 'the red crystal step has a goal the arrow can lead to');
	// "Locate the large, red crystal on Darkshore's eastern mountain range", the quest's area trigger.
	const crystal = data.quests[4811].objectives.find((o) => o.type === 'event');
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
	const quest = data.quests[4763];
	const spawn = (kind, id) => {
		const [x, y] = data[kind][id].spawns[1439].pts[0];
		return { map: 1439, x, y };
	};
	// The samples and the filled bowl: what the quest needs beyond the bowl it hands over.
	const needed = quest.requiredItems.filter((item) => item !== quest.sourceItem);
	assert.deepEqual([...needed].sort(), [12341, 12342, 12343, 12347], 'the data lists the three samples and the filled bowl');
	const got = needed.map((item) => {
		const i = at(list, `collect ${item} (${data.items[item].name})`, (g) => g.t === 'collect' && g.item === item);
		assert.ok(i > accept && i < talisman, `${data.items[item].name} is collected after the accept and before the Talisman`);
		const [source] = Object.keys(data.items[item].drops.object);
		assert.ok(located(list[i]) && yards(list[i].goal, spawn('objects', source)) < 5, `${data.items[item].name} leads to ${data.objects[source].name}`);
		return i;
	});
	const fill = got[needed.indexOf(12347)];
	assert.equal(list[fill].step, list[accept].step, 'the bowl is filled in Auberdine, where Thundris gives the quest');
	const use = at(list, 'use 12347 (Filled Cleansing Bowl)', (g) => g.t === 'use' && g.item === 12347);
	assert.ok(got.every((i) => i < use) && use < talisman, 'the bowl is used with every sample in the bags, before the Talisman');
	assert.ok(yards(list[use].goal, spawn('npcs', 10373)) < 10, `the bowl is used where Xabraxxis comes (${list[use].goal.x},${list[use].goal.y})`);
});

for (const DUN_MOROGH of DUN_MOROGHS) test(`${DUN_MOROGH}: Rumbleshot's Ammo leads to the Ammo Crate by Mountaineer Gretchen, not to Hegnar`, { skip }, () => {
	const list = goals(DUN_MOROGH);
	const ammo = list.find(({ goal: g }) => g.t === 'collect' && g.quest === 5541);
	assert.ok(ammo && located(ammo), 'the ammo has a place');
	assert.ok(yards(ammo.goal, { map: ammo.goal.map, x: 44.13, y: 56.95 }) < 30, `the ammo is at the crate (${ammo.goal.x},${ammo.goal.y})`);
});

test('legacy-challenges: Return to Bodley is turned in before Back to the Beginning is taken', { skip }, () => {
	const list = goals('forever/legacy/legacy-challenges.guide');
	const bodley = at(list, 'turnin 8996', (g) => g.t === 'turnin' && g.quest === 8996);
	for (const quest of [8997, 8998]) assert.ok(bodley < at(list, `accept ${quest}`, (g) => g.t === 'accept' && g.quest === quest), `8996 before ${quest}`);
});

// --- Boats in open water (Fitz's playtest at the Auberdine pier): a boat's
// stop in travel.json is where the ship stands (TaxiPathNode), most of them in
// open water 12-14 yd off the pier. A goto there completes only within 8 yd of
// it, so the step cannot finish without swimming and the arrow points into the
// sea. Every goto at a transport (within 40 yd of its stop) is on walkable
// ground: dry deck, pier or platform within 8 yd, on the navigation grid.

const NAV = path.join(__dirname, '..', 'data', 'local', 'nav');
const navIndex = fs.existsSync(path.join(NAV, 'index.json')) ? JSON.parse(fs.readFileSync(path.join(NAV, 'index.json'), 'utf8')) : null;
const navSkip =
	skip ||
	needs('travel.json', 'zones.json') ||
	(!navIndex ? 'no navigation build in data/local/nav (node tools/polestar.js nav build)' : navIndex.version !== require('../tools/lib/nav/grid/format').VERSION ? `data/local/nav is tile version ${navIndex.version}: rebuild it (node tools/polestar.js nav build)` : false);

test("Fitz's playtest: every goto at a boat, zeppelin or tram stop is on its deck or pier, not in the water", { skip: navSkip }, () => {
	const { openNav } = require('../tools/lib/nav/path');
	const { FLAG, TILE_CELLS, cellOf } = require('../tools/lib/nav/grid/format');
	const { Geo } = require('../tools/lib/planner/geo');
	const read = (f) => JSON.parse(fs.readFileSync(path.join(DATA, f), 'utf8'));
	const nav = openNav({ dir: NAV });
	const geo = new Geo(read('map-frames.json'), read('zones.json'));
	const stops = read('travel.json').transports.flatMap((t) => ['a', 'b'].map((side) => ({ id: `${t.id} (${t[side].name})`, ...t[side] })));
	// A dry walkable surface in the cell at (wx, wy): not swim or blocked, above any water there, in a region the
	// router snaps to (not a pocket under the deck).
	const dry = (c, wx, wy) => {
		const a = cellOf(wx, wy);
		const t = nav.tile(c, a.col, a.row);
		if (!t) return false;
		const k = a.j * TILE_CELLS + a.i;
		const s = [];
		for (let e = t.first[k]; e < t.first[k + 1]; e++) s.push({ e, z: t.z[e], f: t.flags[e] });
		const water = Math.max(-Infinity, ...s.filter((q) => q.f & FLAG.SWIM).map((q) => q.z));
		return s.some((q) => !(q.f & (FLAG.SWIM | FLAG.BLOCKED)) && q.z > water && (nav.regionSize(c, a.col, a.row, q.e) ?? 1000) >= 1000);
	};
	const nearDry = (c, wx, wy) => {
		if (dry(c, wx, wy)) return true;
		for (let r = 2; r <= 8; r += 2) for (let deg = 0; deg < 360; deg += 15) if (dry(c, wx + r * Math.cos((deg * Math.PI) / 180), wy + r * Math.sin((deg * Math.PI) / 180))) return true;
		return false;
	};
	const offenders = new Set();
	let checked = 0;
	for (const guide of allGuides()) {
		for (const { step, goal } of goals(guide)) {
			if (goal.t !== 'goto') continue;
			const w = geo.toWorld(goal.map, goal.x, goal.y, goal.f || 'l');
			if (!w) continue;
			const stop = stops.find((s) => s.c === w.c && Math.hypot(s.wx - w.wx, s.wy - w.wy) <= 40);
			if (!stop) continue;
			checked++;
			if (!nearDry(w.c, w.wx, w.wy)) offenders.add(`${guide} step "${step.title}": goto ${goal.x},${goal.y} "${goal.text}" by ${stop.id}`);
		}
	}
	assert.ok(checked >= 10, `the guides' transport gotos are found (${checked})`);
	assert.deepEqual([...offenders], [], 'transport gotos with no deck or pier within 8 yd');
});

// --- Typed coordinates on the wrong map (Fitz's playtest: Darkshore's "Boat to
// Stormwind" pointed into Moonglade). Coordinates without `map` are on the zone
// in effect, and a `zone` line holds for the steps after it, even when its step
// is for some characters only: the Night Elf Druids' Moonglade trip set zone
// Moonglade for the rest of Darkshore, and a Paladin trip set Thunder Bluff for
// the Barrens Warlocks' summoning circle in Orgrimmar. Each such goal is on the
// zone every character who sees it is in: the last `zone` line of the steps
// that character sees.

test("Fitz's playtest: typed coordinates are on the zone of every character who sees them", { skip: skip || needs('races.json') }, () => {
	const { characterKeys } = require('../tools/lib/dsl/conditions');
	const races = JSON.parse(fs.readFileSync(path.join(DATA, 'races.json'), 'utf8'));
	const classesOf = (race, side) => (races[race] && races[race][side] ? races[race][side].classes : null);
	const offenders = [];
	for (const guide of allGuides()) {
		const g = compiled(guide);
		const ast = g._ast;
		const lines = fs.readFileSync(path.join(OFFICIAL_DIR, guide), 'utf8').split(/\r?\n/);
		const zoneAt = (ln) => (ln ? lines[ln - 1].trim() : 'no zone');
		const head = { factions: ast.header.faction ? [ast.header.faction] : null, races: ast.header.races || null, classes: ast.header.classes || null };
		// Every step's `zone` lines, with who sees the step.
		const zoneLines = ast.steps.flatMap((s, i) => {
			const end = i + 1 < ast.steps.length ? ast.steps[i + 1].line : lines.length + 1;
			const who = characterKeys([head, s.only], classesOf);
			const out = [];
			for (let ln = s.line + 1; ln < end; ln++) if (/^\s+zone\b/.test(lines[ln - 1])) out.push({ ln, who });
			return out;
		});
		ast.steps.forEach((s, si) => {
			s.goals.forEach((ag, gi) => {
				if (!ag.explicitCoords || ag.coordMap !== undefined) return;
				const compiledZone = zoneAt(ag.zone && ag.zone.line);
				const elsewhere = new Set();
				for (const k of characterKeys([head, s.only, ag.only], classesOf)) {
					let ln = ast.header.zone ? ast.header.zone.line : null;
					for (const z of zoneLines) if (z.ln < ag.line && z.who.has(k)) ln = z.ln;
					if (zoneAt(ln) !== compiledZone) elsewhere.add(zoneAt(ln));
				}
				const goal = g.steps[si].goals[gi];
				if (elsewhere.size) offenders.push(`${guide}:${ag.line} (${goal.t} ${goal.x},${goal.y}) is on ${compiledZone}, for characters in ${[...elsewhere].join(', ')}`);
			});
		});
	}
	assert.deepEqual(offenders, [], 'typed coordinates on a zone some of their characters are not in');
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
	const moonbrook = list.findIndex(({ step }) => step.title === 'Moonbrook and the Defias hills');
	assert.ok(moonbrook >= 0, 'the Moonbrook step is in the guide');
	const next = list.slice(moonbrook).find(({ step }) => step !== list[moonbrook].step);
	assert.equal(next.step.title, 'Back to Sentinel Hill', 'the step after Moonbrook leads back to Sentinel Hill');
	assert.ok(list.some(({ goal }) => goal.t === 'sethome' && goal.location === 'Sentinel Hill'), 'the bind at Sentinel Hill stays');
});

// An Enticing Offer: the quest log lists the blood before the petals, so each
// collect counts its own objective (Bashidian Twotao, #279).
test(`${ELWYNN}: Bashidian Twotao's report (#279): the bait ingredients count their own objectives`, { skip }, () => {
	const oi = (item) => goals(ELWYNN).find(({ goal }) => goal.t === 'collect' && goal.quest === 99130 && goal.item === item).goal.oi;
	assert.equal(oi(286215), 1, 'Vial of Animal Blood is objective 1');
	assert.equal(oi(286214), 2, 'Duskweed Petal is objective 2');
});

// --- Northshire Abbey (Zepheriel, #310): Skirmish at Echo Ridge is taken from
// Marshal McBride when Investigate Echo Ridge is handed in to him, not after
// Brother Paxton in the library and a walk back.
test(`${ELWYNN}: Zepheriel's report (#310): Skirmish at Echo Ridge is taken from McBride before Brother Paxton, with nobody between`, { skip }, () => {
	const list = goals(ELWYNN);
	const handed = at(list, 'turnin 15 (Investigate Echo Ridge)', is('turnin', 15));
	const take = at(list, 'accept 21 (Skirmish at Echo Ridge)', is('accept', 21));
	assert.ok(handed < take, 'Investigate Echo Ridge is handed in first');
	assert.equal(list[take].goal.npc, list[handed].goal.npc, 'both at Marshal McBride');
	assert.deepEqual(list.slice(handed + 1, take).filter(located).map(({ goal }) => `${goal.t} ${goal.quest} at ${goal.npcName || goal.npc}`), [], 'nobody else between them');
	assert.ok(take < at(list, 'turnin 91743 (Rascally Rodents)', is('turnin', 91743)), 'Skirmish at Echo Ridge is taken before Brother Paxton');
});

// --- Croaky's Head (Syfin, #221): Croaky, a named elite, roams the murloc
// shore south of the Eastvale bridge, along the river where the first east
// loop searches for Ormin Pelford's Waterlogged tools. Its head starts Croaky's
// Head for Merell Ross at Ridgepoint Tower, a short way east. The loot is an
// optional goal of a step of its own for players who group for it (#979: in the
// river step for everyone it cost 12 recorded deaths at 8-9); the accept
// (optional) and the Ridgepoint Tower turn-in are steps of their own for a
// player who answers the group question with "do" (as one who loots the head
// does when the route asks), and the turn-in holds only a player who took the
// quest (an optional accept vouches for nobody who did not).

test(`${ELWYNN}: Syfin's report (#221): Croaky's Head is an optional extra; Ridgepoint Tower holds and leads the arrow only with the head`, { skip }, () => {
	const pack = buildSimPack([ELWYNN]);
	try {
		const g = pack.guides[0];
		data = data || loadData(DATA);
		const [x, y] = data.npcs[248277].spawns[1429].pts[0];
		// Recorded from the simulated player's own actions, once the engine has
		// settled: the first Waterlogged tool (the river step is live; with the
		// head, it is looted and right-clicked there), and any hand-in of
		// Croaky's Head (the step it is handed in from, and where the arrow
		// leads). The game takes no turn-in for a quest the player does not hold.
		const watch = (head) => `
			local E, w = Polestar.Engine, stub.world
			local murlocs, ridge = false, false
			local progress, turnIn = w.progress, w.turnIn
			w.progress = function(q, ...)
				if q == 91733 and not murlocs then
					murlocs = {}
					if ${head} then
						w.addItem(247826, 1)
						w.accept(91740, {}, "Croaky's Head")
						stub.advance(0.6)
					end
					for _, v in ipairs(E.GetStepView(E.GetStepIndex()).goals) do
						if v.quest == 91740 or v.item == 247826 then murlocs[#murlocs + 1] = v.t .. " " .. tostring(v.optional) end
					end
					for i, s in ipairs(SIM_GUIDE.steps) do
						for _, v in ipairs(s.goals) do
							if v.t == "accept" and v.quest == 91740 then murlocs[#murlocs + 1] = "accept " .. tostring(v.optional) end
						end
					end
				end
				return progress(q, ...)
			end
			w.turnIn = function(q, ...)
				if q == 91740 then
					local i, wp = E.GetStepIndex(), E.GetWaypoint()
					ridge = { title = E.GetStepView(i).title, status = E.GetStepView(i).goals[1].status, wp = wp and { map = wp.map, x = wp.x, y = wp.y } or false }
					if not w.log[q] then return end
				end
				return turnIn(q, ...)
			end
			${SIMULATE}
			local view
			for i, s in ipairs(SIM_GUIDE.steps) do if s.title == "Ridgepoint Tower" then view = E.GetStepView(i).goals[1].status end end
			emit({ murlocs = murlocs, ridge = ridge, later = view or false, done = C_QuestLog.IsQuestFlaggedCompleted(91740) })`;
		// Without the head, whatever the answer at the group quest; with it, as one who does it.
		for (const [head, groups] of [[false, 'skip'], [false, 'do'], [true, 'do']]) {
			const [out, got] = playGuide(pack, g, { race: 'Human', faction: 'Alliance', cls: 'WARRIOR', groups, script: watch(head) });
			const who = `${head ? 'with the head' : 'without the head'}, answering ${groups}`;
			assert.equal(out.stuck, undefined, `${who}: not stuck: ${JSON.stringify(out.stuck)}`);
			assert.ok(out.done, `${who}: plays to the end`);
			assert.deepEqual(got.murlocs, ['accept true'], `${who}: the head is no goal of the river step (groups only, #979), its accept optional`);
			assert.equal(got.done, head, `${who}: Croaky's Head ${head ? 'is' : 'is not'} handed in`);
			if (head) {
				assert.equal(got.ridge && got.ridge.title, 'Ridgepoint Tower', 'with the head: handed in at the Ridgepoint Tower step');
				assert.equal(got.ridge.status, 'active', 'the turn-in holds the step');
				assert.ok(got.ridge.wp && yards(got.ridge.wp, { map: 1429, x, y }) <= 5, `the arrow leads to Merell Ross at Ridgepoint Tower: ${JSON.stringify(got.ridge.wp)}`);
				assert.equal(got.later, 'done');
			} else {
				assert.equal(got.ridge, false, `${who}: Ridgepoint Tower is passed, nothing is handed in there`);
				assert.ok(['na', 'skipped'].includes(got.later), `${who}: the turn-in is not this player's: ${got.later}`);
			}
		}
	} finally {
		pack.dispose();
	}
});

// --- Elwynn (zeike, #553): the Gold Pickup Schedule that starts The Collector
// (123) drops from Gruff Swiftbite, a rare (86%; the Runts and Outrunners of
// Riverpaw Gnoll Bounty 3%), at Forest's Edge, the last stop before Westfall.
// The step waits for the armbands, not for him. The Collector's turn-in
// (Marshal Dughan, Goldshire) and Manhunt (147, Morgan the Collector in the
// east) would each be a trip back across Elwynn, so both are left out
// (Rev17 AS: c17 wrote 123's turn-in into Westfall with no way back).
test(`${ELWYNN}: zeike's report (#553): Forest's Edge does not wait for the rare Gruff Swiftbite; The Collector and Manhunt are left out`, { skip }, () => {
	const list = goals(ELWYNN);
	const s = list[at(list, 'the armbands (782)', (g) => g.t === 'collect' && g.item === 782)].s;
	assert.ok(list.some(({ s: n, goal }) => n === s && goal.t === 'collect' && goal.quest === 11 && !goal.optional), 'the armbands hold the step');
	assert.deepEqual(list.filter(({ goal }) => goal.item === 1307 || goal.item === 2239 || [123, 147].includes(goal.quest)).map(({ goal }) => `${goal.t} ${goal.quest || goal.item}`), [], 'no Schedule, Collector or Manhunt goal');
});

// --- A goal on a neighbour's map (#246): Kadrak stands at the Mor'shan
// Rampart, in the Barrens (Forever's quest data; AreaTable puts the Rampart, 1703,
// under the Barrens), where the Barrens and Ashenvale maps overlap. The step's
// `zone Ashenvale` put him on Ashenvale's map, so the travel planner took him
// for a target in Ashenvale and sent players on the Gold Road through the
// zone crossing to its Ashenvale end, 110 yd past him, and back.
const STONETALON_HORDE = 'forever/horde/05-stonetalon-mountains.guide';

test(`${STONETALON_HORDE}: #246: Kadrak's goals are on the Barrens' map, and the Ashenvale steps after them on Ashenvale's`, { skip }, () => {
	const list = goals(STONETALON_HORDE);
	const kadrak = [is('turnin', 6541), is('accept', 6543), is('turnin', 6543)].map((p, i) => list[at(list, `Kadrak goal ${i + 1}`, p)].goal);
	for (const g of kadrak) assert.equal(g.map, 1413, `${g.t} ${g.quest} is on The Barrens (1413), not ${g.map}`);
	const scout = list[at(list, 'the Warsong Scout Update', (g) => g.t === 'collect' && g.item === 16764)].goal;
	assert.equal(scout.map, 1440, 'the Warsong Scout is still in Ashenvale');
});

// Tirion's quests have two givers in the data: Tirion Fordring (1855) at his
// hut on the Thondroril, and Lord Tirion Fordring (12126), who stands in
// Hearthglen only during the In Dreams event. On Western Plaguelands' map the
// compiler picked the one spawned there, 12126, and sent players into the
// Scarlet town (the Alliance Western Plaguelands and Horde Felwood guides).
test('#246: every goal with Tirion leads to Tirion Fordring at his hut, never to Lord Tirion Fordring in Hearthglen', { skip }, () => {
	const tirion = [5542, 5543, 5544, 5742, 5781];
	const found = [];
	for (const guide of allGuides()) {
		for (const { step, goal } of goals(guide)) {
			if (!tirion.includes(goal.quest) || !['accept', 'turnin'].includes(goal.t)) continue;
			found.push(`${guide} ${goal.t} ${goal.quest}`);
			const picked = { npc: goal.npc, map: goal.map };
			assert.deepEqual(picked, { npc: 1855, map: 1423 }, `${guide} (step ${step.title}) ${goal.t} ${goal.quest}: Tirion Fordring on the Eastern Plaguelands' map`);
		}
	}
	for (const guide of ['forever/alliance/50-60/04-western-plaguelands.guide', 'forever/horde/50-60/02-felwood.guide']) {
		for (const q of [5542, 5543, 5544]) assert.ok(found.includes(`${guide} accept ${q}`), `${guide} takes ${q} from Tirion`);
	}
});

// The same pattern everywhere: where the zone maps overlap, the data spawns an
// NPC or object at one spot on both maps, and the step's zone picks the map.
// A goal on the map of a zone Forever's quest data does not list it in, while
// the data has it at that spot on a map of one it lists, routes the player
// standing beside it through the crossing to the other zone and back (the
// travel planner takes the target's zone from its map). Drops count when no
// dropper is listed in the goal's zone. Needs Forever's list cache
// (data/sources/web/codex, `polestar codex build`).
const NEIGHBOUR_MAP = new Set([
	// The optional hand-in at Garush shares a step with the Alliance's at Pureheart in Western Plaguelands.
	'forever/reputation/argent-dawn.guide talk npc 10839',
]);
const webLists = fs.existsSync(path.join(SOURCES, 'web', 'codex', 'lists', 'npc.json'));

test('#246: no NPC or object goal is on a neighbouring zone\'s map where the two maps overlap', { skip: skip || (!webLists && 'no Forever list cache (data/sources/web/codex/lists)') }, () => {
	const wh = loadWeb(SOURCES).listed;
	data = data || loadData(DATA);
	const area = (map) => data.zone(map) && data.zone(map).areaId;
	const world = (map, x, y, f) => {
		const fr = (f === 'e' ? data.mapFrames.era : data.mapFrames.forever || {})[map] || data.eraFrame(map);
		return fr && { c: fr.c, wx: fr.top + ((fr.bottom - fr.top) * y) / 100, wy: fr.left + ((fr.right - fr.left) * x) / 100 };
	};
	const listedIn = (kind, id) => (wh[kind] && wh[kind][id] && wh[kind][id].location) || [];
	const offenders = [];
	for (const guide of allGuides()) {
		for (const { step, goal } of goals(guide)) {
			if (goal.map == null || goal.x == null) continue;
			let sources = ['npc', 'object'].filter((k) => typeof goal[k] === 'number').map((k) => [k, goal[k]]);
			if (!sources.length && goal.t === 'collect' && goal.item) {
				const drops = (data.item(goal.item) || {}).drops || {};
				sources = ['npc', 'object'].flatMap((k) => Object.keys(drops[k] || {}).map((id) => [k, Number(id)]));
			}
			const zone = area(goal.map);
			if (!sources.length || sources.some(([k, id]) => listedIn(k, id).length === 0 || listedIn(k, id).includes(zone))) continue;
			const points = [goal, ...(goal.spots || [])].map((p) => world(goal.map, p.x, p.y, goal.f)).filter(Boolean);
			const elsewhere = sources.some(([k, id]) => data.spawns(k, id).some((s) => s.map !== goal.map && listedIn(k, id).includes(area(s.map))
				&& s.pts.some((p) => {
					const w = world(s.map, p[0], p[1], s.f);
					return w && points.some((g) => g.c === w.c && Math.hypot(g.wx - w.wx, g.wy - w.wy) <= 60);
				})));
			const key = `${guide} ${goal.t} ${sources.length === 1 ? sources[0].join(' ') : `item ${goal.item}`}`;
			if (elsewhere && !NEIGHBOUR_MAP.has(key)) offenders.push(`${key} (step ${step.title}, map ${goal.map})`);
		}
	}
	assert.deepEqual([...new Set(offenders)], [], 'goals on the map of a zone Forever\'s quest data does not place them in');
});

// --- Ashenvale (Zerkness #383, Ioney #396): two Paladins found no Alonso at
// Mystral Lake. Whether Forever offers his Dragonslayer quests (78132-78134)
// to every class waits on an in-game check, so every player is led to him
// (a plain goto), his accepts are optional and the turn-ins hold only a
// player who took the quest: one he offers nothing passes the step there.

test('Zerkness\'s and Ioney\'s reports (#383, #396): every player is led to Alonso, and his quests hold only one who takes them, in both Ashenvale guides', { skip }, () => {
	const chain = [78132, 78133, 78134];
	for (const [guide, faction, paladinRace, warriorRace] of [[ASHENVALE, 'Alliance', 'Dwarf', 'Human'], [ASHENVALE_HORDE, 'Horde', 'Scourge', 'Orc']]) {
		const list = goals(guide);
		const first = at(list, `${guide}: accept 78132`, is('accept', 78132));
		const { step } = list[first];
		assert.equal(step.title, 'Alonso', `${guide}: Alonso has his own step`);
		assert.ok(!step.only, `${guide}: the Alonso step is for every class`);
		assert.deepEqual([step.goals[0].t, !!step.goals[0].optional], ['goto', false], `${guide}: a plain goto leads everyone to Alonso`);
		for (const q of chain) {
			assert.equal(list[at(list, `${guide}: accept ${q}`, is('accept', q))].goal.optional, true, `${guide}: accept ${q} is optional`);
			assert.ok(!list[at(list, `${guide}: turnin ${q}`, is('turnin', q))].goal.optional, `${guide}: turnin ${q} is plain`);
		}
		const pack = buildSimPack([guide]);
		try {
			const g = pack.guides[0];
			// offered: whether Alonso offers the chain. The game takes no accept
			// he does not offer; a player he offers them to takes each one the
			// guide shows (the simulated player leaves optional goals alone).
			const watch = (offered) => `
				local w, E = stub.world, Polestar.Engine
				local chain = { [78132] = true, [78133] = true, [78134] = true }
				local accept, view, turnIn = w.accept, E.GetStepView, w.turnIn
				local held, taking, reached = false, false, false
				w.accept = function(q, ...)
					if not ${offered} and chain[q] then return end
					return accept(q, ...)
				end
				-- Held: with 78132 taken, the step is still Alonso's when it is handed in.
				w.turnIn = function(q, ...)
					if q == 78132 then held = E.GetStepView(E.GetStepIndex()).title end
					return turnIn(q, ...)
				end
				E.GetStepView = function(...)
					local v = view(...)
					if v and v.title == "Alonso" and v.goals[1] and v.goals[1].status == "done" then reached = true end
					if ${offered} and not taking then
						taking = true
						for _, g in ipairs(v and v.goals or {}) do
							if g.t == "accept" and chain[g.quest] and (g.status == "pending" or g.status == "active") and not w.log[g.quest] and not C_QuestLog.IsQuestFlaggedCompleted(g.quest) then
								w.accept(g.quest, {}, g.title or "")
								stub.advance(0.6)
							end
						end
						taking = false
					end
					return v
				end
				${SIMULATE}
				local done = {}
				for _, q in ipairs({ 78132, 78133, 78134 }) do done[#done + 1] = C_QuestLog.IsQuestFlaggedCompleted(q) end
				emit({ done = done, held = held, reached = reached })`;
			for (const [cls, race, offered] of [['PALADIN', paladinRace, false], ['WARRIOR', warriorRace, true]]) {
				const who = `${guide}: a ${race} ${cls}${offered ? '' : ' Alonso offers nothing'}`;
				const [out, got] = playGuide(pack, g, { race, faction, cls, script: watch(offered) });
				assert.equal(out.stuck, undefined, `${who}: not stuck: ${JSON.stringify(out.stuck)}`);
				assert.ok(out.done, `${who}: plays to the end`);
				assert.equal(got.reached, true, `${who}: is led to Alonso`);
				assert.deepEqual(got.done, chain.map(() => offered), `${who}: the chain is ${offered ? '' : 'not '}handed in`);
				assert.equal(got.held, offered ? 'Alonso' : false, `${who}: ${offered ? 'held at Alonso until 78132 is handed in' : 'hands nothing in'}`);
			}
		} finally {
			pack.dispose();
		}
	}
});

// --- The Barrens (Fitz, #273): Savannah Lion Hides drop from the Patriarchs
// in the Dry Hills and from the Matriarchs by Ratchet, but the Sprung Traps
// the same step needs are all in the Dry Hills. The hide arrow stays there;
// the alternatives (alt) are only marked on the map, never picked by the arrow
// (a lone Patriarch spawns by Ratchet too), and never the Matriarchs.
test('forever/horde/04-the-barrens.guide: Fitz\'s report (#273): the Savannah Lion Hide arrow stays in the Dry Hills with the traps, never by Ratchet', { skip }, () => {
	const list = goals('forever/horde/04-the-barrens.guide');
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

test('forever/horde/04-the-barrens.guide: Fitz\'s report (#274): the Dry Hills step also collects the Raptor Horns, in the Dry Hills, before the Ratchet turn-in', { skip }, () => {
	const list = goals('forever/horde/04-the-barrens.guide');
	// The step where Vrang's harpy quest is worked in the Dry Hills (its title is the route's own).
	const hills = list.findIndex(({ goal }) => is('collect', 95494)(goal));
	assert.ok(hills >= 0, 'the Dry Hills step is in the guide');
	const horns = list.findIndex(({ s, goal }) => s === list[hills].s && is('collect', 865)(goal));
	assert.ok(horns >= 0, 'the Dry Hills step collects the Raptor Horns');
	const { goal } = list[horns];
	assert.equal(goal.item, 5055, 'Intact Raptor Horn');
	// The arrow's spots; the alternatives (alt) are only marked on the map.
	for (const p of [goal, ...(goal.spots || []).filter((spot) => !spot.alt)]) {
		assert.ok(p.x >= 40 && p.x <= 52 && p.y >= 10 && p.y <= 22, `the horns' arrow at ${p.x},${p.y} is in the Dry Hills`);
	}
	assert.ok(horns < at(list, 'the Raptor Horns turn-in', is('turnin', 865)), 'before the horns are handed in at Ratchet');
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

// Avtom (#280): "Kill Ribchaser (rare) or Redridge Brute for Iron Pike" led to
// the Redridge Mongrels' camp, where no Brute stands. Ribchaser, a rare, shares
// the Mongrels' spawn points and drops the quest's Iron Pike and Iron Rivet at
// 80%, the common Brutes, Mystics, Bashers and Drudgers at 65%: the highest
// chance put the rare first and the arrow led to its camp. A rare is passed
// over for the common droppers beside it, as elites are.

test(`${REDRIDGE}: Avtom's report (#280): Iron Pike and Iron Rivet lead to the gnolls that drop them, not to the rare Ribchaser's camp among the Mongrels`, { skip }, () => {
	const list = goals(REDRIDGE);
	const ribchaser = 14271;
	const camp = data.spawns('npc', ribchaser).filter((s) => s.map === 1433).flatMap((s) => s.pts);
	assert.ok(camp.length, 'Ribchaser spawns in Redridge Mountains');
	for (const item of [2856, 1013]) {
		const i = at(list, `item ${item}`, (g) => g.t === 'collect' && g.quest === 89 && g.item === item);
		const g = list[i].goal;
		assert.notEqual(g.from, 'Ribchaser', `item ${item} names a common dropper, not the rare`);
		assert.notEqual(g.fromAlso, 'Ribchaser');
		assert.equal(g.fromRank, undefined, `item ${item} names a common dropper (rank ${g.fromRank})`);
		const dropper = new Set(Object.keys(data.item(item).drops.npc).map(Number).filter((id) => id !== ribchaser));
		const spawns = [...dropper].flatMap((id) => data.spawns('npc', id).filter((s) => s.map === 1433).flatMap((s) => s.pts));
		const near = (a, pts, r) => pts.some(([x, y]) => yards({ map: 1433, x: a.x, y: a.y }, { map: 1433, x, y }) <= r);
		const points = [g, ...(g.spots || []).filter((s) => !s.alt)];
		for (const p of points) {
			assert.ok(!near(p, camp, 60), `item ${item}: ${p.x},${p.y} is in Ribchaser's camp`);
			assert.ok(near(p, spawns, 120), `item ${item}: ${p.x},${p.y} is by a common dropper`);
		}
	}
});

// --- Elemental Bracers (Tazul | Robin, #391): the step asked only for the
// Divined Scroll, which the Divining Scroll makes from five Intact Elemental
// Bracers. With no goal for the bracers, the target button had no elementals
// to target and the bracers were not counted. The bracer goal is optional:
// the Divined Scroll holds the step.

const ASHENVALE_ALLIANCE = 'forever/alliance/06-ashenvale.guide';

test(`Tazul's report: Elemental Bracers counts the five bracers before the Divined Scroll`, { skip }, () => {
	const list = goals(ASHENVALE_ALLIANCE);
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

// --- Battleworn Axe (Tazul, #286): the Redridge guide typed the orcs' camp at
// Alther's Mill as @55.9,43.6, a live-frame spot from the data, in a guide
// whose coordinates are Era-frame by default. Redridge's Forever map is
// shifted 5 units from Classic's, so the arrow led into the tarantulas in the
// middle of the mill, 68 yd west of the nearest orc. A typed coordinate on a
// goal the data can place is near one of its spawns in the frame it is
// compiled in, not only in the other one.
test("#286: a typed coordinate is near its target's spawns in its own map frame, not only in the other one", { skip }, () => {
	data = data || loadData(DATA);
	const { point } = makeProjector(data.mapFrames);
	const offenders = [];
	for (const guide of allGuides()) {
		const g = compiled(guide);
		g._ast.steps.forEach((as, si) => as.goals.forEach((ag, gi) => {
			const goal = g.steps[si] && g.steps[si].goals[gi];
			if (!ag.explicitCoords || !goal || goal.map == null || goal.x == null) return;
			const targets = [];
			if (goal.t === 'collect') {
				const item = data.item(goal.item);
				for (const id of Object.keys((item && item.drops && item.drops.npc) || {})) targets.push(['npc', id]);
				for (const id of Object.keys((item && item.drops && item.drops.object) || {})) targets.push(['object', id]);
			} else if (goal.npc) targets.push(['npc', goal.npc]);
			else if (goal.object) targets.push(['object', goal.object]);
			const pts = targets.flatMap(([kind, id]) => data.spawns(kind, Number(id)).filter((s) => s.map === goal.map).flatMap((s) => s.pts.map((p) => point(s.map, p[0], p[1], s.f))));
			if (!pts.length) return;
			const f = goal.f || 'l';
			const near = (q) => Math.min(...pts.map((p) => Math.hypot(p.wx - q.wx, p.wy - q.wy)));
			const own = near(point(goal.map, goal.x, goal.y, f));
			const other = near(point(goal.map, goal.x, goal.y, f === 'l' ? 'e' : 'l'));
			if (own > 40 && other < 10) offenders.push(`${guide}:${ag.line} ${goal.t} @${goal.x},${goal.y} (step ${g.steps[si].title}) is ${Math.round(own)} yd from its target in its ${f === 'l' ? 'live' : 'Era'} frame, ${Math.round(other)} yd in the other`);
		}));
	}
	assert.deepEqual(offenders, [], 'typed coordinates written in the other map frame');
});

// --- Raider's Bow (Lyngtoft, #289): the Durotar guide sent the arrow 124 yd
// south-west of the bow, to where QuestieDB 1.0.5 had it; 1.0.6 moved it to
// 59.4,56.4, where the player found it. A quest item that lies on the ground
// at a few fixed spots is collected where one of them is: the arrow leads
// within 1 map unit of its object's spawn, both points in the same map frame
// (Augustus' Receipt Book, #423: the Un'Goro guide's 17.4,31.1 is the Era
// frame's name for the spawn the data gives as 14.04,24.22 live).
const AWAY_FROM_ITS_OBJECTS = new Set([
	// Fish from pools: the schools drift along the shore, and the step points at a stretch of it.
	'forever/professions/fishing.guide 16968',
	'forever/professions/fishing.guide 16969',
	'forever/professions/fishing.guide 16970',
]);
test("#289: a quest item picked up from objects is collected at one of the objects' spawns", { skip }, () => {
	data = data || loadData(DATA);
	const { point } = makeProjector(data.mapFrames);
	const offenders = [];
	for (const guide of allGuides()) {
		for (const { step, goal } of goals(guide)) {
			if (goal.t !== 'collect' || goal.map == null || goal.x == null) continue;
			const item = data.item(goal.item);
			if (!item || !item.questItem || !item.drops) continue;
			const objects = Object.keys(item.drops.object || {});
			if (!objects.length || Object.keys(item.drops.npc || {}).length) continue;
			const pts = objects.flatMap((id) => data.spawns('object', Number(id)).filter((s) => s.map === goal.map).flatMap((s) => s.pts.map((p) => point(s.map, p[0], p[1], s.f))));
			if (!pts.length) continue;
			const near = Math.min(...[goal, ...(goal.spots || [])].flatMap((g) => {
				const q = point(goal.map, g.x, g.y, goal.f || 'l');
				return pts.map((p) => Math.hypot(p.x - q.x, p.y - q.y));
			}));
			if (near > 1 && !AWAY_FROM_ITS_OBJECTS.has(`${guide} ${goal.item}`)) offenders.push(`${guide} collect ${goal.item} @${goal.x},${goal.y} (step ${step.title}) is ${near.toFixed(2)} from its objects`);
		}
	}
	assert.deepEqual(offenders, [], 'quest items collected away from the objects that hold them');
});

// --- The Warsong Reports (Hotline, #278): the Warsong Scout, Runner and
// Outrider each give their update for a Warsong Report, which comes only out
// of the Bundle of Reports Kadrak hands out. The Kadrak step holds until a
// report is in the bags, so nobody reaches the scout with the bundle unopened.
// (Idea and test from PRDesrochers on #293.)

test('forever/horde/05-stonetalon-mountains.guide: Hotline\'s report (#278): the Bundle of Reports is opened at Kadrak, before the Warsong Scout', { skip }, () => {
	const guide = 'forever/horde/05-stonetalon-mountains.guide';
	const list = goals(guide);
	const reports = at(list, 'the Warsong Reports', (g) => g.t === 'collect' && g.item === 16746 && !g.quest);
	assert.equal(list[reports].goal.count || 1, 1, 'any report in the bags shows the bundle was opened');
	assert.equal(list[reports].step, list[at(list, 'accept 6543', is('accept', 6543))].step, 'opened on the Kadrak step');
	for (const update of [16764, 16765, 16763]) assert.ok(reports < at(list, `update ${update}`, (g) => g.t === 'collect' && g.item === update), `a report is in the bags before update ${update}`);
});

// --- "Ride through SW? (I am lvl 12)" (Pynte, #404): riding comes at level
// 40 (tools/lib/nav/move.js MOUNT_LEVEL), so a guide that starts below it
// never tells the player to ride somewhere. Riding a boat, zeppelin, tram,
// lift, airship, flight or Zephras Isle's wind currents is fine ("ride it"
// names the transport just before). A step gated to level 40 or more
// (`when level>=40`), or any step after a `level` goal of 40 or more, is
// played with riding learned, so it may say ride.
const RIDING_LEVEL = 40;
const RIDE_TRANSPORT = /\bride (?:it\b|(?:the |a |on the |up a |down the )?(?:boat|ferry|zeppelin|tram|Deeprun Tram|lift|elevator|airship|flight|hippogryph|gryphon|wind rider|wind current|bat|taxi))/gi;
test("Pynte's report (#404): guides played below riding level never tell you to ride somewhere", { skip }, () => {
	const offenders = [];
	for (const guide of allGuides()) {
		if (guide.startsWith('forever/collectibles/')) continue;
		const g = compiled(guide);
		if (!(g.minLevel < RIDING_LEVEL)) continue;
		let mounted = false;
		for (const step of g.steps) {
			const gated = (step.when || []).some((p) => p.k === 'level' && p.op === '>=' && !p.neg && p.n >= RIDING_LEVEL);
			if (!mounted && !gated) {
				for (const text of [step.note, ...step.goals.map((goal) => goal.note)]) {
					if (typeof text !== 'string') continue;
					if (/\b(?:ride|rides|riding|rode)\b/i.test(text.replace(RIDE_TRANSPORT, ''))) offenders.push(`${guide} (from level ${g.minLevel}), step ${step.title}: ${text}`);
				}
			}
			if (step.goals.some((goal) => goal.t === 'level' && goal.level >= RIDING_LEVEL)) mounted = true;
		}
	}
	assert.deepEqual(offenders, [], 'travel by riding in a guide played before level 40');
});

// --- Flight to Auberdine (Pynte, #402, #403): Vesprystus flies you to
// Auberdine for free once you have the quest ("speak with me again when you
// are ready to fly"), so the guide takes his flight, not the boat. Return to
// Nessa (6343) is taken from Laird and handed to Nessa in Rut'theran by every
// class (Druids on their own Rut'theran stop).
test(`${TELDRASSIL}: Pynte's report: Flight to Auberdine is flown with Vesprystus, not the boat, and Return to Nessa is handed in (#402, #403)`, { skip }, () => {
	for (const cls of ['WARRIOR', 'HUNTER', 'ROGUE', 'PRIEST', 'DRUID']) {
		const list = goals(TELDRASSIL).filter(forClass(cls));
		const take = at(list, 'accept 6342 (Flight to Auberdine)', is('accept', 6342));
		const travel = list.slice(take + 1).find(({ goal }) => ['goto', 'fly', 'hearth'].includes(goal.t));
		assert.ok(travel && travel.goal.t === 'fly' && travel.goal.location === 'Auberdine', `${cls}: the travel after accepting 6342 is the flight to Auberdine`);
		const give = at(list, 'turnin 6342 (Flight to Auberdine)', is('turnin', 6342));
		assert.ok(list.indexOf(travel) < give, `${cls}: 6342 is handed in after the flight`);
		assert.ok(!list.slice(take, give).some(({ goal }) => goal.t === 'goto'), `${cls}: no walk to a boat between taking 6342 and handing it in`);
		const back = at(list, 'accept 6343 (Return to Nessa)', is('accept', 6343));
		assert.ok(give < back, `${cls}: Return to Nessa is taken from Laird after 6342`);
		assert.ok(back < at(list, 'turnin 6343 (Return to Nessa)', is('turnin', 6343)), `${cls}: Return to Nessa is handed in`);
	}
});

// --- Gnoll Paws (Bashidian Twotao, #385): Westfall's Gnoll Paws had no
// point, so the arrow searched every camp of every Gnoll Paw dropper in the
// zone, down to the level 16-19 Bandits, Taskmasters and Mystics in the
// south. A quest item whose droppers span level bands is hand-placed on the
// low ones the step means: the arrow leads to a camp of droppers at most two
// levels above the quest, not a search over the whole zone. The same
// held for Westfall's north coast murlocs, Darkshore's crawlers and
// threshers below Auberdine, the Barrens' plainstriders by the Crossroads,
// Silverpine's worgs and Vile Fins by the Yoricks' house and Hillsbrad's
// bears and lions west of Tarren Mill.
const BY_LEVEL = [
	[WESTFALL, 725, 102],
	[WESTFALL, 254548, 92744],
	[WESTFALL, 730, 38],
	[DARKSHORE, 5385, 983],
	[DARKSHORE, 5412, 1001],
	['forever/horde/02-the-barrens.guide', 5087, 844],
	[SILVERPINE, 3164, 429],
	[SILVERPINE, 730, 91920],
	[HILLSBRAD_HORDE, 3476, 496],
	[HILLSBRAD_HORDE, 3496, 501],
];
test("Bashidian Twotao's report (#385): a quest drop from droppers of several level bands leads to the low ones' camp, not over the whole zone", { skip }, () => {
	data = data || loadData(DATA);
	for (const [guide, item, quest] of BY_LEVEL) {
		const { goal } = goals(guide)[at(goals(guide), `${guide} collect ${item}`, (g) => g.t === 'collect' && g.item === item && g.quest === quest)];
		const qlvl = data.quest(quest).level;
		const what = `${guide} collect ${item} (quest ${quest}, level ${qlvl})`;
		assert.ok(located({ goal }) && !goal.spread, `${what} has a point and is no zone-wide search`);
		const droppers = Object.keys(data.item(item).drops.npc).map((id) => data.npc(Number(id))).filter((n) => n && n.spawns && n.spawns[goal.map]);
		const here = droppers.filter((n) => n.spawns[goal.map].pts.some((p) => Math.hypot(p[0] - goal.x, p[1] - goal.y) < 3));
		assert.ok(here.length && here.every((n) => n.level <= qlvl + 2), `${what} leads to droppers at most two levels above the quest (${here.map((n) => `${n.name} ${n.level}`).join(', ')})`);
	}
	const paws = goals(WESTFALL).find(({ goal }) => goal.t === 'collect' && goal.item === 725).goal;
	assert.ok(paws.y < 35, `the Gnoll Paws lead into the north hills (${paws.x},${paws.y})`);
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
		const i = at(list, `accept ${q}`, is('accept', q));
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

// --- Handful of Oats (Xaden Ryan, #621): the oats were the first step's last
// goal, unplaced, so before Saldean's the arrow searched every Sack of Oats
// in the zone, down to Moonbrook, and the far sacks were empty. They are
// gathered on the return to the Jansen Stead, in its fields, beside the
// turn-in.
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

// --- Thendal Grove (Alx-Ryan, #363): the guide walked you to Rorian, up the
// watchtower a few steps from Elatrell, then floated you back down to Rorian.
// The tower comes first now: The Anchors of Zephras and Falling With Style
// (both need level 2 and nothing else), then the Walk on Air glide down to
// Rorian, who takes Harmony in Balance and Falling With Style on one visit.
// Falling With Style has no objectives: it is only handed in.

test(`Alx-Ryan's report (#363): on Zephras Isle, the watchtower quests come before Rorian, who takes Harmony in Balance and Falling With Style on one visit`, { skip }, () => {
	for (const guide of [ZEPHRAS_ALLIANCE, ZEPHRAS_HORDE]) {
		const list = goals(guide);
		const harmony = at(list, `${guide}: turnin 92461`, is('turnin', 92461));
		const falling = at(list, `${guide}: turnin 92474`, is('turnin', 92474));
		for (const quest of [94414, 92474]) assert.ok(at(list, `${guide}: accept ${quest}`, is('accept', quest)) < harmony, `${guide}: ${quest} is taken on the tower before Harmony in Balance is handed in`);
		assert.ok(at(list, `${guide}: turnin 94414`, is('turnin', 94414)) < harmony, `${guide}: The Anchors of Zephras is done before Rorian`);
		assert.equal(Math.abs(falling - harmony), 1, `${guide}: Harmony in Balance and Falling With Style are handed in one after the other`);
		assert.equal(list[falling].s, list[harmony].s, `${guide}: on the same step`);
		assert.equal(list[falling].goal.npc, list[harmony].goal.npc, `${guide}: to the same NPC, Rorian`);
		assert.deepEqual(list.filter(({ goal }) => goal.quest === 92474 && goal.t === 'complete').map(({ s }) => s), [], `${guide}: no complete goal for a quest with no objectives`);
	}
});

// --- The Broken Construct (𝔄𝔫𝔫𝔦𝔢, #285): the Horde Zephras Isle guide sent
// you for the Air Construct Core and the Crystallized Lightning, but never for
// the Enchanted Gyrozephyr (93737.3), which lies only south-west of Windsong
// Lake: one objective was lost when the route's `complete` was split into a
// goal per objective. Every objective of a quest handed in on Zephras Isle has
// its goal (or a `complete` for the whole quest) before the turn-in.
// Traditions of the Bluff's Prepared Incense is made from the four parts
// bought just before and used up on Hunter Rise, so it is never in the bags
// at the turn-in.
const COVERED_ELSEWHERE = new Set(['97485.1']);

test(`𝔄𝔫𝔫𝔦𝔢's report (#285): on Zephras Isle, every objective of a quest is sent for before its turn-in; the Enchanted Gyrozephyr at its spawns`, { skip }, () => {
	data = data || loadData(DATA);
	for (const guide of [ZEPHRAS_ALLIANCE, ZEPHRAS_HORDE]) {
		const list = goals(guide);
		list.forEach(({ goal }, i) => {
			if (goal.t !== 'turnin') return;
			const q = data.quest(goal.quest);
			if (!q || !q.objectives || !q.objectives.length) return;
			const before = list.slice(0, i).filter(({ goal: g }) => g.quest === goal.quest && g.t !== 'accept' && g.t !== 'turnin');
			if (before.some(({ goal: g }) => g.t === 'complete' && !g.oi)) return;
			const missing = q.objectives.map((_, k) => k + 1).filter((oi) => !COVERED_ELSEWHERE.has(`${goal.quest}.${oi}`) && !before.some(({ goal: g }) => g.oi === oi));
			assert.deepEqual(missing, [], `${guide}: ${goal.quest} (${q.title}) is handed in with objectives never sent for`);
		});
	}
	const list = goals(ZEPHRAS_HORDE);
	const gyro = at(list, 'collect 260883', (g) => g.t === 'collect' && g.item === 260883 && g.quest === 93737);
	assert.ok(gyro < at(list, 'turnin 93737', is('turnin', 93737)), 'before Riaani takes the quest');
	const spawns = data.spawns('object', 616466).find((x) => x.map === 2521).pts;
	assert.ok(spawns.some(([x, y]) => close(list[gyro].goal, { map: 2521, x, y }, 1)), `the arrow's point ${list[gyro].goal.x},${list[gyro].goal.y} is at a gyrozephyr`);
});

// --- The Wounds of Betrayal (Phear, #395): the Alliance Zephras Isle guide
// wrote it as a bare `complete`, which has no place, so the step had no arrow
// into the Nightfang Den; the Horde guide points at the druids and Jorel.
// Standing Our Ground was the same. Each objective of these quests is its own
// goal with a place, before the turn-in, in both guides.

test(`Phear's report (#395): on Zephras Isle, The Wounds of Betrayal and Standing Our Ground lead to each objective, in both guides`, { skip }, () => {
	data = data || loadData(DATA);
	for (const guide of [ZEPHRAS_ALLIANCE, ZEPHRAS_HORDE]) {
		const list = goals(guide);
		for (const quest of [94489, 92693]) {
			const take = at(list, `${guide}: accept ${quest}`, is('accept', quest));
			const give = at(list, `${guide}: turnin ${quest}`, is('turnin', quest));
			const between = list.slice(take + 1, give).filter(({ goal }) => goal.quest === quest);
			assert.deepEqual(between.filter((x) => !located(x)).map(({ goal }) => goal.t), [], `${guide}: every goal of ${quest} has a place for the arrow`);
			const objectives = data.quest(quest).objectives.map((_, i) => i + 1);
			assert.deepEqual(objectives.filter((oi) => !between.some(({ goal }) => goal.oi === oi)), [], `${guide}: every objective of ${quest} has its goal before the turn-in`);
		}
	}
});

// --- Battleworn Axe (Tazul | Robin, #340): the axes were collected east of
// Alther's Mill, about ten normal Blackrock spawns that Tazul found too few
// and too slow to respawn. The camps at the south end of Galardell Valley,
// east of Stonewatch Keep, hold some forty, with no elite among them. The
// arrow leads there, on the way south-east from the mill, not to the mill.
// Galardell Valley's own gnolls (Solomon's Law, Fangore) are out of the route
// since #979: 22-26 at about 21 (#977).
test(`${REDRIDGE}: Tazul's report (#340): the Battleworn Axes lead to the Blackrock camps east of Stonewatch Keep, not to Alther's Mill`, { skip }, () => {
	data = data || loadData(DATA);
	const { point } = makeProjector(data.mapFrames);
	const list = goals(REDRIDGE);
	const axes = at(list, 'Battleworn Axe', (g) => g.t === 'collect' && g.item === 3014);
	const { goal } = list[axes];
	assert.ok(at(list, "Alther's Mill tarantulas", is('kill', 98386)) < axes, "after Alther's Mill, on the way south-east");
	assert.ok(!list.some(({ goal: g }) => [91, 180].includes(g.quest)), 'Galardell Valley (Solomon\'s Law, Fangore) is out of the route');
	assert.match(fs.readFileSync(path.join(OFFICIAL_DIR, REDRIDGE), 'utf8'), /^# Left out for the level \(.*\): .*Solomon's Law \(91\).*Lieutenant Fangore \(180\)/m, 'the header says why');
	const here = point(goal.map, goal.x, goal.y, goal.f || 'l');
	const near = { normal: 0, elite: 0 };
	for (const id of Object.keys(data.item(3014).drops.npc)) {
		const npc = data.npc(Number(id));
		for (const s of data.spawns('npc', Number(id)).filter((sp) => sp.map === goal.map)) {
			for (const p of s.pts) {
				const q = point(s.map, p[0], p[1], s.f);
				if (Math.hypot(q.wx - here.wx, q.wy - here.wy) < 150) near[npc && npc.rank ? 'elite' : 'normal']++;
			}
		}
	}
	assert.equal(near.elite, 0, 'no elite axe carrier within 150 yd of the arrow');
	assert.ok(near.normal >= 20, `at least 20 normal axe carriers within 150 yd (${near.normal})`);
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

// --- Hearts of the Lovers (Phyz, #412): QuestieDB lists only Isaac's Heart,
// so the Ratchet step read the quest log's first line, which is Avelina's
// Heart, and passed as soon as the Silverpine heart was in the bags.
// Forever's quest data lists Avelina's Heart first, then Isaac's Heart
// (corrections.json 65593). With that correction applied, as `data build`
// does, each heart's goal reads its own line.
test("forever/class/warlock/incubus-horde.guide: Phyz's report (#412): Avelina's and Isaac's hearts each read their own line of Hearts of the Lovers", { skip }, () => {
	const corrected = loadData(DATA);
	const fix = loadCorrections().quests['65593'];
	assert.ok(fix, 'the corrections correct 65593');
	Object.assign(corrected.quest(65593), fix.set);
	const file = path.join(OFFICIAL_DIR, 'forever/class/warlock/incubus-horde.guide');
	const { guides } = compileSources([{ file, text: fs.readFileSync(file, 'utf8') }], corrected);
	const list = guides[0].steps.flatMap((step) => step.goals);
	const heart = (item) => list.find((g) => g.t === 'collect' && g.quest === 65593 && g.item === item);
	assert.deepEqual(corrected.quest(65593).objectives.map((o) => o.id), [190179, 190180], "Avelina's Heart is the first objective, Isaac's the second");
	assert.equal(heart(190179).oi, 1, "Avelina's Heart reads line 1");
	assert.equal(heart(190180).oi, 2, "Isaac's Heart reads line 2");
});

// --- Making Do (Nittepitte, #453): Baros Alexston offers Making Do only to a
// player who handed him Expanding Horizons (97914), taken at the end of
// Darkshore. The project data has no prerequisite for it, and the sources
// disagree, so the accept and its turn-in in Ashenvale are optional: a
// player without Expanding Horizons is not held at Baros or Thundris.
test(`Nittepitte's report (#453): Making Do is optional in Redridge and Ashenvale, and taken only after Expanding Horizons is handed in`, { skip }, () => {
	const list = goals(REDRIDGE);
	const take = at(list, 'accept 97926', is('accept', 97926));
	assert.ok(list[take].goal.optional, 'accept 97926 is optional');
	assert.ok(at(list, 'turnin 97914', is('turnin', 97914)) < take, 'Expanding Horizons is handed in first');
	const ashenvale = goals('forever/alliance/06-ashenvale.guide');
	assert.ok(ashenvale[at(ashenvale, 'turnin 97926', is('turnin', 97926))].goal.optional, 'turnin 97926 is optional');
});

// Ioney (#524): "quest not available from Tarrel Rockweaver until completing
// 'Unrequited Love' first, which was in the questlog from earlier." Hollee's
// note (98461, Forever) is handed to Tarrel before he gives In Search of the
// Excavation Team (305); both are optional, so a player without the note is
// not held.

test(`${ASHENVALE}: Ioney's report (#524): Unrequited Love is handed to Tarrel Rockweaver before In Search of the Excavation Team, and taken in Auberdine before the boat`, { skip }, () => {
	// Hollee's note is taken in Auberdine on the Darkshore guide and carried through Redridge and
	// Duskwood to Menethil: the list is the chain from Darkshore.
	const list = ['03-darkshore', '04-redridge-mountains', '05-duskwood', '06-ashenvale'].flatMap((g) => goals(`forever/alliance/${g}.guide`));
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

test(`${ASHENVALE}: Ioney's report (#617): the grind to 28 comes after the Menethil hand-ins, before Pilot Longbeard`, { skip }, () => {
	const list = goals(ASHENVALE);
	const grind = at(list, 'level 28', (g) => g.t === 'level' && g.level === 28);
	for (const quest of [306, 484, 470, 98282]) {
		assert.ok(at(list, `turnin ${quest}`, is('turnin', quest)) < grind, `the Menethil hand-in ${quest} counts towards 28`);
	}
	assert.ok(grind < at(list, 'accept 1179', is('accept', 1179)), 'level 28 before Pilot Longbeard');
});

// Pynte (#327): "Timberling Seeds quest points me to the north of Teldrassil
// instead of just around the quest giver." XrayAlpha's diagnosis: QuestieDB's
// server drop table gives the Elder Timberling (level 10) 100% for the seed and
// the Timberlings round Denalan (level 5) 37%, so only the Elder counted as
// likely and the arrow went 1,400 yards north. A dropper 3 or more levels above
// the quest no longer sets the likely-dropper bar where it would crowd out the
// ones near the quest's level (resolve.js, levelSplit). The Southsea Kidnapper
// stood alone on Pirate Hats Ahoy! with pfQuest's 50% against 10% for the other
// pirates; it does not drop the hat (corrections.json removeDrops). Both tests
// are XrayAlpha's.

test(`${TELDRASSIL}: Pynte's report (#327): the Timberling Seed arrow stays round Denalan with the Timberlings, not with the Elder Timberlings in the north`, { skip }, () => {
	const list = goals(TELDRASSIL);
	const { goal } = list[at(list, 'the Timberling Seed collect', (g) => g.t === 'collect' && g.quest === 918 && g.item === 5168)];
	const ids = (goal.fromNpcs || []).map((n) => n.npc);
	assert.notEqual(goal.from, 'Elder Timberling', 'the goal names the Timberlings, not the Elder');
	assert.ok(ids.includes(2022), `the Timberlings (2022) are among the droppers (${ids.join(', ')})`);
	assert.ok(!ids.includes(2030), 'the Elder Timberling (2030) is not');
	const denalan = { map: 1438, x: 60.9, y: 68.49 };
	assert.ok(yards(goal, denalan) <= 150, `the arrow at ${goal.x},${goal.y} is by Denalan, not ${Math.round(yards(goal, denalan))} yd off`);
});

// --- Teldrassil (#555): Soft Saber Pelts (87288) accepted from Aldia on first Dolanaar
// stop so both Nightsaber quests are done in one east loop
test(`${TELDRASSIL}: #555: Soft Saber Pelts accept comes before Zenn's Bidding turn-in, so both Nightsaber quests share the first east loop`, { skip }, () => {
	const list = goals(TELDRASSIL);
	const accept87288 = list.find(({ goal }) => goal.t === 'accept' && goal.quest === 87288);
	const turnin488 = list.find(({ goal }) => goal.t === 'turnin' && goal.quest === 488);
	assert.ok(accept87288, 'accept 87288 is in the guide');
	assert.ok(accept87288.s < turnin488.s, 'accept 87288 (Soft Saber Pelts) comes before turnin 488 (Zenn\'s Bidding), not after it');
	// Both collect goals are in the same step
	const coll488 = list.find(({ goal }) => goal.t === 'collect' && goal.quest === 488 && goal.item === 3409);
	const coll87288 = list.find(({ goal }) => goal.t === 'collect' && goal.quest === 87288);
	assert.ok(coll87288, 'collect 280087 quest 87288.1 is in the guide');
	assert.equal(coll488.s, coll87288.s, 'Nightsaber Fang (488.1) and Nightsaber Pelt (87288.1) are in the same step');
});

// --- Teldrassil (#619): Ferocitas drops the Gnarlpine Necklace, and Tallonkai's
// Jewel is only in the bags once the necklace is opened.
test(`${TELDRASSIL}: #619: the Gnarlpine Necklace is looted from Ferocitas before the jewel is collected`, { skip }, () => {
	const list = goals(TELDRASSIL);
	const necklace = at(list, 'collect 8049 (Gnarlpine Necklace)', (g) => g.t === 'collect' && g.item === 8049 && !g.quest);
	const jewel = at(list, 'collect 8050 quest 2459 (Tallonkai\'s Jewel)', (g) => g.t === 'collect' && g.item === 8050 && g.quest === 2459);
	assert.ok(necklace < jewel, 'the necklace comes before the jewel');
	assert.equal(list[necklace].s, list[jewel].s, 'on the Ferocitas step');
	assert.ok(located(list[necklace]), 'the arrow leads to Ferocitas for the necklace');
});

test('#327: Pirate Hats Ahoy! names every pirate that drops the hat, not the Southsea Kidnapper alone, in both guides', { skip }, () => {
	for (const guide of [TANARIS_ALLIANCE, 'forever/horde/40-50/02-feralas.guide']) {
		const list = goals(guide);
		const { goal } = list[at(list, `${guide}: the Southsea Pirate Hat collect`, (g) => g.t === 'collect' && g.quest === 8365 && g.item === 20519)];
		const ids = (goal.fromNpcs || []).map((n) => n.npc);
		for (const pirate of [7855, 7856, 7857, 7858]) assert.ok(ids.includes(pirate), `${guide}: pirate ${pirate} is among the droppers (${ids.join(', ')})`);
		assert.notEqual(goal.from, 'Southsea Kidnapper', `${guide}: the goal does not send the player after the Kidnapper alone`);
	}
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

// dgc1980 (#563), Alliance: on Cozy Sleeping Bag's Stonetalon step the arrow
// pointed straight from the Barrens (1413 42.08,32.49) at the path into the
// Stonetalon hills, a line through Honor's Stand, the Horde post on the road
// west. Alliance now go by the reporter's safe spot north of it
// (40.20,24.88; 1413's Era and live frames are the same). The post is the
// shipped walking maps' hostile hub, so the straight arrow of every leg, from
// the report's spot to the safe spot and on to the path, keeps out of it.

test("forever/miscellaneous/cozy-sleeping-bag.guide: dgc1980's report (#563): Alliance go round Honor's Stand on the way to Stonetalon, Horde go straight", { skip }, () => {
	const list = goals('forever/miscellaneous/cozy-sleeping-bag.guide');
	const hills = at(list, 'the path into the hills', (g) => g.t === 'goto' && g.map === 1442);
	const step = list[hills].s;
	const before = list.filter(({ s, goal }, i) => s === step && i < hills && goal.t === 'goto');
	const alliance = before.filter(({ goal }) => !goal.only || (goal.only.factions || []).includes('Alliance'));
	const horde = before.filter(({ goal }) => !goal.only || (goal.only.factions || []).includes('Horde'));
	const [hubs] = runAddon({
		stubs: ['stub_encoding.lua'],
		addons: ['Polestar_Nav'],
		script: `
local out = {}
for _, h in ipairs(PolestarPathData[1].hubs) do
	if h.id == "horde-honors-stand" then
		for i, d in ipairs(h.disks) do out[i] = { d[1], d[2], d[3] } end
	end
end
emit(out)`,
	}).emitted;
	assert.ok(hubs.length > 0, "the walking maps know Honor's Stand");
	// A map point in the world frame the maps use: x north, y west.
	const world = ({ map, x, y }) => {
		const f = data.eraFrame(map);
		return { x: f.top + ((f.bottom - f.top) * y) / 100, y: f.left + ((f.right - f.left) * x) / 100 };
	};
	// How far (yd) the line from a to b stays outside the hub's disks.
	const clear = (a, b) => {
		const [p, q] = [world(a), world(b)];
		const dx = q.x - p.x;
		const dy = q.y - p.y;
		const l2 = dx * dx + dy * dy;
		return Math.min(...hubs.map(([x, y, r]) => {
			const t = Math.max(0, Math.min(1, ((x - p.x) * dx + (y - p.y) * dy) / l2));
			return Math.hypot(p.x + dx * t - x, p.y + dy * t - y) - r;
		}));
	};
	const stops = [{ map: 1413, x: 42.08, y: 32.49 }, ...alliance.map(({ goal }) => goal), list[hills].goal];
	for (let i = 1; i < stops.length; i++) {
		const [a, b] = [stops[i - 1], stops[i]];
		const off = clear(a, b);
		assert.ok(off > 50, `the arrow from ${a.x},${a.y} to ${b.x},${b.y} (map ${b.map}) passes ${Math.round(off)} yd outside Honor's Stand`);
	}
	assert.equal(alliance.length, 1, 'Alliance get one waypoint before the path');
	assert.ok(yards(alliance[0].goal, { map: 1413, x: 40.2, y: 24.88 }) <= 30, "it is the reporter's safe spot");
	assert.equal(horde.length, 0, 'Horde get none');
});

// Syrael (#575): "Collect the ghost plasma is in the wrong spot, it shows the
// same spot as for the collect the kodo bone quest above it." The Horde guide
// had a bare `complete 6134` in the Kodo Graveyard step, so it had no place
// and the step showed the bones' point; the Magrami Spectres the Crate of
// Ghost Magnets draws are in the Valley of Bones, where the report finished
// the quest (63.77,91.60). The ghosts now come on the Mannoroc Coven trip,
// and Hornizz is handed the plasm afterwards.

test('forever/horde/30-40/04-dustwallow-marsh.guide: Syrael\'s report (#575): the ghost-o-plasm points at the Valley of Bones, after the Kodo Graveyard', { skip }, () => {
	const list = goals('forever/horde/30-40/04-dustwallow-marsh.guide');
	const plasm = at(list, 'collect 15849 (Ghost-o-plasm)', (g) => g.t === 'collect' && g.quest === 6134 && g.item === 15849);
	const { goal } = list[plasm];
	const finished = { map: 1443, x: 63.77, y: 91.6 };
	assert.equal(goal.map, 1443, 'the goal is on Desolace');
	assert.ok(yards(goal, finished) <= 200, `the arrow at ${goal.x},${goal.y} is in the Valley of Bones, not ${Math.round(yards(goal, finished))} yd off`);
	assert.ok(at(list, 'collect 13703 (Kodo Bone)', (g) => g.t === 'collect' && g.quest === 5501) < plasm, 'the kodo bones come first');
	assert.ok(plasm < at(list, 'turnin 6134', is('turnin', 6134)), 'the plasm is collected before Hornizz is handed it');
});

test("forever/professions: Schpune's report (#620): Skinning, Mining and Herbalism are learned at level 1, from the Junior trainers in the starting zones too", { skip: skip || needs('professions.json') }, () => {
	// Junior trainers in Northshire Valley and The Den, by profession guide.
	const juniors = { skinning: [247227, 267327], mining: [247226, 267328], herbalism: [247223, 267329] };
	for (const [file, npcs] of Object.entries(juniors)) {
		const guide = `forever/professions/${file}.guide`;
		const learn = compiled(guide).steps[0];
		assert.match(learn.title, /^Learn /, `${guide}: the first step learns the profession`);
		assert.ok(!learn.goals.some((g) => g.t === 'level'), `${guide}: no level goal before Apprentice`);
		const train = learn.goals.find((g) => g.t === 'train');
		assert.equal(train.rank, 1, `${guide}: Apprentice`);
		const ids = train.candidates.map((c) => c.npc);
		for (const npc of npcs) assert.ok(ids.includes(npc), `${guide}: Junior trainer ${npc} is a candidate`);
	}
});

// Nittepitte (#613): "Since Collecting Kelp starts an RP events, it should be
// suggested to be turned in [...] before turning in Baited for Success."
// Handing in Collecting Kelp (112) starts William Pestle's brewing scene before
// he offers The Escape (114); cmangos classic-db's quest-end script runs it
// for 5 seconds. Helene and Jason stand on the lake shore on the way in, so
// they stay first, and Marshal Dughan's turn-ins, a few yards from William,
// fill the wait.

test(`${ELWYNN}: Nittepitte's report (#613): Marshal Dughan's turn-ins come between Collecting Kelp and The Escape, while William Pestle brews`, { skip }, () => {
	const list = goals(ELWYNN);
	const kelp = at(list, 'turnin 112', is('turnin', 112));
	const escape = at(list, 'accept 114', is('accept', 114));
	const dughan = at(list, 'turnin 39', is('turnin', 39));
	assert.ok(at(list, 'turnin 99131', is('turnin', 99131)) < kelp, 'Baited for Success is handed to Jason on the way in');
	assert.ok(kelp < dughan && dughan < escape, 'Collecting Kelp, then Dughan, then The Escape');
	assert.equal(list[kelp].s, list[escape].s, 'all in the same Goldshire step');
});

// Nittepitte (#612): "it should tell you to pick up Mining Tools while
// discovering the Jasperlode Mine." The step led to the mine's far end first,
// then out to the Kobold Geomancers, and only then back in for the Mining
// Tools, which lie along the tunnel from the entrance. The tools now come
// first, on the walk in; the geomancers on the way out.

test(`${ELWYNN}: Nittepitte's report (#612): the Mining Tools are picked up on the walk into the Jasperlode Mine, before its far end`, { skip }, () => {
	const list = goals(ELWYNN);
	const tools = at(list, 'collect 247816', (g) => g.t === 'collect' && g.item === 247816 && g.quest === 91732);
	const explore = at(list, 'complete 76', is('complete', 76));
	const geomancers = at(list, 'kill 476', is('kill', 91723));
	assert.equal(list[tools].s, list[explore].s, 'one step in the mine');
	assert.ok(tools < explore && explore < geomancers, 'the tools, then the far end, then the geomancers');
	const entrance = list.slice(0, tools).reverse().find(({ goal }) => goal.t === 'goto');
	assert.ok(entrance, 'the step before is the walk to the entrance');
	const spots = list[tools].goal.spots || [list[tools].goal];
	for (const s of spots) {
		assert.ok(yards(entrance.goal, { map: list[tools].goal.map, ...s }) < yards(entrance.goal, list[explore].goal), `the tools at ${s.x},${s.y} lie between the entrance and the far end`);
	}
});

test(`${ASHENVALE}: #424: the Horn of Awakening is taken from Kerlonian's Chest at the Grove, before the escort`, { skip }, () => {
	const list = goals(ASHENVALE);
	const horn = at(list, 'collect 13536 quest 5321 (Horn of Awakening)', (g) => g.t === 'collect' && g.item === 13536 && g.quest === 5321);
	const turnin = at(list, 'turnin 5321', is('turnin', 5321));
	assert.ok(horn < turnin, 'the horn comes before the hand-in at Maestra\'s Post');
	assert.ok(located(list[horn]), 'the arrow leads to the chest');
	assert.equal(list[horn].goal.map, 1439, 'the chest is at the Grove of the Ancients in Darkshore');
});

// Fyurie (#920): The Sleeper Has Awakened (5321) was taken from Kerlonian
// Evershade on the Darkshore visit at about 19, but his escort waits for the
// Ashenvale guide at about 26, so players carried a timed escort for hours.
// The Horn of Awakening lasts 25 minutes (item 13536, duration 1500 s). The
// quest is taken from Kerlonian in the Ashenvale guide's Grove step, right
// before his chest and the escort, and no step waits for it in the log first.
test(`${ASHENVALE}: Fyurie's report (#920): The Sleeper Has Awakened is taken from Kerlonian right before his chest and the escort, not on the Darkshore visit`, { skip }, () => {
	assert.ok(!goals(DARKSHORE).some(({ goal }) => goal.quest === 5321), 'the Darkshore visit leaves Kerlonian alone');
	const list = goals(ASHENVALE);
	const accept = at(list, 'accept 5321 (Kerlonian Evershade)', is('accept', 5321));
	const horn = at(list, 'collect 13536 quest 5321 (Horn of Awakening)', (g) => g.t === 'collect' && g.item === 13536 && g.quest === 5321);
	const turnin = at(list, 'turnin 5321', is('turnin', 5321));
	assert.equal(list[accept].s, list[horn].s, 'the accept and the chest are one step at the Grove');
	assert.ok(accept < horn && horn < turnin, 'accept, chest, then the hand-in at Maestra\'s Post');
	assert.ok(!(list[accept].step.when || []).some((p) => p.k === 'onquest' && [].concat(p.q).includes(5321)), 'the step does not wait for 5321 in the quest log');
	assert.equal(list[accept].goal.npc, 11218, 'from Kerlonian Evershade');
});

// A bare `complete` that opens its step has no place of its own and nothing
// placed before it, so the arrow showed nothing until the quest was done
// (#303's leftovers; #632 and #646 place the Horde ones). Each now leads to
// its objective: the bears, the Faulk brothers (their `use` of the Symbol of
// Life since #956). Wandering Shay (2845, Rockbiter's camp) is out of the route
// since #979: Shay wanders among the level 49 harpies, at about 44 (#977).
test('Alliance: a quest objective that opens its step leads the arrow to the objective (#303 leftovers)', { skip }, () => {
	data = data || loadData(DATA);
	const feralas = 'forever/alliance/40-50/03-feralas.guide';
	assert.ok(!goals(feralas).some(({ goal }) => goal.quest === 2845 || goal.quest === 2844), 'Wandering Shay and The Giant Guardian are out of Feralas');
	assert.match(fs.readFileSync(path.join(OFFICIAL_DIR, feralas), 'utf8'), /^# Left out: .*The Giant Guardian \(2844\), Wandering Shay \(2845\)/m, 'the header names them');
	assert.ok(JSON.parse(fs.readFileSync(path.join(__dirname, '..', 'data', 'route-fixes.json'), 'utf8')).overrides.skip.some((s) => s.q === 2845 && /harpies/.test(s.reason)), 'the route fixes skip Wandering Shay, saying why');
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
			? data.npcs[target.npc].spawns[goal.map].pts.map(([x, y]) => ({ map: goal.map, x, y }))
			: data.quests[target.event].objectives.filter((o) => o.type === 'event').map((o) => ({ map: o.map, x: o.x, y: o.y }));
		const near = Math.min(...places.map((p) => yards(goal, p)));
		assert.ok(near < 30, `${file}: ${goal.t} ${quest} leads to its objective (${near.toFixed(0)} yd away)`);
	}
});

// A bare `complete` gave the window no target, spawn area or progress for a
// quest whose objective is a plain one (#956). The Tome of Divinity's
// objective is a kill credit for using the Symbol of Life on Henze Faulk: the
// step uses it on him, tracked from the quest log, and never reads "Kill".
// The Northern Pylon is an object to click.
test(`${REDRIDGE}: the Henze Faulk step tracks 1786.1 with an objective goal, not \`complete\` (#956)`, { skip }, () => {
	const list = goals(REDRIDGE);
	assert.ok(!list.some(({ goal }) => is('complete', 1786)(goal)), 'no bare complete 1786');
	const i = at(list, 'use 6866 quest 1786.1', (g) => g.t === 'use' && g.quest === 1786 && g.oi === 1);
	assert.equal(list[i].step.title, 'Henze Faulk');
	assert.equal(list[i].goal.item, 6866, 'the Symbol of Life');
	const paladin = { race: 'Human', raceName: 'Human', faction: 'Alliance', cls: 'PALADIN', className: 'Paladin', level: 12 };
	const line = (fulfilled) => stepView(REDRIDGE, paladin, list[i].s, `w.onQuest(1786, { { required = 1, fulfilled = ${fulfilled} } })`).goals.find((g) => g.quest === 1786 && g.t === 'use');
	assert.ok(!/\bKill\b/.test(line(0).text), `"${line(0).text}" does not read Kill`);
	assert.notEqual(line(0).status, 'done', 'open while the quest log has Henze to do');
	assert.equal(line(1).status, 'done', 'done once the quest log counts him');
	for (const guide of [UN_GORO_ALLIANCE, 'forever/horde/50-60/01-un-goro-crater.guide']) {
		const pylon = goals(guide);
		assert.ok(!pylon.some(({ goal }) => is('complete', 4285)(goal)), `${guide}: no bare complete 4285`);
		const { goal } = pylon[at(pylon, 'interact 164955 quest 4285.1', (g) => g.t === 'interact' && g.quest === 4285 && g.oi === 1)];
		assert.equal(goal.object, 164955, `${guide}: the Northern Crystal Pylon`);
	}
});

// --- Cozy Sleeping Bag (Hotline, #698): every quest of the chain needs level
// 14, and a level 13 Horde Paladin was sent to the Barrens for a note it could
// not take yet. Polestar holds back only Class guides at their gate by itself,
// so the guide waits for the level before each faction sets out.
test(`Hotline's report (#698): the Cozy Sleeping Bag chain waits for level 14 before either faction sets out`, { skip }, () => {
	const list = goals('forever/miscellaneous/cozy-sleeping-bag.guide');
	for (const faction of ['Alliance', 'Horde']) {
		const mine = list.filter(({ step, goal }) => [step.only, goal.only].every((o) => !o || !o.factions || o.factions.includes(faction)));
		let reached = 1;
		let accepts = 0;
		for (const { goal } of mine) {
			if (goal.t === 'level') reached = Math.max(reached, goal.level);
			if (goal.t !== 'accept') continue;
			accepts++;
			assert.ok((goal.minLevel || 1) <= reached, `${faction}: accept ${goal.quest} (from level ${goal.minLevel}) comes after the guide waits for that level`);
			reached = Math.max(reached, goal.minLevel || 1);
		}
		assert.ok(accepts > 0, `${faction}: the chain is offered`);
		assert.ok(reached >= 14, `${faction}: the chain's level 14 is reached before it starts`);
	}
});

// --- The Quarry's Smith (TP1186, #727): Frast Dokner asks for 12 Copper
// Bars, then 4 Toughened Boar Hides. The merged data kept only the hides,
// so `quest 95217.1` tracked the hides against the Copper Bars line
// (corrections.json 95217 restores both, as `data build` applies it).
for (const DUN_MOROGH of DUN_MOROGHS) test(`${DUN_MOROGH}: TP1186's report (#727): the Toughened Boar Hides read their own line of The Quarry's Smith, not the Copper Bars`, { skip }, () => {
	const corrected = loadData(DATA);
	const fix = loadCorrections().quests['95217'];
	assert.ok(fix, 'the corrections correct 95217');
	Object.assign(corrected.quest(95217), fix.set);
	const file = path.join(OFFICIAL_DIR, DUN_MOROGH);
	const { guides } = compileSources([{ file, text: fs.readFileSync(file, 'utf8') }], corrected);
	const hides = guides[0].steps.flatMap((step) => step.goals).find((g) => g.t === 'collect' && g.item === 267416);
	assert.deepEqual(corrected.quest(95217).objectives.map((o) => o.id), [2840, 267416], 'Copper Bars first, the hides second');
	assert.equal(hides.quest, 95217);
	assert.equal(hides.oi, 2, 'the hides read line 2');
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
	const darkshore = goals(DARKSHORE);
	const cat = at(darkshore, 'turnin 98397', is('turnin', 98397));
	assert.ok(!darkshore.slice(0, cat).some(({ goal }) => goal.t === 'goto' && /Boat to Stormwind/.test(goal.text)), 'no boat to Stormwind before Cat Form');
});

// --- mariusch's elite blocks (#639): the optional elites of the start zones
// and the Barrens are asked (`when group`), accept to turn-in, not offered
// to a solo player as bare optional goals.
test("mariusch's report (#639): Vulgara, Aggor the Young and Bruuz are asked as group quests, every goal of them", { skip }, () => {
	for (const [guide, quest] of [
		[ZEPHRAS_ALLIANCE, 93318],
		[ZEPHRAS_HORDE, 93318],
		...DUROTARS.map((guide) => [guide, 99052]),
		[BARRENS, 92706],
	]) {
		const mine = goals(guide).filter(({ goal }) => goal.quest === quest);
		assert.deepEqual([...new Set(mine.map(({ goal }) => goal.t))].sort(), ['accept', 'collect', 'turnin'], `${guide}: ${quest} accepted, done and handed in`);
		for (const { step, goal } of mine) {
			assert.ok((step.when || []).some((p) => p.k === 'group' && p.q === quest && !p.neg), `${guide}: ${goal.t} ${quest} is under when group ${quest}`);
		}
	}
});

test(`Hotline's report (#718): the Undead's Silverpine fishing step leads to Lordamere Lake, not the Great Sea coast`, { skip }, () => {
	const list = goals('forever/professions/fishing.guide');
	const arrow = list.find(({ step, goal }) => step.title === 'Fishing: Silverpine Forest (50-125)' && goal.t === 'goto');
	assert.ok(arrow, 'the Silverpine step has a waypoint');
	const { point } = makeProjector(data.mapFrames);
	const [x, y] = data.npcs[6570].spawns[1421].pts[0];
	const ferry = point(1421, x, y, data.npcs[6570].spawns[1421].f);
	assert.ok(dist(point(arrow.goal.map, arrow.goal.x, arrow.goal.y, arrow.goal.f || 'l'), ferry) < 80, 'within 80 yards of Fenwick Thatros at the Decrepit Ferry on the lake');
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

// --- Snowiee's report (#912): the Night Elves' Goldshire training stop has no
// Druid trainer, so the Druids walked from Stormwind Harbor to Goldshire, back
// to Stormwind to train and back to Goldshire. A class the stop cannot train
// trains in the town the way to it passes, a few hundred yards from its
// trainer, before the way leaves that town: the Druids in Stormwind, the
// Paladins of the Felwood stop in Brill before the zeppelin to Orgrimmar.
test("Snowiee's report (#912): a class the training stop cannot train trains in the town the way passes with its trainer, before leaving it", { skip }, () => {
	for (const [guide, cls, after, before] of [
		['forever/alliance/nightelf/02-darkshore.guide', 'DRUID', (g) => g.t === 'getfp' && g.location === 'Stormwind', (g) => g.t === 'goto' && g.text === 'Elwynn Forest'],
		['forever/horde/50-60/02-felwood.guide', 'PALADIN', (g) => g.t === 'goto' && g.text === 'Tirisfal Glades', (g) => g.t === 'goto' && g.text === 'Zeppelin to Orgrimmar'],
	]) {
		const mine = goals(guide).filter(forClass(cls));
		const into = at(mine, `${guide}: the way into town`, after);
		const train = mine.findIndex(({ goal }, i) => i > into && goal.t === 'train' && goal.class);
		assert.ok(train >= 0, `${guide}: the ${cls}s train after the way reaches the town`);
		assert.ok(train < at(mine, `${guide}: the way out of town`, before), `${guide}: the ${cls}s train before the way leaves the town`);
	}
});

// Erá's report (#948): Arantir offers no Horns of Nez'ra (2358) after Alther's
// Mill; the quest is not in the game on Forever. The Rogue's Certificate of
// Thievery ends when Lucius takes the token back.
test("Erá's report (#948): the Rogue's Certificate of Thievery ends at Lucius, with no Horns of Nez'ra", { skip }, () => {
	const list = goals('forever/class/rogue/certificate-of-thievery.guide');
	assert.equal(list.findIndex(({ goal }) => goal.quest === 2358), -1, 'no goal for Horns of Nez\'ra');
	assert.ok(is('turnin', 2282)(list[list.length - 1].goal), 'the guide ends with Alther\'s Mill handed in to Lucius');
});

// --- Found by Fitz (2026-11-06): after the Moonglade quests (Umber's Under the
// Chitin Was..., 1185) the Silithus guide hearthed everyone to Cenarion Hold, flew
// them to Rut'theran Village and sent them back into Moonglade for Nighthaven's
// flight path, 600 yards from Umber. The flight path comes straight after Umber,
// with no hearth or flight between, and its flight is the way on: straight to
// Rut'theran Village, so neither the flight path's step nor Erelas Ambersky's
// hand-in (4901) sends the player by Auberdine (its old way, the boat from there).
test("Fitz's find (2026-11-06): after the Moonglade quests the Silithus guide takes Nighthaven's flight path without leaving Moonglade first", { skip }, () => {
	const guide = 'forever/alliance/50-60/06-silithus.guide';
	const list = goals(guide);
	const umber = at(list, `${guide}: Umber's hand-in of 1185`, is('turnin', 1185));
	const fp = list.findIndex(({ goal }, i) => i > umber && goal.t === 'getfp' && goal.location === 'Moonglade');
	assert.ok(fp > umber, `${guide}: Nighthaven's flight path is learned after Umber`);
	for (const { goal, step } of list.slice(umber + 1, fp)) {
		assert.ok(goal.t !== 'hearth' && goal.t !== 'fly', `${guide}: "${step.title}" ${goal.t}s out of Moonglade before its flight path`);
		assert.ok(goal.map == null || goal.map === 1450, `${guide}: "${step.title}" leads to map ${goal.map}, not Moonglade`);
	}
	const hand = at(list, `${guide}: Erelas Ambersky's hand-in of 4901`, is('turnin', 4901));
	assert.ok(hand > fp, `${guide}: Rut'theran Village comes after Nighthaven's flight path`);
	for (const { step } of [list[fp], list[hand]]) {
		const tip = [].concat(step.note || []).join(' ');
		assert.doesNotMatch(tip, /Auberdine/, `${guide}: "${step.title}" tip: ${tip}`);
	}
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
	const { point } = makeProjector(data.mapFrames);
	const crabs = Object.keys(data.items[12237].drops.npc).flatMap((npc) => {
		const sp = data.npcs[npc].spawns[1439];
		return sp ? sp.pts.map(([x, y]) => point(1439, x, y, sp.f)) : [];
	});
	const here = steps[falls].goals.filter((g) => located({ goal: g }) && g !== goal);
	const nearest = Math.min(...here.flatMap((g) => crabs.map((c) => dist(point(g.map, g.x, g.y, g.f || 'l'), c))));
	assert.ok(nearest <= 200, `Cliffspring Falls is ${Math.round(nearest)} yd from the nearest crab that drops the chunks`);
});

// --- Flight path sweep from #939 (the route walked past a flight master without learning its path,
// then needed it): the shared Alliance route boards the Booty Bay boat at Ratchet's dock at 40, about
// 100 yards from Bragok, and v1 learns Ratchet's flight path there; the route did not, so at 44 the
// Gnome Warlocks' Felsteed trip could not fly from Theramore to Strahad Farsan in Ratchet and walked
// there instead. The Gnome Warlocks learn the path at the dock and fly.
test("Flight path sweep (#939): Gnome Warlocks learn Ratchet's flight path at the Booty Bay boat and fly from Theramore to Strahad Farsan", { skip }, () => {
	const forGnome = ({ step, goal }) => [step.only, goal.only].every((o) => !o || !o.races || o.races.includes('Gnome'));
	const list = ['forever/alliance/40-50/01-stranglethorn-vale.guide', 'forever/alliance/40-50/02-badlands.guide']
		.flatMap((g) => goals(g))
		.filter(forGnome)
		.filter(forClass('WARLOCK'));
	const felsteed = at(list, "Strahad Farsan's hand-in of 4488", is('turnin', 4488));
	const fp = list.findIndex(({ goal }) => goal.t === 'getfp' && goal.location === 'Ratchet');
	const fly = list.findIndex(({ goal }, i) => i < felsteed && goal.t === 'fly' && goal.location === 'Ratchet');
	assert.ok(fp >= 0, "Ratchet's flight path is learned before 40-50/02-badlands");
	assert.ok(fp < fly, "the flight to Ratchet for Strahad Farsan comes after its flight path");
	const walks = list.slice(fp + 1, felsteed).filter(({ goal }) => goal.t === 'goto' && goal.text === 'Ratchet');
	assert.deepEqual(walks.map(({ step }) => step.title), [], 'no walk to Ratchet for the Felsteed');
});

// #960, after #941: the givers the data puts on an upper floor (spawn heights from classic-db and
// the Forever server agree; the walking grid has a floor under them and the ground floor below).
// The arrow has no height, so every step at one of them says to go up, in a goal note or the tip.
// #961 (Verium, Human Mage): the first `train class` in Northshire led a Mage to the Abbey's ground
// floor under Khelden Bremen. A `train class` step whose nearest trainer for a class (to the step's
// other goals) stands upstairs says so too.
test('Upper-floor givers (#960, #961): every step at one says to go up, train-class steps included', { skip: skip || needs('spawnz.json') }, () => {
	const givers = {
		2104: 'Stoutfist', 4964: 'Samaul', 7879: 'Quintis', 2316: "Gol'dir", 2501: 'MacKinley', 3391: 'Gazlowe',
		377: 'Josetta', 328: 'Zaldimar', 198: 'Khelden', 7880: 'Ginro', 7907: 'Daryn', 2107: 'Gaerolas',
		11802: 'Dendrite', 15189: 'Beetix', 15190: 'Noggle', 5394: 'Neeka', 14736: 'Primal Torntusk',
		// Class trainers: Goldshire's inn, Brill's inn, the ramps of Aldrassil.
		917: 'Keryn Sylvius', 2128: 'Cain Firesong', 2129: 'Beryl', 2127: 'Rupert Boch', 2130: 'Marion Call',
		3593: 'Alyissia', 3594: 'Frahun Shadewhisper', 3595: 'Shanda', 3596: 'Ayanna Everstride', 3597: 'Mardant Strongoak',
	};
	const near = (a, b) => {
		const f = a.map === b.map && (a.f || 'l') === (b.f || 'l') && data.eraFrame(a.map);
		return f ? Math.hypot(((f.right - f.left) * (a.x - b.x)) / 100, ((f.bottom - f.top) * (a.y - b.y)) / 100) : Infinity;
	};
	const up = /\b(upstairs|top floor|upper level|second level|on top of)\b/i;
	const said = (step, npc) => {
		const key = givers[npc];
		const sentences = [].concat(step.note || []).join(' ').split(/(?<=\.)\s+/);
		const he = /^(He|Dendrite) stands upstairs/;
		return step.goals.some((g) => g.npc === npc && up.test(g.note || '')) || sentences.some((s) => up.test(s) && (s.includes(key) || (he.test(s) && sentences.join(' ').includes(key))));
	};
	const missing = [];
	let seen = 0;
	for (const guide of allGuides()) {
		for (const step of compiled(guide).steps) {
			if (step.along) continue;
			const atNpc = new Set(step.goals.filter((g) => (g.t === 'accept' || g.t === 'turnin') && givers[g.npc]).map((g) => g.npc));
			// The trainer each class walks to: the nearest candidate to the step's other goals, within 120 yd.
			const here = step.goals.filter((g) => g.t !== 'train' && g.map != null && g.x != null);
			for (const g of step.goals.filter((g) => g.t === 'train' && g.class && here.length)) {
				const byClass = new Map();
				for (const c of g.candidates || []) {
					const d = Math.min(...here.map((h) => near(h, c)));
					for (const cls of c.classes || []) if (!byClass.has(cls) || d < byClass.get(cls).d) byClass.set(cls, { npc: c.npc, d });
				}
				for (const { npc, d } of byClass.values()) if (d <= 120 && givers[npc]) atNpc.add(npc);
			}
			for (const npc of atNpc) {
				seen++;
				if (!said(step, npc)) missing.push(`${guide}: step "${step.title}" at ${givers[npc]}`);
			}
		}
	}
	assert.ok(seen > 50, `the givers' steps are found (${seen})`);
	assert.deepEqual(missing, []);
});

// --- Travel follow-ups of the flight path sweep (#964).
const forRaceOf = (race) => ({ step, goal }) => [step.only, goal.only].every((o) => !o || !o.races || o.races.includes(race));

// The Tauren and Skyborne Druids took the zeppelin to Orgrimmar for their Thunder Bluff training at 16,
// then walked about 2,400 yards to Ratchet's flight master and back to the zeppelin afterwards, though
// Doras stands about 480 yards from the zeppelin. They learn Orgrimmar's flight path off the zeppelin,
// fly from it to Thunder Bluff and back to it.
test('Flight path sweep (#964): Silverpine Druids learn Orgrimmar off the zeppelin and fly from it, not from Ratchet', { skip }, () => {
	for (const race of ['Tauren', 'Skyborne']) {
		const list = goals('forever/horde/03-silverpine-forest.guide').filter(forRaceOf(race)).filter(forClass('DRUID'));
		const zep = at(list, `${race}: the zeppelin to Orgrimmar`, (g) => g.t === 'goto' && g.text === 'Zeppelin to Orgrimmar');
		// (The guide opens with everyone's Undercity zeppelin from Durotar: the one after the trip.)
		const back = list.findIndex(({ goal }, i) => i > zep && goal.t === 'goto' && goal.text === 'Zeppelin to Undercity');
		assert.ok(back > zep, `${race}: the zeppelin back to the Undercity after the trip`);
		const trip = list.slice(zep, back).map(({ goal }) => goal);
		const fp = trip.findIndex((g) => g.t === 'getfp' && g.location === 'Orgrimmar');
		const out = trip.findIndex((g) => g.t === 'fly' && g.location === 'Thunder Bluff');
		assert.ok(fp >= 0 && fp < out, `${race}: Orgrimmar's flight path is learned before the flight to Thunder Bluff`);
		assert.ok(trip.slice(out).some((g) => g.t === 'fly' && g.location === 'Orgrimmar'), `${race}: the way back flies to Orgrimmar for the zeppelin`);
		assert.deepEqual(trip.filter((g) => /Ratchet/.test(`${g.location || ''} ${g.text || ''}`)).map((g) => g.t), [], `${race}: no walk to or flight from Ratchet`);
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

// Flow audit, Horde Ashenvale & Thousand Needles: Stonetalon Standstill's elementals and gazebo are in Mystral
// Lake, where the walk hunts Tideress, but the guide came back to the lake after Shadumbra (1,475 yd from
// Splintertree, 23 min later). Shamans filled Brine's waterskin by walking from Alonso back to the Zoram'gar
// flight master (2,666 yd) and on to the Ruins of Stardust fountain (2,496 yd), beside Ursangous; and they
// handed it to Brine on a flight from Freewind Post to Camp Taurajo and back, although the walk from Camp
// Taurajo down to the Great Lift passes his hut.
test(`${ASHENVALE_HORDE}: Stonetalon Standstill with Tideress at Mystral Lake; the Shaman's waterskin beside Ursangous and to Brine on the road to the Great Lift`, { skip }, () => {
	const list = goals(ASHENVALE_HORDE);
	const tideress = at(list, 'accept 1918 (The Befouled Element)', is('accept', 1918));
	const lake = at(list, 'the Befouled Water Elementals (25)', (g) => g.quest === 25 && g.t === 'kill');
	assert.ok(lake > tideress && lake < at(list, 'the Foulweald banner (6621)', (g) => g.quest === 6621 && g.t === 'use'), 'the elementals right after Tideress, before the Foulweald');
	const shaman = list.filter(forRaceOf('Orc')).filter(forClass('SHAMAN'));
	const fountain = at(shaman, 'the fountain (1534)', (g) => g.quest === 1534 && g.t === 'collect');
	assert.ok(fountain < at(shaman, 'Ursangous\'s paw (23)', is('accept', 23)), 'the fountain before Ursangous, in his ruins');
	assert.deepEqual(shaman.slice(fountain, at(shaman, 'accept 1918', is('accept', 1918))).filter(({ goal }) => goal.t === 'goto' && goal.x != null && goal.x < 20).map(({ s }) => s), [], 'no walk back to Zoram\'gar for the fountain');
	const brine = at(shaman, 'turnin 1534 (Call of Water)', is('turnin', 1534));
	assert.ok(brine < at(shaman, 'accept 4767 (Wind Rider)', is('accept', 4767)), 'Brine before Freewind Post');
	assert.equal(shaman.filter(({ goal }) => goal.t === 'fly' && goal.location === 'Camp Taurajo').length, 2, 'two flights to Camp Taurajo (from Zoram\'gar and Thunder Bluff), none from Freewind Post');
});

// The same pattern at Orgrimmar: the Warriors' (and the other classes') training step flew them to
// Orgrimmar from Orgrimmar's flight master, after the Crossroads flight there (Stonetalon) or the walk
// there from Boulder Lode Mine (the Barrens). They train where they stand.
test('Flight path sweep (#964): the Orgrimmar training steps of the Barrens and Stonetalon do not fly to Orgrimmar from Orgrimmar', { skip }, () => {
	for (const [file, race] of [['forever/horde/04-the-barrens.guide', 'Tauren'], ['forever/horde/04-the-barrens.guide', 'Orc'], [STONETALON, 'Undead']]) {
		const list = goals(file).filter(forRaceOf(race)).filter(forClass('WARRIOR'));
		const train = list.findIndex(({ goal, step }) => goal.t === 'train' && !goal.npc && step.title === 'Orgrimmar');
		assert.ok(train > 0, `${file} ${race}: the Orgrimmar training`);
		const last = list.slice(0, train + 1).reverse().find(({ goal }) => ['fly', 'goto'].includes(goal.t));
		assert.ok(last && (last.goal.t === 'fly' ? last.goal.location === 'Orgrimmar' && last.s < list[train].s : last.goal.map === 1454), `${file} ${race}: they reach Orgrimmar before the training step, which flies nowhere`);
	}
});

// The Gnomes', Night Elves' and Skyborne's flight from Booty Bay to Darkshire was written before their
// own boat from Ratchet: Warriors, Mages, Warlocks and Druids were sent to Booty Bay's flight master
// from the Barrens. Every race's boat comes first.
test('Flight path sweep (#964): Stranglethorn 40: every race and class takes the Booty Bay boat before the flight to Darkshire', { skip }, () => {
	for (const race of ['Dwarf', 'Gnome', 'NightElf', 'Skyborne']) {
		for (const cls of ['WARRIOR', 'PALADIN', 'HUNTER', 'ROGUE', 'PRIEST', 'SHAMAN', 'MAGE', 'WARLOCK', 'DRUID']) {
			const list = goals('forever/alliance/40-50/01-stranglethorn-vale.guide').filter(forRaceOf(race)).filter(forClass(cls));
			const fly = list.findIndex(({ goal }) => goal.t === 'fly' && goal.location === 'Darkshire');
			if (fly < 0) continue;
			const boat = list.findIndex(({ goal }) => goal.t === 'goto' && goal.text === 'Boat to Booty Bay');
			assert.ok(boat >= 0 && boat < fly, `${race} ${cls}: the boat to Booty Bay comes before the flight to Darkshire`);
		}
	}
});

// --- Flight path sweep (#964), travel tips: tips kept from the seed sent players on
// flights they can't take where they stand: from a flight master in another zone, or
// to or from a flight path no chain of that side has learned by then (Ratchet and
// Talonbranch Glade for the Alliance at those levels, Zoram'gar, Undercity and Tarren
// Mill for the Horde, Stormwind for Humans in Westfall). Each tip now names the way
// the guide goes. Read from the guide files: a step is found by a line it holds.
test('flight path sweep (#972): travel tips name only flights the player can take there', () => {
	const cases = [
		['alliance/40-50/07-un-goro-crater', 'accept 4504', /From Ratchet/],
		['alliance/50-60/02-felwood', 'turnin 5156', /Talonbranch/],
		['alliance/50-60/03-winterspring', 'turnin 6028', /Timbermaw|Auberdine/],
		['alliance/50-60/04-western-plaguelands', 'turnin 5158', /^Fly to Ratchet/],
		['alliance/50-60/05-silithus', 'turnin 4502', /Cenarion Hold/],
		['alliance/40-50/02-badlands', 'turnin 4488', /^Fly to Ratchet|Fly back to Theramore/],
		['alliance/02-westfall', 'accept 1638', /Fly or walk/],
		['alliance/02-westfall', 'turnin 94774', /Fly or walk/],
		['alliance/02-westfall', 'train class only Warrior,Paladin,Hunter,Rogue,Priest,Mage,Warlock,Druid', /Fly or walk/],
		['horde/05-stonetalon-mountains', 'accept 6462', /Fly from Ratchet/],
		['horde/05-stonetalon-mountains', 'accept 95883', /Tarren Mill flight path|fly from the Undercity/],
		['horde/06-hillsbrad-foothills', 'accept 4542', /Fly from Thunder Bluff/],
		['horde/07-ashenvale', 'turnin 1534', /Fly from Thunder Bluff/],
		['horde/40-50/06-azshara', 'goto 32.2,27.7 "Grom\'gol Base Camp"', /Valormok/],
		['horde/40-50/02-feralas', 'Alodan the Hopeful (Paladins). Fly there', /from Orgrimmar/],
		['horde/30-40/01-desolace', 'only Druid\n  zone Thunder Bluff', /from Shadowprey/],
		['horde/50-60/05-eastern-plaguelands', 'train class only Druid,Paladin', /Fly to the Undercity/],
	];
	for (const [guide, anchor, wrong] of cases) {
		const text = fs.readFileSync(path.join(__dirname, '..', 'guides', 'forever', `${guide}.guide`), 'utf8');
		const steps = text.split('\nstep ').filter((s) => anchor.split('|').some((a) => s.includes(a)));
		assert.ok(steps.length > 0, `${guide}: a step with "${anchor}"`);
		for (const s of steps) {
			const tip = (s.match(/^\s+tip (.*)$/m) || [])[1] || '';
			assert.doesNotMatch(tip, wrong, `${guide}, step "${s.split('\n')[0]}": tip "${tip}"`);
		}
	}
});

// --- Fyurie's report (#977, Discord): Redridge "suddenly jumped from level 20/21 mobs to Fangore
// and a bunch of 24-25 mobs". The route took WANTED: Lieutenant Fangore (180, Fangore 26) and
// Solomon's Law (91) in Galardell Valley, whose Shadowhide gnolls are a median 24 (22-26), at the
// model's 21.4, and Bellygrub (34, level 24) at 20.3; the Old Lion Statue of A Watchful Eye (94) and
// Looking Further (248) stands among the same gnolls. The writer's level fit (docs/forge/writer.md,
// "Work at the player's level") leaves out work more than two levels above the player when the route
// never comes back to it at a level that fits; the statue's quests are route-fixes skips.
const LEVEL_FIT = [
	// [guide, quests left out, npcs no goal may send the player to]
	['forever/alliance/04-redridge-mountains.guide', [34, 91, 180, 94, 248], [345, 703, 429, 431, 432, 433, 434, 568, 579]],
	['forever/alliance/07-thousand-needles.guide', [1105, 1175, 1176], [4147, 4150, 4151]],
	['forever/horde/07-ashenvale.guide', [1105, 1175, 1176], [4147, 4150, 4151]],
	['forever/alliance/40-50/03-feralas.guide', [2844, 2845], [7774]],
	['forever/horde/50-60/01-un-goro-crater.guide', [5509], []],
];
for (const [guide, gone, mobs] of LEVEL_FIT) {
	test(`Fyurie's report (#977): ${guide.replace(/^forever\//, '')} sends nobody to work far above their level`, { skip }, () => {
		for (const { step, goal } of goals(guide)) {
			assert.ok(!gone.includes(goal.quest), `${guide}: "${step.title}" ${goal.t} ${goal.quest} is left out for the level`);
			assert.ok(!mobs.includes(goal.npc), `${guide}: "${step.title}" ${goal.t} targets npc ${goal.npc}`);
			const from = goal.fromNpcs || [];
			assert.ok(!(from.length && from.every((n) => mobs.includes(n.npc))), `${guide}: "${step.title}" ${goal.t} ${goal.item} drops only from ${from.map((n) => n.npcName).join(', ')}`);
		}
		if (guide.includes('redridge')) {
			assert.ok(!goals(guide).some(({ goal }) => goal.object === 31), 'no goal at the Old Lion Statue in Galardell Valley');
		}
	});
}

test("Recordings (#977): Croaky's Head, a level 11 elite's drop, is collected only by players grouping for it, not in Elwynn's step for everyone", { skip }, () => {
	// 12 recorded deaths to Croaky at levels 8-9 with the optional head in the solo step.
	const list = goals('forever/alliance/human/01-elwynn-forest.guide');
	const heads = list.filter(({ goal }) => goal.t === 'collect' && goal.item === 247826);
	assert.ok(heads.length > 0, "the head is still collected by groups");
	for (const { step } of heads) {
		assert.ok([].concat(step.when || []).some((w) => w.k === 'group'), `"${step.title}" collects the head without asking for a group`);
	}
});

test('Level fit (#977): the Rogues\' Venture Co. tower (drones 25, Gallywix a 23 elite) shows from level 23, not at the route\'s 20', { skip }, () => {
	const list = goals('forever/horde/04-the-barrens.guide');
	const work = list.filter(({ goal }) => goal.quest === 2478 && ['kill', 'collect'].includes(goal.t));
	assert.ok(work.length > 0, 'the tower work is in the guide');
	for (const { step } of work) {
		assert.ok([].concat(step.when || []).some((w) => w.k === 'level' && w.op === '>=' && w.n >= 23), `"${step.title}" shows before level 23`);
	}
});

test("Snowiee's report (#1003): the Great Cat Spirit's accepts and turn-ins point to where it stands in Moonglade, by the bridge", { skip }, () => {
	// Recorded hand-ins of 98394 and 98396 at Moonglade 54.30,75.01 and 54.69,75.01; the reporter stood
	// by it at 54.60,75.07. The merged data had 58.39,73.52, about 90 yards east.
	const spirit = { map: 1450, x: 54.5, y: 75 };
	const spawn = (loadCorrections().npcs[11957] || {}).addSpawns;
	assert.deepEqual(spawn && spawn[spirit.map].pts, [[spirit.x, spirit.y]], 'the correction places the spirit');
	// The generated guides keep the point through a build from data/places.json (giver and ender of each quest).
	const { places } = JSON.parse(fs.readFileSync(path.join(__dirname, '..', 'data', 'places.json'), 'utf8'));
	for (const [quest, objective] of [[98394, 'ender'], [98396, 'giver'], [98396, 'ender'], [98731, 'giver'], [98405, 'ender'], [98342, 'giver'], [98342, 'ender'], [98739, 'giver']]) {
		const rec = places.find((p) => p.quest === quest && p.objective === objective);
		assert.deepEqual(rec && rec.at, { ...spirit, frame: 'era' }, `data/places.json places the ${objective} of ${quest}`);
	}
	for (const guide of ['forever/class/druid/cat-form.guide', 'forever/alliance/03-darkshore.guide', 'forever/horde/04-the-barrens.guide']) {
		const list = goals(guide).filter(({ goal }) => goal.npc === 11957 && ['accept', 'turnin'].includes(goal.t));
		assert.ok(list.length >= 4, `${guide}: the spirit's goals are in the guide`);
		for (const { goal } of list) {
			assert.deepEqual({ map: goal.map, x: goal.x, y: goal.y }, spirit, `${guide}: ${goal.t} ${goal.quest}`);
		}
	}
});

// Bill (#1004): at Ratchet the guide sent you up to the inn to bind, then back
// to Mebok Mizzyrix, who stands by the WANTED poster you had just read. The
// bind comes after the givers next to the ones before it; the same sweep found
// the inn wedged between two goals at one NPC at the Crossroads (Mankrik), Sun
// Rock (Maggran Earthbinder) and Tarren Mill (Apothecary Lydon).
test("Bill's report (#1004): a town's bind never sends you back to the giver you just left", { skip }, () => {
	for (const [guide, place, before] of [
		['forever/horde/02-the-barrens.guide', 'Ratchet', [865]],
		['forever/horde/02-the-barrens.guide', 'The Crossroads', [4921, 899]],
		['forever/horde/05-stonetalon-mountains.guide', 'Sun Rock Retreat', [86576, 5881]],
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

// #1024 (Pilk, Tauren Druid): Apothecary Zamah's arrow led up out of the Pools of Vision, the cave under
// Spirit Rise in Thunder Bluff. The NPCs down there (spawn heights 97 to 112; Spirit Rise above them at about
// 135-138): every step at one says so, since the arrow cannot tell the floors apart. Birgitte Cranston's tip
// had her "with the mage trainers on Spirit Rise".
test('Pools of Vision NPCs (#1024): every step at one says they stand down in the cave under Spirit Rise', { skip: skip || needs('spawnz.json') }, () => {
	const below = {
		3419: 'Apothecary Zamah', 3044: 'Miles Welsh', 3045: 'Malakai Cross', 3046: 'Father Cobb', 3047: 'Archmage Shymm',
		3048: 'Ursyn Ghull', 3049: 'Thurston Xane', 5543: 'Clarice Foster', 5957: 'Birgitte Cranston',
	};
	const down = /\b(Pools of Vision|cave under Spirit Rise)\b/;
	const missing = [];
	let seen = 0;
	for (const guide of allGuides()) {
		for (const step of compiled(guide).steps) {
			const at = step.goals.filter((g) => ['accept', 'turnin', 'talk', 'train'].includes(g.t) && below[g.npc]);
			if (at.length === 0) continue;
			seen++;
			const text = [].concat(step.note || [], at.map((g) => g.note || '')).join(' ');
			if (!down.test(text)) missing.push(`${guide}: step "${step.title}" at ${below[at[0].npc]}`);
			if (/\bon Spirit Rise\b/.test(text)) missing.push(`${guide}: step "${step.title}" puts ${below[at[0].npc]} on Spirit Rise`);
		}
	}
	assert.ok(seen >= 3, `the steps at them are found (${seen})`);
	assert.deepEqual(missing, []);
});
