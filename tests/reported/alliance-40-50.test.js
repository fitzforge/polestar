'use strict';
// Player-reported guide fixes: the Alliance 40-50 guides.
// tests/reported/helpers.js says what the cases check and where a new one goes.

const { test } = require('node:test');
const assert = require('node:assert/strict');
const fs = require('node:fs');
const path = require('node:path');
const {
	allGuides, anyLine, at, codeOf, compiled, forClass, forRaceOf, goals, is, OFFICIAL_DIR, RG_ALLIANCE, RIVERGLADES,
	RIVERGLADES_HORDE, rivergladesSteps, ROOT, skip, stepTips,
} = require('./helpers');

const riverglades = () => [...fs.readdirSync(RIVERGLADES).filter((f) => /^riverglades-.*\.guide$/.test(f)).sort().map((f) => path.join(RIVERGLADES, f)), RIVERGLADES_HORDE, RG_ALLIANCE];

test(`forever/alliance/40-50/05-the-hinterlands.guide: Mokk's heart waits for Unbagwa's ritual, its hand-in done (#2561 sweep)`, { skip }, () => {
	const { steps } = compiled('forever/alliance/40-50/05-the-hinterlands.guide');
	const ritual = steps.findIndex((st) => st.goals.some(is('turnin', 349)));
	const heart = steps.findIndex((st) => st.goals.some((g) => g.t === 'collect' && g.item === 2797));
	assert.ok(heart > ritual, 'the heart comes after the fangs are handed in');
	assert.ok((steps[heart].when || []).some((p) => p.k === 'turnedin' && !p.neg && [].concat(p.q).includes(349)), 'and only once Unbagwa has them: Mokk comes from his ritual');
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
	const walks = list.slice(fp + 1, felsteed).filter(({ step, goal }) => step !== list[fp].step && goal.t === 'goto' && goal.text === 'Ratchet');
	assert.deepEqual(walks.map(({ step }) => step.title), [], 'no walk to Ratchet for the Felsteed');
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

// Offer sweep with #1579: Alliance Tanaris (40-50/04) took and handed in Zamek's Distraction (1191) on its Mirage Raceway
// stop, but 1191 is a step of Keeping Pace (1190, its parent), which the Alliance leaves out, so Zamek never offered it.
test('forever/alliance/40-50/04-tanaris.guide: no Zamek\'s Distraction without Keeping Pace (offer sweep, #1579)', { skip }, () => {
	assert.ok(!goals('forever/alliance/40-50/04-tanaris.guide').some(({ goal }) => goal.quest === 1191 || goal.quest === 1190), 'neither 1191 nor its parent 1190 in the Alliance guide');
	const { overrides } = JSON.parse(fs.readFileSync(path.join(ROOT, 'data', 'route-fixes.json'), 'utf8'));
	assert.ok(overrides.skip.some((r) => r.q === 1191 && r.faction === 'Alliance'), 'route-fixes leaves 1191 out on the Alliance side, with 1190');
});

// shacklef00rd's tests from #2305, pinned to 0.4.0's fix (#2335): the group question. A player who answers "Skip it"
// never sees Zamael's steps, so nothing required (not even the hand-in of a Prayer to Elune already in the log) pulls
// him back into the Twilight camp; one who answers "Do it with a group" sees real goals, so the arrow leads him there.
test("Edet's report (#2300): Prayer to Elune never requires the elite camp, even with the quest already held", { skip }, () => {
	const grouped = ({ step }) => (step.when || []).some((p) => p.k === 'group' && !p.neg && [p.q].flat().includes(3377));
	const list = goals('forever/alliance/40-50/06-searing-gorge.guide');
	const prayer = list.filter(({ goal }) => goal.quest === 3377);
	assert.deepEqual(prayer.map(({ goal }) => goal.t), ['accept', 'talk', 'turnin'], 'keep the quest available');
	assert.ok(prayer.every(grouped), 'pickup, talk and hand-in all wait for the group answer: "Skip it" hides them, carried quest or not');
	assert.ok(prayer.every(({ goal }) => !goal.optional), 'for a player who chose the group, each goal holds its step, so the arrow leads there');
	assert.deepEqual(list.filter(({ goal }) => goal.npc === 8436 && !grouped({ step: list.find((e) => e.goal === goal).step })).map(({ goal }) => `${goal.t} ${goal.quest}`), [], 'no other goal sends anyone to Zamael');
	const { goal: talk } = prayer[1];
	assert.deepEqual([talk.npc, talk.oi, talk.map, talk.x, talk.y], [8436, 1, 1427, 29.6, 26.3], 'keep the real talk target and coordinates');
	for (const [verb, quest] of [['kill', 7724], ['accept', 3441], ['talk', 3441], ['turnin', 3441]]) {
		const e = list[at(list, `${verb} ${quest}`, is(verb, quest))];
		assert.ok(!e.goal.optional && !grouped(e), `${verb} ${quest} remains required for everyone`);
	}
});

// Flow review (2026-11-07): Alliance Stranglethorn 40-50 killed the Jungle Stalkers on a trip of their own after the
// last Booty Bay stop and walked back north to Nesingwary for Raptor Mastery, though the jungle loop crosses their
// slopes at the Cold Eye basilisks and the ride to the Rebel Camp passes Nesingwary's camp.
test('forever/alliance/40-50/01-stranglethorn-vale.guide: flow re-order: Raptor Mastery with the Cold Eye basilisks, handed in at Nesingwary on the way to the Rebel Camp', { skip }, () => {
	const list = goals('forever/alliance/40-50/01-stranglethorn-vale.guide');
	const stepOf = (what, pred) => list[at(list, what, pred)].s;
	const stalkers = stepOf('the Jungle Stalkers (196)', (g) => g.t === 'kill' && g.quest === 196);
	// Level tidy 0.4.0: Zanzil's village and Maury (43-44) wait for the level-48 Booty Bay stop, so the raptors follow
	// the optional Cortello's scroll step on the way north out of town.
	assert.equal(stalkers, stepOf("Cortello's scroll", (g) => g.t === 'collect' && g.item === 4056) + 1, 'the raptors on the jungle loop, right after leaving Booty Bay (A Meal Served Cold is left out)');
	assert.ok(goals('forever/alliance/40-50/05-the-hinterlands.guide').some(({ goal }) => goal.t === 'collect' && goal.item === 3924), "Maury's foot on the level-48 Booty Bay stop");
	const turnin = stepOf('turnin 196', is('turnin', 196));
	assert.ok(turnin < stepOf('turnin 622', is('turnin', 622)), 'handed in on the way to the Rebel Camp');
	assert.ok(turnin < stepOf('turnin 611', is('turnin', 611)), 'before the last Booty Bay stop');
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
	// Level tidy (0.4.0): Zorbin's giants (47-49, elite Striders around them) stay left out.
	assert.ok(!list.some(({ goal }) => [7003, 7721].includes(goal.quest)), "Zorbin's giants are left out");
	assert.equal(stepOf('the Groddoc livers', (g) => g.t === 'collect' && g.quest === 1452 && g.oi === 3), stepOf('the yeti hides (2821)', (g) => g.t === 'collect' && g.quest === 2821), 'the livers with the yetis');
});

// Flow review (2026-11-07): Alliance Un'Goro rode from Torwa to Marshal's Refuge and only came back south-east for the
// Lar'korwi glands and the wrecked raft, which lie just west of Torwa at the foot of the ramp. Since the 0.4.0 fix round
// Karna's A-Me 01 waits for the later Un'Goro visit, so the ride north is measured by the first refuge stop (Muigin).
test("forever/alliance/40-50/07-un-goro-crater.guide: flow re-order: the Lar'korwi glands and the wrecked raft on arrival, before the ride north", { skip }, () => {
	const list = goals('forever/alliance/40-50/07-un-goro-crater.guide');
	const stepOf = (what, pred) => list[at(list, what, pred)].s;
	const glands = stepOf('the glands (4291)', (g) => g.t === 'collect' && g.quest === 4291);
	const refuge = stepOf('accept 4141', is('accept', 4141));
	assert.ok(glands < refuge, 'the glands before the ride north to the refuge');
	assert.equal(stepOf('turnin 3844', is('turnin', 3844)), glands, 'the raft with the glands');
	assert.equal(glands, stepOf('turnin 4290', is('turnin', 4290)) + 1, 'right after Torwa');
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
	assert.ok(jartsam > stepOf('turnin 1271', is('turnin', 1271)), 'after the Stormwind stop');
	for (const npc of [4772, 7954]) assert.ok(list.some(({ goal }) => train(npc)(goal)), `riding ${npc} on this guide, before the Riverglades and the Badlands`);
	const last = stepOf('turnin 600', is('turnin', 600));
	const sw = list.find(({ goal, s }) => s > last && goal.t === 'fly' && /Stormwind/.test(goal.location || ''));
	const gotoBefore = list.filter(({ s, goal }) => s === sw.s && goal.t === 'goto')[0];
	assert.equal(gotoBefore.goal.map, 1434, 'the Stormwind flight leaves from Booty Bay');
	assert.ok(!goals('forever/alliance/40-50/02-badlands.guide').some(({ goal }) => goal.t === 'fly' && /Thelsamar/.test(goal.location || '')), 'no flight back to Thelsamar in the Badlands guide');
});

// Final route review, Alliance 40-60: a player under 45 on Sardor Isle was sent to grind in Feral Scar Vale and then back
// to Feathermoon's dock for the boat to the coast. Since #1999 (0.4.0 audit) the level-45 grind comes on the mainland
// loop, before the Rage Scar yetis and the ride to Feathermoon, so it never sends you back across the water for it.
test('forever/alliance/40-50/03-feralas.guide: final review: the level-45 grind on the mainland, no boat back for it', { skip }, () => {
	const g = compiled('forever/alliance/40-50/03-feralas.guide');
	const grind = g.steps.findIndex((s) => s.goals.some((x) => x.t === 'level' && x.level === 45));
	assert.ok(grind > 0, 'the level-45 grind is in the guide');
	const fm = g.steps.findIndex((s, i) => i > grind && /Feathermoon Stronghold/.test(s.title || ''));
	assert.ok(fm > grind, 'Feathermoon after the grind');
});


// Final route review, Alliance 40-60: Loch Modan once each way (Ghak's quest from Thelsamar where the flight lands, the
// seed's order). Since 0.3.7 the loop is done from the Badlands at 43, where the route already is: Ghak's quest is taken
// in Thelsamar where the Riverglades guide's flight lands (the Badlands guide's first step; until fix round 1 the
// Stranglethorn guide flew there and back for it) and handed in where the Badlands guide flies
// out, and the Hinterlands guide only sets the hearth there. The Booty Bay flight after Nethergarde was only for The
// Monogrammed Sash's group; since 0.3.7 it is for everyone (MacKinley and the Bloodsail captains), and the Sash and
// Negolash steps stay group-only.
test('forever/alliance/40-50/05-the-hinterlands.guide: final review: Loch Modan once each way, the Sash and Negolash only for the group', { skip }, () => {
	const bad = goals('forever/alliance/40-50/02-badlands.guide');
	assert.ok(!goals('forever/alliance/40-50/01-stranglethorn-vale.guide').some(({ goal }) => goal.quest === 17), 'no Thelsamar trip on the Stranglethorn guide');
	assert.equal(bad[at(bad, 'accept 17', is('accept', 17))].step.title, 'Thelsamar', 'Ghak on the Badlands guide\'s opening Thelsamar step, where the flight lands');
	assert.ok(at(bad, 'accept 17', is('accept', 17)) < at(bad, 'accept 732', is('accept', 732)), 'before the Badlands');
	assert.match(fs.readFileSync(path.join(ROOT, 'guides', 'forever', 'alliance', '40-50', '01b-riverglades.guide'), 'utf8'), /\n\s+fly "Thelsamar"\n(?![\s\S]*\nstep )/, 'the Riverglades guide ends on the flight to Thelsamar');
	const sb = (what, pred) => bad[at(bad, what, pred)].s;
	assert.ok(sb('turnin 706', is('turnin', 706)) < sb('turnin 739', is('turnin', 739)), 'the Badlands first, then Ironband');
	assert.ok(sb('turnin 739', is('turnin', 739)) < sb('urns', (g) => g.t === 'collect' && g.quest === 704), 'Ironband, then the dig');
	assert.equal(sb('urns', (g) => g.t === 'collect' && g.quest === 704), sb('mushrooms', (g) => g.t === 'collect' && g.quest === 17), 'urns and mushrooms in one step');
	assert.ok(sb('turnin 704', is('turnin', 704)) < sb('turnin 17', is('turnin', 17)), 'Ironband on the way back, then Ghak');
	assert.ok(sb('turnin 17', is('turnin', 17)) < sb('fly Southshore', (g) => g.t === 'fly' && /Southshore/.test(g.location || '')), 'before the flight out');
	const list = goals('forever/alliance/40-50/05-the-hinterlands.guide');
	assert.ok(!list.some(({ goal }) => [17, 739, 704].includes(goal.quest)), 'no second Loch Modan loop');
	assert.ok(list.some(({ goal }) => goal.t === 'sethome' && /Ironforge/.test(goal.location || goal.label || JSON.stringify(goal))), 'the hearth for the Searing Gorge guide (Ironforge since the 0.4.0 audit)');
	for (const q of [8552, 8554]) {
		const e = list[at(list, `accept ${q}`, is('accept', q))];
		assert.ok((e.step.when || []).some((w) => w.k === 'group'), `${q} only for the group`);
	}
});

// Final route review, Alliance 40-60: Suntara Stones is an escort that starts on accept; it was taken at the first
// outhouse stop and the guide left for Thorium Point. Caught! on the spot (as on the Horde side); no along lists.
test('forever/alliance/40-50/06-searing-gorge.guide: final review: Dorius taken with his escort, Caught! on the spot, no along lists', { skip }, () => {
	const list = goals('forever/alliance/40-50/06-searing-gorge.guide');
	const stepOf = (what, pred) => list[at(list, what, pred)].s;
	assert.equal(stepOf('accept 3367', is('accept', 3367)), stepOf('complete 3367', is('complete', 3367)), 'accepted on the escort step');
	// Since 0.3.7 the escort follows the outhouse, where Dorius stands, instead of a ride back there at the end.
	assert.ok(stepOf('accept 3367', is('accept', 3367)) > stepOf('turnin 4449', is('turnin', 4449)), 'after the outhouse');
	assert.ok(stepOf('accept 3367', is('accept', 3367)) < stepOf('accept 7728', is('accept', 7728)), 'before Thorium Point');
	assert.equal(stepOf('turnin 4449', is('turnin', 4449)), stepOf('kill 5839', (g) => g.t === 'kill' && g.quest === 4449), 'Caught! with its geologists');
	assert.ok(stepOf('turnin 4449', is('turnin', 4449)) < stepOf('accept 7728', is('accept', 7728)), 'before Thorium Point');
	assert.ok(!list.some(({ step }) => step.along), 'no along lists');
});

// ... and Bugs' crawler legs drop from the Silt Crawlers (40-41) and the Monstrous Crawlers (43-44) of the Swamp of
// Sorrows' shore. With Stranglethorn's top-ups gone the level model plays this leg at about 40.7, and the unpinned goal
// led the arrow to the Monstrous Crawlers' stretch (94.6,28.6): it now points at the Silt Crawlers' north end, and the
// step's Careful line names the Monstrous Crawlers.
test('Alliance 40-50: ... and Bugs\' crawler legs come from the Silt Crawlers at the shore\'s north end', { skip }, () => {
	const guide = 'forever/alliance/40-50/01-stranglethorn-vale.guide';
	const list = goals(guide);
	const legs = list[at(list, 'collect 5938', (g) => g.t === 'collect' && g.quest === 1258)].goal;
	assert.ok(legs.x < 86 && legs.y < 16, `the legs' point among the Silt Crawlers (${legs.x},${legs.y})`);
	assert.match(stepTips(guide, /collect 5938 quest 1258/).join(' '), /Careful: .*Monstrous Crawlers \(43-44\)/);
	const fixes = JSON.parse(fs.readFileSync(path.join(ROOT, 'data', 'guide-fixes.json'), 'utf8')).fixes;
	assert.ok(fixes.some((f) => f.at && f.at.quest === 1258 && /Monstrous Crawlers/.test(f.tip || '')), 'a guide-fixes record carries the tip');
});

// Final route review before 0.3.5, Alliance 40-60: the Gadgetzan stop told the player to skip Sprinkle's next
// ingredient ("the route never brings it back") right before accepting it. Level tidy 0.4.0: The Thirsty Goblin's
// Thistleshrub Valley (48-50) waits for the Un'Goro guide's Gadgetzan landing, after the route's last Hinterlands
// visit, so Sprinkle's Secret Ingredient is left out (route-fixes skip) and no step sends you for its water.
test('forever/alliance/40-50/04-tanaris.guide: final review: Sprinkle\'s Secret Ingredient left out with a record, no stray step for it', { skip }, () => {
	for (const g of ['04-tanaris', '05-the-hinterlands', '07-un-goro-crater']) {
		assert.ok(!goals(`forever/alliance/40-50/${g}.guide`).some(({ goal }) => goal.quest === 2641), `no 2641 goal in ${g}`);
	}
	const rf = JSON.parse(fs.readFileSync(path.join(ROOT, 'data', 'route-fixes.json'), 'utf8')).overrides;
	assert.ok(rf.skip.some((e) => e.q === 2641 && e.faction === 'Alliance'), 'a route-fix skip says why');
	const un = goals('forever/alliance/40-50/07-un-goro-crater.guide');
	assert.ok(at(un, 'turnin 2606', is('turnin', 2606)) > at(un, 'turnin 2605', is('turnin', 2605)), 'In Good Taste handed to Sprinkle on the Un\'Goro guide\'s Gadgetzan stop');
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
	const recs = JSON.parse(fs.readFileSync(path.join(ROOT, 'data', 'guide-fixes.json'), 'utf8')).fixes;
	for (const quest of [4449, 7722]) {
		const rec = recs.find((f) => f.at.quest === quest && f.at.goal === 'accept' && f.tip);
		assert.ok(rec, `${quest}: the tip is a record`);
		assert.deepEqual(stepTips(guide, new RegExp(`^  accept ${quest}\\b`)), [rec.tip]);
	}
});

// Final route review before 0.3.5, Alliance 40-60: after the last Booty Bay stop, Stranglethorn rode back north for the
// Nesingwary hunts (Tethis, King Bangalash) or, solo, for top-ups on the Cold Eye Basilisks, then south again to fly.
// They come before that stop now, after the Crystalvein Mine. Since 0.3.7 the solo top-up is one step on the
// Skullsplitter trolls (tusks), with one fallback after the hunts.
test('forever/alliance/40-50/01-stranglethorn-vale.guide: final review: the northern hunts and solo top-ups before the last Booty Bay stop', { skip }, () => {
	const list = goals('forever/alliance/40-50/01-stranglethorn-vale.guide');
	const last = at(list, 'turnin 611', is('turnin', 611));
	const fly = list.findIndex((e, i) => i > last && e.goal.t === 'fly');
	assert.ok(at(list, 'turnin 208', is('turnin', 208)) < last, 'Big Game Hunter before Booty Bay');
	assert.ok(at(list, 'collect 3877', (g) => g.t === 'collect' && g.quest === 197) < last, 'Tethis before Booty Bay');
	// Fix round 2 (0.4.0): Stranglethorn has no solo top-up any more: the one top-up of 40-50 Alliance's start is to
	// 44.4 on the Riverglades' first Eastsea camp, right before the pirates' second wave (see the Alliance 42-44 case).
	assert.ok(!list.some(({ goal }) => goal.t === 'level'), 'no top-up in Stranglethorn');
	assert.ok(!list.slice(last, fly).some(({ goal }) => goal.t === 'level'), 'no grind between Booty Bay and the flight');
	const rf = JSON.parse(fs.readFileSync(path.join(ROOT, 'data', 'route-fixes.json'), 'utf8')).deliberate.pairs;
	assert.ok(rf.some((p) => p.a[0] === 'turnin' && p.a[1] === 208 && p.b[0] === 'turnin' && p.b[1] === 611), 'a route-fixes pair keeps it');
});

// Final route review before 0.3.5 (Main's grind policy): every written grind step of Alliance 40-60 ("Level N" top-ups,
// solo fallbacks, "Grind to N") ends its tip with the dungeon a group can run instead, the writer's sentence.
test('alliance 40-50: final review: every written grind step names only a dungeon the route runs nearby', { skip }, () => {
	// Since the 0.4.0 audit, Alliance 40-50's grind tips follow the dungeons-in-the-route rule: a tip names a dungeon
	// only when its run is in the same or the next guide, on the same continent (Uldaman for Stranglethorn, whose next
	// guide runs it from the Badlands; Zul'Farrak for Feralas, whose next guide runs it from Tanaris; none elsewhere).
	// 50-60 has its own case for the same rule.
	const near = { '01-stranglethorn-vale': 'the Uldaman dungeon', '03-feralas': "the Zul'Farrak dungeon" };
	for (const guide of allGuides().filter((g) => /^forever\/alliance\/40-50\//.test(g))) {
		for (const step of compiled(guide).steps) {
			if (!/^(?:Level [\d.]+|Grind to \d+)$/.test(step.title)) continue;
			const d = near[/\/40-50\/([^/]+)\.guide$/.exec(guide)[1]];
			if (d) assert.ok((step.note || '').endsWith(`Or, with a group, run ${d} instead.`), `${guide} "${step.title}": ${step.note}`);
			else assert.ok(!/run the [^.]* dungeon/.test(step.note || ''), `${guide} "${step.title}": no dungeon off the route: ${step.note}`);
		}
	}
});

test('Alliance 47-48: everyone flies from Nethergarde to Booty Bay for MacKinley and the Bloodsail captains', { skip }, () => {
	const tan = goals('forever/alliance/40-50/04-tanaris.guide');
	assert.ok(at(tan, 'turnin 2873', is('turnin', 2873)) < at(tan, 'accept 2874', is('accept', 2874)), '04: Deliver to MacKinley taken from Stoley');
	const g = goals('forever/alliance/40-50/05-the-hinterlands.guide');
	const pick = (t, q) => {
		const i = at(g, `${t} ${q}`, is(t, q));
		assert.ok(!(g[i].step.when || []).some((p) => p.k === 'group'), `${t} ${q} is for everyone`);
		return i;
	};
	const fly = g.findIndex(({ goal }) => goal.t === 'fly');
	assert.ok(fly >= 0 && !(g[fly].step.when || []).some((p) => p.k === 'group'), 'the flight to Booty Bay is for everyone');
	const a = pick('turnin', 2874), b = pick('accept', 608);
	const kills = [2550, 2548, 2546].map((npc) => at(g, `kill ${npc}`, (x) => x.t === 'kill' && x.npc === npc));
	const c = pick('turnin', 608);
	assert.ok(fly < a && a < c && b < Math.min(...kills) && Math.max(...kills) < c, 'Booty Bay, the captains, Booty Bay');
});

// Fix round 2 (0.4.0): the Stranglethorn top-ups (42.16 on the Skullsplitters for the skipped Nesingwary hunts, 42.16 on
// the basilisks, 42.46 in Dustwallow) sat before nothing in the jungle that needed them; they are one top-up to 44.4 on
// the Riverglades' first Eastsea camp (buccaneers and musketeers 41-43), right before the second wave (43-45). The
// reviewer's point holds: no grind block before Booty Bay.
test('Alliance 42-44: the solo top-up for the skipped Nesingwary hunts is one Riverglades top-up before the pirates\' second wave (reviewer: the grind block before Booty Bay)', { skip }, () => {
	const g = goals('forever/alliance/40-50/01-stranglethorn-vale.guide');
	assert.ok(!g.some(({ goal }) => goal.t === 'level'), 'no grind block in Stranglethorn');
	const rg = goals('forever/alliance/40-50/01b-riverglades.guide');
	const tops = rg.map((e, i) => ({ ...e, i })).filter(({ goal }) => goal.t === 'level');
	assert.equal(tops.length, 1, 'one top-up in the Riverglades');
	const [top] = tops;
	assert.ok(top.goal.level >= 44 && top.goal.grind === 257901, 'to 44.4 on the Eastsea Buccaneers (41-42)');
	assert.ok(top.i < at(rg, 'kill 257915', (x) => x.t === 'kill' && x.npc === 257915), 'right before the second wave');
	assert.ok(!(top.step.when || []).some((p) => p.k === 'group'), 'for anyone short of it');
});

// Position sweep (0.3.6, the Missing Diplomat check): Archmage Tervosh takes The Missing Diplomat (1265)
// at Sentry Point's tower, where its exploration ticks (4 of 4 people in players' recordings), and he and Lady Jaina
// take 1324 and 1267 beside North Point Tower once Private Hendel yields (3 of 3). Nobody handed them in in Theramore's
// tower, the only spot the data had: the guide hands them in on the spot instead of sending players back.
test('Dustwallow Marsh (Alliance 40): The Missing Diplomat handed in at Sentry Point and North Point Tower', { skip }, () => {
	const g = goals('forever/alliance/40-50/01-stranglethorn-vale.guide');
	const near = (i, x, y) => Math.abs(g[i].goal.x - x) < 0.5 && Math.abs(g[i].goal.y - y) < 0.5;
	const explore = at(g, 'complete 1265', is('complete', 1265));
	const t1265 = at(g, 'turnin 1265', is('turnin', 1265));
	const a1266 = at(g, 'accept 1266', is('accept', 1266));
	assert.ok(g[t1265].s === g[explore].s && g[a1266].s === g[explore].s, '1265 handed in and 1266 taken on the Sentry Point step');
	assert.ok(near(t1265, 59.7, 41.2) && near(a1266, 59.7, 41.2), 'Tervosh at Sentry Point');
	const yields = at(g, 'complete 1324', is('complete', 1324));
	for (const [what, pred, x, y] of [['turnin 1324', is('turnin', 1324), 45.2, 24.4], ['turnin 1267', is('turnin', 1267), 45.2, 24.3]]) {
		const i = at(g, what, pred);
		assert.equal(g[i].s, g[yields].s, `${what} on the North Point Tower step`);
		assert.ok(near(i, x, y), `${what} beside North Point Tower`);
	}
});

// Position sweep (0.3.6, class B2): Boss Tho'grun walks a long loop around the Badlands (the Forever TDB's waypoint
// path for him, 102 nodes; CMaNGOS a 642 yd walk); the step said he stands at Camp Boff, his spawn and the only
// point the data has. The arrow now searches his loop.
test('Badlands (Alliance 40): Boss Tho\'grun is searched for along his loop', { skip }, () => {
	const list = goals('forever/alliance/40-50/02-badlands.guide');
	const { goal } = list[at(list, 'collect 4640', (g) => g.t === 'collect' && g.item === 4640)];
	const spots = (goal.spots || []).filter((s) => !s.alt);
	assert.ok(spots.length >= 8, `the arrow searches his loop: ${JSON.stringify(goal.spots)}`);
	assert.ok(spots.some((s) => s.x > 55) && spots.some((s) => s.x < 15), 'from the east of the zone to Camp Boff');
});

// Alliance 40-60 (0.3.6): a group that hands in The Flame's Casing (3452) stood next to the rest of
// Velarok Windblade's chain and walked away from it: The Torch of Retribution (3453, 3454), Squire Maltrake (3462),
// Set Them Ablaze! (3463, the four Sentry Braziers on the Cauldron's southern rim) and Trinkets... (3481), 13,710 XP,
// all given and taken at Velarok's spot. The chain now follows the hand-in, the braziers on the way south to the
// horn and the outhouse, Set Them Ablaze! handed in on the way back to Thorium Point.
test('Searing Gorge (Alliance 48-49): The Flame\'s Casing group carries on with the Torch of Retribution chain', { skip }, () => {
	const sg = goals('forever/alliance/40-50/06-searing-gorge.guide');
	const casing = at(sg, 'turnin 3452', is('turnin', 3452));
	const gated = (i) => (sg[i].step.when || []).some((p) => !p.neg && ((p.k === 'group' && [p.q].flat().includes(3452)) || (p.k === 'onquest' && [].concat(p.q).some((q) => [3453, 3463].includes(q)))));
	let prev = casing;
	for (const [t, q] of [['accept', 3453], ['turnin', 3453], ['accept', 3454], ['turnin', 3454], ['accept', 3462], ['turnin', 3462], ['accept', 3463]]) {
		const i = at(sg, `${t} ${q}`, is(t, q));
		assert.ok(i > prev - (t === 'accept' && q === 3453 ? 1 : 0) && gated(i), `${t} ${q} follows the casing, only for its group`);
		prev = i;
	}
	const braziers = sg.filter(({ goal }) => goal.t === 'interact' && goal.quest === 3463);
	assert.equal(braziers.length, 4, 'all four Sentry Braziers');
	const done = at(sg, 'turnin 3463', is('turnin', 3463));
	assert.ok(gated(done) && done > at(sg, 'turnin 4451', is('turnin', 4451)), 'Set Them Ablaze! handed in after the outhouse');
	assert.ok(done < at(sg, 'turnin 7722', is('turnin', 7722)), 'before Thorium Point');
	assert.ok(at(sg, 'turnin 3481', is('turnin', 3481)) > done, 'Trinkets... at the hoard beside the squire');
});

// Final route review leftover, Alliance 40-43 (0.3.6): every Alliance race but Humans walks onto the Ratchet dock for the
// Booty Bay boat at 41, 30 yd from the flight master, and the Badlands guide sends Warlocks back to Strahad Farsan in
// Ratchet at 43 with `fly "Ratchet"` for Dwarves, Gnomes, Night Elves and Skyborne; only Gnome Warlocks learned the
// flight path. Every one of those Warlocks now learns it at the dock.
test('Stranglethorn Vale (Alliance 41): every Warlock who flies to Ratchet at 43 learns its flight path at the boat', { skip }, () => {
	const list = goals('forever/alliance/40-50/01-stranglethorn-vale.guide');
	const fits = (o, race) => !o || ((!o.races || o.races.includes(race)) && (!o.classes || o.classes.includes('WARLOCK')));
	for (const race of ['Dwarf', 'Gnome', 'NightElf', 'Skyborne']) {
		const mine = list.filter(({ step, goal }) => fits(step.only, race) && fits(goal.only, race));
		const fp = mine.findIndex(({ goal }) => goal.t === 'getfp' && goal.location === 'Ratchet');
		const boat = mine.findIndex(({ goal }) => goal.t === 'goto' && goal.text === 'Boat to Booty Bay');
		assert.ok(fp >= 0 && boat >= 0 && fp <= boat, `${race} Warlocks learn the Ratchet flight path before the boat`);
	}
});

// Flow review, Alliance 40 (0.3.6): Mudrock Soup and Bugs (1204) was handed to Morgan Stern on a ride back from Sentry
// Point to Theramore and out past Sentry Point again; it now goes in on the second Theramore stop, with Stinky's
// Escape to the same NPC.
test('Dustwallow Marsh (Alliance 40): Mudrock Soup and Bugs handed in with Stinky\'s Escape, no ride back from Sentry Point', { skip }, () => {
	const list = goals('forever/alliance/40-50/01-stranglethorn-vale.guide');
	const soup = at(list, 'turnin 1204', is('turnin', 1204));
	assert.equal(list[soup].step, list[at(list, 'turnin 1222', is('turnin', 1222))].step, 'on the stop that hands Stinky in');
	assert.equal(list[at(list, 'accept 1258', is('accept', 1258))].step, list[soup].step, '... and Bugs taken there');
	const sentry = at(list, 'turnin 1265', is('turnin', 1265));
	const manor = at(list, 'accept 1218', is('accept', 1218));
	assert.ok(!list.slice(sentry, manor).some(({ step }) => step.title === 'Theramore'), 'Sentry Point straight on to Swamplight Manor');
});

// Hurley (Helping Hands), the lost horse (Rescue Roundup), Fuzzle (Biting the Hand), Dunston Willis (Dunston
// Checks Out) and Jom-jom (Jom-jom's Escape) set off as soon as their quest is taken: recorded players who did
// something else first failed Helping Hands at Turner's Logging Camp and took it again.
test('Riverglades: an escort is taken and walked in one step, so its NPC never sets off without the player', () => {
	const ESCORTS = [94861, 94992, 94963, 94927, 94556];
	const seen = new Set();
	for (const f of riverglades()) {
		for (const step of fs.readFileSync(f, 'utf8').split(/\n(?=step\b)/)) {
			const lines = step.split('\n').map(codeOf);
			for (const q of ESCORTS) {
				const taken = lines.findIndex((l) => new RegExp(`^\\s+accept ${q}\\b`).test(l));
				if (taken < 0) continue;
				seen.add(q);
				const walked = lines.findIndex((l) => new RegExp(`^\\s+complete ${q}\\b`).test(l));
				assert.ok(walked > taken, `${path.basename(f)}: ${lines[0]}: escort ${q} is walked in the step that takes it`);
			}
		}
	}
	assert.deepEqual([...seen].sort(), [...ESCORTS].sort(), 'every escort of the zone is in the guides');
});

// Demar Brant offers The Western Front, and Ashe Amberhall A Small Favor, only once Curious Trinkets and Scraps of
// Knowledge are handed in (players' offer windows): in the keep, Ashe's hand-ins come first.
test("Riverglades: Ashe Amberhall's Sunnyglade hand-ins come before The Western Front and A Small Favor", () => {
	const lines = fs.readFileSync(RG_ALLIANCE, 'utf8').split('\n').map(codeOf);
	const first = (verb, q) => lines.findIndex((l) => new RegExp(`^\\s+${verb} ${q}\\b`).test(l));
	for (const q of [94886, 94907]) {
		assert.ok(first('accept', q) >= 0, `${q} is taken`);
		for (const t of [94881, 94879]) {
			assert.ok(first('turnin', t) >= 0 && first('turnin', t) < first('accept', q), `${t} is handed in before ${q} is taken`);
		}
	}
});

// Benjy Wheeler offers Freshwater Fiends before My Kingdom for a Horse (players' offer windows), and its Mudfin murlocs
// drop Halligan Turner's murloc heads: one sweep along the river does both, instead of a second murloc hunt later.
test("Riverglades: Benjy Wheeler's murlocs and Halligan Turner's murloc heads are one sweep", () => {
	const steps = rivergladesSteps(RG_ALLIANCE);
	const sweep = steps.findIndex((lines) => anyLine(lines, /^\s+collect 267266\b/));
	assert.ok(sweep >= 0, 'the murloc heads are collected');
	for (const npc of [258574, 258573]) {
		assert.ok(anyLine(steps[sweep], new RegExp(`^\\s+kill ${npc}\\b.*\\bquest 94614\\.`)), `the heads' step kills ${npc} for Freshwater Fiends`);
	}
	const taken = steps.findIndex((lines) => anyLine(lines, /^\s+accept 94614\b/));
	assert.ok(taken >= 0 && taken < sweep, 'Freshwater Fiends is taken before the sweep');
});

// No class trainer stands in the Riverglades, and the Badlands & Hinterlands guide passes none: the Alliance trains in
// Stormwind at the end of the Riverglades guide whatever quests they carry, shamans in Ironforge (Stormwind has none),
// then flies to Thelsamar for the Badlands.
test('Riverglades: the Alliance trains at the end of the Riverglades guide and flies on to Thelsamar', () => {
	const steps = rivergladesSteps(RG_ALLIANCE);
	const questGated = (lines) => anyLine(lines, /^\s+when !?(onquest|complete|turnedin|available|level)\b/);
	assert.ok(steps.some((l) => anyLine(l, /^\s+fly "Stormwind"/) && anyLine(l, /^\s+only !Shaman\b/) && !questGated(l)), 'everyone but shamans flies to Stormwind');
	assert.ok(steps.some((l) => anyLine(l, /^\s+train class only .*\bWarrior\b/) && !questGated(l)), 'the class trainer step');
	assert.ok(steps.some((l) => anyLine(l, /^\s+train class only Shaman\b/) && anyLine(l, /^\s+fly "Ironforge"/) && !questGated(l)), 'shamans train in Ironforge');
	assert.ok(anyLine(steps[steps.length - 1], /^\s+fly "Thelsamar"/), 'the guide ends with the flight to Thelsamar');
	assert.ok(!steps.some((l) => anyLine(l, /^\s+abandon\b/)), 'nothing carried in is dropped: the Stranglethorn and Badlands quests are handed in on the route');
});

// 0.4.0 route audit, binds sweep (the addon's own travel planner on every Alliance start): the Stormwind bind on the
// Stranglethorn guide's Stormwind stop and the Aerie Peak bind on the Badlands guide's first Aerie Peak visit are never
// hearthed to before the next bind; both are gone.
test('Stranglethorn and the Badlands (Alliance 42-43): no Stormwind or Aerie Peak bind the route never hearths to (0.4.0 audit)', { skip }, () => {
	const bind = (guide, re) => goals(guide).some(({ goal }) => goal.t === 'sethome' && re.test(goal.location || goal.label || JSON.stringify(goal)));
	assert.ok(!bind('forever/alliance/40-50/01-stranglethorn-vale.guide', /Stormwind/), 'no Stormwind bind in 40-50/01');
	assert.ok(!bind('forever/alliance/40-50/02-badlands.guide', /Aerie Peak/), 'no Aerie Peak bind in 40-50/02');
	assert.ok(bind('forever/alliance/40-50/01-stranglethorn-vale.guide', /Booty Bay/), 'the Booty Bay bind stays');
});

// 0.4.0 route audit (F3), Alliance 40: the Humans' riding branch (Jaina, the boat to Menethil, Stormwind, Eastvale) only
// shows from level 40, but its Darkshire -> Booty Bay flight did not, and Humans had no Ratchet step: the level model has
// them at 39.8 at Balos Jacken, so a Human under 40 was pointed at Darkshire from Dustwallow Marsh. Every race below 40
// now takes the Booty Bay boat from Ratchet (one step, no longer one pair per race and class mix), and everyone who
// passes Ratchet's gryphon master by the dock learns the flight path.
test('Stranglethorn Vale (Alliance 40): every race takes the Booty Bay boat from Ratchet below 40, and learns the flight path there (0.4.0 audit)', { skip }, () => {
	const all = goals('forever/alliance/40-50/01-stranglethorn-vale.guide');
	const firstBB = at(all, 'turnin 627', is('turnin', 627));
	for (const race of ['Human', 'Dwarf', 'Gnome', 'NightElf', 'Skyborne']) {
		const list = all.filter(forRaceOf(race)).filter(forClass('WARRIOR'));
		const boat = list.filter(({ goal }) => goal.t === 'goto' && goal.text === 'Boat to Booty Bay');
		assert.equal(new Set(boat.map(({ s }) => s)).size, 1, `${race}: one Booty Bay boat step`);
		assert.ok(list.some(({ goal }) => goal.t === 'getfp' && goal.location === 'Ratchet'), `${race}: Ratchet's flight path at the dock`);
	}
	const human = all.filter(forRaceOf('Human'));
	const lvl = (e, op) => (e.step.when || []).some((w) => w.k === 'level' && JSON.stringify(w).includes(op));
	const humanBoat = human.find(({ goal }) => goal.t === 'goto' && goal.text === 'Boat to Booty Bay');
	assert.ok(lvl(humanBoat, '<'), 'the Humans\' boat is for those under 40');
	for (const e of human.filter(({ goal, s }) => s < firstBB && goal.t === 'fly' && /Booty Bay/.test(goal.location || ''))) {
		assert.ok(lvl(e, '>='), 'the Darkshire flight to Booty Bay only for Humans who took the riding trip at 40');
	}
});

// 0.4.0 route audit (redo of a 0.3.7 grind fix), Alliance 49-50: Un'Goro's written grind ("Level 49.51" and the in-step
// top-ups to 49.6 and 49.79) sat before Marshal's Refuge, whose hand-ins cover it (up to 26.8k XP to go, 32.4k ready).
// One "Level 49.79" now follows the refuge's hand-ins, for whoever is still short. Since the 0.4.0 fix round the
// refuge's last hand-ins on this first visit are J.D. Collie's crystals and Muigin's petals (Making Sense of It waits for
// the later Un'Goro visit).
test("Un'Goro Crater (Alliance 49-50): the written grind comes after Marshal's Refuge's hand-ins (0.4.0 audit)", { skip }, () => {
	const list = goals('forever/alliance/40-50/07-un-goro-crater.guide');
	const grind = list.map((e, i) => [e, i]).filter(([{ goal }]) => goal.t === 'level' && goal.level === 49);
	assert.ok(!list.some(({ goal }) => goal.quest === 4321), 'Making Sense of It on the later visit');
	const refuge = Math.max(at(list, 'turnin 4141', is('turnin', 4141)), at(list, 'turnin 4284', is('turnin', 4284)));
	assert.ok(grind.length >= 1, 'a level 49 top-up');
	for (const [, i] of grind) assert.ok(i > refuge, 'every Un\'Goro top-up to 49.x comes after the refuge\'s hand-ins');
});

// Bennistrov's report (#1999): the Feralas High Wilderness step ground to level 44.5 on the Rage Scar yetis (46-48) at
// 43-44. The level-45 grind came first, on the Feral Scar yetis (43-45), and the Rage Scar yetis' hides after it. Level
// tidy 0.4.0: the Rage Scar yetis (46-49) are still two or more over the 45 player there, so Improved Quality and the
// Pristine Yeti Hide are left out: the guide never sends you to them.
test("Bennistrov's report (#1999): Feralas never sends you to the Rage Scar yetis", { skip }, () => {
	const list = goals('forever/alliance/40-50/03-feralas.guide');
	const at45 = list.findIndex(({ goal }) => goal.t === 'level' && goal.level >= 45);
	assert.ok(at45 >= 0, 'a level-45 grind');
	const rageScar = new Set([5296, 5297, 5299]); // Rage Scar Yeti 46, Ferocious Rage Scar 47, Elder Rage Scar 48
	const onRageScar = ({ goal }) => (goal.t === 'level' && rageScar.has(goal.grind)) || (goal.t === 'kill' && rageScar.has(goal.npc)) ||
		(goal.t === 'collect' && [18947, 18969].includes(goal.item)) || [7733, 7735].includes(goal.quest);
	assert.deepEqual(list.filter(onRageScar).map(({ goal }) => `${goal.t} ${goal.quest || goal.item || goal.npc || goal.grind}`), [], 'no Rage Scar work');
});


// 0.4.0 route audit (F5): the first Booty Bay loop runs at about 40 against level 40-43 Bloodsail casters; players died
// in the camp and on the Wild Shore (4 people, 9 deaths in players' recordings). Both steps warn. Since the 0.4.0 fix
// round the Wild Shore's charts and orders wait for the Hinterlands guide's Booty Bay leg (about 48), where those
// casters are under the player: the step there still names them.
test('Stranglethorn Vale (Alliance 40): the Bloodsail camp and the Wild Shore warn of the 40-43 casters (0.4.0 audit)', { skip }, () => {
	const list = goals('forever/alliance/40-50/01-stranglethorn-vale.guide');
	assert.match(JSON.stringify(list[at(list, 'collect 4027', (g) => g.t === 'collect' && g.quest === 610)].step), /Careful: the [^"]*4[0-3]/, 'collect 4027: a heads-up');
	assert.ok(!list.some(({ goal }) => goal.quest === 604 && goal.t !== 'accept'), 'no Wild Shore work at about 40');
	const hin = goals('forever/alliance/40-50/05-the-hinterlands.guide');
	assert.match(JSON.stringify(hin[at(hin, 'kill 1563', (g) => g.t === 'kill' && g.quest === 604)].step), /Swashbucklers \(4[0-3]-4[0-3]\)/, 'kill 1563: the casters named where they are worked');
});

// 0.4.0 route audit (F14, the #1508/#1518 pattern): the way from Ironforge to Thelsamar at the end of the Stranglethorn
// guide went by race (Humans, Night Elves, Skyborne fly; Dwarves and Gnomes ride). It goes by the flight path the
// character knows, and whoever just rode out to Dun Morogh's riding trainers rides on through the tunnel. Since the 0.4.0
// fix round the Stranglethorn guide ends in Ironforge (Ghak's mushrooms are taken where the Riverglades guide's flight to
// Thelsamar lands), so the way to Thelsamar is the Riverglades guide's last leg: by the known flight path there too.
test('Stranglethorn Vale (Alliance 42): Ironforge to Thelsamar by the known flight path, not by race (0.4.0 audit)', { skip }, () => {
	assert.ok(!goals('forever/alliance/40-50/01-stranglethorn-vale.guide').some(({ goal }) => goal.t === 'fly' && goal.location === 'Thelsamar'), 'no Thelsamar trip and back in Stranglethorn');
	const list = goals('forever/alliance/40-50/01b-riverglades.guide');
	const flights = list.filter(({ goal }) => goal.t === 'fly' && goal.location === 'Thelsamar');
	assert.ok(flights.length > 0, 'the Riverglades guide flies to Thelsamar');
	for (const fly of flights) {
		assert.ok(!fly.step.only, 'the flight is for every race');
		assert.ok((fly.step.when || []).some((w) => w.k === 'taxi' && !w.neg), 'the flight needs the flight path');
	}
	const rides = list.filter(({ step, goal }) => step.title === 'Loch Modan' && goal.t === 'goto');
	assert.ok(rides.some(({ step }) => (step.when || []).some((w) => w.k === 'taxi' && w.neg)), 'a ride for whoever lacks the flight path');
	assert.ok(rides.every(({ step }) => !step.only), 'no race split');
});

// 0.4.0 route audit (R1, Riverglades): a player who takes the Riverglades from Thelsamar and comes back to the Feralas
// guide at 43+ skips the Badlands guide, where Aerie Peak's flight path is learned. The Tanaris guide's way to Aerie Peak
// flies there only with the flight path; without it, it flies to Southshore and rides north-east, and the flight path
// is learned on arrival.
test('Tanaris (Alliance 47): the way to Aerie Peak without its flight path, for Riverglades players (0.4.0 audit)', { skip }, () => {
	const list = goals('forever/alliance/40-50/04-tanaris.guide');
	const fly = list[at(list, 'fly Aerie Peak', (g) => g.t === 'fly' && g.location === 'Aerie Peak')];
	assert.ok((fly.step.when || []).some((w) => w.k === 'taxi' && !w.neg), 'the flight needs the flight path');
	const ss = list[at(list, 'fly Southshore', (g) => g.t === 'fly' && g.location === 'Southshore')];
	assert.ok((ss.step.when || []).some((w) => w.k === 'taxi' && w.neg), 'Southshore for whoever lacks it');
	assert.ok(list.some(({ goal }) => goal.t === 'getfp' && goal.location === 'Aerie Peak'), 'learned on arrival');
});

// Pysch_MC's report (#2199): Forever names npc 5858 "Searing Lava Spider", and the Searing Gorge guide's step for Fiery
// Menace! (7724) called them Greater Lava Spiders, so the player looked for a mob that isn't there. The step, its goal's
// name and the seed's copy use the game's name.
test("Pysch_MC's report (#2199): the Searing Gorge guide names the Searing Lava Spiders as the game does", { skip }, () => {
	for (const file of ['forever/alliance/40-50/06-searing-gorge.guide']) {
		const list = goals(file);
		const spiders = list[at(list, 'kill 5858', (g) => g.t === 'kill' && g.npc === 5858)];
		assert.equal(spiders.step.title, 'Searing Lava Spiders', `${file}: the step's title`);
		const text = fs.readFileSync(path.join(OFFICIAL_DIR, file), 'utf8');
		assert.ok(!/Greater Lava Spider/.test(text), `${file}: no "Greater Lava Spider" left`);
	}
	const seed = fs.readFileSync(path.join(ROOT, 'forge', 'seed', 'guides', 'forever', 'alliance', '40-50', '06-searing-gorge.guide'), 'utf8');
	assert.ok(!/Greater Lava Spider/.test(seed), 'the seed copy too');
});

// Bennistrov's and Visur's report (#2207): the Tanaris guide's Dunemaul Compound step grinds to 47.06, almost a level
// for a player at 46.1. The gate stays (lower, the Thistleshrub Valley's level-50 quests and 48-50 mobs would come 3+
// levels over); the step now says why, and the grind is on the level 45-46 Ogres at the compound's south end.
test("Bennistrov's and Visur's report (#2207): the Dunemaul grind says why, and grinds on the safer ogres", { skip }, () => {
	const list = goals('forever/alliance/40-50/04-tanaris.guide');
	const dune = list.find(({ goal }) => goal.t === 'level' && goal.level === 47 && goal.frac);
	assert.ok(dune, 'the written grind at the compound');
	assert.equal(dune.goal.grind, 5471, 'the grind on the Dunemaul Ogres (45-46), not the Brutes');
	const text = JSON.stringify(dune.step);
	assert.match(text, /Thistleshrub Valley/, 'why: the Thistleshrub Valley next');
	assert.match(text, /Ogres \(45-46\)/, 'the safer ogres');
});

// Route feel (0.4.0 audit): the boat from Auberdine lands below Rut'theran Village; the guide walked up to Daryn and
// Erelas and then, before handing in, back down to Vesprystus for the flight path and up again (about 160 yd each way,
// the hand-ins and Favored of Elune? some minutes later). The flight path is learned on the way up, first.
test("Tanaris (Alliance 47): Rut'theran's flight path on the way up from the boat, then Daryn and Erelas (0.4.0 audit)", { skip }, () => {
	const list = goals('forever/alliance/40-50/04-tanaris.guide');
	const fp = at(list, "getfp Rut'theran", (g) => g.t === 'getfp' && g.location === "Rut'theran Village");
	for (const [t, q] of [['turnin', 2939], ['turnin', 3022], ['accept', 3661]]) {
		const i = at(list, `${t} ${q}`, is(t, q));
		assert.ok(fp < i, `the flight path before ${t} ${q}`);
		assert.notEqual(list[fp].s, list[i].s, `the flight path in its own step, before the ${t} ${q} stop`);
	}
});

// #2300 (Edet, Human Warlock 48): Searing Gorge (Alliance 40-50) sent the player alone to Zamael Lunthistle for Prayer
// to Elune, "the night elf stands alone west of Thorium Point"; he stands inside the Twilight camp at Firewatch Ridge
// among Twilight Fire Guards, Idolaters and Geomancers (level 48-49 elites in Forever's creature data) within 10 yards,
// with Highlord Mastrogonde (51, rare elite) beside him, and the player died there. Its second part (3378) is already a
// group quest of 4 for the same camp; the first part is one now: its three steps wait for the player's group answer,
// and the tip names the camp.
test('#2300: Searing Gorge (Alliance): Prayer to Elune waits for a group, among the Twilight camp\'s elites', { skip }, () => {
	const list = goals('forever/alliance/40-50/06-searing-gorge.guide');
	const zamael = list.filter(({ goal }) => goal.quest === 3377);
	assert.deepEqual(zamael.map(({ goal }) => goal.t), ['accept', 'talk', 'turnin'], 'accept, talk and hand-in');
	for (const { step, goal } of zamael) {
		assert.ok((step.when || []).some((p) => p.k === 'group' && !p.neg && [p.q].flat().includes(3377)), `${goal.t} 3377 waits for \`when group 3377\``);
	}
	const talk = zamael.find(({ goal }) => goal.t === 'talk').goal;
	assert.equal(talk.group && talk.group.size, 4, 'the talk says a group of 4');
	const tip = [zamael[0].step.note, zamael[0].step.tip].flat().filter(Boolean).join(' ');
	assert.doesNotMatch(tip, /stands alone/, 'not "stands alone"');
	assert.match(tip, /Twilight camp/, 'the tip names the Twilight camp');
});

// Level tidy 0.4.0, Alliance 40-50 reports. PRDesrochers/Bennistrov (#1917): leaving Theramore without the Soothing
// Spices left Jarl's hand-in with no way to get them; the Swamplight Manor step buys them from Helenia Olden before
// the hand-in. Fyurie (#2448): the Tanaris guide ended with a ride to Rhapsody's camp for players without Rhapsody's
// Kalimdor Kocktail, then a trip to the Violet Tragan pool; the ride is only for players carrying 1452. Fyurie
// (#2396): the Sandsorrow pool step says to tap the pool and warns of the Scarabs that come out.
test('Alliance 40-50 reports: Jarl\'s spices bought before the hand-in (#1917), no empty Rhapsody ride (#2448), the pool\'s Scarabs (#2396)', { skip }, () => {
	const stv = goals('forever/alliance/40-50/01-stranglethorn-vale.guide');
	const hand = at(stv, 'turnin 1218', is('turnin', 1218));
	const buy = stv.findIndex(({ goal, s }) => goal.t === 'buy' && goal.item === 3713 && s === stv[hand].s);
	assert.ok(buy >= 0 && stv[buy].s === stv[hand].s && buy < hand, 'the spices are bought on the Swamplight Manor step, before the hand-in');
	const tan = goals('forever/alliance/40-50/04-tanaris.guide');
	const ride = tan.find(({ goal }) => goal.t === 'goto' && /Rhapsody/.test(goal.text || goal.label || JSON.stringify(goal)));
	assert.ok(ride && (ride.step.when || []).some((p) => p.k === 'onquest' && !p.neg && [p.q].flat().includes(1452)), 'the ride to Rhapsody only with 1452 in the log');
	assert.ok(!tan.some(({ goal }) => goal.t === 'collect' && goal.quest === 2641), 'no trip to the pool at the end of Tanaris');
	const pool = tan[at(tan, 'the Sandsorrow pool', (g) => g.quest === 992 && g.t === 'use')];
	const tip = [pool.step.note, pool.step.tip].flat().filter(Boolean).join(' ');
	assert.match(tip, /tap it/, 'says to tap the pool');
	assert.match(tip, /Scarabs/, 'warns of the Scarabs');
});

// #2575 (rockzors, 0.4.0, Alliance Riverglades): What We Lost's only objective is the five graves (Loose Soil), so the
// arrow went to them before the player had the Farmers' Mementos the Twilight Raiders drop; each grave takes one.
// The graves' goal says so on its line.
test('#2575: Riverglades (Alliance): the Loose Soil goal says to loot the Farmers\' Mementos from the Twilight Raiders first', { skip }, () => {
	const list = goals('forever/alliance/40-50/01b-riverglades.guide');
	const { goal } = list[at(list, 'the Loose Soil goal', (g) => g.t === 'interact' && g.quest === 94829)];
	assert.match(goal.note || '', /Farmers' Mementos|\{item:266148\}/, goal.note);
	assert.match(goal.note || '', /Twilight Raiders|\{npc:256952\}/, goal.note);
});

// #2604 (Amerigo, 0.4.0, Alliance Stranglethorn 40-50): the Skullsplitter Tusks goal's third spot sent a player north
// to Zul'Kunda, where only two named trolls drop them. Every Skullsplitter troll drops tusks, and their camp is the
// ruins of Zul'Mamwe (42-49,30-42); the goal points there, as the Horde one does, so Zul'Kunda is only an alternative.
test('#2604: Stranglethorn (Alliance): Skullsplitter Tusks are looked for in the trolls\' camp at Zul\'Mamwe', { skip }, () => {
	const list = goals('forever/alliance/40-50/01-stranglethorn-vale.guide');
	const { goal } = list[at(list, 'collect 1524', (g) => g.t === 'collect' && g.quest === 209)];
	assert.equal(goal.map, 1434);
	assert.ok(goal.x >= 42 && goal.x <= 49 && goal.y >= 30 && goal.y <= 42, `the trolls' camp: ${goal.x},${goal.y}`);
	for (const s of goal.spots || []) assert.ok(s.alt || s.x > 35, `no spot the arrow picks far from the ruins: ${s.x},${s.y}`);
});
