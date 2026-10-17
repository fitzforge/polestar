'use strict';
// The planner's source edits (tools/lib/planner/source.js, goalfmt.js): every
// goal line of guides/ survives fields -> text -> parse, and each edit
// operation writes the minimal, still-parsing change, keeping every goal's zone.

const test = require('node:test');
const assert = require('node:assert/strict');
const fs = require('node:fs');
const path = require('node:path');
const { findGuideFiles, OFFICIAL_DIR } = require('../tools/lib/dsl/project');
const { parseGuide } = require('../tools/lib/dsl/parse');
const { parseConditions } = require('../tools/lib/dsl/conditions');
const { Diagnostics } = require('../tools/lib/dsl/diag');
const { goalFields, formatGoal, formatCoord, verbSchema } = require('../tools/lib/planner/goalfmt');
const { model, apply, EditError } = require('../tools/lib/planner/source');
const { guideText, lineOf } = require('./helpers/dsl');

// A goal's enumerable fields, `only` as parsed, without line/zone.
function comparable(goal) {
	const { line, zone, ...rest } = goal;
	return JSON.parse(JSON.stringify(rest));
}

test('every goal line of guides/ survives fields -> text -> parse', (t) => {
	let lines = 0;
	const failures = [];
	for (const file of findGuideFiles(OFFICIAL_DIR)) {
		const guide = parseGuide(fs.readFileSync(path.join(OFFICIAL_DIR, file), 'utf8'), file, new Diagnostics());
		for (const step of guide.steps) {
			for (const goal of step.goals) {
				lines++;
				const fields = goalFields(goal);
				assert.equal(fields.onlyText === undefined, goal.only === undefined);
				if (goal.only) assert.deepEqual(parseConditions(fields.onlyText.replace(/\s*,\s*/g, ','), 'any').value, goal.only);
				const text = formatGoal(fields);
				const diag = new Diagnostics();
				const back = parseGuide(guideText([`step S`, `  ${text}`]), 'x', diag);
				const again = back && back.steps[0] && back.steps[0].goals[0];
				if (!again || diag.errors.length) failures.push(`${file}:${goal.line}: ${text}: ${diag.errors.map((d) => d.message).join('; ')}`);
				else if (JSON.stringify(comparable(again)) !== JSON.stringify(comparable(goal))) {
					try {
						assert.deepEqual(comparable(again), comparable(goal));
					} catch (e) {
						failures.push(`${file}:${goal.line}: ${text}\n${e.message}`);
					}
				}
			}
		}
	}
	t.diagnostic(`${lines} goal lines round-tripped`);
	assert.ok(lines > 5000, `only ${lines} goal lines`);
	assert.deepEqual(failures.slice(0, 5), []);
});

test('formatGoal writes the canonical forms', () => {
	const f = (text) => {
		const g = parseGuide(guideText(['step S', `  ${text}`]), 'x', new Diagnostics()).steps[0].goals[0];
		return formatGoal(goalFields(g));
	};
	assert.equal(f('accept 7 "A Title"   only Human, Dwarf optional -- from Marshal'), 'accept 7 "A Title" optional only Human,Dwarf -- from Marshal');
	assert.equal(f('turnin 7 money 15000 xp 300 choose 6480 918 "Hide Pack" common'), 'turnin 7 choose 6480 918 "Hide Pack" common xp 300 money 1g50s');
	// #108: the editor must not drop `direct` when it rewrites a turn-in.
	assert.equal(f('turnin 308 optional direct'), 'turnin 308 direct optional');
	assert.equal(f('goto 39.5, 80 r 20'), 'goto 39.5,80.0 r 20');
	assert.equal(f('kill "Wolf" npc 299 x8 @40,50 live'), 'kill "Wolf" @40.0,50.0 live npc 299 x8');
	assert.equal(f('train Mining Expert'), 'train Mining Expert');
	assert.equal(f('skill "First Aid" 150'), 'skill "First Aid" 150');
	assert.equal(f('rep Stormwind Friendly optional'), 'rep Stormwind Friendly optional');
	assert.equal(f('note Wait for the boat'), 'note Wait for the boat');
	assert.equal(f('note "Wait # here" optional'), 'note "Wait # here" optional');
	// A label right after the id would read as the quest's title.
	assert.equal(f('accept 7 optional "Label"'), 'accept 7 optional "Label"');
	assert.throws(() => formatGoal({ verb: 'accept', quest: 7, text: 'Label' }), /reads as its name/);
});

