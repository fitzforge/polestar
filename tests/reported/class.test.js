'use strict';
// Player-reported guide fixes: the class guides (guides/forever/class).
// tests/reported/helpers.js says what the cases check and where a new one goes.

const { test } = require('node:test');
const assert = require('node:assert/strict');
const fs = require('node:fs');
const path = require('node:path');
const {
	allGuides, at, compiled, compileSources, Data, DATA, Diagnostics, goals, is, loadCorrections, loadData, needs,
	OFFICIAL_DIR, parseGuide, refData, ROOT, runAddon, skip, TOTEMS, USE_ITEM_873, writeTestPack,
} = require('./helpers');

const { writeCodexPack } = require('../helpers/codex');
function totemHeaders() {
	const items = Object.fromEntries([
		[5175, 'Earth Totem'], [5176, 'Fire Totem'], [5177, 'Water Totem'], [5178, 'Air Totem'],
		[6637, 'Water Sapta'], [263412, 'Totem of Charged Flames'],
		[280607, "Lightning's Grasp"], [280605, "Tidebringer's Claw"],
		[280604, 'Rage of the Storm'], [280696, "Elementalist's Guard"],
	].map(([id, name]) => [id, { id, name }]));
	const zones = Object.fromEntries([
		[1426, 'Dun Morogh'], [1411, 'Durotar'], [1413, 'The Barrens'],
		[1455, 'Ironforge'], [1454, 'Orgrimmar'],
	].map(([id, name]) => [id, { id, name }]));
	const headerData = new Data({ items, zones });
	const sources = TOTEMS.flatMap(([, element]) => ['alliance', 'horde'].map((side) => {
		const file = path.join(OFFICIAL_DIR, `forever/class/shaman/call-of-${element}-${side}.guide`);
		const text = fs.readFileSync(file, 'utf8');
		const firstStep = text.search(/^step(?:\s|$)/m);
		assert.ok(firstStep > 0, `${file}: the authored header ends before the steps`);
		return { file, text: text.slice(0, firstStep) + 'step\n  note Header lookup test\n' };
	}));
	const { guides, diag } = compileSources(sources, headerData);
	assert.deepEqual(diag.sorted(), []);
	assert.equal(guides.length, 8);
	return { guides, headerData };
}

// These approaches contain only explicit coordinates and quest-state predicates, so
// exercise their actual source without the optional reference data. The task after
// each approach makes its applicability observable without the later chain's work.
for (const [verb, quest] of [['accept', 98393], ['turnin', 98397]]) {
	test(`Cat Form: the entrance before ${verb} ${quest} is needed only until that visit is done (#2294)`, async (t) => {
		const file = path.join(OFFICIAL_DIR, 'forever/class/druid/cat-form.guide');
		const text = fs.readFileSync(file, 'utf8');
		const diag = new Diagnostics();
		const ast = parseGuide(text, file, diag);
		assert.deepEqual(diag.errors, []);
		const isVisit = (s) => s.goals.some((g) => g.verb === verb && g.quest === quest);
		assert.equal(ast.steps.filter(isVisit).length, 1, 'the visit is unambiguous');
		const visit = ast.steps.findIndex(isVisit);
		assert.ok(visit > 0, `the ${quest} visit has an approach`);
		const lines = text.split('\n');
		const source = [
			...lines.slice(0, ast.steps[0].line - 1),
			...lines.slice(ast.steps[visit - 1].line - 1, ast.steps[visit].line - 1),
			'step Continue after the visit', '  task "Continue"',
		].join('\n');
		const maps = new Data({ zones: {
			1450: { id: 1450, name: 'Moonglade', type: 3 },
			1457: { id: 1457, name: 'Darnassus', type: 3 },
		} });
		const compiled = compileSources([{ file, text: source }], maps);
		assert.deepEqual(compiled.diag.list, []);
		const approach = compiled.guides[0].steps[0];
		const door = approach.goals.find((g) => g.t === 'goto');
		assert.ok(door, 'keep the entrance needed to reach the upstairs trainer (#1338)');
		assert.deepEqual([door.map, door.x, door.y], [1457, 35.8, 11.6]);
		if (verb === 'accept') assert.ok(approach.goals.some((g) => g.t === 'level' && g.level === 20));
		const pack = writeTestPack(compiled.guides, maps);
		try {
			const loads = pack.scripts.map((f) => `assert(loadfile(${JSON.stringify(f)}))("Polestar_Guides", ns)`).join('\n');
			const states = ['untaken', 'held', 'turnedIn'].map((state) => ({ state, level: 20 }));
			if (verb === 'accept') states.push({ state: 'untaken', level: 19 });
			for (const race of ['NightElf', 'Skyborne']) {
				for (const { state, level } of states) {
					await t.test(`${race}, ${state}, level ${level}`, () => {
						const [out] = runAddon({
							stubs: ['stub_world.lua'],
							before: `local w = stub.world
								w.race, w.raceName, w.faction, w.class, w.className = "${race}", "${race}", "Alliance", "DRUID", "Druid"
								w.level = ${level}
								w.addMap(1450, {name="Moonglade", c=1, left=-1381.25, right=-3689.583, top=8491.666, bottom=6952.083})
								w.addMap(1457, {name="Darnassus", c=1, left=2938.363, right=1880.03, top=10238.316, bottom=9532.587})
								w.moveTo(1450, 40, 60)`,
							addons: [{ name: 'Polestar', files: ['Core/Core.xml'] }],
							saved: { Polestar: 'PolestarDB = {schema=1, settings={behavior={autoSelectGuide=false}}}' },
							script: `do local ns = {}
								${loads}
								end
								local w = stub.world
								${state !== 'untaken' ? `w.accept(${quest}, {})` : ''}
								${state === 'turnedIn' ? `w.turnIn(${quest})` : ''}
								stub.login(); stub.advance(0.5)
								local E = Polestar.Engine
								E.SetGuide("forever/class/druid/cat-form"); stub.advance(0.5)
								emit({step=E.GetStepIndex(), point=E.GetWaypoint(), firstDone=E.GetStepView(1).goals[1].status=="done"})`,
						}).emitted;
						const completed = state === 'turnedIn' || (verb === 'accept' && state === 'held');
						assert.equal(out.step, completed ? 2 : 1, 'only completed work makes this visit unnecessary');
						if (!completed && level === 20) assert.deepEqual([out.point.map, out.point.x, out.point.y], [1457, 35.8, 11.6]);
						if (level === 19) assert.equal(out.firstDone, false, 'the level goal still holds the approach');
					});
				}
			}
		} finally {
			fs.rmSync(pack.dir, { recursive: true, force: true });
		}
	});
}

