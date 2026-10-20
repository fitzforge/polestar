'use strict';
// sim elites (tools/lib/sim/elites.js): chains as lint checks them, where a
// chain goes in the guides, merged steps, and the lint gate on --apply.

const test = require('node:test');
const assert = require('node:assert/strict');
const fs = require('node:fs');
const os = require('node:os');
const path = require('node:path');
const { chainAt, mergeSteps, stepEnd, applyDrafts, applyChecked, place, predecessors } = require('../tools/lib/sim/elites');
const { applicable } = require('../tools/lib/dsl/conditions');

// A tiny data store: quests by id, NPC 1 at Durotar 50,50 and NPC 2 at 60,60.
function store(quests) {
	const byId = new Map(quests.map((q) => [q.id, { title: `Quest ${q.id}`, start: { npc: [1] }, end: { npc: [1] }, level: 10, ...q }]));
	const spawn = { 1: { map: 1411, pts: [[50, 50]] }, 2: { map: 1411, pts: [[60, 60]] } };
	return {
		quest: (id) => byId.get(id) || null,
		questObjectives: (id) => [...(byId.get(id).kill ? [{ kind: 'kill', id: byId.get(id).kill, index: 1 }] : []), ...(byId.get(id).event ? [{ kind: 'event', index: 2 }] : [])],
		spawns: (kind, id) => (kind === 'npc' && spawn[id] ? [spawn[id]] : []),
		npc: (id) => (id === 9 ? { name: 'Big Ogre', rank: 1, faction: 0 } : { name: 'Boar', rank: 0, faction: 0 }),
		item: () => null,
	};
}
const horde = applicable([{ factions: ['Horde'] }]);
const none = { has: () => false };

test('chainAt: prerequisites first, one of an any-of group, nothing already done', () => {
	const data = store([{ id: 10 }, { id: 11 }, { id: 12 }, { id: 20, preAll: [10], preAny: [11, 12] }]);
	assert.deepEqual(chainAt(data, 20, { done: new Set(), later: none, set: horde }), { chain: [10, 11, 20] });
	assert.deepEqual(chainAt(data, 20, { done: new Set([10, 12]), later: none, set: horde }), { chain: [20] });
});

test('chainAt: a prerequisite the guides turn in elsewhere, or a quest for other races, is no chain here', () => {
	const data = store([{ id: 10 }, { id: 20, preAll: [10] }, { id: 30, races: 1, source: ['questie'] }]);
	assert.match(chainAt(data, 20, { done: new Set(), later: new Set([10]), set: horde }).why, /needs 10/);
	assert.match(chainAt(data, 30, { done: new Set(), later: none, set: horde }).why, /not for every character/);
});

test('mergeSteps: steps at one NPC become one, every step `when group` the elite quest', () => {
	const lines = mergeSteps([
		{ who: 'npc:1', title: 'A', lines: ['  turnin 10'] },
		{ who: 'npc:1', title: 'B', lines: ['  accept 11'] },
		{ who: null, title: 'B', lines: ['  kill 5 quest 11.1'] },
	], 11);
	assert.deepEqual(lines, ['step A', '  when group 11', '  turnin 10', '  accept 11', '', 'step B', '  when group 11', '  kill 5 quest 11.1', '']);
});

test('place: the first step that visits the giver with every prerequisite turned in before it', () => {
	const data = store([{ id: 10 }, { id: 20, preAll: [10], kill: 9 }]);
	const goals = (...g) => g.map(([t, quest, npc]) => ({ t, quest, npc }));
	const g = {
		id: 'h/one',
		category: 'Leveling',
		faction: 'Horde',
		minLevel: 8,
		maxLevel: 12,
		_ast: { file: 'guides/one.guide' },
		steps: [
			{ title: 'Early', _line: 3, goals: goals(['accept', 10, 1]) },
			{ title: 'Later', _line: 7, goals: goals(['turnin', 10, 1]) },
		],
	};
	const d = place({ guides: [g], data, faction: 'Horde', q: { id: 20, seconds: 600 }, ancestorsOf: predecessors([g]), turnedInAnywhere: new Set([10]) });
	assert.equal(d.stepTitle, 'Later');
	assert.deepEqual(d.chain, [20]);
	assert.deepEqual(d.lines, ['step Quest 20', '  when group 20', '  accept 20', '', 'step Quest 20', '  when group 20', '  tip Big Ogre is elite: grouping up is advised.', '  kill 9 quest 20.1', '', 'step Quest 20', '  when group 20', '  turnin 20', '']);
});

