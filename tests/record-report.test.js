'use strict';
// `record report` (tools/lib/recording/report.js) on synthetic recordings:
// a /reload mid-step, an AFK gap and an idle gap, a Prev/Next jump, a second
// character across two sessions, and a second guide in another tab.

const { test } = require('node:test');
const assert = require('node:assert/strict');
const fs = require('node:fs');
const path = require('node:path');
const { buildReport, formatReport } = require('../tools/lib/recording/report');
const { tmpdir } = require('./helpers/tmp');
const { polestar } = require('./helpers/cli');

const G = 'forever/alliance/human/01-elwynn';
const G2 = 'professions/mining';
// Elwynn Forest: 5200 yd wide, so 1% of x = 52 yd.
const MAPS = { 1429: { name: 'Elwynn Forest', type: 3, parent: 1415, c: 0, left: 1100, right: -4100, top: 1800, bottom: -1666.67 } };

function session(name, started, events) {
	return {
		schema: 1, session: `${started}-${name}`, char: { name, realm: 'Test Realm', race: 'Human', class: 'WARRIOR', faction: 'Alliance' },
		started, ended: started + 3000, events, maps: MAPS,
	};
}

const at = { map: 1429, x: 50, y: 50 };
const step = (t, reason, guide, stepIndex, lvl, xp, extra = {}) => ({
	t, e: 'step', v: 1, reason, guide, ...(stepIndex ? { step: stepIndex } : {}), lvl, xp, xpMax: lvl === 1 ? 400 : 900, ...at, ...extra,
});

function alpha() {
	const walk = [];
	for (let i = 1; i <= 20; i++) walk.push({ t: 2600 + i * 10, e: 'pos', map: 1429, x: 50 - i, y: 50 });
	return session('Alpha', 1791000000, [
		step(0, 'login', G, 1, 1, 0, { title: 'Deputy Willem', guideTitle: 'Elwynn Forest' }),
		{ t: 10, e: 'combat', on: true, ...at },
		{ t: 40, e: 'combat', on: false },
		step(60, 'step', G, 2, 1, 100, { title: 'Kobold Camp' }),
		{ t: 100, e: 'turnin', q: 7, xpReward: 170, money: 35, lvl: 1, ...at },
		{ t: 110, e: 'pos', ...at },
		// /reload: the session continues, the recorder snapshots the same step
		step(130, 'login', G, 2, 1, 300, { title: 'Kobold Camp' }),
		{ t: 150, e: 'death', ...at },
		{ t: 170, e: 'revive', ...at },
		// a level-up inside step 2 (cumulative XP: 400 + 50)
		step(200, 'step', G, 3, 2, 50, { title: 'Wolves' }),
		{ t: 220, e: 'afk', on: true },
		{ t: 1420, e: 'afk', on: false },
		{ t: 1430, e: 'pos', ...at },
		// 1000 s with no events and no AFK flag: counted as 5 minutes
		step(2430, 'step', G, 4, 2, 150, { title: 'Goldshire' }),
		// Prev back to step 3, Next again
		step(2500, 'step', G, 3, 2, 150, { title: 'Wolves' }),
		step(2560, 'step', G, 4, 2, 200, { title: 'Goldshire' }),
		step(2600, 'step', G, 5, 2, 300, { title: 'Into Westfall' }),
		...walk, // 20 x 52 yd
		{ t: 2810, e: 'pos', map: 1429, x: 80, y: 50 }, // hearthstone: 1560 yd in 10 s is not travel
		step(2820, 'step', G, null, 2, 300),
		step(2820, 'complete', G, null, 2, 300),
	]);
}

function beta() {
	return [
		session('Beta', 1791100000, [
			step(0, 'login', G, 1, 1, 0, { title: 'Deputy Willem' }),
			// another tab: only the active tab's step is ever recorded
			step(100, 'guide', G2, 1, 1, 0, { title: 'Learn Mining', guideTitle: 'Mining 1-75' }),
			step(400, 'guide', G, 1, 1, 0, { title: 'Deputy Willem' }),
			step(500, 'step', G, 2, 1, 200, { title: 'Kobold Camp' }),
			{ t: 600, e: 'pos', ...at },
		]),
		// logged out mid-step 2, back the next day
		session('Beta', 1791200000, [
			step(0, 'login', G, 2, 1, 250, { title: 'Kobold Camp' }),
			step(90, 'step', G, 3, 1, 350, { title: 'Wolves' }),
			{ t: 150, e: 'pos', ...at },
		]),
	];
}

