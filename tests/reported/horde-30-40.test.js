'use strict';
// Player-reported guide fixes: the Horde 30-40 guides.
// tests/reported/helpers.js says what the cases check and where a new one goes.

const { test } = require('node:test');
const assert = require('node:assert/strict');
const fs = require('node:fs');
const path = require('node:path');
const {
	at, compiled, engineRun, forClass, goals, H3040, HILLSBRAD_3040, hillsbradChains, is, loadCorrections, OFFICIAL_DIR,
	refData, ROOT, skip, stepTips, STRANGLETHORN_HORDE, TAUREN_DRUID_29, yards,
} = require('./helpers');

// Kolbi's report (#1776, Skyborne Druid 31, 0.3.6): "Dangerous! makes you split 4 kills between a few steps". Since the
// level tidy (2026-11-15) Dangerous! (567) is taken from the Tarren Mill poster in this guide: Farmer Kalaba and Citizen
// Wilkes come with Battle of Hillsbrad 529 at the smithy, the clerk and the miner with this guide's town hall (532) and
// Azurelode Mine (539) visits, as players' recordings show. A character who carried it from an older 22-25 guide with
// 529 already handed in keeps the clerk and the miner open.
function dangerousKills(before) {
	return engineRun(HILLSBRAD_3040, TAUREN_DRUID_29, {
		before,
		script: `local out = {}
			for i, step in ipairs(E.GetGuide().steps) do
				for k, g in ipairs(step.goals) do
					if g.t == "kill" and g.quest == 567 then
						local key = tostring(g.oi)
						out[key] = (out[key] and out[key] .. "," or "") .. E.GetStepView(i).goals[k].status
					end
				end
			end
			emit(out)`,
	});
}

// Horde 30-40 audit (0.4.0): the hearthstone stays bound at Freewind Post through Hillsbrad (07-ashenvale's bind), so the
// next guide's way from the Undercity to Freewind goes by Hearthstone; the travel sweep measured 4.8 minutes saved per
// branch against the Tarren Mill bind.
test('forever/horde/30-40/01-hillsbrad-foothills.guide: no bind in Hillsbrad', { skip }, () => {
	const list = goals('forever/horde/30-40/01-hillsbrad-foothills.guide');
	assert.deepEqual(list.filter(({ goal }) => goal.t === 'sethome').map(({ goal }) => goal.location), [], 'Freewind Post stays bound');
});

// Horde 21-40 audit (0.4.0) and level tidy (2026-11-15): Elixir of Agony's first two parts (509, 513) come on the 30-31
// Hillsbrad visit (the Mudsnout blossoms, then Faranell on the Undercity stop at its end); 515 needs a Lesser Troll's
// Blood Elixir no vendor sells and could only start after Hillsbrad, so it is left out (route-fixes skip 515).
test('forever/horde/30-40/01-hillsbrad-foothills.guide: Elixir of Agony is offered in the Undercity only with the elixir in the bags', { skip }, () => {
	const list = goals('forever/horde/30-40/01-hillsbrad-foothills.guide');
	assert.equal(list.filter(({ goal }) => goal.quest === 515).length, 0, 'no 515: it would start after Hillsbrad');
	const blossoms = at(list, 'the Mudsnout blossoms', (g) => g.t === 'collect' && g.quest === 509);
	const fly = list.findIndex(({ step }) => step.title === 'Fly to Undercity');
	const faranell = at(list, 'turnin 513 (Faranell)', is('turnin', 513));
	assert.ok(blossoms < fly && fly < faranell, 'the blossoms in Hillsbrad, Faranell on the Undercity stop at the end');
});

// Horde 30-40 audit (0.4.0): the Badlands bound the hearthstone at Kargath, and nothing hearths back to it: the guide
// ends at Kargath, and Stranglethorn Vale & Swamp of Sorrows binds at Grom'gol before its first hearth (the addon's
// travel planner over every Horde branch never hearths to Kargath).
test('forever/horde/30-40/06-badlands.guide: no bind at Kargath', { skip }, () => {
	const list = goals('forever/horde/30-40/06-badlands.guide');
	assert.deepEqual(list.filter(({ goal }) => goal.t === 'sethome').map(({ goal }) => goal.location), [], 'no sethome in the Badlands');
	at(list, 'getfp Kargath', (g) => g.t === 'getfp');
});

// Horde 30-40/40-50 audit (0.4.0): The Green Hills of Stranglethorn's chapters (338-342) were accepted at Nesingwary's
// camp at 35 and turned in only on the next Stranglethorn visit at 40, five quest log slots for a 1% drop; the pages
// drop without the quests, so the chapters are accepted and turned in together on that visit. Goblin Sponsorship
// (1183, Revilgaz -> Pozzik) is taken on 40-50's first Booty Bay stop, closer to Pozzik.
test('forever/horde/30-40/03-stranglethorn-vale.guide: no Green Hills chapters or Goblin Sponsorship carried to 40', { skip }, () => {
	const list = goals('forever/horde/30-40/03-stranglethorn-vale.guide');
	assert.deepEqual(list.filter(({ goal }) => goal.t === 'accept' && [338, 339, 340, 341, 342, 1183].includes(goal.quest)).map(({ goal }) => goal.quest), [], 'none accepted at 35');
	assert.deepEqual(list.filter(({ goal }) => goal.t === 'collect' && [338, 339, 340, 341, 342].includes(goal.quest)).length, 0, 'no page goals for chapters not in the log');
	at(list, 'turnin 583 (Welcome to the Jungle, which the chapters need)', is('turnin', 583));
	// Since the Horde 0.4.0 audit (round 2) Goblin Sponsorship part 4 (1182) is left out of the solo route: Foreman
	// Cozzle (38) and the Venture Co. Agents (39) keep the key four and five levels over players here.
	assert.ok(!list.some(({ goal }) => [1182, 1183].includes(goal.quest)), 'no Goblin Sponsorship part 4 or 5 here');
});

// #1976 (TriageNav) and the Horde 30-40/40-50 audit (0.4.0): Gadgetzan's flight path is learned on the way back
// from the Mirage Raceway (the walk to Gadgetzan and the flight to Freewind Post beat the walk west across the flats:
// the addon's travel planner takes that way itself), so the 40-50 guide can fly to Gadgetzan. Since the level tidy
// (2026-11-15) that is the first raceway visit's hand-ins (1104, 1105); the flats' south comes after Desolace.
test('forever/horde/30-40/02-thousand-needles.guide: Gadgetzan\'s flight path on the way back from the raceway (#1976)', { skip }, () => {
	const list = goals('forever/horde/30-40/02-thousand-needles.guide');
	const raceway = at(list, 'turnin 1105 (the raceway)', is('turnin', 1105));
	const fp = at(list, 'getfp Gadgetzan', (g) => g.t === 'getfp' && /Gadgetzan/.test(JSON.stringify(g)));
	const family = at(list, 'accept 5361 (Freewind Post)', is('accept', 5361));
	assert.ok(raceway < fp && fp < family, 'after the raceway, before Freewind Post');
});

// Horde 30-40 audit (0.4.0): Battle of Hillsbrad (541) and Humbert's Sword (547) are elite group quests at Dun Garok,
// offered at Tarren Mill, and players took and dropped them (players' recordings: 547 abandoned by 5 people, 541 by
// 3): the hand-in that opens 541 says they want a group.
test('forever/horde/30-40/01-hillsbrad-foothills.guide: the Tarren Mill hand-in says Dun Garok is group work', { skip }, () => {
	const list = goals('forever/horde/30-40/01-hillsbrad-foothills.guide');
	const { goal } = list[at(list, 'turnin 539', is('turnin', 539))];
	assert.match(goal.note || '', /Dun Garok/);
	assert.match(goal.note || '', /group/);
});

// #2025 (unclear breadcrumbs, PrereqCrumbs040): the Badlands take Report to Helgrum (1420) from Neeka Bloodscar without
// Neeka Bloodscar (1418), which the data listed as both its prerequisite and its breadcrumb. Players' recordings: Neeka
// offered 1420 to 7 people, none of whom ever had 1418 (two recorded from level 1): a breadcrumb only.
test('#2025: Report to Helgrum has no prerequisite; the Badlands take it at Kargath', { skip }, () => {
	const fix = loadCorrections().quests['1420'];
	assert.deepEqual(fix && fix.set.pre, [], 'the correction drops 1418 as a prerequisite');
	const list = goals('forever/horde/30-40/06-badlands.guide');
	assert.equal(list.filter(({ goal }) => goal.quest === 1418).length, 0, 'no trip for Neeka Bloodscar (1418)');
	at(list, 'accept 1420 at Kargath', is('accept', 1420));
});