test('place: a chain with an objective no goal can be written for is left out', () => {
	const data = store([{ id: 20, kill: 9, event: true }]);
	const g = { id: 'h/one', category: 'Leveling', faction: 'Horde', minLevel: 8, maxLevel: 12, _ast: { file: 'g' }, steps: [{ title: 'S', _line: 3, goals: [{ t: 'accept', quest: 5, npc: 1 }] }] };
	const d = place({ guides: [g], data, faction: 'Horde', q: { id: 20, seconds: 600 }, ancestorsOf: predecessors([g]), turnedInAnywhere: new Set() });
	assert.match(d.why, /20 has an objective of kind event/);
});

test('applyDrafts: blocks after their step, with the lines each holds', () => {
	const dir = fs.mkdtempSync(path.join(os.tmpdir(), 'elites-'));
	try {
		fs.writeFileSync(path.join(dir, 'a.guide'), 'guide x\n\nstep One\n  accept 1\n\nstep Two\n  turnin 1\n');
		assert.equal(stepEnd(fs.readFileSync(path.join(dir, 'a.guide'), 'utf8').split('\n'), 3), 4);
		const draft = (id, after) => ({ id, title: `Q${id}`, seconds: 600, file: 'a.guide', after, chain: [id], steps: (c) => [`step Q${c[0]}`, `  when group ${c[0]}`, `  accept ${c[0]}`, ''] });
		const blocks = applyDrafts([draft(7, 6), draft(8, 3), { ...draft(9, 3), chain: [8] }], dir);
		const lines = fs.readFileSync(path.join(dir, 'a.guide'), 'utf8').split('\n');
		assert.deepEqual(blocks.map((b) => b.id), [8, 7]);
		for (const b of blocks) assert.match(lines.slice(b.from - 1, b.to).join('\n'), new RegExp(`accept ${b.id}`));
		assert.equal(lines.filter((l) => l === '  accept 8').length, 1);
	} finally {
		fs.rmSync(dir, { recursive: true, force: true });
	}
});

test('applyChecked: a block lint reports in is taken out again', () => {
	const dir = fs.mkdtempSync(path.join(os.tmpdir(), 'elites-'));
	try {
		const file = path.join(dir, 'a.guide');
		fs.writeFileSync(file, 'guide x\n\nstep One\n  accept 1\n');
		const draft = (id) => ({ id, title: `Q${id}`, seconds: 600, file: 'a.guide', after: 3, chain: [id], steps: (c) => [`step Q${c[0]}`, `  when group ${c[0]}`, `  accept ${c[0]}`, ''] });
		// A fake lint: an error on every `accept 8` line.
		const lint = () =>
			fs
				.readFileSync(file, 'utf8')
				.split('\n')
				.flatMap((l, i) => (l === '  accept 8' ? [{ file: 'a.guide', line: i + 1, severity: 'error', message: 'bad' }] : []));
		const r = applyChecked([draft(7), draft(8)], dir, lint);
		assert.deepEqual(r.dropped, [{ id: 8, why: 'lint: bad' }]);
		const text = fs.readFileSync(file, 'utf8');
		assert.match(text, /accept 7/);
		assert.doesNotMatch(text, /accept 8/);
	} finally {
		fs.rmSync(dir, { recursive: true, force: true });
	}
});
