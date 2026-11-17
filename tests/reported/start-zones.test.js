'use strict';
// Player-reported guide fixes: checks across both factions' start zones.
// tests/reported/helpers.js says what the cases check and where a new one goes.

const { test } = require('node:test');
const assert = require('node:assert/strict');
const fs = require('node:fs');
const path = require('node:path');
const {
	allGuides, at, buildSimPack, compiled, DUN_MOROGHS, DUROTARS, DWARF_DUN_MOROGH, ELWYNN, goals, is, loadCorrections,
	located, MULGORE, ORC_DUROTAR, playGuide, refData, ROOT, SIMULATE, skip, SKYBORNE_HORDE, stepView, TELDRASSIL,
	TIRISFAL, TROLL_DUROTAR, ZEPHRAS_ALLIANCE, ZEPHRAS_HORDE,
} = require('./helpers');

const SKYBORNE_ALLIANCE = { race: 'Skyborne', raceName: 'Skyborne', faction: 'Alliance', cls: 'ROGUE', className: 'Rogue', level: 4 };
// Zephras Isle has no Era frame: points compare in map percent.
const close = (a, b, pct) => a.map === b.map && Math.hypot(a.x - b.x, a.y - b.y) <= pct;

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

test(`EpicTibbles's report (#565): a Hunter's Taming the Beast beast reads "Tame", not "Kill", in every guide`, { skip }, () => {
	// The data counts the tame as kill credit on the beast, so the goal stays
	// a `kill` tracking the objective; its text is what the guide window shows.
	refData();
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
			const q = goal.t === 'kill' && goal.quest && refData().quests[goal.quest];
			if (q && /Taming Rod to tame/.test(q.objectiveText || '')) {
				assert.match(goal.text || '', /^Tame /, `${guide}: ${goal.quest}.${goal.oi}`);
				seen++;
			}
		}
	}
	assert.ok(seen >= 21, `the seven Hunter starting guides' 21 tames (found ${seen})`);
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