test('formatCoord: one decimal unless that moves the point more than 4 yards', () => {
	assert.equal(formatCoord(39.5, 40), '39.5');
	assert.equal(formatCoord(80, 40), '80.0');
	assert.equal(formatCoord(39.54, 40), '39.5');
	assert.equal(formatCoord(39.45, 100), '39.45');
	assert.equal(formatCoord(39.549, 100), '39.55');
});

test('verbSchema lists each verb with its positional and modifier fields', () => {
	const { verbs } = verbSchema();
	assert.deepEqual(verbs.accept.positional.map((p) => p.key), ['quest', 'title']);
	assert.ok(verbs.kill.modifiers.some((m) => m.key === 'xy' && m.mod === 'at'));
	assert.ok(verbs.goto.positional.some((p) => p.type === 'coords' && p.required));
	assert.ok(!verbs.goto.modifiers.some((m) => m.mod === 'at'));
	assert.ok(verbs.turnin.modifiers.some((m) => m.key === 'rewardMoney'));
	assert.ok(verbs.turnin.modifiers.some((m) => m.key === 'direct' && m.type === 'bool'));
});

const BASE = [
	'# Comment block above A',
	'step A',
	'  accept 7                    -- Marshal McBride',
	'  goto 40.1,50.2 r 10 "Camp"',
	'  kill 6 quest 7 x5 @ 41.0, 52 # wolves',
	'  talk 240',
	'',
	'# ---------------- a separator',
	'',
	'step B',
	'  zone Westfall',
	'  tip West of the farm.',
	'  goto 50.0,50.0',
	'  note Do the thing',
	'',
	'# Lead of C',
	'step C',
	'  goto 60.0,60.0',
	'  turnin 7',
];
const BASE_TEXT = guideText(BASE);
const edit = (op, text = BASE_TEXT) => apply(text, op, 'test.guide');
const lineText = (text, n) => text.split('\n')[n - 1];

test('model: header, steps with their range, directives, zone and goals', () => {
	const m = model(BASE_TEXT, 'test.guide');
	assert.equal(m.ok, true);
	assert.equal(m.coords, 'era');
	assert.equal(m.header.title.value, 'Test');
	assert.deepEqual(m.steps.map((s) => [s.title, s.lead, s.line, s.end]), [
		['A', lineOf(BASE_TEXT, '# Comment block above A'), lineOf(BASE_TEXT, 'step A'), lineOf(BASE_TEXT, 'talk 240')],
		['B', lineOf(BASE_TEXT, 'step B'), lineOf(BASE_TEXT, 'step B'), lineOf(BASE_TEXT, 'note Do the thing')],
		['C', lineOf(BASE_TEXT, '# Lead of C'), lineOf(BASE_TEXT, 'step C'), lineOf(BASE_TEXT, 'turnin 7')],
	]);
	assert.deepEqual(m.steps.map((s) => s.zone && s.zone.name), ['Elwynn Forest', 'Elwynn Forest', 'Westfall']);
	assert.equal(m.steps[1].tip, 'West of the farm.');
	assert.deepEqual(m.steps[1].directives.map((d) => [d.kind, d.value]), [['zone', 'Westfall'], ['tip', 'West of the farm.']]);
	const kill = m.steps[0].goals[2];
	assert.equal(kill.verb, 'kill');
	assert.deepEqual(kill.fields, { verb: 'kill', npc: 6, quest: 7, count: 5, x: 41, y: 52, explicitCoords: true });
	assert.equal(kill.raw.slice(...kill.spans.coords), '@ 41.0, 52');
	assert.equal(kill.raw.slice(...kill.spans.comment), '# wolves');
});

