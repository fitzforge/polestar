'use strict';
// Player-reported guide fixes: the Horde 50-60 guides.
// tests/reported/helpers.js says what the cases check and where a new one goes.

const { test } = require('node:test');
const assert = require('node:assert/strict');
const fs = require('node:fs');
const path = require('node:path');
const {
	at, compiled, forClass, goals, is, OFFICIAL_DIR, ROOT, skip, stepTips,
} = require('./helpers');

// #2561's sweep: Horde Silithus' Gadgetzan stop was The Super Egg-O-Matic's
// hand-in alone (2741, at the Egg-O-Matic straight from the bags), for a
// player still carrying the Hippogryph Egg from Azshara. A player loading the
// guide without the egg stood on a hand-in the machine never offers. The step
// shows only with the egg in the bags.
test('forever/horde/50-60/06-silithus.guide: the Egg-O-Matic stop shows only with the Hippogryph Egg in the bags (#2561 sweep)', { skip }, () => {
	const { steps } = compiled('forever/horde/50-60/06-silithus.guide');
	const egg = steps.filter((st) => st.goals.some((g) => g.t === 'turnin' && g.quest === 2741));
	assert.equal(egg.length, 1, 'one Egg-O-Matic hand-in');
	assert.ok(egg[0].goals.find((g) => g.quest === 2741).direct, 'handed in without entering the quest log');
	assert.ok((egg[0].when || []).some((p) => p.k === 'has' && !p.neg && p.item === 8564 && (p.n || 1) === 1), 'shown only with the Hippogryph Egg in the bags');
});
test('forever/horde/50-60/05-eastern-plaguelands.guide: Gaeriyan waits for Meet at the Grave (#2561 sweep)', { skip }, () => {
	// The elixir comes only from Gregan's Evoroot hand-in, gated on the Evoroot since #2561's sweep: a player without
	// it never hands The Videre Elixir to Donova or takes Meet at the Grave, and the Gaeriyan step (drink the elixir)
	// must not hold the route. Not `when has 11243`: drinking it there would drop the step before Gaeriyan.
	const { steps } = compiled('forever/horde/50-60/05-eastern-plaguelands.guide');
	const st = steps.find((s) => s.goals.some((g) => g.t === 'use' && g.item === 11243));
	assert.ok(st && st.goals.some(is('turnin', 3912)), 'the elixir is drunk on the Gaeriyan step');
	const when = st.when || [];
	assert.ok(when.some((p) => p.k === 'onquest' && !p.neg && [].concat(p.q).includes(3912)), 'only with Meet at the Grave in the log');
});

// #1149 (Corin's Crossing): the step's goto pointed at Nathanos's camp (26.5,74.7), far west of the town where
// Living Rot drops. The town's point lives in the seed now, so every Forge build writes it.
test("Fitz's report (#1149): Eastern Plaguelands' Corin's Crossing step leads to the town, in the guide and its seed", () => {
	const rel = 'forever/horde/50-60/05-eastern-plaguelands.guide';
	for (const file of [path.join(OFFICIAL_DIR, rel), path.join(ROOT, 'forge', 'seed', 'guides', rel)]) {
		const text = fs.readFileSync(file, 'utf8');
		const step = text.split(/\n(?=step )/).find((s) => s.startsWith("step Corin's Crossing\n"));
		assert.ok(step, `${file}: a Corin's Crossing step`);
		assert.match(step, /\n\s+goto 52\.3,58\.2 "Corin's Crossing" live\n/, `${file}: the goto is the town`);
		assert.doesNotMatch(step, /goto 26\.5,74\.7/, `${file}: not Nathanos's camp`);
	}
});

// Flow review, Horde 40-60 (#1166): Salfa stands where Timbermaw Hold's tunnel comes out; Speak to Salfa was carried
// to Everlook and back west.
test('forever/horde/50-60/03-winterspring.guide: flow re-order: Salfa where the tunnel comes out', { skip }, () => {
	const list = goals('forever/horde/50-60/03-winterspring.guide');
	const salfa = at(list, 'turnin 8465', is('turnin', 8465));
	assert.ok(salfa < at(list, 'accept 3783', is('accept', 3783)), 'before Everlook');
	// Winterfall Activity (8464: the village's Shamans and Ursas 56-58) waits for the last Winterspring loop since the
	// 0.4.0 level tidy: taken from Salfa there, not here.
	assert.ok(!list.some(({ goal }) => goal.quest === 8464), 'no Winterfall Activity at 55');
	const fw = goals('forever/horde/50-60/07-felwood.guide');
	assert.equal(fw[at(fw, 'accept 8464', is('accept', 8464))].goal.npc, 11556, 'taken from Salfa in 07');
});

// Flow review, Horde 40-60 (#1166): the flight lands in Ratchet, so Liv and Islen come first and the ride north ends
// at Dokimi in the Crossroads; it rode north to the Crossroads and back to Ratchet.
test('forever/horde/50-60/04-azshara.guide: flow re-order: Ratchet first, then the crates at the Crossroads', { skip }, () => {
	const list = goals('forever/horde/50-60/04-azshara.guide');
	const crates = at(list, 'turnin 91899', is('turnin', 91899));
	assert.ok(at(list, 'turnin 4147', is('turnin', 4147)) < crates && at(list, 'turnin 5158', is('turnin', 5158)) < crates, 'Liv and Islen before the crates');
});

