'use strict';
// Player-reported guide fixes: the Horde 40-50 guides.
// tests/reported/helpers.js says what the cases check and where a new one goes.

const { test } = require('node:test');
const assert = require('node:assert/strict');
const fs = require('node:fs');
const path = require('node:path');
const {
	anyLine, at, codeOf, compiled, forClass, goals, is, OFFICIAL_DIR, RIVERGLADES_HORDE, rivergladesSteps, ROOT, skip,
	stepTips, where,
} = require('./helpers');

// Horde 40-50 route audit (0.4.0): fixes pinned by the band's audit (players' recordings, the travel sweep and the
// calibrated level model).
const H40 = (n) => `forever/horde/40-50/${n}.guide`;

// Hand-in sweep (2026-11-16, after Kerlonian's escort): The Vile Reef step reached the Drowned City's entrance with a
// goto, done on arrival whether the quest's find counted or not, ~40 yards from the find's point. The step waits for
// Locating the Lost City (95770) itself, at the same point.
test("forever/horde/40-50/01-stranglethorn-vale.guide: The Vile Reef waits for Locating the Lost City's find, not only the arrival", { skip }, () => {
	const list = goals('forever/horde/40-50/01-stranglethorn-vale.guide');
	const work = at(list, 'complete 95770', is('complete', 95770));
	assert.ok(work < at(list, 'turnin 95770', is('turnin', 95770)), 'before the hand-in at Kin\'weelay');
	const { goal, step } = list[work];
	assert.equal(step.title, 'The Vile Reef');
	assert.ok(goal.map === 1434 && Math.hypot(goal.x - 21.8, goal.y - 27.6) < 0.2, `at the entrance (${goal.map} ${goal.x},${goal.y})`);
});

test('Horde 40-50 binds: Stranglethorn sets none, Camp Mojache is bound once (0.4.0 route audit)', { skip }, () => {
	// The travel sweep found no trip in 30-40/06 or 40-50/01 that hearths back to Grom'gol, Booty Bay or Stonard.
	const stv = goals(H40('01-stranglethorn-vale')).filter(({ goal }) => goal.t === 'sethome');
	assert.deepEqual(stv.map(({ goal }) => goal.location), [], '40-50/01 leaves the hearthstone where it is');
	const binds = goals(H40('02-feralas')).filter(({ goal }) => goal.t === 'sethome');
	assert.deepEqual(binds.map(({ goal }) => goal.location), ['Camp Mojache'], '40-50/02 binds Camp Mojache once, at Innkeeper Greul');
});

test("Horde 40-50/06: Un'Goro Soil comes after Assisting Arch Druid Runetotem is handed to Hamuul (#2025, #2085)", { skip }, () => {
	const list = goals(H40('06-azshara'));
	const take = at(list, 'accept 3762 (Innkeeper Pala)', is('accept', 3762));
	const handIn = at(list, 'turnin 3762 (Hamuul)', is('turnin', 3762));
	const soil = at(list, "accept 3761 (Un'Goro Soil)", is('accept', 3761));
	assert.ok(take < handIn && handIn < soil, 'the breadcrumb is out of the log before its target is asked for');
	assert.equal(list[take].s, list[soil].s, 'all on the one Thunder Bluff stop');
});

test('Horde 40-50/05: Venom Bottles is not taken, its hand-in is behind the route in Tarren Mill (0.4.0 route audit)', { skip }, () => {
	for (const n of ['05-the-hinterlands', '06-azshara']) {
		assert.deepEqual(goals(H40(n)).filter(({ goal }) => goal.quest === 2933).map(({ goal }) => goal.t), [], `${n}: no Venom Bottles goal`);
	}
});

test('Horde 40-50/01: the Wild Shore pass comes after the Cape of Stranglethorn coast, not at 40 (#2102)', { skip }, () => {
	// Since the 0.4.0 level tidy the Wild Shore (Bloodsail 43-45) is still taken on the Booty Bay stop after the coast,
	// but its pirates are fought on 40-50/02's Grom'gol stop at about 45 (after the Riverglades), where they fit.
	const list = goals(H40('01-stranglethorn-vale'));
	// The Booty Bay stop after the coast is the one that hands in Scaring Shaky (606).
	const coastStop = at(list, 'turnin 606 (Shaky Phillipe)', is('turnin', 606));
	for (const q of [604, 587, 576]) {
		const take = at(list, `accept ${q}`, is('accept', q));
		assert.ok(take > coastStop, `${q} is taken on the Booty Bay stop after the coast, not on the first visit`);
	}
	assert.ok(!list.some(({ goal }) => goal.t === 'kill' && goal.quest === 604), 'no swashbuckler kills in 40-50/01');
	const st = goals(H40('02-feralas'));
	const swash = at(st, 'the Bloodsail Swashbucklers (604.1)', (g) => g.t === 'kill' && g.quest === 604);
	const back = at(st, 'turnin 573 (Mok\'thardin, end of the Stranglethorn stop)', is('turnin', 573));
	assert.ok(swash < back, 'the swashbuckler kills on the Grom\'gol stop of 40-50/02');
	assert.ok(at(list, 'accept 348 (Fin Fizracket)', is('accept', 348)) >= 0, 'Stranglethorn Fever is taken in 40-50/01');
	const fang = at(st, 'the gorilla fang for 348', (g) => g.quest === 348 && g.t === 'collect');
	assert.ok(fang < back, 'and its heart is fetched on that stop');
});

test('Horde 40-50/01: the Green Hills chapters and Goblin Sponsorship are taken here, with 30-40/03 no longer carrying them (0.4.0 audit)', { skip }, () => {
	const list = goals(H40('01-stranglethorn-vale'));
	const when = (e, k) => (e.step.when || []).filter((p) => p.k === k);
	const book = list[at(list, 'accept 338', is('accept', 338))];
	assert.ok(when(book, 'turnedin').some((p) => [p.q].flat().includes(583)), '338 only after Welcome to the Jungle');
	for (const q of [339, 340, 341, 342]) {
		const take = list[at(list, `accept ${q}`, is('accept', q))];
		assert.ok(when(take, 'has').length >= 3, `${q}: only with its pages in the bags`);
		assert.ok(list.some((e) => is('turnin', q)(e.goal) && e.s === take.s), `${q}: handed in on the spot`);
	}
	// Since the Horde 0.4.0 audit (round 2) Goblin Sponsorship part 4 (1182) is left out of the solo route, and its
	// part 5 (1183) with it.
	assert.ok(!list.some(({ goal }) => [1182, 1183].includes(goal.quest)), 'no Goblin Sponsorship part 4 or 5');
});