// Danger at the spot (#1575, release gate #2042), Horde 30-40 audit (0.4.0): Dustwallow & Desolace's second Desolace
// visit pointed the Valley of Spears' totems and ears at the Magram's village (Necromancers 42-43) and the ghost magnet
// at Desolace 63.5,91.6, now Shen'dralas, among Magram Necrokhans and Corpsefeeders (45, elite; players' recordings: 8
// deaths there). The totems' arrow now points at the Maraudine camps in the Valley of Spears (the ears keep touring every
// tribe's camps, #1616), and the crate at the bone fields' eastern side, where players used it.
test('forever/horde/30-40/04-dustwallow-marsh.guide: the Valley of Spears and the Valley of Bones point away from the high Magram', { skip }, () => {
	const list = goals('forever/horde/30-40/04-dustwallow-marsh.guide');
	for (const [what, pred] of [['totems', (g) => g.t === 'collect' && g.quest === 93225]]) {
		const { goal } = list[at(list, what, pred)];
		assert.ok(goal.map === 1443 && Math.hypot(goal.x - 33.0, goal.y - 54.0) < 1, `${what}: the Valley of Spears' eastern camps (got ${goal.map} ${goal.x},${goal.y})`);
	}
	for (const [what, pred] of [['crate', (g) => g.t === 'use' && g.quest === 6134], ['ghost-o-plasm', (g) => g.t === 'collect' && g.quest === 6134]]) {
		const { goal } = list[at(list, what, pred)];
		assert.ok(goal.map === 1443 && Math.hypot(goal.x - 64.4, goal.y - 91.7) < 1, `${what}: the bone fields' eastern side (got ${goal.map} ${goal.x},${goal.y})`);
	}
});

// Phenyx on Discord (#2357, level 37.5): "This quest is too hard alone" (Ghost-o-plasm Round Up, 6134). The Crate of
// Ghost Magnets draws the Magrami Spectres (38-39) in numbers, a few yards from the Magram Necrokhans and Corpsefeeders
// (45, elite). Players' recordings put the 25th percentile at the crate at 38.1, so the spectres are at most one level
// over: the quest stays solo, comes last on the Desolace visit (after Thunder Axe Fortress and Mannoroc Coven, whose
// Valley of Bones lies just south-east), and the steps say the spectres come in numbers and where the elites walk.
// The Valley of Spears' totems (93225) say where Khan Hratha and the Rock Worms (elite) stand.
test('forever/horde/30-40/04-dustwallow-marsh.guide: Phenyx (#2357): the ghost-o-plasm comes after Mannoroc Coven, with the elites named', { skip }, () => {
	const list = goals('forever/horde/30-40/04-dustwallow-marsh.guide');
	const take = list[at(list, 'accept 6134', is('accept', 6134))];
	assert.ok(!(take.step.when || []).some((p) => p.k === 'group'), 'a solo accept, not a group choice');
	const plasm = at(list, 'collect 15849', (g) => g.t === 'collect' && g.quest === 6134);
	for (const q of [5381, 1366, 93225]) assert.ok(at(list, `turnin ${q}`, is('turnin', q)) < plasm, `${q} is handed in before the spectres`);
	assert.ok(at(list, 'complete 5581', (g) => g.quest === 5581 && g.t !== 'accept' && g.t !== 'turnin') < plasm, 'Mannoroc Coven comes first');
	assert.ok(plasm < at(list, 'turnin 6134', is('turnin', 6134)) && at(list, 'turnin 6134', is('turnin', 6134)) < at(list, 'turnin 5581', is('turnin', 5581)), 'Hornizz, then the hearth to Taiga');
	const text = (i) => [list[i].step.note, list[i].step.tip].flat().filter(Boolean).join(' ');
	assert.match(text(plasm), /Spectres \(38-39\)[^.]*in numbers/, 'the spectres come in numbers');
	assert.match(text(plasm), /Necrokhans and Corpsefeeders \(45, elite\)/, 'the elites are named');
	assert.match(text(at(list, 'totems', (g) => g.t === 'collect' && g.quest === 93225)), /Khan Hratha and the Rock Worms \(41-42, elite\)/, 'the valley\'s elites are named');
	const rf = JSON.parse(fs.readFileSync(path.join(ROOT, 'data', 'route-fixes.json'), 'utf8'));
	assert.ok(!rf.deliberate.group.some((g) => g.q === 6134), 'no group record');
	assert.ok(rf.deliberate.pairs.some((p) => p.faction === 'Horde' && `${p.a}` === 'task,5581' && `${p.b}` === 'task,6134'), 'a record the build keeps');
	assert.ok(!rf.overrides.skip.some((s) => s.q === 93225 && s.faction === 'Horde'), 'the totems are not skipped');
});

// Level tidy (2026-11-15): Questioning Reethe's fight (Private Hallan and the Theramore Skirmishers, 36; 4 people died
// there in players' recordings) came on the first walk out of Brackenwall at about 35 (calibrated level model). Ogron
// is now met on the second walk east to the Swamplight Manor, after Brackenwall's hand-ins, and Krog takes it on the
// last Brackenwall stop.
test('forever/horde/30-40/04-dustwallow-marsh.guide: Questioning Reethe comes on the second walk east, after Brackenwall\'s hand-ins', { skip }, () => {
	const list = goals('forever/horde/30-40/04-dustwallow-marsh.guide');
	const take = at(list, 'accept 1273', is('accept', 1273));
	for (const q of [1201, 1322, 1323, 1218]) assert.ok(at(list, `turnin ${q}`, is('turnin', q)) < take, `${q} is handed in first`);
	assert.ok(take < at(list, 'turnin 1206', is('turnin', 1206)), 'on the way to Jarl');
	assert.equal(list[at(list, 'turnin 1273', is('turnin', 1273))].s, list[at(list, 'turnin 1177', is('turnin', 1177))].s, 'Krog, on the last Brackenwall stop');
	const pairs = JSON.parse(fs.readFileSync(path.join(ROOT, 'data', 'route-fixes.json'), 'utf8')).deliberate.pairs;
	assert.ok(pairs.some((p) => p.faction === 'Horde' && `${p.a}` === 'turnin,1323' && `${p.b}` === 'accept,1273'), 'a record the build keeps');
});

// Level tidy (2026-11-15): from the Mudsnout blossoms (Hillsbrad 64,61) the straight line to Hillsbrad's smithy crosses
// Southshore, whose guards (55) stand at 47-55,49-62. The walk now goes back north along the river, north-east of the
// town, and Lydon takes the blossoms with Darthalia's Battle of Hillsbrad on the Tarren Mill stop after the smithy.
test('forever/horde/30-40/01-hillsbrad-foothills.guide: from the Mudsnout blossoms to the smithy north of Southshore', { skip }, () => {
	const list = goals('forever/horde/30-40/01-hillsbrad-foothills.guide');
	const blossoms = at(list, 'collect 3502', (g) => g.t === 'collect' && g.quest === 509);
	const smithy = at(list, 'kill 2404', (g) => g.t === 'kill' && g.quest === 529);
	const way = list.findIndex(({ goal }, i) => i > blossoms && i < smithy && goal.map === 1424 && goal.y < 49 && goal.x > 55);
	assert.ok(way > 0, 'a point north-east of Southshore\'s guards between the blossoms and the smithy');
	assert.ok(!list.some(({ goal }, i) => i > blossoms && i < smithy && goal.map === 1424 && goal.x > 46 && goal.x < 56 && goal.y > 48 && goal.y < 63), 'no goal inside Southshore');
	assert.equal(list[at(list, 'turnin 509', is('turnin', 509))].s, list[at(list, 'turnin 529', is('turnin', 529))].s, 'Lydon and Darthalia on one stop');
});

// Level tidy (2026-11-15): Masoj's Scout Support and Valuable Vantages (98094, 98095, level 25) left the 22-25 Hillsbrad
// guide (the western peak's yetis, 30-32, were five over there). Horde 0.4.0 audit: at 30 the western vial's peak
// (Alterac 38.6,94.8, where 33 of the 34 recorded players placed it) is still among Ferocious Yetis (31-32) and Mountain Lions
// (32-34), so both are left out of this guide too. Soothing Turtle Bisque (7321) comes in their place: Christoph
// Jeffcoat on the first Tarren Mill stop, the Snapjaws (29) on the river walk south, the hand-in after the mine.
test('forever/horde/30-40/01-hillsbrad-foothills.guide: no vials among the western peak\'s yetis; Soothing Turtle Bisque on the river walk', { skip }, () => {
	const list = goals('forever/horde/30-40/01-hillsbrad-foothills.guide');
	const i = (what, pred) => at(list, what, pred);
	for (const q of [98094, 98095]) assert.ok(!list.some(({ goal }) => goal.quest === q), `${q} left out (western peak yetis 31-32)`);
	const meat = i('collect 3712', (g) => g.t === 'collect' && g.item === 3712);
	assert.ok(i('accept 7321', is('accept', 7321)) < meat && meat < i('collect 3502', (g) => g.t === 'collect' && g.quest === 509), 'the meat on the river walk south, before the blossoms');
	assert.ok(i('kill 2305', (g) => g.t === 'kill' && g.npc === 2305) < i('turnin 7321', is('turnin', 7321)), 'handed in after the mine');
	assert.equal(list[i('turnin 7321', is('turnin', 7321))].s, list[i('turnin 539', is('turnin', 539))].s, 'on the Tarren Mill stop with Darthalia');
});

