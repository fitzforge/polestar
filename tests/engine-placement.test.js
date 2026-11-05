'use strict';
// Placement and navigation on compiled leveling guides, in the real engine.
// The guides are frozen copies (tests/fixtures/placement) of the shipped
// guides the player reports came from, so rewriting the shipped guides does
// not change what these tests pin:
// - The Southern Barrens (forever/horde/04-barrens) as an Undead Warlock:
//   where the guide opens from a quest log (login, reload, a new tab),
//   Prev/Next over the steps that apply, and the breadcrumb Ziz Fizziks
//   (1483), which Sputtervalve no longer offers once its follow-up Super
//   Reaper 6000 (1093) is done.
// - The Barrens (forever/horde/02-barrens) as a level-12 Tauren Warrior who
//   had skipped ahead to the Wailing Caverns mound (every open step before it
//   skipped): a reload keeps them there; without saved state, placement picks
//   the first step with work they started or can do now.
// Steps are found by their goals (stepOf), never by number.
//
// Needs data/forever (forge data build); skips without it.

const { test, after } = require('node:test');
const assert = require('node:assert/strict');
const fs = require('node:fs');
const path = require('node:path');
const { runAddon } = require('./helpers/lua');
const { needs } = require('./helpers/data');
const { buildSimPack, luaValue } = require('../tools/lib/playtest');

const skip = needs('quests.json');

const packs = {};
after(() => Object.values(packs).forEach((p) => p.dispose()));

const PERSONAS = {
	warlock: {
		id: 'forever/horde/04-barrens',
		files: ['forever/horde/04-barrens.guide', 'forever/horde/05-stonetalon.guide'],
		race: 'Scourge', raceName: 'Undead', cls: 'WARLOCK', at: [1413, 58.9, 25.8],
	},
	warrior: {
		id: 'forever/horde/02-barrens',
		files: ['forever/horde/02-barrens.guide', 'forever/horde/03-hillsbrad.guide', 'forever/horde/tauren/01-mulgore.guide'],
		race: 'Tauren', raceName: 'Tauren', cls: 'WARRIOR', at: [1413, 51.6, 30.5], // the Crossroads
	},
};

const FIXTURES = path.join(__dirname, 'fixtures', 'placement');

function packOf(persona) {
	const files = PERSONAS[persona].files.map((f) => ({ file: `guides/${f}`, text: fs.readFileSync(path.join(FIXTURES, f), 'utf8') }));
	return packs[persona] || (packs[persona] = buildSimPack(files));
}

function guideOf(persona) {
	return packOf(persona).guides.find((g) => g.id === PERSONAS[persona].id);
}

// 1-based index of the first step with a goal matching `match` ({ t, quest,
// oi, location }), or of the step titled `match` (a string).
function stepOf(persona, match) {
	const i = guideOf(persona).steps.findIndex((s) => (typeof match === 'string'
		? s.title === match
		: s.goals.some((g) => Object.entries(match).every(([k, v]) => g[k] === v))));
	assert.ok(i >= 0, `no step for ${JSON.stringify(match)}`);
	return i + 1;
}

// Steps whose `only` lets the persona's race and class in.
function applies(persona, s) {
	const p = PERSONAS[persona];
	const only = guideOf(persona).steps[s - 1].only;
	if (!only) return true;
	return (!only.classes || only.classes.includes(p.cls)) && (!only.races || only.races.includes(p.race));
}

function savedState(persona, { manual = [], skipped = [] } = {}) {
	const id = PERSONAS[persona].id;
	return `PolestarCharDB = { schema = 1, tabs = { "${id}" }, activeTab = 1,
		manual = { ["${id}"] = { ${manual.map((k) => `["${k}"] = true`).join(', ')} } },
		skipped = { ["${id}"] = { ${skipped.map((s) => `[${s}] = true`).join(', ')} } } }`;
}

const FRESH = 'PolestarDB = { schema = 1, settings = { behavior = { autoSelectGuide = false } } }';
const LOST = 'PolestarDB = nil; PolestarCharDB = nil';

// Quests a level-20 Undead Warlock had done or held on reaching 04-barrens
// (from the player's report): the succubus chain done, Super Reaper 6000 done
// in Stonetalon, Tribes at War and Blood Shards turned in.
const DONE = [1093, 1094, 1507, 1508, 1509, 1510, 1511, 1512, 1513, 1515, 878, 5052, 883];
const LOG = [879, 97250, 869, 871, 1095];

