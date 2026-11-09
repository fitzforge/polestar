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
const { compileSources, compileProject, OFFICIAL_DIR } = require('../tools/lib/dsl/project');
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
	const list = goals(STONETALON);
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
	// The Warsong Reports (6543) is left out since the final route review (route-fixes skip); holds if a build takes it.
	if (!list.some(({ goal }) => goal.quest === 6543)) return;
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

// Flow audit, Troll Durotar (#1077): the Troll guide went on to the Crossroads (Meats to Orgrimmar,
// Crossroads Conscription, the flight path), then walked 2,490 yd back to Razor Hill to hand Threat from
// Below to Orgnil, and the Barrens guide walked 2,197 yd back to the Crossroads for the five quests the
// player had stood next to. Razor Hill comes on the walk from Margoz to Far Watch Post, as in Orc's guide;
// both races hand Crossroads Conscription to Sergra on the Barrens guide's first stop, with the five quests.
for (const DUROTAR of DUROTARS) test(`${DUROTAR}: Threat from Below is handed in at Razor Hill on the way to Far Watch Post, and the Crossroads waits for the Barrens guide`, { skip }, () => {
	const list = goals(DUROTAR);
	const threat = at(list, 'the Threat from Below turn-in', is('turnin', 99051));
	// Horde 12-30 re-chain: Durotar ends in Orgrimmar. Since the final route review (0.3.5) Conscript of the Horde is
	// handed to Kargal at Far Watch Post before Orgrimmar (no carry through Silverpine), after Orgnil.
	const mage = list.filter(forClass('MAGE'));
	assert.ok(at(mage, 'turnin 840', is('turnin', 840)) > at(mage, 'turnin 99051', is('turnin', 99051)), 'Kargal after Orgnil (Shamans hand it in on the way to Kranal)');
	const orgnil = list[threat].goal.npc;
	assert.deepEqual(list.slice(threat + 1).filter(({ goal }) => goal.npc === orgnil && !goal.optional && !is('turnin', 99051)(goal)).map(({ goal }) => `${goal.t} ${goal.quest}`), [], 'nothing sends you back to Orgnil afterwards');
	assert.deepEqual(list.filter(({ goal }) => goal.quest === 6365 || is('turnin', 842)(goal) || goal.t === 'getfp').map(({ goal }) => `${goal.t} ${goal.quest || goal.location}`), [], 'the Crossroads stop is the Barrens guide\'s');
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

// --- Timed-quest sweep (2026-11-08): Iverron's Antidote (3522) lasts five minutes. It was taken from Dirania at the foot of
// Aldrassil before Tenaron's turn-in at the top, the moonwell and the climb back to Tenaron; players' recordings show 2 timer
// fails and 4 abandons among 24 characters. It is taken on the way down after Crown of the Earth (921), in the hand-in's step.
test(`${TELDRASSIL}: Iverron's Antidote is taken after the last Tenaron visit and carried straight to Iverron`, { skip }, () => {
	const list = goals(TELDRASSIL);
	const take = at(list, 'accept 3522 (Iverron\'s Antidote)', is('accept', 3522));
	const hand = at(list, 'turnin 3522', is('turnin', 3522));
	assert.ok(at(list, 'turnin 921 (Crown of the Earth)', is('turnin', 921)) < take, 'the antidote is taken after the last climb to Tenaron');
	assert.equal(list[take].s, list[hand].s, 'taken in the step that hands it in');
	assert.deepEqual(list.slice(take + 1, hand).map(({ goal }) => `${goal.t} ${goal.quest}`), [], 'nothing between the accept and the hand-in');
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
	['forever/horde/30-40/04-dustwallow-marsh.guide', 1218, 3713, 3, 'H', 'the Soothing Spices for "Swamp Eye" Jarl, bought in Orgrimmar at the start of the Dustwallow guide'],
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

// --- Flow audit (2026-11-07): Dun Morogh's quarry was stopped at up to six
// times (each of Those Blasted Troggs!, the powder keg, the powder, the smith's
// hides and The Public Servant handed in on a stop of its own), with the
// Bonesnappers listed along the way though they share the quarry with the
// Skullthumpers; Kharanos was entered four times in a row for Senir, the malt,
// Tognus, the malt again and the cooking lesson; Razzle's cogs were listed along
// the whole walk west and twice more. Now the quarry troggs are one step,
// Foreman Stonebrow, Senator Mehr and Thesten take their quests on the first
// return before Helm's Bed Lake, Kharanos is one stop with one malt, and the
// cogs are collected with the Leper Gnomes.
for (const DUN_MOROGH of DUN_MOROGHS) test(`${DUN_MOROGH}: flow audit: the quarry troggs in one step and handed in on the first return, Kharanos once, no along lists for the cogs or the Bonesnappers`, { skip }, () => {
	const list = goals(DUN_MOROGH);
	const skull = at(list, 'kill 1115 (Skullthumpers)', (g) => g.t === 'kill' && g.quest === 432);
	const bone = at(list, 'kill 1117 (Bonesnappers)', (g) => g.t === 'kill' && g.quest === 433);
	assert.equal(list[bone].step, list[skull].step, 'the Bonesnappers with the Skullthumpers');
	const t432 = at(list, 'turnin 432', is('turnin', 432));
	assert.equal(list[at(list, 'turnin 433', is('turnin', 433))].step, list[t432].step, 'Stonebrow and Mehr on one stop');
	assert.ok(t432 < at(list, 'the Stolen Blasting Powder', (g) => g.t === 'collect' && g.item === 267415), 'before the powder');
	assert.ok(t432 < at(list, 'kill 6123 (Dark Iron Spies)', (g) => g.t === 'kill' && g.quest === 96390), 'before the spies');
	assert.equal(list.filter(({ goal }) => goal.t === 'buy' && goal.item === 2894).length, 1, 'one Rhapsody Malt');
	const senir = at(list, 'turnin 98323', is('turnin', 98323));
	assert.equal(list[senir].step, list[at(list, 'accept 287', is('accept', 287))].step, 'Senir once: Secure the Mountain in, Frostmane Hold out');
	const { steps } = compiled(DUN_MOROGH);
	assert.deepEqual(steps.filter((st) => st.along && st.goals.some((g) => [412, 433].includes(g.quest))).map((st) => st.title), [], 'no along list for the cogs or the Bonesnappers');
	assert.equal(list.filter(({ goal }) => goal.t === 'collect' && goal.item === 3083).length, 1, 'the cogs listed once');
});

test(`EpicTibbles's report (#532): an objective that is talking to someone reads "Talk to", not "Kill": the Skyborne visits to the Horde leaders`, { skip }, () => {
	// Where the data counts these as kill credit on the NPC, the goal stays a `kill` tracking the
	// objective and its text is what the guide window shows; where the game's own objective list
	// makes them talks (#859), the goal is a `talk` tracking the objective, which reads "Talk to".
	const talks = [
		// (Zarrin's Camping 101: Cooking is now done by training Cooking from him: #743.)
		['forever/horde/03-silverpine-forest.guide', 93739, 1, 'Nazgrel'],
		['forever/horde/03-silverpine-forest.guide', 93739, 2, "Vol'jin"],
		// (Sylvanas is talked to on the Undercity stop at the end of the Silverpine guide, since the Horde 12-30 re-chain.)
		['forever/horde/03-silverpine-forest.guide', 93739, 4, 'Lady Sylvanas Windrunner'],
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
	// Final route review (2026-11-08): Ironforge is one round of the city, so the senator is a stop of that round,
	// in Ironforge before the tram, not a step of its own after it.
	const tram = at(list, 'goto Deeprun Tram', (g) => g.t === 'goto' && g.text === 'Deeprun Tram');
	assert.ok(turnin < tram, 'handed in before the tram');
	assert.equal(list[turnin].goal.map, 1455, 'in Ironforge');
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
	const files = ['03-darkshore', '03-loch-modan', '03-darkshore-return', '04-redridge-mountains', '05-duskwood', '06-ashenvale', '07-thousand-needles']
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
	assert.deepEqual(at20['983'], [1002, 'Grey, kept: opens “Buzzbox 323”']);
	assert.deepEqual(at20['1001'], [1002, 'Grey, kept: opens “Buzzbox 323”']);
	const at22 = greyInDarkshore(22).kept;
	assert.deepEqual(at22['983'], [1003, 'Grey, kept: opens “Buzzbox 525”']);
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

// The Barrens' 15-21 stay (forever/horde/02-the-barrens since the Horde 12-30 re-chain, 2026-11-07: the
// former 12-16 guide and the first half of the former 19-23 guide in one); 04-the-barrens is its 24-26 return.
const BARRENS = 'forever/horde/02-the-barrens.guide';

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

// Rohkin (#957): the Bristleback camps step collected Mankrik's tusks
// (Consumed by Hatred, 899) before Camp Taurajo, then the guide sent them back
// into the same camps for Tribes at War (878) from Mangletooth. Every
// Bristleback 878 asks for drops tusks, so the tusks are collected on 878's
// step, after its accept; Mankrik's wife (Lost in Battle, 4921) stays on the
// walk south.
// Flow audit, The Barrens (#1078). 12-16: Orcs and Trolls walked to Ratchet for its flight path alone and
// back to the Crossroads, 25 minutes before the route went to Ratchet anyway; Kolkar Leaders' Regthar was
// passed at 0 yd and Barak's camp walked through, the quest taken 326 minutes later in the 19-23 guide.
// 19-23: Raptor Horns was walked past at Mebok on the first Ratchet stop and handed in on the second, 149
// minutes later; a Warrior was sent from Camp Taurajo to Thun'grim (2,300 yd) and back for one hand-in.
const BARRENS_12 = 'forever/horde/02-the-barrens.guide';
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
	const background = new Set(JSON.parse(fs.readFileSync(path.join(__dirname, '..', 'data', 'guide-fixes.json'), 'utf8')).fixes.filter((r) => r.background).map((r) => `${r.at.quest}.${r.at.objective}`));
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
	assert.ok(turnin > at(list, 'turnin 868', is('turnin', 868)), "after the flight back to the Crossroads (Korran's Egg Hunt)");
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

// Flow audit, Horde Hillsbrad (#1079): Battle of Hillsbrad was walked out in one visit, Tarren Mill ->
// Hillsbrad Fields -> Tarren Mill five times, the last two for Magistrate Burnside and Foreman Bonds (both
// level 30) at 25-27. Parts 4 and 5 (532, 539) and Dangerous!'s clerk and miner come on the Tarren Mill
// visit at 30-32 (30-40/01-hillsbrad-foothills since the 2026-11-07 Horde 30-40 re-order): the town hall
// after the yeti caves, Infiltration and Helcular's Revenge handed in on the Tarren Mill stop between, then
// the flames, Dalaran's crater and the mine on one sweep south-west to Southshore's graveyard.
test('forever/horde/06-hillsbrad-foothills.guide: Battle of Hillsbrad parts 4 and 5 wait for the Tarren Mill visit at 32', { skip }, () => {
	const early = goals('forever/horde/06-hillsbrad-foothills.guide');
	assert.deepEqual(early.filter(({ goal }) => [532, 539].includes(goal.quest)).map(({ goal }) => `${goal.t} ${goal.quest}`), [], 'nothing of parts 4 and 5 at 25-27');
	assert.deepEqual(early.filter(({ goal }) => goal.quest === 567 && goal.t === 'kill').map(({ goal }) => goal.npc).sort(), [2449, 2451], "only Dangerous!'s Kalaba and Wilkes at 25-27");
	const list = goals('forever/horde/30-40/01-hillsbrad-foothills.guide');
	const idx = (what, pred) => at(list, what, pred);
	const accept = idx('accept 532', is('accept', 532));
	const rod = idx("Helcular's Rod", (g) => g.t === 'collect' && g.quest === 552);
	const hall = idx('Magistrate Burnside', (g) => g.t === 'kill' && g.quest === 532 && g.npc === 2335);
	const back = idx('turnin 532', is('turnin', 532));
	const bonds = idx('Foreman Bonds', (g) => g.t === 'kill' && g.quest === 539 && g.npc === 2305);
	const dalaran = idx('the first Bloodstone piece', (g) => g.t === 'collect' && g.quest === 544);
	assert.ok(accept < rod && rod < hall && hall < back && back < dalaran && dalaran < bonds, 'Tarren Mill, the yetis, the town hall, Tarren Mill, Dalaran, the mine');
	for (const q of [533, 552]) assert.equal(list[idx(`turnin ${q}`, is('turnin', q))].s, list[back].s, `${q} is handed in on the Tarren Mill stop between`);
	for (const q of [539, 567]) assert.ok(idx(`turnin ${q}`, is('turnin', q)) > bonds, `${q} is handed in after the mine`);
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
// Darkshore's southern and last loops, after the Eastern Kingdoms loop (Alliance 12-20 re-order, 2026-11-07).
const DARKSHORE_RETURN = 'forever/alliance/03-darkshore-return.guide';
const LOCH_MODAN = 'forever/alliance/03-loch-modan.guide';
// Both Darkshore visits in chain order: a quest of the first visit before one of the return.
const darkshoreBoth = () => [...goals(DARKSHORE), ...goals(DARKSHORE_RETURN)];
const THOUSAND_NEEDLES = 'forever/alliance/07-thousand-needles.guide';
const WETLANDS = 'forever/alliance/06-wetlands.guide';

test('Forever follow-ups are taken only once the quests before them are handed in', { skip }, () => {
	for (const [guide, quest, after, optional] of [
		[MULGORE, 99081, [99079]],
		[MULGORE, 99101, [99081]],
		[MULGORE, 99080, [99101]],
		[MULGORE, 99082, [99080]],
		[MULGORE, 98435, [760]],
		[TIRISFAL, 96899, [96897, 96898]],
		[TIRISFAL, 99156, [356], true],
		[[LOCH_MODAN, REDRIDGE], 98386, [89]],
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
		[[DARKSHORE, DARKSHORE_RETURN], 87760, [4722, 4723, 4725, 4727, 4728, 4730, 4731, 4732, 4733]],
		[SILVERPINE, 425, [91921]],
		[SILVERPINE, 98298, [99], true],
		[WESTFALL, 92911, [92910], true],
		// Lou-Saydus (#225): Forever puts From the Ashes before Nek'rosh's Gambit, so Captain
		// Stoutfist did not offer 465 when War Banners was handed in. From the Ashes itself is
		// offered together with War Banners (players' recordings), so it has no row here.
		[WETLANDS, 465, [98221]],
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
		// DexeeXI (#872): Shadow Priest Allister offers Watching the Roads only once Dalaran's Intentions
		// is handed in to him: Dalaran's Intentions is handed in in the Silverpine stay (12-15), Watching the
		// Roads taken on the ride to Hillsbrad at 22 (05-stonetalon-mountains, after it in every chain).
		// DexeeXI (#891): Yelmak offers Whuut's the Rush once Yelmak's Medley
		// is handed in to Kor'geld beside him.
		[SILVERPINE, 97275, [97242]],
		// The #872 sweep: James Halloran's Crocs of the Sky is his last favor
		// after Apprentice's Duties, and Lord Grayson Shadowbreaker's The
		// Shamed Lieutenant thanks you for the statuette A Friend of the Family
		// brings him.
		[WETLANDS, 98072, [471], true],
		[WETLANDS, 98072, [471]],
		[WETLANDS, 98219, [98191]],
		// Bennistrov (#1354): Bolvar offers his A Friend of the Family once Captain Stoutfist's is handed in to him.
		[WETLANDS, 98191, [98190]],
		// soockee (#1002) and jiskim (#984): Va'xug Firefure offers A Void Path
		// only once Never Coming Back is handed in to him.
		[STONETALON, 98252, [98251]],
		// The offer audit of players' recordings (2026-11-07): Karl Boran offers
		// Return the Statuette (98189) once the old one (286) is handed in
		// (#1113, #1118); Muln Earthfury offers The Broodmother once Defending the
		// Dead is handed in (#1083); Thrall offers a Skyborne Journey to the
		// Crossroads once Welcome to Azeroth is handed in.
		[WETLANDS, 98189, [286]],
		[ASHENVALE_HORDE, 96261, [96259]],
		['forever/reputation/thunder-bluff.guide', 96261, [96259]],
		[SILVERPINE, 98024, [95350]],
		[SILVERPINE, 93739, [95350], true],
		// #1134: James Halloran offers Crimson Crate Delivery only after Crocs of
		// the Sky; the route now leaves it out (data/route-fixes.json skip).
		[ASHENVALE, 98240, [98072], true],
		[HILLSBRAD_ALLIANCE, 98240, [98072], true],
	]) {
		const list = [].concat(guide).flatMap((g) => goals(g));
		const take = list.findIndex(({ goal }) => is('accept', quest)(goal));
		if (take < 0 && optional) continue;
		assert.ok(take >= 0, `${guide}: accept ${quest} is in the guide`);
		for (const pre of after) {
			assert.ok(at(list, `${guide}: turnin ${pre}`, is('turnin', pre)) < take, `${guide}: ${quest} is taken after ${pre} is handed in`);
		}
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
	for (const [t, q] of [['turnin', 479], ['turnin', 91920], ['turnin', 422]]) {
		assert.equal(list[at(list, `${t} ${q}`, is(t, q))].s, stop, `${t} ${q} on the Sepulcher stop after the south loop`);
	}
	const eyes = at(list, 'the murloc eyes (91920)', (g) => g.quest === 91920 && g.t === 'collect');
	const pendants = at(list, 'the Dalaran Pendants (479)', (g) => g.quest === 479 && g.t === 'collect');
	assert.deepEqual(list.slice(eyes, pendants).filter(({ goal }) => goal.t === 'turnin' && !goal.optional && goal.npc != null).map(({ goal }) => goal.quest), [], 'no Sepulcher stop between the shore and Ambermill');
	assert.deepEqual(list.filter(({ goal }) => [443, 460, 461, 493, 516, 95981].includes(goal.quest)).map(({ goal }) => `${goal.t} ${goal.quest}`), [], 'no Fenris Isle, and the level 19-21 quests wait for the ride to Hillsbrad');
	const ride = goals(STONETALON);
	const sep = ride[at(ride, 'accept 493', is('accept', 493))].s;
	for (const q of [516, 95981]) assert.equal(ride[at(ride, `accept ${q}`, is('accept', q))].s, sep, `${q} on the ride's Sepulcher stop`);
	assert.deepEqual(compiled(SILVERPINE).steps.filter((step) => step.along).map((step) => step.title), [], 'no "along the way" lists');
});

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
		assert.match(list[take].step.note || '', guide === WESTFALL ? /walk to Stormwind/i : /the tram from Ironforge arrives in the Dwarven District/, `${guide}: the step keeps its own travel line`);
	}
	// A build writes the guide-fixes record's tip over every Alliance warrior's step: it must carry the
	// Dwarf and Gnome tram line and the Human walk, so a rebuild loses neither hand fix.
	const fixes = JSON.parse(fs.readFileSync(path.join(__dirname, '..', 'data', 'guide-fixes.json'), 'utf8')).fixes;
	const tips = fixes.filter((r) => r.at && r.at.quest === 1638 && r.at.goal === 'accept' && r.tip).map((r) => r.tip);
	assert.equal(tips.length, 1, 'one tip record for the Defensive Stance step');
	for (const want of [/the tram from Ironforge arrives in the Dwarven District/, /walk to Stormwind/i, /go straight to Harry/]) assert.match(tips[0], want);
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

// --- Tirisfal (Fitz, #1046): out of Deathknell the road passes Calvin
// Montague, Deathguard Simmer, the pumpkin fields and Gordo's road before
// Brill. The guide ran past Simmer, Dillinger and Executor Zygand, went back
// to Solliden for A Rogue's Deal and saved the pumpkins for a sweep much
// later. Now what the road in passes is taken and done on it, Brill is
// entered from the west (Dillinger and Bartholomew, Holland, the branches and
// Eleanor, then the square: Zygand before Sevren), Calvin's duel is fought on
// the west loop's way to the Crusader's Outpost, and no step is an along list.
const TIRISFAL_CLASSES = ['WARRIOR', 'ROGUE', 'PRIEST', 'MAGE', 'WARLOCK', 'PALADIN'];
const collects = (item) => (g) => g.t === 'collect' && g.item === item;

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
test(`${TIRISFAL}: Fitz's report (#1046 follow-up): each Brill visit enters the Gallows' End Tavern once`, { skip }, () => {
	goals(TIRISFAL); // loads the reference data
	for (const npc of [5688, 1500, 1560, 2131, 265944, 1521, 2128, 2129, 2127, 2130, 1931, 2211]) {
		const spawn = data.npcs[npc] && data.npcs[npc].spawns[1420];
		if (spawn) assert.ok(inBox({ map: 1420, x: spawn.pts[0][0], y: spawn.pts[0][1] }, BRILL_INN), `npc ${npc} stands inside the inn's box`);
	}
	for (const npc of [1515, 1499, 1518, 2118, 1652, 1738]) {
		const spawn = data.npcs[npc].spawns[1420];
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
	const list = darkshoreBoth();
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

test(`${HILLSBRAD_ALLIANCE}: Lou-Saydus's report: Nek'rosh's Gambit, taken after From the Ashes in ${WETLANDS}, is handed in on the Wetlands loop (#225)`, { skip }, () => {
	const needles = goals(WETLANDS);
	assert.equal(needles.findIndex(({ goal }) => is('turnin', 465)(goal)), -1, 'the catapult is not lit in the guide that takes the quest');
	const plans = needles.filter(({ goal }) => is('interact', 98221)(goal));
	assert.equal(plans.length, 4, 'one goal per Attack Plan (#1312)');
	assert.ok(plans.every(located), 'each attack plan has a place');
	const list = goals(HILLSBRAD_ALLIANCE);
	assert.equal(list.findIndex(({ goal }) => is('accept', 98221)(goal)), -1, 'From the Ashes is not taken again');
	const lit = at(list, 'turnin 465', is('turnin', 465));
	assert.ok(lit < at(list, 'accept 98223', is('accept', 98223)), 'before the Tattered Spellbook');
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

// --- Alliance 12-21 level ranges (Discord, 2026-11-08: a Human "usually gets cut off in Westfall around 15 and a
// half"): #1274 set Westfall 13-17, Darkshore 17-19 and Loch Modan 19-21 from the Dwarf, Gnome, Night Elf and
// Skyborne levels, but Humans come from Elwynn and enter about 2 lower. The level model (ReleaseAudit, 0.3.5, mean
// over each start's classes) has Humans entering Westfall at 11.35, Darkshore at 15.27 and Loch Modan at 17.77,
// and the other starts leaving them at up to 17.54, 19.38 and 21.61. The per-start levels come from the level sim
// with locally calibrated parameters, so a test can't recompute them; these tests check the guides' own labels instead.
const headers = () => Object.fromEntries(allGuides().flatMap((file) => {
	const text = fs.readFileSync(path.join(OFFICIAL_DIR, file), 'utf8');
	const id = /^guide (\S+)/m.exec(text);
	const lv = /^levels (\d+)-(\d+)/m.exec(text);
	const next = /^next (\S+)/m.exec(text);
	return id && lv ? [[id[1], { file, min: +lv[1], max: +lv[2], next: next && next[1] }]] : [];
}));

test('every leveling guide starts at most one level above the end of each guide that leads into it', () => {
	const all = headers();
	const holes = [];
	for (const [id, g] of Object.entries(all)) {
		const n = g.next && all[g.next];
		if (n && n.min > g.max + 1) holes.push(`${id} ends at ${g.max}, ${g.next} starts at ${n.min}`);
	}
	assert.deepEqual(holes, []);
});

test('Alliance 12-21: Westfall, Darkshore and Loch Modan start where Humans enter them, within one level', () => {
	const all = headers();
	for (const [id, human, top] of [['forever/alliance/02-westfall', 11.35, 17.54], ['forever/alliance/03-darkshore', 15.27, 19.38], ['forever/alliance/03-loch-modan', 17.77, 21.61]]) {
		assert.ok(all[id].min <= human + 1 && all[id].min >= Math.floor(human), `${id} starts at ${all[id].min}; Humans enter at ${human}`);
		assert.ok(all[id].max >= Math.floor(top), `${id} ends at ${all[id].max}; the last start leaves at ${top}`);
	}
});

// --- Dun Modr (Fyurie, #1313): Spark of Freedom's Captive Fire Elemental is held at the far west of the Dark Iron
// ruins, among elites (27-30, Balgaras the Foul 34), and the escort walks back out through them; 0.3.5 sent solo
// players in without asking. It is a group quest now; the camp quests on the road stay for everyone.
test(`${HILLSBRAD_ALLIANCE}: Fyurie's report: Spark of Freedom is asked as a group quest; the Dun Modr camp quests are not (#1313)`, { skip }, () => {
	const list = goals(HILLSBRAD_ALLIANCE);
	const mine = list.filter(({ goal }) => goal.quest === 87491);
	assert.equal(mine.length, 2, 'the accept and the hand-in');
	for (const { step, goal } of mine) assert.ok((step.when || []).some((p) => p.k === 'group' && [p.q].flat().includes(87491) && !p.neg), `${goal.t} 87491 is under when group 87491`);
	for (const [t, q] of [['turnin', 472], ['accept', 631]]) {
		const { step } = list[at(list, `${t} ${q}`, is(t, q))];
		assert.ok(!(step.when || []).some((p) => p.k === 'group'), `${t} ${q} is for everyone`);
	}
});

// --- Tarren Mill (refusal gate's hand-in-first step, 2026-11-08): all 6 people who took Dalaran Patrols (545) had just
// handed in Key to the City (93680) to Magus Wordeen Voidglare, and nobody took it without; the route left 93680 out
// and accepted 545 right after Prison Break In. Key to the City is taken with 544 and handed in before 545's accept.
test('forever/horde/30-40/01-hillsbrad-foothills.guide: Key to the City is handed in before Dalaran Patrols is accepted', { skip }, () => {
	const list = goals('forever/horde/30-40/01-hillsbrad-foothills.guide');
	const take = at(list, 'accept 93680', is('accept', 93680));
	const key = at(list, 'collect 279469', (g) => g.t === 'collect' && g.item === 279469);
	const done = at(list, 'turnin 93680', is('turnin', 93680));
	const patrols = at(list, 'accept 545', is('accept', 545));
	assert.ok(at(list, 'accept 544', is('accept', 544)) < take, 'taken with Prison Break In');
	assert.ok(take < key && key < done && done < patrols, 'the key, its hand-in, then Dalaran Patrols');
	// The Grimy Key is looted from an object the data has no spawn for: the step carries the recorded spot.
	const g = list[key].goal;
	assert.ok(g.map === 1416 && Math.hypot(g.x - 16.4, g.y - 89.3) < 0.5, `the key's step points at Alterac 16.4,89.3 (got ${g.map} ${g.x},${g.y})`);
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
	const hand = goals(DUN_MOROGHS[0]).find(({ goal }) => is('turnin', 5637)(goal));
	assert.ok(hand && hand.goal.npc === 11406, 'Desperate Prayer to High Priest Rohan');
	assert.ok(!/Stormwind/.test(JSON.stringify(hand.step.zone || '')), 'in Ironforge, not Stormwind');
	for (const file of DUN_MOROGHS) {
		const go = goals(file).find(({ goal }) => goal.t === 'goto' && goal.x != null && goal.x < 24 && goal.y > 50 && goal.y < 56);
		assert.ok(go && Math.hypot(go.goal.x - 21.3, go.goal.y - 54.2) < 0.5, `${file}: the Frostmane Hold point at 21.3,54.2`);
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

// --- Never seen taken (#1314's pattern; RefusalSweep's never-taken sweep, 2026-11-08): Hearts of the Lost turned
// out not to be in the game. Two more Forever quests nobody has been recorded taking or being offered, whose giver
// nobody has ever seen, from another addon's data and the web only, are optional, with a tip to skip them when the
// giver isn't there: every goal of theirs is optional, so nothing in the guide waits on them.
for (const [q, title, giver, files] of [
	[93176, 'My Little Friends', 'Amaryllis Webb', ['forever/alliance/30-40/05-arathi-highlands.guide', 'forever/alliance/40-50/01-stranglethorn-vale.guide']],
	[97265, 'Hate the Hatefury', "Aka'rai", ['forever/horde/30-40/02-thousand-needles.guide']],
]) {
	test(`${title} (${q}): every goal is optional and the accept says to skip it when ${giver} doesn't offer it (#1314)`, { skip }, () => {
		let n = 0;
		for (const file of files) {
			for (const { goal } of goals(file).filter(({ goal }) => goal.quest === q)) {
				n++;
				assert.ok(goal.optional, `${file}: ${goal.t} ${q} is optional`);
				if (goal.t === 'accept') assert.match(stepTips(file, new RegExp(`^\\s+accept ${q}\\b`)).join(' '), new RegExp(`${giver} may not be here on Forever: if ${giver} doesn't offer ${title}, skip it\\.`), `${file}: the accept's step says to skip it`);
			}
		}
		assert.ok(n >= 2, `the accept and the hand-in are found (${n})`);
	});
}

// --- Hammerfall (never-taken check, 2026-11-08): the Defiler's Basic Care Package (8263) needs Friendly with the
// Defilers (the game's quest data: RequiredMinRepFaction 510, 3000), which the leveling route never earns; Rutherford
// Twing refused it to a level 28 player. Both ends are optional and the step says why.
test('forever/horde/30-40/01-hillsbrad-foothills.guide: the Defiler\'s Basic Care Package is optional and says it needs Defilers reputation', { skip }, () => {
	const file = 'forever/horde/30-40/01-hillsbrad-foothills.guide';
	const list = goals(file).filter(({ goal }) => goal.quest === 8263);
	assert.ok(list.length >= 2, 'the accept and the hand-in');
	for (const { goal } of list) assert.ok(goal.optional, `${goal.t} 8263 is optional`);
	assert.match(stepTips(file, /^\s+accept 8263\b/).join(' '), /Friendly with the Defilers/);
});

// --- DexeeXI's report (#1322, client 70862): Elixir of Agony (515) takes item 3388, which the game calls Lesser Troll's
// Blood Elixir (players' recordings: the objective reads so and ticks with it); the quest's own text still says Strong. The
// Undercity step told players to buy a Strong Troll's Blood Potion, the item's old name. The Craftsman's Writs of the
// Supply Factions Reputation guide named old item names the same way (one, Elixir of Greater Defense, is now another item).
test("DexeeXI's report (#1322): the guides name the elixirs the quests take by their names in the game", { skip }, () => {
	const file = 'forever/horde/30-40/01-hillsbrad-foothills.guide';
	const list = goals(file);
	assert.equal(data.items[3388].name, "Lesser Troll's Blood Elixir");
	assert.ok(data.quests[515].objectives.some((o) => o.type === 'item' && o.id === 3388), 'Elixir of Agony takes item 3388');
	const step = list.find(({ step }) => step.title === 'The Undercity').step;
	const said = [step.tip, step.note, ...step.goals.map((g) => g.text)].flat().filter(Boolean).join(' ');
	assert.match(said, /needs a Lesser Troll's Blood Elixir/);
	assert.match(said, /quest text says Strong, but it takes a Lesser Troll's Blood Elixir/);
	assert.doesNotMatch(said, /Strong Troll's Blood Potion/);
	// Each writ's hand-in says which item it takes: one of the quest's item objectives, by the game's name.
	const writs = goals('forever/reputation/merchants-favor.guide').filter(({ goal }) => goal.t === 'turnin' && /^Craftsman's Writ/.test(data.quests[goal.quest]?.title || ''));
	assert.ok(writs.length > 0, 'the writ hand-ins');
	for (const { goal } of writs) {
		const item = (goal.note || '').replace(/, \d+ reputation$/, '');
		const takes = data.quests[goal.quest].objectives.filter((o) => o.type === 'item').map((o) => data.items[o.id]?.name);
		assert.ok(takes.includes(item), `writ ${goal.quest}: "${item}" is one of ${takes.join(', ')}`);
	}
});

// --- Level sweep over the guides the level model doesn't play (SweepGates, 2026-11-08): the centaur reputation guide
// opens at level 30, and its clans reach Honored on quests from level 30 and tradeable totems, but Valley of Bones and
// every quest after it (Gelkis 93034..., Magram 92841...) need level 35 (Forever's quest data and the page agree). The
// steps took them at Honored alone, so a level 30-34 player stood at a giver who offered nothing.
test('forever/reputation/centaur-clans.guide: no accept comes before the guide waits for its quest\'s level', { skip }, () => {
	const G = 'forever/reputation/centaur-clans.guide';
	let reached = compiled(G).minLevel || 1;
	for (const { goal } of goals(G)) {
		if (goal.t === 'level') reached = Math.max(reached, goal.level);
		if (goal.t === 'accept') assert.ok((goal.minLevel || 1) <= reached, `accept ${goal.quest} (from level ${goal.minLevel}) comes after the guide waits for that level (${reached})`);
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

// --- Flow re-order (2026-11-07): Desolace killed Other Fish to Fry's naga at
// Sar'theris Strand and walked past Drulzegar Skraghook in Shadowprey with the
// quest done, carrying it into the Dustwallow guide, whose Desolace visit
// killed the naga again and handed it in about nine hours later.
test('forever/horde/30-40/02-thousand-needles.guide: flow re-order: Other Fish to Fry is handed to Drulzegar on the Shadowprey stop after the naga, not in the Dustwallow guide', { skip }, () => {
	const list = goals('forever/horde/30-40/02-thousand-needles.guide');
	const kills = list.filter(({ goal }) => goal.t === 'kill' && goal.quest === 6143);
	assert.equal(kills.length, 3, 'the three naga kinds are killed in the Desolace guide');
	const turnin = at(list, 'turnin 6143 (Other Fish to Fry)', is('turnin', 6143));
	assert.ok(kills.every(({ s }) => s < list[turnin].s), 'handed in after the naga');
	assert.equal(list[turnin].s, list[at(list, 'turnin 6142 (Clam Bait)', is('turnin', 6142))].s, 'on the Shadowprey stop that hands Clam Bait to Mai\'Lahii, beside Drulzegar');
	assert.ok(!goals('forever/horde/30-40/04-dustwallow-marsh.guide').some(({ goal }) => goal.quest === 6143), 'the Dustwallow guide neither kills the naga again nor hands it in');
});

// --- Flow re-order (2026-11-07, #1106): Alliance Badlands walked from the
// skeleton at Agmond's End west to Lotwil for his quest alone, back to Agmond's
// End for the sweep, and west again for the Lesser Rock Elementals; the
// Indurium flakes were an along list.
test(`${BADLANDS}: flow re-order: Agmond's End swept before Lotwil, Lotwil's elementals in one go, no along steps`, { skip }, () => {
	const list = goals(BADLANDS);
	assert.deepEqual(compiled(BADLANDS).steps.filter((st) => st.along).map((st) => st.title), [], 'no along steps');
	const lotwil = at(list, 'accept 710 (Lotwil)', is('accept', 710));
	for (const [what, pred] of [['Theldurin\'s accept', is('accept', 709)], ['the scrap', (g) => g.t === 'collect' && g.quest === 733]]) {
		assert.ok(at(list, what, pred) < lotwil, `${what} before Lotwil`);
	}
	const stones = at(list, 'collect 4626 (Small Stone Shard)', (g) => g.t === 'collect' && g.item === 4626);
	assert.ok(stones > lotwil, 'the Small Stone Shards after Lotwil\'s accept');
	assert.ok(list.some(({ goal, s }) => s === list[stones].s && goal.t === 'collect' && goal.item === 7848), 'Ghak\'s Rock Elemental Shards with them');
});

// The same pattern elsewhere: a quest taken where the route already stands,
// instead of on a walk back to its giver later.
const STRANGLETHORN_HORDE = 'forever/horde/30-40/03-stranglethorn-vale.guide';
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

// --- Flow re-order (2026-11-07, #1104): Horde Badlands ground the Lesser
// Rock Elementals before Kargath, where Jarkal gives Badlands Reagent Run, and
// came back to the Dustbowl for his Rock Elemental Shards after Agmond's End;
// the buzzard wings were a stop of their own at Agmond's End.
test('forever/horde/30-40/06-badlands.guide: flow re-order: Jarkal\'s shards with the Dustbowl elementals, the wings on the way to Agmond\'s End', { skip }, () => {
	const list = goals('forever/horde/30-40/06-badlands.guide');
	const jarkal = at(list, 'accept 2258 (Badlands Reagent Run)', is('accept', 2258));
	const stones = at(list, 'collect 4626 (Small Stone Shard)', (g) => g.t === 'collect' && g.item === 4626);
	assert.ok(jarkal < stones, 'Badlands Reagent Run taken before the Lesser Rock Elementals');
	assert.ok(list.some(({ goal, s }) => s === list[stones].s && goal.t === 'collect' && goal.item === 7848), 'the Rock Elemental Shards collected with the Small Stone Shards');
	const wings = list.filter(({ goal }) => goal.t === 'collect' && goal.item === 3404);
	assert.equal(wings.length, 1, 'the wings listed once');
	// Indurium's flakes (1108), which the wings were gathered with, are left out with Martek the Exiled (#1214).
	const theldurin = at(list, 'accept 709 (Theldurin)', is('accept', 709));
	const rigglefuzz = at(list, 'turnin 703 (Rigglefuzz)', is('turnin', 703));
	assert.ok(theldurin < at(list, 'the wings', (g) => g.t === 'collect' && g.item === 3404) && wings[0].s < list[rigglefuzz].s, 'the wings between Agmond\'s End and Rigglefuzz');
});

// --- Flow re-order (2026-11-07, #1109): Horde Stranglethorn 30-40 had six
// along lists, each duplicating a step that already does the work, and listed
// the Shadowmaw Panthers on the Savage Coast, where none live (they are by
// Grom'gol and the Mosh'Ogg camp, around 42,32).
test(`${STRANGLETHORN_HORDE}: flow re-order: no along steps, the Shadowmaw Panthers only by Grom'gol`, { skip }, () => {
	assert.deepEqual(compiled(STRANGLETHORN_HORDE).steps.filter((st) => st.along).map((st) => st.title), [], 'no along steps');
	const list = goals(STRANGLETHORN_HORDE);
	const shadowmaw = list.filter(({ goal }) => goal.t === 'kill' && goal.quest === 192);
	assert.ok(shadowmaw.length > 0, 'the Shadowmaw Panthers are in the guide');
	for (const { goal } of shadowmaw) assert.ok(goal.x > 38 && goal.y > 25, `Shadowmaw Panthers by Grom'gol, not on the Savage Coast (${goal.x},${goal.y})`);
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


test(`${REDRIDGE}: Yendi's report: Herble's Bronze Tube is offered before Look to the Stars is handed in, without holding the step`, { skip }, () => {
	// Look to the Stars is handed in on Duskwood's first Darkshire visit since the flow audit (2026-11-07); that
	// visit opens 04-redridge-mountains since the Alliance 20-30 re-order (2026-11-07).
	const list = goals(REDRIDGE);
	const give = at(list, 'turnin 174 (Look to the Stars)', is('turnin', 174));
	const buy = at(list, 'buy 4371 (Bronze Tube)', (g) => g.t === 'buy' && g.item === 4371);
	assert.ok(buy < give && list[buy].s === list[give].s, 'bought on the same stop, before the turn-in');
	assert.equal(list[buy].goal.npc, 3133, 'from Herble Baubbletump, beside Viktori');
	// A player who has the tube, or who already handed it in, is not held by it.
	assert.equal(list[buy].goal.optional, true, 'the buy is optional');
});

// uNBEx and Bennistrov (#1348): Herble keeps one Bronze Tube and is nearly always sold out (no tube in 30
// merchant windows of 19 players' recordings; Billibub Cogspinner in Stormwind none in 20 of 14). The players
// who handed Look to the Stars in bought it at the Stormwind Auction House, so the Stormwind stop before
// Darkshire sends them there, without holding anyone who has no use for it.
const STORMWIND_AH = { map: 1453, x: 61.2, y: 71.3 };
const atAuctionHouse = (g) => g.map === STORMWIND_AH.map && Math.hypot(g.x - STORMWIND_AH.x, g.y - STORMWIND_AH.y) <= 1;
test(`${REDRIDGE}: uNBEx's report (#1348): the Bronze Tube comes from the Stormwind Auction House before Darkshire`, { skip }, () => {
	const list = goals(REDRIDGE);
	const ah = at(list, 'collect 4371 at the Auction House', (g) => g.t === 'collect' && g.item === 4371);
	assert.ok(atAuctionHouse(list[ah].goal), 'the arrow leads to the Trade District Auction House');
	assert.equal(list[ah].goal.optional, true, 'optional: a player with a tube, or without the money, is not held');
	const take = at(list, 'accept 174 (Look to the Stars)', is('accept', 174));
	assert.ok(list[ah].s < list[take].s, 'on a stop before Darkshire, where Look to the Stars is taken');
});

// The sweep for #1348: a Bronze Tube is never a buy that holds a step (every vendor of it keeps one or two),
// and a goal that must get one sends the player to the Stormwind Auction House, not to a vendor.
test('Every guide (#1348): no Bronze Tube buy holds a step; a required tube comes from the Auction House', { skip }, () => {
	let seen = 0;
	for (const guide of allGuides()) {
		if (!fs.readFileSync(path.join(OFFICIAL_DIR, guide), 'utf8').includes('4371')) continue;
		for (const { goal } of goals(guide)) {
			if (goal.item !== 4371 || (goal.t !== 'buy' && goal.t !== 'collect')) continue;
			seen++;
			if (goal.t === 'buy') assert.equal(goal.optional, true, `${guide}: buy 4371 is optional`);
			else if (!goal.optional) assert.ok(atAuctionHouse(goal), `${guide}: a required Bronze Tube is collected at the Auction House`);
			assert.notEqual(goal.npc, 5519, `${guide}: not Billibub Cogspinner, sold out in every recorded window`);
		}
	}
	assert.ok(seen >= 4, `the Bronze Tube goals were found (${seen})`);
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
		.goals.filter((g) => g.quest === 92514 && g.t !== 'turnin' && g.t !== 'accept').sort((a, b) => a.oi - b.oi).map((g) => g.status);
	// Objective 1 is Illaya, 2 Coriella, whichever line the step lists first.
	assert.deepEqual(objectives(1, 0).map((st) => st === 'done'), [true, false], 'Illaya done earlier, Coriella still to do');
	assert.ok(objectives(1, 1).every((st) => st === 'done'), 'both done: only the turn-in is left');
});

// --- Flow re-order (2026-11-07, #1093): Zephras Isle sent players back
// across the isle. Both factions walked past Fendaal Windstone and his
// assassins on the road to Valanaar and came back for them on the turncoat's
// trip; Horde Skyborne walked back to Raan's campfire from the hippogryph
// nests and from the far-north gyrozephyrs back to Aamelia's farm; the
// Alliance's last Valanaar stop went Elaadrin -> Talaanis -> Elaadrin -> the
// west gate; four along lists.
test('Zephras Isle, both factions: flow re-order: Fendaal on the road in, no along steps, no trip back to the campfire or the farm', { skip }, () => {
	for (const guide of [ZEPHRAS_ALLIANCE, ZEPHRAS_HORDE]) {
		const list = goals(guide);
		const { steps } = compiled(guide);
		assert.deepEqual(steps.filter((st) => st.along).map((st) => st.title), [], `${guide}: no along steps`);
		const fendaal = at(list, `${guide}: turnin 98512`, is('turnin', 98512));
		const valanaar = list.findIndex(({ goal }) => goal.t === 'turnin' && (goal.quest === 93948 || goal.quest === 92701));
		assert.ok(fendaal < valanaar, `${guide}: Al'Aketh Assassins done before the first Valanaar stop`);
		assert.ok(fendaal < at(list, `${guide}: accept 92643 (The Turncoat)`, is('accept', 92643)), `${guide}: not on the turncoat's trip`);
	}
	const horde = goals(ZEPHRAS_HORDE);
	const campfire = at(horde, 'complete 96101 (The Great Outdoors)', is('complete', 96101));
	assert.equal(horde[campfire].s, horde[at(horde, 'turnin 92472 (Aonda)', is('turnin', 92472))].s, 'Horde: the campfire on the first Shen\'dar stop');
	assert.ok(at(horde, 'turnin 92693 (Standing Our Ground)', is('turnin', 92693)) < at(horde, 'collect 260883 (Enchanted Gyrozephyr)', (g) => g.t === 'collect' && g.item === 260883), 'Horde: Aamelia\'s chain finished before the gyrozephyrs');
	const alliance = goals(ZEPHRAS_ALLIANCE);
	assert.ok(at(alliance, 'accept 93951 (Taleen)', is('accept', 93951)) < at(alliance, 'collect 6889 (Small Egg)', (g) => g.t === 'collect' && g.quest === 92553), 'Alliance: Taleen on the first Shen\'dar stop');
	assert.ok(at(alliance, 'accept 94896 (Ealaane)', is('accept', 94896)) < at(alliance, 'turnin 92699 (Elaadrin)', is('turnin', 92699)), 'Alliance: Ealaane on the first walk through Valanaar');
	const last = at(alliance, 'turnin 93835 (Confront Lorthuna)', is('turnin', 93835));
	const firstHalf = alliance.slice(last).findIndex(({ goal }) => goal.t === 'turnin' && goal.quest === 93089);
	assert.ok(alliance.slice(last, last + firstHalf).some(({ goal }) => goal.t === 'turnin' && goal.quest === 94896), 'Alliance: Ealaane before the last visit to Elaadrin');
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
		['forever/alliance/03-darkshore-return.guide', 'Grizzled Scalp', (g) => g.t === 'collect' && g.item === 5414, [37, 46, 69, 83]],
		['forever/alliance/50-60/02-felwood.guide', 'Jadefire Hellcaller (Jadefire Run)', (g) => g.t === 'kill' && g.npc === 7111, [38, 44, 13, 23]],
		['forever/horde/04-the-barrens.guide', 'Stonetalon Sap', (g) => g.t === 'collect' && g.item === 5582, [32, 41, 9, 21]],
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

test('forever/alliance/03-darkshore-return.guide: the Grizzled Scalps are collected in the step at the Grove, where the bears are and Buzzbox 525 takes them', { skip }, () => {
	const list = goals(DARKSHORE_RETURN);
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
	// (The Warsong Reports, 6543, is left out since the final route review; Kadrak keeps Report to Kadrak.)
	const kadrak = list[at(list, 'turnin 6541', is('turnin', 6541))].goal;
	assert.equal(kadrak.map, 1413, `${kadrak.t} ${kadrak.quest} is on The Barrens (1413), not ${kadrak.map}`);
	const outrunners = list[at(list, 'the Ashenvale Outrunners', (g) => g.t === 'kill' && g.npc === 12856)].goal;
	assert.equal(outrunners.map, 1440, 'the Outrunners are still in Ashenvale');
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

// --- Ashenvale (Zerkness #383, Ioney #396, soockee #1117): two Paladins and a
// Shaman found no Alonso at Mystral Lake; #1117 is the in-game check by a
// non-Warrior that #383 waited on. His Dragonslayer quests (78132-78134) are
// for Warriors (corrections, classes 1): only a Warrior is led to him, his
// accepts stay optional and the turn-ins hold only a player who took the
// quest, so a Warrior he offers nothing passes the step there.

test('Zerkness\'s, Ioney\'s and soockee\'s reports (#383, #396, #1117): only Warriors are led to Alonso, and his quests hold only one who takes them, in both Ashenvale guides', { skip }, () => {
	const chain = [78132, 78133, 78134];
	for (const [guide, faction, paladinRace, warriorRace] of [[ASHENVALE, 'Alliance', 'Dwarf', 'Human'], [ASHENVALE_HORDE, 'Horde', 'Scourge', 'Orc']]) {
		const list = goals(guide);
		const first = at(list, `${guide}: accept 78132`, is('accept', 78132));
		const { step } = list[first];
		assert.equal(step.title, 'Alonso', `${guide}: Alonso has his own step`);
		assert.deepEqual(step.only && step.only.classes, ['WARRIOR'], `${guide}: the Alonso step is for Warriors`);
		assert.deepEqual([step.goals[0].t, !!step.goals[0].optional], ['goto', false], `${guide}: a plain goto leads the Warrior to Alonso`);
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
			for (const [cls, race, offered] of [['PALADIN', paladinRace, false], ['WARRIOR', warriorRace, true], ['WARRIOR', warriorRace, false]]) {
				const who = `${guide}: a ${race} ${cls}${offered ? '' : ' Alonso offers nothing'}`;
				const [out, got] = playGuide(pack, g, { race, faction, cls, script: watch(offered) });
				assert.equal(out.stuck, undefined, `${who}: not stuck: ${JSON.stringify(out.stuck)}`);
				assert.ok(out.done, `${who}: plays to the end`);
				assert.equal(got.reached, cls === 'WARRIOR', `${who}: ${cls === 'WARRIOR' ? 'is' : 'is not'} led to Alonso`);
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

// Avtom (#280): "Kill Ribchaser (rare) or Redridge Brute for Iron Pike" led to
// the Redridge Mongrels' camp, where no Brute stands. Ribchaser, a rare, shares
// the Mongrels' spawn points and drops the quest's Iron Pike and Iron Rivet at
// 80%, the common Brutes, Mystics, Bashers and Drudgers at 65%: the highest
// chance put the rare first and the arrow led to its camp. A rare is passed
// over for the common droppers beside it, as elites are.

test(`${LOCH_MODAN}: Avtom's report (#280): Iron Pike and Iron Rivet lead to the gnolls that drop them, not to the rare Ribchaser's camp among the Mongrels`, { skip }, () => {
	const list = goals(LOCH_MODAN);
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
	const known = data.spawns('object', 665289).filter((s) => s.map === 1432).flatMap((s) => [...s.pts, ...(s.more || [])]);
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
	if (data.quests[98042].pre.includes(949)) assert.ok((goal.pre || []).includes(949), `the accept waits for 949: ${JSON.stringify(goal.pre)}`);
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
	// Left out since the final route review (route-fixes skip 6543); holds whenever a build takes it again.
	if (!list.some(({ goal }) => is('accept', 6543)(goal))) return;
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
		// The step that does the work: an along list (the Barrens' beaks, worked on the way, #1135) has
		// its place on the finish step.
		const list = working(goals(guide));
		const { goal } = list[at(list, `${guide} collect ${item}`, (g) => g.t === 'collect' && g.item === item && g.quest === quest)];
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

// --- Flow audit (2026-11-07): Westfall's north loop came back to Saldean's
// in its middle for two hand-ins, then went west for the livers and the
// vulture meat, north again, and back to Saldean's a second time; Dwarves,
// Gnomes, Night Elves and Skyborne walked up to the Jansen Stead's well alone
// before the loop. Now one loop from Sentinel Hill: the Molsen Farm fields
// (watchers, okra, livers, snouts, vulture meat), the Defias by Jangolode
// Mine, the north hills and coast, the Jansen Stead (oats and well), then
// every Saldean's hand-in at once on the way back to the hill.
test(`${WESTFALL}: flow audit: one north loop, the farm work in its first fields, Saldean's handed in once on the way back`, { skip }, () => {
	const list = goals(WESTFALL);
	const collects = (item) => (g) => g.t === 'collect' && g.item === item;
	const paws = at(list, 'the Gnoll Paws', collects(725));
	for (const [what, item] of [['the Goretusk Livers', 723], ['the Stringy Vulture Meat', 729], ['the Goretusk Snouts', 731], ['the Okra', 732]]) {
		const i = at(list, what, collects(item));
		assert.ok(i < paws, `${what} before the north hills`);
		assert.ok(list.filter(({ goal }) => collects(item)(goal)).length === 1, `${what} listed once`);
	}
	const oats = at(list, 'the oats', collects(1528));
	const saldean = list[at(list, 'turnin 9', is('turnin', 9))].step;
	for (const q of [9, 92909, 38, 22]) {
		const i = at(list, `turnin ${q}`, is('turnin', q));
		assert.ok(i > oats, `turnin ${q} after the Jansen Stead`);
		assert.equal(list[i].step, saldean, `turnin ${q} on the one Saldean's stop after the loop`);
	}
	assert.ok(at(list, 'turnin 9', is('turnin', 9)) < at(list, 'turnin 12', is('turnin', 12)), 'then Sentinel Hill');
	assert.equal(list[at(list, 'the Jansen Stead well', collects(254546))].step, list[oats].step, 'the well vial with the oats');
	assert.deepEqual(compiled(WESTFALL).steps.filter((st) => st.along).map((st) => st.title), [], 'no along-the-way lists');
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
	// Galardell Valley comes after the camps, on the way back west (Redridge is entered at about 24.5 since
	// Duskwood's first loop comes first, 2026-11-07); Fangore at the valley's north end on the same loop.
	assert.ok(!list[axes].step.goals.some((g) => g.t === 'level'), 'no top-up at the camps');
	assert.ok(list.every(({ goal: g }, i) => g.quest !== 91 || g.t === 'accept' || i > axes), "Solomon's Law's pendants after the camps");
	assert.ok(list.every(({ goal: g }, i) => g.quest !== 180 || g.t === 'accept' || i > axes), "Fangore's paw after the camps");
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
	assert.ok(auberdine[at(auberdine, 'turnin 97926', is('turnin', 97926))].goal.optional, 'turnin 97926 is optional');
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

// --- Flow re-order (2026-11-07, #1100): Alliance Hillsbrad 30-40 walked
// from the Syndicate camp to a point in north-west Alterac and back to the
// camp for Syndicate Assassins, split Farren's Reassignment from Stormwind Ho!
// by a walk across Southshore, and listed the Syndicate on the way.
test(`${HILLSBRAD_ALLIANCE}: flow re-order: the Syndicate camp once, Reassignment with Stormwind Ho!, no along steps`, { skip }, () => {
	const list = goals(HILLSBRAD_ALLIANCE);
	const { steps } = compiled(HILLSBRAD_ALLIANCE);
	assert.deepEqual(steps.filter((st) => st.along).map((st) => st.title), [], 'no along steps');
	const docs = at(list, 'accept 510 (Foreboding Plans)', is('accept', 510));
	const kills = list.filter(({ goal }) => goal.t === 'kill' && goal.quest === 505);
	assert.ok(kills.length && kills.every(({ s }) => s === list[docs].s), 'the Syndicate killed at the camp with the documents');
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
	const chest = data.spawns('object', 28024).find((sp) => sp.map === reagents.goal.map);
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

// --- Flow audit (2026-11-07): Teldrassil killed Ferocitas' mystics, went on
// to the Oracle Glade, Ursal and Lake Al'Ameth, then walked back east to the
// same camp for Ferocitas' necklace and the jewel, and back to Dolanaar for
// Tallonkai alone. The necklace and the jewel come with the mystics; Tallonkai
// takes the jewel as the walk west to the Oracle Glade passes through
// Dolanaar (#1087). The guide's last step told Night Elves to take the boat to
// Stormwind before their own Darkshore guide: it goes, the boat is that guide's.
test(`${TELDRASSIL}: flow audit: Ferocitas' camp once, Tallonkai's jewel on the way through Dolanaar, no boat before Darkshore`, { skip }, () => {
	const list = goals(TELDRASSIL);
	const mystics = at(list, 'kill 7235 (Gnarlpine Mystics)', (g) => g.t === 'kill' && g.quest === 2459);
	const jewel = at(list, 'collect 8050 (Tallonkai\'s Jewel)', (g) => g.t === 'collect' && g.item === 8050);
	assert.equal(list[jewel].s, list[mystics].s, 'the jewel on the mystics\' step');
	const tallonkai = at(list, 'turnin 2459', is('turnin', 2459));
	assert.ok(jewel < tallonkai, 'the jewel is handed in after the camp');
	assert.ok(tallonkai < at(list, 'accept 937 (The Enchanted Glade)', is('accept', 937)), 'on the way to the Oracle Glade, before Arynia');
	const { steps } = compiled(TELDRASSIL);
	assert.ok(!steps.some((st) => /boat/i.test(st.title || '')), 'no boat step in Teldrassil');
	assert.ok(steps.at(-1).goals.length > 0, 'the last step has something to do');
});

// --- Flow re-order (2026-11-07, #1087): Teldrassil sent players back and
// forth. Aldrassil -> north for The Balance of Nature's kills -> back to
// Ilthalaine -> north again to the cave; Dolanaar -> the Fel Cones east ->
// back to Dolanaar to train -> west; the Oracle Glade's moonwell visited three
// times before the Amethyst Phial was filled; two along lists. Now one trip
// north (kills, venom sacs, Iverron), the cones on the road east to Zenn after
// the west loop, training on the Dolanaar stop, the phial on arrival, a
// Warrior's Nessa Shadowsong on the first walk into Darnassus, and no along
// steps.
test(`${TELDRASSIL}: flow re-order: one trip north from Aldrassil, the cones on the road east, the phial on arrival, no along steps`, { skip }, () => {
	const list = goals(TELDRASSIL);
	const { steps } = compiled(TELDRASSIL);
	assert.deepEqual(steps.filter((st) => st.along).map((st) => st.title), [], 'no along steps');
	const kills = at(list, 'kill 2032 (Mangy Nightsabers)', (g) => g.t === 'kill' && g.quest === 457);
	const sacs = at(list, 'collect 5166 (Webwood Venom Sacs)', (g) => g.t === 'collect' && g.quest === 916);
	assert.equal(list[sacs].s, list[kills].s, 'the north kills and the venom sacs in one step');
	assert.equal(list[at(list, 'turnin 457', is('turnin', 457))].s, list[at(list, 'turnin 916', is('turnin', 916))].s, 'The Balance of Nature handed in with the venom sacs');
	const cones = at(list, 'collect 3418 (Fel Cones)', (g) => g.t === 'collect' && g.quest === 489);
	assert.ok(at(list, 'turnin 483 (The Relics of Wakening)', is('turnin', 483)) < cones, 'the cones after the west loop');
	assert.equal(list[cones].s, list[at(list, 'turnin 489', is('turnin', 489))].s, 'the cones on Zenn\'s step');
	const relics = at(list, 'accept 483', is('accept', 483));
	assert.ok(list.some(({ goal, s }) => s === list[relics].s && goal.t === 'train' && goal.class), 'training on the Dolanaar stop that gives the relics');
	const phial = at(list, 'collect 18151 (Amethyst Phial)', (g) => g.t === 'collect' && g.quest === 7383);
	assert.equal(list[phial].s, list[at(list, 'accept 937', is('accept', 937))].s, 'the phial filled on the first moonwell stop');
	const warrior = list.filter(forClass('WARRIOR'));
	assert.ok(at(warrior, 'accept 6344 (Warrior)', is('accept', 6344)) < at(warrior, 'turnin 1684 (Elanaria)', is('turnin', 1684)), 'a Warrior takes Nessa Shadowsong on the first walk into Darnassus');
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
// and Hornizz is handed the plasm afterwards (on the second Desolace stop of
// 30-40/04-dustwallow-marsh since the 2026-11-07 Horde 30-40 re-order, after
// Melizza's escort: Bone Collector and its kodo bones are left out).

test('forever/horde/30-40/04-dustwallow-marsh.guide: Syrael\'s report (#575): the ghost-o-plasm points at the Valley of Bones, after Melizza', { skip }, () => {
	const list = goals('forever/horde/30-40/04-dustwallow-marsh.guide');
	const plasm = at(list, 'collect 15849 (Ghost-o-plasm)', (g) => g.t === 'collect' && g.quest === 6134 && g.item === 15849);
	const { goal } = list[plasm];
	const finished = { map: 1443, x: 63.77, y: 91.6 };
	assert.equal(goal.map, 1443, 'the goal is on Desolace');
	assert.ok(yards(goal, finished) <= 200, `the arrow at ${goal.x},${goal.y} is in the Valley of Bones, not ${Math.round(yards(goal, finished))} yd off`);
	assert.ok(at(list, 'turnin 6132 (Melizza)', is('turnin', 6132)) < plasm, "Melizza's escort comes first");
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

// Thin-data audit (#1317): Elemental Bracers' Divined Scroll is made where the elementals are; the goal pointed at the
// lake's west edge, ~70 yd from every recorded tick (7 people, middle at 49.6,71.3).
test(`${ASHENVALE}: thin-data audit: Elemental Bracers points where players make the Divined Scroll (#1317)`, { skip }, () => {
	const list = goals(ASHENVALE);
	const { goal } = list[at(list, 'collect 5455 (1016)', (g) => g.t === 'collect' && g.quest === 1016)];
	assert.equal(goal.map, 1440, 'Ashenvale');
	assert.ok(Math.hypot(goal.x - 49.6, goal.y - 71.3) < 1, `among the elementals (${goal.x},${goal.y})`);
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
	const darkshore = darkshoreBoth();
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

// --- Flow audit (2026-11-07): the Night Elf start's own Darkshore took the
// boat to Stormwind for Goldshire's training and A Fishy Peril, then sent every
// Night Elf back across the sea for the last part of Bashal'Aran (957: the
// Ancient Flame at Ameth'Aran, then Asterion) and took the boat out again. 957
// is open from the first Bashal'Aran visit: the second loop passes Ameth'Aran
// and ends at Asterion before Auberdine, so the sea is crossed once. The first
// loop captured a Plagued Lands bear 700 yards north-east and walked a thousand
// back south for it: the bears south of Auberdine are on the way to the
// furbolg camp (players' recordings tick it at either place).
const NE_DARKSHORE = 'forever/alliance/nightelf/02-darkshore.guide';
const nightElf = ({ step, goal }) => [step.only, goal.only].every((o) => !o || !o.races || o.races.includes('NightElf'));
// The bones for Washed Ashore are picked on the Long Wash south of Auberdine at
// the end of Teldrassil, and the walk back north passes Gwennyth first: she
// takes them then, not on the next guide's first stop after the Return to
// Nessa flight.
test(`${TELDRASSIL}: flow audit: Washed Ashore is handed to Gwennyth on the walk back from the Long Wash`, { skip }, () => {
	const list = goals(TELDRASSIL);
	const bones = at(list, 'the Sea Creature Bones', (g) => g.t === 'collect' && g.item === 12242);
	const turnin = at(list, 'turnin 3524', is('turnin', 3524));
	assert.ok(bones < turnin, 'the bones, then Gwennyth');
	assert.ok(turnin < at(list, 'accept 954', is('accept', 954)), 'Gwennyth first on the way into Auberdine, before Thundris');
	assert.ok(!goals(NE_DARKSHORE).some(({ goal }) => is('turnin', 3524)(goal)), 'not again in the Night Elf Darkshore');
});
test(`${NE_DARKSHORE}: flow audit: Bashal'Aran is finished before the boat, and the sea is crossed once`, { skip }, () => {
	for (const cls of ['WARRIOR', 'HUNTER', 'ROGUE', 'PRIEST', 'DRUID', 'MAGE', 'PALADIN', 'WARLOCK', 'SHAMAN']) {
		const list = goals(NE_DARKSHORE).filter(nightElf).filter(forClass(cls));
		const boats = list.map((e, i) => (e.goal.t === 'goto' && /^Boat to /.test(e.goal.text || '') ? i : -1)).filter((i) => i >= 0);
		assert.equal(boats.length, 1, `a ${cls} takes one boat`);
		const flame = at(list, `the Ancient Flame for a ${cls}`, (g) => g.t === 'interact' && g.quest === 957);
		const asterion = at(list, `turnin 957 for a ${cls}`, is('turnin', 957));
		const terenthis = at(list, `turnin 985 for a ${cls}`, is('turnin', 985));
		assert.ok(at(list, `accept 4728 for a ${cls}`, is('accept', 4728)) < flame, `a ${cls}: the southern beach, then Ameth'Aran's flame`);
		assert.ok(flame < asterion && asterion < terenthis && terenthis < boats[0], `a ${cls}: the flame, Asterion and Auberdine before the boat`);
		assert.ok(list.slice(boats[0] + 1).every(({ goal }) => goal.map == null || goal.map !== list[flame].goal.map), `a ${cls}: nothing in Darkshore after the boat`);
		const bear = at(list, `the Plagued Lands bear for a ${cls}`, (g) => g.t === 'complete' && g.quest === 2118);
		const camp = at(list, `the furbolg camp for a ${cls}`, (g) => g.t === 'complete' && g.quest === 984);
		assert.equal(list[bear].step, list[camp].step, `a ${cls}: the bear is captured on the way to the furbolg camp`);
		assert.ok(camp < at(list, `accept 953 for a ${cls}`, is('accept', 953)), `a ${cls}: before Ameth'Aran`);
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
// then walked about 2,400 yards to Ratchet's flight master and back to the zeppelin afterwards. Since the
// Horde 12-30 re-chain (Silverpine first, the Barrens at 15-21) they fly from the Crossroads stop after
// Echeyakee to Thunder Bluff, and from there straight on to Ratchet, where everyone flies next: no stop at
// the Crossroads with nothing to do between two flights, and no zeppelin round trip from the Sepulcher.
test('Flight path sweep (#964): Druids fly to Thunder Bluff from the Crossroads at 16 and on to Ratchet, not by zeppelin', { skip }, () => {
	for (const race of ['Tauren', 'Skyborne']) {
		const barrens = goals('forever/horde/02-the-barrens.guide').filter(forRaceOf(race)).filter(forClass('DRUID'));
		const mura = at(barrens, `${race}: the Crossroads stop after Echeyakee`, is('turnin', 880));
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
	assert.equal(shaman.filter(({ goal }) => goal.t === 'fly' && goal.location === 'Camp Taurajo').length, 2, 'two flights to Camp Taurajo (from Zoram\'gar and Thunder Bluff), none from Freewind Post');
});

// Maazias's report (#1333): The Tear of the Moons is a level 30 quest; its strongbox stands beside
// General Twinbraid (30) and his Officers (26). Done with Gann Stonespire's Bael Modan quests in the
// Barrens 24-26 it came at 26 for every Horde start, and the guide frame told everyone to reach 28
// first. It is taken on the next pass, the road from Camp Taurajo to the Great Lift, at about 28.
test(`${ASHENVALE_HORDE}: Maazias's report: The Tear of the Moons is done on the road from Camp Taurajo to the Great Lift, not in the Barrens 24-26 (#1333)`, { skip }, () => {
	assert.deepEqual(goals('forever/horde/04-the-barrens.guide').filter(({ goal }) => goal.quest === 857).map(({ goal }) => goal.t), [], 'not in the Barrens 24-26');
	for (const [race, cls] of [['Orc', 'MAGE'], ['Tauren', 'SHAMAN'], ['Undead', 'PALADIN']]) {
		const list = goals(ASHENVALE_HORDE).filter(forRaceOf(race)).filter(forClass(cls));
		const taurajo = list.findLastIndex(({ goal }) => goal.t === 'fly' && goal.location === 'Camp Taurajo');
		const accept = at(list, 'accept 857', is('accept', 857));
		const box = at(list, 'the strongbox (857)', (g) => g.quest === 857 && g.t === 'collect');
		const turnin = at(list, 'turnin 857', is('turnin', 857));
		assert.ok(taurajo >= 0 && taurajo < accept && accept < box && box < turnin, `${race} ${cls}: after the flight to Camp Taurajo, taken, done and handed in`);
		assert.ok(turnin < at(list, 'turnin 4542 (Message to Freewind Post)', is('turnin', 4542)), `${race} ${cls}: before the Great Lift and Freewind Post`);
		assert.match([list[box].step.note, list[box].step.tip].flat().filter(Boolean).join(' '), /General Twinbraid.*\(30\)/, 'the step names General Twinbraid and his level');
	}
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
		// (Super Sticky 4504 is taken on the later Gadgetzan stop since the Alliance 40-60 order, #1228: the arrival step is found by Gaeriyan's hand-in.)
		['alliance/40-50/07-un-goro-crater', 'turnin 2941', /From Ratchet/],
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
		['horde/04-the-barrens', 'accept 4542', /Fly from Thunder Bluff/],
		['horde/07-ashenvale', 'turnin 1534', /Fly from Thunder Bluff/],
		['horde/40-50/06-azshara', 'goto 32.2,27.7 "Grom\'gol Base Camp"', /Valormok/],
		['horde/40-50/02-feralas', 'Alodan the Hopeful (Paladins).', /from Gadgetzan/],
		// (Since the Horde 30-40 re-order the Druids fly from Freewind Post, Orgrimmar and Shadowprey Village straight to Thunder Bluff.)
		['horde/30-40/01-hillsbrad-foothills', 'only Druid\n  zone Thunder Bluff\n  tip Fly from', /from Orgrimmar|from Shadowprey/],
		['horde/30-40/03-stranglethorn-vale', 'only Druid\n  zone Thunder Bluff\n  tip Fly from', /from Orgrimmar/],
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
	for (const guide of ['forever/class/druid/cat-form.guide', 'forever/alliance/03-darkshore-return.guide', 'forever/horde/02-the-barrens.guide']) {
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
		['forever/horde/02-the-barrens.guide', 'The Crossroads', [903, 881]],
		['forever/horde/04-the-barrens.guide', 'Sun Rock Retreat', [86576, 5881]],
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

// Erá's report (#1130): the Venture Co. Work Order for Goblin Lockpicks is picked from the Venture Co. Loggers'
// pockets, but the collect goal's text, built from the item's NPC source, said "Kill Venture Co. Logger for
// Venture Co. Work Order". Every rogue collect whose item comes by Pick Pocket says so.
test("Erá's report (#1130): rogue items that come by Pick Pocket say Pick Pocket, not Kill", { skip }, () => {
	for (const [guide, item] of [
		['forever/class/rogue/the-horn-of-xelthos.guide', 210187],
		['forever/class/rogue/blade-of-cunning-alliance.guide', 7675],
		['forever/class/rogue/blade-of-cunning-alliance.guide', 7737],
		['forever/class/rogue/blade-of-cunning-horde.guide', 7208],
		['forever/class/rogue/poisons-alliance.guide', 7923],
		['forever/class/rogue/poisons-horde.guide', 8072],
		['forever/class/rogue/ravenholdt.guide', 17124],
		['forever/class/rogue/ravenholdt.guide', 275482],
	]) {
		const found = goals(guide).find(({ goal }) => goal.t === 'collect' && goal.item === item);
		assert.ok(found, `${guide}: collect ${item} is in the guide`);
		assert.match(found.goal.text || '', /^Pick Pocket /, `${guide}: collect ${item} says Pick Pocket`);
	}
});

// --- Flow audit (2026-11-07, Elwynn Forest): the first Goldshire stop zig-zagged (the inn, Remy, back to the
// inn, then Dughan across the road); Baited for Success was carried past Jason Mathers on the walk east and
// handed in on the walk back, as was the kelp from the murlocs that walk passes; Princess waited for a second
// trip south after the logging camp; and the end went Goldshire -> Westbrook -> back to Goldshire -> the
// gnolls -> Westbrook -> Maybell and the Stonefield Farm -> the still -> Westbrook. Now: Dughan, Remy, then the
// inn; Jason and the kelp on the walk east; Princess with Downstream; and Goldshire -> Maybell -> the
// Stonefield Farm -> the still -> Westbrook -> the gnolls -> Westbrook, as the seed has it.
test(`${ELWYNN}: flow audit: Goldshire in walking order, Jason and the kelp on the walk east, Princess with Downstream, one pass to Westbrook`, { skip }, () => {
	const list = goals(ELWYNN);
	const idx = (what, t, q) => at(list, what, is(t, q));
	const farley = idx('turnin 2158', 'turnin', 2158);
	for (const [t, q] of [['turnin', 54], ['accept', 47]]) {
		const i = idx(`${t} ${q}`, t, q);
		assert.ok(i < farley && list[i].s === list[farley].s, `${t} ${q} before Innkeeper Farley on the first Goldshire stop`);
	}
	const tower = idx('accept 91723', 'accept', 91723);
	assert.ok(idx('turnin 99131', 'turnin', 99131) < tower, 'Baited for Success handed to Jason on the walk east');
	assert.ok(at(list, 'the kelp', (g) => g.t === 'collect' && g.item === 1256) < tower, 'the kelp on the walk east');
	const collar = list[at(list, 'the Brass Collar', (g) => g.t === 'collect' && g.item === 1006)];
	const saw = list[at(list, 'the Waterlogged Saw', (g) => g.t === 'collect' && g.item === 247813)];
	assert.equal(collar.s, saw.s, 'Princess in the Downstream step');
	const westbrook = idx('turnin 239', 'turnin', 239);
	for (const [t, q] of [['turnin', 114], ['turnin', 87], ['turnin', 88], ['accept', 1685]]) assert.ok(idx(`${t} ${q}`, t, q) < westbrook, `${t} ${q} before Westbrook Garrison`);
	assert.deepEqual(list.slice(westbrook).filter(({ step }) => /Goldshire/.test(step.title || '')).map(({ s }) => s), [], 'no walk back to Goldshire after Westbrook');
	assert.deepEqual(compiled(ELWYNN).steps.filter((st) => st.along).map((st) => st.title), [], 'no along-the-way lists');
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
	assert.equal(stepIn(one, 'turnin 174', 'turnin', 174), first, 'Look to the Stars handed in on the first Darkshire visit');
	assert.equal(stepIn(one, 'accept 175', 'accept', 175), first, 'and its second part taken there');
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

// Fitz's report (#1149): The Barrens' "The Zhevra" step sent the arrow to `goto 52.5,27.5 "Zhevra"` by the
// Crossroads, then 432 yards on to the nearest Zhevra Runner: a goto from the hand-written v1 route with nothing to
// do at it. In a written guide a goto right before a kill or collect leads to that work: its nearest spot is within
// 200 yards, or the goto is a way in (a cave or subzone, with its area). The others (the Razormane camp's prowler
// claws, Feralas' forest walkers, Corin's Crossing pointing at Nathanos) went with it.
test("Fitz's report (#1149): a goto before a kill or collect in a written guide leads to that work", { skip }, () => {
	data = data || loadData(DATA);
	const { point } = makeProjector(data.mapFrames);
	const at2 = (map, x, y, f) => point(map, x, y, f === 'e' ? 'e' : 'l');
	const bad = [];
	for (const guide of allGuides()) {
		if (!fs.readFileSync(path.join(OFFICIAL_DIR, guide), 'utf8').startsWith('# Generated')) continue;
		for (const step of compiled(guide).steps) {
			const gs = step.goals;
			for (let i = 0; i + 1 < gs.length; i++) {
				const a = gs[i], b = gs[i + 1];
				if (a.t !== 'goto' || a.map == null || a.area || !['kill', 'collect'].includes(b.t)) continue;
				const spots = b.spots && b.spots.length ? b.spots.map((p) => ({ map: p.map || b.map, ...p })) : b.map != null ? [b] : [];
				const from = at2(a.map, a.x, a.y, a.f);
				let best = Infinity;
				for (const p of spots) {
					const to = at2(p.map || b.map, p.x, p.y, p.f || b.f);
					if (to.c === from.c) best = Math.min(best, dist(from, to));
				}
				if (best > 200 && best < Infinity) bad.push(`${guide}: step "${step.title}": goto ${a.x},${a.y} is ${Math.round(best)} yd from ${b.t} ${b.quest || ''} ${b.item || b.npc || ''}`);
			}
		}
	}
	assert.deepEqual(bad, []);
});

// #1149 (Corin's Crossing): the step's goto pointed at Nathanos's camp (26.5,74.7), far west of the town where
// Living Rot drops. The town's point lives in the seed now, so every Forge build writes it.
test("Fitz's report (#1149): Eastern Plaguelands' Corin's Crossing step leads to the town, in the guide and its seed", () => {
	const rel = 'forever/horde/50-60/05-eastern-plaguelands.guide';
	for (const file of [path.join(OFFICIAL_DIR, rel), path.join(__dirname, '..', 'forge', 'seed', 'guides', rel)]) {
		const text = fs.readFileSync(file, 'utf8');
		const step = text.split(/\n(?=step )/).find((s) => s.startsWith("step Corin's Crossing\n"));
		assert.ok(step, `${file}: a Corin's Crossing step`);
		assert.match(step, /\n\s+goto 52\.3,58\.2 "Corin's Crossing" live\n/, `${file}: the goto is the town`);
		assert.doesNotMatch(step, /goto 26\.5,74\.7/, `${file}: not Nathanos's camp`);
	}
});

// A Paladin's report on Discord (2026-11-07): the level 12 Redemption chain came up again and again though it was
// done. Duthorian Rall's The Tome of Divinity (1641; Tiza Battleforge's 1645) is a repeatable quest he takes back
// straight from the quest window: players' recordings have its hand-in and no accept, and the client never flags it
// completed, so an `accept` goal for it reopened after every reload. Such quests are `turnin <id> direct` (the
// Tomes of Valor, the Saptas too).
test('Repeatable quests handed straight back at their giver are direct turn-ins with no accept (the Tome of Divinity)', { skip }, () => {
	for (const [guide, quests] of [
		['forever/class/paladin/tome-of-divinity.guide', [1641, 1645]],
		['forever/alliance/02-westfall.guide', [1641]],
		['forever/class/paladin/verigans-fist.guide', [1793, 1794]],
		['forever/class/shaman/call-of-earth-alliance.guide', [94472]],
		['forever/class/shaman/call-of-earth-horde.guide', [1462, 1463]],
		['forever/class/shaman/call-of-fire-alliance.guide', [94473]],
		['forever/class/shaman/call-of-fire-horde.guide', [1464]],
		['forever/class/shaman/call-of-water-horde.guide', [972]],
	]) {
		const list = goals(guide);
		for (const q of quests) {
			assert.ok(!list.some(is('accept', q)), `${guide}: no accept ${q}`);
			const turnin = list.find(({ goal }) => is('turnin', q)(goal));
			assert.ok(turnin && turnin.goal.direct === true, `${guide}: turnin ${q} direct`);
		}
	}
});

// #1117 (soockee, Tauren Shaman; #383 and #396 before it, Dwarf Paladins): Alonso's Dragonslayer quests
// at Mystral Lake are for Warriors; other classes find no Alonso there. The lock lived only in
// data/rules.json, which Forge does not read, so the generated Horde Ashenvale guide sent every class to
// him. The record is the class in forever-db/corrections/quests.json.
test("soockee's report (#1117): only Warriors are sent to Alonso for the Dragonslayer quests", { skip }, () => {
	const corrections = JSON.parse(fs.readFileSync(path.join(__dirname, '..', 'forever-db', 'corrections', 'quests.json'), 'utf8'));
	const ALONSO = [78132, 78133, 78134];
	for (const q of ALONSO) assert.equal(corrections[q] && corrections[q].set.classes, 1, `${q}: the Warrior class is a correction the build applies`);
	let warrior = 0;
	for (const guide of allGuides().filter((f) => /^forever\/(horde|alliance)\//.test(f))) {
		const list = goals(guide).filter(({ goal }) => ALONSO.includes(goal.quest));
		for (const cls of ['PALADIN', 'SHAMAN', 'DRUID', 'HUNTER', 'ROGUE', 'PRIEST', 'MAGE', 'WARLOCK']) {
			assert.deepEqual(list.filter(forClass(cls)).map(({ goal }) => `${goal.t} ${goal.quest}`), [], `${guide}: no Alonso quest for a ${cls}`);
		}
		warrior += list.filter(forClass('WARRIOR')).length;
	}
	assert.ok(warrior > 0, 'a Warrior still takes them');
});

// Rohkin's report (#1123): Mountain Lion Blood's few, contested lions were a stop of their own on the way down to
// Hillsbrad Fields. They stand between the fields and Tarren Mill: the blood comes after the farmers, on the walk
// back to Tarren Mill, where both are handed in (route-fixes pair task 527 before task 501, Horde).
test("Rohkin's report (#1123): Mountain Lion Blood on the walk back from Hillsbrad Fields, before Tarren Mill", { skip }, () => {
	const fixes = JSON.parse(fs.readFileSync(path.join(__dirname, '..', 'data', 'route-fixes.json'), 'utf8'));
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
// lines with the peaks players placed them on; the guide places each vial, then hands it in on a later visit.
test("Konky88's report (#1150): Valuable Vantages' three vials come before its hand-in, not in the step that takes it", { skip }, () => {
	const list = goals('forever/horde/06-hillsbrad-foothills.guide');
	const accept = at(list, 'accept 98095', is('accept', 98095));
	const turnin = at(list, 'turnin 98095', is('turnin', 98095));
	assert.notEqual(list[accept].s, list[turnin].s, 'not handed in in the step that takes it');
	for (const oi of [1, 2, 3]) {
		const vial = at(list, `objective 98095.${oi}`, (g) => g.quest === 98095 && g.oi === oi);
		assert.ok(accept < vial && vial < turnin, `vial ${oi} between the accept and the hand-in`);
		assert.ok(located(list[vial]), `vial ${oi} has a place`);
	}
});

// Erá's report (#1160): The Eye of Bhossca, C's second job, comes with C's letter in a capital city's mailbox at
// level 30 (after the horn job), not at the quest data's 25. The guide, its correction and the class-quest
// heads-up all wait for 30.
test("Erá's report (#1160): The Eye of Bhossca waits for level 30", { skip }, () => {
	const guide = 'forever/class/rogue/the-eye-of-bhossca.guide';
	assert.match(fs.readFileSync(path.join(OFFICIAL_DIR, guide), 'utf8'), /^levels 30-35$/m);
	const list = goals(guide);
	const accept = at(list, 'accept 78676', is('accept', 78676));
	const gate = list.find(({ step, goal }) => step === list[accept].step && goal.t === 'level');
	assert.equal(gate && gate.goal.level, 30, 'a level 30 gate before the Dead Drop');
	const corrections = JSON.parse(fs.readFileSync(path.join(__dirname, '..', 'forever-db', 'corrections', 'quests.json'), 'utf8'));
	assert.equal(corrections[78676].set.minLevel, 30, 'the correction a data build applies');
	assert.match(fs.readFileSync(path.join(__dirname, '..', 'addon', 'Polestar', 'UI', 'ClassRewards.lua'), 'utf8'), /\[78676\] = \{ 30, /, 'the heads-up starts at 30');
});

// --- Flow re-order (2026-11-07, Alliance starts 1-20): the walks below crossed back over ground for one
// hand-in. Northshire: Garrick's head went to Willem on a trip back to the Abbey steps between Garrick's camp
// and Milly in the vineyard; now Milly first, Willem with Skirmish at Echo Ridge on the Abbey visit after the
// mine.
test(`${ELWYNN}: flow re-order: Milly's Harvest at Milly, Garrick's head on the Abbey visit after the mine`, { skip }, () => {
	const list = goals(ELWYNN);
	const idx = (t, q) => at(list, `${t} ${q}`, is(t, q));
	assert.ok(idx('turnin', 3904) < idx('turnin', 6), "Milly's Harvest before Garrick's head");
	assert.equal(list[idx('turnin', 6)].s, list[idx('turnin', 21)].s, 'Garrick handed in with Skirmish at Echo Ridge');
});

// Coldridge and Kharanos: the Dwarf guide took the five-minute Scalding Mornbrew before the troll whelps and
// Felix's parts, and both starts walked to Steelgrill's Depot for Stocking Jetsteam alone, then came back after
// the Grizzled Den for The Grizzled Den. Now the Mornbrew is the last thing taken at Grelin's camp before Anvilmar,
// and both pilots take their quests on one depot stop after the den.
for (const guide of DUN_MOROGHS) {
	test(`${guide}: flow re-order: the Mornbrew taken last at Grelin's camp, one depot stop for both pilots`, { skip }, () => {
		const list = goals(guide);
		const idx = (t, q) => at(list, `${t} ${q}`, is(t, q));
		const brew = idx('accept', 3364);
		assert.ok(idx('turnin', 182) < brew, 'the whelps are handed in before the Mornbrew is taken');
		assert.ok(list.slice(brew + 1, idx('turnin', 3364)).every(({ goal }) => !['kill', 'collect'].includes(goal.t)), 'no field work while the Mornbrew cools');
		assert.equal(list[idx('turnin', 317)].s, list[idx('turnin', 313)].s, 'Stocking Jetsteam and The Grizzled Den on one depot stop');
		assert.ok(at(list, 'the Wendigo Manes', (g) => g.t === 'collect' && g.item === 2671) < idx('turnin', 317), 'after the den');
	});
}

// #1224 (Dwarf Hunter, Coldridge Valley): the Frostmane Troll Whelps for The Troll Cave were an along list
// before Grelin's hand-in, and the field step held only for Felix's three parts, so the route moved on to Grelin
// with the whelp count short. The whelps are now goals of the Coldridge field step, with Felix's parts.
for (const guide of DUN_MOROGHS) {
	test(`${guide}: #1224: the troll whelps are worked in the Coldridge field step with Felix's parts, before Grelin`, { skip }, () => {
		const list = goals(guide);
		const whelps = at(list, 'kill 706 (Frostmane Troll Whelp) for 182', (g) => g.t === 'kill' && g.npc === 706 && g.quest === 182);
		assert.ok(!list[whelps].step.along, 'the whelps are not an along list');
		assert.equal(list[whelps].s, list[at(list, "Felix's Chest", (g) => g.t === 'collect' && g.item === 16313)].s, "in the step with Felix's parts");
		assert.ok(whelps < at(list, 'turnin 182', is('turnin', 182)), 'before Grelin takes The Troll Cave back');
		assert.equal(list.filter(({ goal }) => goal.t === 'kill' && goal.npc === 706 && goal.quest === 182).length, 1, 'one whelp goal');
	});
}

// Darkshore: Fruit of the Sea's crab chunks come with Cliffspring Falls; the walk passed Gubber Blump with them
// on the next Auberdine visit and handed them in a loop later.
test(`${DARKSHORE}: flow re-order: Fruit of the Sea handed in on the Auberdine visit after Cliffspring Falls`, { skip }, () => {
	const list = goals(DARKSHORE);
	const idx = (t, q) => at(list, `${t} ${q}`, is(t, q));
	assert.equal(list[idx('turnin', 1138)].s, list[idx('turnin', 4762)].s, 'with the Cliffspring River sample');
	assert.ok(idx('turnin', 1138) < idx('turnin', 1001), 'before the north loop');
});

// Zephras Isle (Alliance): from the Ursera den the guide went to Hanaa first and walked back north to the
// grove; now the grove's hand-ins, then Hanaa on the way south to Shen'dar.
test(`${ZEPHRAS_ALLIANCE}: flow re-order: Aetheen and Valreaa before Hanaa, on the way south`, { skip }, () => {
	const list = goals(ZEPHRAS_ALLIANCE);
	const idx = (t, q) => at(list, `${t} ${q}`, is(t, q));
	assert.ok(idx('turnin', 92470) < idx('accept', 92544), 'Aetheen before Hanaa');
	assert.ok(idx('turnin', 92473) < idx('accept', 92544), 'Valreaa before Hanaa');
	assert.ok(idx('turnin', 92544) < idx('turnin', 92472), 'Hanaa before Shen\'dar');
});

// Flow re-order (2026-11-07): Alliance Hillsbrad 30-40 took only the Captive Fire Elemental at Dun Modr
// on the way north and came back to the same camp for Longbraid, Rhag, Roggo and the Heart of Modr,
// walking past the Villards twice.
test(`${HILLSBRAD_ALLIANCE}: flow re-order: Dun Modr in one stop, the Villards on the way north, Ebenezer on the crossing`, { skip }, () => {
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
	assert.ok(stepOf('accept', 87318) > dunModr && stepOf('accept', 87318) < span, 'the Villards between Dun Modr and the span');
	assert.equal(stepOf('turnin', 631), stepOf('turnin', 87318), 'Ebenezer handed in beside Essene, before the crossing (final review: every race)');
	// #1314: Corma Villard did not offer Hearts of the Lost to a player at 32; it stays, optional, with a tip to skip it.
	const hearts = list.filter(({ goal }) => goal.quest === 87318);
	assert.ok(hearts.length >= 2 && hearts.every(({ goal }) => goal.optional), '87318 is optional (#1314)');
	assert.ok([hearts[0].step.note, hearts[0].step.tip].flat().filter(Boolean).join(' ').includes('may not offer Hearts of the Lost'), 'the step says to skip it if she does not offer it');
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
	for (const i of [accept, turnin]) assert.deepEqual([...(list[i].goal.only?.races ?? [])].sort(), ['Dwarf', 'Gnome', 'NightElf', 'Skyborne'], `${list[i].goal.t} 647 keeps its races`);
});

// --- Timed-quest check (2026-11-08, #1319's pattern): A Meal Served Cold (212) must be back with Angus Stern in Stormwind
// within 30 minutes. The route took it in Stormwind in 30-40/05 and handed it in two guides later: it always ran out. Left out.
test('A Meal Served Cold (30-minute limit) is in no leveling guide', { skip }, () => {
	for (const guide of allGuides().filter((g) => /^forever\/(alliance|horde)\//.test(g))) {
		assert.equal(goals(guide).filter(({ goal }) => goal.quest === 212).length, 0, `${guide}: no 212`);
	}
});

// Flow re-order (2026-11-07): Alliance Desolace made the Scorpashi venom a stop of its own at Kormek's Hut
// after the Kodo Graveyard, then walked back to the graveyard for the last hides.
test('forever/alliance/30-40/02-desolace.guide: flow re-order: the Scorpashi venom with the kodos at the Kodo Graveyard, no Kormek\'s Hut stop', { skip }, () => {
	const list = goals('forever/alliance/30-40/02-desolace.guide');
	const kodos = list.find(({ goal }) => goal.t === 'kill' && goal.quest === 5561);
	const venom = list.filter(({ goal }) => goal.t === 'collect' && goal.item === 6248);
	const hides = list.filter(({ goal }) => goal.t === 'collect' && goal.item === 6249);
	assert.ok(kodos && venom.length === 1 && venom[0].s === kodos.s, 'the venom on the Kodo Graveyard step');
	assert.ok(hides.length === 1 && hides[0].s === kodos.s, 'the hides there, once');
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
	assert.ok(!goals('forever/alliance/30-40/04-stranglethorn-vale.guide').some(({ goal }) => [210, 328, 627].includes(goal.quest)), 'not on the first loop at 33-34');
});

// Flow re-order (2026-11-07): Alliance Arathi took the tusks and pouches from the few Witherbark west of
// Refuge Pointe and made a second trip to Witherbark Village for the knife.
test(`${ARATHI}: flow re-order: Worth Its Weight in Gold in one visit to Witherbark Village`, { skip }, () => {
	const list = goals(ARATHI);
	const work = list.filter(({ goal }) => goal.t === 'collect' && goal.quest === 691);
	assert.deepEqual(work.map(({ goal }) => goal.item).sort(), [4503, 4522, 5040], 'tusks, pouches and knife listed once each');
	assert.equal(new Set(work.map(({ s }) => s)).size, 1, 'all three on one step');
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
	assert.ok(work(880) < work(875) && work(875) < eche, 'Lushwater, the Dry Hills, then Echeyakee');
	// Since the Horde 12-30 re-chain Samophlange waits for the Ratchet stop at 18 (no walk from the Sludge Fen
	// to Ratchet and back to the Razormane camp), and Wenikee's Nugget Slugs go with the second Sludge Fen visit.
	const fen = stepOf('accept', 858);
	assert.ok(stepOf('turnin', 902) < stepOf('turnin', 3921) && stepOf('turnin', 3921) < fen && fen < work(3922) && work(3922) < stepOf('turnin', 3922), 'Samophlange at Ratchet, Wenikee around the second Sludge Fen visit');
	const last = stepOf('turnin', 869);
	assert.ok(eche < last, 'the raptor heads after Echeyakee');
	for (const [t, q] of [['turnin', 881], ['turnin', 880], ['turnin', 875]]) assert.equal(stepOf(t, q), last, `${t} ${q} on the final Crossroads visit`);
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

test(`${TROLL_DUROTAR}: flow review: Lar Prowltusk on the first Sen'jin stop, Razor Hill once after the keep, eggs and fur on the coast walk`, { skip }, () => {
	const list = goals(TROLL_DUROTAR);
	const stepOf = (t, q) => list[at(list, `${t} ${q}`, is(t, q))].s;
	assert.equal(stepOf('accept', 786), stepOf('turnin', 805), "Lar with Master Gadrin on the first Sen'jin stop");
	assert.equal(stepOf('turnin', 96822), stepOf('turnin', 784), 'Turroc and Gar\'Thok on one Razor Hill visit');
	const coast = list.find(({ goal }) => goal.t === 'collect' && goal.quest === 825).s;
	assert.equal(list.find(({ goal }) => goal.t === 'collect' && goal.quest === 815).s, coast, 'the eggs on the coast walk');
	assert.ok(list.find(({ goal }) => goal.t === 'collect' && goal.quest === 817).s < list.find(({ goal }) => goal.t === 'collect' && goal.quest === 826).s, 'the tiger fur on the first isle, before the southern isles');
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

// Flow review, Horde 40-60 (#1166): "Sea Wolf" MacKinley offers Scaring Shaky on the first Booty Bay stop; it waited for
// the next Booty Bay stop after the Bloodsail note. Stoley's Debt (minimum level 40) is taken from him with Return to
// MacKinley since the Horde 40-60 accept-level fix (2026-11-08): the route lands from Kargath at about 39.7.
test('forever/horde/40-50/01-stranglethorn-vale.guide: flow re-order: Scaring Shaky on the first Booty Bay stop, Stoley\'s Debt with Return to MacKinley', { skip }, () => {
	const list = goals('forever/horde/40-50/01-stranglethorn-vale.guide');
	const shaky = list[at(list, 'accept 606', is('accept', 606))];
	const stoley = list[at(list, 'accept 2872', is('accept', 2872))];
	assert.ok(shaky.s < list[at(list, 'turnin 595', is('turnin', 595))].s, 'Scaring Shaky before the Bloodsail note');
	assert.equal(stoley.s, list[at(list, 'turnin 607', is('turnin', 607))].s, 'Stoley\'s Debt on the step that hands MacKinley Return to MacKinley');
});

// Flow review, Horde 40-60 (#1166): the last loop out of Camp Mojache is one sweep west: the Writhing Deep, the Ruins
// of Isildien, Feral Scar Vale, then one Mojache stop for every hand-in. The ruins went with the Grimtotem loop and
// the hive had a Mojache return of its own; the beacon (any Feralas mob drops it) had a ride to the Forgotten Coast.
test('forever/horde/40-50/02-feralas.guide: flow re-order: one sweep from the Writhing Deep west, no ride to the Forgotten Coast', { skip }, () => {
	const list = goals('forever/horde/40-50/02-feralas.guide');
	const hive = at(list, 'collect 18961 quest 7730', (g) => g.t === 'collect' && g.item === 18961);
	const ruins = at(list, 'kill 5236 quest 2980', (g) => g.t === 'kill' && g.quest === 2980);
	const yetis = at(list, 'collect 8973 quest 2822', (g) => g.t === 'collect' && g.item === 8973);
	const handIn = at(list, 'turnin 7730', is('turnin', 7730));
	assert.ok(hive < ruins && ruins < yetis && yetis < handIn, 'the hive, the ruins, the yetis, then Mojache');
	for (const q of [2980, 2822, 7731]) assert.equal(list[at(list, `turnin ${q}`, is('turnin', q))].s, list[handIn].s, `${q} on the same Mojache stop`);
	assert.ok(!list.some(({ goal }) => goal.map === 1444 && goal.x != null && goal.x < 35), 'no ride to the Forgotten Coast');
});

// Flow review, Horde 40-60 (#1166): the Pool of Tears on the ride east before Misty Reed Post (it went Misty Reed,
// pool, Misty Reed); Natural Materials' minerals with the logs and the sinew with the fragments; Improved Quality
// (taken on the previous Feralas visit) done on the ride back from the harpies and handed in on the last Mojache stop.
test('forever/horde/40-50/03-feralas.guide: flow re-order: the Pool of Tears before Misty Reed, the Rage Scar yetis on the way back', { skip }, () => {
	const file = 'forever/horde/40-50/03-feralas.guide';
	const list = goals(file);
	assert.ok(at(list, 'collect 6175 quest 1424', (g) => g.t === 'collect' && g.item === 6175) < at(list, 'turnin 699', is('turnin', 699)), 'the pool before Misty Reed Post');
	const step = (item) => list[at(list, `collect ${item}`, (g) => g.t === 'collect' && g.item === item)].s;
	assert.equal(step(9589), step(9590), 'minerals and logs on one step');
	assert.equal(step(9591), step(9592), 'sinew and fragments on one step');
	const harpies = at(list, 'kill 5366 quest 3063', (g) => g.t === 'kill' && g.quest === 3063);
	const yetis = at(list, 'collect 18947 quest 7734', (g) => g.t === 'collect' && g.item === 18947);
	const turnin = at(list, 'turnin 7734', is('turnin', 7734));
	assert.ok(harpies < yetis && yetis < turnin, 'harpies, Rage Scar yetis, then Mojache');
	assert.equal(list[turnin].s, list[at(list, 'turnin 3063', is('turnin', 3063))].s, 'with Talo\'s hand-in');
	assert.ok(goals('forever/horde/40-50/02-feralas.guide').some(({ goal }) => is('accept', 7734)(goal)), 'Improved Quality comes from the previous guide');
	assert.ok(!goals('forever/horde/40-50/06-azshara.guide').some(({ goal }) => is('turnin', 7734)(goal)), 'not carried to the Azshara guide');
});

// Flow review, Horde 40-60 (#1166): Caught! is handed in at the outhouse right after its work (the guide came back to
// the dig site at the end), and the Smithing Tuyere drops from the same Steamsmiths as the Thorium Plated Daggers.
test('forever/horde/40-50/04-tanaris.guide: flow re-order: Caught! on the spot, the tuyere with the daggers', { skip }, () => {
	const list = goals('forever/horde/40-50/04-tanaris.guide');
	const caught = list[at(list, 'turnin 4449', is('turnin', 4449))];
	assert.equal(caught.s, list[at(list, 'collect 4306 quest 4449', (g) => g.t === 'collect' && g.item === 4306)].s, 'handed in on the dig site step');
	assert.ok(caught.s < list[at(list, 'accept 7728', is('accept', 7728))].s, 'before Thorium Point');
	const step = (item) => list[at(list, `collect ${item}`, (g) => g.t === 'collect' && g.item === item)].s;
	assert.equal(step(18959), step(10551), 'the tuyere on the daggers step');
});

// Flow review, Horde 40-60 (#1166): Salfa stands where Timbermaw Hold's tunnel comes out; Speak to Salfa was carried
// to Everlook and back west.
test('forever/horde/50-60/03-winterspring.guide: flow re-order: Salfa where the tunnel comes out', { skip }, () => {
	const list = goals('forever/horde/50-60/03-winterspring.guide');
	const salfa = at(list, 'turnin 8465', is('turnin', 8465));
	assert.ok(salfa < at(list, 'accept 3783', is('accept', 3783)), 'before Everlook');
	assert.equal(list[salfa].s, list[at(list, 'accept 8464', is('accept', 8464))].s, 'Winterfall Activity taken there');
});

// Flow review, Horde 40-60 (#1166): the flight lands in Ratchet, so Liv and Islen come first and the ride north ends
// at Dokimi in the Crossroads; it rode north to the Crossroads and back to Ratchet.
test('forever/horde/50-60/04-azshara.guide: flow re-order: Ratchet first, then the crates at the Crossroads', { skip }, () => {
	const list = goals('forever/horde/50-60/04-azshara.guide');
	const crates = at(list, 'accept 91899', is('accept', 91899));
	assert.ok(at(list, 'turnin 4147', is('turnin', 4147)) < crates && at(list, 'turnin 5158', is('turnin', 5158)) < crates, 'Liv and Islen before the crates');
});

// Flow review, Horde 40-60 (#1166): Corin's Crossing on the ride south from Quel'Lithien Lodge, all three hand-ins to
// Nathanos in one visit (it rode from the Marris Stead to the crossing and back); The Everlook Report at the Bulwark on
// the way in (it waited two guides for another Bulwark stop).
test('forever/horde/50-60/05-eastern-plaguelands.guide: flow re-order: Corin\'s Crossing before Nathanos, The Everlook Report at the Bulwark', { skip }, () => {
	const list = goals('forever/horde/50-60/05-eastern-plaguelands.guide');
	const rot = at(list, 'collect 15447', (g) => g.t === 'collect' && g.item === 15447);
	const nathanos = at(list, 'turnin 6133', is('turnin', 6133));
	assert.ok(rot < nathanos, 'Corin\'s Crossing before Nathanos');
	assert.equal(list[at(list, 'turnin 6022', is('turnin', 6022))].s, list[nathanos].s, 'To Kill With Purpose on the same visit');
	assert.ok(at(list, 'turnin 6029', is('turnin', 6029)) < at(list, 'turnin 5229', is('turnin', 5229)), 'the Bulwark on the way to Felstone Field');
	assert.ok(!goals('forever/horde/50-60/06-silithus.guide').some(({ goal }) => is('turnin', 6029)(goal)), 'not carried to the Silithus guide');
});

// Flow review, Horde 40-60 (#1166): Chromie offers Counting Out Time on A Matter of Time's hand-in and the lockboxes are
// around her inn; it waited for a return to Chromie later in the guide.
test('forever/horde/50-60/06-silithus.guide: flow re-order: Counting Out Time on the first Chromie visit', { skip }, () => {
	const list = goals('forever/horde/50-60/06-silithus.guide');
	assert.equal(list[at(list, 'accept 4972', is('accept', 4972))].s, list[at(list, 'turnin 4971', is('turnin', 4971))].s, 'taken on A Matter of Time\'s hand-in');
	assert.ok(at(list, 'collect 12638', (g) => g.t === 'collect' && g.item === 12638) < at(list, 'turnin 5098', is('turnin', 5098)), 'the lockboxes before the Bulwark');
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
		assert.equal(list[at(list, `turnin ${q}`, is('turnin', q))].s, list[back].s, `${q} is handed in on the stop back in Lakeshire`);
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
	assert.ok(!wet.some(({ goal }) => goal.t === 'level'), 'no written top-up in 06-wetlands');
	assert.ok(!wet.some(({ goal }) => goal.quest === 526), 'Lightforge Ingots (526, needs 324) is not taken at 27');
	const late = goals(ASHENVALE_30);
	assert.ok(!late.some(({ goal }) => [1026, 1035, 1046, 1022, 1140, 1031].includes(goal.quest)), '30-40/03 no longer carries the Ashenvale quests');
	const hills = goals(HILLSBRAD_ALLIANCE);
	assert.ok(!hills.some(({ goal }) => goal.quest === 97926), 'Thundris is not visited again for Making Do');
	assert.ok(!hills.some(({ goal }) => goal.quest === 293), 'Cleansing the Eye is handed in on the 27-29 Wetlands trip');
});

// Town visits for one quest (2026-11-07, Alliance 20-30): Volcor's escort went to Auberdine on a walk north and back
// south for Kerlonian, Fall of Dun Modr took a walk north to Dun Modr and back, Astranaar had a stop for three hand-ins
// between two others, Ormer's dig a stop for one hand-in, and Lakeshire a stop for Keeshan after the other hand-ins.
test('Alliance 20-30: no town stop for one quest where the route comes back anyway', { skip }, () => {
	const dark = darkshoreBoth();
	assert.ok(!dark.filter(forClass('WARRIOR')).some(({ goal }) => goal.t === 'turnin' && goal.quest === 994), 'Volcor\'s escort is not taken back to Auberdine from Darkshore (Druids excepted)');
	const wet = goals(WETLANDS);
	const wetStep = (t, q) => wet[at(wet, `${t} ${q}`, is(t, q))].s;
	assert.equal(wetStep('turnin', 994), wetStep('accept', 990), 'Volcor\'s escort to Terenthis on the Auberdine stop, with Selarin\'s Trek to Ashenvale');
	assert.ok(!wet.some(({ goal }) => goal.t === 'turnin' && goal.quest === 472), 'Fall of Dun Modr is handed in on 30-40/01\'s Dun Modr stop');
	const hills = goals(HILLSBRAD_ALLIANCE);
	assert.ok(hills.some(({ goal }) => goal.t === 'turnin' && goal.quest === 472), 'Longbraid takes it there');
	assert.equal(wetStep('turnin', 1046), wetStep('turnin', 1035), 'one Astranaar stop at the end of the Ashenvale trip');
	const ash = goals(ASHENVALE);
	const ashStep = (t, q) => ash[at(ash, `${t} ${q}`, is(t, q))].s;
	assert.equal(ashStep('turnin', 1008), ashStep('turnin', 1034), 'Astranaar\'s hand-ins with The Zoram Strand');
	assert.equal(ashStep('turnin', 294), ashStep('accept', 295), 'Ormer\'s second quest taken with the first hand-in');
	assert.ok(!ash.some(({ goal }) => goal.quest === 343), 'no walk into Stormwind Keep for Speaking of Fortitude');
	const red = goals('forever/alliance/04-redridge-mountains.guide');
	const redStep = (t, q) => red[at(red, `${t} ${q}`, is(t, q))].s;
	assert.equal(redStep('turnin', 219), redStep('turnin', 20), 'Keeshan and the rest of Lakeshire\'s hand-ins on one stop');
	assert.ok(red.some(({ goal }) => is('turnin', 34)(goal)) && !red.some(({ goal }) => goal.quest === 130), 'Bellygrub to Martie at 24; her own errand was done at 20 (03-loch-modan)');
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
	const mura = at(barrens, 'turnin 880', is('turnin', 880));
	const lake = at(barrens, 'turnin 28', is('turnin', 28));
	const back = barrens.findIndex(({ step, goal }) => goal.t === 'fly' && goal.location === 'Ratchet' && step.only && step.only.classes && step.only.classes.join() === 'DRUID');
	assert.ok(mura < at(barrens, 'accept 27', is('accept', 27)) && lake > mura && back > lake, 'Druids train and do the Moonglade trial from the Crossroads, then fly on to Ratchet');
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
	assert.ok(!barrens.some(({ goal }) => is('turnin', 840)(goal)), 'no Conscript of the Horde carried into the Barrens');
});

// Final route review, Horde 1-30: the flight lands in Ratchet beside Sputtervalve, who came after the grind south and
// back; the Silithid eggs lie on the road south to Gann but were done on a walk back north from Gann, and Sulhasa's
// Field to Clear (beside Gann) was taken after Blackthorn Ridge, whose plain holds its lizards and stalkers.
test('forever/horde/02-the-barrens.guide, 04-the-barrens.guide: final route review: Ratchet in walking order, the eggs with Jorn\'s hunt, Field to Clear with Blackthorn Ridge', { skip }, () => {
	// Horde 12-30 re-chain: the Ratchet stop before Northwatch and the Silithid eggs are in the Barrens' 15-21 stay
	// (02), Gann Stonespire and Blackthorn Ridge in its 24-26 return (04).
	const early = goals('forever/horde/02-the-barrens.guide');
	const thalo = at(early, 'accept 891', is('accept', 891));
	assert.ok(at(early, 'accept 1483', is('accept', 1483)) < thalo && at(early, 'turnin 819', is('turnin', 819)) < thalo, 'Sputtervalve and Drohn before Thalo\'thas');
	const eggs = at(early, 'collect 5058', (g) => g.t === 'collect' && g.item === 5058);
	const wings = at(early, 'collect 5164', (g) => g.t === 'collect' && g.item === 5164);
	assert.ok(eggs > wings && eggs < at(early, 'turnin 913', is('turnin', 913)) && eggs < at(early, 'turnin 868', is('turnin', 868)), 'the eggs right after Jorn\'s thunderhawks, before his hand-in and Korran');
	assert.ok(at(early, 'accept 865', is('accept', 865)) < at(early, 'collect 5055', (g) => g.t === 'collect' && g.item === 5055), 'Raptor Horns taken before its horns');
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

// Discord report (2026-11-08): "Ashenvale & Silverpine is labeled 21-22 but the steps tell me I'm behind for not being
// level 24". Ashenvale Outrunners (level 24, its Outrunners 23-24) was the first Ashenvale step, at 21, where the level
// model has every start but Skyborne at 21.2-21.7: the pace line's "Behind: Ashenvale Outrunners (24) ... reach 22 first"
// for players on the route's own pace. It waits for the way back, after Ruul's hand-in at Splintertree (22-23), and is
// still handed in on the spot, before the flight to Orgrimmar.
test(`${STONETALON}: Discord report: Ashenvale Outrunners on the way back from Thistlefur, not at 21 on the way in`, { skip }, () => {
	const list = goals(STONETALON);
	const senani = at(list, 'turnin 6382', is('turnin', 6382));
	const ruul = at(list, 'turnin 6482', is('turnin', 6482));
	const take = at(list, 'accept 6503', is('accept', 6503));
	const kill = list.findIndex(({ goal }) => goal.t === 'kill' && goal.quest === 6503);
	const hand = at(list, 'turnin 6503', is('turnin', 6503));
	const fly = list.findIndex(({ goal }, i) => i > hand && goal.t === 'fly');
	assert.ok(senani < ruul && ruul < take && take < kill && kill < hand, 'Senani, Thistlefur and Ruul first, then the Outrunners');
	assert.ok(fly > hand && list[fly].goal.location === 'Orgrimmar', 'handed in before the flight to Orgrimmar');
	const pairs = JSON.parse(fs.readFileSync(path.join(__dirname, '..', 'data', 'route-fixes.json'), 'utf8')).deliberate.pairs;
	assert.ok(pairs.some((p) => p.a[0] === 'turnin' && p.a[1] === 6482 && p.b[0] === 'accept' && p.b[1] === 6503), 'a route-fixes pair keeps the order');
	assert.ok(!pairs.some((p) => p.a[0] === 'turnin' && p.a[1] === 6503 && p.b[0] === 'turnin' && p.b[1] === 6382), 'no pair puts it before Senani');
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

// Final route review before 0.3.5, Horde 1-30: three walks back to a town between two pieces of work on one road
// (Jorn in Camp Taurajo between his thunderhawks and the Field of Giants' eggs south of them; Tarren Mill between the
// bears on the slope down to Hillsbrad Fields and the fields; the Sepulcher and the Decrepit Ferry, a boat the later
// shore walk to Ambermill passes), and texts that sent players the wrong way or to the wrong guide.
test('Final route review (Horde 1-30, 0.3.5): Jorn after the eggs, Lydon after Hillsbrad Fields, the Decrepit Ferry on the shore walk; tips that match the route', { skip }, () => {
	const fixes = JSON.parse(fs.readFileSync(path.join(__dirname, '..', 'data', 'route-fixes.json'), 'utf8'));
	for (const [a, b] of [[['task', 868], ['turnin', 913]], [['task', 527], ['turnin', 496]], [['task', 91920], ['turnin', 438]], [['turnin', 438], ['task', 479]]]) {
		assert.ok(fixes.overrides.pairs.some((p) => p.faction === 'Horde' && `${p.a}` === `${a}` && `${p.b}` === `${b}`), `pair ${a} before ${b} is a record the build keeps`);
	}
	const barrens = goals(BARRENS);
	const wings = at(barrens, 'collect 5164', (g) => g.t === 'collect' && g.item === 5164);
	const eggs = at(barrens, 'collect 5058', (g) => g.t === 'collect' && g.item === 5058);
	const jorn = at(barrens, 'turnin 913', is('turnin', 913));
	assert.ok(wings < eggs && eggs < jorn, 'the thunderhawks, the eggs, then Jorn on the way back north');
	assert.ok(!barrens.slice(wings + 1, eggs).some(({ goal }) => goal.npc === barrens[jorn].goal.npc), 'no walk back to Jorn between the hawks and the eggs');
	const warrior = barrens.filter(forClass('WARRIOR'));
	assert.equal(warrior[at(warrior, 'turnin 1824', is('turnin', 1824))].s, warrior[at(warrior, 'turnin 913', is('turnin', 913))].s, 'Ruga and Jorn on one Camp Taurajo stop');
	// Ingest 2026-11-08: 8 of 14 players abandoned Egg Hunt, taken at 17 and carried to the eggs at 21. It is taken on
	// the last Crossroads stop before the eggs: no other Crossroads hand-in between its accept and its work.
	const egg = at(barrens, 'accept 868', is('accept', 868));
	assert.equal(barrens[egg].s, barrens[at(barrens, 'turnin 4921', is('turnin', 4921))].s, 'Egg Hunt with Mankrik\'s Lost in Battle');
	assert.ok(!barrens.slice(egg + 1, eggs).some(({ goal }) => goal.npc === barrens[egg].goal.npc || goal.npc === 3338), 'no Crossroads stop (Korran, Sergra) between the accept and the eggs');
	assert.match(barrens[at(barrens, 'accept 855', is('accept', 855))].step.note, /^West to Regthar/, 'Regthar is west of the Crossroads');
	assert.doesNotMatch(barrens[at(barrens, 'accept 1512', is('accept', 1512))].goal.note, /end of this guide/, 'The Binding is on the next guide\'s Orgrimmar stop');
	const hills = goals(HILLSBRAD_HORDE);
	const bears = at(hills, 'collect 3476', (g) => g.t === 'collect' && g.item === 3476);
	const farmers = at(hills, 'kill 2266 quest 527.1', (g) => g.t === 'kill' && g.quest === 527);
	assert.ok(bears < farmers && farmers < at(hills, 'turnin 496', is('turnin', 496)), 'the bears, the fields, then Lydon');
	assert.deepEqual(hills.slice(bears + 1, farmers).filter(({ goal }) => ['accept', 'turnin'].includes(goal.t)).map(({ goal }) => `${goal.t} ${goal.quest}`), [], 'no Tarren Mill stop between the bears and the fields');
	const pine = goals(SILVERPINE);
	const ferry = at(pine, 'turnin 438', is('turnin', 438));
	assert.ok(at(pine, 'collect 730', (g) => g.t === 'collect' && g.item === 730) < ferry && ferry < at(pine, 'collect 3354', (g) => g.t === 'collect' && g.item === 3354), 'the boat between the murlocs and Ambermill');
	assert.equal(pine[at(pine, 'turnin 439', is('turnin', 439))].s, pine[at(pine, 'turnin 479', is('turnin', 479))].s, 'Rot Hide Clues on the Sepulcher stop after Ambermill');
	assert.doesNotMatch(goals(TIRISFAL).find(({ goal }) => is('accept', 86784)(goal)).goal.note, /walks/, 'Bartholomew stays beside Dillinger (#1046)');
	assert.match(goals(ZEPHRAS_HORDE).find(({ goal }) => is('accept', 94913)(goal)).step.note, /forever\/horde\/02-the-barrens/, 'the Cat Form trip is in the Barrens 15-21 guide');
	const grind = compiled('forever/horde/07-ashenvale.guide').steps.find((step) => step.title === 'Level 28.9');
	assert.match(grind.note, /Or, with a group, run the Blackfathom Deeps dungeon or the Razorfen Kraul dungeon instead\.$/, 'the top-up names the dungeons that fit, in the writer\'s sentence');
	// The Warsong Reports: its walks east of Night Run and back to Kadrak cost more than its XP (measured): left out.
	assert.ok(fixes.overrides.skip.some((r) => r.q === 6543 && r.faction === 'Horde'), 'the skip is a record');
	assert.ok(!goals(STONETALON_HORDE).some(({ goal }) => goal.quest === 6543), 'no Warsong Reports in Ashenvale at 21');
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
	const sylvanas = uc[at(uc, 'Sylvanas', (g) => g.t === 'kill' && g.npc === 10181)].step;
	assert.ok(!/Crossroads/.test(sylvanas.note || ''), 'no Crossroads in the Undercity tip');
	assert.ok(at(uc, 'accept 97891', is('accept', 97891)) < at(uc, 'turnin 97891', is('turnin', 97891)), 'Prompt Potion Runner taken and handed in');
	assert.equal(uc[at(uc, 'turnin 97891', is('turnin', 97891))].s, uc[at(uc, 'turnin 441', is('turnin', 441))].s, 'on the one Undercity stop, with Raleigh');
});

// Final route review, Horde 1-30: Sharptalon prowls between Torek's fight and Splintertree but was hunted on a walk
// back south from the town; Tauren and Skyborne, who know the Thunder Bluff flight path, flew to Camp Taurajo and rode
// across Mulgore; and the guide asked for Test of Strength, which Dorn offers only once Test of Endurance is in.
test('forever/horde/07-ashenvale.guide: final route review: Sharptalon on the way in, Thunder Bluff by air, Test of Strength after Test of Endurance', { skip }, () => {
	const list = goals(ASHENVALE_HORDE);
	assert.ok(at(list, 'accept 2', is('accept', 2)) < at(list, 'turnin 6544', is('turnin', 6544)), 'Sharptalon before Splintertree');
	const tb = list.find(({ goal }) => goal.t === 'fly' && goal.location === 'Thunder Bluff' && !goal.only);
	assert.ok(tb && tb.step.only && tb.step.only.races.includes('Tauren') && tb.step.only.races.includes('Skyborne'), 'Tauren and Skyborne fly to Thunder Bluff from Zoram\'gar');
	const taurajo = list.find(({ goal }) => goal.t === 'fly' && goal.location === 'Camp Taurajo');
	assert.ok(taurajo.step.only && !taurajo.step.only.races.includes('Tauren'), 'the Camp Taurajo flight is for the others');
	assert.ok(at(list, 'turnin 1150', is('turnin', 1150)) < at(list, 'accept 1151', is('accept', 1151)), 'Test of Strength after Test of Endurance');
	for (const { step, goal } of list.filter(({ goal }) => goal.quest === 96261)) {
		assert.ok((step.when || []).some((p) => p.k === 'group' && p.q === 96261 && !p.neg), `${goal.t} 96261: Broodmother Valraxx is elite, asked as a group quest`);
	}
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

// Flow review (2026-11-07): Alliance Stranglethorn 40-50 killed the Jungle Stalkers on a trip of their own after the
// last Booty Bay stop and walked back north to Nesingwary for Raptor Mastery, though the jungle loop crosses their
// slopes at the Cold Eye basilisks and the ride to the Rebel Camp passes Nesingwary's camp.
test('forever/alliance/40-50/01-stranglethorn-vale.guide: flow re-order: Raptor Mastery with the Cold Eye basilisks, handed in at Nesingwary on the way to the Rebel Camp', { skip }, () => {
	const list = goals('forever/alliance/40-50/01-stranglethorn-vale.guide');
	const stepOf = (what, pred) => list[at(list, what, pred)].s;
	const stalkers = stepOf('the Jungle Stalkers (196)', (g) => g.t === 'kill' && g.quest === 196);
	assert.equal(stalkers, stepOf("Maury's Clubbed Foot (609)", (g) => g.t === 'collect' && g.item === 3924) + 1, 'the raptors on the jungle loop, right after Maury (A Meal Served Cold is left out)');
	const turnin = stepOf('turnin 196', is('turnin', 196));
	assert.ok(turnin < stepOf('turnin 622', is('turnin', 622)), 'handed in on the way to the Rebel Camp');
	assert.ok(turnin < stepOf('turnin 611', is('turnin', 611)), 'before the last Booty Bay stop');
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
	assert.ok(accept > s(hin, 'turnin', 3763), 'the crate after Darnassus');
	assert.ok(s(hin, 'turnin', 1395) - accept <= 4, 'the crate straight to Nethergarde Keep');
});

// Flow review (2026-11-07): Alliance Feralas went back to Feathermoon after the southern mainland loop, then took the
// boat out again for Lord Shalzaru on the Isle of Dread and back for his hand-in; the Groddoc livers waited for the
// eastern loop, which walked back to the apes by Feral Scar Vale.
test('forever/alliance/40-50/03-feralas.guide: flow re-order: Lord Shalzaru closes the southern loop, one Feathermoon visit, Groddoc livers by Feral Scar', { skip }, () => {
	const list = goals('forever/alliance/40-50/03-feralas.guide');
	const stepOf = (what, pred) => list[at(list, what, pred)].s;
	const relic = stepOf('the Mysterious Relic (2870)', (g) => g.t === 'collect' && g.quest === 2870);
	assert.ok(relic > stepOf('the yeti hides (2821)', (g) => g.t === 'collect' && g.quest === 2821), 'after the yetis');
	assert.ok(relic < stepOf('turnin 4127', is('turnin', 4127)), 'before the Feathermoon hand-ins');
	assert.equal(stepOf('turnin 2870', is('turnin', 2870)), stepOf('turnin 4127', is('turnin', 4127)), 'one Feathermoon visit');
	assert.equal(stepOf('the Groddoc livers', (g) => g.t === 'collect' && g.quest === 1452 && g.oi === 3), stepOf('the yeti hides (2821)', (g) => g.t === 'collect' && g.quest === 2821), 'the livers with the yetis');
});

// Flow review (2026-11-07): Alliance Un'Goro rode from Torwa to Marshal's Refuge and only came back south-east for the
// Lar'korwi glands and the wrecked raft, which lie just west of Torwa at the foot of the ramp.
test("forever/alliance/40-50/07-un-goro-crater.guide: flow re-order: the Lar'korwi glands and the wrecked raft on arrival, before the ride north", { skip }, () => {
	const list = goals('forever/alliance/40-50/07-un-goro-crater.guide');
	const stepOf = (what, pred) => list[at(list, what, pred)].s;
	const glands = stepOf('the glands (4291)', (g) => g.t === 'collect' && g.quest === 4291);
	const karna = stepOf('accept 4243', is('accept', 4243));
	assert.ok(glands < karna, 'the glands before Karna');
	assert.equal(stepOf('turnin 3844', is('turnin', 3844)), glands, 'the raft with the glands');
	assert.equal(glands, stepOf('turnin 4290', is('turnin', 4290)) + 1, 'right after Torwa');
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
	assert.equal(stepOf('turnin 5211', is('turnin', 5211)), stepOf('turnin 5509', is('turnin', 5509)), 'with the Scourgestones');
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

// Teldrassil: Zenn's Bidding is handed in on the walk east from Dolanaar, before Starbreeze and the lake; the step's tip
// sent players to Zenn "north from the lake", which comes after.
test(`${TELDRASSIL}: Zenn's hand-in step does not send players there from Lake Al'Ameth, which comes after it`, { skip }, () => {
	const list = goals(TELDRASSIL);
	const zenn = at(list, 'turnin 488', is('turnin', 488));
	assert.ok(zenn < at(list, 'turnin 997', is('turnin', 997)), 'Zenn before Denalan at the lake');
	assert.ok(!/from the lake/i.test(String(list[zenn].step.note || '')), 'the tip matches the walk');
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

// Final route review, Alliance 40-60 (2026-11-07): the riding trips go from the city the route already stops in (Night
// Elves from the first Stormwind stop, not a walk from the Swamp of Sorrows to Stormwind and back; Dwarves and Gnomes
// on the way out of Ironforge, not back from the Badlands); only Humans, coming from Eastvale, go by Darkshire to Booty
// Bay (the others came by boat and flew to Darkshire and back); the flight to Stormwind leaves from Booty Bay.
test('forever/alliance/40-50/01-stranglethorn-vale.guide: final review: riding trips from the city stops, no Darkshire round trip', { skip }, () => {
	const stv = 'forever/alliance/40-50/01-stranglethorn-vale.guide';
	const list = goals(stv);
	const stepOf = (what, pred) => list[at(list, what, pred)].s;
	const train = (npc) => (g) => g.t === 'train' && JSON.stringify(g).includes(String(npc));
	const firstBB = stepOf('turnin 627', is('turnin', 627));
	const darkshire = list.filter(({ goal, s }) => goal.t === 'fly' && /Darkshire/.test(goal.location || '') && s < firstBB);
	assert.deepEqual(darkshire, [], 'no flight to Darkshire before the first Booty Bay stop');
	const toBB = list.filter(({ goal, s }) => goal.t === 'fly' && /Booty Bay/.test(goal.location || '') && s < firstBB);
	assert.ok(toBB.length > 0 && toBB.every(({ step }) => step.only && JSON.stringify(step.only).includes('Human')), 'the Darkshire flight to Booty Bay is the Humans\' way back from Eastvale');
	const jartsam = stepOf('Jartsam', train(4753));
	assert.ok(jartsam < stepOf('turnin 1477', is('turnin', 1477)), 'Night Elves ride from the first Stormwind stop, before Darkshire');
	assert.ok(jartsam > stepOf('accept 1271', is('accept', 1271)), 'after the Stormwind stop');
	for (const npc of [4772, 7954]) assert.ok(stepOf(`riding trainer ${npc}`, train(npc)) < stepOf('turnin 733', is('turnin', 733)), `riding ${npc} before the Badlands`);
	const last = stepOf('turnin 609', is('turnin', 609));
	const sw = list.find(({ goal, s }) => s > last && goal.t === 'fly' && /Stormwind/.test(goal.location || ''));
	const gotoBefore = list.filter(({ s, goal }) => s === sw.s && goal.t === 'goto')[0];
	assert.equal(gotoBefore.goal.map, 1434, 'the Stormwind flight leaves from Booty Bay');
	assert.ok(!goals('forever/alliance/40-50/02-badlands.guide').some(({ goal }) => goal.t === 'fly' && /Thelsamar/.test(goal.location || '')), 'no flight back to Thelsamar in the Badlands guide');
});

// Final route review, Alliance 40-60: a player under 45 on Sardor Isle was sent to grind in Feral Scar Vale and then back
// to Feathermoon's dock for the boat to the coast; the boat now comes first.
test('forever/alliance/40-50/03-feralas.guide: final review: the boat to the coast before the level-45 grind', { skip }, () => {
	const g = compiled('forever/alliance/40-50/03-feralas.guide');
	const grind = g.steps.findIndex((s) => s.goals.some((x) => x.t === 'level' && x.level === 45));
	assert.ok(grind > 0, 'the level-45 grind is in the guide');
	assert.match(g.steps[grind - 1].title || '', /Boat to The Forgotten Coast/, 'the boat right before the grind');
});

// Final route review, Alliance 40-60: Loch Modan once each way (Ghak's quest from Thelsamar where the flight lands, the
// seed's order); the Booty Bay flight after Nethergarde only for The Monogrammed Sash's group.
test('forever/alliance/40-50/05-the-hinterlands.guide: final review: Loch Modan once each way, Booty Bay only for the group', { skip }, () => {
	const list = goals('forever/alliance/40-50/05-the-hinterlands.guide');
	const stepOf = (what, pred) => list[at(list, what, pred)].s;
	assert.ok(stepOf('accept 17', is('accept', 17)) < stepOf('turnin 739', is('turnin', 739)), 'Ghak before Ironband');
	assert.ok(stepOf('turnin 704', is('turnin', 704)) < stepOf('turnin 17', is('turnin', 17)), 'Ironband on the way back, then Ghak');
	const bb = list[at(list, 'fly Booty Bay', (g) => g.t === 'fly' && /Booty Bay/.test(g.location || ''))];
	assert.ok((bb.step.when || []).some((w) => w.k === 'group' && [w.q].flat().includes(8552)), 'only for the Sash group');
});

// Final route review, Alliance 40-60: Suntara Stones is an escort that starts on accept; it was taken at the first
// outhouse stop and the guide left for Thorium Point. Caught! on the spot (as on the Horde side); no along lists.
test('forever/alliance/40-50/06-searing-gorge.guide: final review: Dorius taken with his escort, Caught! on the spot, no along lists', { skip }, () => {
	const list = goals('forever/alliance/40-50/06-searing-gorge.guide');
	const stepOf = (what, pred) => list[at(list, what, pred)].s;
	assert.equal(stepOf('accept 3367', is('accept', 3367)), stepOf('complete 3367', is('complete', 3367)), 'accepted on the escort step');
	assert.ok(stepOf('accept 3367', is('accept', 3367)) > stepOf('turnin 7722', is('turnin', 7722)), 'at the end, after Thorium Point');
	assert.equal(stepOf('turnin 4449', is('turnin', 4449)), stepOf('kill 5839', (g) => g.t === 'kill' && g.quest === 4449), 'Caught! with its geologists');
	assert.ok(stepOf('turnin 4449', is('turnin', 4449)) < stepOf('accept 7728', is('accept', 7728)), 'before Thorium Point');
	assert.ok(!list.some(({ step }) => step.along), 'no along lists');
});

// Final route review, Alliance 40-60: the pylon loop clockwise as the seed has it (the order crossed the crater from
// the north-east to the south-west and back east); Ironforge round the ring: Tymor before Archesonus.
test("forever/alliance/40-50/07-un-goro-crater.guide: final review: the pylon loop one way round, Ironforge in walking order", { skip }, () => {
	const list = goals('forever/alliance/40-50/07-un-goro-crater.guide');
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
	const five = goals('forever/alliance/50-60/05-silithus.guide');
	const s5 = (what, pred) => five[at(five, what, pred)].s;
	assert.equal(s5('class training', (g) => g.t === 'train'), s5('turnin 4512', is('turnin', 4512)), 'training in the Ironforge stop');
	const list = goals('forever/alliance/50-60/06-silithus.guide');
	const stepOf = (what, pred) => list[at(list, what, pred)].s;
	const sw = stepOf('turnin 7793', is('turnin', 7793));
	assert.equal(stepOf('turnin 7795', is('turnin', 7795)), sw, 'the Runecloth donation on the same stop');
	assert.equal(stepOf('turnin 7791', is('turnin', 7791)), sw, 'the Wool donation on the same stop');
	assert.ok(sw < stepOf('turnin 4513', is('turnin', 4513)), 'then Ironforge');
	assert.equal(list.filter(({ goal }) => goal.t === 'fly' && /Stormwind/.test(goal.location || '')).length, 1, 'one flight to Stormwind');
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
	const train = druid.findIndex(({ step, goal }) => goal.t === 'train' && step.only);
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
// Final route review, 30-40 (2026-11-07): the step after the flight into Grom'gol told the player to follow the road south to
// Grom'gol.
test('forever/horde/30-40/03-stranglethorn-vale.guide: final review: no walk to Grom\'gol after the flight there', { skip }, () => {
	const steps = compiled('forever/horde/30-40/03-stranglethorn-vale.guide').steps;
	const s = steps.findIndex((st) => st.goals.some((g) => g.t === 'turnin' && g.quest === 581));
	assert.ok(s > 0, 'turnin 581 is in the guide');
	assert.doesNotMatch([].concat(steps[s].note || []).join(' '), /road south to Grom'gol/, 'the tip names where the NPC stands, not a walk to the town');
});
// Final route review, 30-40 (2026-11-07): Blackmoore's Legacy's hand-in, right after the Tarren Mill hand-ins to Keeper
// Bel'varil, told the player to head back south to Tarren Mill (on the 38-39 Alterac visit since the Horde 30-40 re-order).
test('forever/horde/30-40/05-arathi-highlands.guide: final review: no walk to Tarren Mill from Tarren Mill', { skip }, () => {
	const steps = compiled('forever/horde/30-40/05-arathi-highlands.guide').steps;
	const s = steps.findIndex((st) => st.goals.some((g) => g.t === 'turnin' && g.quest === 506));
	assert.ok(s > 0, 'turnin 506 is in the guide');
	assert.doesNotMatch([].concat(steps[s].note || []).join(' '), /back south to Tarren Mill/, 'the tip names where the NPC stands, not a walk to the town');
});
// Final route review, 30-40 (2026-11-07): Warriors walked from Stormwind's flight master to Wu Shen in Old Town, back to
// Elling Trias in the Trade District and on to Dashel in Old Town; the Ironforge stop, reached by flight from Southshore,
// told players to take the tram to Ironforge.
test('forever/alliance/30-40/01-hillsbrad-foothills.guide: final review: The Islander on the Dashel stop, the Ironforge tip fits the flight', { skip }, () => {
	const list = goals('forever/alliance/30-40/01-hillsbrad-foothills.guide');
	const islander = at(list, 'accept 1718', is('accept', 1718));
	assert.ok(islander > at(list, 'turnin 1447', is('turnin', 1447)) && islander < at(list, 'turnin 563', is('turnin', 563)), 'after Dashel, before the Keep');
	const hall = list[at(list, 'turnin 514', is('turnin', 514))];
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
// Final route review, 30-40 (2026-11-07): Horde Desolace & Hillsbrad sent Undead Paladins to an Orgrimmar step that
// pointed at Thunder Bluff, then flew them Tarren Mill -> Undercity -> Tarren Mill for Garen Largo; Druids and Paladins
// skipped their level-30 training; Druids at 32 flew Orgrimmar -> Thunder Bluff -> Orgrimmar; the Undercity shopping
// note and the Shamans' Sepulcher trip came after the flight to Tarren Mill.
test('forever/horde/30-40/01-hillsbrad-foothills.guide: final review: training in the cities the walk passes', { skip }, () => {
	// Since the Horde 30-40 re-order the Druids train in Thunder Bluff on the flight from Freewind Post (30) and from
	// Orgrimmar to Freewind Post (32-33), the Paladins with Garen Largo in the Undercity on the way to Tarren Mill (30)
	// and on the way back from Arathi (32-33).
	const list = goals('forever/horde/30-40/01-hillsbrad-foothills.guide');
	const flies = (l, dest) => l.findIndex(({ goal }) => goal.t === 'fly' && JSON.stringify(goal).includes(dest));
	const trains = (l) => l.map((e, i) => (e.goal.t === 'train' ? i : -1)).filter((i) => i >= 0);
	const tm = (l) => flies(l, 'Tarren Mill');
	const dru = list.filter(forClass('DRUID'));
	assert.ok(flies(dru, 'Thunder Bluff') >= 0 && flies(dru, 'Thunder Bluff') < trains(dru)[0] && trains(dru)[0] < flies(dru, 'Crossroads'), 'Druids: Thunder Bluff on the flight from Freewind Post to the Crossroads');
	const pal = list.filter(forClass('PALADIN'));
	assert.ok(trains(pal)[0] < tm(pal), 'Paladins: Garen Largo before the flight to Tarren Mill');
	assert.equal(pal.filter(({ goal }) => goal.t === 'fly' && JSON.stringify(goal).includes('Tarren Mill')).length, 1, 'Paladins: one flight to Tarren Mill');
	const sham = list.filter(forClass('SHAMAN'));
	assert.ok(flies(sham, 'The Sepulcher') < tm(sham), 'Shamans: the Sepulcher before Tarren Mill');
	const war = list.filter(forClass('WARRIOR'));
	// #1322: the note names the Lesser Troll's Blood Elixir the objective takes (the quest text says Strong).
	const note = war.find(({ step }) => /Lesser Troll's Blood Elixir/.test([].concat(step.note || []).join(' ')));
	assert.ok(note && note.s < war[tm(war)].s, 'the potion tip in the Undercity, before the flight to Tarren Mill');
	const next = goals('forever/horde/30-40/02-thousand-needles.guide').filter(forClass('DRUID'));
	assert.ok(flies(next, 'Thunder Bluff') < flies(next, 'Freewind Post') || flies(next, 'Freewind Post') < 0, 'Druids at 32: Orgrimmar -> Thunder Bluff -> Freewind Post');
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
	assert.ok(next[0].goal.t === 'fly' && /Menethil/.test(JSON.stringify(next[0].goal)), 'the next guide opens with the flight to Menethil Harbor');
});

// --- Alliance 30-40 re-order (2026-11-07, zone order the quest levels fit): Wetlands & Hillsbrad 30-32, then one
// crossing to Theramore for the Mirage Raceway and the Shady Rest quests (33-34; the Raceway was a crossing of its own
// at 30 in 07-thousand-needles), Stranglethorn's first loop, Desolace's first visit (it was at 32, where the route
// grinded for The Karnitol Shipwreck), Stranglethorn's northern loop (04b), then the Swamp of Sorrows, Arathi &
// Alterac and the Badlands with Desolace's south loop. High accepts wait for the visit that works them.
test('Alliance 30-40 re-order: the Mirage Raceway on the Theramore crossing, Desolace between the Stranglethorn loops, no early accepts of high quests', { skip }, () => {
	const chain = ['07-thousand-needles', '30-40/01-hillsbrad-foothills', '30-40/03-ashenvale', '30-40/04-stranglethorn-vale', '30-40/02-desolace', '30-40/04b-stranglethorn-vale', '30-40/05-arathi-highlands', '30-40/06-badlands', '40-50/01-stranglethorn-vale'];
	for (let i = 0; i + 1 < chain.length; i++) assert.equal(compiled(`forever/alliance/${chain[i]}.guide`).next, `forever/alliance/${chain[i + 1]}`, `${chain[i]} leads to ${chain[i + 1]}`);
	const dust = goals('forever/alliance/30-40/03-ashenvale.guide');
	for (const q of [1302, 1264, 1284, 1253, 1319, 1320, 1110, 1104, 1105, 1176, 1175, 1135]) assert.ok(dust.some(({ goal }) => is('turnin', q)(goal)), `30-40/03 hands in ${q}`);
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
	assert.ok(!goals('forever/alliance/30-40/02-desolace.guide').some(({ goal }) => is('accept', 1454)(goal)), 'The Karnitol Shipwreck (39) is taken on the south loop, not at the first Desolace visit');
	assert.ok(goals(BADLANDS).some(({ goal }) => is('accept', 1454)(goal)), 'and taken there');
	assert.ok(!goals(HILLSBRAD_ALLIANCE).some(({ goal }) => is('accept', 707)(goal)), 'Ironband Wants You! (37) is not taken at 32');
	assert.ok(goals(ARATHI).some(({ goal }) => is('accept', 707)(goal)), 'it is taken on the Ironforge stop before Loch Modan');
	assert.ok(!goals('forever/alliance/30-40/04b-stranglethorn-vale.guide').some(({ goal }) => is('accept', 209)(goal)), 'Skullsplitter Tusks (42) is not taken at 37');
	assert.ok(at(late, 'accept 209', is('accept', 209)) < at(late, 'turnin 209', is('turnin', 209)), 'it is taken in 40-50/01 before its trolls');
	for (const g of ['30-40/02-desolace', '30-40/03-ashenvale', '30-40/04b-stranglethorn-vale']) assert.deepEqual(compiled(`forever/alliance/${g}.guide`).steps.filter((st) => st.along).map((st) => st.title), [], `${g}: no along steps`);
});


// Final route review, Horde 40-60: the Aged Gorilla Sinew drops from the Mistvale gorillas whose fangs Unbagwa wants,
// not on the Wild Shore; and the guide opened with a vendor step titled Booty Bay while still in Ratchet and a note
// about Tarren Mill, both carried over from the 30-40 guide's last Booty Bay stop.
test('forever/horde/40-50/01-stranglethorn-vale.guide: final review: the sinew with the gorilla fangs, no stray vendor or Tarren Mill note', { skip }, () => {
	const list = goals('forever/horde/40-50/01-stranglethorn-vale.guide');
	const sinew = list[at(list, 'collect 3862', (g) => g.t === 'collect' && g.item === 3862)];
	assert.equal(sinew.s, list[at(list, 'collect 2799', (g) => g.t === 'collect' && g.item === 2799)].s, 'with the gorilla fangs');
	assert.notEqual(sinew.s, list[at(list, 'collect 3920', (g) => g.t === 'collect' && g.item === 3920)].s, 'not with the Bloodsail charts');
	const arrive = at(list, 'fly Booty Bay', (g) => g.t === 'fly' && /Booty Bay/.test(JSON.stringify(g)));
	assert.ok(!list.slice(0, arrive).some(({ goal }) => goal.t === 'vendor'), 'no vendor before the flight to Booty Bay (from Kargath since the Horde 30-40 re-order)');
	assert.ok(!list.some(({ goal }) => goal.t === 'note' && /Tarren Mill/.test(goal.text || goal.note || '')), 'no note about the next guide flying to Tarren Mill');
});

// Final route review, Horde 40-60: Zukk'ash Report is ready on the Orgrimmar stop that ends the Feralas guide, which
// passes Zilzibin Drumlore; it was carried to the Azshara guide's Orgrimmar stop.
test('forever/horde/40-50/02-feralas.guide: final review: Zukk\'ash Report on the Orgrimmar stop that ends the guide', { skip }, () => {
	const list = goals('forever/horde/40-50/02-feralas.guide');
	const report = list[at(list, 'turnin 7732', is('turnin', 7732))];
	assert.equal(report.s, list[at(list, 'turnin 3121', is('turnin', 3121))].s, 'with Neeru\'s hand-in, in Orgrimmar');
	assert.ok(!goals('forever/horde/40-50/06-azshara.guide').some(({ goal }) => is('turnin', 7732)(goal)), 'not carried to the Azshara guide');
});

// Final route review, Horde 40-60: the snapper claws were an "along the way" list from the Pool of Tears; the
// snappers share the east coast's strand with the Monstrous Crawlers, so both are the coast step's work. A tip at
// Misty Reed Post said the next guide starts there, and a note about The Sunken Temple came before its accept.
test('forever/horde/40-50/03-feralas.guide: final review: the snapper claws on the coast step, no stray next-guide tip or Sunken Temple note', { skip }, () => {
	const file = 'forever/horde/40-50/03-feralas.guide';
	const list = goals(file);
	assert.deepEqual(compiled(file).steps.filter((step) => step.along).map((step) => step.title), [], 'no "along the way" lists');
	const claws = list[at(list, 'collect 6168', (g) => g.t === 'collect' && g.item === 6168)];
	assert.equal(claws.s, list[at(list, 'collect 6184', (g) => g.t === 'collect' && g.item === 6184)].s, 'with the crawler legs');
	assert.ok(!compiled(file).steps.some((step) => /next guide starts here/.test(step.note || '')), 'no next-guide tip mid-guide');
	assert.ok(!list.some(({ goal }) => goal.t === 'note' && /Sunken Temple/.test(goal.text || goal.note || '')), 'no Sunken Temple note');
	const last = list.map((e, i) => i).filter((i) => is('turnin', 3128)(list[i].goal)).pop();
	assert.ok(at(list, 'turnin 7734', is('turnin', 7734)) < last && list[at(list, 'turnin 7734', is('turnin', 7734))].s === list[last].s, 'Jangdor first on the last Mojache stop, coming in from the north-west');
});

// Final route review, Horde 40-60: Tooga's escort ends at Steamwheedle Port, but the Noxious Lair sat between the
// escort and its hand-in (a ride from the port back west and east again); the gorge had two "along the way" lists
// (the taskmasters, slavers and golems are now killed on the ride from Thorium Point to Kalaran, where it crosses them); two tips spoke of Kargath and of the next guide.
test('forever/horde/40-50/04-tanaris.guide: final review: the lair before Tooga, the Cauldron\'s Dark Irons on the way to Kalaran, no along lists', { skip }, () => {
	const file = 'forever/horde/40-50/04-tanaris.guide';
	const list = goals(file);
	const escort = at(list, 'accept 1560', is('accept', 1560));
	assert.ok(at(list, 'collect 8587', (g) => g.t === 'collect' && g.item === 8587) < escort, 'the insect parts before the escort');
	const done = list[at(list, 'complete 1560', is('complete', 1560))].goal;
	assert.deepEqual([done.map, Math.round(done.x), Math.round(done.y)], [1446, 67, 26], 'the escort points at Torta in the port');
	const kalaran = at(list, 'accept 3441', is('accept', 3441));
	for (const npc of [5846, 5844, 5854]) assert.ok(at(list, `kill ${npc}`, (g) => g.t === 'kill' && g.npc === npc) < kalaran, `${npc} on the ride from Thorium Point to Kalaran`);
	assert.deepEqual(compiled(file).steps.filter((step) => step.along).map((step) => step.title), [], 'no "along the way" lists');
	assert.ok(!compiled(file).steps.some((step) => /Kargath|next guide starts/.test(step.note || '')), 'no tip about Kargath or the next guide');
});

// Final route review, Horde 40-60: the stalkers and the scalpers were listed "along the way" ahead of the temples
// step that does them, and the Revantusk stop before the Blasted Lands said the next guide starts there.
test('forever/horde/40-50/05-the-hinterlands.guide: final review: no along lists, no next-guide tip mid-guide', { skip }, () => {
	const file = 'forever/horde/40-50/05-the-hinterlands.guide';
	assert.deepEqual(compiled(file).steps.filter((step) => step.along).map((step) => step.title), [], 'no "along the way" lists');
	const list = goals(file);
	assert.equal(list[at(list, 'kill 2926', (g) => g.t === 'kill' && g.npc === 2926)].s, list[at(list, 'kill 4466', (g) => g.t === 'kill' && g.npc === 4466)].s, 'stalkers and scalpers on the temples step');
	assert.ok(!compiled(file).steps.some((step) => /next guide starts/.test(step.note || '')), 'no next-guide tip');
});

// Final route review, Horde 40-60: the Orgrimmar stop comes off the flight from Valormok but told you to take the
// zeppelin back, and the Camp Mojache stop before the muisek chain said the next guide starts there.
test('forever/horde/40-50/06-azshara.guide: final review: tips that match the way in', { skip }, () => {
	const file = 'forever/horde/40-50/06-azshara.guide';
	const steps = compiled(file).steps;
	assert.ok(!steps.some((step) => /zeppelin back to Orgrimmar/.test(step.note || '')), 'no zeppelin tip after the Valormok flight');
	assert.ok(!steps.some((step) => /next guide starts with the flight to Gadgetzan/.test(step.note || '')), 'no next-guide tip at Camp Mojache');
});

// Final route review, Horde 40-60: the flight into the Undercity lands beside Harbinger Balthazad, but the order went
// to Oran Snakewrithe first and came back; the pterrordax step carried the Gorishi hive's title and tip; two tips
// still sent you by the Grom'gol zeppelin; a note said to skip Pawn Captures Queen right before accepting it.
test('forever/horde/50-60/01-un-goro-crater.guide: final review: Balthazad first, tips that match the way', { skip }, () => {
	const file = 'forever/horde/50-60/01-un-goro-crater.guide';
	const list = goals(file);
	assert.ok(at(list, 'accept 5094', is('accept', 5094)) < at(list, 'turnin 2782', is('turnin', 2782)), 'Balthazad before Oran');
	const scale = list[at(list, 'collect 11831', (g) => g.t === 'collect' && g.item === 11831)];
	assert.ok(!/hive/i.test(scale.step.title) && !/silithid hive/.test(scale.step.note || ''), 'the pterrordax step is not titled or tipped for the hive');
	assert.ok(!compiled(file).steps.some((step) => /Grom'gol/.test(step.note || '')), 'no Grom\'gol zeppelin in the tips');
	const queen = at(list, 'accept 4507', is('accept', 4507));
	assert.ok(!list[queen].step.goals.some((g) => g.t === 'note' && /Skip it/.test(g.text || '')), 'no skip note beside the accept');
});

// Final route review, Horde 40-60: in from Tarren Mill at Sorrow Hill, the order rode north to Mulgris and back south
// to Marlene; Kirsta's Scarlets were an "along the way" list; the Bloodvenom flight path sat in the step for the
// optional Blood Red Key, which players without the key skip.
test('forever/horde/50-60/02-felwood.guide: final review: Marlene before Mulgris, no along list, the flight path at Bloodvenom Post', { skip }, () => {
	const file = 'forever/horde/50-60/02-felwood.guide';
	const list = goals(file);
	assert.ok(at(list, 'turnin 5152', is('turnin', 5152)) < at(list, 'accept 4984', is('accept', 4984)), 'Marlene before Mulgris');
	assert.deepEqual(compiled(file).steps.filter((step) => step.along).map((step) => step.title), [], 'no "along the way" lists');
	const fp = list[at(list, 'getfp Bloodvenom Post', (g) => g.t === 'getfp' && g.location === 'Bloodvenom Post')];
	assert.equal(fp.s, list[at(list, 'accept 6162', is('accept', 6162))].s, 'with the Bloodvenom Post quests');
	assert.ok(!fp.step.goals.some((g) => g.optional), 'not in an optional step');
});

// Final route review, Horde 40-60: Morrowgrain Research was accepted, completed and handed in on one Thunder Bluff
// step, but it wants ten Morrowgrain from an Evergreen Pouch with a ten-minute cooldown and soil the route has
// spent: optional, as on the Alliance side. The Den Watchers and owlbeasts were "along the way" lists.
test('forever/horde/50-60/03-winterspring.guide: final review: Morrowgrain optional, no along lists', { skip }, () => {
	const file = 'forever/horde/50-60/03-winterspring.guide';
	const list = goals(file);
	for (const q of [3786, 3804]) {
		for (const t of ['accept', 'complete']) assert.ok(list[at(list, `${t} ${q}`, is(t, q))].goal.optional, `${t} ${q} is optional`);
	}
	assert.deepEqual(compiled(file).steps.filter((step) => step.along).map((step) => step.title), [], 'no "along the way" lists');
	const bashana = list[at(list, 'turnin 3782', is('turnin', 3782))].step;
	assert.ok(!/Gorishi/.test(bashana.note || ''), 'no Gorishi warning in Thunder Bluff');
});

// Final route review, Horde 40-60: every class flew Orgrimmar -> Bloodvenom Post -> Thunder Bluff -> Bloodvenom Post,
// though only Druids and Paladins train there (the cloth donations, carried in the bags, now go in when they are
// taken in the Winterspring guide); the Plaguebats and grubs were "along the way" lists.
test('forever/horde/50-60/05-eastern-plaguelands.guide: final review: Thunder Bluff only for Druid and Paladin training, no along lists', { skip }, () => {
	const file = 'forever/horde/50-60/05-eastern-plaguelands.guide';
	const list = goals(file);
	const trip = list.filter(({ step }) => /Thunder Bluff|Bloodvenom Post/.test(step.title) && list.findIndex((e) => e.step === step) > at(list, 'turnin 5181', is('turnin', 5181)));
	assert.ok(trip.some(({ step }) => /Thunder Bluff/.test(step.title)), 'the Thunder Bluff trip is there');
	const back = trip.filter(({ step }) => /Thunder Bluff/.test(step.title) || trip.findIndex((e) => /Thunder Bluff/.test(e.step.title)) < trip.findIndex((e) => e.step === step));
	for (const { step, goal } of back) {
		for (const cls of ['WARRIOR', 'ROGUE', 'MAGE']) assert.ok(!forClass(cls)({ step, goal }), `${step.title}: not for ${cls}`);
	}
	assert.deepEqual(compiled(file).steps.filter((step) => step.along).map((step) => step.title), [], 'no "along the way" lists');
	const ws = goals('forever/horde/50-60/03-winterspring.guide');
	for (const q of [7820, 7821, 7822]) assert.equal(ws[at(ws, `turnin ${q}`, is('turnin', q))].s, ws[at(ws, `accept ${q}`, is('accept', q))].s, `${q} handed in where it is taken`);
	assert.ok(!list.some(({ goal }) => goal.quest === 7820), 'no donation stop in this guide');
	assert.deepEqual([list[0].goal.t, list[0].goal.map], ['goto', 1420], 'a travel line out of the Undercity before the Bulwark');
});

// Final route review, Horde 40-60: the flayer stingers were an "along the way" list; the refuge tip was cut at
// "J.D." with "Collie is inside it." on a later step; the mid-guide Bulwark stop said the next guide starts nearby.
test('forever/horde/50-60/06-silithus.guide: final review: no along list, whole tips, no next-guide tip mid-guide', { skip }, () => {
	const file = 'forever/horde/50-60/06-silithus.guide';
	const steps = compiled(file).steps;
	assert.deepEqual(steps.filter((step) => step.along).map((step) => step.title), [], 'no "along the way" lists');
	assert.ok(!steps.some((step) => /J\.D\.$|^Collie/.test(step.note || '')), 'no tip cut at J.D.');
	assert.ok(!steps.some((step) => /next guide starts/.test(step.note || '')), 'no next-guide tip');
});

// Final route review, Horde 40-60: two level top-ups in the Felwood part sent players to the Winterfall Totemics in
// Winterspring (through Timbermaw Hold and back) before Bloodvenom Post; the Winterspring top-up later does it.
test('forever/horde/50-60/07-felwood.guide: final review: no Winterspring grind while in Felwood', { skip }, () => {
	const list = goals('forever/horde/50-60/07-felwood.guide');
	const moonglade = list.findIndex(({ goal }) => goal.map === 1450);
	assert.ok(moonglade > 0, 'the guide reaches Moonglade');
	assert.deepEqual(list.slice(0, moonglade).filter(({ goal }) => goal.t === 'level').map(({ step }) => step.title), [], 'no grind before Moonglade');
	assert.ok(list.slice(moonglade).some(({ goal }) => goal.t === 'level'), 'the top-up waits for Winterspring');
});

// Final route review, Horde 40-60: Prompt Potion Runner (level 16) waited for the Undercity stop at 56; the Hillsbrad
// guide takes it on its Undercity visit (#1175).
test('forever/horde/50-60/04-azshara.guide: final review: no level 16 Prompt Potion Runner at 56', { skip }, () => {
	const list = goals('forever/horde/50-60/04-azshara.guide');
	assert.ok(!list.some(({ goal }) => goal.quest === 97891), 'not in this guide');
	assert.ok(at(list, 'turnin 3568', is('turnin', 3568)) >= 0, 'the Apothecarium stop stays');
});

// Final route review, Horde 40-60: each race learns to ride where the route already passes its trainer's city:
// Trolls from the Orgrimmar stop (not a flight and boat from Stonard to Durotar and back), Undead on the next
// guide's Undercity stop (not Gadgetzan -> Orgrimmar -> Brill -> Gadgetzan), Taurens, Druids, Paladins and Warlocks
// from Orgrimmar on the way out (not a flight back from Gadgetzan).
test('forever/horde/40-50: final review: riding at 40 and class trips where the route already passes', { skip }, () => {
	const stv = goals('forever/horde/40-50/01-stranglethorn-vale.guide');
	assert.ok(!stv.some(({ goal }) => goal.t === 'train' && goal.npc === 7953), 'no Troll riding trip from the Swamp of Sorrows');
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
	assert.ok(stv[at(stv, 'accept 624', is('accept', 624))].goal.optional, '624 optional');
	const fer = goals('forever/horde/40-50/03-feralas.guide');
	for (const [q, pre] of [[625, 624], [626, 625]]) {
		const a = fer[at(fer, `accept ${q}`, is('accept', q))];
		assert.ok(a.goal.optional && a.step.when.some((p) => p.k === 'onquest' && p.q.includes(pre)), `${q} only with ${pre}`);
	}
	const sil = goals('forever/horde/50-60/06-silithus.guide');
	assert.doesNotMatch(sil[at(sil, 'use 11833', (g) => g.t === 'use' && g.item === 11833)].step.note || '', /elite/);
});

// --- Horde quest volume (2026-11-07): quests recorded players take whose givers, work and enders lie on the
// Horde route's walks are taken where the walk passes the giver and handed in on a visit the route makes
// anyway (data/route-fixes.json, overrides.include, "Flow coverage" / "Quest volume").
const HORDE_VOLUME = {
	'forever/horde/undead/01-tirisfal-glades.guide': [445, 99152, 99153], // Delivery to Silverpine Forest; Hilda and Ephram
	'forever/horde/03-silverpine-forest.guide': [422, 1359, 1358], // Arugal's Folly; Zinge's Delivery; Sample for Helbrim
	'forever/horde/02-the-barrens.guide': [4021, 1062, 6548, 6629, 6461], // Counterattack!; Goblin Invaders; Avenge My Village; Kill Grundig Darkcloud; Blood Feeders
	'forever/horde/05-stonetalon-mountains.guide': [494], // Time To Strike
	'forever/horde/30-40/02-thousand-needles.guide': [1111], // Wharfmaster Dizzywig (handed in at Ratchet in 30-40/04)
	'forever/horde/30-40/05-arathi-highlands.guide': [566], // WANTED: Baron Vardus
};

// The guide and every guide its `next` leads to, in order.
function chainFrom(guide) {
	const out = [];
	for (let g = guide; g && !out.includes(g); ) {
		out.push(g);
		const next = compiled(g).next;
		g = next ? `${String(Array.isArray(next) ? next[0] : next).replace(/\.guide$/, '')}.guide` : null;
		if (g && !fs.existsSync(path.join(OFFICIAL_DIR, g))) break;
	}
	return out;
}

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
	'forever/alliance/30-40/03-ashenvale.guide': [1319, 1320], // The Black Shield; The Black Shield (on the Theramore crossing since the 30-40 re-order)
	'forever/alliance/40-50/07-un-goro-crater.guide': [2662], // Noggenfogger Elixir
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

for (const [guide, quests] of Object.entries(HORDE_VOLUME)) test(`${guide}: Horde quest volume: quests on the walk are taken there and handed in, not optional`, { skip }, () => {
	const here = goals(guide);
	const later = chainFrom(guide).flatMap((g) => goals(g));
	for (const q of quests) {
		assert.ok(here.some(({ goal }) => goal.t === 'accept' && goal.quest === q && !goal.optional), `accept ${q} is in ${guide}`);
		assert.ok(later.some(({ goal }) => goal.t === 'turnin' && goal.quest === q && !goal.optional), `turnin ${q} is in ${guide} or a guide after it`);
	}
});

for (const [guide, quests] of Object.entries(ALLIANCE_VOLUME)) test(`${guide}: Alliance quest volume: the quests on its visits are taken there and handed in`, { skip }, () => {
	const here = goals(guide);
	const later = chainFrom(guide).flatMap((g) => goals(g));
	for (const q of quests) {
		assert.ok(here.some(({ goal }) => goal.t === 'accept' && goal.quest === q && !goal.optional), `accept ${q} is in ${guide}`);
		assert.ok(later.some(({ goal }) => goal.t === 'turnin' && goal.quest === q && !goal.optional), `turnin ${q} is in ${guide} or a guide after it`);
	}
});

test('Horde quest volume: every added quest has its include record in the route fixes', () => {
	const inc = JSON.parse(fs.readFileSync(path.join(__dirname, '..', 'data', 'route-fixes.json'), 'utf8')).overrides.include;
	for (const q of new Set(Object.values(HORDE_VOLUME).flat())) assert.ok(inc.some((e) => e.q === q && /Flow coverage|Quest volume/.test(e.reason)), `include ${q} is recorded`);
});

// Barrens carry-over (2026-11-07, re-chained the same day): the Barrens are two stays, 15-21
// (02-the-barrens, with Stonetalon's road) and 24-26 (04-the-barrens, with Sun Rock); each accepts
// the quests it works where their giver stands on its walk before the work, and 02 hands in Chen's keg
// and the raptor horns before it leaves.
test('forever/horde/04-the-barrens.guide: Barrens carry-over: each Barrens stay accepts the quests it works, and 02 hands in Chen\'s keg before leaving', { skip }, () => {
	const g02 = goals('forever/horde/02-the-barrens.guide');
	const g04 = goals('forever/horde/04-the-barrens.guide');
	for (const [here, other, qs] of [[g02, g04, [896, 876, 4921, 899, 858, 3281, 905, 851, 868]], [g04, g02, [893, 879, 1058, 843]]]) {
		for (const q of qs) {
			assert.ok(!other.some(({ goal }) => goal.t === 'accept' && goal.quest === q), `${q} accepted in one Barrens stay only`);
			const a = here.findIndex(({ goal }) => goal.t === 'accept' && goal.quest === q);
			const w = here.findIndex(({ goal }) => goal.quest === q && goal.t !== 'accept');
			assert.ok(a >= 0 && a < w, `${q} accepted before its work, in the stay that works it`);
		}
	}
	assert.ok(g02.some(({ goal }) => goal.t === 'turnin' && goal.quest === 819), "Chen's Empty Keg handed in in 02");
	assert.ok(g02.some(({ goal }) => goal.t === 'turnin' && goal.quest === 865), 'Raptor Horns handed in in 02');
});

for (const [guide, quests] of Object.entries(ALLIANCE_VOLUME_HANDIN)) test(`${guide}: Alliance quest volume: the quests taken earlier in the chain are handed in here`, { skip }, () => {
	const here = goals(guide);
	for (const q of quests) assert.ok(here.some(({ goal }) => goal.t === 'turnin' && goal.quest === q && !goal.optional), `turnin ${q} is in ${guide}`);
});

test('Alliance quest volume: every added quest has its include record in the route fixes', () => {
	const inc = JSON.parse(fs.readFileSync(path.join(__dirname, '..', 'data', 'route-fixes.json'), 'utf8')).overrides.include;
	for (const q of new Set(Object.values(ALLIANCE_VOLUME).flat())) assert.ok(inc.some((e) => e.q === q && /Quest volume/.test(e.reason)), `include ${q} is recorded`);
});
// --- end of Alliance quest volume

// --- Alliance 12-20 zone order (2026-11-07). Darkshore is played in two parts around an Eastern Kingdoms
// loop at 18-20 (03-loch-modan: Loch Modan, Redridge and the Defias chain in Westfall), where those
// zones' 15-20 quests give full XP; before, the route never went to Loch Modan after the starts, did
// Redridge's 15-18 quests at 24 and entered Ashenvale at 20 with a grind there. Dwarves and Gnomes do
// east Elwynn on the walk from Goldshire to Westfall (Humans in their start guide; Night Elves and
// Skyborne arrive at 14.5, where its level 9-10 quests turn grey).
const A1220_LOCH = ['forever/alliance/03-loch-modan.guide', [127, 250, 199, 86614, 436, 297, 298, 301, 86613, 86758, 257, 258, 86585, 244, 246, 98407, 118, 119, 120, 121, 125, 89, 129, 130, 131, 92, 3741, 122, 124, 132, 135, 141, 142, 155, 104]];
const A1220_ELWYNN = [40, 35, 37, 52, 45, 71, 39, 83, 5545, 91732, 91733, 91723, 91725];

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

test('forever/alliance/04-redridge-mountains.guide: Alliance 12-20 zone order: Redridge\'s 15-20 quests are no longer taken at 24, its level 20-21 quests come with you from the first visit', { skip }, () => {
	const list = goals('forever/alliance/04-redridge-mountains.guide');
	for (const q of [244, 246, 98407, 125, 89, 129, 130, 131, 92, 65, 127]) assert.ok(!list.some(({ goal }) => goal.quest === q && (goal.t === 'accept' || goal.t === 'turnin')), `${q} is not in 04-redridge-mountains`);
	// Marshal Marris's Blackrock quests, Alther's Mill and Murloc Poachers are taken at their givers at 20 and done here.
	const first = goals(LOCH_MODAN);
	for (const q of [20, 98387, 98386, 150]) {
		assert.ok(first.some(({ goal }) => is('accept', q)(goal)), `accept ${q} at 20`);
		assert.ok(!list.some(({ goal }) => is('accept', q)(goal)) && list.some(({ goal }) => is('turnin', q)(goal)), `${q} handed in at 24`);
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
		for (const q of A1220_ELWYNN) assert.ok(mine.some(({ goal }) => is('turnin', q)(goal)), `${race}: turnin ${q}`);
		// The Jasperlode Mine (76) needs The Fargodeep Mine (62), which they never take (players' recordings): not asked for.
		for (const q of [76, 239, 11]) assert.ok(!mine.some(({ goal }) => goal.quest === q), `${race}: no ${q}`);
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
	const inc = JSON.parse(fs.readFileSync(path.join(__dirname, '..', 'data', 'route-fixes.json'), 'utf8')).overrides.include;
	for (const q of [127, 250, 199, 86614, 436, 297, 298, 301, 86613, 86758, 257, 258, 86585, 118, 119, 122, 124, 120, 121, 3741, 132, 135, 141, 142, 155, 104]) {
		assert.ok(inc.some((e) => e.q === q && /Alliance 12-20 re-order/.test(e.reason)), `include ${q} is recorded`);
	}
});
// --- end of Alliance 12-20 zone order

// --- Guide end (release blocker, 2026-11-08): 04-redridge-mountains' last step carried `vendor nearest` with its
// hand-ins, so a player who handed everything in without visiting a vendor never reached the guide's end
// (forge-addontest guides_end: the last step done ahead of the live one must end the guide). A vendor goal is
// a check-off the Engine ticks only when a merchant window opens during its step, so a required one holds
// any step whose real goals are done. The sell and repair stops are optional: no leveling guide's last step
// waits on one, and in the Alliance 12-20 guides no step does.
const forAllOnly = (o) => !(o && ((o.classes || []).length || (o.races || []).length));
const waitsOnVendor = (st) => st.goals.some((g) => g.t === 'vendor' && !g.optional && forAllOnly(g.only)) && st.goals.some((g) => !['vendor', 'note'].includes(g.t) && !g.optional);
test('Guide end: no leveling guide\'s last step for everyone waits on a vendor visit', { skip }, () => {
	const offenders = [];
	for (const guide of allGuides().filter((g) => /^forever\/(alliance|horde)\//.test(g))) {
		const c = compiled(guide);
		if (c.category && c.category !== 'Leveling') continue;
		const last = [...c.steps].reverse().find((st) => forAllOnly(st.only) && !st.along && st.goals.some((g) => g.t !== 'note' && !g.optional));
		if (last && last.goals.some((g) => g.t === 'vendor' && !g.optional && forAllOnly(g.only))) offenders.push(`${guide}: ${last.title}`);
	}
	assert.deepEqual(offenders, [], 'last steps with a vendor goal');
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
	assert.equal(wet.filter(({ goal }) => goal.npc === 1244).map(({ s }) => s).filter((v, i, a) => a.indexOf(v) === i).length, 2, 'Rethiel on two stops (Fire Taboo and Blisters in, Blisters out)');
});

// --- Player reports, route-wide (0.3.0 to 0.3.4). Each case states a reported route problem as a property
// of every leveling route of a side, as one character plays it: a start's guides along `next`, with the
// goals that character's race and class get. They are keyed by quests, NPCs and places, never by a guide
// file or a step number, so a route rework that moves zones or renames guides is checked the same way.
// A case that fails on next and passes on the rework that fixes it carries a `todo` naming the issue and
// that pull request; the rework removes it when it lands, and a release ships with none left.

const { greyLevel } = require('../tools/lib/game/xp');

const STARTS = {
	Horde: [[ORC_DUROTAR, 'Orc'], [TROLL_DUROTAR, 'Troll'], [MULGORE, 'Tauren'], [TIRISFAL, 'Scourge'], [ZEPHRAS_HORDE, 'Skyborne']],
	Alliance: [[DWARF_DUN_MOROGH, 'Dwarf'], [DUN_MOROGHS[1], 'Gnome'], [ELWYNN, 'Human'], [TELDRASSIL, 'NightElf'], [ZEPHRAS_ALLIANCE, 'Skyborne']],
};
const routeMemo = new Map();
// Every character's route on a side, as { who, cls, list }: `list` the goals in order as { step, goal, s, guide }.
function routes(side) {
	if (!routeMemo.has(side)) {
		routeMemo.set(side, STARTS[side].flatMap(([start, race]) => {
			const all = chainFrom(start).flatMap((guide) => goals(guide).map((e) => ({ ...e, guide })));
			const mine = all.filter(forRaceOf(race));
			return data.raceClasses(race, side).map((cls) => ({ who: `${race} ${cls}`, cls, list: mine.filter(forClass(cls)) }));
		}));
	}
	return routeMemo.get(side);
}
const where = ({ guide, s }) => `${guide.replace(/^forever\//, '').replace(/\.guide$/, '')} step ${s}`;

// Follow-ups a giver offers only once the quest before them is handed in: the route asked for both on one
// visit and the giver had nothing. A route may leave the follow-up out; it may never take it early.
const FOLLOW_UPS = [
	{ side: 'Horde', quest: 96656, after: [382], says: 'The Adventurer is never accepted before The Red Messenger is handed in (#792)' },
	{ side: 'Horde', quest: 99142, after: [5482], says: 'Tomb Weed is never accepted before Doom Weed is handed in (#800)' },
	{ side: 'Horde', quest: 98601, after: [364], says: 'A Difficult Path is never accepted before The Mindless Ones is handed in (#830)' },
	{ side: 'Horde', quest: 97225, after: [805], says: "Forgotten Loa Idols is never accepted before Report to Sen'jin Village is handed in (#796)" },
	{ side: 'Horde', quest: 97282, after: [97281], says: 'Stormy Potential is never accepted before A Simmering Storm is handed in (#807)' },
	{ side: 'Horde', quest: 95981, after: [482], says: "Watching the Roads is never accepted before Dalaran's Intentions is handed in (#872)" },
	{ side: 'Horde', quest: 97275, after: [97242], says: "Whuut's the Rush is never accepted before Yelmak's Medley is handed in (#891)" },
	{ side: 'Horde', quest: 98252, after: [98251], says: 'A Void Path is never accepted before Never Coming Back is handed in (#984, #1002)' },
	{ side: 'Horde', quest: 96261, after: [96259], says: 'The Broodmother is never accepted before Defending the Dead is handed in (#1083)' },
	{ side: 'Alliance', quest: 98189, after: [286], says: 'Karl Boran\'s second Return the Statuette is never accepted before the first is handed in (#1113)' },
	{ side: 'Alliance', quest: 98190, after: [286, 98189], says: 'A Friend of the Family is never accepted before both Return the Statuette quests are handed in (#1118)' },
	{ side: 'Alliance', quest: 526, after: [324], says: 'Lightforge Ingots is never accepted before The Lost Ingots is handed in (#1116)' },
	{ side: 'Alliance', quest: 98240, after: [98072], says: 'Crimson Crate Delivery is never accepted before Crocs of the Sky is handed in (#1134)' },
	{ side: 'Alliance', quest: 98310, after: [98216], says: 'Gleaning Our Future is never accepted before Understanding Our Present is handed in (#1184, #1206)' },
	{ side: 'Alliance', quest: 98313, after: [98310], says: 'For Further Study is never accepted before Gleaning Our Future is handed in (#1184)' },
];
for (const { side, quest, after, says, todo } of FOLLOW_UPS) test(`Every ${side} route: ${says}`, { skip, todo }, () => {
	for (const { who, list } of routes(side)) {
		list.forEach((e, i) => {
			if (!is('accept', quest)(e.goal)) return;
			for (const pre of after) assert.ok(list.slice(0, i).some(({ goal }) => is('turnin', pre)(goal)), `${who}: ${where(e)} accepts ${quest} before ${pre} is handed in`);
		});
	}
});

// poro (#1065): Escorting Erland, a level 11 quest, came in the 16-19 Silverpine guide after a level 16.51
// target. Players run about a level above the route's targets (their recordings), so the level reached is
// rounded up: at 17 the quest is grey. It is taken while it still gives experience.
test('Every Horde route (#1065): Escorting Erland is taken before the route reaches the level at which it is grey', { skip }, () => {
	const qlvl = data.quest(435).level;
	for (const { who, list } of routes('Horde')) {
		list.forEach((e, i) => {
			if (!is('accept', 435)(e.goal)) return;
			const targets = list.slice(0, i).filter(({ goal }) => goal.t === 'level').map(({ goal }) => goal.level + (goal.frac || 0));
			const reached = Math.max(compiled(e.guide).minLevel || 0, ...targets);
			assert.ok(greyLevel(Math.ceil(reached)) < qlvl, `${who}: ${where(e)} takes Escorting Erland (level ${qlvl}) at level ${reached}, where it is grey`);
		});
	}
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
	const objectives = data.questObjectives(98095).map((o) => o.index);
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

// Zerkness (#383), Ioney (#396), soockee (#1117): Alonso's Dragonslayer quests are for Warriors only; a
// Paladin and a Shaman were sent to Mystral Lake for nothing.
test('Every route (#1117): only Warriors are sent to Alonso for the Dragonslayer quests', { skip }, () => {
	const ALONSO = 210995;
	for (const side of ['Horde', 'Alliance']) {
		for (const { who, cls, list } of routes(side)) {
			if (cls === 'WARRIOR') continue;
			const sent = list.find(({ goal }) => [78132, 78133, 78134].includes(goal.quest) || goal.npc === ALONSO);
			assert.ok(!sent, `${who}: ${sent && where(sent)} sends a ${cls} to Alonso`);
		}
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

// Bennistrov (#1191): the guide brought a Night Elf Druid back to Astranaar from the west only to fly to
// Auberdine. A flight out of Astranaar is taken on a visit that does something there.
test('Every Alliance route (#1191): Astranaar is never walked to only for a flight out of it', { skip }, () => {
	const { point } = makeProjector(data.mapFrames);
	const spawn = data.spawns('npc', 4267).find((sp) => sp.map === 1440);
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

// Bill (#1004): at Ratchet the guide sent you up to the inn to bind, then back down to Mebok Mizzyrix, who
// stands by the WANTED poster you had just read. The bind never splits two stops that stand side by side.
test('Every Horde route (Bill, #1004): the Ratchet bind never sends you back to where you stood before it', { skip }, () => {
	const { point } = makeProjector(data.mapFrames);
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

// Wetlands report (2026-11-07, Discord; #1184, #1206): on 0.3.4 "pretty much all the quests" the guide asked
// for at Menethil and the dig were chain quests nobody could take yet. Every leveling path (each start,
// each `next` option) is played as every race and class, and no accept may come before its blocking
// prerequisites are handed in on that path (tools/lib/route/prereq-order.js; lint's check counts a hand-in
// on any branch into the guide).
test('every leveling path hands in each accept\'s prerequisites before the accept, for every start, race and class', { skip }, () => {
	const { prereqOrder } = require('../tools/lib/route/prereq-order');
	const { guides, data: all } = compileProject({ packDir: OFFICIAL_DIR, manifest: { id: 'guides', author: 'Polestar' }, dataDir: DATA });
	const found = prereqOrder(guides, all).map(
		(v) => `${path.relative(OFFICIAL_DIR, v.file).split(path.sep).join('/')}:${v.line} accept ${v.quest} (${v.title}) needs ${v.missing.join(v.any ? ' or ' : ' and ')} handed in first (${v.race} ${v.cls || ''}, path from ${v.path[0]}${v.groups === 'do' ? ', group quests on' : ''})`
	);
	assert.deepEqual(found, []);
});

test('Wetlands (#1184, #1206): Whelgar\'s and Rethiel\'s chain quests come after the hand-in that opens them', { skip }, () => {
	const wet = goals('forever/alliance/06-wetlands.guide');
	const hb = goals('forever/alliance/30-40/01-hillsbrad-foothills.guide');
	const idx = (list, t, q) => at(list, `${t} ${q}`, (g) => g.t === t && g.quest === q);
	assert.ok(idx(wet, 'turnin', 299) < idx(wet, 'accept', 98216), 'Understanding Our Present after Uncovering the Past (#1206)');
	for (const t of ['collect', 'turnin']) {
		const g = wet.find(({ goal }) => goal.t === t && goal.quest === 98216);
		assert.ok((g.step.when || []).some((p) => p.k === 'onquest' && [].concat(p.q).includes(98216)), `the keystone's ${t} only with 98216 in the log`);
	}
	assert.ok(idx(wet, 'turnin', 98216) < idx(wet, 'accept', 98310), 'Gleaning Our Future after Understanding Our Present');
	assert.ok(wet[idx(wet, 'accept', 98310)].step.when.some((p) => p.k === 'turnedin' && [].concat(p.q).includes(98216)), 'Gleaning Our Future only once 98216 is handed in (98216 is optional)');
	assert.ok(idx(wet, 'turnin', 275) < idx(wet, 'accept', 98283), 'Carnage after Fen Creeper');
	assert.ok(!wet.some(({ goal }) => goal.t === 'accept' && goal.quest === 98313), 'For Further Study is not taken on the first dig visit');
	assert.ok(idx(hb, 'turnin', 98310) < idx(hb, 'accept', 98313), 'For Further Study after Gleaning Our Future');
	assert.ok(idx(hb, 'turnin', 637) < idx(hb, 'accept', 683), "Sara Balloo's Plea after Sully Balloo's Letter");
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

// --- Flights with nothing to do in between (#1191): a flight to a stop where nothing is left for the
// character to do, then straight on by another flight, is one flight to the second one's end (the game routes
// it through the first stop). The same rule as `forge guide lint`'s (validate.rs, check_flight_hops), per
// race and class: a `when` or any work between keeps the stop, a flight without a flight master to leave from
// (a druid's Moonglade flight) and a walk onto another continent (a boat, a zeppelin) end the check.

const FLIGHT_RACES = { horde: ['Orc', 'Scourge', 'Tauren', 'Troll', 'Skyborne'], alliance: ['Human', 'Dwarf', 'NightElf', 'Gnome', 'Skyborne'] };
const FLIGHT_CLASSES = ['WARRIOR', 'PALADIN', 'HUNTER', 'ROGUE', 'PRIEST', 'SHAMAN', 'MAGE', 'WARLOCK', 'DRUID'];
const forChar = (o, race, cls) => !o || ((!o.races || o.races.includes(race)) && (!o.classes || o.classes.includes(cls)));
// "<step> -> <step>" for each such pair in `guide` for one race and class.
function flightHops(guide, race, cls) {
	const nodes = new Map((data.travel?.taxi?.nodes || []).map((n) => [n.id, n.c]));
	const continent = (map) => (data.mapFrames.forever?.[map] || data.mapFrames.era?.[map] || {}).c;
	const steps = compiled(guide).steps.filter((step) => forChar(step.only, race, cls)).map((step) => ({ step, goals: step.goals.filter((g) => forChar(g.only, race, cls)) }));
	const work = (g) => !['goto', 'fly', 'note'].includes(g.t);
	const out = [];
	steps.forEach(({ step, goals }, i) => {
		const last = goals.map((g) => g.t).lastIndexOf('fly');
		if (last < 0 || step.when || !goals.slice(0, last).some((g) => g.t === 'goto' && g.x != null) || goals.slice(last + 1).some(work)) return;
		let on = nodes.get(goals[last].node);
		for (const { step: next, goals: later } of steps.slice(i + 1)) {
			if (next.when) return;
			const f = later.findIndex((g) => g.t === 'fly');
			const before = f < 0 ? later : later.slice(0, f);
			if (before.some(work)) return;
			for (const g of before.filter((g) => g.t === 'goto' && g.map != null)) {
				const c = continent(g.map);
				if (c == null) continue;
				if (on != null && c !== on) return;
				on = c;
			}
			if (f >= 0) {
				out.push(`${step.title} -> ${next.title}`);
				return;
			}
		}
	});
	return out;
}

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

test('The Hinterlands (Horde 48): Thorium Point flies straight to Tarren Mill, no stop at Hammerfall (#1191)', { skip }, () => {
	const list = goals('forever/horde/40-50/05-the-hinterlands.guide');
	const flights = list.filter(({ goal }) => goal.t === 'fly').map(({ goal }) => goal.location);
	assert.equal(flights[0], 'Tarren Mill');
	assert.ok(!flights.includes('Hammerfall'));
});

test('Eastern Plaguelands (Horde 55): Druids and Paladins fly from Orgrimmar to Thunder Bluff, not through Bloodvenom Post (#1191)', { skip }, () => {
	const list = goals('forever/horde/50-60/05-eastern-plaguelands.guide');
	for (const cls of ['DRUID', 'PALADIN', 'MAGE']) {
		const flights = list.filter(forClass(cls)).filter(({ goal }) => goal.t === 'fly').map(({ goal }) => goal.location);
		const from = flights.indexOf('Undercity');
		const after = cls === 'MAGE' ? flights.slice(from + 1, from + 2) : flights.slice(from + 1, from + 3);
		assert.deepEqual(after, cls === 'MAGE' ? ['Bloodvenom Post'] : ['Thunder Bluff', 'Bloodvenom Post'], `${cls}: ${flights.join(', ')}`);
	}
});

// Since the Horde 30-40 re-order Desolace is entered at 33 from the Shimmering Flats (30-40/02-thousand-needles).
test('Desolace (Horde 33): a Shaman flies from Freewind Post straight to Sun Rock Retreat, not back to Orgrimmar first (#1191)', { skip }, () => {
	const list = goals('forever/horde/30-40/02-thousand-needles.guide').filter(forClass('SHAMAN'));
	const flights = list.filter(({ goal }) => goal.t === 'fly').map(({ goal }) => goal.location);
	const at = flights.indexOf('Freewind Post');
	assert.ok(at >= 0, flights.join(', '));
	assert.equal(flights[at + 1], 'Sun Rock Retreat', flights.join(', '));
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
// --- end of flights with nothing to do in between

// Horde 12-30 re-chain (2026-11-07): Silverpine Forest 12-15, the Barrens and Stonetalon's road 15-21,
// Ashenvale and the Silverpine ride 21-22, Hillsbrad 22-24, the Barrens and Sun Rock 24-26, Ashenvale and
// Thousand Needles 26-30. A quest whose objectives are not done yet never rides out of the guide (the zone
// stay) that takes it into the next one, for any start: a delivery or a finished quest may wait for its
// hand-in, and class quests and optional tours may run on, but zone work is done in its stay. On the old
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
		const list = chain.flatMap((g) => goals(g).map((e) => ({ ...e, g })))
			.filter(({ step, goal }) => fits(step.only) && fits(goal.only) && !cls(step.only) && !cls(goal.only));
		const classQuest = (q) => !!(data.quests[q] && data.quests[q].classes);
		const lastWork = new Map();
		list.forEach(({ goal }, i) => { if (WORK.has(goal.t) && goal.quest != null && !goal.optional) lastWork.set(goal.quest, i); });
		const open = new Map();
		list.forEach(({ goal, g }, i) => {
			if (goal.t === 'accept' && !goal.optional && !classQuest(goal.quest)) open.set(goal.quest, g);
			if (goal.t === 'turnin') open.delete(goal.quest);
			const nextG = list[i + 1] && list[i + 1].g;
			if (nextG && nextG !== g) {
				for (const [q, from] of open) {
					assert.ok(!(lastWork.get(q) > i), `${race}: ${q} (${data.quests[q] && data.quests[q].title}) rides from ${from} into ${nextG} with its objectives still to do`);
				}
			}
		});
	}
});

// --- Horde 30-40 re-order (2026-11-07, Final3040's report: 379 minutes of grind in Desolace &
// Hillsbrad and 310 in Stranglethorn, a top-up to 32.2 at Sargeron right after arriving at 30). The
// zones in the order their quest levels fit, as both other orders run them: Hillsbrad and a first
// Arathi visit 30-32, the Shimmering Flats and Desolace's 33-36 quests 32-34, Stranglethorn, Dustwallow
// with a short second Desolace stop for its 38-40 quests, Alterac and Arathi, the Badlands, then the
// flight to Booty Bay for 40-50. Martek the Exiled is taken once Hardened Shells is in (the game's
// prerequisites), and Stolen Freewind Supplies goes with Stop the Screeching.
const H3040 = ['01-hillsbrad-foothills', '02-thousand-needles', '03-stranglethorn-vale', '04-dustwallow-marsh', '05-arathi-highlands', '06-badlands'].map((n) => `forever/horde/30-40/${n}.guide`);
test('Horde 30-40 re-order: the chain runs Hillsbrad, the Flats and Desolace, Stranglethorn, Dustwallow, Alterac and Arathi, the Badlands', { skip }, () => {
	const header = (g) => fs.readFileSync(path.join(__dirname, '..', 'guides', g), 'utf8');
	const nextOf = (g) => (header(g).match(/^next (.*)$/m) || [])[1];
	assert.equal(nextOf('forever/horde/07-ashenvale.guide'), 'forever/horde/30-40/01-hillsbrad-foothills');
	for (let i = 0; i < H3040.length - 1; i++) assert.equal(nextOf(H3040[i]), H3040[i + 1].replace(/\.guide$/, ''), `${H3040[i]} leads to the next zone`);
	assert.equal(nextOf(H3040[5]), 'forever/horde/40-50/01-stranglethorn-vale');
	const retired = JSON.parse(fs.readFileSync(path.join(__dirname, '..', 'guides', 'retired.json'), 'utf8'));
	for (const id of ['01-desolace', '02-stranglethorn-vale', '03-arathi-highlands']) assert.ok(retired.includes(`forever/horde/30-40/${id}`), `${id} is retired`);
	const [hills, tn, , dust, alterac] = H3040.map((g) => goals(g));
	const has = (list, t, q) => list.some(({ goal }) => goal.t === t && goal.quest === q);
	for (const q of [532, 539, 553, 677]) assert.ok(has(hills, 'turnin', q), `${q} in the 30-32 guide`);
	assert.ok(!has(hills, 'turnin', 1365) && has(tn, 'turnin', 1365), 'Desolace is not entered at 30');
	for (const q of [1105, 1176, 1175, 1147, 5361, 6027]) assert.ok(has(tn, 'turnin', q), `${q} with the Flats and Desolace`);
	for (const q of [5581, 6134, 93225]) assert.ok(has(dust, 'turnin', q) && !has(tn, 'turnin', q), `${q} on the second Desolace stop, at 38`);
	for (const q of [503, 507, 508, 651]) assert.ok(has(alterac, 'turnin', q), `${q} on the 38-39 Alterac and Arathi visit`);
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

test('forever/horde/07-ashenvale.guide: Stolen Freewind Supplies with Stop the Screeching, in the same harpy den', { skip }, () => {
	const list = goals('forever/horde/07-ashenvale.guide');
	const step = (t, q) => list[at(list, `${t} ${q}`, is(t, q))].s;
	assert.equal(step('accept', 98069), step('accept', 98070), 'taken from Jandia with Stop the Screeching');
	assert.equal(list[at(list, 'collect 279383', (g) => g.t === 'collect' && g.quest === 98069)].s, list[at(list, 'kill 4101', (g) => g.t === 'kill' && g.quest === 98070)].s, 'the supplies in the Screeching Canyon step');
	assert.equal(step('turnin', 98069), step('turnin', 98070), 'handed in with it');
});

// --- Alliance 40-60 order (2026-11-08): a first Western Plaguelands stop at ~51 between the Hinterlands and the Burning
// Steppes, and every accept the level model ground for (a quest 5+ levels above, or under its minimum level) taken on a
// later visit to the same giver, with the work and the hand-in where the route already goes.
test('Alliance 40-60 order: the first Western Plaguelands stop before the Burning Steppes, high accepts on the later visit', { skip }, () => {
	const A = (g) => `forever/alliance/${g}.guide`;
	const bs = goals(A('50-60/01-burning-steppes'));
	const pos = (list, t, q) => at(list, `${t} ${q}`, is(t, q));
	assert.ok(pos(bs, 'turnin', 5217) < pos(bs, 'accept', 3823), 'the cauldron at Felstone Field before Morgan\'s Vigil');
	assert.ok(at(bs, 'the Wildkin Feathers (3661)', (g) => g.t === 'collect' && g.quest === 3661) < pos(bs, 'accept', 5092), 'the Hinterlands feathers on the way to Southshore, then Chillwind Camp');
	assert.ok(pos(bs, 'accept', 3702) < pos(bs, 'accept', 3823), 'Archesonus on the Ironforge stop before the Steppes');
	assert.ok(!goals(A('40-50/07-un-goro-crater')).some(({ goal }) => goal.quest === 3702 || goal.quest === 3701 || goal.quest === 4504), 'no 54s taken at 49 in Un\'Goro\'s guide');
	const wpl = goals(A('50-60/04-western-plaguelands'));
	assert.ok(pos(wpl, 'turnin', 4493) <= pos(wpl, 'accept', 4504), 'Super Sticky from Tran\'rek on the 57 Gadgetzan stop');
	assert.ok(!goals(A('50-60/03-winterspring')).some(({ goal }) => [6604, 4861, 4863, 4864, 5281, 5249].includes(goal.quest)), 'Jaron\'s chain, The Restless Souls and To Winterspring! are not in the 53-55 Winterspring guide');
	const last = goals(A('50-60/06-silithus'));
	assert.ok(pos(last, 'turnin', 6604) < pos(last, 'turnin', 4864), 'Jaron\'s chain on the 58-59 Winterspring visit');
	assert.ok(pos(goals(A('50-60/05-silithus')), 'turnin', 5181) <= pos(goals(A('50-60/05-silithus')), 'accept', 5281), 'The Restless Souls from Caretaker Alen at 58');
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
	const fixes = JSON.parse(fs.readFileSync(path.join(__dirname, '..', 'data', 'guide-fixes.json'), 'utf8')).fixes;
	const rec = fixes.find((f) => f.at && f.at.quest === 852 && f.at.goal === 'objective');
	assert.ok(rec && /walks that shore/.test(rec.tip), 'the guide-fixes record holds the tip');
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

// --- Horde 40-60 accept levels (2026-11-08). The level model ground before accepts it could not take at the route's
// level (a minimum level above it, or a quest 5+ levels over): 1,287 minutes for an Orc Warrior, 409 of them in Feralas
// at 46 for The Strength of Corruption (minimum 47). Each is now taken on a later stop at the same giver, or a written
// top-up at the spot before it brings the level.
test('Horde 40-60 accept levels: quests are taken where the route reaches their level', { skip }, () => {
	const g = (n) => goals(`forever/horde/${n}.guide`);
	const step = (list, t, q) => list[at(list, `${t} ${q}`, is(t, q))].s;
	const stv = g('40-50/01-stranglethorn-vale');
	assert.equal(step(stv, 'accept', 348), step(stv, 'turnin', 587), 'Stranglethorn Fever on the Booty Bay stop after the Wild Shore');
	assert.equal(step(stv, 'accept', 2864), step(stv, 'turnin', 209), "Tran'rek on the last Booty Bay stop");
	for (const q of [348, 2872, 2864]) assert.ok(step(stv, 'accept', q) > step(stv, 'turnin', 595), `${q} not on arrival`);
	const zk = stv[at(stv, 'collect 3905 quest 584', (x) => x.t === 'collect' && x.quest === 584)];
	assert.ok(zk.step.goals.some((x) => x.t === 'level' && x.level === 41), "Zul'Kunda brings you to 41 before Speaking with Gan'zulah");
	assert.ok(!g('40-50/03-feralas').some(({ goal }) => is('accept', 4120)(goal)), 'The Strength of Corruption is not taken at 46');
	const azs = g('40-50/06-azshara');
	assert.equal(step(azs, 'accept', 4120), step(azs, 'turnin', 3123), "The Strength of Corruption from Talo on the Mojache stop at 49-50");
	const t50 = azs.findIndex(({ goal }) => goal.t === 'level' && goal.level === 50);
	assert.ok(t50 >= 0 && t50 < at(azs, 'accept 4494', is('accept', 4494)), "Azshara's top-up reaches 50 before March of the Silithid");
	const ung = g('50-60/01-un-goro-crater');
	const top = ung.findIndex(({ goal }) => goal.t === 'level' && goal.level === 52);
	assert.ok(top >= 0 && top < at(ung, 'accept 4061', is('accept', 4061)), "Un'Goro's top-up reaches 52 before The Rise of the Machines");
	const sil = g('50-60/06-silithus');
	assert.equal(step(sil, 'accept', 8318), step(sil, 'turnin', 8318), 'Secret Communication taken and handed in on one stop');
	const t58 = sil.findIndex(({ goal }) => goal.t === 'level' && goal.level === 58);
	assert.ok(t58 >= 0 && t58 < at(sil, 'accept 8304', is('accept', 8304)), 'a top-up to 58 before Dearest Natalia');
});

// --- Alliance quest volume, flow follow-up (2026-11-08): the stops the added quests cost are folded
// into walks the route makes anyway (the release audit's flow findings on the quest-volume batch).
test('Alliance quest volume follow-up: the added quests ride on walks the route already makes', { skip }, () => {
	const first = (list, pred) => list.findIndex(({ goal }) => pred(goal));
	const tel = goals('forever/alliance/nightelf/01-teldrassil.guide');
	assert.ok(first(tel, is('turnin', 490)) < first(tel, is('accept', 937)), 'Teldrassil: the fang bounty is handed to Shayla on the way to the Oracle Glade');
	assert.ok(first(tel, is('accept', 931)) < first(tel, (g) => g.t === 'collect' && g.quest === 2518), 'Teldrassil: the Strange Fronded Plant is taken on the walk north to Lady Sathrah');
	const owl = first(tel, (g) => g.t === 'use' && g.quest === 98067 && g.oi === 1);
	assert.ok(owl > first(tel, is('accept', 98046)) && owl < first(tel, is('turnin', 923)), 'Darnassus: the tunnel-mouth owl is placed on the walk south from the Enclave');
	const wet = goals('forever/alliance/06-wetlands.guide');
	assert.ok(first(wet, is('turnin', 469)) > first(wet, is('accept', 465)), 'Wetlands: Halloran after Stoutfist');
});

// --- Triage round 5 (2026-11-08) ---

// Bonesavv77's report (#1241, Orc Warrior 24): Sun Rock Retreat took Braelyn Firehand and the flight path
// before Tammra Windfield, a walk back east across the town. Arriving from the south (Tsunaman, Maggran),
// Tammra comes first, then Braelyn outside the gate and the flight master beside her on the way out
// (route-fixes after: accept 6301 before accept 1087, Horde).
test("Bonesavv77's report (#1241): Sun Rock Retreat takes Tammra Windfield before Braelyn Firehand and the flight path", { skip }, () => {
	const fixes = JSON.parse(fs.readFileSync(path.join(__dirname, '..', 'data', 'route-fixes.json'), 'utf8'));
	assert.ok(fixes.deliberate.after.some((p) => p.a[0] === 'accept' && p.a[1] === 6301 && p.b[0] === 'accept' && p.b[1] === 1087), 'the order is a record the build keeps');
	const list = goals('forever/horde/04-the-barrens.guide');
	const tammra = at(list, 'accept 6301', is('accept', 6301));
	const braelyn = at(list, 'accept 1087', is('accept', 1087));
	const fp = at(list, 'getfp Sun Rock Retreat', (g) => g.t === 'getfp' && /Sun Rock/.test(g.location || ''));
	assert.ok(tammra < braelyn && braelyn < fp, 'Tammra, then Braelyn, then the flight master');
	assert.equal(list[tammra].step, list[fp].step, 'one Sun Rock stop');
});

// The guide file's tip lines for the step holding the first goal that matches `re`.
function stepTips(guide, re) {
	const lines = fs.readFileSync(path.join(OFFICIAL_DIR, guide), 'utf8').split('\n');
	const k = lines.findIndex((l) => re.test(l));
	assert.ok(k >= 0, `${re} is in ${guide}`);
	let s = k;
	while (s > 0 && !/^step /.test(lines[s])) s--;
	let e = k;
	while (e < lines.length && !/^step /.test(lines[e + 1] || 'step ')) e++;
	return lines.slice(s, e + 1).filter((l) => /^\s+tip /.test(l)).map((l) => l.replace(/^\s+tip /, ''));
}

// Gray's report (#1234): Kodo Roundup counts a tamed kodo only once you talk to it at Smeed's camp, and
// the Kombobulator tames no other until then (players' recordings: each of the five ticks came with the
// kodo's window). The tips said "five times" and nothing about talking to it. The tip is a guide-fixes
// record for each side, so a build writes it again.
test("Gray's report (#1234): Kodo Roundup's tip says to talk to each tamed kodo at Smeed's, one at a time", { skip }, () => {
	const fixes = JSON.parse(fs.readFileSync(path.join(__dirname, '..', 'data', 'guide-fixes.json'), 'utf8')).fixes;
	for (const [guide, faction, re] of [
		['forever/horde/30-40/02-thousand-needles.guide', 'Horde', /^\s+complete 5561\b/],
		['forever/alliance/30-40/02-desolace.guide', 'Alliance', /quest 5561\.1\b/],
	]) {
		const rec = fixes.find((f) => f.at.quest === 5561 && f.faction === faction && f.tip);
		assert.ok(rec, `${faction}: the tip is a record`);
		assert.deepEqual(stepTips(guide, re), [rec.tip], `${faction}: the step's tip is the record's`);
		assert.match(rec.tip, /talk to the kodo/);
		assert.match(rec.tip, /one at a time/);
	}
});

// #1257 (Dwarf Shaman 24, Duskwood): the arrow sought the Pygmy Venom Web Spiders by Sven's camp in the
// north, where few spawn among the wolves and bigger spiders, and the tip put them east of the cemetery.
// Half their western spawns lie on the Hushed Bank west of Raven Hill: the arrow goes there (places
// record) and the tip says so (guide-fixes record).
test('#1257: Duskwood\'s Pygmy Venom Web Spiders are sought on the Hushed Bank west of Raven Hill', { skip }, () => {
	const guide = 'forever/alliance/04-redridge-mountains.guide';
	const place = JSON.parse(fs.readFileSync(path.join(__dirname, '..', 'data', 'places.json'), 'utf8')).places.find((p) => p.quest === 245 && p.objective === 1);
	assert.ok(place, 'the spot is a record');
	const { goal } = goals(guide)[at(goals(guide), 'kill 539 quest 245', (g) => g.t === 'kill' && g.quest === 245)];
	assert.equal(goal.map, 1431);
	assert.ok(Math.abs(goal.x - place.at.x) < 0.5 && Math.abs(goal.y - place.at.y) < 0.5, `the arrow goes to ${place.at.x},${place.at.y}, not ${goal.x},${goal.y}`);
	const spawns = data.npcs[539].spawns[1431];
	const near = [...spawns.pts, ...(spawns.more || [])].filter((p) => Math.hypot(p[0] - goal.x, p[1] - goal.y) < 7).length;
	assert.ok(near >= 8, `most western spawns are near the spot (${near})`);
	const rec = JSON.parse(fs.readFileSync(path.join(__dirname, '..', 'data', 'guide-fixes.json'), 'utf8')).fixes.find((f) => f.at.quest === 245 && f.tip);
	assert.ok(rec, 'the tip is a record');
	assert.deepEqual(stepTips(guide, /kill 539 quest 245/), [rec.tip]);
	assert.doesNotMatch(rec.tip, /east of the cemetery/);
});

// Final route review for 0.3.5 (Horde 30-40): Call of Air (1531) is offered from level 30, and the
// 30-40/01 Orgrimmar stop comes at about 29.4, so Searn Firewarder had nothing for the Shaman the step
// sent there. The accept is on 30-40/02's Orgrimmar stop (about 31.7, after Alliance Relations, also
// from 30), before Prate Cloudseer takes it at Freewind Post; a route-fixes pair keeps it there.
test('Horde 30-40: Call of Air is taken on the Orgrimmar stop at 31, not at 29', { skip }, () => {
	data = data || loadData(DATA);
	assert.equal(data.quests[1531].minLevel, 30, 'Call of Air is offered from level 30');
	const first = goals('forever/horde/30-40/01-hillsbrad-foothills.guide');
	assert.ok(!first.some(({ goal }) => goal.t === 'accept' && goal.quest === 1531), 'no Call of Air on the 29.4 Orgrimmar stop');
	const list = goals('forever/horde/30-40/02-thousand-needles.guide').filter(forClass('SHAMAN'));
	const relations = at(list, 'accept 1431', is('accept', 1431));
	const air = at(list, 'accept 1531', is('accept', 1531));
	const prate = at(list, 'turnin 1531', is('turnin', 1531));
	const fly = at(list, 'fly to Freewind Post', (g) => g.t === 'fly' && /Freewind/.test(g.location || ''));
	assert.ok(relations < air && air < fly && fly < prate, 'Alliance Relations, Call of Air, the flight, then Prate');
	const pair = JSON.parse(fs.readFileSync(path.join(__dirname, '..', 'data', 'route-fixes.json'), 'utf8')).deliberate.pairs
		.find((p) => p.a[0] === 'accept' && p.a[1] === 1431 && p.b[0] === 'accept' && p.b[1] === 1531);
	assert.ok(pair, 'the order is a record');
});

// Final route review for 0.3.5 (Arathi 36-39, both sides): Sunken Treasure's escort step said the
// professor goes down to the shore and naga ambush him; he walks up to the cave above Faldir's Cove and
// summons two water elementals there (the server's script), as the writer's own 'Careful' tip said.
// One guide-fixes tip for both sides.
test('Sunken Treasure: the escort tip sends you up to the cave, where two water elementals come', { skip }, () => {
	const rec = JSON.parse(fs.readFileSync(path.join(__dirname, '..', 'data', 'guide-fixes.json'), 'utf8')).fixes.find((f) => f.at.quest === 665 && f.tip);
	assert.ok(rec, 'the tip is a record');
	assert.match(rec.tip, /cave/);
	assert.match(rec.tip, /water elementals/);
	assert.doesNotMatch(rec.tip, /naga|shore|beach/);
	for (const guide of ['forever/horde/30-40/05-arathi-highlands.guide', 'forever/alliance/30-40/05-arathi-highlands.guide']) {
		assert.deepEqual(stepTips(guide, /^\s+complete 665\b/), [rec.tip], `${guide}: the step's tip is the record's`);
	}
});

// Final route review for 0.3.5 (Horde Stranglethorn 34-37): the step that lands from the zeppelin was
// titled "Fly to Grom'gol"; the tigers' tip put them east of Nesingwary's camp along the lake (they are
// around and south of it, the panthers west); the Venture Co. step sent you north past Nesingwary's camp
// (the geologists' lake is south-east of it). The tigers' tip is a guide-fixes record, the other two are
// seed lines.
test('Horde Stranglethorn: the Grom\'gol landing, the tigers and the Venture Co. camp are where the steps say', { skip }, () => {
	const guide = 'forever/horde/30-40/03-stranglethorn-vale.guide';
	const list = goals(guide);
	const fp = at(list, 'getfp Grom\'gol', (g) => g.t === 'getfp' && /Grom'gol/.test(g.location || ''));
	assert.doesNotMatch(list[fp].step.title || '', /^Fly/, 'the zeppelin landing is not titled as a flight');
	const rec = JSON.parse(fs.readFileSync(path.join(__dirname, '..', 'data', 'guide-fixes.json'), 'utf8')).fixes.find((f) => f.at.quest === 186 && f.faction === 'Horde' && f.tip);
	assert.ok(rec, 'the tigers\' tip is a record');
	assert.deepEqual(stepTips(guide, /kill 682 quest 186\b/), [rec.tip]);
	assert.doesNotMatch(rec.tip, /hills east of the camp|along the lake shore/);
	// Since the Horde 30-40 audit (2026-11-09) the Tumbled Crystals are only gathered on that loop, by Lake
	// Nazferiti, and handed to Kebok on the next Booty Bay stop: no second Venture Co. trip after it.
	assert.match(rec.tip, /Lake Nazferiti/);
	const crystals = list.filter(({ goal }) => goal.t === 'collect' && goal.item === 4106);
	assert.equal(crystals.length, 1, 'the crystals are gathered once');
	assert.ok(list.findIndex(({ goal }) => goal === crystals[0].goal) < at(list, 'turnin 213', is('turnin', 213)), 'Hostile Takeover is handed in in this guide, after the crystals');
});

// Final route review for 0.3.5 (Alliance Badlands 38-39): Lotwil's level 42 bracers were listed at his
// hand-in with no word on where they drop (the Greater Rock Elementals, 42-44, in the south-west); a note
// said Lotwil's next test needs crafted gear (that is Lucien's quest); and another said the skeleton's next
// task, Murdaloc, waits for a later guide right under the accept of Murdaloc itself.
test('Alliance Badlands: Lotwil\'s bracers, Lucien\'s crafted bracers and Murdaloc are described as they are', { skip }, () => {
	const guide = 'forever/alliance/30-40/06-badlands.guide';
	const rec = JSON.parse(fs.readFileSync(path.join(__dirname, '..', 'data', 'guide-fixes.json'), 'utf8')).fixes.find((f) => f.at.quest === 712 && f.faction === 'Alliance' && f.tip);
	assert.ok(rec, 'the bracers\' tip is a record');
	assert.deepEqual(stepTips(guide, /^\s+accept 712\b/), [rec.tip]);
	assert.match(rec.tip, /Greater Rock Elementals/);
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
	const stormpike = steps.find((s) => s.goals.some((g) => g.t === 'turnin' && g.quest === 514));
	assert.equal(stormpike.title, 'Hall of Explorers');
});

// Final route review for 0.3.5 (Horde 30-32): the level 31 top-up said Hammerfall's quests start at 31
// (they are offered from 29-30; the top-up keeps their 32-36 levels within reach), and the level 30 top-up
// by Tarren Mill had no dungeon to run instead of the yetis.
test('Horde Hillsbrad 30-32: the level 30 and 31 top-ups say why, and the first offers the Graveyard', { skip }, () => {
	data = data || loadData(DATA);
	const guide = 'forever/horde/30-40/01-hillsbrad-foothills.guide';
	for (const q of [655, 672, 677, 97539]) assert.ok(data.quests[q].minLevel <= 30, `${q} is offered below 31`);
	const [t31] = stepTips(guide, /^\s+level 31\b/);
	assert.doesNotMatch(t31, /start at 31/);
	const [t30] = stepTips(guide, /^\s+level 30\b/);
	assert.match(t30, /Scarlet Monastery/);
});

// Final route review for 0.3.5 (Alliance 30-40): Bartolo's Yeti Fur Cloak (565) also wants a Hillman's
// Cloak and a Bolt of Woolen Cloth, which no vendor sells and no step gets. It is optional, with its yeti
// cave only for players who took it, and a route-fixes record keeps it so.
test('Alliance 30-40: Bartolo\'s Yeti Fur Cloak is optional and says what it needs', { skip }, () => {
	data = data || loadData(DATA);
	for (const item of [3719, 2997]) assert.deepEqual(data.items[item].vendors || [], [], `${item} is not sold`);
	const first = goals('forever/alliance/30-40/01-hillsbrad-foothills.guide');
	const acc = first[at(first, 'accept 565', is('accept', 565))];
	assert.ok(acc.goal.optional, 'the accept is optional');
	assert.match(acc.goal.note || '', /Hillman's Cloak/);
	const fur = first[at(first, 'collect 3720', (g) => g.t === 'collect' && g.quest === 565)];
	assert.ok(fur.goal.optional || /565/.test(JSON.stringify(fur.step.when || fur.step.conditions || '')), 'the yeti fur is only for those on it');
	const last = goals('forever/alliance/30-40/05-arathi-highlands.guide');
	assert.ok(last[at(last, 'turnin 565', is('turnin', 565))].goal.optional, 'the hand-in is optional');
	const rec = JSON.parse(fs.readFileSync(path.join(__dirname, '..', 'data', 'route-fixes.json'), 'utf8')).deliberate.optional.find((o) => o.q === 565);
	assert.ok(rec, 'optional is a record');
});

// Final route review for 0.3.5 (Alliance 32-33): from the Mirage Raceway the guide walked back west to the
// Great Lift, north through the Barrens and east through Dustwallow to Theramore (about 5,800 yd). It now
// takes the road south to Gadgetzan (about 1,000 yd), learns the flight path and flies to Theramore.
test('Alliance Thousand Needles: from the Raceway to Gadgetzan and a flight to Theramore, not back through the Barrens', { skip }, () => {
	const list = goals('forever/alliance/30-40/03-ashenvale.guide');
	const race = at(list, 'turnin 1175', is('turnin', 1175));
	const fp = at(list, 'getfp Gadgetzan', (g) => g.t === 'getfp' && /Gadgetzan/.test(g.location || ''));
	const fly = at(list, 'fly Theramore', (g) => g.t === 'fly' && /Theramore/.test(g.location || ''));
	const fiora = at(list, 'turnin 1135', is('turnin', 1135));
	assert.ok(race < fp && fp < fly && fly < fiora, 'Raceway, Gadgetzan, the flight, then Theramore');
	assert.ok(!list.slice(race, fiora).some(({ goal }) => goal.t === 'goto' && goal.map === 1445 && goal.x < 40), 'no walk past the Shady Rest Inn');
});

// Final route review for 0.3.5 (Fitz: grind if we must, but say so): every written grind step in 30-40
// names where to grind and a dungeon to run instead, in the writer's sentence.
test('30-40: every written grind step says where, and names a dungeon to run instead', { skip }, () => {
	const dir = path.join(OFFICIAL_DIR, 'forever');
	for (const side of ['horde', 'alliance']) {
		for (const f of fs.readdirSync(path.join(dir, side, '30-40'))) {
			const guide = `forever/${side}/30-40/${f}`;
			for (const { step, goal } of goals(guide)) {
				if (goal.t !== 'level') continue;
				assert.match([step.note, step.tip].flat().filter(Boolean).join(' '), /Or, with a group, run the .+ dungeon( \(.+\))? instead\.$/, `${guide}: "${step.title}"`);
				assert.match([step.note, step.tip].flat().filter(Boolean).join(' '), /until level/, `${guide}: "${step.title}" says where`);
			}
		}
	}
});

// Final route review, Alliance 1-30 (2026-11-08): Night Elves take Further Concerns (35) from Marshal Dughan
// at the end of their Darkshore guide (level 14), then walk the Elwynn road past Guard Thomas' bridge on
// 03-loch-modan's way to Redridge at about 19; the route carried it to 04-redridge-mountains at about 24.
test('forever/alliance/03-loch-modan.guide: final review: Night Elves hand Further Concerns to Guard Thomas on the Elwynn road', { skip }, () => {
	const list = goals('forever/alliance/03-loch-modan.guide');
	const thomas = at(list, 'turnin 35', is('turnin', 35));
	const { step } = list[thomas];
	assert.deepEqual(step.only && step.only.races, ['NightElf'], 'a Night Elf step');
	assert.ok(step.when.some((p) => p.k === 'onquest' && !p.neg && [].concat(p.q).includes(35)), 'only while carried');
	const road = at(list, 'goto 65.2,69.7', (g) => g.t === 'goto' && Math.abs(g.x - 65.2) < 0.1 && Math.abs(g.y - 69.7) < 0.1);
	const wiley = at(list, 'turnin 65', is('turnin', 65));
	assert.ok(road < thomas && thomas < wiley, 'on the road east, before Lakeshire');
	assert.ok(!goals('forever/alliance/04-redridge-mountains.guide').some(({ goal }) => is('turnin', 35)(goal)), 'not carried to 04-redridge-mountains');
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

// Final route review follow-up (2026-11-08): the Dwarf and Gnome starts crossed Ironforge five times after the
// Thelsamar gryphon (a bare goto to Tinker Town's mailbox, back to the Great Forge for the flight path, the Hall of
// Arms, the Forlorn Cavern, the Military Ward, the High Seat, then the tram). Now one round: Great Forge, Tinker Town,
// the Forlorn Cavern, the Mystic Ward, the High Seat, the Military Ward, the tram.
for (const DUN_MOROGH of DUN_MOROGHS) test(`${DUN_MOROGH}: final review: Ironforge in one round of the city`, { skip }, () => {
	const list = goals(DUN_MOROGH);
	const gryth = at(list, 'turnin 6388', is('turnin', 6388));
	const fp = at(list, 'getfp Ironforge', (g) => g.t === 'getfp' && /Ironforge/.test(g.location || g.text || ''));
	assert.equal(list[fp].step, list[gryth].step, 'the flight path with Gryth');
	const tram = at(list, 'goto Deeprun Tram', (g) => g.t === 'goto' && g.text === 'Deeprun Tram');
	const city = list.slice(gryth, tram + 1);
	assert.ok(!city.some(({ goal }) => goal.t === 'goto' && goal.text === 'Ironforge'), 'no bare goto into Tinker Town');
	const order = [is('accept', 97263), is('turnin', 97263), is('turnin', 291)].map((p, k) => at(list, `stop ${k}`, p));
	assert.ok(gryth < order[0] && order[0] < order[1] && order[1] < order[2] && order[2] < tram, 'Tinker Town, Eldrun, the senator, the tram');
	const trains = city.filter(({ goal }) => goal.t === 'train' && goal.class === true).map(({ goal }) => goal);
	assert.ok(trains.every((g) => g.only), 'each trainer stop names its classes');
});

// Final route review before 0.3.5, Alliance 40-60: the Gadgetzan stop told the player to skip Sprinkle's next
// ingredient ("the route never brings it back") right before accepting it; the route takes it, collects it in
// the Hinterlands and hands it in on the Un'Goro guide's Gadgetzan stop.
test('forever/alliance/40-50/04-tanaris.guide: final review: no note to skip Sprinkle\'s Secret Ingredient, which the route takes', { skip }, () => {
	const list = goals('forever/alliance/40-50/04-tanaris.guide');
	const take = at(list, 'accept 2641', is('accept', 2641));
	const stop = list.filter(({ s }) => s === list[take].s);
	assert.ok(!stop.some(({ goal }) => goal.t === 'note' && /Sprinkle/.test(goal.text) && /skip/i.test(goal.text)), 'no skip note on the stop that takes it');
	assert.ok(list.some(({ goal }) => goal.t === 'collect' && goal.quest === 2641), 'its ingredient is collected');
	assert.ok(goals('forever/alliance/40-50/07-un-goro-crater.guide').some(({ goal }) => goal.t === 'turnin' && goal.quest === 2641), 'and handed in at Gadgetzan in the Un\'Goro guide');
});

// Final route review before 0.3.5, Alliance 40-60: the Burning Steppes topped up to 51.39 on the Dreadmaul Rock
// ogres on the way to Flame Crest, then rode back to the same ogres for a top-up to 52 right after the Flame Crest
// accepts. Nothing between gives experience: one top-up to 52 on the way (guide-fixes level record).
test('forever/alliance/50-60/01-burning-steppes.guide: final review: one top-up to 52 at Dreadmaul Rock before Flame Crest, no ride back', { skip }, () => {
	const list = goals('forever/alliance/50-60/01-burning-steppes.guide');
	const crest = at(list, 'accept 4726', is('accept', 4726));
	const vigil = at(list, 'accept 3824', is('accept', 3824));
	const grinds = list.filter(({ goal }) => goal.t === 'level');
	const between = grinds.filter(({ s }) => s > list[vigil].s && s < list[crest].s);
	assert.ok(between.some(({ goal }) => goal.level >= 52), 'the top-up to 52 is on the way to Flame Crest');
	const after = list.findIndex(({ goal }) => goal.t === 'turnin' && goal.quest === 4726);
	assert.ok(!grinds.some(({ s }) => s > list[crest].s && s < list[after].s), 'no top-up between the Flame Crest accepts and their hand-ins');
	const rec = JSON.parse(fs.readFileSync(path.join(__dirname, '..', 'data', 'guide-fixes.json'), 'utf8')).fixes.find((f) => f.at.quest === 4726 && f.at.goal === 'accept');
	assert.equal(rec && rec.level, 52, 'a level record keeps it on a refresh');
});

// Final route review before 0.3.5, Alliance 40-60: Searing Gorge starts at the Grimesilt outhouse in the south-east
// (Caught!), but the ride in from Thelsamar was described on the later Thorium Point step, and the outhouse step
// said to ride east across the Cauldron. Both tips are records now.
test('forever/alliance/40-50/06-searing-gorge.guide: final review: the ride in is on the first stop, Thorium Point from the dig site', { skip }, () => {
	const guide = 'forever/alliance/40-50/06-searing-gorge.guide';
	const list = goals(guide);
	const outhouse = list[at(list, 'accept 4449', is('accept', 4449))];
	const point = list[at(list, 'accept 7722', is('accept', 7722))];
	assert.ok(outhouse.s < point.s, 'the outhouse comes first');
	assert.match(outhouse.step.note, /Thelsamar/, 'the first stop says how to get in');
	assert.doesNotMatch(point.step.note, /Thelsamar/, 'Thorium Point starts from the dig site');
	const recs = JSON.parse(fs.readFileSync(path.join(__dirname, '..', 'data', 'guide-fixes.json'), 'utf8')).fixes;
	for (const quest of [4449, 7722]) {
		const rec = recs.find((f) => f.at.quest === quest && f.at.goal === 'accept' && f.tip);
		assert.ok(rec, `${quest}: the tip is a record`);
		assert.deepEqual(stepTips(guide, new RegExp(`^  accept ${quest}\\b`)), [rec.tip]);
	}
});

// Final route review before 0.3.5, Alliance 40-60: the 58 Light's Hope stop handed Villains of Darrowshire to Carlin
// Redpath, walked to Caretaker Alen, and came back to Carlin for Heroes of Darrowshire, under a tip from an older
// order ("ride on north to Chillwind Camp and fly to Light's Hope Chapel"). Carlin's hand-ins are one visit now.
test('forever/alliance/50-60/05-silithus.guide: final review: Carlin Redpath\'s two hand-ins in one visit, then Caretaker Alen', { skip }, () => {
	const list = goals('forever/alliance/50-60/05-silithus.guide');
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
	const dm = list.find(({ goal }) => goal.t === 'note' && /Dire Maul/.test(goal.text));
	assert.ok(dm, 'the Dire Maul note is in the guide');
	const grind = list.find(({ goal }) => goal.t === 'level' && goal.level >= 60);
	assert.ok(grind && /Terrordale/.test(grind.step.note || ''), 'the solo grind to 60 is in Terrordale');
	assert.match(dm.goal.text, /Terrordale/, 'the note points at that grind');
	assert.doesNotMatch(dm.goal.text, /Shardtooth/, 'not at one the guide does not have');
});

// Final route review before 0.3.5, Alliance 40-60: texts from an older order. Vital Supplies was "for Nethergarde
// Keep, keep it" though Watchmaster Sorigal in Darkshire takes it a few steps later; the Ironforge stop opened with
// the tram ride already taken and said the next guide flies to Thelsamar (this one does); Sigrun Ironhew's dig was two
// steps with the way in on the second; Feralas said you end at the dock with Thalanaar still to come; Felwood said
// to ride out of Astranaar on its second stop; Un'Goro's "Bind and train" binds nowhere.
test('alliance 40-60: final review: travel tips, notes and titles match where the player is', { skip }, () => {
	const texts = ({ step, goal }) => [step.note || '', goal.note || '', goal.t === 'note' ? goal.text : ''].join(' ');
	const stv = goals('forever/alliance/40-50/01-stranglethorn-vale.guide');
	const supplies = stv[at(stv, 'accept 1477', is('accept', 1477))];
	assert.ok(stv.some(({ goal }) => goal.t === 'turnin' && goal.quest === 1477), 'Vital Supplies is handed in on this guide');
	assert.doesNotMatch(supplies.goal.note || '', /Nethergarde/, 'so it is not "for Nethergarde Keep"');
	const roetten = stv[at(stv, 'turnin 1467', is('turnin', 1467))];
	assert.doesNotMatch(roetten.step.note || '', /Tram|next guide/, 'the Ironforge stop starts in Ironforge');
	const sigrun = stv[at(stv, 'turnin 733', is('turnin', 733))];
	assert.equal(sigrun.s, stv[at(stv, 'accept 706', is('accept', 706))].s, 'one stop at Sigrun Ironhew');
	assert.match(sigrun.step.note || '', /Badlands/, 'with the way in');
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

// Final route review before 0.3.5, Alliance 40-60: the 56-58 guide spends about a quarter of its quest goals in
// Un'Goro Crater and Silithus, but its title named only the Plaguelands and Feralas.
test('forever/alliance/50-60/04-western-plaguelands.guide: final review: the title names Un\'Goro Crater and Silithus', { skip }, () => {
	const guide = compiled('forever/alliance/50-60/04-western-plaguelands.guide');
	const zones = new Set(guide.steps.flatMap((step) => step.goals.filter((g) => ['accept', 'turnin'].includes(g.t) && g.map).map((g) => g.map)));
	assert.ok(zones.has(1449) && zones.has(1451), 'it quests in Un\'Goro Crater (1449) and Silithus (1451)');
	assert.match(guide.title, /Un'Goro Crater/);
	assert.match(guide.title, /Silithus/);
});

// Final route review before 0.3.5, Alliance 40-60: after the last Booty Bay stop, Stranglethorn rode back north for the
// Nesingwary hunts (Tethis, King Bangalash) or, solo, for top-ups on the Cold Eye Basilisks, then south again to fly.
// They come before that stop now, after the Crystalvein Mine, with the top-ups lowered by the Booty Bay experience.
test('forever/alliance/40-50/01-stranglethorn-vale.guide: final review: the northern hunts and solo top-ups before the last Booty Bay stop', { skip }, () => {
	const list = goals('forever/alliance/40-50/01-stranglethorn-vale.guide');
	const last = at(list, 'turnin 611', is('turnin', 611));
	const fly = list.findIndex((e, i) => i > last && e.goal.t === 'fly');
	assert.ok(at(list, 'turnin 208', is('turnin', 208)) < last, 'Big Game Hunter before Booty Bay');
	assert.ok(at(list, 'collect 3877', (g) => g.t === 'collect' && g.quest === 197) < last, 'Tethis before Booty Bay');
	const ups = list.filter(({ goal, step }) => goal.t === 'level' && (step.when || []).some((w) => w.k === 'group' && [w.q].flat().some((q) => [193, 197, 208].includes(q))));
	assert.equal(ups.length, 3, 'three solo top-ups for the Nesingwary hunts');
	for (const e of ups) assert.ok(list.indexOf(e) < last, `top-up to ${e.goal.level} before Booty Bay`);
	assert.ok(!list.slice(last, fly).some(({ goal }) => goal.t === 'level'), 'no grind between Booty Bay and the flight');
	const rf = JSON.parse(fs.readFileSync(path.join(__dirname, '..', 'data', 'route-fixes.json'), 'utf8')).deliberate.pairs;
	assert.ok(rf.some((p) => p.a[0] === 'turnin' && p.a[1] === 208 && p.b[0] === 'turnin' && p.b[1] === 611), 'a route-fixes pair keeps it');
});

// Final route review before 0.3.5 (Main's grind policy): every written grind step of Alliance 40-60 ("Level N" top-ups,
// solo fallbacks, "Grind to N") ends its tip with the dungeon a group can run instead, the writer's sentence.
test('alliance 40-60: final review: every written grind step offers a dungeon for its level', { skip }, () => {
	const bands = [['the Uldaman dungeon', 40, 45], ["the Zul'Farrak dungeon", 44, 48], ['the Maraudon dungeon', 46, 52], ['the Sunken Temple dungeon', 50, 54], ['the Blackrock Depths dungeon', 52, 58], ['the Blackrock Spire dungeon (Lower)', 55, 60], ['the Scholomance dungeon', 58, 60], ['the Stratholme dungeon', 58, 60]];
	const want = (lv) => bands.map(([n, lo, hi], i) => ({ n, i, d: Math.abs((lo + hi) / 2 - lv), ok: lo <= lv && lv <= hi })).filter((b) => b.ok).sort((a, b) => a.d - b.d || a.i - b.i).slice(0, 2).map((b) => b.n).join(' or ');
	for (const guide of allGuides().filter((g) => /^forever\/alliance\/(40-50|50-60)\//.test(g))) {
		for (const step of compiled(guide).steps) {
			const m = /^(?:Level ([\d.]+)|Grind to (\d+))$/.exec(step.title);
			if (!m) continue;
			const lv = Math.floor(Number(m[1] || m[2]));
			assert.ok((step.note || '').endsWith(`Or, with a group, run ${want(lv)} instead.`), `${guide} "${step.title}": ${step.note}`);
		}
	}
});

// --- Final route review before 0.3.5, Horde 40-60 (2026-11-08) ---

// Stranglethorn Vale 39-43 starts at Kargath since the 30-40 rework: it flew to Booty Bay, on to Grom'gol for
// Kin'weelay, the Jungle Stalkers and Mok'thardin, and back to Booty Bay. Now Kargath flies to Grom'gol first and on to
// Booty Bay: one flight less. The zone-entry arrow that pointed 1,000 yd past the Bloodsail cove is gone too.
test('forever/horde/40-50/01-stranglethorn-vale.guide: final review: Grom\'gol before Booty Bay on the flight from Kargath', { skip }, () => {
	const list = goals('forever/horde/40-50/01-stranglethorn-vale.guide');
	const cove = at(list, 'turnin 595', is('turnin', 595));
	assert.equal(list.slice(0, cove).filter(({ goal }) => goal.t === 'fly').length, 2, "Kargath to Grom'gol, Grom'gol to Booty Bay");
	const bay = at(list, 'turnin 577', is('turnin', 577));
	assert.ok(at(list, 'turnin 1240', is('turnin', 1240)) < bay && at(list, 'accept 571', is('accept', 571)) < bay, "Grom'gol before the first Booty Bay stop");
	assert.ok(!list.some(({ goal, s }) => s > list[bay].s && s < list[cove].s && goal.t === 'goto'), 'straight from Booty Bay to the Bloodsail cove');
});

// The Swamp of Sorrows part of Stranglethorn's guide told you to "keep going north into Duskwood" after the Duskwood
// stop, and its second Stonard step opened with "You start in Stonard", a leftover of a split guide. One Stonard stop
// for Dar's two quests, the bind and the flight path.
test('forever/horde/40-50/01-stranglethorn-vale.guide: final review: the swamp tips match the way in, one Stonard stop', { skip }, () => {
	const file = 'forever/horde/40-50/01-stranglethorn-vale.guide';
	assert.doesNotMatch(stepTips(file, /accept 1389/).join(' '), /north into Duskwood/);
	assert.doesNotMatch(stepTips(file, /accept 1430/).join(' '), /You start in/);
	const list = goals(file);
	const stonard = list[at(list, 'accept 698', is('accept', 698))].s;
	for (const q of [1430, 1424]) assert.equal(list[at(list, `accept ${q}`, is('accept', q))].s, stonard, `${q} on the one Stonard stop`);
});

// Tips that pointed the wrong way: the Ironjaw Basilisks lie north of Booty Bay on the road back to Grom'gol ("follow
// the road south"); the Altar of Zul is south-west of Valorwind Lake ("on the way back east"); Rogue Vale opens just
// north of Zorbin's dock ("ride west into the middle of Feralas"); Felstone Farm is reached from the Bulwark, where the
// step before ends ("leave the Undercity"). Marvon's step had the same direction twice.
test('Horde 40-60 final review: tips point the way the route goes', { skip }, () => {
	const H = (n) => `forever/horde/${n}.guide`;
	const basilisks = stepTips(H('40-50/06-azshara'), /collect 3911 quest 589/).join(' ');
	assert.match(basilisks, /north out of Booty Bay/);
	assert.doesNotMatch(basilisks, /road south/);
	assert.equal(stepTips(H('40-50/06-azshara'), /turnin 3380/).length, 1, "one tip at Marvon's camp");
	assert.doesNotMatch(stepTips(H('40-50/05-the-hinterlands'), /kill 2925 quest 7828/).join(' '), /back east/);
	assert.doesNotMatch(stepTips(H('40-50/03-feralas'), /kill 8612 quest 3520/).join(' '), /Ride west/);
	assert.doesNotMatch(stepTips(H('50-60/01-un-goro-crater'), /accept 5021/).join(' '), /Leave the Undercity/);
});

// Felwood & Western Plaguelands: the top-up to 52.63 ground on Northridge's Scarlet Mages, then walked on to Kirsta
// Deepshadow on the hill above for Unfinished Business, which wants those Scarlets. Kirsta first: the grind counts.
test('forever/horde/50-60/02-felwood.guide: final review: Kirsta before the Northridge top-up', { skip }, () => {
	const list = goals('forever/horde/50-60/02-felwood.guide');
	const top = list.findIndex(({ goal }) => goal.t === 'level' && goal.level === 52);
	assert.ok(top >= 0, 'the top-up is in the guide');
	assert.ok(at(list, 'accept 6004', is('accept', 6004)) < top, 'Unfinished Business before the Scarlet grind');
});

// Winterspring ended in Orgrimmar taking the Wool, Silk and Mageweave donations, and the Azshara guide landed in
// Orgrimmar again between the Crossroads and Valormok just to hand them in, from the Valley of Spirits to the Valley of
// Honor. They are handed in on the stop that takes them, as the Thunder Bluff ones are; the Runecloth ones are taken
// there and still handed in at the end of the route.
test('Horde 55-56 final review: the Orgrimmar cloth donations are handed in where they are taken', { skip }, () => {
	const ws = goals('forever/horde/50-60/03-winterspring.guide');
	for (const q of [7833, 7834, 7835, 7826, 7827, 7831]) {
		assert.equal(ws[at(ws, `turnin ${q}`, is('turnin', q))].s, ws[at(ws, `accept ${q}`, is('accept', q))].s, `${q} on the stop that takes it`);
	}
	for (const q of [7836, 7824]) at(ws, `accept ${q}`, is('accept', q));
	const az = goals('forever/horde/50-60/04-azshara.guide');
	assert.ok(!az.some(({ goal }) => [7833, 7834, 7835, 7836, 7826, 7827, 7831, 7824].includes(goal.quest)), 'no donation stop in the Azshara guide');
	const between = az.slice(at(az, 'turnin 91904', is('turnin', 91904)) + 1, at(az, 'turnin 3562', is('turnin', 3562)));
	assert.deepEqual(between.filter(({ goal }) => goal.t === 'fly').map(({ goal }) => goal.location), ['Valormok'], 'one flight, the Crossroads to Valormok');
	assert.ok(!between.some(({ goal }) => goal.map === 1454), 'no Orgrimmar stop between the crates and Valormok');
});

// Silithus: Dearest Natalia comes from Commander Mar'alith (the top-up named Bor Wildmane), its two dwarves are
// questioned, not killed (the step had only two kill goals and no tip), and two notes said to skip what the guide had
// just taken: Dearest Natalia itself and Dithers' Skeletal Fragments.
test('forever/horde/50-60/06-silithus.guide: final review: Dearest Natalia from Mar\'alith, questioned not killed, no stale skip notes', { skip }, () => {
	const file = 'forever/horde/50-60/06-silithus.guide';
	const rec = JSON.parse(fs.readFileSync(path.join(__dirname, '..', 'data', 'guide-fixes.json'), 'utf8')).fixes.find((f) => f.at.quest === 8304 && f.tip && f.faction === 'Horde');
	assert.ok(rec, 'the tip is a record');
	assert.deepEqual(stepTips(file, /kill 15171 quest 8304/), [rec.tip]);
	assert.match(rec.tip, /Question them/);
	const top = stepTips(file, /^\s+level 58\b/).join(' ');
	assert.match(top, /Mar'alith/);
	assert.doesNotMatch(top, /Bor Wildmane/);
	const text = fs.readFileSync(path.join(OFFICIAL_DIR, file), 'utf8');
	assert.doesNotMatch(text, /Dearest Natalia needs level 58 and leads/);
	assert.doesNotMatch(text, /Skeletal Fragments \(Scholomance\)\. Skip it/);
	const list = goals(file);
	at(list, 'turnin 964', is('turnin', 964));
});

// Felwood, Moonglade & Winterspring: two Donova Snowden steps in a row, the way there on the second.
test('forever/horde/50-60/07-felwood.guide: final review: one Donova stop with the way there', { skip }, () => {
	const file = 'forever/horde/50-60/07-felwood.guide';
	const list = goals(file);
	const donova = list[at(list, 'turnin 980', is('turnin', 980))].s;
	assert.equal(list[at(list, 'accept 5087', is('accept', 5087))].s, donova, 'Toxic Horrors on the same stop');
	assert.match(stepTips(file, /turnin 980/).join(' '), /Timbermaw tunnel/);
});

// The Hinterlands: Separation Anxiety, Kidnapped Elder Torntusk! and Dark Vessels are group quests in Forever's data,
// and every Vilebranch troll in Jintha'Alor is elite; the guide sent a solo player at about 48 up through them. They
// are taken, done and handed in only with a group, and the top-up after Revantusk covers them when skipped.
test('forever/horde/40-50/05-the-hinterlands.guide: final review: Jintha\'Alor only with a group', { skip }, () => {
	const list = goals('forever/horde/40-50/05-the-hinterlands.guide');
	for (const q of [7849, 7845, 7850]) {
		const steps = list.filter(({ goal }) => goal.quest === q);
		assert.ok(steps.length >= 2, `${q} is in the guide`);
		for (const { step, goal } of steps) assert.ok((step.when || []).some((w) => w.k === 'group' && w.q === 7849), `${goal.t} ${q} is on a 'when group 7849' step`);
	}
	const top = list.find(({ goal }) => goal.t === 'level' && goal.level === 49);
	assert.ok(top && !(top.step.when || []).some((w) => w.k === 'group'), 'the top-up is for everyone below its level');
	const groups = JSON.parse(fs.readFileSync(path.join(__dirname, '..', 'data', 'route-fixes.json'), 'utf8')).deliberate.group;
	for (const q of [7849, 7845, 7850]) assert.ok(groups.some((g) => g.q === q && g.size >= 2 && g.size <= 4), `${q} is a group quest record`);
});

// --- Final route review follow-ups, Horde 40-60 (2026-11-08) ---

// Feralas & Tanaris: the four Steamwheedle Port quests are finished at Lost Rigger Cove on the first Tanaris visit but
// waited for the 45-47 guide, whose flight from Brackenwall went to Gadgetzan, rode to the port and back, and flew on
// to Camp Mojache for them alone. They are handed in on the way back to Gadgetzan, Yeh'kinya's Screecher Spirits taken
// there; the 45-47 guide flies Brackenwall to Camp Mojache.
test('Horde 43-47 follow-up: the Steamwheedle Port hand-ins on the first Tanaris visit, no Tanaris detour from Brackenwall', { skip }, () => {
	const fer = goals('forever/horde/40-50/02-feralas.guide');
	const cove = at(fer, 'collect 9246 quest 2875', (g) => g.t === 'collect' && g.item === 9246);
	const gadgetzan = at(fer, 'turnin 1691', is('turnin', 1691));
	for (const [t, q] of [['turnin', 8365], ['turnin', 2873], ['turnin', 2875], ['turnin', 8366], ['accept', 3520]]) {
		const i = at(fer, `${t} ${q}`, is(t, q));
		assert.ok(i > cove && i < gadgetzan, `${t} ${q} between Lost Rigger Cove and Gadgetzan`);
	}
	const sw = goals('forever/horde/40-50/03-feralas.guide');
	assert.ok(!sw.some(({ goal }) => goal.map === 1446), 'no Tanaris stop in the 45-47 guide');
	const fly = sw.filter(({ goal }) => goal.t === 'fly').map(({ goal }) => goal.location);
	assert.ok(fly.includes('Camp Mojache') && !fly.includes('Gadgetzan'), 'Brackenwall flies to Camp Mojache');
	const pairs = JSON.parse(fs.readFileSync(path.join(__dirname, '..', 'data', 'route-fixes.json'), 'utf8')).overrides.pairs;
	assert.ok(!pairs.some((p) => p.b[0] === 'accept' && p.b[1] === 3520), 'the swamp-stay pairs anchor on the screecher work, not the accept');
});

// Swamp of Sorrows, first stay: the Fallow Sanctuary, the Harborage in the far west, back east to Galen's strongbox,
// then the far south-east coast for Lack of Surplus alone. Now one pass: the strongbox on the way back west, the
// Harborage last; Tok'Kar takes the flanks on the second stay, which rides to Misty Reed Post anyway.
test('Horde Swamp of Sorrows follow-up: the first stay is one pass, Tok\'Kar on the second', { skip }, () => {
	const stv = goals('forever/horde/40-50/01-stranglethorn-vale.guide');
	assert.ok(at(stv, 'turnin 1393', is('turnin', 1393)) < at(stv, 'turnin 1389', is('turnin', 1389)), 'the strongbox before the Harborage');
	assert.ok(!stv.some(({ goal }) => is('turnin', 698)(goal) || is('accept', 699)(goal)), 'no Misty Reed Post in the first stay');
	assert.equal(stv[stv.length - 1].goal.quest, 1389, 'the guide ends at the Harborage');
	const sw = goals('forever/horde/40-50/03-feralas.guide');
	const pool = at(sw, 'collect 6175 quest 1424', (g) => g.t === 'collect' && g.item === 6175);
	const tok = at(sw, 'turnin 698', is('turnin', 698));
	assert.ok(pool < tok && tok < at(sw, 'collect 6168 quest 699', (g) => g.t === 'collect' && g.item === 6168), 'the pool, Tok\'Kar, then the snappers');
});

// Main's grind policy (2026-11-08): every written grind step ("Level N" top-ups and solo fallbacks) ends its tip with
// the dungeons whose band holds N ("Or, with a group, run the <Name> dungeon instead."), the sentence the forge writer writes from the next build. Horde 40-60 by hand.
test('Horde 40-60: every grind step offers the dungeons at its level', { skip }, () => {
	const files = fs.readdirSync(path.join(OFFICIAL_DIR, 'forever/horde/40-50')).map((f) => `forever/horde/40-50/${f}`)
		.concat(fs.readdirSync(path.join(OFFICIAL_DIR, 'forever/horde/50-60')).map((f) => `forever/horde/50-60/${f}`));
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
	assert.ok(n >= 19, `the grind steps are found (${n})`);
});

test('Image of Archmage Modera is met at the Kirin Tor camp in Silverpine Forest, never by the Dalaran sewer entrance in Alterac (#1305)', { skip }, () => {
	// Players' windows with her are all at Silverpine 68.57-68.66,45.09-45.25; the merged data also had a point in
	// Alterac Mountains 14.3,59.57 (about 186 yd east), which the Arathi hand-in of An Alarming Request (92432) used.
	for (const [file, pred] of [
		['forever/alliance/30-40/05-arathi-highlands.guide', is('turnin', 92432)],
		['forever/reputation/kirin-tor.guide', is('turnin', 92432)],
		['forever/reputation/kirin-tor.guide', is('accept', 92458)],
	]) {
		const list = goals(file);
		const { goal } = list[at(list, `${file}: ${pred.toString()}`, pred)];
		assert.equal(goal.npc, 269127, `${file}: Image of Archmage Modera`);
		assert.equal(goal.map, 1421, `${file} ${goal.t} ${goal.quest}: Silverpine Forest, not Alterac Mountains`);
		assert.ok(Math.abs(goal.x - 68.6) < 0.5 && Math.abs(goal.y - 45.2) < 0.5, `${file} ${goal.t} ${goal.quest}: at the camp (${goal.x},${goal.y})`);
	}
});

// --- Level sweep (2026-11-08, #1320's class of report: a guide asks for a quest the character is too low to take).
// The calibrated level model, run at every accept of every start, had these taken 0.05-0.6 below the quest's
// minimum level; players' recordings had 8 Scourge Paladins at Aramis Hammerhand's Coming to Terms at levels 2-3
// (minimum 4). Each is now taken where every start is at its level, or behind a `level` gate for the players it is
// for (guide-fixes `only`); Tanaris (Horde 40-50) and the Barrens (Horde 15-21) start where every start enters them.
test('Level sweep: accepts below their minimum level are moved or gated', { skip }, () => {
	const step = (list, t, q) => list[at(list, `${t} ${q}`, is(t, q))].s;
	// A level goal of at least `n` for `cls` (none other) before the accept, in its step.
	const gated = (file, q, n, cls) => {
		const list = goals(file);
		const i = at(list, `${file}: accept ${q}`, is('accept', q));
		const gate = list.slice(0, i).reverse().find(({ goal, s }) => s === list[i].s && goal.t === 'level');
		assert.ok(gate && gate.goal.level >= n, `${file}: a level ${n} gate before accept ${q}`);
		if (cls) assert.match(JSON.stringify(gate.goal.only), new RegExp(cls, 'i'), `${file}: the gate before ${q} is for ${cls}`);
		else assert.equal(gate.goal.only, undefined, `${file}: the gate before ${q} is for everyone`);
	};
	const stv = goals('forever/alliance/40-50/01-stranglethorn-vale.guide');
	assert.equal(step(stv, 'accept', 348), step(stv, 'turnin', 587), 'Stranglethorn Fever on the Booty Bay stop after the Wild Shore');
	assert.equal(step(stv, 'accept', 2872), step(stv, 'turnin', 617), "Stoley's Debt on the Booty Bay stop after the naga");
	const ungoro = goals('forever/alliance/40-50/07-un-goro-crater.guide');
	const gate = ungoro.findIndex(({ goal }) => goal.t === 'level' && goal.level >= 50 && /priest/i.test(JSON.stringify(goal.only)));
	assert.ok(gate >= 0 && gate < at(ungoro, 'accept 8254', is('accept', 8254)), "Priests reach 50 in Un'Goro before Cenarion Aid");
	gated('forever/alliance/dwarf/01-dun-morogh.guide', 5637, 10, 'Priest');
	gated('forever/alliance/gnome/01-dun-morogh.guide', 94824, 10, 'Priest');
	for (const side of ['alliance', 'horde']) {
		gated(`forever/${side}/skyborne/01-zephras-isle.guide`, 94003, 10, 'Warrior');
		gated(`forever/${side}/skyborne/01-zephras-isle.guide`, 94978, 10, 'Hunter');
	}
	gated('forever/horde/skyborne/01-zephras-isle.guide', 97243, 10, 'Shaman');
	gated('forever/horde/tauren/01-mulgore.guide', 264, 12);
	const tirisfal = goals('forever/horde/undead/01-tirisfal-glades.guide');
	assert.equal(step(tirisfal, 'accept', 91208), step(tirisfal, 'turnin', 3902), 'Coming to Terms after Scavenging Deathknell');
	assert.ok(step(tirisfal, 'accept', 91209) >= step(tirisfal, 'turnin', 91208), 'Continue Your Training once Coming to Terms is handed in');
	const all = headers();
	assert.ok(all['forever/horde/40-50/04-tanaris'].min <= 46, 'Tanaris starts at 46: every start enters it at 45.96');
	assert.ok(all['forever/horde/02-the-barrens'].min <= 14, 'the Barrens start at 14: Orc and Troll Rogues, Mages and Priests enter them at 13.99');
});

// FlyHifiGuy's report (#1327): on Trial of the Lake (28/29, a 30-minute quest timer) a teleport reset the trial, and the
// trial's step opened with "Cast Teleport: Moonglade" for the whole step. The arrow plans no Hearthstone or class
// teleport while a quest timer runs (Nav/Travel.lua; forge-addontest travel-transit.rs). The guides: every trial step
// says no teleport or Hearthstone until Tajarri has it (the leveling guides' tips are guide-fixes records, so a build
// writes them again, and no longer say to cast the teleport: the step before does), and no guide puts a `hearth` goal
// between a timed quest's accept and its hand-in.
test("FlyHifiGuy's report (#1327): no teleport or Hearthstone while Trial of the Lake runs, no hearth goal inside a timed quest", { skip: skip || needs('mechanics.json') }, () => {
	const fixes = JSON.parse(fs.readFileSync(path.join(__dirname, '..', 'data', 'guide-fixes.json'), 'utf8')).fixes;
	for (const [file, q, record] of [
		['forever/alliance/03-darkshore.guide', 29, 'upstairs-dendrite-starblaze-turnin-26'],
		['forever/horde/02-the-barrens.guide', 28, 'upstairs-dendrite-starblaze-turnin-27'],
		['forever/class/druid/aquatic-form.guide', 29, null],
		['forever/class/druid/aquatic-form.guide', 28, null],
	]) {
		const tips = stepTips(file, new RegExp(`^\\s+accept ${q}\\b`));
		assert.match(tips.join(' '), /no teleport or Hearthstone until Tajarri has it/, `${file}: quest ${q}'s step`);
		if (!record) continue;
		const rec = fixes.find((f) => f.id === record);
		assert.deepEqual(tips, [rec.tip], `${file}: the step's tip is the record's`);
		assert.doesNotMatch(rec.tip, /Cast Teleport/, `${file}: the step before casts it`);
	}
	const read = (f) => JSON.parse(fs.readFileSync(path.join(DATA, f), 'utf8'));
	const quests = read('quests.json');
	const timed = new Set((Array.isArray(quests) ? quests : Object.values(quests)).filter((q) => q.limit > 0).map((q) => q.id));
	for (const [id, m] of Object.entries(read('mechanics.json').quests || {})) {
		if ((m.params || []).some((p) => p.kind === 'timed' && p.what === 'quest timer' && p.seconds > 0)) timed.add(Number(id));
	}
	assert.ok(timed.has(28) && timed.has(29), 'Trial of the Lake is timed in the data');
	let windows = 0;
	for (const file of allGuides()) {
		const open = new Map(); // timed quest -> line of its accept
		fs.readFileSync(path.join(OFFICIAL_DIR, file), 'utf8').split('\n').forEach((line, i) => {
			const m = line.match(/^\s+(accept|turnin|complete|hearth)\b\s*(\d+)?/);
			if (!m) return;
			const q = Number(m[2]);
			if (m[1] === 'accept' && timed.has(q)) {
				open.set(q, i + 1);
				windows++;
			} else if ((m[1] === 'turnin' || m[1] === 'complete') && open.has(q)) {
				open.delete(q);
			} else if (m[1] === 'hearth') {
				assert.equal(open.size, 0, `${file}:${i + 1}: a hearth while timed quest ${[...open.keys()].join(', ')} runs (accepted at line ${[...open.values()].join(', ')})`);
			}
		});
	}
	assert.ok(windows >= 30, `the timed accepts are found (${windows})`);
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
	assert.ok(at(list, 'accept 511 (the Syndicate camp)', is('accept', 511)) < use, 'delivered after the Syndicate camp');
	const g = list[use].goal;
	assert.ok(g.map === 1424 && Math.abs(g.x - 29.7) < 0.5 && Math.abs(g.y - 41.7) < 0.5, `at the Hillsbrad council (${g.map} ${g.x},${g.y})`);
	for (const i of [take, use, hand]) assert.ok(list[i].goal.optional, `${list[i].goal.t} 98059 stays optional`);
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

// --- Windshear Mine (Emil, #1370): Gerenzo's Orders is Piznik's five-minute defence at the bottom of the mine,
// with kobold waves (19-23) and a fail when he dies. Players lost it alone at 23 and 25; both routes reach it at
// 20-23. It is asked as a group quest in both guides, with what the defence is, Ziz's hand-in of the follow-up
// with it; Super Reaper 6000 (1093) and the crag's quests stay for everyone, and the Alliance arrow into
// Stonetalon no longer leads into the mine.
test("Emil's report (#1370): Gerenzo's Orders is asked as a group quest; Windshear Crag's other quests are not", { skip }, () => {
	for (const guide of [ASHENVALE, BARRENS]) {
		const list = goals(guide);
		const gerenzo = list.filter(({ goal }) => goal.quest === 1090 || goal.quest === 1092);
		assert.deepEqual(gerenzo.map(({ goal }) => `${goal.t} ${goal.quest}`).sort(), ['accept 1090', 'accept 1092', 'complete 1090', 'turnin 1090', 'turnin 1092'], `${guide}: Gerenzo's Orders' goals`);
		for (const { step, goal } of gerenzo) {
			assert.ok((step.when || []).some((p) => p.k === 'group' && [p.q].flat().includes(1090) && !p.neg), `${guide}: ${goal.t} ${goal.quest} is under when group 1090`);
			if (goal.quest === 1090) assert.equal(step.title, 'Piznik', `${guide}: ${goal.t} 1090 on Piznik's step`);
		}
		assert.match(stepTips(guide, /^step Piznik$/).join(' '), /grouping up is encouraged[\s\S]*If he dies, the quest fails/, `${guide}: the step says what the defence is`);
		const reaper = list.filter(({ goal }) => goal.quest === 1093);
		assert.ok(reaper.length >= 2, `${guide}: Super Reaper 6000 is still taken`);
		for (const { step, goal } of reaper) assert.ok(!(step.when || []).some((p) => p.k === 'group'), `${guide}: ${goal.t} 1093 is for everyone`);
	}
	const ally = goals(ASHENVALE);
	const into = ally[at(ally, 'goto Windshear Crag', ({ t, text }) => t === 'goto' && /Windshear Crag/.test(text || ''))].goal;
	assert.ok(Math.hypot(into.x - 71.9, into.y - 60.0) > 10, `the Stonetalon arrow (${into.x},${into.y}) is not Piznik's spot in the mine`);
});

// #1357 (MrBackus, Skyborne Shaman 30): Hillsbrad & Arathi's Orgrimmar training step came up while he
// stood in the Barrens by Ratchet, and the Engine took the Shaman trainer nearest him, Shikrik in the
// Valley of Trials. The Undercity training step of the Arathi guide comes up at Orgrimmar's zeppelin tower
// the same way. A `train class` goal carries its step's zone, whose trainers the Engine ranks first
// wherever the player stands: each of these steps names its town, and the town has a trainer of every
// class the step trains.
test('#1357: a training step carries its town, and the town has a trainer of each class it trains', { skip }, () => {
	const cases = [
		['forever/horde/30-40/01-hillsbrad-foothills.guide', /^Train$/, 1454],
		['forever/horde/30-40/05-arathi-highlands.guide', /^(Undercity|\{zone:1458\}) trainers$/, 1458],
		['forever/alliance/02-westfall.guide', /^Shaman training$/, 1455],
		['forever/alliance/50-60/01-burning-steppes.guide', /^Druid training$/, 1457],
	];
	for (const [guide, title, town] of cases) {
		const list = goals(guide).filter(({ step, goal }) => title.test(step.title) && goal.t === 'train' && goal.class);
		assert.ok(list.length > 0, `${guide}: the "${title}" step trains`);
		for (const { step, goal } of list) {
			assert.equal(goal.zone, town, `${guide}, "${title}": the step's town`);
			const classes = (goal.only && goal.only.classes) || (step.only && step.only.classes) || [];
			for (const cls of classes) {
				const side = guide.includes('/horde/') ? 'H' : 'A';
				const there = goal.candidates.filter((c) => c.map === town && (c.faction === side || c.faction === 'AH') && (c.classes || []).includes(cls.toUpperCase()));
				assert.ok(there.length > 0, `${guide}, "${title}": a ${cls} trainer in the town`);
			}
		}
	}
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
	data = data || loadData(DATA);
	for (const q of Object.values(data.quests)) {
		for (const o of q.objectives || []) if (o.type === 'item' && o.id) needed.set(o.id, [...(needed.get(o.id) || []), q.id]);
		for (const i of q.requiredItems || []) needed.set(i, [...(needed.get(i) || []), q.id]);
	}
	const startItems = new Set(Object.values(data.quests).flatMap((q) => (q.start && q.start.item) || []));
	const classOnly = ({ step, goal }) => [step.only, goal.only].some((o) => o && o.classes && o.classes.length);
	let checked = 0;
	for (const file of allGuides().filter((f) => /^forever\/(alliance|horde)\//.test(f))) {
		const list = goals(file);
		list.forEach(({ step, goal }, i) => {
			if (!['collect', 'use'].includes(goal.t) || goal.quest || !classOnly(list[i])) return;
			const item = data.items[goal.item];
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
	const fixes = JSON.parse(fs.readFileSync(path.join(__dirname, '..', 'data', 'guide-fixes.json'), 'utf8')).fixes;
	assert.deepEqual(stepTips('forever/horde/06-hillsbrad-foothills.guide', /^\s+turnin 30\b/), [fixes.find((f) => f.id === 'upstairs-dendrite-starblaze-turnin-30').tip], 'the hand-in step carries the record tip');
	assert.deepEqual(stepTips('forever/horde/02-the-barrens.guide', /^\s+turnin 6129\b/), [fixes.find((f) => f.id === 'upstairs-dendrite-starblaze-turnin-6129').tip], "the Barrens' Moonglade step carries its record tip");
});

// --- Horde 30-40 audit (2026-11-09, AuditHorde3040): Lydon's Shindigger keg is in Dun Garok's elite cellar, so Elixir
// of Agony's second part is a group choice and its steps lead players who took it (a gated step whose goals were all
// optional was done at once); the Shaman's Water Sapta is used at the brazier; Desolace's Demon Pick, Gem of the
// Serpent and clams are lines of their own; Portals of the Legion uses the Hand of Iruxos, not a "Rod of Banishing".
test('Horde 30-40 audit: Desolace\'s quest items are used where the game needs them', { skip }, () => {
	const list = goals('forever/horde/30-40/02-thousand-needles.guide');
	for (const [item, quest, what] of [[14523, 5381, 'the Demon Pick'], [15766, 6027, 'the Gem of the Serpent'], [15874, 6142, 'the Soft-shelled Clams']]) {
		const use = at(list, `use ${item}`, (g) => g.t === 'use' && g.item === item);
		assert.ok(use < at(list, `turnin ${quest}`, is('turnin', quest)), `${what} before the hand-in`);
	}
	const pick = list.find(({ goal }) => goal.t === 'use' && goal.item === 14523).goal;
	assert.ok(Math.hypot(pick.x - 54.95, pick.y - 26.66) < 1, 'the Demon Pick goes to the Hand of Iruxos Crystal');
	const [portals] = stepTips('forever/horde/30-40/04-dustwallow-marsh.guide', /^\s+complete 5581\b/);
	assert.doesNotMatch(portals, /Rod of Banishing/);
	assert.match(portals, /Hand of Iruxos/);
});
// Gol'dir (503): the data asked to kill Gol'dir, who takes the hand-in; the game's record and every recorded accept list
// the key and "Find where Gol'dir is being held" only (correction 503).
test('Horde 30-40 audit: Gol\'dir is found, not killed', { skip }, () => {
	const list = goals('forever/horde/30-40/05-arathi-highlands.guide');
	assert.ok(!list.some(({ goal }) => goal.t === 'kill' && goal.npc === 2316), 'no kill of Gol\'dir');
	const find = at(list, 'complete 503', is('complete', 503));
	assert.ok(find < at(list, 'turnin 503', is('turnin', 503)));
});