test('setCoords rewrites only the coordinate tokens', () => {
	const goto = lineOf(BASE_TEXT, 'goto 40.1,50.2 r 10 "Camp"');
	let r = edit({ op: 'setCoords', line: goto, x: 42.345, y: 51, yards: 40 });
	assert.equal(lineText(r.text, goto), '  goto 42.3,51.0 r 10 "Camp"');
	assert.deepEqual(r.select, { line: goto });
	// Split `@ x, y` forms are replaced whole; the comment stays.
	const kill = lineOf(BASE_TEXT, 'kill 6 quest 7 x5 @ 41.0, 52 # wolves');
	r = edit({ op: 'setCoords', line: kill, x: 30, y: 31.25, yards: { x: 40, y: 40 } });
	assert.equal(lineText(r.text, kill), '  kill 6 quest 7 x5 @30.0,31.3 # wolves');
	// Added when absent, before an aligned note that keeps its column.
	const accept = lineOf(BASE_TEXT, BASE[2]);
	r = edit({ op: 'setCoords', line: accept, x: 1, y: 2, yards: 40 });
	assert.equal(lineText(r.text, accept), '  accept 7 @1.0,2.0           -- Marshal McBride');
	// Another map; the guide's own frame is not written, the other one is.
	r = edit({ op: 'setCoords', line: accept, x: 1, y: 2, map: 1429, frame: 'era', yards: 40 });
	assert.equal(lineText(r.text, accept), '  accept 7 @1.0,2.0 map 1429  -- Marshal McBride');
	r = edit({ op: 'setCoords', line: goto, x: 1, y: 2, map: 1429, frame: 'live', yards: 40 });
	assert.equal(lineText(r.text, goto), '  goto 1.0,2.0 r 10 "Camp" map 1429 live');
	// `map` goes when the point is back in the goal's zone.
	const moved = r.text;
	r = edit({ op: 'setCoords', line: goto, x: 3, y: 4, map: 1429, zoneMap: 1429, frame: 'era', yards: 40 }, moved);
	assert.equal(lineText(r.text, goto), '  goto 3.0,4.0 r 10 "Camp"');
	// A bare note text would swallow the coordinates: the goal is rewritten.
	const note = lineOf(BASE_TEXT, 'note Do the thing');
	r = edit({ op: 'setCoords', line: note, x: 5, y: 6, yards: 40 });
	assert.equal(lineText(r.text, note), '  note "Do the thing" @5.0,6.0');
	assert.throws(() => edit({ op: 'setCoords', line: lineOf(BASE_TEXT, 'step A'), x: 1, y: 2 }), EditError);
});

test('setRadius adds, replaces and removes `r` on goto/explore only', () => {
	const goto = lineOf(BASE_TEXT, 'goto 40.1,50.2 r 10 "Camp"');
	assert.equal(lineText(edit({ op: 'setRadius', line: goto, r: 25 }).text, goto), '  goto 40.1,50.2 r 25 "Camp"');
	assert.equal(lineText(edit({ op: 'setRadius', line: goto, r: null }).text, goto), '  goto 40.1,50.2 "Camp"');
	const plain = lineOf(BASE_TEXT, 'goto 50.0,50.0');
	assert.equal(lineText(edit({ op: 'setRadius', line: plain, r: 12.5 }).text, plain), '  goto 50.0,50.0 r 12.5');
	assert.throws(() => edit({ op: 'setRadius', line: lineOf(BASE_TEXT, 'talk 240'), r: 5 }), /goto/);
});

test('setGoal rewrites the line, keeping indent, note column and comment', () => {
	const accept = lineOf(BASE_TEXT, BASE[2]);
	let r = edit({ op: 'setGoal', line: accept, fields: { verb: 'accept', quest: 8, title: 'New' } });
	assert.equal(lineText(r.text, accept), '  accept 8 "New"              -- Marshal McBride');
	r = edit({ op: 'setGoal', line: accept, fields: { verb: 'accept', quest: 8, note: null } });
	assert.equal(lineText(r.text, accept), '  accept 8');
	const kill = lineOf(BASE_TEXT, 'kill 6 quest 7 x5 @ 41.0, 52 # wolves');
	r = edit({ op: 'setGoal', line: kill, fields: { verb: 'kill', npc: 6, quest: 7, oi: 1, count: 6, x: 41, y: 52 } });
	assert.equal(lineText(r.text, kill), '  kill 6 @41.0,52.0 quest 7.1 x6 # wolves');
	assert.throws(() => edit({ op: 'setGoal', line: kill, fields: { verb: 'talk', npc: 6, count: 3 } }), /does not parse/);
	assert.throws(() => edit({ op: 'setGoal', line: kill, fields: { verb: 'kill', npc: 6, title: 'x' } }), EditError);
});