// log: questID, or [questID, objectives] (stub_world: counts or { required, fulfilled }).
// open: how the guide gets loaded ("saved" from SavedVariables, "tab" in a new
// tab, "set" with SetGuide when saved state was lost).
function play({ persona = 'warlock', done = DONE, log = LOG, level = 20, at, saved, open = 'saved', script }) {
	const p = PERSONAS[persona];
	const pack = packOf(persona);
	const load = open === 'tab' ? `E.OpenTab("${p.id}")`
		: open === 'set' ? `if not E.GetGuide() or E.GetGuide().id ~= "${p.id}" then E.SetGuide("${p.id}") end`
			: '';
	return runAddon({
		stubs: ['stub_world.lua'],
		addons: ['Polestar'],
		saved: saved ? { Polestar: saved } : undefined,
		before: `
			local w = stub.world
			${pack.maps}
			w.race, w.raceName, w.class, w.className, w.faction = "${p.race}", "${p.raceName}", "${p.cls}", "${p.cls}", "Horde"
			w.level = ${level}
			w.complete(${luaValue(done)})
			for q, objectives in pairs(${luaValue(Object.fromEntries(log.map((q) => (Array.isArray(q) ? q : [q, [1]]))))}) do w.onQuest(q, objectives) end
			w.moveTo(${(at || p.at).join(', ')})`,
		script: `
			${pack.loads}
			stub.login()
			stub.fire("QUEST_LOG_UPDATE"); stub.advance(0.6)
			E = Polestar.Engine
			${load}
			${script}`,
	}).emitted;
}

// ---------------------------------------------------------------------------
// 04-barrens, Undead Warlock
// ---------------------------------------------------------------------------

// The player's saved state: the opening travel steps checked off, the
// Crossroads and Chol'aruk steps skipped.
function warlockSaved() {
	const w = (m) => stepOf('warlock', m);
	return savedState('warlock', {
		manual: [`${w({ t: 'fly', location: 'Undercity' })}:1`, `${w('Zeppelin to Durotar')}:1`,
			`${w({ t: 'getfp', location: 'Orgrimmar' })}:1`, `${w({ t: 'getfp', location: 'Orgrimmar' })}:2`],
		skipped: [w({ t: 'accept', quest: 868 }), w({ t: 'collect', quest: 97003 })],
	});
}

test('the breadcrumb Ziz Fizziks is skipped before the trip to Ratchet once Super Reaper 6000 is done, and says why', { skip }, () => {
	const ratchet = stepOf('warlock', { t: 'accept', quest: 1483 });
	const taurajo = stepOf('warlock', { t: 'accept', quest: 878 });
	const [out] = play({
		saved: warlockSaved(),
		script: `
			local g = E.GetStepView(${ratchet}).goals[1]
			emit({ at = E.GetStepIndex(), ratchet = E.GetStepView(${ratchet}).status, status = g.status, why = g.unavailable, text = g.unavailableText })
		`,
	});
	// The Crossroads and Chol'aruk skipped by the player, Ratchet closed, the
	// Warlock's Ken'zigla step done: Camp Taurajo.
	assert.deepEqual(out, {
		at: taurajo,
		ratchet: 'done',
		status: 'skipped',
		why: 'closed',
		text: 'No longer offered: you took Super Reaper 6000',
	});

	// Without Super Reaper 6000 the breadcrumb still sends the player to Ratchet.
	const [open] = play({
		done: DONE.filter((q) => q !== 1093 && q !== 1094),
		saved: warlockSaved(),
		script: `emit({ at = E.GetStepIndex(), status = E.GetStepView(${ratchet}).goals[1].status })`,
	});
	assert.deepEqual(open, { at: ratchet, status: 'active' });
});

test('Prev visits every step that applies to a Warlock, Next walks back to where Prev started, and skips stay as they were', { skip }, () => {
	const start = stepOf('warlock', { t: 'accept', quest: 878 });
	const skipped = [stepOf('warlock', { t: 'accept', quest: 868 }), stepOf('warlock', { t: 'collect', quest: 97003 })];
	const before = [];
	for (let s = start - 1; s >= 1; s--) if (applies('warlock', s)) before.push(s);
	const [out] = play({
		saved: warlockSaved(),
		script: `
			local back, forward = {}, {}
			for k = 1, ${before.length + 1} do E.Prev(); stub.advance(0.6); back[k] = E.GetStepIndex() end
			for k = 1, ${before.length} do E.Next(); stub.advance(0.6); forward[k] = E.GetStepIndex() end
			local skips = {}
			for s in pairs(PolestarCharDB.skipped["${PERSONAS.warlock.id}"]) do skips[#skips + 1] = s end
			table.sort(skips)
			emit({ at = ${start}, back = back, forward = forward, skips = skips })
		`,
	});
	// Rogue and Shaman steps are passed over; done and skipped steps are shown.
	assert.deepEqual(out.back, [...before, 1]);
	assert.deepEqual(out.forward, [...before.slice(0, -1).reverse(), start]);
	assert.deepEqual(out.skips, skipped);
});