const SESSIONS = () => [alpha(), ...beta()];

function stepRow(report, guide, i) {
	return report.steps.find((r) => r.guide === guide && r.step === i);
}

test('per-step passes: reloads and tab switches continue a pass, AFK and idle gaps are capped, Prev/Next is a revisit', () => {
	const r = buildReport(SESSIONS());
	assert.equal(r.sessions, 3);
	assert.equal(r.characters, 2);

	// Step 1: Alpha 60 s (30 in combat); Beta 100 s, a tab switch to Mining, 100 s more.
	const s1 = stepRow(r, G, 1);
	assert.deepEqual(
		{ passes: s1.passes, chars: s1.chars, median: s1.medianTime, p75: s1.p75Time, xp: s1.xp, xpPerHour: s1.xpPerHour, combat: s1.combatShare },
		{ passes: 2, chars: 2, median: 130, p75: 200, xp: 300, xpPerHour: Math.round((300 * 3600) / 260), combat: 30 / 260 },
	);

	// Step 2: Alpha 70 s + a /reload + 70 s, with a level-up (100 -> 400+50 XP),
	// a death and a turn-in; Beta 100 s, logout, 90 s next session (200 -> 350 XP).
	const s2 = stepRow(r, G, 2);
	assert.deepEqual(
		{ passes: s2.passes, median: s2.medianTime, xp: s2.xp, deaths: s2.deaths, turnins: s2.turnins },
		{ passes: 2, median: 165, xp: 350 + 150, deaths: 1, turnins: 1 },
	);

	// Step 3: 20 s, AFK 20 min (0), 10 s, 1000 s idle (capped at 300). The Prev
	// back to it is a 60 s revisit, not a pass. Beta's pass is still open.
	const s3 = stepRow(r, G, 3);
	assert.deepEqual(
		{ passes: s3.passes, open: s3.open, median: s3.medianTime, xp: s3.xp, revisits: s3.revisits, revisitTime: s3.revisitTime },
		{ passes: 1, open: 1, median: 330, xp: 100, revisits: 1, revisitTime: 60 },
	);

	// Step 4: 70 s, the Prev, 40 s after Next; XP 0 + 100.
	const s4 = stepRow(r, G, 4);
	assert.deepEqual({ median: s4.medianTime, xp: s4.xp }, { median: 110, xp: 100 });

	// Step 5: 220 s walking 1040 yd for no XP; the hearthstone jump is not travel.
	const s5 = stepRow(r, G, 5);
	assert.deepEqual({ median: s5.medianTime, xp: s5.xp, yards: s5.medianYards }, { median: 220, xp: 0, yards: 1040 });

	// The Mining tab's time is its own, its only step still open.
	const mining = stepRow(r, G2, 1);
	assert.deepEqual({ passes: mining.passes, open: mining.open }, { passes: 0, open: 1 });
});

test('per-guide totals and the ranked lists', () => {
	const r = buildReport(SESSIONS());
	const g = r.guides.find((x) => x.id === G);
	assert.equal(g.title, 'Elwynn Forest');
	assert.equal(g.completedRuns, 1);
	// Alpha's completed run: every segment, revisit included.
	assert.equal(g.medianTime, 60 + 140 + 330 + 110 + 60 + 220);
	// level 1 (0 XP) to level 2 + 300/900
	assert.equal(g.levelsGained, 1.33);
	// All runs: Alpha 700 XP in 920 s, Beta 350 XP in 450 s.
	assert.equal(g.xpPerHour, Math.round((1050 * 3600) / 1370));
	assert.equal(g.revisitTime, 60);
	const alphaRun = g.runs.find((x) => x.char === 'Alpha-Test Realm');
	assert.deepEqual({ time: alphaRun.time, xp: alphaRun.xp, completed: alphaRun.completed }, { time: 920, xp: 700, completed: true });

	assert.deepEqual(
		r.slowest.filter((x) => x.guide === G).map((x) => x.step),
		[5, 3, 4, 1, 2],
	);
	// Step medians 110, 130, 165, 220, 330: step 3 is twice the 165 s median.
	assert.deepEqual(r.overBaseline.map((x) => [x.step, x.medianTime, x.baseline, x.excess]), [[3, 330, 165, 165]]);
	assert.deepEqual(r.detours.map((x) => [x.guide, x.step, x.medianYards, x.medianXp]), [[G, 5, 1040, 0]]);
});

