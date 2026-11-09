'use strict';
// Guides are scored on what they require (docs/legacy/SIMULATION-js.md §5, issue #30):
// `sim compare` leaves a guide's optional goals out unless --with-optional.

const { test } = require('node:test');
const assert = require('node:assert/strict');
const fs = require('node:fs');
const os = require('node:os');
const path = require('node:path');

const { loadPolestarRoutes, requiredEvents } = require('../tools/lib/sim/baselines/polestar');
const { sources } = require('../tools/lib/sim/compare');

const FIX = path.join(__dirname, 'fixtures', 'sim', 'polestar');

// The sample guides with an optional turn-in (90010) and an optional quest
// (90020, accept optional) in North.
function guides() {
	const dir = fs.mkdtempSync(path.join(os.tmpdir(), 'polestar-optional-'));
	fs.cpSync(path.join(FIX, 'guides'), dir, { recursive: true });
	const north = path.join(dir, 'forever', 'horde', '02-north.guide');
	fs.writeFileSync(north, fs.readFileSync(north, 'utf8').replace('  turnin 90010 "North Task"\n', '  turnin 90010 "North Task" optional\n  accept 90020 optional\n  turnin 90020\n'));
	return dir;
}

const quests = (events) => events.filter((e) => e.q != null && e.t !== 'guide').map((e) => `${e.t} ${e.q}`);

test('requiredEvents: an optional quest goes whole, another optional goal by itself', () => {
	const ev = [
		{ t: 'accept', q: 1 },
		{ t: 'complete', q: 1, obj: 1, optional: true },
		{ t: 'turnin', q: 1 },
		{ t: 'accept', q: 2, optional: true },
		{ t: 'complete', q: 2, obj: 1 },
		{ t: 'turnin', q: 2 },
		{ t: 'level', level: 5, xp: null },
	];
	assert.deepEqual(requiredEvents(ev), [ev[0], ev[2], ev[6]]);
});

test('sim compare scores the guides without their optional goals; --with-optional keeps them', () => {
	const dir = guides();
	const simDir = fs.mkdtempSync(path.join(os.tmpdir(), 'polestar-optional-sim-'));
	try {
		const all = loadPolestarRoutes({ guidesDir: dir, dataDir: path.join(FIX, 'data'), faction: 'Horde', race: 'Orc' }).default.events;
		assert.ok(quests(all).includes('turnin 90010') && quests(all).includes('accept 90020'));
		const o = { guidesDir: dir, dataDir: path.join(FIX, 'data'), simDir };
		const polestar = (opts) => sources({ ...o, ...opts }, 'Horde', 'Orc', { world: null }, { world: null }).list.find((s) => s.id === 'polestar').events;
		const req = quests(polestar({}));
		assert.ok(req.includes('accept 90010'));
		assert.ok(!req.includes('turnin 90010'));
		assert.ok(!req.some((x) => x.endsWith(' 90020')));
		assert.deepEqual(quests(polestar({ withOptional: true })), quests(all));
	} finally {
		fs.rmSync(dir, { recursive: true, force: true });
		fs.rmSync(simDir, { recursive: true, force: true });
	}
});

test('the routes play a `when dungeon` step only for a chosen dungeon and a `when !dungeon` step only for one not chosen', () => {
	const dir = fs.mkdtempSync(path.join(os.tmpdir(), 'polestar-dungeon-'));
	try {
		fs.cpSync(path.join(FIX, 'guides'), dir, { recursive: true });
		const north = path.join(dir, 'forever', 'horde', '02-north.guide');
		fs.appendFileSync(north, '\nstep The run\n  when dungeon "Wailing Caverns"\n  accept 90020\n  turnin 90020\n\nstep Solo\n  when !dungeon "Wailing Caverns"\n  level 7\n');
		const play = (dungeons) => loadPolestarRoutes({ guidesDir: dir, dataDir: path.join(FIX, 'data'), faction: 'Horde', race: 'Orc', dungeons }).default.events;
		const solo = play(null);
		assert.ok(!quests(solo).some((x) => x.endsWith(' 90020')), 'none chosen: the solo route');
		assert.ok(solo.some((e) => e.t === 'level' && e.level === 7));
		for (const chosen of [['Wailing Caverns'], 'all']) {
			const run = play(chosen);
			assert.ok(quests(run).includes('accept 90020') && quests(run).includes('turnin 90020'), String(chosen));
			assert.ok(!run.some((e) => e.t === 'level' && e.level === 7), String(chosen));
		}
		assert.ok(!quests(play(['The Deadmines'])).some((x) => x.endsWith(' 90020')), 'another dungeon');
	} finally {
		fs.rmSync(dir, { recursive: true, force: true });
	}
});

test('a dungeon quest runs its dungeon once, and only when the sequence took the quest: a hand-in alone runs nothing', () => {
	const { compileSequence } = require('../tools/lib/sim/sequence');
	const { K_DUNGEON, K_TURNIN } = require('../tools/lib/sim/run');
	// two dungeon quests (index 0, 1) in dungeon 0, one open-world quest (2) with one task
	const run = {
		qIndex: new Map([[100, 0], [101, 1], [102, 2]]), qDungeon: [0, 0, -1], dungeons: [{ pt: 7 }],
		qTask0: [0, 0, 0], qTask1: [0, 0, 1], taskPt: [3], qAccept: [1, 1, 1], qGiver: [1, 1, 1], qEnder: [2, 2, 2],
	};
	const kinds = (events) => Array.from(compileSequence(run, events).kind);
	assert.equal(kinds([{ t: 'turnin', q: 100 }, { t: 'turnin', q: 101 }]).filter((k) => k === K_DUNGEON).length, 0, 'never taken: no run');
	const took = kinds([{ t: 'accept', q: 100 }, { t: 'accept', q: 101 }, { t: 'complete', q: 100 }, { t: 'turnin', q: 100 }, { t: 'turnin', q: 101 }]);
	assert.equal(took.filter((k) => k === K_DUNGEON).length, 1, 'one run for both quests');
	assert.equal(took.filter((k) => k === K_TURNIN).length, 2);
});