// Level tidy (2026-11-15): the Shimmering Flats' silithid dig (Invaders 34-35) and the Gazers (34-35) came first on the
// flats at about 31 (calibrated level model), three levels over the player. The flats' north (basilisks, tortoises,
// Scorpid Reavers and rocket rubble, 30-32) and the raceway's hand-ins now come first, then one top-up to 32 on the
// Scorpid Reavers (31-32, at most a level over), then the Gazers, the dig and Moktar Krin, all on the same visit
// before Gadgetzan. With players' recorded 25th percentile 33.1-33.2 there, 32 puts the Gazers and Invaders (35) at most
// two over at the top of their camps, with tips; Desolace's Kolkar top-up went (the flats' one covers it).
test('forever/horde/30-40/02-thousand-needles.guide: the flats\' south after the raceway\'s hand-ins, on the same visit', { skip }, () => {
	const list = goals('forever/horde/30-40/02-thousand-needles.guide');
	const firstHandIn = at(list, 'turnin 1105', is('turnin', 1105));
	for (const [what, pred] of [
		['dig 1147', (g) => g.t === 'kill' && g.quest === 1147],
		['Gazers', (g) => g.t === 'kill' && g.quest === 1175 && g.oi === 3],
		['turnin 1147', is('turnin', 1147)],
		['turnin 1175', is('turnin', 1175)],
	]) assert.ok(at(list, what, pred) > firstHandIn, `${what} after the raceway's first hand-ins`);
	assert.ok(at(list, 'turnin 1175', is('turnin', 1175)) < at(list, 'accept 5561', is('accept', 5561)), 'the whole flats before Desolace');
	const levels = list.filter(({ goal }) => goal.t === 'level');
	assert.equal(levels.length, 1, 'one top-up');
	const [flats] = levels;
	assert.equal(flats.goal.level + (flats.goal.frac || 0), 32);
	assert.equal(flats.goal.grind, 4140, 'on the Scorpid Reavers (31-32)');
	const fi = list.indexOf(flats);
	assert.ok(firstHandIn < fi && fi < at(list, 'Gazers', (g) => g.t === 'kill' && g.quest === 1175 && g.oi === 3), 'after the hand-ins, before the Gazers');
	const gazers = list[at(list, 'Gazers', (g) => g.t === 'kill' && g.quest === 1175 && g.oi === 3)].step;
	assert.match([gazers.note, gazers.tip].flat().filter(Boolean).join(' '), /Gazers can still be two over you/, 'the Gazers step says how to pull them');
	const pairs = JSON.parse(fs.readFileSync(path.join(ROOT, 'data', 'route-fixes.json'), 'utf8')).deliberate.pairs;
	assert.ok(pairs.some((p) => p.faction === 'Horde' && `${p.a}` === 'turnin,1105' && `${p.b}` === 'task,1147'), 'a record the build keeps');
});

// --- Tarren Mill (refusal gate's hand-in-first step, 2026-11-08): all 6 people who took Dalaran Patrols (545) had just
// handed in Key to the City (93680) to Magus Wordeen Voidglare, and nobody took it without; the route left 93680 out
// and accepted 545 right after Prison Break In. Key to the City is taken with 544 and handed in before 545's accept,
// all on the 38-39 visit since the level tidy (2026-11-15).
test('forever/horde/30-40/01-hillsbrad-foothills.guide: Key to the City is handed in before Dalaran Patrols is accepted', { skip }, () => {
	const list = goals('forever/horde/30-40/05-arathi-highlands.guide');
	const take = at(list, 'accept 93680', is('accept', 93680));
	const key = at(list, 'collect 279469', (g) => g.t === 'collect' && g.item === 279469);
	const done = at(list, 'turnin 93680', is('turnin', 93680));
	assert.ok(at(list, 'accept 544', is('accept', 544)) < take, 'taken with Prison Break In');
	assert.ok(take < key && key < done, 'the key, then its hand-in');
	assert.ok(done < at(list, 'accept 545', is('accept', 545)), 'Dalaran Patrols after the hand-in');
	// The Grimy Key is looted from an object the data has no spawn for: the step carries the recorded spot.
	const g = list[key].goal;
	assert.ok(g.map === 1416 && Math.hypot(g.x - 16.4, g.y - 89.3) < 0.5, `the key's step points at Alterac 16.4,89.3 (got ${g.map} ${g.x},${g.y})`);
});

// --- Hammerfall (never-taken check, 2026-11-08): the Defiler's Basic Care Package (8263) needs Friendly with the
// Defilers (the game's quest data: RequiredMinRepFaction 510, 3000), which the leveling route never earns; Rutherford
// Twing refused it to a level 28 player. The hand-in (straight from his window: #1699) is optional and the step says why.
test('forever/horde/30-40/01-hillsbrad-foothills.guide: the Defiler\'s Basic Care Package is optional and says it needs Defilers reputation', { skip }, () => {
	const file = 'forever/horde/30-40/05-arathi-highlands.guide';
	const list = goals(file).filter(({ goal }) => goal.quest === 8263);
	assert.ok(list.length >= 1, 'the hand-in');
	for (const { goal } of list) assert.ok(goal.optional, `${goal.t} 8263 is optional`);
	assert.match(stepTips(file, /^\s+turnin 8263\b/).join(' '), /Friendly with the Defilers/);
});