for (const [side, race] of [['Alliance', 'Dwarf'], ['Horde', 'Orc']]) {
	test(`${side} Shaman totems: item Lookup opens the authored class guide (#2331, Logan)`, () => {
		const { guides, headerData } = totemHeaders();
		const pack = writeTestPack(guides, headerData);
		// A real serialized Codex pack lets the public action load normally.
		// It intentionally has no totem records: this tests curated selection,
		// not the generated quest chain or its unavailable Forever-only facts.
		const codex = writeCodexPack(require('../fixtures/codex/lookup.json'));
		try {
			const [opened, fallback] = runAddon({
				stubs: ['stub_world.lua', 'stub_encoding.lua'],
				before: `local w = stub.world
					w.race, w.raceName, w.faction = "${race}", "${race}", "${side}"
					w.class, w.className, w.classID, w.level = "SHAMAN", "Shaman", 7, 30
					${codex.stubLua}`,
				addons: ['Polestar', { name: 'Polestar_Guides', files: pack.scripts }],
				login: true,
				script: `local L, E, G = Polestar.Lookup, Polestar.Engine, Polestar.Guides
					local result = {}
					for _, item in ipairs({5175, 5176, 5177, 5178}) do
						local id, reason = L.Guide("item", item)
						result[#result + 1] = { opened = id or false, reason = reason or false,
							active = E.GetGuide() and E.GetGuide().id or false }
					end
					emit(result)
					-- Another class gets none of them: 0.4.0 never offers a guide of another class (#2462).
					stub.world.class, stub.world.className, stub.world.classID = "WARRIOR", "Warrior", 1
					local curated = L.CuratedGuide("item", 5177)
					local id = L.Guide("item", 5177)
					emit({ curated = curated or false, opened = id or false,
						matches = curated and G.GuideMatches(G.Get(curated), Polestar.Compat.GetPlayerInfo()) or false,
						active = E.GetGuide() and E.GetGuide().id or false })`,
			}).emitted;
			assert.deepEqual(opened.map((r) => r.opened), TOTEMS.map(([, element]) => `forever/class/shaman/call-of-${element}-${side.toLowerCase()}`));
			for (const row of opened) assert.equal(row.active, row.opened, 'the selected guide is active');
			for (const [item, element] of TOTEMS) for (const faction of ['alliance', 'horde']) {
				assert.deepEqual(guides.find((g) => g.id.endsWith(`call-of-${element}-${faction}`)).collects, [item], 'only the primary totem is indexed');
			}
			assert.equal(fallback.curated, false, 'a Warrior is never sent to a Shaman guide (#2462)');
			assert.notEqual(fallback.opened, `forever/class/shaman/call-of-water-${side.toLowerCase()}`);
		} finally {
			fs.rmSync(pack.dir, { recursive: true, force: true });
			codex.cleanup();
		}
	});
}

test("Tyr's Watch: Tanis Alderwood's goals carry his Undercity floor's height, from the Forever TDB when classic-db lacks him (#855)", { skip: skip || needs('spawnz.json') }, () => {
	const list = goals('forever/class/paladin/tyrs-watch.guide');
	for (const pred of [is('turnin', 94434), is('accept', 94435)]) {
		const { goal } = list[at(list, 'Tanis Alderwood', pred)];
		assert.equal(goal.npc, 257648);
		assert.ok(Math.abs(goal.z - -43) < 3, `${goal.t} ${goal.quest}: z ${goal.z} is the city level, not the ruins above`);
	}
});