test('insertGoal, deleteGoal and moveGoal', () => {
	let r = edit({ op: 'insertGoal', step: 0, index: 1, fields: { verb: 'kill', npc: 9, count: 3, note: 'wolves' } });
	const at = lineOf(BASE_TEXT, BASE[2]) + 1;
	assert.equal(lineText(r.text, at), '  kill 9 x3                   -- wolves');
	assert.deepEqual(r.select, { line: at });
	r = edit({ op: 'insertGoal', step: 2, fields: { verb: 'goto', x: 1, y: 2 } });
	assert.equal(lineText(r.text, lineOf(BASE_TEXT, 'turnin 7') + 1), '  goto 1.0,2.0');

	r = edit({ op: 'deleteGoal', line: lineOf(BASE_TEXT, 'talk 240') });
	assert.ok(!r.text.includes('talk 240'));
	assert.throws(() => edit({ op: 'deleteGoal', line: lineOf(BASE_TEXT, 'step B') }), /not a goal/);
	assert.throws(() => edit({ op: 'deleteGoal', line: 999 }), /no line/);
	// The last goal of a step: the step would have none.
	const one = guideText(['step A', '  talk 240', '', 'step B', '  talk 241']);
	assert.throws(() => edit({ op: 'deleteGoal', line: lineOf(one, 'talk 241') }, one), /step has no goals/);

	r = edit({ op: 'moveGoal', line: lineOf(BASE_TEXT, BASE[2]), step: 2, index: 1 });
	const lines = r.text.split('\n');
	const c = lines.indexOf('step C');
	assert.deepEqual(lines.slice(c + 1, c + 4), ['  goto 60.0,60.0', '  accept 7                    -- Marshal McBride', '  turnin 7']);
	assert.deepEqual(r.select, { line: c + 3 });
	r = edit({ op: 'moveGoal', line: lineOf(BASE_TEXT, BASE[2]), step: 0, index: 3 });
	assert.equal(lineText(r.text, lineOf(BASE_TEXT, 'talk 240')), '  accept 7                    -- Marshal McBride');
});

test('insertStep, deleteStep and moveStep carry leading comments and keep one blank line', () => {
	let r = edit({ op: 'insertStep', index: 1, title: 'New', goals: [{ verb: 'goto', x: 10, y: 20 }] });
	assert.ok(r.text.includes('  talk 240\n\n# ---------------- a separator\n\nstep New\n  goto 10.0,20.0\n\nstep B\n'));
	assert.deepEqual(r.select, { line: lineOf(r.text, 'step New') });
	r = edit({ op: 'insertStep', index: 3, title: 'Last', goals: [{ verb: 'level', level: 5 }] });
	assert.ok(r.text.endsWith('  turnin 7\n\nstep Last\n  level 5\n'));

	r = edit({ op: 'deleteStep', step: 0 });
	assert.ok(r.text.startsWith(`${guideText([]).trimEnd()}\n\n# ---------------- a separator\n\nstep B\n`));
	r = edit({ op: 'deleteStep', step: 2 });
	assert.ok(r.text.endsWith('  note Do the thing\n'), r.text);

	r = edit({ op: 'moveStep', step: 0, index: 2 });
	assert.ok(r.text.endsWith('  turnin 7\n\n# Comment block above A\nstep A\n  zone Elwynn Forest\n  accept 7                    -- Marshal McBride\n  goto 40.1,50.2 r 10 "Camp"\n  kill 6 quest 7 x5 @ 41.0, 52 # wolves\n  talk 240\n'), r.text);
	assert.deepEqual(r.select, { line: lineOf(r.text, 'step A') });
	assert.equal(model(r.text).ok, true);
});

test('moving or deleting a step keeps every goal in its zone', () => {
	// C ran in Westfall from B's `zone` line; moved first, it gets its own.
	let r = edit({ op: 'moveStep', step: 2, index: 0 });
	let m = model(r.text);
	assert.deepEqual(m.steps.map((s) => s.title), ['C', 'A', 'B']);
	assert.deepEqual(m.steps[0].directives.map((d) => d.raw), ['  zone Westfall']);
	// A was in the header's zone; after C it would be in Westfall.
	assert.deepEqual(m.steps[1].directives.map((d) => d.raw), ['  zone Elwynn Forest']);
	assert.ok(r.text.includes('# Lead of C\nstep C\n  zone Westfall\n  goto 60.0,60.0'));
	// Deleting B (which carried the zone) gives C the zone it had.
	r = edit({ op: 'deleteStep', step: 1 });
	m = model(r.text);
	assert.deepEqual(m.steps.map((s) => s.title), ['A', 'C']);
	assert.deepEqual(m.steps[1].directives.map((d) => d.raw), ['  zone Westfall']);
	// Steps without located goals are left alone.
	const t = guideText(['step A', '  hearth "Goldshire"', '', 'step B', '  zone Westfall', '  goto 1.0,2.0']);
	r = edit({ op: 'moveStep', step: 1, index: 0 }, t);
	assert.ok(r.text.endsWith('step B\n  zone Westfall\n  goto 1.0,2.0\n\nstep A\n  hearth "Goldshire"\n'), r.text);
});