test('a mid-guide quest log opens the guide at the Bael\'dun fortress, at login and in a new tab, with or without saved state', { skip }, () => {
	// Gann's Reclamation turned in, Revenge of Gann taken; Egg Hunt, Chol'aruk,
	// Betrayal from Within, Weapons of Choice and Wrongly Blamed ready to hand
	// in; the scroll and the note kept; Ziz Fizziks and Love's Gift carried.
	const done = [1507, 1508, 1509, 1510, 1511, 1515, 878, 5052, 843];
	const log = [[846, [1, 1, 1]], [868, [{ required: 12, fulfilled: 12 }]], [97003, [{ required: 1, fulfilled: 1 }]],
		[879, [{ fulfilled: 1 }, { fulfilled: 1 }, { fulfilled: 1 }]], [893, [{ fulfilled: 1 }, { fulfilled: 1 }, { fulfilled: 1 }]],
		[97250, [{ fulfilled: 1 }, { fulfilled: 1 }]], [3513, []], [79192, []], [1483, []], [1512, []]];
	const w = (m) => stepOf('warlock', m);
	// Soft goals behind the quest progress: the Camp Taurajo flight path and
	// bind, the Field of Giants and Blackthorn Ridge arrivals.
	const soft = [w({ t: 'getfp', location: 'Camp Taurajo' }), w({ t: 'collect', quest: 868 }), w({ t: 'collect', quest: 879, oi: 3 })];
	const script = `emit({ at = E.GetStepIndex(), soft = { ${soft.map((s) => `E.GetStepView(${s}).status`).join(', ')} } })`;
	const expected = { at: w({ t: 'collect', quest: 846, oi: 1 }), soft: ['done', 'done', 'done'] };
	const [lost] = play({ done, log, level: 22, saved: LOST, open: 'set', script });
	assert.deepEqual(lost, expected, 'SavedVariables lost: placed from the log alone');
	const checkOffs = savedState('warlock', {
		manual: [`${w({ t: 'fly', location: 'Undercity' })}:1`, `${w('Zeppelin to Durotar')}:1`],
	});
	const [reload] = play({ done, log, level: 22, saved: checkOffs, script });
	assert.deepEqual(reload, expected, 'stored check-offs do not hold the guide at its opening steps');
	const [tab] = play({ done, log, level: 22, saved: FRESH, open: 'tab', script });
	assert.deepEqual(tab, expected, 'a guide opened in a new tab');
});

// ---------------------------------------------------------------------------
// 02-barrens, Tauren Warrior
// ---------------------------------------------------------------------------

// A recorded Tauren Warrior at level 12: Questie's completed list for the
// character and the tracker's quest log. Tal (6363), Dizzywig (1492) and
// Thun'grim Firegaze (1502) ready to turn in, Plainstrider Menace 1/7, Raptor
// Thieves 0/12, The Disruption Ends 0/8, The Stagnant Oasis 0/1, Apothecary
// Zamah failed.
const WARRIOR_DONE = [743, 744, 745, 746, 747, 748, 749, 750, 751, 753, 754, 755, 756, 757, 758, 761, 763, 764, 765,
	766, 767, 771, 772, 773, 775, 780, 833, 848, 854, 860, 861, 870, 871, 1498, 1505, 1656, 1819, 3091, 3376, 5041,
	6361, 6362, 95805, 96130, 96627, 96628, 96630, 96638, 96652, 96656, 96659, 97485, 98424, 98427, 99079, 99080,
	99081, 99082, 99101, 99108];
const WARRIOR_LOG = [[6363, []], [1492, []], [844, [{ required: 7, fulfilled: 1 }]], [869, [12]], [853, []],
	[872, [8, 8, 1]], [877, [1]], [1502, []]];
const warrior = (opts) => play({ persona: 'warrior', level: 12, done: WARRIOR_DONE, log: WARRIOR_LOG, ...opts });

// A recorded saved state: the player pressed › (which then skipped the step) on
// every open step up to the Wailing Caverns mound, with this quest log.
function warriorJumped() {
	const mound = stepOf('warrior', { t: 'collect', quest: 1491 });
	const [state] = warrior({
		saved: FRESH,
		open: 'tab',
		script: `
			local n = 0
			while E.GetStepIndex() and E.GetStepIndex() < ${mound} and n < 100 do E.Skip(); stub.advance(0.3); n = n + 1 end
			local skips = {}
			for s in pairs(PolestarCharDB.skipped["${PERSONAS.warrior.id}"]) do skips[#skips + 1] = s end
			table.sort(skips)
			emit({ at = E.GetStepIndex(), skips = skips })
		`,
	});
	assert.equal(state.at, mound);
	return { saved: savedState('warrior', { skipped: state.skips }), skips: state.skips, mound };
}