// Read each actual entrance block so these quest-state regressions run even without
// optional reference data. A task after the block makes its applicability observable
// independently of the later chain; the original race, level and coordinates stay.
for (const [name, verb, quest, level, races] of [
	['aquatic-form', 'accept', 26, 16, ['NightElf', 'Skyborne']],
	['aquatic-form', 'turnin', 5061, 16, ['NightElf', 'Skyborne']],
	['cure-poison', 'accept', 6121, 14, ['NightElf']],
	['cure-poison', 'accept', 6121, 14, ['Skyborne']],
	['cure-poison', 'turnin', 6125, 14, ['NightElf', 'Skyborne']],
]) {
	test(`${name}: ${races.join('/')} entrance before ${verb} ${quest} follows quest progress (#2299)`, async (t) => {
		const file = path.join(OFFICIAL_DIR, `forever/class/druid/${name}.guide`);
		const text = fs.readFileSync(file, 'utf8');
		const diag = new Diagnostics();
		const ast = parseGuide(text, file, diag);
		assert.deepEqual(diag.errors, []);
		const isVisit = (s) => s.goals.some((g) => g.verb === verb && g.quest === quest)
			&& s.only.races.length === races.length && races.every((race) => s.only.races.includes(race));
		assert.equal(ast.steps.filter(isVisit).length, 1, 'the quest and races identify one visit');
		const visit = ast.steps.findIndex(isVisit);
		assert.ok(visit > 0, `the ${quest} visit has an approach`);
		const lines = text.split('\n');
		const source = [
			...lines.slice(0, ast.steps[0].line - 1),
			...lines.slice(ast.steps[visit - 1].line - 1, ast.steps[visit].line - 1),
			'step Continue after the visit', '  task "Continue"',
		].join('\n');
		const maps = new Data({ items: {
			// Header rewards, from forever-db/data/item.jsonl; no quest data are needed.
			15866: { id: 15866, name: 'Veildust Medicine Bag' },
			16608: { id: 16608, name: 'Aquarius Belt' },
			263411: { id: 263411, name: 'Idol of Shifting Tides' },
		}, zones: {
			1450: { id: 1450, name: 'Moonglade', type: 3 },
			1457: { id: 1457, name: 'Darnassus', type: 3 },
		} });
		const compiled = compileSources([{ file, text: source }], maps);
		assert.deepEqual(compiled.diag.list, []);
		const approach = compiled.guides[0].steps[0];
		const door = approach.goals.find((g) => g.t === 'goto');
		assert.ok(door, 'the upstairs trainer still has an entrance (#1338)');
		assert.deepEqual([door.map, door.x, door.y], [1457, 35.8, 11.6]);
		if (verb === 'accept') assert.ok(approach.goals.some((g) => g.t === 'level' && g.level === level));
		const pack = writeTestPack(compiled.guides, maps);
		try {
			const loads = pack.scripts.map((f) => `assert(loadfile(${JSON.stringify(f)}))("Polestar_Guides", ns)`).join('\n');
			const states = ['untaken', 'held', 'turnedIn'].map((state) => ({ state, playerLevel: level }));
			if (verb === 'accept') states.push({ state: 'untaken', playerLevel: level - 1 });
			for (const race of races) {
				for (const { state, playerLevel } of states) {
					await t.test(`${race}, ${state}, level ${playerLevel}`, () => {
						const [out] = runAddon({
							stubs: ['stub_world.lua'],
							before: `local w = stub.world
								w.race, w.raceName, w.faction, w.class, w.className = "${race}", "${race}", "Alliance", "DRUID", "Druid"
								w.level = ${playerLevel}
								w.addMap(1450, {name="Moonglade", c=1, left=-1381.25, right=-3689.583, top=8491.666, bottom=6952.083})
								w.addMap(1457, {name="Darnassus", c=1, left=2938.363, right=1880.03, top=10238.316, bottom=9532.587})
								w.moveTo(1450, 40, 60)`,
							addons: [{ name: 'Polestar', files: ['Core/Core.xml'] }],
							saved: { Polestar: 'PolestarDB = {schema=1, settings={behavior={autoSelectGuide=false}}}' },
							script: `do local ns = {}
								${loads}
								end
								local w = stub.world
								${state !== 'untaken' ? `w.accept(${quest}, {})` : ''}
								${state === 'turnedIn' ? `w.turnIn(${quest})` : ''}
								stub.login(); stub.advance(0.5)
								local E = Polestar.Engine
								E.SetGuide("forever/class/druid/${name}"); stub.advance(0.5)
								emit({step=E.GetStepIndex(), point=E.GetWaypoint(), firstDone=E.GetStepView(1).goals[1].status=="done"})`,
						}).emitted;
						const completed = state === 'turnedIn' || (verb === 'accept' && state === 'held');
						assert.equal(out.step, completed ? 2 : 1, 'quest progress skips only an unnecessary visit');
						if (!completed && playerLevel === level) assert.deepEqual([out.point.map, out.point.x, out.point.y], [1457, 35.8, 11.6]);
						if (playerLevel < level) assert.equal(out.firstDone, false, 'the level goal still holds the approach');
					});
				}
			}
		} finally {
			fs.rmSync(pack.dir, { recursive: true, force: true });
		}
	});
}