// Flow review, Horde 40-60 (#1166): Corin's Crossing on the ride south from Quel'Lithien Lodge, all three hand-ins to
// Nathanos in one visit (it rode from the Marris Stead to the crossing and back); The Everlook Report at the Bulwark on
// the way in (it waited two guides for another Bulwark stop).
test('forever/horde/50-60/05-eastern-plaguelands.guide: flow re-order: Corin\'s Crossing before Nathanos, The Everlook Report at the Bulwark', { skip }, () => {
	const list = goals('forever/horde/50-60/05-eastern-plaguelands.guide');
	const rot = at(list, 'collect 15447', (g) => g.t === 'collect' && g.item === 15447);
	// Since the 0.4.0 level tidy The Ranger Lord's Behest (6133, Rangers 59-60) is handed in on the Silithus guide's second
	// Plaguelands ride; To Kill With Purpose and Un-Life's Little Annoyances go in here on one visit.
	const nathanos = at(list, 'turnin 6022', is('turnin', 6022));
	assert.ok(rot < nathanos, 'Corin\'s Crossing before Nathanos');
	assert.equal(list[at(list, 'turnin 6042', is('turnin', 6042))].s, list[nathanos].s, 'Un-Life\'s Little Annoyances on the same visit');
	assert.ok(goals('forever/horde/50-60/06-silithus.guide').some(({ goal }) => is('turnin', 6133)(goal)), 'the Rangers on the Silithus guide');
	// Since 0.3.7 the Bulwark and Felstone Farm close 50-60/04 (fresh start: 05 opens at Light's Hope Chapel's flight).
	const az = goals('forever/horde/50-60/04-azshara.guide');
	assert.ok(at(az, 'turnin 6029', is('turnin', 6029)) < at(az, 'turnin 5229', is('turnin', 5229)), 'the Bulwark on the way to Felstone Field');
	assert.ok(!goals('forever/horde/50-60/06-silithus.guide').some(({ goal }) => is('turnin', 6029)(goal)), 'not carried to the Silithus guide');
});

// Flow review, Horde 40-60 (#1166): Chromie offers Counting Out Time on A Matter of Time's hand-in and the lockboxes are
// around her inn; it waited for a return to Chromie later in the guide.
test('forever/horde/50-60/06-silithus.guide: flow re-order: Counting Out Time on the first Chromie visit', { skip }, () => {
	const list = goals('forever/horde/50-60/06-silithus.guide');
	assert.equal(list[at(list, 'accept 4972', is('accept', 4972))].s, list[at(list, 'turnin 4971', is('turnin', 4971))].s, 'taken on A Matter of Time\'s hand-in');
	assert.ok(at(list, 'collect 12638', (g) => g.t === 'collect' && g.item === 12638) < at(list, 'turnin 5098', is('turnin', 5098)), 'the lockboxes before the Bulwark');
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
	// Pawn Captures Queen is taken on 50-60/05's Gadgetzan stop since the 0.4.0 level tidy, the visit before its Un'Goro loop.
	const ep = goals('forever/horde/50-60/05-eastern-plaguelands.guide');
	const queen = at(ep, 'accept 4507', is('accept', 4507));
	assert.ok(!ep[queen].step.goals.some((g) => g.t === 'note' && /Skip it/.test(g.text || '')), 'no skip note beside the accept');
});