// A Last Request (93927): the game's objective 1 is the Bloody Note ("Collect
// and read the note"), 2 is Skypriest Aanders (players' recordings, Forever's
// quest data). Written swapped, the note goal followed Aanders' line and stayed
// open after the note was read.
test('Zephras Isle: A Last Request\'s note and Skypriest Aanders count the objectives the game gives them (#825)', { skip }, () => {
	const order = fs.readFileSync(path.join(ROOT, 'forever-db', 'data', 'quest_objective.jsonl'), 'utf8').split('\n').filter(Boolean).map((l) => JSON.parse(l)).filter((o) => o.quest === 93927);
	const n = (target) => order.find((o) => o.target === target).n;
	assert.deepEqual([n(254871), n(256966)], [1, 2], 'Forever\'s quest data: the note first, Aanders second');
	for (const guide of ['forever/alliance/skyborne/01-zephras-isle.guide', 'forever/horde/skyborne/01-zephras-isle.guide']) {
		const list = goals(guide);
		const note = list[at(list, `${guide}: the Bloody Note`, (g) => g.t === 'collect' && g.item === 254871 && g.quest === 93927)].goal;
		const aanders = list[at(list, `${guide}: Skypriest Aanders`, (g) => g.t === 'kill' && g.npc === 256966 && g.quest === 93927)].goal;
		assert.deepEqual([note.oi, aanders.oi], [n(254871), n(256966)], guide);
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

// The Great Outdoors: /sit by Raan's campfire for Boosted Rest; nothing to click.
test('Sato\'s report: The Great Outdoors on Zephras Isle is done by sitting at Raan\'s campfire, not by clicking it', { skip }, () => {
	refData();
	const fire = refData().spawns('object', 460003).find((x) => x.map === 2521);
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

// --- Thendal Grove (Alx-Ryan, #363): the guide walked you to Rorian, up the
// watchtower a few steps from Elatrell, then floated you back down to Rorian.
// The tower comes first now: The Anchors of Zephras and Falling With Style
// (both need level 2 and nothing else), then the Walk on Air glide down to
// Rorian, who takes Harmony in Balance and Falling With Style on one visit.
// Falling With Style counts the Walk on Air cast at the top of the tower (players' recordings: the line "Use Walk
// on Air" at every accept, done on the tower's top), so its goal is there, before Rorian's hand-ins.

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
		const cast = at(list, `${guide}: complete 92474`, is('complete', 92474));
		assert.ok(cast < harmony, `${guide}: Walk on Air before Rorian's hand-ins`);
		assert.ok(Math.hypot(list[cast].goal.x - 43.7, list[cast].goal.y - 24.1) < 1, `${guide}: on the tower's top (${list[cast].goal.x},${list[cast].goal.y})`);
	}
});

test(`𝔄𝔫𝔫𝔦𝔢's report (#285): on Zephras Isle, every objective of a quest is sent for before its turn-in; the Enchanted Gyrozephyr at its spawns`, { skip }, () => {
	refData();
	for (const guide of [ZEPHRAS_ALLIANCE, ZEPHRAS_HORDE]) {
		const list = goals(guide);
		list.forEach(({ goal }, i) => {
			if (goal.t !== 'turnin') return;
			const q = refData().quest(goal.quest);
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
	const spawns = refData().spawns('object', 616466).find((x) => x.map === 2521).pts;
	assert.ok(spawns.some(([x, y]) => close(list[gyro].goal, { map: 2521, x, y }, 1)), `the arrow's point ${list[gyro].goal.x},${list[gyro].goal.y} is at a gyrozephyr`);
});

// --- The Wounds of Betrayal (Phear, #395): the Alliance Zephras Isle guide
// wrote it as a bare `complete`, which has no place, so the step had no arrow
// into the Nightfang Den; the Horde guide points at the druids and Jorel.
// Standing Our Ground was the same. Each objective of these quests is its own
// goal with a place, before the turn-in, in both guides.

test(`Phear's report (#395): on Zephras Isle, The Wounds of Betrayal and Standing Our Ground lead to each objective, in both guides`, { skip }, () => {
	refData();
	for (const guide of [ZEPHRAS_ALLIANCE, ZEPHRAS_HORDE]) {
		const list = goals(guide);
		for (const quest of [94489, 92693]) {
			const take = at(list, `${guide}: accept ${quest}`, is('accept', quest));
			const give = at(list, `${guide}: turnin ${quest}`, is('turnin', quest));
			const between = list.slice(take + 1, give).filter(({ goal }) => goal.quest === quest);
			assert.deepEqual(between.filter((x) => !located(x)).map(({ goal }) => goal.t), [], `${guide}: every goal of ${quest} has a place for the arrow`);
			const objectives = refData().quest(quest).objectives.map((_, i) => i + 1);
			assert.deepEqual(objectives.filter((oi) => !between.some(({ goal }) => goal.oi === oi)), [], `${guide}: every objective of ${quest} has its goal before the turn-in`);
		}
	}
});

// Camping 101 accepts and their givers' prerequisites: Eric Brighthammer offers Blacksmithing (96044) only once
// Supplies to Tannok (2160) is handed in, Brakk offers Tailoring (96102) only once A Peon's Burden (2161) and
// Camping 101: Cooking (96655) are (players' recordings). A Camping step placed before those hand-ins was
// passed with the quest not offered, and the guide never came back to it.
test('Start zones: a Camping 101 accept comes after the hand-ins its giver waits for', { skip }, () => {
	const cases = [...DUN_MOROGHS.map((g) => [g, 96044, [2160]]), ...DUROTARS.map((g) => [g, 96102, [2161, 96655]])];
	for (const [guide, quest, pres] of cases) {
		const list = goals(guide);
		const take = at(list, `accept ${quest}`, is('accept', quest));
		for (const pre of pres) {
			assert.ok(at(list, `turnin ${pre}`, is('turnin', pre)) < take, `${guide}: ${pre} is handed in before ${quest} is taken`);
		}
		const hand = list.findIndex(({ goal }) => is('turnin', quest)(goal));
		assert.ok(hand < 0 || take < hand, `${guide}: ${quest} is taken before its hand-in`);
	}
});
