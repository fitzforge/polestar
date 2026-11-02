'use strict';
// The planner's hub view (tools/planner/hubview.js, command hub_view): the
// quest marks at a step and the walk's problems in a hub, on Northshire's
// fixture NPCs (Deputy Willem, Marshal McBride and Eagan Peltskinner stand
// within a hub's 120 yd; the kobold camp is far north).

const test = require('node:test');
const assert = require('node:assert');
const path = require('node:path');
const { compile, fixtureData, guideText } = require('./helpers/dsl');
const { buildTimeline, loadParams } = require('../tools/lib/planner/timeline');
const { Geo } = require('../tools/lib/planner/geo');
const fs = require('node:fs');
const { tmpdir } = require('./helpers/tmp');
const { hubView, screensOf, screenView, screenProblems } = require('../tools/planner/hubview');
const { addNote, deleteNote, readNotes } = require('../tools/planner/review');

const PARAMS = loadParams({ simDir: path.join(__dirname, 'no-such-sim-dir'), cls: 'WARRIOR' });
const HUMAN = { race: 'Human', cls: 'WARRIOR', faction: 'Alliance' };
const NO_HUBS = path.join(__dirname, 'no-such-hubs.json');

function setup(lines) {
	const { guides, errors } = compile(guideText(lines));
	assert.deepStrictEqual(errors, []);
	const data = fixtureData();
	const geo = new Geo(data.mapFrames, data.zones);
	const tl = buildTimeline({ guides: new Map(guides.map((g) => [g.id, g])), data, geo, params: PARAMS, travel: {}, questXp: null, start: 't/main', character: HUMAN });
	const ws = { data, geo };
	return { tl, ws, view: (step) => hubView(ws, tl, HUMAN, step, { hubsFile: NO_HUBS }) };
}

const ROUTE = [
	'step Willem',
	'  accept 783',
	'step McBride',
	'  turnin 783',
	'  accept 7',
	'step Kobolds',
	'  kill 6 x10 quest 7.1',
	'step Back',
	'  turnin 7',
	'step Away',
	'  goto 47.6,31.2 "Kobold camp"',
	'step Eagan',
	'  accept 33',
];

test('marks: yellow ! takeable now, ? in the log with its work done or not, nothing taken or done', () => {
	const { view } = setup(ROUTE);
	const first = view(0);
	const willem = first.marks.find((m) => m.id === 823);
	assert.ok(willem, 'Deputy Willem has a mark');
	assert.strictEqual(willem.mark, '!');
	assert.strictEqual(willem.tone, 'ready');
	assert.ok(willem.quests.some((q) => q.id === 783 && q.route === 'here'));
	// Veteran Business (9300, level 20) is too far away for even a grey mark.
	assert.ok(!willem.quests.some((q) => q.id === 9300));
	// Kobold Camp Cleanup (7) waits on A Threat Within (783): a faint ! "after" it at McBride, never a problem.
	const mcbride0 = first.marks.find((m) => m.id === 197);
	const locked = mcbride0.quests.find((q) => q.id === 7);
	assert.deepStrictEqual([locked.mark, locked.tone, locked.after], ['!', 'locked', 'A Threat Within']);
	assert.match(mcbride0.tip, /Kobold Camp Cleanup \(after A Threat Within\)/);
	assert.ok(!first.walkedPast.concat(first.leftReady).some((w) => w.quest === 7));
	// At McBride, 783 is in the log with no work: a yellow ? there.
	const at = view(1);
	const mcbride = at.marks.find((m) => m.id === 197);
	assert.strictEqual(mcbride.mark, '?');
	assert.strictEqual(mcbride.tone, 'ready');
	// Back from the camp: 7 is ready, 783 done (no mark for it anywhere).
	const back = view(3);
	const ready = back.marks.find((m) => m.id === 197).quests.find((q) => q.id === 7);
	assert.deepStrictEqual([ready.mark, ready.tone], ['?', 'ready']);
	assert.ok(!back.marks.some((m) => m.quests.some((q) => q.id === 783)));
	assert.ok(back.counts.ready['!'] >= 1 && back.counts.ready['?'] >= 1);
});

test('a hub: its visits, our numbered stops and the walk through it', () => {
	const { view } = setup(ROUTE);
	const v = view(3);
	assert.ok(v.hub);
	assert.strictEqual(v.hub.visits.length, 3);
	assert.strictEqual(v.hub.visit, 2);
	assert.deepStrictEqual(v.hub.visits.map((x) => [x.s0, x.s1]), [[0, 1], [3, 3], [5, 5]]);
	assert.deepStrictEqual(v.stops.map((s) => s.step), [3]);
	assert.ok(v.path.length > 0 && v.path.every((r) => r.pts.length >= 4));
	const first = view(1);
	assert.deepStrictEqual(first.stops.map((s) => s.n), [1, 2]);
});