// Discord (a Rogue on The Horn of Xelthos): C's payment (78307) is handed in at the Dead Drop with nothing to
// accept. Players' recordings: five people handed it in there, none accepted it, 13 minutes to 2 hours after the horn
// (78261). The guide asked for an accept that never comes; the payment is a `direct` hand-in at the same chest.
test('forever/class/rogue/the-horn-of-xelthos.guide: C\'s payment is handed in at the Dead Drop with no accept', { skip }, () => {
	const list = goals('forever/class/rogue/the-horn-of-xelthos.guide');
	assert.deepEqual(list.filter(({ goal }) => goal.t === 'accept' && goal.quest === 78307).map(({ goal }) => goal.t), [], 'no accept for the payment');
	const pay = at(list, 'turnin 78307', is('turnin', 78307));
	assert.equal(list[pay].goal.direct, true, 'a direct hand-in');
	assert.equal(list[pay].goal.object, 410369, 'at the Dead Drop');
	assert.ok(at(list, 'turnin 78261', is('turnin', 78261)) < pay, 'after the horn');
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

// gabriel pasternak's report (#1760, Orc Shaman at Freewind Post): Razorfen Kraul's page and pick-up guide
// showed Elemental Aid (79360) as given by Rau Cliffrunner and handed in to Bath'rah the Windwatcher in Alterac
// Mountains, with no prerequisite: the Season of Discovery chain's NPCs, listed first in the merged data. Prate
// Cloudseer gives it once Call of Air (1531, 1532 or Skyborne's 96136) is handed in to her, and Rau takes it
// (players' recordings: taken from Prate by 2 people, handed in to Rau by 3, never offered by Rau). The same
// Season of Discovery NPC led Storm, Earth, and Fire's enders (79361, Prate) and Heed My Call's givers (79366,
// Prate). The Horde Shaman class guide already went that way; the records make the data agree with it.
test("gabriel pasternak's report (#1760): the Horde Elemental Aid chain's givers and enders, and Call of Air first", { skip }, () => {
	const q = loadCorrections().quests;
	const npcs = (rec, end) => rec && rec.set && rec.set[end] && rec.set[end].npc;
	assert.deepEqual(npcs(q['79360'], 'start'), [5905], 'Elemental Aid: Prate Cloudseer alone gives it');
	assert.deepEqual(npcs(q['79360'], 'end'), [4722], 'Elemental Aid: Rau Cliffrunner alone takes it');
	assert.deepEqual([...q['79360'].set.preAny].sort((a, b) => a - b), [1531, 1532, 96136], 'Elemental Aid: after any Call of Air');
	assert.deepEqual(npcs(q['79361'], 'end'), [5905], 'Storm, Earth, and Fire: handed in to Prate Cloudseer');
	assert.deepEqual(npcs(q['79366'], 'start'), [5905], 'Heed My Call: given by Prate Cloudseer');
	const list = goals('forever/class/shaman/call-of-air-horde.guide');
	const accept = at(list, 'accept 79360', is('accept', 79360));
	assert.equal(list[accept].goal.npc, 5905, 'the class guide takes Elemental Aid from Prate');
	assert.equal(list[at(list, 'turnin 79360', is('turnin', 79360))].goal.npc, 4722, 'and hands it in to Rau');
	for (const air of [1531, 1532, 96136]) assert.ok(at(list, `turnin ${air}`, is('turnin', air)) < accept, `Call of Air ${air} is handed in before Elemental Aid is taken`);
	assert.equal(list[at(list, 'turnin 79361', is('turnin', 79361))].goal.npc, 5905, 'Storm, Earth, and Fire to Prate');
	assert.equal(list[at(list, 'accept 79366', is('accept', 79366))].goal.npc, 5905, 'Heed My Call from Prate');
});

// Fitz's level rule (0.4.0), after #1667 (devanpy: Enchanted Gold Bloodrobe sent an Orc Warlock of 31 to the Burning
// Exiles, 38-39) and Kapu's report (an Alliance Warrior of 21 sent from Fire Hardened Mail to Roogug, a level 28 elite
// in Razorfen Kraul): a class guide never sends you to mobs, or hands you a quest to fight for, more than 1 level above
// you. Every step that works a quest waits on its OWN `level` hold (the guide's opening level is the floor), so skipping
// a waiting step never runs on into the next one; a timed quest's steps wait at its accept instead (the timer must not
// run while the guide waits). The per-spot +0 for dense camps, casters and elites is the danger gate's (tools/lib/danger.js).
// A group quest the guide splits into a `when group` step and a `when !group` solo way (the Rogues' Poisons towers, the
// lead's call for 0.4.0: Poisons from 20 with a friend) is taken at the floor; its group step is the party's, and its
// solo way waits on its own level like any other step.
test('class guides: every step waits on its own level for mobs and quests at most 1 above it (Fitz\'s rule, #1667, Kapu)', { skip }, () => {
	const top = (id) => refData().npcs[id] && (refData().npcs[id].levelMax || refData().npcs[id].level);
	const fights = (q) => ((refData().quests[q] || {}).objectives || []).some((o) => ['kill', 'item', 'object'].includes(o.type));
	for (const G of allGuides().filter((g) => g.startsWith('forever/class/'))) {
		const floor = compiled(G).minLevel || 1;
		const timedAt = {};
		const groupChoice = new Set(compiled(G).steps.flatMap((s) => (s.when || []).filter((w) => w.k === 'group' && w.neg).map((w) => w.q)));
		for (const step of compiled(G).steps) {
			if ((step.when || []).some((w) => w.k === 'group' && !w.neg && groupChoice.has(w.q))) continue;
			let own = Math.max(floor, ...step.goals.filter((g) => g.t === 'level').map((g) => g.level));
			for (const goal of step.goals) if (goal.quest && timedAt[goal.quest] && goal.t !== 'accept') own = Math.max(own, timedAt[goal.quest]);
			for (const goal of step.goals) {
				const q = goal.quest && refData().quests[goal.quest];
				if (goal.t === 'accept' && q && fights(goal.quest) && !groupChoice.has(goal.quest)) assert.ok(q.level <= own + 1, `${G}, ${step.title}: accept ${goal.quest} (level ${q.level}) waits only for ${own}`);
				if (q && !['accept', 'turnin'].includes(goal.t)) assert.ok(q.level <= own + 1, `${G}, ${step.title}: ${goal.t} for ${goal.quest} (level ${q.level}) waits only for ${own}`);
				const item = goal.t === 'collect' ? refData().items[goal.item] : null;
				// Droppers with a real chance (1% or more): a quest giver "drops" the item he hands out.
				const droppers = item && item.drops && !(item.vendors || []).length ? Object.entries(item.drops.npc || {}).filter(([, chance]) => typeof chance === 'number' && chance >= 1).map(([id]) => top(id)).filter(Boolean) : [];
				// A kill objective on a side's own NPC is a heal or a talk (the priest robes' wounded guards); raid bosses
				// (63, the game's boss sentinel) and anything at the level cap are past what a hold can wait for.
				const friend = goal.t === 'kill' && refData().npcs[goal.npc] && refData().npcs[goal.npc].faction;
				const mob = friend ? null : goal.t === 'kill' ? top(goal.npc) : droppers.length ? Math.min(...droppers) : null;
				if (mob && mob < 63 && own < 60) assert.ok(mob <= own + 1, `${G}, ${step.title}: ${goal.t} ${goal.item || goal.npc}, mobs up to ${mob}, the step waits only for ${own}`);
				if (goal.t === 'accept' && q && q.limit) timedAt[goal.quest] = own;
			}
		}
	}
});

// The lead's call (0.4.0): Rogues get Poisons from 20 with a friend. The chain opens at 20 with no hold up to the tower's
// quest; the tower (Gallywix, a level 23 elite, drones 25; Klaven Mortwake, a level 26 elite, Sentries 24) is a group
// choice, its solo way held at the tower's level.
for (const [G, q, solo] of [['forever/class/rogue/poisons-horde.guide', 2478, 25], ['forever/class/rogue/poisons-alliance.guide', 2359, 24]]) test(`${G}: Poisons from 20 with a group; the tower solo waits for ${solo}`, { skip }, () => {
	const steps = compiled(G).steps;
	const held = (s) => Math.max(0, ...s.goals.filter((g) => g.t === 'level').map((g) => g.level));
	const take = steps.findIndex((s) => s.goals.some((g) => g.t === 'accept' && g.quest === q));
	assert.ok(take >= 0 && steps.slice(0, take + 1).every((s) => held(s) <= 20), `accept ${q} waits for no more than 20`);
	const group = steps.filter((s) => (s.when || []).some((w) => w.k === 'group' && !w.neg && w.q === q));
	const alone = steps.filter((s) => (s.when || []).some((w) => w.k === 'group' && w.neg && w.q === q));
	assert.equal(group.length, 1, 'one group step for the tower');
	assert.equal(alone.length, 1, 'one solo way for the tower');
	assert.equal(held(group[0]), 0, 'the group step has no hold');
	assert.equal(held(alone[0]), solo, `the solo way waits for ${solo}`);
	assert.deepEqual(group[0].goals.filter((g) => g.quest === q).map((g) => `${g.t} ${g.item || g.npc}`), alone[0].goals.filter((g) => g.quest === q).map((g) => `${g.t} ${g.item || g.npc}`), 'both ways do the same objectives');
});

// #2462 (TAKODACHI: an Alliance Warrior followed the Horde-only Brutal Armor guide to Camp Taurajo and died), the side
// guides' sweep: no guide sends a character to a quest giver, ender, trainer or vendor of the other faction. A guide
// with no `faction` line is for both sides, so its one-side NPCs need an `only` (Celestial Orb's Tabetha's Task went to
// Deino in Orgrimmar for every mage). Leveling guides have their own checks.
test('side guides: no step sends a character to an NPC of the other faction (#2462)', { skip }, () => {
	const { applicable } = require('../../tools/lib/dsl/conditions');
	const SIDE = { Human: 'Alliance', Dwarf: 'Alliance', NightElf: 'Alliance', Gnome: 'Alliance', Orc: 'Horde', Scourge: 'Horde', Tauren: 'Horde', Troll: 'Horde' };
	const exp = path.join(ROOT, 'experimental', 'guides');
	const side = allGuides().filter((g) => !/^forever\/(alliance|horde)\//.test(g)).map((g) => compiled(g));
	for (const f of fs.readdirSync(exp).filter((f) => f.endsWith('.guide'))) side.push(compileSources([{ file: path.join(exp, f), text: fs.readFileSync(path.join(exp, f), 'utf8') }], refData()).guides[0]);
	const wrong = [];
	for (const g of side) {
		const head = { factions: g.faction ? [g.faction] : null, races: g.races || null, classes: g.classes || null };
		for (const step of g.steps) {
			for (const goal of step.goals) {
				const n = goal.npc && goal.t !== 'kill' && refData().npcs[goal.npc];
				if (!n || (n.faction !== 'A' && n.faction !== 'H')) continue;
				const own = n.faction === 'A' ? 'Alliance' : 'Horde';
				const set = applicable([head, step.only, goal.only]);
				const others = set.factions.includes(own === 'Alliance' ? 'Horde' : 'Alliance') ? set.races.filter((r) => (SIDE[r] ? SIDE[r] !== own : r === 'Skyborne')) : [];
				if (others.length) wrong.push(`${g.id}, ${step.title}: ${goal.t} at ${n.name} (${own}) for ${others.join('/')}`);
			}
		}
	}
	assert.deepEqual(wrong, []);
	const tabetha = goals('forever/class/mage/celestial-orb.guide').filter(({ goal }) => goal.t === 'accept' && goal.quest === 2861);
	assert.deepEqual(tabetha.map(({ goal }) => `${goal.only.factions} ${goal.npc}`), ['Alliance 5497', 'Horde 5885'], 'Tabetha\'s Task from each side\'s own trainer');
});

test('forever/class/warrior/fire-hardened-armor.guide: Kapu\'s report: Fire Hardened Mail is taken at 27, not at 20, and Roogug waits for 28', { skip }, () => {
	const G = 'forever/class/warrior/fire-hardened-armor.guide';
	const list = goals(G);
	const held = (s) => Math.max(0, ...compiled(G).steps[s - 1].goals.filter((g) => g.t === 'level').map((g) => g.level));
	const shield = list[at(list, 'turnin 1702', is('turnin', 1702))];
	const mail = list[at(list, 'accept 1701', is('accept', 1701))];
	assert.notEqual(mail.s, shield.s, 'the shield is handed out at 20-22, Fire Hardened Mail in a step of its own');
	assert.ok(held(mail.s) >= 27, `Fire Hardened Mail (level 28) waits for 27 (waits for ${held(mail.s)})`);
	const roogug = list.find(({ goal }) => goal.t === 'collect' && goal.item === 6841);
	assert.ok(held(roogug.s) >= 28, `Roogug's step waits on its own level for 28 (waits for ${held(roogug.s)})`);
	assert.ok(roogug.goal.group && roogug.goal.group.size === 5, 'Roogug is a group of five');
	for (const item of [6838, 6839, 6840]) {
		const { s } = list.find(({ goal }) => goal.t === 'collect' && goal.item === item);
		assert.ok(held(s) >= 28, `collect ${item} waits on its own level for 28`);
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

// Hand-in sweep (2026-11-16, after Kerlonian's escort): The Windshaper's Wrath (96204) is an escort whose step held
// only its accept, so the window went from the accept to the hand-in at the Sepulcher. The step waits for the escort.
test("forever/class/paladin/lumina-windsinger.guide: Free Lumina waits for the escort before the hand-in", { skip }, () => {
	const list = goals('forever/class/paladin/lumina-windsinger.guide');
	const accept = at(list, 'accept 96204', is('accept', 96204));
	const escort = at(list, 'complete 96204', is('complete', 96204));
	assert.equal(list[escort].s, list[accept].s, "in the accept's step");
	assert.equal(list[escort].goal.escort, true, 'marked as an escort');
	assert.ok(escort < at(list, 'turnin 96204', is('turnin', 96204)), 'before the hand-in');
	const { goal } = list[escort];
	assert.ok(goal.map === 1421 && Math.hypot(goal.x - 65.7, goal.y - 29.7) < 1, `leads where the escort ends (${goal.map} ${goal.x},${goal.y})`);
});

// Found by the playtest's hand-in check (2026-11-17): A Grim Fate (91860) is handed in at the Charred Remains on
// Fenris Isle (all 14 recorded hand-ins), but the data also named Deathguard Baldren, its giver, as an ender, so the
// pyre step's hand-in pointed back to the Sepulcher. It names the remains.
test("forever/class/paladin/lumina-windsinger.guide: A Grim Fate is handed in at the Charred Remains, not back at the Sepulcher", { skip }, () => {
	const list = goals('forever/class/paladin/lumina-windsinger.guide');
	const { goal, step } = list[at(list, 'turnin 91860', is('turnin', 91860))];
	assert.equal(step.title, 'The pyre on Fenris Isle');
	assert.equal(goal.object, 566037, 'the Charred Remains');
	assert.ok(goal.map === 1421 && Math.hypot(goal.x - 64.9, goal.y - 34.3) < 1, `on Fenris Isle (${goal.map} ${goal.x},${goal.y})`);
});

// Erá's report (#948): Arantir offers no Horns of Nez'ra (2358) after Alther's
// Mill; the quest is not in the game on Forever. The Rogue's Certificate of
// Thievery ends when Lucius takes the token back.
test("Erá's report (#948): the Rogue's Certificate of Thievery ends at Lucius, with no Horns of Nez'ra", { skip }, () => {
	const list = goals('forever/class/rogue/certificate-of-thievery.guide');
	assert.equal(list.findIndex(({ goal }) => goal.quest === 2358), -1, 'no goal for Horns of Nez\'ra');
	assert.ok(is('turnin', 2282)(list[list.length - 1].goal), 'the guide ends with Alther\'s Mill handed in to Lucius');
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

// Erá's report (#1160): The Eye of Bhossca, C's second job, comes with C's letter in a capital city's mailbox at
// level 30 (after the horn job), not at the quest data's 25: its correction goes by 30. The quest itself is level 35
// (the Scarlet Monastery), so under Fitz's level rule (0.4.0) the guide holds its accept at the Dead Drop for 34, and
// the class-quest heads-up waits for the guide's hold (34) instead of telling you at 30 about a quest it then holds.
test("Erá's report (#1160): The Eye of Bhossca opens at 30 and holds its level 35 quest for 34", { skip }, () => {
	const guide = 'forever/class/rogue/the-eye-of-bhossca.guide';
	assert.match(fs.readFileSync(path.join(OFFICIAL_DIR, guide), 'utf8'), /^levels 30-35$/m);
	const list = goals(guide);
	const accept = at(list, 'accept 78676', is('accept', 78676));
	const gate = list.find(({ step, goal }) => step === list[accept].step && goal.t === 'level');
	assert.equal(gate && gate.goal.level, 34, 'a level 34 gate before the Dead Drop');
	const corrections = JSON.parse(fs.readFileSync(path.join(ROOT, 'forever-db', 'corrections', 'quests.json'), 'utf8'));
	assert.equal(corrections[78676].set.minLevel, 30, 'the correction a data build applies');
	assert.match(fs.readFileSync(path.join(ROOT, 'addon', 'Polestar', 'UI', 'ClassRewards.lua'), 'utf8'), /\[78676\] = \{ 34, /, 'the heads-up waits for the guide\'s hold at 34');
});

// #1531 pattern (an item that only drops while you have a quest, listed where you might not have it), swept over
// every non-leveling guide against the Forever TDB's loot conditions: the Dragonmaw Shinbone (7131) drops only with
// Dragonmaw Shinbones (1846) in the log (TDB condition on every Dragonmaw orc; players' recordings: 281 Dragonmaw loot
// windows without the quest, no shinbone). The Warrior's Brutal Armor step that farms them shows only on the quest.
test('#1531 pattern: Brutal Armor\'s Dragonmaw Shinbone step shows only with Dragonmaw Shinbones in the log', { skip }, () => {
	const list = goals('forever/class/warrior/brutal-armor.guide');
	const take = at(list, 'accept 1846', is('accept', 1846));
	for (const i of list.map((e, k) => k).filter((k) => list[k].goal.t === 'collect' && [7131, 7134].includes(list[k].goal.item))) {
		assert.ok(take < i, 'Velora gives the quest before the shinbones are farmed');
		assert.ok([].concat(list[i].step.when || []).some((w) => w.k === 'onquest' && !w.neg), `"${list[i].step.title}" waits for the quest`);
	}
});

test('Bear Form approaches follow completed visits without dropping carried work (#2306)', async (t) => {
	const file = path.join(OFFICIAL_DIR, 'forever/class/druid/bear-form.guide');
	const text = fs.readFileSync(file, 'utf8');
	const diag = new Diagnostics();
	const ast = parseGuide(text, file, diag);
	assert.deepEqual(diag.errors, []);
	const lines = text.split('\n');
	const zones = new Data({ zones: {
		1450: { id: 1450, name: 'Moonglade' }, 1457: { id: 1457, name: 'Darnassus' },
		1416: { id: 1416, name: 'Alterac Mountains' }, 1412: { id: 1412, name: 'Mulgore' },
	} });
	const islandStates = [
		['chain untaken', [], [], false],
		['94006 held', [94006], [], false],
		['94006 handed in, final untaken', [], [94006], false],
		['94638 held', [94638], [94006], false],
		['94638 handed in', [], [94006, 94638], true],
	];
	const visits = [
		{ name: 'later Night Elf doorway', quest: 6001, race: 'NightElf', faction: 'Alliance', point: [1457, 35.8, 11.6], states: [
			['visit untaken', [], [], false],
			['5931 held', [5931], [], false],
			['5931 handed in, 6001 untaken', [], [5931], false],
			['6001 held', [6001], [5931], true],
			['6001 handed in', [], [5931, 6001], true],
		] },
		{ name: 'first Night Elf doorway', quest: 5921, race: 'NightElf', faction: 'Alliance', point: [1457, 35.8, 11.6], states: [
			['visit untaken', [], [], false],
			['5921 held without a letter', [5921], [], true],
			['5921 handed in without a letter', [], [5921], true],
			...[5923, 5924, 5925].flatMap((letter) => [
				[`${letter} letter held, 5921 untaken`, [letter], [], false],
				[`${letter} letter and 5921 held`, [letter, 5921], [], false],
				[`${letter} letter held after 5921 hand-in`, [letter], [5921], false],
			]),
		] },
		{ name: 'Alliance skyboat', race: 'Skyborne', faction: 'Alliance', point: [1416, 12.5, 51.8], states: islandStates },
		{ name: 'Horde skyboat', race: 'Skyborne', faction: 'Horde', point: [1412, 34.3, 25.8], states: islandStates },
	];
	for (const visit of visits) {
		const identifies = visit.quest
			? (s) => s.goals.some((g) => g.verb === 'accept' && g.quest === visit.quest)
			: (s) => s.title.startsWith('Skyboat') && s.only.factions.includes(visit.faction);
		assert.equal(ast.steps.filter(identifies).length, 1, `${visit.name} has one source block`);
		const approach = (s) => s.goals.length === 1 && s.goals[0].verb === 'goto';
		let end = ast.steps.findIndex(identifies) + (visit.quest ? 0 : 1);
		// Trainer hand-ins can sit between the entrance and its quest pickup.
		if (visit.quest) while (end > 0 && !approach(ast.steps[end - 1])) end--;
		let start = end - 1;
		// Include every contiguous approach to exercise their interaction on arrival.
		if (visit.quest) while (start > 0 && approach(ast.steps[start - 1])) start--;
		assert.ok(start >= 0 && end < ast.steps.length);
		// Compile the actual approaches, retaining the guide header and restrictions. A sentinel
		// task exposes whether the Engine leaves it, without optional quest/reference data.
		const source = [
			...lines.slice(0, ast.steps[0].line - 1),
			...lines.slice(ast.steps[start].line - 1, ast.steps[end].line - 1),
			'step Continue after the visit', '  task "Continue"',
		].join('\n');
		const compiled = compileSources([{ file, text: source }], zones);
		assert.deepEqual(compiled.diag.list, []);
		const pack = writeTestPack(compiled.guides, zones);
		const loads = pack.scripts.map((f) => `assert(loadfile(${JSON.stringify(f)}))("Polestar_Guides", ns)`).join('\n');
		const continuation = compiled.guides[0].steps.length;
		const snapshot = 'emit({step=E.GetStepIndex(), point=E.GetWaypoint()})';
		const runState = (held, completed, after = '') => runAddon({
			stubs: ['stub_world.lua'],
			addons: [{ name: 'Polestar', files: ['Core/Core.xml'] }],
			saved: { Polestar: 'PolestarDB = {schema=1, settings={behavior={autoSelectGuide=false}}}' },
			before: `local w = stub.world
				w.race, w.raceName, w.faction, w.class, w.className = "${visit.race}", "${visit.race}", "${visit.faction}", "DRUID", "Druid"
				w.level = 10
				w.addMap(1450, {name="Moonglade", c=1, left=-1381.25, right=-3689.583, top=8491.666, bottom=6952.083})
				w.addMap(1457, {name="Darnassus", c=1, left=2938.363, right=1880.03, top=10238.316, bottom=9532.587})
				w.moveTo(1450, 40, 50)`,
			script: `do local ns = {}
				${loads}
				end
				local w = stub.world
				${held.map((q) => `w.accept(${q}, {})`).join('\n')}
				w.complete({${completed.join(',')}})
				stub.login(); stub.advance(0.5)
				local E = Polestar.Engine
				E.SetGuide("forever/class/druid/bear-form"); stub.advance(0.5)
				${snapshot}
				${after}`,
		}).emitted;
		const atDoor = (out) => {
			assert.ok(out.step >= 1 && out.step < continuation, 'the approach stays active');
			assert.deepEqual([out.point.map, out.point.x, out.point.y], visit.point, 'retain the original doorway or port');
		};
		try {
			for (const [state, held, completed, continues] of visit.states) {
				await t.test(`${visit.name}: ${state}`, () => {
					const [out] = runState(held, completed);
					if (continues) assert.equal(out.step, continuation, 'a finished visit removes its approach');
					else atDoor(out);
				});
			}
			if (visit.quest === 5921) {
				for (const [name, held, action] of [
					['arrive with a letter', [5925], ''],
					['arrive without a letter', [], ''],
					['abandon the letter before arrival', [5925], 'w.abandon(5925)'],
					['take a letter before arrival', [], 'w.accept(5925, {})'],
					['abandon Moonglade while carrying a letter', [5925, 5921], 'w.abandon(5921)'],
				]) {
					await t.test(`first Night Elf doorway: ${name}`, () => {
						const [before, changed, arrived] = runState(held, [], `
							${action}
							stub.advance(0.5); ${snapshot}
							w.moveTo(1457, 35.8, 11.6); stub.advance(2); ${snapshot}`);
						atDoor(before);
						atDoor(changed);
						assert.equal(arrived.step, continuation, 'one arrival completes the approach, even when both reasons apply');
					});
				}
			}
		} finally {
			fs.rmSync(pack.dir, { recursive: true, force: true });
		}
	}
});

// --- Class guide audit (0.3.7) ----------------------------------------------------------------------

// Aquatic Form (Tauren, Horde Skyborne): the Barrens half (Sludge Fen, outside Orgrimmar) on the way to the zeppelin,
// then Silverpine, then Moonglade: one sea crossing instead of Silverpine first and back to the Barrens.
test('Class audit: Aquatic Form (Horde) takes the Sludge Fen half before the zeppelin to Silverpine', { skip }, () => {
	const list = goals('forever/class/druid/aquatic-form.guide').filter(({ step }) => step.only && step.only.races && step.only.races.includes('Tauren'));
	const agility = at(list, 'collect 15883', (g) => g.t === 'collect' && g.item === 15883);
	const zeppelin = at(list, 'Zeppelin to Undercity', (g) => g.t === 'goto' && /Zeppelin to Undercity/.test(g.label || g.text || ''));
	const endurance = at(list, 'collect 15882', (g) => g.t === 'collect' && g.item === 15882);
	assert.ok(agility < zeppelin && zeppelin < endurance, 'Barrens half, zeppelin, Silverpine half');
});

test('Bear Form hands in each carried alternative trainer letter (#2310)', async (t) => {
	const file = path.join(OFFICIAL_DIR, 'forever/class/druid/bear-form.guide');
	const text = fs.readFileSync(file, 'utf8');
	const diag = new Diagnostics();
	const ast = parseGuide(text, file, diag);
	assert.deepEqual(diag.errors, []);
	const letters = [5923, 5924, 5926, 5927];
	const sides = [
		{ quests: [5923, 5924], race: 'NightElf', npc: 4217, name: 'Mathrengyl Bearwalker', map: 1457, zone: 'Darnassus', x: 35.4, y: 8.4, next: 5921 },
		{ quests: [5926, 5927], race: 'Tauren', npc: 3033, name: 'Turak Runetotem', map: 1456, zone: 'Thunder Bluff', x: 76.5, y: 27.2, next: 5922 },
	];
	// Canonical distinct IDs/enders (forever-db quest_end.jsonl:2623-2628), with
	// published giver positions. This fixture tests ready client windows, not eligibility.
	const quests = {}, npcs = {}, zones = { 1450: { id: 1450, name: 'Moonglade' } };
	for (const side of sides) {
		for (const id of side.quests) quests[id] = { id, title: 'Heeding the Call', end: { npc: [side.npc] }, objectives: [] };
		npcs[side.npc] = { id: side.npc, name: side.name, spawns: { [side.map]: { f: 'e', pts: [[side.x, side.y]] } } };
		zones[side.map] = { id: side.map, name: side.zone };
	}
	const data = new Data({ quests, npcs, zones });
	const lines = text.split('\n');
	const handins = ast.steps.flatMap((s, i) => s.goals.some((g) => g.verb === 'turnin' && letters.includes(g.quest))
		? lines.slice(s.line - 1, ast.steps[i + 1]?.line - 1 || lines.length) : []);
	const compiled = compileSources([{ file, text: [
		...lines.slice(0, ast.steps[0].line - 1), ...handins,
		'step Continue after trainer letters', '  task "Continue"',
	].join('\n') }], data);
	assert.deepEqual(compiled.diag.list, []);
	const pack = writeTestPack(compiled.guides, data);
	const loads = pack.scripts.map((f) => `assert(loadfile(${JSON.stringify(f)}))("Polestar_Guides", ns)`).join('\n');
	const sentinel = compiled.guides[0].steps.length;
	const run = (side, q, { state = 'held', race = side.race, mode = 'gossip', auto = true, action = '' } = {}) => runAddon({
		stubs: ['stub_world.lua'],
		addons: [{ name: 'Polestar', files: ['Core/Core.xml'] }],
		saved: { Polestar: 'PolestarDB={schema=1,settings={behavior={autoSelectGuide=false,autoAccept=false,autoTurnin=true}}}' },
		before: `local w = stub.world
			w.race, w.raceName, w.faction, w.class, w.className = "${race}", "${race}", "${race === 'NightElf' ? 'Alliance' : 'Horde'}", "DRUID", "Druid"
			w.level = 10
			w.addMap(1457, {name="Darnassus", c=1, left=2938.363, right=1880.03, top=10238.316, bottom=9532.587})
			w.addMap(1456, {name="Thunder Bluff", c=1, left=516.667, right=-527.083, top=-850, bottom=-1545.833})
			w.moveTo(${side.map}, ${side.x}, ${side.y})`,
		script: `do local ns = {}
			${loads}
			end
			local w, E = stub.world, Polestar.Engine
			${state === 'held' ? `w.onQuest(${q}, {})` : state === 'done' ? `w.complete({${q}})` : ''}
			stub.login(); stub.advance(0.5)
			E.SetGuide("forever/class/druid/bear-form"); stub.advance(0.5)
			Polestar.Set("behavior.autoTurnin", ${auto})
			${action}
			stub.advance(0.5)
			emit({step=E.GetStepIndex(), wanted=E.WantsQuest("turnin",${q}), wants={${letters.map((id) => `[${id}]=E.WantsQuest("turnin",${id})`).join(',')}}})
			w.calls={}
			${mode === 'gossip' || mode === 'greeting'
				? `w.${mode}(${side.npc}, {active={{questID=${q}, isComplete=true}}, available={}})`
				: `w.quest${mode === 'progress' ? 'Progress' : 'Complete'}(${side.npc}, ${q})`}
			stub.advance(1)
			emit({step=E.GetStepIndex(), held=w.log[${q}]~=nil, done=w.completed[${q}]==true, calls=#w.calls})`,
	}).emitted;
	try {
		for (const side of sides) for (const q of side.quests) {
			for (const mode of ['gossip', 'greeting', 'progress', 'complete']) {
				await t.test(`${q}: ready letter through ${mode}`, () => {
					const [before, after] = run(side, q, { mode });
					assert.equal(before.wanted, true, 'the carried alternative is an exact wanted hand-in');
					for (const id of letters) assert.equal(before.wants[id], id === q, 'unheld alternatives are not wanted');
					assert.equal(after.done, true, 'the ready NPC window hands in the letter');
					assert.equal(after.held, false);
					assert.equal(after.step, sentinel, 'no other letter is required');
					const turnin = ast.steps.findIndex((s) => s.goals.some((g) => g.verb === 'turnin' && g.quest === q));
					const accept = ast.steps.findIndex((s) => s.goals.some((g) => g.verb === 'accept' && g.quest === side.next));
					assert.ok(turnin >= 0 && turnin < accept, 'hand in a carried letter before accepting Moonglade');
					if (side.race === 'NightElf') {
						const entrance = ast.steps.findIndex((s) => s.goals.some((g) => g.verb === 'goto' && g.x === 35.8 && g.y === 11.6));
						assert.ok(entrance >= 0 && entrance < turnin, 'reach the Cenarion entrance before the upstairs hand-in');
					}
				});
			}
			for (const [name, opts, held, done] of [
				['absent', { state: 'absent' }, false, false],
				['already handed in', { state: 'done' }, false, true],
				['wrong race', { race: side.race === 'NightElf' ? 'Tauren' : 'NightElf' }, true, false],
				['skipped quest', { action: `E.SkipQuest(${q}, true)` }, true, false],
				['abandoned before the window', { action: `w.abandon(${q})` }, false, false],
			]) {
				await t.test(`${q}: ${name}`, () => {
					const [before, after] = run(side, q, opts);
					assert.equal(before.wanted, false);
					assert.equal(before.step, sentinel, 'an inapplicable letter does not hold the guide');
					assert.equal(after.held, held);
					assert.equal(after.done, done);
					assert.equal(after.calls, 0, 'no unwanted hand-in action');
				});
			}
			await t.test(`${q}: auto-turn-in disabled`, () => {
				const [before, after] = run(side, q, { auto: false });
				assert.equal(before.wanted, true, 'manual hand-in stays in the guide');
				assert.equal(after.held, true);
				assert.equal(after.done, false);
				assert.equal(after.calls, 0, 'respect the automation setting');
			});
		}
	} finally {
		fs.rmSync(pack.dir, { recursive: true, force: true });
	}
});

// Tyr's Watch: a step gated `when onquest 99152,99153` whose hand-ins were all optional counted done at once, so
// nobody was led back to Hilda or Ephram. Each hand-in now has its own step, gated on its own quest, and holds it.
test("Class audit: Tyr's Watch leads back to Hilda and Ephram for their hand-ins", { skip }, () => {
	const list = goals('forever/class/paladin/tyrs-watch.guide');
	for (const quest of [99152, 99153]) {
		const { step, goal } = list[at(list, `turnin ${quest}`, is('turnin', quest))];
		assert.ok(!goal.optional, `${quest}: the hand-in holds its step`);
		assert.ok(step.when.some((p) => p.k === 'onquest' && !p.neg && [p.q].flat().length === 1 && [p.q].flat()[0] === quest), `${quest}: gated on its own quest`);
	}
});

// Spellfire Robes (1962): Josef Gregorian offers it after Gathering Materials (recordings: 2 people, EG Link live);
// Rhiannon Davis never did. The accept points at Josef.
test('Class audit: Spellfire Robes is taken from Josef Gregorian', { skip }, () => {
	const list = goals('forever/class/mage/spellfire-robes.guide');
	assert.equal(list[at(list, 'accept 1962', is('accept', 1962))].goal.npc, 4576);
	const corrections = JSON.parse(fs.readFileSync(path.join(ROOT, 'forever-db', 'corrections', 'quests.json'), 'utf8'));
	assert.deepEqual(corrections[1962].set.start.npc, [4576], 'the correction a data build applies');
});