test('Horde 40-50: Feralas & Tanaris opens from Stonard or from Kargath, and every Stonard flight has a way in without its flight path (R17r)', { skip }, () => {
	// The Riverglades guide hands over at Kargath (about 45); a character who starts Feralas & Tanaris fresh in the
	// Badlands may not know Stonard's flight path.
	const whenOf = (step, k) => (step.when || []).filter((p) => p.k === k);
	const opener = goals(H40('02-feralas')).filter(({ goal }) => goal.t === 'fly' && goal.location === "Grom'gol").slice(0, 2);
	assert.equal(opener.length, 2, 'two ways to the Grom\'gol flight at the start');
	const zones = opener.map(({ step }) => whenOf(step, 'zone').map((p) => `${p.neg ? '!' : ''}${p.zone || p.name || p.v}`).join());
	assert.ok(zones.some((z) => /Swamp of Sorrows/.test(z)) && zones.some((z) => /Badlands/.test(z)), `one from Stonard, one from Kargath: ${zones}`);
	for (const n of ['03-feralas', '05-the-hinterlands']) {
		const list = goals(H40(n));
		const fly = list.find(({ goal }) => goal.t === 'fly' && goal.location === 'Stonard');
		assert.ok(fly && whenOf(fly.step, 'taxi').some((p) => !p.neg), `${n}: the Stonard flight is for characters who know it`);
		const learn = list.find(({ goal }) => goal.t === 'getfp' && /Stonard/.test(goal.location || ''));
		assert.ok(learn && whenOf(learn.step, 'taxi').some((p) => p.neg), `${n}: the others get there another way and learn it`);
	}
});

test('Horde 40-50/01: the classes the Undercity trains do their level 40 training there on the way to Grom\'gol (R17)', { skip }, () => {
	// No class trainer between 30-40/05's Undercity (~38) and 40-50/02's Orgrimmar (~43) before this.
	const list = goals(H40('01-stranglethorn-vale'));
	const firstGromgol = at(list, 'turnin 1240 (Kin\'weelay)', is('turnin', 1240));
	for (const cls of ['WARRIOR', 'MAGE', 'PRIEST']) {
		const mine = list.filter(forClass(cls));
		const train = mine.findIndex(({ goal }) => goal.t === 'train' && goal.class);
		const kin = mine.findIndex(({ goal }) => is('turnin', 1240)(goal));
		assert.ok(train >= 0 && train < kin, `${cls}: trains before the first Grom'gol stop`);
	}
	for (const cls of ['HUNTER', 'SHAMAN']) {
		const mine = list.slice(0, firstGromgol).filter(forClass(cls));
		assert.ok(mine.some(({ goal }) => goal.t === 'fly' && goal.location === "Grom'gol"), `${cls}: flies straight to Grom'gol (no trainer in the Undercity)`);
		assert.ok(!mine.some(({ goal }) => goal.t === 'fly' && goal.location === 'Undercity'), `${cls}: no Undercity detour`);
	}
});

