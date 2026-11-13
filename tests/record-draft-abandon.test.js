'use strict';

const { test } = require('node:test');
const assert = require('node:assert/strict');
const { draftGuide } = require('../tools/lib/recording/draft');
const { parseGuide } = require('../tools/lib/dsl/parse');
const { Diagnostics } = require('../tools/lib/dsl/diag');
const fixture = require('./fixtures/recordings/1791000000-Testchar.json');
const chunkBoundary = require('./fixtures/recordings/abandon-chunk-boundary.json');

// Synthetic quest attempts using the existing session's map and character.
function draft(events) {
	const session = {
		...fixture,
		events: [...events, { e: 'mark', text: 'Continue the route' }]
			.map((ev, i) => ({ t: i * 10, map: 1429, x: 40, y: 40, ...ev })),
	};
	const { text } = draftGuide(session);
	const diag = new Diagnostics();
	const guide = parseGuide(text, 'draft.guide', diag);
	assert.deepEqual(diag.list, []);
	return { text, goals: guide.steps.flatMap((step) => step.goals) };
}

function progress(q, type = 'monster') {
	return { e: 'progress', q, oi: 1, type, text: 'Recorded objective', cur: 1, max: 8 };
}

for (const [type, event, target] of [['monster', 'kill', 'npc'], ['item', 'loot', 'item']]) {
	test(`draft omits abandoned ${type} work for a quest accepted before recording`, () => {
		const { text, goals } = draft([
			progress(100, type),
			{ e: event, q: 100, oi: 1, [target]: 1001 },
			{ e: 'abandon', q: 100 },
		]);
		assert.deepEqual(goals.map((g) => g.verb), ['note']);
		assert.match(text, /# abandoned quest 100/);
	});

	test(`draft drops ${event} evidence before the first progress event when that attempt is abandoned`, () => {
		const { text, goals } = draft([
			{ e: event, q: 100, oi: 1, [target]: 1001 },
			{ e: 'abandon', q: 100 },
			{ e: 'accept', q: 100 },
			progress(100, type),
			{ e: event, q: 100, oi: 1, [target]: 1002 },
			{ e: 'turnin', q: 100 },
		]);
		const verb = type === 'monster' ? 'kill' : 'collect';
		assert.deepEqual(goals.map((g) => g.verb), ['accept', verb, 'turnin', 'note']);
		assert.match(text, new RegExp(`${verb} 1002 x8 quest 100\\.1`));
		assert.doesNotMatch(text, /1001/);
	});
}

test('draft uses only the later attempt when a pre-recording quest is abandoned and reaccepted', () => {
	const { text, goals } = draft([
		{ ...progress(100), x: 20, y: 20 },
		{ e: 'kill', q: 100, oi: 1, npc: 1001 },
		{ e: 'abandon', q: 100 },
		{ e: 'accept', q: 100, t: 20 }, // same timestamp: retain recorded order
		{ ...progress(100), x: 60, y: 60 },
		{ e: 'kill', q: 100, oi: 1, npc: 1001 },
		{ e: 'turnin', q: 100 },
	]);
	assert.deepEqual(goals.map((g) => g.verb), ['accept', 'kill', 'turnin', 'note']);
	assert.match(text, /kill 1001 x8 quest 100\.1 @60\.0,60\.0/);
});

test('draft keeps a completed pre-recording attempt when a later attempt is abandoned', () => {
	const { text, goals } = draft([
		progress(100),
		{ e: 'kill', q: 100, oi: 1, npc: 1001 },
		{ e: 'turnin', q: 100 },
		{ e: 'accept', q: 100 },
		progress(100),
		{ e: 'kill', q: 100, oi: 1, npc: 1002 },
		{ e: 'abandon', q: 100 },
	]);
	assert.deepEqual(goals.map((g) => g.verb), ['kill', 'turnin', 'note']);
	assert.match(text, /kill 1001 x8 quest 100\.1/);
	assert.doesNotMatch(text, /1002/);
	assert.match(text, /# quest 100 was accepted before this recording/);
});

test('draft keeps unrelated pre-recording quest work when another quest is abandoned', () => {
	const { text, goals } = draft([
		progress(100),
		{ e: 'kill', q: 100, oi: 1, npc: 1001 },
		progress(200),
		{ e: 'kill', q: 200, oi: 1, npc: 2001 },
		{ e: 'abandon', q: 100 },
	]);
	assert.deepEqual(goals.map((g) => g.verb), ['kill', 'note']);
	assert.match(text, /kill 2001 x8 quest 200\.1/);
	assert.doesNotMatch(text, /kill 1001/);
	assert.match(text, /# quest 200 was accepted before this recording/);
});

test('draft drops a kill recorded after abandonment with its original earlier timestamp', () => {
	const { text, goals } = draft([
		{ ...progress(100), t: 10 },
		{ e: 'abandon', q: 100, t: 12 },
		// Finds.lua waits three seconds for the objective tick and XP line.
		{ e: 'kill', q: 100, oi: 1, npc: 1001, t: 10 },
		{ e: 'accept', q: 100, t: 20 },
		{ ...progress(100), t: 30 },
		{ e: 'kill', q: 100, oi: 1, npc: 1002, t: 30 },
		{ e: 'turnin', q: 100, t: 40 },
	]);
	assert.deepEqual(goals.map((g) => g.verb), ['accept', 'kill', 'turnin', 'note']);
	assert.match(text, /kill 1002 x8 quest 100\.1/);
	assert.doesNotMatch(text, /1001/);
});

test('draft preserves a completed attempt\'s delayed kill when a later attempt is abandoned', () => {
	const { text, goals } = draft([
		{ ...progress(100), t: 10 },
		{ e: 'turnin', q: 100, t: 11 },
		{ e: 'accept', q: 100, t: 12 },
		{ e: 'kill', q: 100, oi: 1, npc: 1001, t: 10 },
		{ ...progress(100), t: 20 },
		{ e: 'kill', q: 100, oi: 1, npc: 1002, t: 20 },
		{ e: 'abandon', q: 100, t: 21 },
	]);
	assert.deepEqual(goals.map((g) => g.verb), ['kill', 'turnin', 'note']);
	assert.match(text, /kill 1001 x8 quest 100\.1/);
	assert.doesNotMatch(text, /1002/);
});

test('draft drops a delayed abandoned kill clamped to the next chunk boundary by the recorder', () => {
	// Reduced output of the real Recorder + Rust normalizer: death at 298.8,
	// removal at 299, abandon at 300, then Finds' delayed callback in chunk 2.
	// RecAt clamps the earlier death to that chunk's start (300), tying abandon.
	const abandon = chunkBoundary.events.findIndex((ev) => ev.e === 'abandon');
	const oldKill = chunkBoundary.events.findIndex((ev) => ev.e === 'kill');
	assert.ok(oldKill > abandon);
	assert.equal(chunkBoundary.events[oldKill].t, chunkBoundary.events[abandon].t);
	const { text } = draftGuide(chunkBoundary);
	const diag = new Diagnostics();
	const guide = parseGuide(text, 'draft.guide', diag);
	assert.deepEqual(diag.list, []);
	assert.deepEqual(guide.steps.flatMap((step) => step.goals).map((g) => g.verb), ['accept', 'kill', 'turnin']);
	assert.match(text, /kill 1002 x8 quest 100\.1/);
	assert.doesNotMatch(text, /1001/);
});

for (const [type, event, target] of [['monster', 'kill', 'npc'], ['item', 'loot', 'item']]) {
	test(`draft keeps abandoned ${type} work closed without any earlier recorded work`, () => {
		const { text, goals } = draft([
			{ e: 'abandon', q: 100, t: 10 },
			{ ...progress(100, type), t: 10, x: 20, y: 20 },
			{ e: event, q: 100, oi: 1, [target]: 1001, t: 10 },
			{ e: 'accept', q: 100, t: 20 },
			{ ...progress(100, type), t: 20, x: 60, y: 60 },
			{ e: event, q: 100, oi: 1, [target]: 1002, t: 20 },
			{ e: 'turnin', q: 100, t: 30 },
		]);
		const verb = type === 'monster' ? 'kill' : 'collect';
		assert.deepEqual(goals.map((g) => g.verb), ['accept', verb, 'turnin', 'note']);
		assert.match(text, new RegExp(`${verb} 1002 x8 quest 100\\.1 @60\\.0,60\\.0`));
		assert.doesNotMatch(text, /1001/);
	});
}

test('draft preserves completed progress when a later abandonment makes a tied target ambiguous', () => {
	const { text, goals } = draft([
		{ ...progress(100), t: 10, x: 20, y: 20 },
		{ e: 'turnin', q: 100, t: 11 },
		{ e: 'accept', q: 100, t: 12 },
		{ e: 'abandon', q: 100, t: 13 },
		// The original death time is lost: this could belong to either attempt.
		{ e: 'kill', q: 100, oi: 1, npc: 1001, t: 13 },
	]);
	assert.deepEqual(goals.map((g) => g.verb), ['kill', 'turnin', 'note']);
	assert.match(text, /kill "Recorded objective" x8 quest 100\.1 @20\.0,20\.0/);
	assert.doesNotMatch(text, /1001/);
});

test('draft keeps work after an explicit reaccept at the same timestamp as abandonment', () => {
	const { text, goals } = draft([
		{ e: 'abandon', q: 100, t: 10 },
		{ e: 'accept', q: 100, t: 10 },
		{ ...progress(100), t: 10 },
		{ e: 'kill', q: 100, oi: 1, npc: 1002, t: 10 },
		{ e: 'turnin', q: 100, t: 20 },
	]);
	assert.deepEqual(goals.map((g) => g.verb), ['accept', 'kill', 'turnin', 'note']);
	assert.match(text, /kill 1002 x8 quest 100\.1/);
});
