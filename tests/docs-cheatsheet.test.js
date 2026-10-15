'use strict';
// docs/GUIDE_CHEATSHEET.md keeps up with the compiler: it names every header
// key, step line, goal verb, modifier and condition the parser accepts, and
// every example in its tables lints clean against the fixture data.

const { test } = require('node:test');
const assert = require('node:assert/strict');
const fs = require('node:fs');
const path = require('node:path');
const { VERBS, MOD_WORDS, HEADER_KEYS, STEP_KEYS } = require('../tools/lib/dsl/parse');
const { FACTIONS } = require('../tools/lib/dsl/conditions');
const { CLASSES, RACES } = require('../tools/lib/game/races');
const { compile } = require('./helpers/dsl');

const DOC = fs.readFileSync(path.join(__dirname, '..', 'docs', 'GUIDE_CHEATSHEET.md'), 'utf8');
const spans = (text) => [...text.matchAll(/`([^`]+)`/g)].map((m) => m[1]);
// Every code span of the page, as written.
const SPANS = spans(DOC);
// The code spans of each table row's first cell: the lines the page documents.
// A row taken out takes its words with it, even when the prose still names them.
const LINES = [];
{
	let first = true;
	for (const line of DOC.split('\n')) {
		if (!line.startsWith('|')) {
			first = true;
			continue;
		}
		const cell = line.split('|')[1].trim();
		if (!first && !/^-+$/.test(cell)) LINES.push(...spans(cell));
		first = false;
	}
}
// A name counts when a row's line starts with it as a word: `kill`, `kill <npc>`.
const named = (name) => LINES.some((s) => s.toLowerCase() === name || s.toLowerCase().startsWith(`${name} `));

// The tables' rows: { header (a "Header line" table), example (the last cell's code) }.
function examples() {
	const out = [];
	let header = null;
	for (const line of DOC.split('\n')) {
		if (!line.startsWith('|')) {
			header = null;
			continue;
		}
		const cells = line.split('|').slice(1, -1).map((c) => c.trim());
		if (header === null) {
			header = cells[0] === 'Header line';
			continue;
		}
		if (/^-+$/.test(cells[0])) continue;
		const code = /^`(.+)`$/.exec(cells[cells.length - 1]);
		assert.ok(code, `example cell is one code span: ${line}`);
		out.push({ header, example: code[1] });
	}
	return out;
}

test('the cheat sheet names every header key, step line, verb and modifier', () => {
	const words = ['step', ...HEADER_KEYS, ...STEP_KEYS, ...VERBS, ...MOD_WORDS];
	assert.ok(VERBS.length >= 20 && HEADER_KEYS.length >= 10 && MOD_WORDS.length >= 10);
	assert.deepEqual(words.filter((w) => !named(w)), []);
	for (const form of ['@<x>,<y>', 'x<N>', '"<text>"', '# <text>', '<goal> -- <text>']) assert.ok(LINES.includes(form), form);
});

test('the cheat sheet names every class, race and faction', () => {
	const names = [...Object.keys(CLASSES), ...Object.keys(RACES), ...Object.keys(FACTIONS)];
	const lower = new Set(SPANS.map((s) => s.toLowerCase()));
	assert.deepEqual(names.filter((n) => !lower.has(n)), []);
	assert.ok(SPANS.includes('!<Class>'));
});

// Guides a `next` example may name.
const follower = (id, title) =>
	[`guide joe-routes/${id}`, `title ${title}`, 'faction Alliance', 'levels 10-20', 'zone Elwynn Forest', `pitch ${title}.`, '', 'step Start', '  note Go on.', ''].join('\n');
const FOLLOWERS = { 'westfall.guide': follower('westfall', 'Westfall'), 'redridge.guide': follower('redridge', 'Redridge') };
const BASE = ['guide joe-routes/sheet', 'title Sheet', 'faction Alliance', 'levels 1-10', 'zone Elwynn Forest'];

test('every header example lints clean in a guide of its own', () => {
	const list = examples().filter((e) => e.header).map((e) => e.example);
	assert.ok(list.length >= HEADER_KEYS.length);
	for (const ex of list) {
		const key = ex.split(' ')[0];
		const header = BASE.filter((l) => l.split(' ')[0] !== key);
		if (key === 'guide') header.unshift(ex);
		else header.push(ex);
		const r = compile({ 'sheet.guide': [...header, '', 'step Start', '  goto 42.9,65.6 "Goldshire"', ''].join('\n'), ...FOLLOWERS });
		assert.equal(r.text, '', `${ex}\n${r.text}`);
	}
});

// One step per example; the examples are bits of different routes, so a last
// step hands in the quests they take and never hand in.
test('the step examples, in page order, make a guide that lints clean', () => {
	const list = examples().filter((e) => !e.header).map((e) => e.example);
	assert.ok(list.length >= VERBS.length);
	const lines = [...BASE, ''];
	list.forEach((ex, i) => {
		const word = ex.split(' ')[0].toLowerCase();
		if (word === 'step') lines.push(ex, '  note Example', '');
		else if (word === 'loop') lines.push(`step Example ${i + 1}`, `  ${ex}`, '  goto 47.6,35.1', '  goto 52.3,26.8', '  kill 6 x10', ''); // a loop needs points and a goal
		else lines.push(`step Example ${i + 1}`, `  ${ex}`, ...(VERBS.includes(word) ? [] : ['  note Example']), '');
	});
	const taken = list.map((ex) => /^accept (\d+)/.exec(ex)).filter(Boolean).map((m) => m[1]);
	const handedIn = new Set(list.map((ex) => /^turnin (\d+)/.exec(ex)).filter(Boolean).map((m) => m[1]));
	const open = taken.filter((q) => !handedIn.has(q));
	if (open.length) lines.push('step Hand in', ...open.map((q) => `  turnin ${q}`), '');
	const text = lines.join('\n');
	const r = compile({ 'sheet.guide': text });
	assert.equal(r.text, '', `${r.text}\n\n${text}`);
});