test('Horde 40-50: grind tips name a dungeon only when its run is in the same or the next guide on that continent', { skip }, () => {
	// The dungeons-in-the-route rule (0.4.0): Uldaman and Maraudon have no run in the route; the Sunken Temple's is in
	// 50-60/01, two guides after 40-50/05; Zul'Farrak's is in 40-50/04, right after 40-50/03.
	const tipsOf = (n) => fs.readFileSync(path.join(OFFICIAL_DIR, H40(n)), 'utf8').split('\n').filter((l) => /^\s+tip /.test(l)).join('\n');
	for (const n of ['01-stranglethorn-vale', '03-feralas', '05-the-hinterlands', '06-azshara']) {
		for (const d of ['Uldaman', 'Maraudon', 'Sunken Temple']) assert.ok(!new RegExp(`run the ${d} dungeon`).test(tipsOf(n)), `${n}: no "run the ${d} dungeon" tip`);
	}
	assert.ok(/run the Zul'Farrak dungeon/.test(tipsOf('03-feralas')), "03 still offers Zul'Farrak, run in 40-50/04");
});

test('Horde 40-50/04: the Slag Pit plans come with the gorge sweep and go back on the first Thorium Point return (0.4.0 route audit)', { skip }, () => {
	const list = goals(H40('04-tanaris'));
	const plans = at(list, 'the Secret Plans (7722)', (g) => g.t === 'collect' && g.quest === 7722);
	const incendosaurs = at(list, 'the Incendosaurs (7727)', (g) => g.t === 'kill' && g.quest === 7727);
	assert.equal(list[plans].s, list[incendosaurs].s, 'the plans are on the sweep step with the Incendosaurs');
	const flux = at(list, 'turnin 7722', is('turnin', 7722));
	const fat = at(list, 'turnin 7723', is('turnin', 7723));
	assert.equal(list[flux].s, list[fat].s, 'What the Flux? is handed in on the first Thorium Point return');
});

test('Horde 40-50/06: Stonard flies straight to Booty Bay, and Nimboya is passed on the way to the Grom\'gol zeppelin (0.4.0 route audit)', { skip }, () => {
	const list = goals(H40('06-azshara'));
	const flights = list.filter(({ goal }) => goal.t === 'fly').map(({ goal }) => goal.location);
	assert.deepEqual(flights.slice(0, 2), ['Booty Bay', "Grom'gol"], 'Stonard -> Booty Bay, then Booty Bay -> Grom\'gol');
	const seahorn = at(list, 'turnin 608', is('turnin', 608));
	const nimboya = at(list, 'turnin 2932', is('turnin', 2932));
	const zeppelin = at(list, 'the zeppelin to Orgrimmar', (g) => g.t === 'goto' && /Zeppelin to Orgrimmar/.test(g.label || g.text || ''));
	assert.ok(seahorn < nimboya && nimboya < zeppelin, 'Booty Bay, then Nimboya, then the zeppelin');
});

// Since the 0.4.0 audit the Orgrimmar stop after Feralas opens 40-50/03 (the flight from Shen'dralas lands there).
test('Horde 40-50/06: A Grim Discovery is handed in once, on the Orgrimmar stop after Feralas, not asked for again in Orgrimmar', { skip }, () => {
	assert.ok(goals(H40('03-feralas')).some(({ goal }) => is('turnin', 2976)(goal)), '03 hands it to Belgrom');
	assert.ok(!goals(H40('06-azshara')).some(({ goal }) => is('turnin', 2976)(goal)), '06 has no second hand-in');
});

// g4dz1n4's report (#2460): A Meeting with the Master is no longer a quest on Forever (Sanath Lim-yo's teleport is
// free). The Alliance guide left it out; the Horde Azshara guide asked for it too, with a feather hunt.
test('Horde 40-50/06: no Meeting with the Master or its feathers at Valormok (#2460)', { skip }, () => {
	const list = goals(H40('06-azshara'));
	assert.ok(!list.some(({ goal }) => goal.quest === 3381), 'A Meeting with the Master is not in the guide');
	assert.ok(list.some(({ goal }) => goal.t === 'getfp' && /Valormok/.test(goal.location || goal.name || JSON.stringify(goal))), "Valormok's flight path is still learnt");
	const rf = JSON.parse(fs.readFileSync(path.join(ROOT, 'data', 'route-fixes.json'), 'utf8')).overrides;
	assert.ok(rf.skip.some((e) => e.q === 3381 && e.faction === 'Horde' && e.issue === '#2460'), 'the route fixes leave it out for the Horde');
});

// Ice's report (Discord): Witch Doctor Unbagwa's gorilla waves for Stranglethorn Fever come back to back, then Mokk,
// and were hard alone. The step that hands him the fangs (Horde 40-50/02's Grom'gol stop since the 0.4.0 audit) warns
// before it starts.
test('Horde 40-50/02: the Stranglethorn Fever waves step warns of three back-to-back gorilla waves and Mokk', { skip }, () => {
	const list = goals(H40('02-feralas'));
	const hand = list[at(list, 'turnin 349', is('turnin', 349))];
	const text = [hand.step.note, hand.step.tip].flat().filter(Boolean).join(' ');
	assert.match(text, /Careful: three waves of gorillas/, 'the Careful tip on the hand-in step');
	assert.match(text, /a friend makes it easy/, 'it says a friend makes it easy');
	const fixes = JSON.parse(fs.readFileSync(path.join(ROOT, 'data', 'guide-fixes.json'), 'utf8')).fixes;
	assert.ok(fixes.some((f) => f.at && f.at.quest === 349 && f.at.goal === 'turnin' && /three waves of gorillas/.test(f.tip || '')), 'and its record');
});

test('Horde 40-50/02: a character who knows Gadgetzan flies there instead of Freewind Post (#1976)', { skip }, () => {
	// 30-40/02 learns Gadgetzan's flight path beside the Shimmering Flats; each way to Freewind Post has its twin.
	const steps = compiled(H40('02-feralas')).steps;
	const taxi = (st, neg) => (st.when || []).some((p) => p.k === 'taxi' && !!p.neg === neg && p.name === 'Gadgetzan');
	const flies = (st, where) => st.goals.some((g) => g.t === 'fly' && g.location === where);
	const freewind = steps.filter((st) => flies(st, 'Freewind Post')).slice(0, -1); // the last one flies out of Gadgetzan
	assert.ok(freewind.length >= 5, 'the class and race ways to Freewind Post');
	for (const st of freewind) assert.ok(taxi(st, true), `${st.title}: only without Gadgetzan's flight path`);
	assert.equal(steps.filter((st) => flies(st, 'Gadgetzan') && taxi(st, false)).length, freewind.length, 'each has a Gadgetzan twin');
});

// Route feel (0.4.0 audit): flown in to Gadgetzan, the player lands beside Tran'rek, so Gadgetzan's quests come first and
// the raceway after, with no ride back into town; the Freewind Post way keeps the road order (raceway, then the town).
test('Horde 40-50/02: flown in to Gadgetzan, its quests come before the Mirage Raceway', { skip }, () => {
	const steps = compiled(H40('02-feralas')).steps;
	const taxi = (st, neg) => (st.when || []).some((p) => p.k === 'taxi' && !!p.neg === neg && p.name === 'Gadgetzan');
	const has = (t, q) => (st) => st.goals.some((g) => g.t === t && g.quest === q);
	const raceway = steps.findIndex((st) => st.title === 'Mirage Raceway');
	const landed = steps.findIndex(has('turnin', 2864));
	assert.ok(landed >= 0 && landed < raceway, 'Tran\'rek before the raceway');
	assert.ok(taxi(steps[landed], false), 'for those who flew in');
	for (const q of [992, 1690, 1707]) assert.ok(has('accept', q)(steps[landed]), `accept ${q} on landing`);
	const zf = steps.findIndex((st, i) => i < raceway && taxi(st, false) && has('accept', 2865)(st));
	assert.ok(zf > landed && (steps[zf].when || []).some((p) => p.k === 'dungeon' && !p.neg), "the Zul'Farrak pick-ups too, for its runners");
	const back = steps.findIndex((st) => st.title === 'To Gadgetzan');
	assert.ok(back > raceway && taxi(steps[back], true), 'the ride back into town is only for the Freewind Post way');
	assert.ok(steps.findIndex((st, i) => i > raceway && has('turnin', 2864)(st)) > back, 'the Freewind Post way hands in at the town after the raceway');
});

test('Horde 40-50: the steps beside the elites and level 60 roamers the danger gate reviewed warn about them (#1575)', { skip }, () => {
	for (const [n, quest, name] of [['02-feralas', 2975, "Ohk'zi"], ['02-feralas', 2974, 'Namida Grimtotem'], ['03-feralas', 699, 'Methuselah Crab'], ['03-feralas', 3128, 'Vale Screamer']]) {
		const steps = fs.readFileSync(path.join(OFFICIAL_DIR, H40(n)), 'utf8').split(/\n(?=step )/);
		const step = steps.find((t) => new RegExp(`^\\s+(kill|collect) \\d+ quest ${quest}\\b`, 'm').test(t));
		assert.ok(step, `${n}: the objective of ${quest} is in the guide`);
		const tips = step.split('\n').filter((l) => /^\s+tip /.test(l)).join(' ');
		assert.ok(tips.includes(name), `${n}: the ${quest} step names ${name}`);
	}
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
	// The Northspring harpies (48-50) are worked on 40-50/06's Feralas loop at about 51 since the 0.4.0 level tidy:
	// the yetis come on the ride back from the coast, Talo's quest is taken here and handed in there.
	const vale = at(list, 'talk 8612 quest 3520', (g) => g.t === 'talk' && g.quest === 3520);
	const yetis = at(list, 'collect 18947 quest 7734', (g) => g.t === 'collect' && g.item === 18947);
	const turnin = at(list, 'turnin 7734', is('turnin', 7734));
	assert.ok(vale < yetis && yetis < turnin, 'Rogue Vale, Rage Scar yetis, then Mojache');
	assert.ok(!list.some(({ goal }) => goal.quest === 3063 && goal.t !== 'accept'), 'Talo\'s harpies are only taken here');
	const az = goals('forever/horde/40-50/06-azshara.guide');
	assert.ok(at(az, 'kill 5366 quest 3063', (g) => g.t === 'kill' && g.quest === 3063) < at(az, 'turnin 3063', is('turnin', 3063)), 'the harpies and Talo on 06\'s Feralas loop');
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


// Final route review, Horde 40-60: the Aged Gorilla Sinew drops from the Mistvale gorillas whose fangs Unbagwa wants,
// not on the Wild Shore; and the guide opened with a vendor step titled Booty Bay while still in Ratchet and a note
// about Tarren Mill, both carried over from the 30-40 guide's last Booty Bay stop.
test('forever/horde/40-50/01-stranglethorn-vale.guide: final review: the sinew with the gorilla fangs, no stray vendor or Tarren Mill note', { skip }, () => {
	const list = goals('forever/horde/40-50/01-stranglethorn-vale.guide');
	const sinew = list[at(list, 'collect 3862', (g) => g.t === 'collect' && g.item === 3862)];
	assert.equal(sinew.s, list[at(list, 'collect 2799', (g) => g.t === 'collect' && g.item === 2799)].s, 'with the gorilla fangs');
	// The Bloodsail charts (3920) are looted on 40-50/03's Wild Shore stop since the 0.4.0 level tidy.
	assert.ok(!list.some(({ goal }) => goal.t === 'collect' && goal.item === 3920), 'not with the Bloodsail charts');
	const arrive = at(list, 'fly Booty Bay', (g) => g.t === 'fly' && /Booty Bay/.test(JSON.stringify(g)));
	assert.ok(!list.slice(0, arrive).some(({ goal }) => goal.t === 'vendor'), 'no vendor before the flight to Booty Bay (from Kargath since the Horde 30-40 re-order)');
	assert.ok(!list.some(({ goal }) => goal.t === 'note' && /Tarren Mill/.test(goal.text || goal.note || '')), 'no note about the next guide flying to Tarren Mill');
});

// Final route review, Horde 40-60: Zukk'ash Report is ready on the Orgrimmar stop after the Feralas guide, which
// passes Zilzibin Drumlore; it was carried to the Azshara guide's Orgrimmar stop. Since the 0.4.0 audit that stop opens
// 40-50/03 (the flight from Shen'dralas lands in Orgrimmar).
test('forever/horde/40-50/03-feralas.guide: final review: Zukk\'ash Report on the Orgrimmar stop after Feralas', { skip }, () => {
	const list = goals('forever/horde/40-50/03-feralas.guide');
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

test('The Hinterlands (Horde 48): Thorium Point flies straight to Tarren Mill, no stop at Hammerfall (#1191)', { skip }, () => {
	const list = goals('forever/horde/40-50/05-the-hinterlands.guide');
	const flights = list.filter(({ goal }) => goal.t === 'fly').map(({ goal }) => goal.location);
	assert.equal(flights[0], 'Tarren Mill');
	assert.ok(!flights.includes('Hammerfall'));
});

// --- Final route review before 0.3.5, Horde 40-60 (2026-11-08) ---

// Stranglethorn Vale 39-43 starts at Kargath since the 30-40 rework: it flew to Booty Bay, on to Grom'gol for
// Kin'weelay, the Jungle Stalkers and Mok'thardin, and back to Booty Bay. Now Kargath flies to Grom'gol first and on to
// Booty Bay: one flight less. The zone-entry arrow that pointed 1,000 yd past the Bloodsail cove is gone too.
test('forever/horde/40-50/01-stranglethorn-vale.guide: final review: Grom\'gol before Booty Bay on the flight from Kargath', { skip }, () => {
	const list = goals('forever/horde/40-50/01-stranglethorn-vale.guide');
	const cove = at(list, 'turnin 595', is('turnin', 595));
	// 0.4.0 audit (R17): the classes the Undercity trains fly Kargath to the Undercity and take the zeppelin to Grom'gol;
	// Hunters, Shamans and Druids fly Kargath to Grom'gol. Either way two flights before the cove, the second to Booty Bay.
	for (const cls of ['WARRIOR', 'MAGE', 'HUNTER', 'SHAMAN', 'DRUID']) {
		const flights = list.slice(0, cove).filter(forClass(cls)).filter(({ goal }) => goal.t === 'fly').map(({ goal }) => goal.location);
		assert.equal(flights.length, 2, `${cls}: two flights before the cove: ${flights}`);
		assert.equal(flights[1], 'Booty Bay', `${cls}: the second flight goes to Booty Bay`);
	}
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
	const groups = JSON.parse(fs.readFileSync(path.join(ROOT, 'data', 'route-fixes.json'), 'utf8')).deliberate.group;
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
	for (const [t, q] of [['turnin', 8365], ['turnin', 2873], ['turnin', 2875], ['turnin', 8366]]) {
		const i = at(fer, `${t} ${q}`, is(t, q));
		assert.ok(i > cove && i < gadgetzan, `${t} ${q} between Lost Rigger Cove and Gadgetzan`);
	}
	// 0.3.7 flow pass: Yeh'kinya's Screecher Spirits is taken on the first port stop, where the route passes her
	assert.ok(at(fer, 'accept 3520', is('accept', 3520)) < cove, 'accept 3520 on the first Steamwheedle Port stop');
	const sw = goals('forever/horde/40-50/03-feralas.guide');
	assert.ok(!sw.some(({ goal }) => goal.map === 1446), 'no Tanaris stop in the 45-47 guide');
	const fly = sw.filter(({ goal }) => goal.t === 'fly').map(({ goal }) => goal.location);
	assert.ok(fly.includes('Camp Mojache') && !fly.includes('Gadgetzan'), 'Brackenwall flies to Camp Mojache');
	const pairs = JSON.parse(fs.readFileSync(path.join(ROOT, 'data', 'route-fixes.json'), 'utf8')).overrides.pairs;
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

// Final route review, Horde 40-50 (0.3.6): Zilzibin Drumlore stands in the Drag (his quests say so), not the Valley
// of Spirits; the Orgrimmar stop after Feralas goes Cleft, Drag, Valley of Honor from the flight master. And 40-50/06
// rides through Orgrimmar to the flight master on the way to Azshara with Rise of the Silithid (32) and Ripple
// Delivery (81) ready: both are handed in then, before the top-up to 50, not on the stop after Azshara.
test('Horde 45-50 Orgrimmar: Zilzibin in the Drag, and the ready reports handed in on the way to Azshara', { skip }, () => {
	const src = (f) => fs.readFileSync(path.join(OFFICIAL_DIR, f), 'utf8');
	for (const f of ['forever/horde/40-50/02-feralas.guide', 'forever/horde/40-50/06-azshara.guide']) assert.doesNotMatch(src(f), /Zilzibin Drumlore, Valley of Spirits/, f);
	// Since the 0.4.0 audit the Orgrimmar stop after Feralas opens 40-50/03 (the flight from Shen'dralas lands there).
	const fer = goals('forever/horde/40-50/03-feralas.guide');
	const i = (what, pred) => at(fer, what, pred);
	assert.ok(i('turnin 3121', is('turnin', 3121)) < i('turnin 7732', is('turnin', 7732)) && i('turnin 7732', is('turnin', 7732)) < i('turnin 2976', is('turnin', 2976)), 'Cleft, Drag, Valley of Honor');
	const az = goals('forever/horde/40-50/06-azshara.guide');
	const loh = az[at(az, 'accept 5535', is('accept', 5535))].s;
	for (const q of [32, 81]) {
		const first = az[at(az, `turnin ${q}`, is('turnin', q))];
		assert.ok(first.s < loh, `${q} handed in before Azshara`);
		assert.ok(first.step.when.some((p) => p.k === 'onquest' && !p.neg && p.q.includes(q)), `${q}: only while carried`);
	}
});

// Travel sweep (0.3.6): Horde 40-50/02-feralas's Warlock step to Ratchet for the Felsteed put its "Orgrimmar flight
// master" goto (45.3,63.7, Orgrimmar's coordinates) under `zone The Barrens`, so the arrow led Warlocks from Orgrimmar
// to a spot by Camp Taurajo before the flight to Ratchet.
test('forever/horde/40-50/02-feralas.guide: the Felsteed trip starts at Orgrimmar\'s flight master', { skip }, () => {
	const list = goals('forever/horde/40-50/02-feralas.guide');
	const strahad = at(list, 'turnin 3631', is('turnin', 3631));
	const fm = list.slice(0, strahad).reverse().find(({ goal }) => goal.t === 'goto' && goal.x === 45.3 && goal.y === 63.7);
	assert.ok(fm, 'a goto to the flight master before Strahad');
	assert.equal(fm.goal.map, 1454, 'on the Orgrimmar map');
});

// Players' recordings (0.3.6, Forever-new quest near the path): Kin'weelay offers Locating the Lost City (95770, 3150 XP) once
// The Gurubashi Legends of Old is handed in on 40-50/01's cauldron stop; the cavern entrance is under the Vile Reef just
// west of Grom'gol (2 recorded people found it within 3 minutes), and Kin'weelay is visited again for the trophy skulls.
test('Horde Stranglethorn 40: Locating the Lost City after the legend, the reef on the way south, handed in with the skulls', { skip }, () => {
	const stv = goals('forever/horde/40-50/01-stranglethorn-vale.guide');
	const legend = at(stv, 'turnin 95748', is('turnin', 95748));
	const acc = at(stv, 'accept 95770', is('accept', 95770));
	assert.equal(stv[acc].s, stv[legend].s, 'taken on the stop that hands the legend in');
	const reef = at(stv, 'the Vile Reef goal', (g) => (g.t === 'goto' || is('complete', 95770)(g)) && g.map === 1434 && Math.abs(g.x - 21.8) < 1 && Math.abs(g.y - 27.6) < 1);
	assert.ok(stv[reef].s > stv[acc].s, 'the cavern entrance under the Vile Reef after the accept');
	assert.ok(stv[reef].step.when.some((p) => p.k === 'onquest' && !p.neg && p.q.includes(95770)), 'only with the quest in the log');
	assert.ok(reef < at(stv, 'kill 687', (x) => x.t === 'kill' && x.npc === 687), 'before the jungle stalkers south of the camp');
	const tin = at(stv, 'turnin 95770', is('turnin', 95770));
	assert.equal(stv[tin].s, stv[at(stv, 'turnin 598', is('turnin', 598))].s, 'handed in with the trophy skulls');
});

// Seam Horde 30-40/40-50 (0.3.6, with the 30-40 owner): Gazlowe in Ratchet gives Goblin Sponsorship part 2 (1180) on
// 30-40/04's stop; its ender Wharfmaster Lozgil and part 3's ender Baron Revilgaz (1181) stand in Booty Bay, so both go
// in on 40-50/01's first Booty Bay stop, beside MacKinley. Part 4 (1182) stays off the loop.
test('Horde Stranglethorn 40: Goblin Sponsorship parts 2 and 3 handed in on the first Booty Bay stop', { skip }, () => {
	const stv = goals('forever/horde/40-50/01-stranglethorn-vale.guide');
	const lozgil = at(stv, 'turnin 1180', is('turnin', 1180));
	const take = at(stv, 'accept 1181', is('accept', 1181));
	const baron = at(stv, 'turnin 1181', is('turnin', 1181));
	const mack = at(stv, 'accept 606', is('accept', 606));
	assert.ok(lozgil < take && take < baron, 'Lozgil, then Revilgaz');
	for (const i of [lozgil, take, baron]) assert.equal(stv[i].s, stv[mack].s, "on MacKinley's Booty Bay stop");
	assert.ok(!stv.some(({ goal }) => is('accept', 1182)(goal)), 'part 4 is not routed');
});

// Final route review (0.3.6): Tanaris Field Sampling (654) runs on a two-hour timer from the moment its power source is
// used. It was started on the first Gadgetzan stop, with Marvon, Scrimshank's hive and OOX-17/TN's optional escort under
// the timer (80-100 minutes); the power source is now used on the way back north, the dunes south of Gadgetzan sampled,
// and the kit handed in on the stop right after.
test('Horde Tanaris 46: Tanaris Field Sampling started after Scrimshank, handed in right after the dunes', { skip }, () => {
	const tan = goals('forever/horde/40-50/04-tanaris.guide');
	const take = at(tan, 'accept 654', is('accept', 654));
	const gear = at(tan, 'collect 8593 (Scrimshank)', (g) => g.t === 'collect' && g.quest === 10);
	const marvon = at(tan, 'turnin 3161', is('turnin', 3161));
	const ox = tan.findIndex(({ goal }) => is('accept', 648)(goal));
	assert.ok(marvon < take && gear < take && ox < take, 'Marvon, the hive and the escort come before the timer starts');
	const sample = tan.findIndex(({ goal }) => goal.t === 'collect' && goal.quest === 654);
	assert.equal(tan[sample].s, tan[take].s, 'sampled on the step that starts it');
	const tin = at(tan, 'turnin 654', is('turnin', 654));
	assert.equal(tan[tin].s, tan[sample].s + 1, 'handed in on the next step');
});

// Horde 40-50/01 (0.3.6): Excelsior (628, 2850 XP) from Drizzlik with the Snapjaw skins on the first
// Booty Bay stop; the Elder Saltwater Crocolisk (level 38 elite, shared spawns) lives on the coast the route walks from
// Zul'Kunda back to Grom'gol, so its skin is an optional goal there and goes in on the next Booty Bay stop.
test('Horde Stranglethorn 40: Excelsior from Drizzlik, the elder crocolisk on the Zul\'Kunda coast, optional', { skip }, () => {
	const stv = goals('forever/horde/40-50/01-stranglethorn-vale.guide');
	const take = at(stv, 'accept 628', is('accept', 628));
	assert.equal(stv[take].s, stv[at(stv, 'turnin 577', is('turnin', 577))].s, 'with the Snapjaw skins');
	const skin = at(stv, 'collect 4105', (g) => g.t === 'collect' && g.quest === 628);
	assert.ok(stv[skin].goal.optional, 'the croc may be down: optional');
	assert.equal(stv[skin].s, stv[at(stv, 'collect 2007', (g) => g.t === 'collect' && g.quest === 95748)].s, "on the Zul'Kunda step");
	const tin = at(stv, 'turnin 628', is('turnin', 628));
	assert.ok(tin > skin && stv[tin].goal.optional, 'handed in on the next Booty Bay stop, optional');
	assert.equal(stv[tin].s, stv[at(stv, 'turnin 606', is('turnin', 606))].s, "on Shaky Phillipe's stop");
});

// Hand-in order sweep (0.3.6, Horde 40-60): talk goals are taken in written order. On 40-50/03's Undercity stop Zinge's
// errand runs Zinge -> Alessandro Luca -> Zinge, and Keeper Bel'dugur (728) stands between Luca and Zinge, so he is
// visited on the way back instead of after a second walk.
test('Horde Undercity 45: Yagyin\'s Digest to Bel\'dugur between Luca and Zinge', { skip }, () => {
	const list = goals('forever/horde/40-50/03-feralas.guide');
	const luca = at(list, 'turnin 232', is('turnin', 232));
	const bel = at(list, 'turnin 728', is('turnin', 728));
	const zinge = at(list, 'turnin 238', is('turnin', 238));
	assert.ok(luca < bel && bel < zinge && list[bel].s === list[luca].s && list[zinge].s === list[luca].s, 'Luca, Bel\'dugur, Zinge on one stop');
});

// Flow (0.3.6, Horde 40-50/03): the solo top-up that stands in for Mok'Morokk's group challenge was written after the
// Brood of Onyxia hand-in at Brackenwall, but it grinds the Firemane scouts on the Wyrmbog's northern edge: a ride
// back south and north again (about 1,200 yd each way). It now comes right after the eggs, in the Wyrmbog, before the
// ride back, with its level lowered by the hand-in's 4850 XP.
test('Horde Dustwallow 45: the solo top-up in the Wyrmbog before riding back to Brackenwall', { skip }, () => {
	const list = goals('forever/horde/40-50/03-feralas.guide');
	const eggs = at(list, 'interact 20359', (g) => g.t === 'interact' && g.quest === 1172);
	const grind = list.findIndex(({ goal }) => goal.t === 'level' && goal.grind === 4329);
	const tin = at(list, 'turnin 1172', is('turnin', 1172));
	assert.ok(eggs < grind && grind < tin, 'eggs, top-up, then Brackenwall');
	assert.equal(list.filter(({ goal }) => goal.t === 'level' && goal.grind === 4329).length, 1, 'one top-up');
	assert.ok((list[grind].step.when || []).some((p) => p.k === 'group' && p.neg), 'only for solo players');
});

// Seam Horde 30-40/40-50 (0.3.6, with the 30-40 owner): Baron Revilgaz's Goblin Sponsorship part 5 (1183, taken on
// Horde 30-40/03's second Booty Bay stop) goes to Pozzik on 40-50/02's Mirage Raceway stop; The Eighteenth Pilot
// (1186) is a word with Razzeric beside him. Razzeric's Tweaking (1187) sends you to south Tanaris and back: left out.
test('Horde Raceway 43: Goblin Sponsorship to Pozzik and The Eighteenth Pilot on the Raceway stop', { skip }, () => {
	// Since the Horde 0.4.0 audit (round 2) Goblin Sponsorship part 4 (1182) is left out of the solo route, so its
	// parts 5 and 6 (1183 to Pozzik, 1186 to Razzeric) are not routed either.
	const fl = goals('forever/horde/40-50/02-feralas.guide');
	for (const q of [1183, 1186, 1187]) assert.ok(!fl.some(({ goal }) => goal.quest === q), `${q} is not routed`);
	const rf = JSON.parse(fs.readFileSync(path.join(ROOT, 'data', 'route-fixes.json'), 'utf8')).overrides;
	assert.ok(rf.skip.some((e) => e.q === 1182 && e.faction === 'Horde'), 'a route-fix skip leaves out 1182');
});

// 0.4.0: the Riverglades are the Horde route after Stranglethorn Vale & Swamp of Sorrows (the guide ends at the
// Harborage, about 43): Stonard flies to Kargath, known since the Badlands, and the ride goes in through Twilight's
// Shroud; the boat from Tanaris is for a character without Kargath's flight path (R17r). The Badlands no longer
// offer the zone as a route choice.
test('Riverglades (Horde route): after Stranglethorn Vale, flown in from Stonard by Kargath, the boat only without its flight path', () => {
	const steps = rivergladesSteps(RIVERGLADES_HORDE);
	const header = steps[0];
	assert.ok(anyLine(header, /^guide forever\/horde\/40-50\/01b-riverglades$/), 'a guide of the Horde route');
	assert.ok(anyLine(header, /^next forever\/horde\/40-50\/02-feralas$/), 'Feralas & Tanaris next');
	assert.ok(!anyLine(header, /^(pitch|pro|con) /), 'no route-choice card copy: it is the route');
	const H = (n) => fs.readFileSync(path.join(ROOT, 'guides', 'forever', 'horde', n), 'utf8').split('\n');
	assert.deepEqual(H('30-40/06-badlands.guide').filter((l) => l.startsWith('next ')), ['next forever/horde/40-50/01-stranglethorn-vale'], 'the Badlands offer no choice');
	assert.deepEqual(H('40-50/01-stranglethorn-vale.guide').filter((l) => l.startsWith('next ')), ['next forever/horde/40-50/01b-riverglades']);
	const fly = steps.findIndex((l) => anyLine(l, /^\s+fly "Kargath"/));
	assert.ok(fly > 0 && anyLine(steps[fly], /^\s+when zone "Swamp of Sorrows"/) && anyLine(steps[fly], /^\s+when taxi "Kargath"/), 'from the Swamp, the Kargath flight');
	const foot = steps.findIndex((l) => anyLine(l, /^\s+when taxi "Kargath"/) && anyLine(l, /^\s+goto /) && !anyLine(l, /^\s+fly /));
	assert.ok(foot > fly, 'then a step rides in from Kargath');
	for (const re of [/^\s+fly "Freewind Post"/, /^\s+getfp "Gadgetzan"/, /Boat to Powderfuse Port/]) {
		const i = steps.findIndex((l) => anyLine(l, re));
		assert.ok(i > 0 && anyLine(steps[i], /^\s+when !taxi "Kargath"/), `${re}: only for characters without Kargath's flight path`);
	}
	const sleebo = steps.map((l, i) => (anyLine(l, /^\s+accept 96063\b/) ? i : -1)).filter((i) => i >= 0);
	assert.equal(sleebo.length, 2, "Gaseous Gold is taken on either way in");
	const rogmar = steps.findIndex((l) => anyLine(l, /^\s+getfp "Rog'mar"/));
	assert.ok(sleebo[1] > rogmar && anyLine(steps[sleebo[1]], /^\s+when available 96063\b/), "the foot way takes it after Rog'mar, once");
});

// The route's stops on either side of the zone carry its errands, each recorded taken and handed in by players:
// Report to Rog'mar (95141) from Commander Aggro'gosh on Stranglethorn's last Grom'gol stop goes to Krom'rosh; On
// the Other Side (95033, Tan'jani) and Shipping and Handling (95296, Friz) go to Camp Mojache and Steamwheedle Port,
// both on the Feralas & Tanaris guide's way. Twice Misplaced Trust (97332) follows Lozgil's two Stranglethorn quests,
// which the route takes since the Horde 0.4.0 audit (round 2).
test("Riverglades (Horde route): the zone's errands are taken and handed in at stops the route makes", () => {
	const H = (n) => rivergladesSteps(path.join(ROOT, 'guides', 'forever', 'horde', '40-50', n));
	const stepOf = (steps, verb, q) => steps.find((l) => anyLine(l, new RegExp(`^\\s+${verb} ${q}\\b`)));
	const stv = H('01-stranglethorn-vale.guide'), glades = rivergladesSteps(RIVERGLADES_HORDE), feralas = H('02-feralas.guide');
	for (const [q, from, to, at] of [[95141, stv, glades, /^step (Grom'gol Base Camp|Rog'mar)$/],
		[95033, glades, feralas, /^step (Rog'mar|Camp Mojache)$/], [95296, glades, feralas, /^step (Powderfuse Port|Steamwheedle Port)$/]]) {
		const take = stepOf(from, 'accept', q), give = stepOf(to, 'turnin', q);
		assert.ok(take && at.test(take[0]), `${q} taken: ${take && take[0]}`);
		assert.ok(give && at.test(give[0]), `${q} handed in: ${give && give[0]}`);
	}
	// Since the Horde 0.4.0 audit (round 2) the route does Anything of Value and Zimmix's Great Escape in the 30-40
	// Stranglethorn guide, so Lozgil's Twice Misplaced Trust (97332) is taken on the first Booty Bay stop and handed to
	// Wharfmaster Whizzbuzz on the first Powderfuse Port stop.
	const tw = stepOf(stv, 'accept', 97332), tg = stepOf(glades, 'turnin', 97332);
	assert.ok(tw && /^step Booty Bay$/.test(tw[0]), `Twice Misplaced Trust taken in Booty Bay: ${tw && tw[0]}`);
	assert.ok(tg && /^step Wharfmaster Whizzbuzz$/.test(tg[0]), `and handed in to Whizzbuzz: ${tg && tg[0]}`);
});

// Clugfist offers Might Makes Right and Unworthy Champion (95424, 95425) only after Land of Giants (95420): all 17
// recorded characters who took them had handed it in. Land of Giants comes from Tran'gul after Spread the Word
// (95418), Clubtoe's word once Twilight No More! (95427, Chogg'Zac) is done, after Tran'gul's and Clubtoe's
// Sunnyglade quests. So the guide does Sunnyglade whole, Rog'mar, then Bolder'ok, as those players did; Clugfist's
// Decree, the Ring and Da'grosh's camp follow from Might Makes Right. Chogg'Zac is no group choice: the chain
// hangs on him.
test("Riverglades (Horde route): Sunnyglade and Land of Giants come before Clugfist's quests in Bolder'ok", () => {
	const lines = fs.readFileSync(RIVERGLADES_HORDE, 'utf8').split('\n').map(codeOf);
	const first = (verb, q) => lines.findIndex((l) => new RegExp(`^\\s+${verb} ${q}\\b`).test(l));
	const order = [['turnin', 94672], ['turnin', 94680], ['turnin', 94727], ['turnin', 95601], ['turnin', 95602], ['turnin', 95427], ['turnin', 95418], ['turnin', 95420], ['accept', 95424], ['accept', 95425], ['accept', 95428], ['accept', 94744]];
	const at = order.map(([v, q]) => first(v, q));
	order.forEach(([v, q], i) => assert.ok(at[i] >= 0, `${v} ${q} is in the guide`));
	for (let i = 1; i < at.length; i++) assert.ok(at[i - 1] < at[i], `${order[i - 1].join(' ')} before ${order[i].join(' ')}`);
	const steps = rivergladesSteps(RIVERGLADES_HORDE);
	const chogg = steps.find((l) => anyLine(l, /^\s+collect 265750\b/));
	assert.ok(chogg && !anyLine(chogg, /^\s+when group\b/), "Chogg'Zac is on the route, with a Careful tip");
	const last = steps.find((l) => anyLine(l, /^\s+accept 94965\b/));
	assert.ok(last && anyLine(last, /^\s+when turnedin 94737\b/), "the Ring's last bouts wait for Gobam's errands");
});

// #2199 (Searing Gorge): Fiery Menace!'s spiders (npc 5858) are Searing Lava Spiders in Forever; players' quest log
// reads "Searing Lava Spider slain" and every recorded objective tick is a kill of 5858. The Horde gorge step names
// them so, in the guide and its seed.
test('#2199: the Horde Searing Gorge step names the Searing Lava Spiders, in the guide and its seed', () => {
	const rel = 'forever/horde/40-50/04-tanaris.guide';
	for (const file of [path.join(OFFICIAL_DIR, rel), path.join(ROOT, 'forge', 'seed', 'guides', rel)]) {
		const text = fs.readFileSync(file, 'utf8');
		assert.match(text, /\n\s+tip The Searing Lava Spiders roam the plateaus and lava pools in the south-west of the gorge\.\n/, `${file}: the tip names them`);
		assert.doesNotMatch(text, /Greater Lava Spider/, `${file}: no Greater Lava Spiders`);
	}
});

// #2211 (Sekyno, Scourge Warrior 41): the Bloodsail Charts and Orders (604) also lie in the rowboat beside the larger
// camp on the Wild Shore; players' recordings loot them at the data's three spots, two of them by that camp's shore.
test("#2211: Stranglethorn Vale's Wild Shore step says the charts and orders also lie in the rowboat, in the guide and its seed", () => {
	// The Wild Shore is fought on 40-50/02's Grom'gol stop at about 45 since the 0.4.0 audit.
	const rel = 'forever/horde/40-50/02-feralas.guide';
	for (const file of [path.join(OFFICIAL_DIR, rel), path.join(ROOT, 'forge', 'seed', 'guides', rel)]) {
		const step = fs.readFileSync(file, 'utf8').split(/\n(?=step )/).find((s) => s.startsWith('step The Wild Shore\n'));
		assert.ok(step, `${file}: a Wild Shore step`);
		assert.match(step, /the charts and the orders lie in their tents and in the rowboat beside the larger camp/, `${file}: the rowboat`);
	}
});

// #2326 (Stompsville): Screecher Spirits (3520) counts a Screecher Spirit that rises when Yeh'kinya's Bramble is used on
// a dead screecher, and the spirit is friendly: players' recordings (10 people) tick each spirit right after the
// bramble's cast (12699) with the spirit's own window open, and nobody ever killed one; the game's data credits the
// objective on the spirit's gossip. Feralas (Horde 40-50) told the player to kill the spirit. The goal is a talk now,
// after the bramble's use, and the tip says so.
test('#2326: Feralas (Horde): the Screecher Spirits are talked to, after the bramble', { skip }, () => {
	const list = goals('forever/horde/40-50/03-feralas.guide');
	const use = at(list, 'use 10699', (g) => g.t === 'use' && g.item === 10699 && g.quest === 3520);
	const talk = at(list, 'talk 8612', (g) => g.t === 'talk' && g.npc === 8612 && g.quest === 3520);
	assert.ok(use < talk && list[use].step === list[talk].step, 'the bramble first, then the spirit, in one step');
	assert.ok(!list.some(({ goal }) => goal.t === 'kill' && goal.npc === 8612), 'no kill of a Screecher Spirit');
	const tip = [list[talk].step.note, list[talk].step.tip].flat().filter(Boolean).join(' ');
	assert.match(tip, /talk to the spirit that rises/, 'the tip says to talk to it');
});

// Zack (#2394): Water Pouch Bounty asks for 5 Wastewander Water Pouches; the guide asked for 10, so the step never ticked.
test('#2394: Horde Feralas & Tanaris: Water Pouch Bounty counts the quest\'s 5 pouches', { skip }, () => {
	const list = goals('forever/horde/40-50/02-feralas.guide');
	const pouches = list.filter(({ goal }) => goal.t === 'collect' && goal.quest === 1707 && goal.item === 8483);
	assert.ok(pouches.length, 'the pouches are collected');
	for (const { goal } of pouches) assert.equal(goal.count, 5, 'five pouches');
});