// A synthetic 1000-yard map makes each percentage point ten yards.
function movementReport(events, schema = 2) {
	return buildReport([{ ...session('Movement', 1791300000, events), schema, maps: { 1429: { left: 0, right: 1000, top: 0, bottom: 1000 } } }]);
}

const remotePoints = [
	{ e: 'poi', q: 7, done: false },
	{ e: 'treasure', object: 10 },
	{ e: 'rare', npc: 6, src: 'v' },
];

for (const point of remotePoints) {
	test(`${point.e} map points do not invent travel or detours for a stationary player`, () => {
		const r = movementReport([
			step(0, 'step', G, 1, 1, 0),
			{ ...point, t: 200, ...at, x: 90 },
			{ e: 'pos', t: 400, ...at },
			step(600, 'step', G, 2, 1, 100),
		]);
		const row = stepRow(r, G, 1);
		assert.equal(row.medianYards, 0);
		assert.deepEqual(r.detours, []);
		// The sighting still supplies an event timestamp: skipping it entirely
		// would join two gaps and discard 100 seconds through the idle cap.
		assert.equal(row.medianTime, 600);
		assert.equal(row.xp, 100);
	});
}

test('schema-1 rare vignettes are remote points too', () => {
	const r = movementReport([
		step(0, 'step', G, 1, 1, 0),
		{ e: 'rare', src: 'vignette', npc: 6, t: 200, ...at, x: 90 },
		{ e: 'pos', t: 400, ...at },
		step(600, 'step', G, 2, 1, 100),
	], 1);
	assert.equal(stepRow(r, G, 1).medianYards, 0);
	assert.deepEqual(r.detours, []);
});

test('travel continues from the last player position through remote sightings', () => {
	const r = movementReport([
		step(0, 'step', G, 1, 1, 0),
		{ e: 'pos', t: 100, ...at, x: 60 },
		...remotePoints.map((point, i) => ({ ...point, t: 150 + 50 * i, ...at, x: [90, 5, 10][i] })),
		{ e: 'pos', t: 300, ...at, x: 70 },
		step(400, 'step', G, 2, 1, 100, { x: 70 }),
	]);
	assert.equal(stepRow(r, G, 1).medianYards, 200);
	assert.deepEqual(r.detours, []);
});

test('a quest point on another map does not break the player position trail', () => {
	const r = movementReport([
		step(0, 'step', G, 1, 1, 0),
		{ e: 'poi', t: 100, map: 1430, x: 90, y: 50, q: 7 },
		{ e: 'pos', t: 200, ...at, x: 70 },
		step(300, 'step', G, 2, 1, 100, { x: 70 }),
	]);
	assert.equal(stepRow(r, G, 1).medianYards, 200);
});

test('creature sightings made at the player position still measure travel', () => {
	const sightings = [
		{ schema: 2, e: 'unit', src: 'target' },
		{ schema: 2, e: 'unitx' },
		...['p', 't', 'm'].map((src) => ({ schema: 2, e: 'rare', src })),
		...['nameplate', 'target', 'mouseover'].map((src) => ({ schema: 1, e: 'rare', src })),
	];
	for (const { schema, ...point } of sightings) {
		const r = movementReport([
			step(0, 'step', G, 1, 1, 0),
			{ ...point, t: 100, ...at, x: 60, npc: 6 },
			{ e: 'pos', t: 200, ...at },
			step(300, 'step', G, 2, 1, 100),
		], schema);
		assert.equal(stepRow(r, G, 1).medianYards, 200, JSON.stringify(point));
	}
});