test('setStep and setHeader', () => {
	let r = edit({ op: 'setStep', step: 0, title: 'Renamed # here', tip: 'One\nTwo', only: 'Human,Dwarf', zone: 'map 1429' });
	const s = lineOf(BASE_TEXT, 'step A');
	assert.deepEqual(r.text.split('\n').slice(s - 1, s + 5), ['step "Renamed # here"', '  zone map 1429', '  only Human,Dwarf', '  tip One', '  tip Two', '  accept 7                    -- Marshal McBride']);
	r = edit({ op: 'setStep', step: 1, tip: null, title: 'B2' });
	assert.ok(r.text.includes('step B2\n  zone Westfall\n  goto 50.0,50.0'));
	assert.throws(() => edit({ op: 'setStep', step: 0, only: 'Wizard!' }), EditError);

	r = edit({ op: 'setHeader', key: 'title', value: 'Other -- title' });
	assert.equal(lineText(r.text, 2), 'title "Other -- title"');
	assert.equal(model(r.text).header.title.value, 'Other -- title');
	r = edit({ op: 'setHeader', key: 'pitch', value: 'A nice zone' });
	assert.equal(lineText(r.text, 6), 'pitch A nice zone');
	assert.throws(() => edit({ op: 'setHeader', key: 'title', value: null }), /missing required header/);
	assert.throws(() => edit({ op: 'nope' }), /unknown op/);
});

test('CRLF line endings and the final newline survive edits', () => {
	const crlf = BASE_TEXT.replace(/\n/g, '\r\n');
	for (const op of [
		{ op: 'moveStep', step: 2, index: 0 },
		{ op: 'insertGoal', step: 0, index: 0, fields: { verb: 'talk', npc: 5 } },
		{ op: 'setCoords', line: lineOf(BASE_TEXT, 'goto 50.0,50.0'), x: 1, y: 2, yards: 40 },
	]) {
		const r = edit(op, crlf);
		assert.ok(!/[^\r]\n/.test(r.text), `${op.op} wrote a bare LF`);
		assert.ok(r.text.endsWith('\r\n'));
	}
	const bare = BASE_TEXT.replace(/\n$/, '');
	assert.ok(!edit({ op: 'deleteGoal', line: lineOf(BASE_TEXT, 'talk 240') }, bare).text.endsWith('\n'));
});

// Goals as the page's goal editor sends them: the parser's flags stay in the
// fields after the field they describe is cleared or the verb changes.
const FORMS = guideText(['step A', '  kill 6 quest 7 x5 @41.0,52.0', '  accept 7 npc 5', '  skill "First Aid" 150', '  train Mining Apprentice', '  accept 8 -- old']);
const setGoal = (needle, fields) => {
	const line = lineOf(FORMS, needle);
	return lineText(edit({ op: 'setGoal', line, fields }, FORMS).text, line);
};

test('setGoal drops parser flags whose field is gone and trims note and profession', () => {
	assert.equal(setGoal('kill 6 quest 7 x5 @41.0,52.0', { verb: 'kill', npc: 6, quest: 7, count: 5, explicitCoords: true }), '  kill 6 quest 7 x5');
	assert.equal(setGoal('accept 7 npc 5', { verb: 'accept', quest: 7, npcExplicit: true }), '  accept 7');
	assert.equal(setGoal('skill "First Aid" 150', { verb: 'level', level: 150, skillQuoted: true }), '  level 150');
	// A verb without the `npc` modifier writes the id in its place.
	assert.equal(setGoal('accept 7 npc 5', { verb: 'talk', npc: 5, npcExplicit: true }), '  talk 5');
	assert.equal(setGoal('accept 8 -- old', { verb: 'accept', quest: 8, note: 'from Marshal ' }), '  accept 8 -- from Marshal');
	assert.equal(setGoal('train Mining Apprentice', { verb: 'train', profession: 'Mining ', rank: 1 }), '  train Mining Apprentice');
});