test('walked past and left ready: a ready ! passed on the walk back, done after leaving 200 yd', () => {
	const { view } = setup(ROUTE);
	const v = view(3);
	const past = v.walkedPast.find((w) => w.quest === 33);
	assert.ok(past, `Eagan's 33 walked past: ${JSON.stringify(v.walkedPast)}`);
	assert.strictEqual(past.mark, '!');
	assert.ok(past.yd <= 50);
	assert.strictEqual(past.doneStep, 5);
	const left = v.leftReady.find((w) => w.quest === 33);
	assert.ok(left, 'left ready at the visit end');
	assert.ok(v.marks.find((m) => m.id === 196).flags.includes('walked'));
	// The last visit takes it: nothing left behind there.
	assert.deepStrictEqual(view(5).leftReady.filter((w) => w.quest === 33), []);
});

test('the ideal loop keeps each quest in order and never walks more than ours', () => {
	const { view } = setup([
		'step Willem',
		'  accept 783',
		'step Eagan',
		'  accept 33',
		'step McBride',
		'  turnin 783',
		'  accept 7',
	]);
	const v = view(0);
	assert.ok(v.loop);
	assert.ok(v.loop.yards <= v.loop.ours + 1e-6);
	const labels = v.loop.stops.map((s) => s.label);
	assert.ok(labels.indexOf('Accept A Threat Within') < labels.findIndex((l) => l.startsWith('Turn in A Threat Within')));
});

test('review screens: a visit per town (the kobolds stay within 200 yd of Eagan: one visit), the field work between as "out", stops in plain parts', () => {
	const { tl, ws } = setup(ROUTE);
	const screens = screensOf(ws, tl, { hubsFile: NO_HUBS });
	assert.deepStrictEqual(screens.map((s) => [s.kind, s.s0, s.s1]), [['hub', 0, 3], ['out', 4, 4], ['hub', 5, 5]]);
	assert.deepStrictEqual(screens.filter((s) => s.kind === 'hub').map((s) => [s.n, s.of]), [[1, 2], [2, 2]]);
	const v = screenView(ws, tl, HUMAN, 0, { hubsFile: NO_HUBS });
	assert.deepStrictEqual(v.stops.map((s) => s.npc && s.npc.name), ['Deputy Willem', 'Marshal McBride', null, 'Marshal McBride']);
	assert.deepStrictEqual(v.stops[1].items.map((x) => [x.verb, x.quest]), [['turnin', 783], ['accept', 7]]);
	assert.ok(v.stops[1].items.every((x) => x.line > 0));
	const out = screenView(ws, tl, HUMAN, 1, { hubsFile: NO_HUBS });
	assert.deepStrictEqual([out.hub, out.marks.length, out.stops.length], [null, 0, 1]);
	assert.ok(out.path.length > 0);
	const problems = screenProblems(ws, tl, HUMAN, { hubsFile: NO_HUBS });
	assert.strictEqual(problems.length, screens.length);
	assert.deepStrictEqual(problems[1], { walked: 0, left: 0, over: null });
});

test('review notes: one line each in the jsonl, a needs-you feedback item and Fitz\'s comment; delete removes all three', () => {
	const dir = tmpdir();
	const file = `${dir}/notes/review-notes.jsonl`;
	const dash = `${dir}/dashboard`;
	fs.mkdirSync(`${dash}/lib`, { recursive: true });
	fs.copyFileSync(require.resolve('./fixtures/dashboard-comments.js'), `${dash}/lib/comments.js`);
	fs.writeFileSync(`${dash}/needs-you.json`, '[{"id":"keep-me","what":"x"}]\n');
	const n = addNote({ start: 't/main', character: HUMAN, screen: { kind: 'hub', name: 'Northshire', visit: 2, of: 3 }, step: 4, file: 'guides/t.guide', line: 9, target: { kind: 'mark', quest: 33, label: 'Eagan' }, text: 'Take it on the first pass.' }, { file, dashboardDir: dash, url: 'http://x/' });
	assert.deepStrictEqual(readNotes(file).map((x) => [x.id, x.text]), [[n.id, 'Take it on the first pass.']]);
	const needs = JSON.parse(fs.readFileSync(`${dash}/needs-you.json`, 'utf8'));
	assert.deepStrictEqual(needs.map((x) => x.id), ['keep-me', `feedback-route-${n.id}`]);
	assert.match(needs[1].what, /Human Warrior, Northshire visit 2 of 3 \(Eagan\): Take it on the first pass\./);
	const thread = `${dash}/comments/needs-manual:feedback-route-${n.id}.jsonl`;
	assert.strictEqual(JSON.parse(fs.readFileSync(thread, 'utf8')).from, 'Fitz');
	assert.strictEqual(deleteNote(n.id, { file, dashboardDir: dash }), true);
	assert.deepStrictEqual(readNotes(file), []);
	assert.deepStrictEqual(JSON.parse(fs.readFileSync(`${dash}/needs-you.json`, 'utf8')).map((x) => x.id), ['keep-me']);
	assert.ok(!fs.existsSync(thread));
});