test('--guide narrows the report; the text report names steps, revisits and open passes', () => {
	const r = buildReport(SESSIONS(), { guide: 'MINING' });
	assert.deepEqual(r.guides.map((g) => g.id), [G2]);
	assert.ok(r.steps.every((s) => s.guide === G2));

	const text = formatReport(buildReport(SESSIONS()));
	assert.match(text, /Route report: 3 session\(s\), 2 character\(s\), 2 guide\(s\)/);
	assert.match(text, /3 Wolves\s+1\+1 open\s+5m30s/);
	assert.match(text, /1 \(1m00s\)/);
	assert.match(text, /Detours[\s\S]*#5 Into Westfall\s+1,040 yd/);
	assert.match(text, /baseline: the guide's median step/);
});

test('record report CLI: text, --json, --guide, and no recordings', () => {
	const dir = tmpdir('polestar-report-');
	for (const s of SESSIONS()) fs.writeFileSync(path.join(dir, `${s.session}.json`), JSON.stringify(s));
	const run = (...args) => polestar(['record', 'report', '--recordings', dir, ...args]);

	const text = run();
	assert.equal(text.status, 0, text.stderr);
	assert.match(text.stdout, /Slowest steps by XP\/hr/);

	const json = run('--json', '--guide', 'elwynn', '--top', '2');
	assert.equal(json.status, 0, json.stderr);
	const r = JSON.parse(json.stdout);
	assert.deepEqual(r.guides.map((g) => g.id), [G]);
	assert.equal(r.slowest.length, 2);

	const none = run('--guide', 'nowhere');
	assert.equal(none.status, 1);
	assert.match(none.stderr, /no recorded guide matches "nowhere"/);

	const empty = polestar(['record', 'report', '--recordings', path.join(dir, 'missing')]);
	assert.equal(empty.status, 1);
	assert.match(empty.stderr, /no sessions/);
});

test('sessions without Polestar (no step snapshots) report nothing instead of failing', () => {
	const plain = session('Gamma', 1791300000, [
		{ t: 0, e: 'zone', map: 1429, zone: 'Elwynn Forest' },
		{ t: 30, e: 'pos', ...at },
	]);
	const r = buildReport([plain]);
	assert.deepEqual([r.guides, r.steps, r.slowest], [[], [], []]);
	assert.match(formatReport(r), /No guide steps recorded/);
});

test('completion ends a step at its final time, XP and position before unrelated play', () => {
	const r = buildReport([session('Done', 1, [
		step(0, 'login', G, 1, 1, 0, { combat: true }),
		step(60, 'complete', G, null, 1, 100, { x: 51 }),
		{ t: 80, e: 'death', ...at },
		{ t: 90, e: 'turnin', q: 7, ...at },
		step(120, 'guide', G2, 1, 1, 200),
		step(180, 'step', G2, 2, 1, 300),
	])]);
	const last = stepRow(r, G, 1);
	assert.deepEqual(
		{ time: last.totalTime, xp: last.xp, yards: last.medianYards, deaths: last.deaths, turnins: last.turnins, combat: last.combatShare, passes: last.passes, open: last.open },
		{ time: 60, xp: 100, yards: 52, deaths: 0, turnins: 0, combat: 1, passes: 1, open: 0 },
	);
	const run = r.guides.find((g) => g.id === G).runs[0];
	assert.deepEqual({ time: run.time, xp: run.xp, completed: run.completed }, { time: 60, xp: 100, completed: true });
	assert.equal(stepRow(r, G2, 1).totalTime, 60);
	assert.equal(stepRow(r, G2, 1).xp, 100);
	assert.equal(r.unattributedTime, 60, 'play between completion and the next guide is retained');
	assert.equal(r.guides.reduce((sum, g) => sum + g.runs.reduce((n, run) => n + run.time, 0), 0) + r.unattributedTime, 180);
});

for (const order of ['before', 'after']) {
	test(`a terminal snapshot ${order} completion does not restart the completed guide's time`, () => {
		const terminal = step(60, 'step', G, null, 1, 100);
		const complete = step(60, 'complete', G, null, 1, 100);
		const events = [
			step(0, 'login', G, 1, 1, 0),
			...(order === 'before' ? [terminal, complete] : [complete, terminal]),
			{ t: 120, e: 'pos', ...at },
		];
		const r = buildReport([
			session('Done', 1, events),
			// A reload or tab switch can snapshot the completed guide without a step.
			session('Done', 1000, [
				step(0, 'login', G, null, 1, 200),
				{ t: 60, e: 'pos', ...at },
				step(120, 'guide', G2, 1, 1, 250),
				step(180, 'step', G2, 2, 1, 300),
			]),
		]);
		const g = r.guides.find((g) => g.id === G);
		assert.equal(g.completedRuns, 1);
		assert.deepEqual({ time: g.runs[0].time, xp: g.runs[0].xp }, { time: 60, xp: 100 });
		assert.deepEqual({ passes: stepRow(r, G, 1).passes, open: stepRow(r, G, 1).open }, { passes: 1, open: 0 });
		assert.equal(stepRow(r, G2, 1).totalTime, 60);
		assert.equal(stepRow(r, G2, 1).xp, 50);
		assert.equal(r.unattributedTime, 180, 'both snapshot orders retain play without counting the offline gap');
	});
}

test('unattributed play after completion preserves AFK state and the idle cap', () => {
	for (const { before = [], after, expected } of [
		{ after: [{ t: 80, e: 'afk', on: true }, { t: 160, e: 'afk', on: false }, { t: 200, e: 'pos', ...at }], expected: 60 },
		{ before: [{ t: 40, e: 'afk', on: true }], after: [{ t: 160, e: 'afk', on: false }, { t: 200, e: 'pos', ...at }], expected: 40 },
		{ after: [{ t: 660, e: 'pos', ...at }], expected: 300 },
		{ after: [], expected: 0 },
	]) {
		const r = buildReport([session('Done', 1, [
			step(0, 'login', G, 1, 1, 0), ...before,
			step(60, 'complete', G, null, 1, 100), ...after,
		])]);
		assert.equal(r.unattributedTime, expected);
		assert.equal(stepRow(r, G, 1).xp, 100, 'later unassigned play cannot change the completed step');
	}
});

test('a background guide completion leaves the active guide segment running', () => {
	const r = buildReport([session('Tabs', 1, [
		step(0, 'login', G, 1, 1, 0),
		step(30, 'guide', G2, 1, 1, 50),
		step(60, 'complete', G, null, 1, 100),
		step(120, 'step', G2, 2, 1, 200),
	])]);
	assert.deepEqual(
		{ time: stepRow(r, G, 1).totalTime, xp: stepRow(r, G, 1).xp, passes: stepRow(r, G, 1).passes },
		{ time: 30, xp: 50, passes: 1 },
	);
	assert.deepEqual(
		{ time: stepRow(r, G2, 1).totalTime, xp: stepRow(r, G2, 1).xp },
		{ time: 90, xp: 150 },
	);
});

test('reopening an actual step after completion starts a new pass', () => {
	const r = buildReport([session('Repeat', 1, [
		step(0, 'login', G, 1, 1, 0),
		step(60, 'complete', G, null, 1, 100),
		step(60, 'step', G, null, 1, 100),
		step(120, 'guide', G, 1, 1, 200),
		step(180, 'complete', G, null, 1, 300),
	])]);
	const row = stepRow(r, G, 1);
	assert.deepEqual({ passes: row.passes, open: row.open, time: row.totalTime, xp: row.xp }, { passes: 2, open: 0, time: 120, xp: 200 });
	const run = r.guides[0].runs[0];
	assert.deepEqual({ time: run.time, xp: run.xp }, { time: 120, xp: 200 });
});

test('completion without an XP snapshot does not borrow XP from the next session', () => {
	const r = buildReport([
		session('NoXp', 1, [
			step(0, 'login', G, 1, 1, 0),
			{ t: 30, e: 'accept', lvl: 1, xp: 50 },
			{ t: 60, e: 'step', reason: 'complete', guide: G },
		]),
		session('NoXp', 1000, [step(0, 'login', G2, 1, 1, 200)]),
	]);
	assert.equal(stepRow(r, G, 1).xp, 50);
	assert.equal(stepRow(r, G, 1).totalTime, 60);
});