test('text with a line break is refused wherever it would be written', () => {
	const goal = lineOf(FORMS, 'accept 8 -- old');
	const refused = [
		{ op: 'setStep', step: 0, only: 'Human\n  kill 6 x10' },
		{ op: 'setStep', step: 0, zone: 'Westfall\n  kill 6 x10' },
		{ op: 'setStep', step: 0, title: 'A\u2028B' },
		{ op: 'setStep', step: 0, tip: 'One\rTwo' },
		{ op: 'setHeader', key: 'title', value: 'T\n  kill 6 x10' },
		{ op: 'setGoal', line: goal, fields: { verb: 'accept', quest: 8, onlyText: 'Human\n  kill 6 x10' } },
		{ op: 'setGoal', line: goal, fields: { verb: 'accept', quest: 8, note: 'a\nb' } },
		{ op: 'setGoal', line: goal, fields: { verb: 'train', profession: 'Mining\r', rank: 1 } },
		{ op: 'insertGoal', step: 0, fields: { verb: 'goto', x: 1, y: 2, text: 'Camp\u2029' } },
		{ op: 'insertStep', index: 0, title: 'X', goals: [{ verb: 'goto', x: 1, y: 2, note: 'a\n  kill 6 x10' }] },
		{ op: 'insertStep', index: 0, title: 'X\nY', goals: [{ verb: 'goto', x: 1, y: 2 }] },
	];
	for (const op of refused) assert.throws(() => edit(op, FORMS), (e) => e instanceof EditError && /line break/.test(e.message), JSON.stringify(op));
});

test('object property names are not verbs or ops', () => {
	for (const verb of ['constructor', '__proto__', 'toString']) {
		assert.throws(() => formatGoal({ verb }), /unknown verb/);
		assert.throws(() => edit({ op: 'insertGoal', step: 0, fields: { verb, optional: true } }, FORMS), (e) => e instanceof EditError && /unknown verb/.test(e.message));
	}
	assert.throws(() => edit({ op: 'constructor' }, FORMS), /unknown op/);
	const diag = new Diagnostics();
	parseGuide(guideText(['step A', '  constructor', '  rep Stormwind constructor']), 't.guide', diag);
	const messages = diag.errors.map((d) => d.message);
	assert.ok(messages.includes('unknown verb "constructor"'), messages.join('; '));
	// `constructor` is no standing: the faction then has none.
	assert.ok(messages.some((m) => m.startsWith('`rep` needs a faction and a standing')), messages.join('; '));
});

test('in every guide of guides/, an edit leaves every line it does not touch byte-identical', (t) => {
	const failures = [];
	let edits = 0;
	// The lines of `after` that differ from `before` other than line `keep` (1-based).
	const touched = (before, after, keep) => {
		const a = before.split('\n');
		const b = after.split('\n');
		if (a.length !== b.length) return [`${a.length} lines became ${b.length}`];
		return a.flatMap((l, i) => (i !== keep - 1 && l !== b[i] ? [`line ${i + 1}`] : []));
	};
	for (const file of findGuideFiles(OFFICIAL_DIR)) {
		const text = fs.readFileSync(path.join(OFFICIAL_DIR, file), 'utf8');
		const m = model(text, file);
		assert.ok(m.ok, file);
		const check = (what, op, keep) => {
			edits++;
			const out = apply(text, op, file).text;
			const bad = keep === null ? (out === text ? [] : ['the text changed']) : touched(text, out, keep);
			if (bad.length) failures.push(`${file}: ${what}: ${bad.slice(0, 3).join(', ')}`);
		};
		for (const step of m.steps) {
			// No-op edits write nothing at all.
			check(`setStep ${step.index} to its own title`, { op: 'setStep', step: step.index, title: step.title }, null);
			for (const goal of step.goals) {
				if (goal.fields.r !== undefined) {
					check(`setRadius ${goal.line} to its own r`, { op: 'setRadius', line: goal.line, r: goal.fields.r }, null);
					check(`setRadius ${goal.line}`, { op: 'setRadius', line: goal.line, r: goal.fields.r + 1 }, goal.line);
				}
				if (goal.fields.x !== undefined && goal.spans && goal.spans.coords) {
					check(`setCoords ${goal.line}`, { op: 'setCoords', line: goal.line, x: (goal.fields.x + 1) % 100, y: goal.fields.y, yards: 40 }, goal.line);
				}
			}
		}
	}
	t.diagnostic(`${edits} edits`);
	assert.ok(edits > 5000, `only ${edits} edits`);
	assert.deepEqual(failures.slice(0, 5), []);
});