// Final route review, Horde 40-60: in from Tarren Mill at Sorrow Hill, the order rode north to Mulgris and back south
// to Marlene; Kirsta's Scarlets were an "along the way" list; the Bloodvenom flight path sat in the step for the
// optional Blood Red Key, which players without the key skip.
test('forever/horde/50-60/02-felwood.guide: final review: Marlene before Mulgris, no along list, the flight path at Bloodvenom Post', { skip }, () => {
	const file = 'forever/horde/50-60/02-felwood.guide';
	const list = goals(file);
	// Since the 0.3.6 flow pass Marlene and Chromie open 50-60/05 with the rest of Darrowshire: 02 opens at Mulgris.
	const ep = goals('forever/horde/50-60/05-eastern-plaguelands.guide');
	assert.ok(ep.some(({ goal }) => is('turnin', 5152)(goal)), 'Marlene in the Eastern Plaguelands guide');
	assert.ok(!list.some(({ goal }) => is('turnin', 5152)(goal)), 'not here');
	// (Since the 0.4.0 level tidy a top-up to 53 for the wolves, only below 53, comes before him.)
	assert.equal(list.find(({ goal }) => goal.quest).goal.quest, 4984, 'Mulgris first');
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
	for (const t of ['accept', 'complete']) assert.ok(list[at(list, `${t} 3786`, is(t, 3786))].goal.optional, `${t} 3786 is optional`);
	// Morrowgrain to Thunder Bluff is handed in on the spot (#1699): its ten Morrowgrain are an optional collect.
	assert.ok(list[at(list, 'collect 11040', (g) => g.t === 'collect' && g.item === 11040 && g.count === 10)].goal.optional, 'the Morrowgrain is optional');
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
	for (const q of [7820, 7821, 7822]) assert.ok(ws[at(ws, `turnin ${q}`, is('turnin', q))].goal.direct, `${q} handed in at Rumstag on the spot`);
	assert.ok(!list.some(({ goal }) => goal.quest === 7820), 'no donation stop in this guide');
	const az = goals('forever/horde/50-60/04-azshara.guide');
	const bulwark = at(az, 'turnin 6029', is('turnin', 6029));
	assert.deepEqual([az[bulwark - 1].goal.t, az[bulwark - 1].goal.map], ['goto', 1420], 'a travel line out of the Undercity before the Bulwark (the end of 50-60/04 since 0.3.7)');
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

// Horde level tidy, round 3 (0.4.0): Kim'jael's "Missing" Equipment (5534, 6,550 XP) was left out because Eldarath
// comes before the base camp. Its rune drops from the Spitelash at the ruins' northern edge, about 800 yd south of
// Kim'jael: taken with Kim'jael Indeed!'s hand-in, the rune there, back to Kim'jael, then Ekkal on the road home.
test("forever/horde/50-60/04-azshara.guide: level tidy: Kim'jael's rune on a short ride from his camp", { skip }, () => {
	const list = goals('forever/horde/50-60/04-azshara.guide');
	const handin = at(list, 'turnin 3601', is('turnin', 3601));
	const accept = at(list, 'accept 5534', is('accept', 5534));
	assert.equal(list[accept].step, list[handin].step, "taken with Kim'jael Indeed!'s hand-in");
	const rune = at(list, 'collect 13815', (g) => g.t === 'collect' && g.item === 13815 && g.quest === 5534);
	const { goal } = list[rune];
	assert.ok(goal.map === 1447 && Math.abs(goal.x - 47.5) < 2 && Math.abs(goal.y - 44.5) < 2, "the Ruins of Eldarath's northern edge");
	const turnin = at(list, 'turnin 5534', is('turnin', 5534));
	assert.ok(rune < turnin && turnin < at(list, 'turnin 86746', is('turnin', 86746)), "back to Kim'jael before Ekkal");
	assert.ok(turnin < at(list, 'turnin 91500', is('turnin', 91500)), 'before Valormok');
});

// Horde level tidy, round 4 (0.4.0): the Blood Red Key drops only in Shadow Hold (Jaedenar Enforcers, Darkweavers,
// Warlocks, Legionnaires, Ulathek), and Arko'narin's cage stands among Legionnaires (55): 50-60/02 at 53 sent a player
// who strayed north into the cave for a hand-in. 50-60/07 clears Shadow Hold at about 59.7: the key is taken and
// handed in there, after A Final Blow's bosses and before Greta.
test('Horde Felwood: A Strange Red Key on the 59-60 Shadow Hold visit, not at 53', { skip }, () => {
	const early = goals('forever/horde/50-60/02-felwood.guide');
	assert.ok(!early.some(({ goal }) => goal.quest === 5202), '02 (about 53) never sends you to the cage');
	const list = goals('forever/horde/50-60/07-felwood.guide');
	const take = at(list, 'accept 5202', is('accept', 5202));
	const cage = at(list, 'turnin 5202', is('turnin', 5202));
	assert.ok(list[take].step.when.some((p) => p.k === 'has'), 'only with the key');
	assert.ok(list[cage].step.when.some((p) => p.k === 'onquest'), 'the cage only with the quest');
	assert.ok(at(list, 'kill 9860', (g) => g.t === 'kill' && g.npc === 9860) < take, 'after the Shadow Hold bosses');
	assert.ok(take < cage && cage < at(list, 'turnin 5242', is('turnin', 5242)), 'handed in before the ride back to Greta');
});

// Horde 50-60 audit (0.4.0): Venom Bottles (2933, level 43) was handed in to Apothecary Lydon at about 52.4, which gives
// 20% of its experience (about 720 XP), and the flight from Kargath landed at Tarren Mill only for it. It is out of
// the route (taken in neither guide); the flight from Kargath goes straight to the Undercity.
test('forever/horde/50-60/01-un-goro-crater.guide: no Tarren Mill landing for Venom Bottles, Kargath flies to the Undercity', { skip }, () => {
	const list = goals('forever/horde/50-60/01-un-goro-crater.guide');
	assert.ok(!list.some(({ goal }) => goal.quest === 2933), 'no Venom Bottles');
	assert.ok(!list.some(({ goal }) => goal.t === 'fly' && goal.location === 'Tarren Mill'), 'no flight to Tarren Mill');
	const kargath = at(list, 'turnin 3822 at Kargath', is('turnin', 3822));
	const next = list.slice(kargath).find(({ goal }) => goal.t === 'fly');
	assert.equal(next && next.goal.location, 'Undercity', 'the next flight after Kargath goes to the Undercity');
});

// Horde 50-60 audit (0.4.0), travel sweep: after the Plaguelands loop the guide flew Light's Hope Chapel -> the Undercity
// and took the zeppelin to Orgrimmar. With the Orgrimmar bind from the Azshara guide kept (no chapel bind), the
// Hearthstone lands at the Orgrimmar flight master instead: about 4 minutes less for every class but Mage. A Mage
// teleports to Orgrimmar anyway and would lose the chapel's two hearths, so only Mages bind at the chapel.
test('forever/horde/50-60/05-eastern-plaguelands.guide: only Mages bind at Light\'s Hope, the rest hearth to Orgrimmar after Carlin', { skip }, () => {
	const list = goals('forever/horde/50-60/05-eastern-plaguelands.guide');
	const binds = list.filter(({ goal }) => goal.t === 'sethome');
	assert.equal(binds.length, 1, 'one bind line');
	assert.equal(binds[0].goal.location, "Light's Hope Chapel");
	for (const cls of ['WARRIOR', 'DRUID', 'PALADIN', 'ROGUE']) assert.ok(!forClass(cls)(binds[0]), `no chapel bind for ${cls}`);
	assert.ok(forClass('MAGE')(binds[0]), 'Mages bind at the chapel');
	const carlin = at(list, 'turnin 5211', is('turnin', 5211));
	const flight = list.findIndex((e, i) => i > carlin && e.goal.t === 'fly');
	assert.ok(['Bloodvenom Post', 'Thunder Bluff'].includes(list[flight].goal.location), 'the next flight leaves from Orgrimmar');
	assert.ok(!list.slice(carlin, flight).some(({ goal }) => goal.t === 'goto' && goal.text === 'Zeppelin to Orgrimmar'), 'no zeppelin');
	assert.ok(!list.some(({ goal }) => goal.t === 'fly' && goal.location === 'Undercity'), 'no flight to the Undercity');
});

// Horde 50-60 audit (0.4.0): Winterfall Activity (8464) is complete at the end of the Winterspring guide and waited for
// the Felwood guide (about 59.7); Salfa stands where Timbermaw Hold's tunnel comes out into Winterspring, which the
// Eastern Plaguelands guide rides out of from Moonglade to Donova Snowden. Handed in there, three levels earlier.
// Since the 0.4.0 level tidy (the village's Shamans and Ursas are 56-58, over the Winterspring guide's 55) Winterfall
// Activity is taken, worked and handed in on the last guide's Winterspring loop (about 59.7): nothing is carried.
test('forever/horde/50-60/07-felwood.guide: Winterfall Activity on the last Winterspring loop, Salfa to Salfa', { skip }, () => {
	for (const n of ['03-winterspring', '05-eastern-plaguelands']) assert.ok(!goals(`forever/horde/50-60/${n}.guide`).some(({ goal }) => goal.quest === 8464), `no Winterfall Activity in ${n}`);
	const fw = goals('forever/horde/50-60/07-felwood.guide');
	const take = at(fw, 'accept 8464', is('accept', 8464));
	const village = at(fw, 'kill 8464', (g) => g.t === 'kill' && g.quest === 8464);
	const hand = at(fw, 'turnin 8464', is('turnin', 8464));
	assert.ok(take < village && village < hand, 'Salfa, the village, Salfa');
	assert.equal(fw[hand].goal.npc, 11556, 'Salfa');
	assert.ok(hand < at(fw, 'turnin 8469', (g) => g.t === 'turnin' && g.quest === 8469), 'Beads for Salfa after it (8469 needs it handed in)');
});


// Danger at the spot (#1575), Horde 50-60 (0.4.0 base): three goals sent the arrow among elites well above the route.
// Each arrow now points where the objective's mobs stand clear of them, and the step names them.
test('Horde 50-60: arrows away from the Blackmaw Thrall, the Hailspite and the Ancient Irontree Walkers, with a warning (#1575)', { skip }, () => {
	for (const [file, quest, oi, x, y, mob] of [
		['forever/horde/50-60/04-azshara.guide', 3505, 2, 56.2, 29.9, /Blackmaw Thrall/],
		['forever/horde/50-60/05-eastern-plaguelands.guide', 4741, 1, 64.9, 17.8, /Hailspite/],
		['forever/horde/50-60/07-felwood.guide', 5086, 1, 50.6, 22.4, /Ancient Irontree Walkers/],
	]) {
		const list = goals(file);
		const e = list[at(list, `${quest}.${oi}`, (g) => (g.t === 'kill' || g.t === 'collect') && g.quest === quest && g.oi === oi)];
		assert.deepEqual([e.goal.x, e.goal.y], [x, y], `${file}: ${quest}.${oi} points clear of the elites`);
		assert.match([e.step.note, e.step.tip].flat().filter(Boolean).join(' '), mob, `${file}: the step names them`);
	}
});

// Horde 50-60 audit (0.4.0): class ranks come only at even levels (training.json: 50, 52, ..., 60 for every class).
// Several training stops came where the route has no new rank: Orgrimmar at about 53.3 (with the Druids sent to Mulgore
// and the Paladins to Brill, a level after the Undercity's 52), a second Orgrimmar training 20 minutes after the
// first in the Azshara guide, and the Druids' Moonglade training right after their Thunder Bluff one (gone: the
// guide ends below 58; the Felwood guide's Moonglade stop trains them). The other stops now hold only from the next rank's level, so a player above the model still trains there; and the Plaguelands guide
// trains Warriors to Warlocks on its way through Orgrimmar at about 56.6 instead of two levels later.
test('Horde 50-60: training stops hold only from the level of the next class rank', { skip }, () => {
	const gate = (e) => ((e.step.when || []).find((p) => p.k === 'level') || {});
	const trains = (file) => goals(file).filter(({ goal }) => goal.t === 'train' && goal.class);
	for (const e of trains('forever/horde/50-60/02-felwood.guide')) assert.ok(gate(e).n >= 54, `02 ${e.step.title}: from 54`);
	const az = trains('forever/horde/50-60/04-azshara.guide');
	assert.ok(!(az[0].step.when || []).some((p) => p.k === 'level'), '04: the first Orgrimmar training stays for everyone (54)');
	for (const e of az.slice(1)) assert.ok(gate(e).n >= 56, `04 ${e.step.title}: from 56`);
	const epl = trains('forever/horde/50-60/05-eastern-plaguelands.guide');
	const org = epl.find((e) => forClass('WARRIOR')(e));
	assert.ok(org && gate(org).n === 56, '05: Warriors to Warlocks train in Orgrimmar from 56');
	assert.ok(!epl.some((e) => forClass('DRUID')(e) && !forClass('PALADIN')(e)), '05: no second Druid training in Moonglade (Thunder Bluff trained 56; 58 comes in the Felwood guide\'s Moonglade stop)');
});

// --- Horde 40-60 (0.3.7): the written grind sits on mobs a quest in the log still needs, so the kills count twice
// (a player's report from Stranglethorn: "grind on Lashtail Raptor" with Raptor Hunting open). The top-ups that stood
// on mobs no open quest wanted are folded into the quest step whose kills they were next to, where those mobs give at
// least as much experience; the last one before 60 moves to mobs of the player's level.
test('Horde 40-60: grind steps sit on mobs an open quest needs', { skip }, () => {
	// (The level 53.02 top-up on the Diseased Grizzlies, 55-56, is a stand-alone one to 53 on the Carrion Lurkers,
	// 52-53, on the way to Mulgris before them: the danger gate's grind rule, #2207, wants a camp at most a level over
	// the player, and the quest mobs nearby, the wolves (53-54) and the bears, are both higher.)
	const cases = [
		['forever/horde/50-60/02-felwood.guide', 54, (g) => g.t === 'kill' && g.quest === 4120, "Irontree Woods (Talo's grizzlies and ravagers)", /^\s+level 54\b/],
		// Since the 0.4.0 level tidy the crater opens with a short top-up to 51 (Pterrordax and Flayers up to 52), on Larion's Threshers.
		['forever/horde/50-60/01-un-goro-crater.guide', 51, (g) => g.t === 'kill' && g.quest === 4145, "the Bloodpetal Threshers (Larion and Muigin)", /^\s+level 51\b/],
	];
	for (const [guide, lv, work, what, line] of cases) {
		assert.ok(goals(guide).some(({ step, goal }) => goal.t === 'level' && goal.level === lv && step.goals.some(work)), `${guide}: the level ${lv} grind is in the step for ${what}`);
		// the grind policy: a written grind offers the dungeons at its level, in the quest step too
		assert.match(stepTips(guide, line).join(' '), /Or, with a group, run the [A-Z][^.]* dungeon( \([A-Za-z ]+\))? instead\./, `${guide}: ${what} offers a dungeon`);
	}
	const fel = goals('forever/horde/50-60/02-felwood.guide');
	for (const lv of [[53, 0.2], [54, 0.1], [54, 0.45]]) {
		assert.ok(!fel.some(({ step, goal }) => goal.t === 'level' && goal.level === lv[0] && Math.abs((goal.frac || 0) - lv[1]) < 1e-6 && !step.goals.some((g) => g.quest)), `no stand-alone ${lv[0] + lv[1]} top-up on mobs no quest wants`);
	}
	// the last top-up before 60 on the Rabid Shardtooths (59) by Darkwhisper Gorge, not on level 54 furbolgs
	const end = goals('forever/horde/50-60/07-felwood.guide');
	const top = end.find(({ goal }) => goal.t === 'level' && goal.level === 59);
	assert.ok(top && top.step.goals.some((g) => g.t === 'goto' && Math.abs(g.x - 60.1) < 1 && Math.abs(g.y - 71.2) < 1), 'the 59.9 top-up is at Frostwhisper Gorge');
	assert.ok(top.s > end[at(end, 'Darkwhisper Gorge', (g) => g.t === 'complete' && g.quest === 4842)].s, 'after the strange source, before the ride back to Donova');
});

test('Eastern Plaguelands (Horde 55): Druids and Paladins fly from Orgrimmar to Thunder Bluff, not through Bloodvenom Post (#1191)', { skip }, () => {
	const list = goals('forever/horde/50-60/05-eastern-plaguelands.guide');
	for (const cls of ['DRUID', 'PALADIN', 'MAGE']) {
		const flights = list.filter(forClass(cls)).filter(({ goal }) => goal.t === 'fly').map(({ goal }) => goal.location);
		// Since the 0.4.0 audit the Plaguelands are left by Hearthstone to Orgrimmar (no flight to the Undercity): the flights
		// after the last one to Light's Hope Chapel are the ones out of Orgrimmar.
		const from = flights.lastIndexOf("Light's Hope Chapel");
		const after = cls === 'MAGE' ? flights.slice(from + 1, from + 2) : flights.slice(from + 1, from + 3);
		assert.deepEqual(after, cls === 'MAGE' ? ['Bloodvenom Post'] : ['Thunder Bluff', 'Bloodvenom Post'], `${cls}: ${flights.join(', ')}`);
	}
});

// Felwood & Western Plaguelands: the top-up to 52.63 ground on Northridge's Scarlet Mages, then walked on to Kirsta
// Deepshadow on the hill above for Unfinished Business, which wants those Scarlets. Kirsta first: the grind counts.
test('forever/horde/50-60/06-silithus.guide: Kirsta before the Northridge Scarlets, no Scarlet grind in Felwood', { skip }, () => {
	// Since the 0.4.0 level tidy Unfinished Business (Scarlet Mages 55-56) is done on the Silithus guide's Plaguelands ride.
	assert.ok(!goals('forever/horde/50-60/02-felwood.guide').some(({ goal }) => goal.t === 'level' && goal.level === 52), 'no Scarlet top-up in 02');
	const list = goals('forever/horde/50-60/06-silithus.guide');
	assert.ok(at(list, 'accept 6004', is('accept', 6004)) < at(list, 'kill 6004', (g) => g.t === 'kill' && g.quest === 6004), 'Unfinished Business before the Scarlets');
});

// Winterspring ended in Orgrimmar taking the Wool, Silk and Mageweave donations, and the Azshara guide landed in
// Orgrimmar again between the Crossroads and Valormok just to hand them in, from the Valley of Spirits to the Valley of
// Honor. They are handed in on the stop that takes them, as the Thunder Bluff ones are; the Runecloth ones are taken
// there and still handed in at the end of the route.
test('Horde 55-56 final review: the Orgrimmar cloth donations are handed in where they are taken', { skip }, () => {
	const ws = goals('forever/horde/50-60/03-winterspring.guide');
	// (Handed in on the spot, #1699: nothing to take first.)
	for (const q of [7833, 7834, 7835, 7826, 7827, 7831]) assert.ok(ws[at(ws, `turnin ${q}`, is('turnin', q))].goal.direct, `${q} handed in on the Orgrimmar stop`);
	const az = goals('forever/horde/50-60/04-azshara.guide');
	assert.ok(!az.some(({ goal }) => [7833, 7834, 7835, 7836, 7826, 7827, 7831, 7824].includes(goal.quest)), 'no donation stop in the Azshara guide');
	// (Since the 0.4.0 level tidy the Valormok stop takes Stealing Knowledge from Jediga; the payments are gone with its deliveries.)
	const between = az.slice(at(az, 'turnin 91904', is('turnin', 91904)) + 1, at(az, 'accept 3517', is('accept', 3517)));
	assert.deepEqual(between.filter(({ goal }) => goal.t === 'fly').map(({ goal }) => goal.location), ['Valormok'], 'one flight, the Crossroads to Valormok');
	assert.ok(!between.some(({ goal }) => goal.map === 1454), 'no Orgrimmar stop between the crates and Valormok');
});

// Silithus: Dearest Natalia comes from Commander Mar'alith (the top-up named Bor Wildmane), its two dwarves are
// questioned, not killed (the step had only two kill goals and no tip), and two notes said to skip what the guide had
// just taken: Dearest Natalia itself and Dithers' Skeletal Fragments.
test('forever/horde/50-60/06-silithus.guide: final review: Dearest Natalia from Mar\'alith, questioned not killed, no stale skip notes', { skip }, () => {
	const file = 'forever/horde/50-60/06-silithus.guide';
	const rec = JSON.parse(fs.readFileSync(path.join(ROOT, 'data', 'guide-fixes.json'), 'utf8')).fixes.find((f) => f.at.quest === 8304 && f.tip && f.faction === 'Horde');
	assert.ok(rec, 'the tip is a record');
	assert.deepEqual(stepTips(file, /talk 15171 quest 8304/), [rec.tip]);
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

// Final route review, Horde 50-60 (0.3.6): Gregan Brewspewer makes the Videre Elixir (3909) only from an Evoroot,
// through his own quest (4041), and the root is a quest item north of his camp; the guide sent the player to Gregan
// with nothing to give him. And Gaeriyan (3912) is seen only by drinking the elixir, which the step never said.
test('Horde Winterspring guide: the Videre Elixir comes from the Evoroot, and Gaeriyan from drinking it', { skip }, () => {
	const ws = goals('forever/horde/50-60/03-winterspring.guide');
	const root = at(ws, 'collect 11242', (g) => g.t === 'collect' && g.item === 11242);
	const tin = at(ws, 'turnin 4041', is('turnin', 4041));
	assert.ok(root < tin, 'the Evoroot, then Gregan for the elixir (handed in on the spot, #1699)');
	const got = at(ws, 'collect 11243', (g) => g.t === 'collect' && g.item === 11243 && g.quest === 3909);
	assert.equal(ws[got].s, ws[tin].s, 'the elixir is Gregan\'s reward on the same step');
	const g = ws[root].goal;
	assert.ok(g.map === 1444 && Math.abs(g.x - 44.5) < 1 && Math.abs(g.y - 10.2) < 1, `the Evoroot in northern Feralas (${g.x},${g.y})`);
	const epl = goals('forever/horde/50-60/05-eastern-plaguelands.guide');
	const drink = at(epl, 'use 11243', (g) => g.t === 'use' && g.item === 11243);
	const meet = at(epl, 'turnin 3912', is('turnin', 3912));
	assert.ok(drink < meet && epl[drink].s === epl[meet].s, 'the elixir is drunk on the step that meets Gaeriyan');
});

// Travel sweep (0.3.6 plan) and final route review, Horde 50-60: travel text written for a leg the player has
// already made. Vehena's Runecloth hand-in was titled "Zeppelin to Orgrimmar" with a zeppelin tip after the zeppelin
// had landed; the Undercity's Sylvanas step and the Egg-O-Matic nests told the player to travel to where they stood, and
// Everlook's bind claimed the previous guide had bound there.
test('Horde 50-60: no stale travel text on steps the player has already travelled to', { skip }, () => {
	const src = (f) => fs.readFileSync(path.join(OFFICIAL_DIR, f), 'utf8');
	assert.doesNotMatch(src('forever/horde/50-60/07-felwood.guide'), /step Zeppelin to Orgrimmar\n  when complete 7836/);
	const fw = goals('forever/horde/50-60/07-felwood.guide');
	assert.equal(fw[at(fw, 'turnin 7836', is('turnin', 7836))].step.title, 'Vehena');
	assert.doesNotMatch(src('forever/horde/50-60/04-azshara.guide'), /Take the zeppelin from the tower outside Orgrimmar to Tirisfal Glades and ride into the Undercity\. Lady Sylvanas/);
	assert.doesNotMatch(src('forever/horde/50-60/05-eastern-plaguelands.guide'), /tip Fly to Camp Mojache\. The hippogryph nests/);
	// Everlook: no earlier guide binds there (the last bind is Light's Hope Chapel), and no Harlo quest is taken.
	assert.doesNotMatch(src('forever/horde/50-60/03-winterspring.guide'), /the last guide binds here|Gregor's and Harlo's/);
});

// Travel sweep (0.3.6): Horde 50-60/01's walk from Tarren Mill to Sorrow Hill pointed at WPL 43.0,83.5, Argent
// Officer Pureheart's spot inside the Alliance's Chillwind Camp (Commander Ashlam Valorfist, Weldon Barov, Flint
// Shadowmore within 40 yd). It now leads to Sorrow Hill itself.
test('forever/horde/50-60/05-eastern-plaguelands.guide: the walk to Sorrow Hill keeps out of Chillwind Camp', { skip }, () => {
	const list = goals('forever/horde/50-60/05-eastern-plaguelands.guide');
	const marlene = at(list, 'turnin 5152', is('turnin', 5152));
	const walk = list.slice(0, marlene).reverse().find(({ goal }) => goal.t === 'goto' && goal.map === 1422);
	assert.ok(walk, 'a travel line into the Western Plaguelands');
	assert.ok(!(Math.abs(walk.goal.x - 43) < 2 && Math.abs(walk.goal.y - 84) < 2), 'not at Chillwind Camp');
});

// Final route review, Horde 40-60 (0.3.6 leftovers): Winna's kitten (Corrupted Sabers, 4506). The moonwell step held
// `complete 4506` with the Kitten Carrier's use on the NEXT step, so no item button showed at the moonwell and the use
// line was dead once the cat reached Winna. The use is now on the moonwell step, before the completion.
test('forever/horde/50-60/02-felwood.guide: the Kitten Carrier is used on the moonwell step', { skip }, () => {
	const list = goals('forever/horde/50-60/02-felwood.guide');
	const use = list.filter(({ goal }) => goal.t === 'use' && goal.item === 12565);
	assert.equal(use.length, 1, 'one use of the Kitten Carrier');
	const done = list[at(list, 'complete 4506', is('complete', 4506))];
	assert.equal(use[0].s, done.s, 'on the step that completes Corrupted Sabers');
	assert.ok(list.indexOf(use[0]) < list.indexOf(done));
	assert.ok(use[0].goal.x === 32.3 && use[0].goal.y === 66.6 && use[0].goal.map === 1448, 'the use leads to the Jadefire moonwell');
});

// Breadcrumb sweep (0.3.6): Horde 50-60/01 took Defenders of Darrowshire (5211) from Carlin Redpath on
// its first Light's Hope stop and Uncle Carlin (5241) later at Pamela. The server data and the quest data name 5241 as
// 5211's prerequisite (the Alliance route takes them in that order): 5211 comes after 5241 is handed in on the Light's
// Hope stop after Darrowshire (50-60/05 since the 0.3.6 flow pass), its spirits freed at Corin's Crossing later in
// 50-60/05, handed in with Villains of Darrowshire.
test('Horde Darrowshire: Defenders of Darrowshire after Uncle Carlin', { skip }, () => {
	const ep = goals('forever/horde/50-60/05-eastern-plaguelands.guide');
	const acc = at(ep, 'accept 5211', is('accept', 5211));
	assert.ok(at(ep, 'turnin 5241', is('turnin', 5241)) < acc, 'Uncle Carlin handed in before Defenders of Darrowshire is taken');
	// The spirits are freed by talking to them (#2543: a talk objective, no longer a kill).
	assert.ok(acc < at(ep, 'the spirits', (g) => g.t === 'talk' && g.quest === 5211), 'taken before the spirits');
	const spirits = at(ep, 'the spirits', (g) => g.t === 'talk' && g.quest === 5211);
	assert.ok(spirits < at(ep, 'turnin 5211', is('turnin', 5211)), 'spirits before the hand-in');
	assert.equal(ep[at(ep, 'turnin 5211', is('turnin', 5211))].s, ep[at(ep, 'turnin 5181', is('turnin', 5181))].s, 'with Villains of Darrowshire');
});

// Flow pass (0.3.6, Horde 50-60/05): Camp Mojache (7492, 1500 XP) was the only reason left to fly Gadgetzan -> Camp
// Mojache -> Marshal's Refuge (the Egg-O-Matic's nests moved to 40-50/06): about 6 minutes of flying for five kills'
// worth of XP. The guide flies straight from Gadgetzan to Marshal's Refuge on the way to Silithus.
test('Horde 56: Gadgetzan straight to Marshal\'s Refuge, no Camp Mojache detour for Gorlach\'s delivery', { skip }, () => {
	const g = goals('forever/horde/50-60/05-eastern-plaguelands.guide');
	assert.ok(!g.some(({ goal }) => goal.quest === 7492), 'Camp Mojache is not routed');
	const flights = g.filter(({ goal }) => goal.t === 'fly').map(({ goal }) => goal.location);
	assert.ok(!flights.some((l) => /Camp Mojache/.test(l || '')), `no flight to Camp Mojache (${flights.join(', ')})`);
	const i = flights.findIndex((l) => /Marshal/.test(l || ''));
	assert.ok(i > 0 && /Gadgetzan/.test(flights[i - 1] || ''), 'the Marshal\'s Refuge flight follows the Gadgetzan one');
	const rf = JSON.parse(fs.readFileSync(path.join(ROOT, 'data', 'route-fixes.json'), 'utf8')).overrides;
	assert.ok(rf.skip.some((r) => r.q === 7492 && r.faction === 'Horde'), 'a route-fix skip keeps it out');
});

// Horde 50-60/07 (0.3.6): Salve via Hunting (5887, 4200 XP) from Maybess at the Emerald Sanctuary once
// Cleansing Felwood is done; its Corrupted Soul Shards drop from the Jaedenar and Shadow Hold cultists the guide fights
// for Greta, and Maybess stands on the way out and back. The XP comes off the closing grind to 60.
test('Horde Felwood 59: Salve via Hunting on the way to Jaedenar, shards in Shadow Hold, handed in before Greta', { skip }, () => {
	const fw = goals('forever/horde/50-60/07-felwood.guide');
	// Handed in on the spot (#1699): nothing to take from Maybess first.
	assert.ok(!fw.some(({ goal }) => is('accept', 5887)(goal)), 'no accept');
	const shards = at(fw, 'collect 11515', (g) => g.t === 'collect' && g.item === 11515 && g.count === 6);
	assert.equal(fw[shards].s, fw[at(fw, 'kill 9861', (g) => g.t === 'kill' && g.quest === 5242)].s, 'with A Final Blow in Shadow Hold');
	const tin = at(fw, 'turnin 5887', is('turnin', 5887));
	assert.ok(tin > shards && tin < at(fw, 'turnin 5242', is('turnin', 5242)), 'handed in on the way back to Greta');
	assert.ok((fw[tin].step.when || []).some((p) => p.k === 'available' && !p.neg), 'only when Maybess takes it');
});

// Flow (0.3.6, Horde 50-60/02): Maybess Riverbreeze stands in the Emerald Sanctuary with Greta and Taronn. Cleansing
// Felwood had a Sanctuary stop of its own each way: Deadwood -> Sanctuary -> Jaedenar to take it, and Ror (south end of
// Deadwood) -> Sanctuary -> the Deadwood top-up to hand it in. Both now ride on the Sanctuary stops the guide makes.
test('Horde Felwood 53: Cleansing Felwood taken and handed in on the Sanctuary stops, no extra trips', { skip }, () => {
	const fw = goals('forever/horde/50-60/02-felwood.guide');
	const take = at(fw, 'accept 4102', is('accept', 4102));
	assert.equal(fw[take].s, fw[at(fw, 'accept 5156', is('accept', 5156))].s, 'on the arrival stop');
	const tin = at(fw, 'turnin 4102', is('turnin', 4102));
	assert.equal(fw[tin].s, fw[at(fw, 'turnin 5156', is('turnin', 5156))].s, "with Taronn's hand-in");
	const ror = at(fw, 'collect 15879', (g) => g.t === 'collect' && g.quest === 6162);
	const grind = fw.findIndex(({ goal }) => goal.t === 'level' && goal.grind === 7155);
	assert.ok(tin < ror, 'Ror after the hand-in');
	// Horde 0.4.0 audit (round 2): the guide's top-ups are two whole levels (54 in Irontree Woods, 55 at its end); the
	// Deadwood top-up after Ror is gone.
	assert.equal(grind, -1, 'no Deadwood top-up');
});

// Flow pass (0.3.6, Horde 50-60): Darrowshire (Pamela's doll, Zaeldarr, Uncle Carlin) and the Marlene/Chromie chain
// closed 50-60/01 at about level 52.4 among Darrowshire's level 54-57 mobs. They now
// open 50-60/05 (about 56): Light's Hope Chapel on the road in (flight path, bind), Darrowshire, back to the chapel,
// the flight to Tarren Mill for Marlene and Chromie, the flight back to Carlin for Heroes and Villains of Darrowshire.
// Terrordale (Augustus' book, A Plague Upon Thee's termites) moved from 01 to 02's Tirion stop, a river away.
test('Horde Plaguelands: Darrowshire at 56 in the Eastern Plaguelands guide, not at 52 in the Un\'Goro guide', { skip }, () => {
	const un = goals('forever/horde/50-60/01-un-goro-crater.guide');
	assert.ok(!un.some(({ goal }) => [5149, 5152, 5241, 5153, 5154, 5210, 6021, 6164].includes(goal.quest)), 'none of it in 01');
	assert.ok(!un.some(({ goal }) => goal.t === 'getfp' && /Light's Hope/.test(goal.location || '')), 'no Light\'s Hope flight path in 01');
	// The last step is Janice's (talk goals): with the Scarlet camp's `complete 5096` last, the addon's guide-end check
	// (guides_end_early) saw the end done ahead while Janice's step was still live.
	assert.equal(un.filter(({ goal }) => goal.quest).pop().goal.quest, 5023, '01 ends at Janice Felstone, after the Scarlet camp');
	// Terrordale (Augustus' book, the termites) is on 50-60/05's Egan stop since the 0.4.0 level tidy (its undead are
	// 54-56), after Tirion's hut on the ride east; Mickey Levine takes the termites on 06's Bulwark stop.
	const tep = goals('forever/horde/50-60/05-eastern-plaguelands.guide');
	const tirion = at(tep, 'accept 5542', is('accept', 5542));
	const book = at(tep, 'collect 15884', (g) => g.t === 'collect' && g.quest === 6164);
	const termites = at(tep, 'collect 15043', (g) => g.t === 'collect' && g.quest === 5901);
	assert.ok(tirion < at(tep, 'accept 6164', is('accept', 6164)) && tep[book].s === tep[termites].s, 'Terrordale after Tirion');
	assert.ok(goals('forever/horde/50-60/06-silithus.guide').some(({ goal }) => is('turnin', 5901)(goal)), 'the termites to the Bulwark on the next guide');
	const ep = goals('forever/horde/50-60/05-eastern-plaguelands.guide');
	const fp = at(ep, 'getfp LHC', (g) => g.t === 'getfp' && /Light's Hope/.test(g.location || ''));
	const pam = at(ep, 'turnin 5149', is('turnin', 5149));
	const marlene = at(ep, 'turnin 5152', is('turnin', 5152));
	const brother = at(ep, 'turnin 5210', is('turnin', 5210));
	const villains = at(ep, 'accept 5181', is('accept', 5181));
	assert.ok(fp < pam && pam < marlene && marlene < brother && brother < villains, 'chapel, Darrowshire, Marlene and Chromie, then Carlin');
	const flyBack = ep.slice(0, fp).some(({ goal }) => goal.t === 'fly');
	assert.ok(!flyBack, 'no flight to Light\'s Hope before its flight path is learnt');
	assert.ok(at(ep, 'turnin 6164', is('turnin', 6164)) > villains, 'Augustus takes the book back on the Terrordale stop');
});

// The #1791 sweep: Alas, Andorhal's shard (105) comes from Araj's Phylactery at Araj the Summoner's feet, a level
// 61 elite among elite Skeletal Warlords, and the Horde 50-60 route sent every character there. It is asked as a
// group quest, accept to turn-in.
test('the #1791 sweep: Alas, Andorhal is a group quest on the Horde 50-60 route', { skip }, () => {
	const guide = 'forever/horde/50-60/06-silithus.guide';
	const mine = goals(guide).filter(({ goal }) => goal.quest === 105);
	assert.deepEqual(mine.map(({ goal }) => goal.t), ['accept', 'collect', 'turnin']);
	for (const { step, goal } of mine) {
		assert.ok((step.when || []).some((p) => p.k === 'group' && [p.q].flat().includes(105) && !p.neg), `${goal.t} 105 is under when group 105`);
	}
});