// --- Flow re-order (2026-11-07): Desolace killed Other Fish to Fry's naga at
// Sar'theris Strand and walked past Drulzegar Skraghook in Shadowprey with the
// quest done, carrying it into the Dustwallow guide, whose Desolace visit
// killed the naga again and handed it in about nine hours later. Since the 0.4.0 audit the whole quest is on the
// second Desolace visit (Myrmidons 34-35 and Sea Witches 34-36 were two over at 33): taken and handed in at Shadowprey,
// the naga killed once, between them.
test('forever/horde/30-40/04-dustwallow-marsh.guide: flow re-order: Other Fish to Fry is handed to Drulzegar on the Shadowprey stop after the naga, on one Desolace visit', { skip }, () => {
	const list = goals('forever/horde/30-40/04-dustwallow-marsh.guide');
	const kills = list.filter(({ goal }) => goal.t === 'kill' && goal.quest === 6143);
	assert.equal(kills.length, 3, 'the three naga kinds are killed on the second Desolace visit');
	const turnin = at(list, 'turnin 6143 (Other Fish to Fry)', is('turnin', 6143));
	assert.ok(kills.every(({ s }) => s < list[turnin].s && s > list[at(list, 'accept 6143', is('accept', 6143))].s), 'taken, the naga, then handed in');
	assert.equal(list[turnin].s, list[at(list, 'turnin 5381 (Hand of Iruxos)', is('turnin', 5381))].s, 'on the Shadowprey stop that hands Taiga the box, beside Drulzegar');
	assert.ok(!goals('forever/horde/30-40/02-thousand-needles.guide').some(({ goal }) => goal.quest === 6143), 'the first visit does not carry it');
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

test('Tincho on Discord (#1575), Maazias (#1925): Helcular\'s flames and grave are not on the Horde route', { skip }, () => {
	// The Flame of Uzel's Giant and Mountain Yetis (32-34, in pairs) and Frostmaw (37), and the grave between Southshore's
	// level 55 guards were met at 30-31; the only later Horde Hillsbrad visit (38) doesn't pass them. Level tidy
	// (2026-11-15): part 2 (553) is left out with a route-fixes skip; part 1 (552, the rod) stays, see Kolbi's test.
	const fixes = JSON.parse(fs.readFileSync(path.join(ROOT, 'data', 'route-fixes.json'), 'utf8'));
	assert.ok(fixes.overrides.skip.some((s) => s.q === 553 && s.faction === 'Horde' && s.issue === '#1925'), 'skip 553');
	for (const file of ['forever/horde/30-40/01-hillsbrad-foothills.guide', 'forever/horde/30-40/05-arathi-highlands.guide']) {
		assert.equal(goals(file).filter(({ goal }) => goal.quest === 553).length, 0, `${file}: no Helcular's flames`);
	}
});

test('Kolbi on Discord (#1695): Helcular\'s Rod is farmed on the Foothill Caverns\' 30-32 yetis, never toured into the 32-34 cave', { skip }, () => {
	// The rod drops from every Hillsbrad yeti; the goal toured eleven spots, eight of them in the northern cave of Mountain
	// and Giant Yetis (32-34), taken at 29. Recordings: 15 of the 18 people who got it did so in the caverns. Level tidy
	// (2026-11-15): the caverns' yetis are at most one level over the players there (recorded 25th percentile 30.3), so
	// the rod stays, on the walk from Tarren Mill to the town hall.
	const places = JSON.parse(fs.readFileSync(path.join(ROOT, 'data', 'places.json'), 'utf8'));
	assert.ok(places.places.some((p) => p.quest === 552 && p.objective === 1 && p.at), 'the point is a places.json record');
	const list = goals('forever/horde/30-40/01-hillsbrad-foothills.guide');
	const rod = list.filter(({ goal }) => goal.t === 'collect' && goal.quest === 552);
	assert.ok(rod.length > 0, 'the rod is farmed in the Hillsbrad guide');
	for (const { step, goal } of rod) {
		// The Cave (2248) and Ferocious (2249) Yetis stand at Hillsbrad 42-47,25-34; the 32-34 yetis north of y 14.
		assert.equal(goal.map, 1424);
		for (const p of [goal, ...(goal.spots || [])]) assert.ok(p.x >= 42 && p.x <= 47 && p.y >= 25 && p.y <= 34, `every point is in the caverns (${p.x},${p.y})`);
		const from = (goal.fromNpcs || []).map((n) => n.npc);
		assert.ok(!from.includes(2250) && !from.includes(2251), `the Mountain and Giant Yetis are not the rod's targets (${from.join(', ')})`);
		assert.match([step.note, step.tip].flat().filter(Boolean).join(' '), /Stay in these caverns/, `"${step.title}" says to stay in the caverns`);
	}
	const rodAt = at(list, 'collect 3708', (g) => g.t === 'collect' && g.quest === 552);
	assert.ok(rodAt < at(list, 'kill 2335 (Burnside)', (g) => g.quest === 532 && g.t === 'kill' && g.npc === 2335), 'on the way to the town hall');
	assert.equal(list[at(list, 'turnin 552', is('turnin', 552))].s, list[at(list, 'turnin 532', is('turnin', 532))].s, 'handed in on the town hall trip\'s Tarren Mill stop');
});

test('Danger at the spot (#1575, #1695): the Syndicate missives fallback comes when the Syndicate are under you', { skip }, () => {
	// 32-35 Syndicate; recordings: 4 people died there at about 32. Since the level tidy (2026-11-15) Infiltration and its
	// missive fallback come on the 38-39 visit only.
	assert.deepEqual(goals('forever/horde/30-40/01-hillsbrad-foothills.guide').filter(({ goal }) => goal.quest === 533).map(({ goal }) => goal.t), ['accept'], 'Infiltration is only taken at 30-31 (pick up now, do later)');
	const list = goals('forever/horde/30-40/05-arathi-highlands.guide');
	const steps = list.filter(({ goal }) => goal.t === 'collect' && goal.quest === 533);
	assert.ok(steps.length > 0, 'the missive fallback is on the 38-39 visit');
	assert.ok(at(list, 'turnin 533', is('turnin', 533)) < at(list, 'accept 503', is('accept', 503)), 'Gol\'dir after it, on the same visit');
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
	// #1322: the Lesser Troll's Blood Elixir tip went with Elixir of Agony 515 (left out in the level tidy, 2026-11-15);
	// nothing in this guide sends you for the elixir now.
	assert.equal(list.filter(({ goal }) => goal.quest === 515).length, 0, 'no 515, so no elixir tip');
	const next = goals('forever/horde/30-40/02-thousand-needles.guide').filter(forClass('DRUID'));
	assert.ok(flies(next, 'Thunder Bluff') < flies(next, 'Freewind Post') || flies(next, 'Freewind Post') < 0, 'Druids at 32: Orgrimmar -> Thunder Bluff -> Freewind Post');
});

// Since the Horde 30-40 re-order Desolace is entered at 33 from the Shimmering Flats (30-40/02-thousand-needles).
test('Desolace (Horde 33): a Shaman flies from Freewind Post straight to Sun Rock Retreat, not back to Orgrimmar first (#1191)', { skip }, () => {
	const list = goals('forever/horde/30-40/02-thousand-needles.guide').filter(forClass('SHAMAN'));
	const flights = list.filter(({ goal }) => goal.t === 'fly').map(({ goal }) => goal.location);
	// Since the 0.4.0 audit (#1976) the raceway visit ends with a flight from Gadgetzan back to Freewind Post: the
	// flight after the last one into Freewind Post goes on to Sun Rock Retreat.
	const at = flights.lastIndexOf('Freewind Post');
	assert.ok(at >= 0, flights.join(', '));
	assert.equal(flights[at + 1], 'Sun Rock Retreat', flights.join(', '));
	assert.ok(!flights.slice(at + 1).includes('Orgrimmar') || flights.indexOf('Sun Rock Retreat', at) < flights.indexOf('Orgrimmar', at), flights.join(', '));
});

// Final route review for 0.3.5 (Horde 30-40): Call of Air (1531) is offered from level 30, and the
// 30-40/01 Orgrimmar stop comes at about 29.4, so Searn Firewarder had nothing for the Shaman the step
// sent there. The accept is on 30-40/02's Orgrimmar stop (about 31.7, after Alliance Relations, also
// from 30), before Prate Cloudseer takes it at Freewind Post; a route-fixes pair keeps it there.
test('Horde 30-40: Call of Air is taken on the Orgrimmar stop at 31, not at 29', { skip }, () => {
	refData();
	assert.equal(refData().quests[1531].minLevel, 30, 'Call of Air is offered from level 30');
	const first = goals('forever/horde/30-40/01-hillsbrad-foothills.guide');
	assert.ok(!first.some(({ goal }) => goal.t === 'accept' && goal.quest === 1531), 'no Call of Air on the 29.4 Orgrimmar stop');
	const list = goals('forever/horde/30-40/02-thousand-needles.guide').filter(forClass('SHAMAN'));
	const relations = at(list, 'accept 1431', is('accept', 1431));
	const air = at(list, 'accept 1531', is('accept', 1531));
	const prate = at(list, 'turnin 1531', is('turnin', 1531));
	const fly = at(list, 'fly to Freewind Post', (g) => g.t === 'fly' && /Freewind/.test(g.location || ''));
	assert.ok(relations < air && air < fly && fly < prate, 'Alliance Relations, Call of Air, the flight, then Prate');
	const pair = JSON.parse(fs.readFileSync(path.join(ROOT, 'data', 'route-fixes.json'), 'utf8')).deliberate.pairs
		.find((p) => p.a[0] === 'accept' && p.a[1] === 1431 && p.b[0] === 'accept' && p.b[1] === 1531);
	assert.ok(pair, 'the order is a record');
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
	const rec = JSON.parse(fs.readFileSync(path.join(ROOT, 'data', 'guide-fixes.json'), 'utf8')).fixes.find((f) => f.at.quest === 186 && f.faction === 'Horde' && f.tip);
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

// Final route review for 0.3.5 (Horde 30-32): the level 31 top-up said Hammerfall's quests start at 31
// (they are offered from 29-30; the top-up kept their 32-36 levels within reach), and the level 30 top-up
// by Tarren Mill had no dungeon to run instead of the yetis. Since the level tidy (2026-11-15) Hammerfall's quests
// and Tarren Mill's 33-36 quests come on the 38-39 visit; Hillsbrad keeps one top-up, to 30, for the quests offered
// from 30 on its last Tarren Mill stop and the next guide's first (Horde 0.4.0 audit, round 2). Round 4: the dungeon
// it offers is one whose floor fits the player there (the Excavation Site, 28.2; the City of Dalaran's is 31.5), and
// it grinds on the Torn Fin murlocs (28-30) on the coast below the mine, not the mine's Foremen (27-28).
test('Horde Hillsbrad 30-32: the level 30 and 31 top-ups say why, and the first offers a dungeon at its level', { skip }, () => {
	refData();
	const guide = 'forever/horde/30-40/01-hillsbrad-foothills.guide';
	// Horde 0.4.0 audit (round 2): one top-up to 30 after the Azurelode Mine, right before the last Tarren Mill stop, so
	// Voidglare's quests there and Alliance Relations in the next guide's Orgrimmar (both offered from 30) are open.
	const tops = goals(guide).filter(({ goal }) => goal.t === 'level');
	assert.deepEqual(tops.map(({ goal }) => goal.level), [30], 'one top-up in Hillsbrad, to 30');
	const tip = [tops[0].step.note, tops[0].step.tip].flat().filter(Boolean).join(' ');
	assert.match(tip, /offered from level 30/, 'it says why');
	assert.match(tip, /run the Excavation Site dungeon/, 'it offers the Excavation Site, whose floor (28.2) is under the player');
	assert.ok(refData().npcs[tops[0].goal.grind].level >= 28, 'its camp is at the player\'s level, not the mine\'s Foremen (27-28)');
	const arathi = goals('forever/horde/30-40/05-arathi-highlands.guide');
	for (const q of [655, 672, 677, 97539]) {
		assert.ok(refData().quests[q].minLevel <= 30, `${q} is offered below 31`);
		assert.ok(arathi.some(({ goal }) => goal.t === 'accept' && goal.quest === q), `${q} is taken on the 38-39 visit`);
	}
});

// --- Horde 30-40 audit (2026-11-09): Lydon's Shindigger keg is in Dun Garok's elite cellar, so Elixir
// of Agony's second part was a group choice; since the level tidy (2026-11-15) the route leaves 515 and everything after
// it out (route-fixes skip 515), so no step sends a solo player into the cellar. The Shaman's Water Sapta is used at the
// brazier; Desolace's Demon Pick and clams are lines of their own; Portals of the Legion uses the Hand of Iruxos, not a
// "Rod of Banishing".
test('Horde 30-40 audit: Hillsbrad\'s Shindigger keg is a group choice, in Dun Garok, and its steps lead', { skip }, () => {
	const guide = 'forever/horde/30-40/01-hillsbrad-foothills.guide';
	assert.equal(goals(guide).filter(({ goal }) => [515, 517, 524].includes(goal.quest)).length, 0, 'no Elixir of Agony after 513, so no keg');
	const fixes = JSON.parse(fs.readFileSync(path.join(ROOT, 'data', 'route-fixes.json'), 'utf8'));
	assert.ok(fixes.overrides.skip.some((s) => s.q === 515 && s.faction === 'Horde'), 'skip 515');
	const sham = goals(guide).filter(forClass('SHAMAN'));
	const use = at(sham, 'use 6637', (g) => g.t === 'use' && g.item === 6637);
	assert.ok(use < at(sham, 'collect 7812', (g) => g.t === 'collect' && g.item === 7812), 'the Water Sapta is drunk before the bracers');
});

test('Horde 30-40 audit: Desolace\'s quest items are used where the game needs them', { skip }, () => {
	const first = goals('forever/horde/30-40/02-thousand-needles.guide');
	assert.ok(at(first, 'use 15874', (g) => g.t === 'use' && g.item === 15874) < at(first, 'turnin 6142', is('turnin', 6142)), 'the Soft-shelled Clams before the hand-in');
	assert.equal(first.filter(({ goal }) => goal.quest === 6027).length, 0, 'the Book of the Ancients is not on the first visit');
	assert.deepEqual(first.filter(({ goal }) => goal.quest === 5381).map(({ goal }) => goal.t), [], 'the Hand of Iruxos is not taken on the first visit (0.4.0 audit: 04 takes it where its crystal is)');
	const list = goals('forever/horde/30-40/04-dustwallow-marsh.guide');
	assert.ok(at(list, 'use 14523', (g) => g.t === 'use' && g.item === 14523) < at(list, 'turnin 5381', is('turnin', 5381)), 'the Demon Pick before the hand-in');
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

// Badlands: Lotwil's Large Stone Slabs come from the Rock Elementals beside Agmond's End, where the route goes for
// Theldurin, and Lotwil takes them on the walk back to Kargath (no walk back to his camp from the basin in between).
test('Horde 30-40 audit: Badlands slabs beside Agmond\'s End, Lotwil on the way back', { skip }, () => {
	const list = goals('forever/horde/30-40/06-badlands.guide');
	const slabs = at(list, 'collect 4627', (g) => g.t === 'collect' && g.item === 4627);
	assert.ok(list[slabs].goal.y > 70, 'the slabs\' Rock Elementals are the group beside Agmond\'s End');
	assert.ok(at(list, 'turnin 709', is('turnin', 709)) < at(list, 'turnin 711', is('turnin', 711)), 'Lotwil after Theldurin');
	assert.ok(!list.some(({ goal }) => goal.quest === 712 || goal.quest === 716), 'Lotwil\'s level 42 bracers left out');
	const [kargath] = stepTips('forever/horde/30-40/06-badlands.guide', /^\s+turnin 1419\b/);
	assert.match(kargath, /west back to Kargath/);
});

// Mokii's report (#1431): Dustwallow's level 37.5 grind on the far Mirefin coast came before the Brackenwall hand-ins
// the player already had ready. A written grind comes after the ready hand-ins it would otherwise hold back (the same
// in Thousand Needles' raceway and Stranglethorn's two Grom'gol stops).
test("Mokii's report (#1431): Horde 30-40 grinds come after the ready hand-ins", { skip }, () => {
	for (const [guide, level, after] of [
		['forever/horde/30-40/04-dustwallow-marsh.guide', 36, [1177, 1202, 1239]],
		['forever/horde/30-40/02-thousand-needles.guide', 32, [1110, 1104, 1105]],
		['forever/horde/30-40/03-stranglethorn-vale.guide', 35, [568]],
	]) {
		const list = goals(guide);
		const grind = at(list, `${guide}: level ${level}`, (g) => g.t === 'level' && g.level + (g.frac || 0) === level);
		for (const q of after) assert.ok(at(list, `turnin ${q}`, is('turnin', q)) < grind, `${guide}: turnin ${q} before the level ${level} grind`);
	}
	const g = goals('forever/horde/30-40/04-dustwallow-marsh.guide').find(({ goal }) => goal.t === 'level').goal;
	assert.ok(g.grind !== 4362 && g.y < 30, 'the 37 grind is by Brackenwall, not on the Mirefin murlocs of the north-east coast');
});

// Valik's report (2026-11-09, Discord): at level 30 Henchman Valik showed no quest. Valik (535) is a child of Infiltration
// (533): offered only while 533 is in the log, and its reward is the Syndicate Missive 533 asks for. The step is shown
// only with Infiltration in the log, and the stout is handed in at once, before any missive farming.
test("Valik's report: Valik only with Infiltration in the log, handed in at once", { skip }, () => {
	const guide = 'forever/horde/30-40/05-arathi-highlands.guide';
	const steps = compiled(guide).steps;
	const s = steps.find((st) => st.goals.some((g) => g.t === 'accept' && g.quest === 535));
	assert.ok(s && (s.when || []).some((p) => p.k === 'onquest'), 'the Valik step is gated on Infiltration in the log');
	assert.ok(s.goals.some((g) => g.t === 'turnin' && g.quest === 535), 'the stout is handed in on the same step');
	const list = goals(guide);
	assert.ok(at(list, 'turnin 535', is('turnin', 535)) < at(list, 'collect 3601', (g) => g.t === 'collect' && g.item === 3601), 'Valik before the missive drops');
});

// aVikingTrex's detail on #1661 (Discord, 2026-11-11): waiting at Valik's camp he killed the Syndicate around it and
// the missive dropped; from then on Valik's step could not progress (Valik hostile, no errand). With the missive in
// the bags Infiltration is ready to hand in and Valik's errand, whose reward is that missive, is moot: the step
// applies only while Infiltration is in the log and not yet complete.
test("#1661: with the Syndicate Missive already in the bags the guide passes Henchman Valik", { skip }, () => {
	const guide = 'forever/horde/30-40/05-arathi-highlands.guide';
	const steps = compiled(guide).steps;
	const s = steps.findIndex((st) => st.goals.some((g) => g.t === 'accept' && g.quest === 535)) + 1;
	assert.ok((steps[s - 1].when || []).some((p) => p.k === 'complete' && p.neg && p.q === 533), 'gated on Infiltration not complete');
	const who = { race: 'Tauren', raceName: 'Tauren', faction: 'Horde', cls: 'SHAMAN', className: 'Shaman', level: 38 };
	const applies = (before) => engineRun(guide, who, { before, script: `emit({ applies = E.Applies(${s}) })` }).applies;
	assert.equal(applies('w.onQuest(533, { 1 })'), true, 'Infiltration in the log, no missive yet: Valik');
	assert.equal(applies('w.onQuest(533, { 1 }); w.finish(533)'), false, 'the missive dropped: Valik is passed');
	assert.equal(applies('w.onQuest(533, { 1 }); w.onQuest(535, { 1 }); w.finish(533)'), false, 'his errand taken, then the missive dropped');
});

// Steffen's report (#1466): Infiltration (533, level 34; Syndicate 32-34) was worked at 30, right after the first Tarren
// Mill stop, on every start, and the pace line called it hard. 0.3.7 moved Valik and the missive to the walk back from
// Southshore at about 31-32; the level tidy (2026-11-15) moves the whole quest to the 38-39 visit: accepted on the first
// Tarren Mill stop, Valik on the road north, and Krusk takes it with the Dalaran crater's hand-ins. Valik's gate (above)
// keeps working.
test("#1466: Infiltration is accepted at 30 but Valik and the missive wait for the walk back from Southshore", { skip }, () => {
	assert.deepEqual(goals('forever/horde/30-40/01-hillsbrad-foothills.guide').filter(({ goal }) => goal.quest === 533 || goal.quest === 535).map(({ goal }) => goal.t), ['accept'], 'only the accept at 30 (pick up now, do later)');
	const list = goals('forever/horde/30-40/05-arathi-highlands.guide');
	const take = at(list, 'accept 533', is('accept', 533));
	const valik = at(list, 'accept 535', is('accept', 535));
	const missive = at(list, 'collect 3601', (g) => g.t === 'collect' && g.item === 3601);
	const dalaran = at(list, 'the first Bloodstone piece', (g) => g.t === 'collect' && g.quest === 544);
	const hand = at(list, 'turnin 533', is('turnin', 533));
	const dalaranIn = at(list, 'turnin 544', is('turnin', 544));
	assert.ok(take < valik && valik < missive && missive < dalaran && dalaran < hand, 'accepted first, Valik on the road north, then the crater');
	assert.equal(list[hand].s, list[dalaranIn].s, 'Krusk takes it on the Tarren Mill stop with the Dalaran hand-ins');
	const pairs = JSON.parse(fs.readFileSync(path.join(ROOT, 'data', 'route-fixes.json'), 'utf8')).overrides.pairs;
	assert.ok(!pairs.some((p) => p.a[0] === 'turnin' && p.a[1] === 533 && p.b[1] === 539), 'no #1079 pair hands it in before the mine');
	const deliberate = JSON.parse(fs.readFileSync(path.join(ROOT, 'data', 'route-fixes.json'), 'utf8')).deliberate.pairs;
	assert.ok(deliberate.some((p) => p.a[0] === 'turnin' && p.a[1] === 5581 && p.b[0] === 'task' && p.b[1] === 533), 'a route-fixes pair keeps its work on the 38-39 visit');
});

// Final route review 0.3.6, Horde 38-39: Guile of the Raptor's last two parts (702 to Gor'mul, 847 back to Tor'gan, 2,850 XP)
// were written into the 'when group 679' step of the Stromgarde ogres, so a player who answered "Skip it" never handed
// them in. They are solo hand-ins on the Hammerfall stop; only the elite ogre quests stay on the group step.
test('Horde Arathi 38-39: Guile of the Raptor is handed in on the Hammerfall stop, not only on the group step', { skip }, () => {
	const list = goals('forever/horde/30-40/05-arathi-highlands.guide');
	for (const [t, q] of [['turnin', 702], ['accept', 847], ['turnin', 847]]) {
		const { step } = list[at(list, `${t} ${q}`, is(t, q))];
		assert.ok(!(step.when || []).some((p) => p.k === 'group' || p.k === 'dungeon'), `${t} ${q} is for everyone`);
	}
	assert.ok(at(list, 'accept 702', is('accept', 702)) < at(list, 'turnin 702', is('turnin', 702)), 'taken before it is handed in');
});

// Position sweep (0.3.6, the patrol check): Craven Drok walks the Drag (TDB waypoint path; 46 people met
// him across it, the 3 who took Alliance Relations at three different spots); the tip said he waits there.
test('Orgrimmar (Horde 30): Craven Drok\'s step says he walks the Drag', { skip }, () => {
	const g = goals('forever/horde/30-40/02-thousand-needles.guide');
	at(g, 'accept 1431', is('accept', 1431));
	const src = fs.readFileSync(path.join(OFFICIAL_DIR, 'forever/horde/30-40/02-thousand-needles.guide'), 'utf8');
	assert.match(src, /tip [^\n]*Craven Drok walks the Drag/);
	assert.doesNotMatch(src, /Craven Drok waits in the Drag/);
});

// Players' recordings (0.3.6): Horde 30-40 Hillsbrad's travel step into the Dalaran crater pointed at
// Ricter's own spot, in the middle of the linked guard pairs. Of 6 people on 0.3.5+, 3 worked the camp for 12-35
// minutes with only that travel step showing (the goals, NPCs and the linked-pairs warning are on the next step), 2
// died there, and one person in the whole archive ever stood on Ricter's spot. The step now ends at the
// crater's eastern rim, on the path players walk in from the east, outside the guards' reach (the crater is on the
// 38-39 visit since the level tidy, 2026-11-15).
test('Horde Hillsbrad 30: the walk to the Dalaran crater ends at its rim, not on Ricter', { skip }, () => {
	const steps = compiled('forever/horde/30-40/05-arathi-highlands.guide').steps;
	const crater = steps.findIndex((st) => st.goals.some((g) => g.t === 'collect' && g.quest === 544));
	assert.ok(crater > 0, 'the crater step');
	const walk = steps[crater - 1].goals.find((g) => g.t === 'goto');
	assert.ok(walk && walk.map === 1416, 'the step before is the walk there');
	const yd = (x, y) => Math.hypot((walk.x - x) / 100 * 2800, (walk.y - y) / 100 * 1866.667);
	for (const [who, x, y] of [['Ricter', 20.16, 84.28], ['Alina', 20.34, 86.4], ['Dermot', 19.91, 85.97]]) {
		assert.ok(yd(x, y) >= 60, `${who} is ${Math.round(yd(x, y))} yd from the walk's end`);
	}
	assert.ok(yd(20.16, 84.28) <= 200, 'still at the crater');
});

// Review (0.3.6, Horde Stranglethorn 34, flow): the guide came in by zeppelin and walked from Nesingwary's camp all the way
// down the vale (2,900 yd) to take Booty Bay's quests and flight path, then flew back. It now flies to Ratchet (Gazlowe's
// 1178 and Dizzywig's 1111 handed in on the way), takes the boat to Booty Bay and walks north once: Goblin Sponsorship
// 1180-1182 ride along (Lozgil on the pier, Revilgaz upstairs, Cozzle's footlocker by the geologists' lake), 1183 for the Raceway.
test('Horde Stranglethorn 34: Ratchet and the boat to Booty Bay first, one walk north, Goblin Sponsorship on the way to Revilgaz', { skip }, () => {
	const list = goals(STRANGLETHORN_HORDE);
	const ratchet = at(list, 'fly Ratchet', (g) => g.t === 'fly' && /Ratchet/.test(g.location || ''));
	const hand = at(list, 'turnin 1178', is('turnin', 1178));
	const take = at(list, 'accept 1180', is('accept', 1180));
	assert.ok(ratchet < hand && list[take].s === list[hand].s && take > hand, 'Gazlowe offers 1180 on the 1178 hand-in, in Ratchet');
	assert.ok(at(list, 'turnin 1111', is('turnin', 1111)) < at(list, 'getfp Booty Bay', (g) => g.t === 'getfp' && /Booty Bay/.test(g.location || '')), 'Dizzywig before the boat');
	const bb = at(list, 'turnin 1180', is('turnin', 1180));
	const gromgol = at(list, "getfp Grom'gol", (g) => g.t === 'getfp' && /Grom'gol/.test(g.location || ''));
	for (const q of [1181, 575, 605, 213, 189, 201]) assert.ok(at(list, `accept ${q}`, is('accept', q)) < gromgol, `${q} taken in Booty Bay before the walk north`);
	assert.ok(bb < gromgol, 'Lozgil and Revilgaz on the first Booty Bay stop');
	// Since the Horde 0.4.0 audit (round 2) Goblin Sponsorship part 4 (1182: Foreman Cozzle 38 and the Venture Co.
	// Agents 39 at about 34) is left out of the solo route.
	assert.ok(!list.some(({ goal }) => goal.quest === 1182), 'no Cozzle errand');
	const flights = list.filter(({ goal }) => goal.t === 'fly' && /Booty Bay/.test(goal.location || ''));
	assert.equal(flights.length, 1, 'one flight to Booty Bay, for the hand-ins');
	// Since the 0.4.0 audit Goblin Sponsorship's last part (1183, to Pozzik at 43) is taken on the 40-50 guide's first
	// Booty Bay stop, not carried from here through four guides.
	assert.ok(!list.some(({ goal }) => is('accept', 1183)(goal)), '1183 is not taken at 36');
	const h04 = goals('forever/horde/30-40/04-dustwallow-marsh.guide');
	assert.ok(!h04.some(({ goal }) => [1178, 1111, 1180].includes(goal.quest)), 'Dustwallow\'s Ratchet stop keeps only Mebok');
	const rf = JSON.parse(fs.readFileSync(path.join(ROOT, 'data', 'route-fixes.json'), 'utf8')).overrides;
	assert.ok(rf.include.some((e) => e.q === 1180), 'a route-fix include keeps 1180');
	assert.ok(rf.skip.some((e) => e.q === 1182 && e.faction === 'Horde'), 'a route-fix skip leaves out 1182');
});

// Review (0.3.6, Horde Desolace 34): Claim Rackmore's Treasure (6161, 2,800 XP) was left out although its log, both keys
// and its chest lie on the coast the guide works: the silver key from the clam beds' Drysnap crabs, the golden key from the
// Slitherblade naga, the chest beside the Serpent Statue. The coast is now one walk north after Thunder Axe Fortress.
// Level tidy (2026-11-15): the Book of the Ancients (6027) left the Horde route, so the chest has its own step.
test('Horde Desolace 34: Rackmore\'s Treasure on one walk north along the coast, after Thunder Axe Fortress', { skip }, () => {
	const list = goals('forever/horde/30-40/02-thousand-needles.guide');
	assert.equal(list.filter(({ goal }) => goal.quest === 6027).length, 0, 'no Book of the Ancients');
	const take = at(list, 'accept 6161', is('accept', 6161));
	const silver = at(list, 'silver key', (g) => g.t === 'collect' && g.item === 15878);
	const gold = at(list, 'golden key', (g) => g.t === 'collect' && g.item === 15881);
	const chest = at(list, 'turnin 6161', is('turnin', 6161));
	assert.ok(at(list, 'turnin 5741', is('turnin', 5741)) < take, 'after the Sceptre is back with Azore');
	assert.ok(take < silver && silver < gold && gold < chest, 'log, crabs, naga, chest');
	assert.ok(at(list, 'interact 177784 (clams)', (g) => g.t === 'interact' && g.object === 177784) > take, 'the clams come after the log');
	assert.ok(list.every(({ goal }) => !goal.only), 'no race or class filter');
});

test("creazy231's report (#1660): Hillsbrad 30-40 catches a player who skipped the 22-25 guide up on Battle of Hillsbrad and The Rescue", { skip }, () => {
	const list = goals(HILLSBRAD_3040);
	const catchUp = list.filter(({ goal }) => [527, 528, 498].includes(goal.quest));
	assert.ok(catchUp.length >= 9, 'the chains are in the guide');
	for (const { step, goal } of catchUp) {
		const last = [527, 528].includes(goal.quest) ? 528 : 498;
		assert.ok((step.when || []).some((p) => p.k === 'turnedin' && p.neg && p.q === last), `${goal.t} ${goal.quest}: only until ${last} is handed in`);
	}
	for (const { step, goal } of list.filter(({ goal }) => goal.quest === 529 && goal.t !== 'turnin')) {
		assert.ok((step.when || []).some((p) => p.k === 'turnedin' && p.neg && p.q === 529), `${goal.t} 529: only until 529 is handed in`);
	}
	const take = at(list, 'accept 532', is('accept', 532));
	assert.ok(at(list, 'turnin 529', is('turnin', 529)) < take, '529 handed in before 532 is taken');
	assert.ok(at(list, 'turnin 498', is('turnin', 498)) < take, 'The Rescue handed in before the town hall');
	const out = hillsbradChains('');
	assert.deepEqual(Object.values(out.hidden), [], 'nothing left out for a character without the 22-25 guide'); // an empty Lua table comes back as {}
	for (const q of ['527', '498', '529', '532']) assert.ok(!/skipped|na/.test(out.accepts[q]), `${q} is open: ${out.accepts[q]}`);
});

test("Kolbi's report (#1776): Hillsbrad 30-40's catch-up kills Dangerous!'s Kalaba with the peasants and Wilkes at the smithy", { skip }, () => {
	const list = goals(HILLSBRAD_3040);
	const stepOf = (pred, what) => list[at(list, what, pred)].step;
	const kill = (npc, q, oi) => (g) => g.t === 'kill' && g.quest === q && g.oi === oi && g.npc === npc;
	assert.ok(at(list, 'accept 567', is('accept', 567)) < at(list, 'Farmer Kalaba', kill(2451, 567, 4)), 'taken from the poster first');
	assert.equal(stepOf(kill(2451, 567, 4), 'Farmer Kalaba'), stepOf(kill(2404, 529, 1), 'the smithy'), 'Kalaba with the smithy');
	assert.equal(stepOf(kill(2449, 567, 2), 'Citizen Wilkes'), stepOf(kill(2404, 529, 1), 'the smithy'), 'Wilkes at the smithy');
	assert.equal(stepOf(kill(2448, 567, 1), 'the clerk'), stepOf(kill(2387, 532, 2), 'the town hall'), 'the clerk in the town hall, with 532');
	assert.equal(stepOf(kill(2450, 567, 3), 'the miner'), stepOf(kill(2269, 539, 2), 'the mine'), 'the miner in the mine, with 539');
	// Carried from the 22-25 guide with nothing killed, and Battle of Hillsbrad not done: every kill has an open step.
	const carried = dangerousKills('w.onQuest(567, { 1, 1, 1, 1 })');
	for (const oi of ['1', '2', '3', '4']) assert.ok(carried[oi] && !/skipped|na|done/.test(carried[oi]), `567.${oi} is open: ${carried[oi]}`);
	// A character who did the 22-25 guide (529 handed in) sees no catch-up step: Kalaba and Wilkes are behind them.
	const followed = dangerousKills('w.complete({ 527, 528, 529, 498 }); w.onQuest(567, { { required = 1, fulfilled = 0 }, { required = 1, fulfilled = 1 }, { required = 1, fulfilled = 0 }, { required = 1, fulfilled = 1 } })');
	assert.equal(followed['2'], 'na');
	assert.equal(followed['4'], 'na');
	for (const oi of ['1', '3']) assert.ok(!/skipped|na|done/.test(followed[oi]), `567.${oi} is open: ${followed[oi]}`);
});
// Discord (Bright and others, 2026-11-09): Hillsbrad & Arathi was labelled 29-32 (29-33 since #1660) but most of its
// quests were 32-34 ("the group one"). Since the level tidy (2026-11-15) the Hillsbrad guide keeps only the quests at
// its 29-31 label (Tarren Mill's 33-36 quests and Hammerfall's chain moved to the 38-39 visit), and its pitch says so.
test('forever/horde/30-40/01-hillsbrad-foothills.guide: Discord: the guide says why its quests run above its 29-33 label', { skip }, () => {
	const g = compiled('forever/horde/30-40/01-hillsbrad-foothills.guide');
	assert.deepEqual([g.minLevel, g.maxLevel], [29, 31], 'the label stays the route\'s character levels');
	assert.match(g.pitch || '', /at or under your level/, 'the pitch says its quests fit the label');
	const hills = goals('forever/horde/30-40/01-hillsbrad-foothills.guide');
	for (const q of [553, 677, 97539]) assert.ok(!hills.some(({ goal }) => goal.quest === q), `${q} is not in the 29-31 guide`);
	for (const q of [544, 533, 676]) assert.deepEqual(hills.filter(({ goal }) => goal.quest === q).map(({ goal }) => goal.t), ['accept'], `${q} is only taken in the 29-31 guide (pick up now, do later)`);
});

// Helcular's Revenge (553, Horde 30-40/01-hillsbrad-foothills): the grave lies inside Southshore, an Alliance town
// (4 abandons in players' recordings), between level 55 guards. Since the level tidy (2026-11-15, #1925) the quest is
// left out of the Horde route (its yetis were over the players too), so no Horde guide sends anyone into Southshore's
// graveyard.
test('forever/horde/30-40/01-hillsbrad-foothills.guide: Helcular\'s grave is approached from the north, between the guards', { skip }, () => {
	for (const guide of H3040) assert.ok(!goals(guide).some(({ goal }) => goal.quest === 553), `${guide}: no Helcular's grave`);
	const fixes = JSON.parse(fs.readFileSync(path.join(ROOT, 'data', 'route-fixes.json'), 'utf8'));
	assert.ok(fixes.overrides.skip.some((s) => s.q === 553 && s.faction === 'Horde'), 'skip 553 is recorded');
});

// mylons's report (#1893): Stranglethorn Vale's Cozzle's Footlocker step showed to a player without Goblin
// Sponsorship's footlocker part (1182), whose accept on the Booty Bay stop was hidden because the chain before it
// was not done, and its Cozzle's Key line (5851, not tied to the quest) sent them to farm Foreman Cozzle. The key
// drops only while 1182 is in the log (players' recordings; CMaNGOS has it as a quest-only drop). A guide-fixes
// record gives the step `when onquest 1182`, which holds every line of the step, the key's too. The guide is
// generated: until the maintainer's build writes the record in, the check plays the guide with it written in
// the way the writer does (after the step's title and its `only`/`zone` lines).
test("mylons's report (#1893): the Cozzle's Footlocker step waits until Goblin Sponsorship (1182) is in the log", { skip }, () => {
	const guide = 'forever/horde/30-40/03-stranglethorn-vale.guide';
	const fixes = JSON.parse(fs.readFileSync(path.join(ROOT, 'data', 'guide-fixes.json'), 'utf8')).fixes;
	const rec = fixes.find((f) => f.issue === 1893);
	assert.ok(rec, 'the gate is a guide-fixes record');
	assert.deepEqual([rec.faction, rec.at, rec.when], ['Horde', { quest: 1182, goal: 'objective', objective: 1 }, 'onquest 1182']);
	// Since the Horde 0.4.0 audit (round 2) Goblin Sponsorship part 4 is left out of the solo route (Foreman Cozzle 38
	// and the Venture Co. Agents 39 at about 34): with no Cozzle step, the record stays for a build that brings it back.
	if (!goals(guide).some(({ goal }) => goal.quest === 1182)) {
		const rf = JSON.parse(fs.readFileSync(path.join(ROOT, 'data', 'route-fixes.json'), 'utf8')).overrides;
		assert.ok(rf.skip.some((e) => e.q === 1182 && e.faction === 'Horde'), 'Goblin Sponsorship part 4 is a route-fixes skip');
		return;
	}
	// The key's line shares the anchored objective's step, so the step's gate holds it too.
	const list = goals(guide);
	const blueprints = list[at(list, 'collect 5852 quest 1182', (g) => g.t === 'collect' && g.item === 5852 && g.quest === 1182)];
	const key = list[at(list, "collect 5851 (Cozzle's Key)", (g) => g.t === 'collect' && g.item === 5851)];
	assert.equal(key.s, blueprints.s, "Cozzle's Key is on the blueprints' step");
	// The guide as a build writes it.
	const lines = fs.readFileSync(path.join(OFFICIAL_DIR, guide), 'utf8').split('\n');
	const anchor = lines.findIndex((l) => /^\s+collect 5852 quest 1182(\.1)?(\s|$)/.test(l));
	let title = anchor;
	while (!/^step\s/.test(lines[title])) title--;
	let end = anchor;
	while (end + 1 < lines.length && /^\s/.test(lines[end + 1])) end++;
	if (!lines.slice(title + 1, end + 1).some((l) => l.trim() === `when ${rec.when}`)) {
		let k = title + 1;
		while (/^\s+(only|zone|when)\s/.test(lines[k])) k++;
		lines.splice(k, 0, `  when ${rec.when}`);
	}
	const who = { race: 'Scourge', raceName: 'Undead', faction: 'Horde', cls: 'PALADIN', className: 'Paladin', level: 35 };
	const view = (before) => Object.values(engineRun(guide, who, {
		text: lines.join('\n'),
		before,
		script: `local out = {}
			for _, g in ipairs(E.GetStepView(${key.s}).goals) do out[#out + 1] = g.t .. " " .. tostring(g.item or g.quest) .. " " .. g.status end
			emit(out)`,
	}));
	// Without 1182 nothing of the step is for this character: no farming Cozzle for a key that never drops.
	const without = view('');
	assert.ok(without.length >= 2 && without.every((v) => / (na|skipped)$/.test(v)), `without 1182: ${without.join(', ')}`);
	// With it in the log, the key and the blueprints are the step's work.
	const onQuest = view('w.onQuest(1182, { 1 })');
	assert.ok(onQuest.some((v) => /^collect 5851 /.test(v) && !/ (na|skipped)$/.test(v)), `with 1182, the key: ${onQuest.join(', ')}`);
	assert.ok(onQuest.some((v) => /^collect 5852 /.test(v) && !/ (na|skipped)$/.test(v)), `with 1182, the blueprints: ${onQuest.join(', ')}`);
});

// #1985: Dustwallow Marsh's venom-sac step named only the Darkfang Venomspitters; every Darkfang spider drops the
// Acidic Venom Sacs for The Black Shield (1322), the Giant Darkfang Spiders too (drop data, players' recordings). The
// record alone never reached the guide (0.4.0 was not rebuilt from it): the guide's goal line carries the note.
test('Dustwallow Marsh (Horde): the venom-sac goal says every Darkfang spider drops them, in the guide and its record (#1985)', { skip }, () => {
	const { fixes } = JSON.parse(fs.readFileSync(path.join(ROOT, 'data', 'guide-fixes.json'), 'utf8'));
	const r = fixes.find((f) => f.at && f.at.quest === 1322 && f.at.goal === 'objective' && f.at.objective === 1);
	assert.ok(r && /Giant Darkfang Spiders/.test(r.goalNote) && /Lurkers/.test(r.goalNote), 'a goal note on 1322.1 naming every Darkfang kind');
	const list = goals('forever/horde/30-40/04-dustwallow-marsh.guide');
	const { goal } = list[at(list, 'collect 5959 quest 1322', (g) => g.t === 'collect' && g.item === 5959 && g.quest === 1322)];
	for (const kind of ['Lurkers', 'Spiders', 'Venomspitters', 'Giant Darkfang Spiders']) assert.match(goal.note || '', new RegExp(kind), `the guide's goal names the ${kind}`);
});

// #2222 (JohnSalchi, Orc Warrior 36): a death at the Theramore Docks, where the Captain's Footlocker lies under Theramore's
// level 53-57 guards, is a long corpse run (his was 1,585 yards); the step says so, in the guide and its seed.
test("#2222: Dustwallow Marsh's Theramore Docks step warns that a death there is a long run back, in the guide and its seed", () => {
	const rel = 'forever/horde/30-40/04-dustwallow-marsh.guide';
	for (const file of [path.join(OFFICIAL_DIR, rel), path.join(ROOT, 'forge', 'seed', 'guides', rel)]) {
		const step = fs.readFileSync(file, 'utf8').split(/\n(?=step )/).find((s) => s.startsWith('step The Theramore Docks\n'));
		assert.ok(step, `${file}: a Theramore Docks step`);
		assert.match(step, /guards are level 53-57.*long run back from the spirit healer/, `${file}: the corpse run`);
	}
});

// #1933: Thundering Hearts (97985) was in no Horde guide. Calder Gray gives it and takes it back in the Undercity's
// Apothecarium; Stormheart, who carries the heart, walks the canyon floor east of Freewind Post. The route takes it
// on the Undercity stop that ends the 30-40 Hillsbrad guide, right after Varimathras (550), from where the Thousand
// Needles guide leaves (the 0.4.0 rebuild applies the record).
test('route-fixes takes Thundering Hearts on the Undercity stop before Thousand Needles (#1933)', { skip }, () => {
	const { overrides } = JSON.parse(fs.readFileSync(path.join(ROOT, 'data', 'route-fixes.json'), 'utf8'));
	const rec = overrides.include.find((r) => r.q === 97985);
	assert.ok(rec && /#1933/.test(`${rec.issue}`), 'route-fixes includes 97985 for #1933');
	assert.deepEqual(rec.after, ['turnin', 550], 'its accept goes right after Varimathras');
	assert.ok(!overrides.skip.some((r) => r.q === 97985), 'no skip record leaves it out');
	// The anchor is the route's last hand-in before the Thousand Needles guide, in the city Calder Gray stands in.
	const hills = goals('forever/horde/30-40/01-hillsbrad-foothills.guide');
	const last = hills.filter(({ goal }) => goal.t === 'turnin').pop();
	assert.ok(last.goal.t === 'turnin' && last.goal.quest === 550 && last.goal.map === 1458, "Varimathras's hand-in in the Undercity closes the Hillsbrad guide's quests");
	assert.equal(compiled('forever/horde/30-40/01-hillsbrad-foothills.guide').next.replace(/\.guide$/, ''), 'forever/horde/30-40/02-thousand-needles', 'the Thousand Needles guide comes next');
});

// #1933, written into the guides by hand for 0.4.0, as the writer lays out the record above: Stormheart is an elite
// the data knows, so the quest is a group family (`when group 97985`, the player chooses it, the solo route skips
// it): Calder Gray's accept on a step of its own after Varimathras (whose step shows only with 550 in the log),
// Stormheart's heart with the family's tip on the canyon road from Freewind Post's lift before Moktar Krin, and
// the hand-in on the next Undercity stop, the one the Arathi guide opens with, before its flight to Tarren Mill.
test('Thundering Hearts: taken after Varimathras, the heart on the way to Moktar Krin, handed in on the next Undercity stop (#1933)', { skip }, () => {
	const H = (g) => `forever/horde/30-40/${g}.guide`;
	const group = (step) => (step.when || []).some((p) => p.k === 'group' && !p.neg && [].concat(p.q).includes(97985));
	const hills = goals(H('01-hillsbrad-foothills'));
	const take = at(hills, 'accept 97985', is('accept', 97985));
	assert.ok(take > at(hills, 'turnin 550', is('turnin', 550)), 'the accept comes after Varimathras');
	assert.ok(group(hills[take].step) && hills[take].goal.map === 1458, 'the accept, in the Undercity, for a player who chooses the group quest');
	const needles = goals(H('02-thousand-needles'));
	const heart = at(needles, "Stormheart's heart", (g) => g.t === 'collect' && g.item === 279186 && g.quest === 97985);
	assert.ok(group(needles[heart].step), 'the heart, behind the same choice');
	assert.ok(heart < at(needles, 'turnin 1146', is('turnin', 1146)), 'the heart comes on the way to Moktar Krin');
	const arathi = goals(H('05-arathi-highlands'));
	const back = at(arathi, 'turnin 97985', is('turnin', 97985));
	assert.ok(arathi[back].goal.map === 1458 && back < at(arathi, 'the flight to Tarren Mill', (g) => g.t === 'fly'), 'handed in on the Undercity stop, before the flight');
});

// #2650 (Sable, 0.4.0, Horde Hillsbrad): Citizen Wilkes was not at the guide's spot, his Classic spawn at
// 32.62,39.79; players kill him on the west side of Hillsbrad Fields' town (recordings: 72 people, 29-31,38-43).
test('#2650: Hillsbrad (Horde): Citizen Wilkes is looked for on the west side of the town', { skip }, () => {
	const list = goals('forever/horde/30-40/01-hillsbrad-foothills.guide');
	const { goal } = list[at(list, 'kill 2449', (g) => g.t === 'kill' && g.npc === 2449)];
	assert.equal(goal.map, 1424);
	assert.ok(goal.x >= 29 && goal.x <= 31.5 && goal.y >= 38 && goal.y <= 43, `where players meet him: ${goal.x},${goal.y}`);
});
