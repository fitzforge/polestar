'use strict';

const { test } = require('node:test');
const assert = require('node:assert/strict');
const { buildReport, formatReport } = require('../tools/lib/recording/report');

const G = 'synthetic/dialog';
const MAPS = { 1: { left: 0, right: 1000, top: 0, bottom: 1000 }, 2: { left: 0, right: 1000, top: 0, bottom: 1000 } };
const pos = (t, x, map = 1) => ({ t, e: 'pos', map, x, y: 50 });
const step = (t, n, x, extra = {}) => ({ ...pos(t, x), e: 'step', guide: G, step: n, reason: 'step', lvl: 1, xp: 0, xpMax: 400, ...extra });
const session = (events, extra = {}) => ({ schema: 2, session: 'dialog', char: { id: 'dialog' }, started: 1791000000, events, maps: MAPS, ...extra });
const row = (events, extra) => buildReport([session(events, extra)]).steps.find((r) => r.step === 1);
const dialogs = [
	{ e: 'accept', q: 7, npc: 800 },
	{ e: 'turnin', q: 7, npc: 800 },
	{ e: 'detail', q: 7, item: 900, startItem: 900 },
];

for (const dialog of dialogs) {
	test(dialog.e + ' keeps walking before and after cached dialog coordinates', () => {
		const events = [step(0, 1, 10), pos(10, 11), { ...pos(20, 10), ...dialog }, pos(30, 12), step(40, 2, 12)];
		assert.equal(row(events).medianYards, 20, 'neither a return to the dialog nor a lost walking leg');

		// Real recorder/importer shape: 4 yd walked while a dialog remains open.
		// Quantized trail x=50.08 precedes the later action's cached x=50.
		const actionTime = dialog.e === 'detail' ? 61 : 1; // item-popup duplicate suppression lasts 60 s
		const recorded = [step(0, 1, 50), pos(0.8, 50.08), { ...pos(actionTime, 50), ...dialog }, { ...pos(actionTime + 0.5, 50.08), e: 'mark' }, step(actionTime + 1, 2, 50.08)];
		assert.equal(row(recorded, { maps: { 1: { left: 1100, right: -4100, top: 1800, bottom: -1666.7 } } }).medianYards, 4);
	});

	test(dialog.e + ' cannot replace the walking anchor map or timestamp', () => {
		assert.equal(row([step(0, 1, 10), pos(10, 11), { ...pos(20, 10, 2), ...dialog }, pos(30, 12), step(40, 2, 12)]).medianYards, 20);
		// 300 yd in 10 s is walking; replacing the anchor time with t=9 would
		// turn the same movement into a rejected 300 yd/s teleport.
		assert.equal(row([step(0, 1, 10), { ...pos(9, 10), ...dialog }, pos(10, 40), step(20, 2, 40)]).medianYards, 300);
	});
}

for (const fresh of [
	{ e: 'detail', q: 7, npc: 800 },
	{ e: 'detail', q: 7, object: 800 },
	{ e: 'detail', q: 7 },
	{ e: 'detail', q: 7, npc: 800, startItem: 900 },
	{ e: 'offer', npc: 800, available: [7] },
	{ e: 'gossip', npc: 800, option: 1 },
	{ e: 'progress', q: 7, oi: 1, cur: 1, max: 2 },
]) {
	test('fresh quest position remains a movement sample: ' + JSON.stringify(fresh), () => {
		// The intermediate event is the only observation of the excursion;
		// dropping every quest event would incorrectly report zero yards.
		assert.equal(row([step(0, 1, 10), { ...pos(10, 20), ...fresh }, pos(20, 10), step(30, 2, 10)]).medianYards, 200);
	});
}

test('unmarked fresh fallbacks use the same conservative dialog position rule', () => {
	// Accept/turn-in can use fresh context when a matching dialog was missed
	// or expired; first item-use detail is fresh too. The format does not mark
	// freshness, so these points cannot safely be used as walking samples.
	for (const dialog of [{ e: 'accept', q: 7 }, { e: 'turnin', q: 7 }, { e: 'detail', q: 7, item: 900, startItem: 900 }]) {
		assert.equal(row([step(0, 1, 10), { ...pos(10, 20), ...dialog }, pos(20, 10), step(30, 2, 10)]).medianYards, 0);
	}
});

test('a dialog position cannot seed a missing walking anchor', () => {
	for (const dialog of dialogs) {
		assert.equal(row([step(0, 1, null, { map: null }), { ...pos(10, 10), ...dialog }, pos(20, 11), step(30, 2, 11)]).medianYards, 0);
	}
});

test('cached positions preserve event timing, XP observations, turn-ins, and the recorded input', () => {
	const events = [
		step(0, 1, 10), pos(10, 11), { t: 20, e: 'combat', on: true },
		{ ...pos(30, 10), e: 'accept', q: 7, lvl: 1, xp: 50 },
		{ t: 40, e: 'combat', on: false }, { t: 50, e: 'afk', on: true },
		{ ...pos(400, 10), e: 'turnin', q: 7, xpReward: 100 },
		{ t: 450, e: 'afk', on: false }, { ...pos(600, 10), e: 'detail', q: 8, item: 900, startItem: 900 },
		{ t: 700, e: 'death' }, { ...pos(1100, 10), e: 'accept', q: 8, lvl: 1, xp: 75 },
		pos(1110, 12), step(1120, 2, 12, { lvl: null, xp: null }),
	];
	// Legacy accepts observed current XP; without a later usable snapshot,
	// that observation still closes this pass. Turn-in reward XP is separate.
	const source = [session(events, { schema: 1 })];
	const before = structuredClone(source);
	const control = structuredClone(source);
	for (const i of [3, 6, 8, 10]) {
		delete control[0].events[i].map;
		delete control[0].events[i].x;
		delete control[0].events[i].y;
	}
	const report = buildReport(source);
	const first = report.steps.find((r) => r.step === 1);
	assert.deepEqual(
		[first.medianYards, first.medianTime, first.xp, first.turnins, first.deaths, first.combatShare, first.passes],
		[20, 620, 75, 1, 1, 20 / 620, 1],
	);
	assert.deepEqual(report, buildReport(control));
	assert.equal(formatReport(report), formatReport(buildReport(control)));
	assert.deepEqual(source, before, 'giver coordinates and quest facts remain available to other consumers');
});