test('a reload keeps the Warrior at the mound they skipped to: skips stand even over quest work in the log', { skip }, () => {
	const w = (m) => stepOf('warrior', m);
	const jumped = warriorJumped();
	const [out] = warrior({
		saved: jumped.saved,
		script: `
			local skips = {}
			for s in pairs(PolestarCharDB.skipped["${PERSONAS.warrior.id}"]) do skips[#skips + 1] = s end
			table.sort(skips)
			emit({ at = E.GetStepIndex(), skips = skips })
		`,
	});
	assert.equal(out.at, jumped.mound);
	assert.deepEqual(out.skips, jumped.skips, 'the raptor heads, The Disruption Ends, Tal... stay skipped');
	assert.ok(jumped.skips.includes(w({ t: 'collect', quest: 869 })), 'Raptor Thieves (0/12, in the log) was among them');

	// Without saved skips the quest log places them: Raptor Thieves (0/12) is
	// the first started work, at the Razormane camp.
	const [lost] = warrior({ saved: LOST, open: 'set', script: 'emit(E.GetStepIndex())' });
	assert.equal(lost, w({ t: 'collect', quest: 869 }), 'SavedVariables lost');
	const [tab] = warrior({ saved: FRESH, open: 'tab', script: 'emit(E.GetStepIndex())' });
	assert.equal(tab, lost, 'a new tab');
});

test('the Warrior plays on from the mound; a reload after a few turn-ins keeps them there, and Unskip brings a step back', { skip }, () => {
	const w = (m) => stepOf('warrior', m);
	const jumped = warriorJumped();
	const tal = w({ t: 'turnin', quest: 6363 });
	const talGoal = guideOf('warrior').steps[tal - 1].goals.findIndex((g) => g.t === 'turnin' && g.quest === 6363) + 1;
	const heads = w({ t: 'collect', quest: 869 });
	const [played] = warrior({
		saved: jumped.saved,
		script: `
			local w, r = stub.world, {}
			w.turnIn(6363); stub.advance(0.6); r.tal = { E.GetStepIndex(), E.GetStepView(${tal}).goals[${talGoal}].status }
			w.turnIn(1492); stub.advance(0.6)
			w.progress(844, 1, 7); w.turnIn(844); stub.advance(0.6); r.others = E.GetStepIndex()
			r.unskip = E.Unskip(${heads}); stub.advance(0.6); r.heads = E.GetStepIndex()
			emit(r)
		`,
	});
	assert.deepEqual(played, { tal: [jumped.mound, 'done'], others: jumped.mound, unskip: true, heads });

	const done = [...WARRIOR_DONE, 6363, 1492, 844];
	const log = [[869, [12]], [853, []], [872, [8, 8, 1]], [877, [1]], [1502, []]];
	const [reload] = warrior({ done, log, saved: jumped.saved, script: 'emit(E.GetStepIndex())' });
	assert.equal(reload, jumped.mound, 'saved skips kept: still at the mound');
	const [lost] = warrior({ done, log, saved: LOST, open: 'set', script: 'emit(E.GetStepIndex())' });
	assert.equal(lost, heads, 'without saved skips: the raptor heads, the first started work');
});

test('placement: accepts the character cannot take yet are not the start, and travel steps pass when the player already stands at the work', { skip }, () => {
	// A fresh 02-barrens at level 8: every accept needs level 9 or more.
	const [low] = warrior({ done: [], log: [], level: 8, saved: FRESH, open: 'tab', script: 'emit(E.GetStepIndex())' });
	let first = 1;
	while (!applies('warrior', first)) first++;
	assert.equal(low, first, 'nothing to start yet: the guide waits at its first step');
	// A Warlock with Gan'rul's chain under way (Devourer of Souls done, Blind
	// Cazul in the log) opening 04-barrens: from Tarren Mill the trip starts at
	// the bat; standing by Zankaja in Orgrimmar, the bat and the zeppelin are
	// behind, and Orgrimmar's flight path and training still hold.
	const opts = { done: [1507], log: [[1508, []]], saved: FRESH, open: 'tab' };
	const bat = stepOf('warlock', { t: 'fly', location: 'Undercity' });
	const zeppelin = stepOf('warlock', 'Zeppelin to Durotar');
	const orgrimmar = stepOf('warlock', { t: 'getfp', location: 'Orgrimmar' });
	const [there] = play({ ...opts, at: [1454, 37.2, 59.6], script: `emit({ at = E.GetStepIndex(), bat = E.GetStepView(${bat}).status, zeppelin = E.GetStepView(${zeppelin}).status })` });
	assert.deepEqual(there, { at: orgrimmar, bat: 'done', zeppelin: 'done' });
	const [tarren] = play({ ...opts, at: [1424, 56, 20], script: 'emit(E.GetStepIndex())' });
	assert.equal(tarren, bat, 'far from the work: the trip starts at the bat');
});
