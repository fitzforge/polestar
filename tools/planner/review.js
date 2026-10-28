'use strict';
// Fitz's route review notes (the planner's review mode, commands review_note_*):
// one JSON object per line in data/local/route-feedback/review-notes.jsonl
// (local, never committed), and for each note a dashboard item so agents and
// Fitz see it (data/local/dashboard, when it is there): a needs-you entry
// `feedback-route-<id>` in needs-you.json (the dashboard shows feedback-*
// entries as feedback) and Fitz's comment on its thread
// `needs-manual:feedback-route-<id>` (`node note.js inbox` lists it).
//
// A note: { id, at, start, character, guides (the --guides tree), screen
// { i, kind, name, visit, of }, step (1-based, as the steps list), file, line,
// target { kind: 'mark' | 'stop' | 'path' | 'spot', quest, npc, label }, point
// { c, wx, wy, map, x, y }, text }.

const fs = require('node:fs');
const path = require('node:path');
const crypto = require('node:crypto');
const { ROOT } = require('../lib/paths');
const { raceLabel, classLabel } = require('../lib/game/races');

const NOTES_FILE = path.join(ROOT, 'data', 'local', 'route-feedback', 'review-notes.jsonl');
const DASHBOARD = path.join(ROOT, 'data', 'local', 'dashboard');

function writeAtomic(file, text) {
	fs.mkdirSync(path.dirname(file), { recursive: true });
	const tmp = `${file}.${process.pid}.tmp`;
	fs.writeFileSync(tmp, text);
	fs.renameSync(tmp, file);
}

function readNotes(file = NOTES_FILE) {
	let text;
	try {
		text = fs.readFileSync(file, 'utf8');
	} catch (e) {
		if (e.code === 'ENOENT') return [];
		throw e;
	}
	const out = [];
	for (const line of text.split('\n')) {
		if (!line.trim()) continue;
		try {
			out.push(JSON.parse(line));
		} catch {
			// a torn line: skipped
		}
	}
	return out;
}

// The dashboard's needs-you list and comment threads, or null without a dashboard.
function dashboard(dir = DASHBOARD) {
	const lib = path.join(dir, 'lib', 'comments.js');
	if (!fs.existsSync(lib)) return null;
	return { comments: require(lib), needsFile: path.join(dir, 'needs-you.json') };
}

const keyOf = (id) => `feedback-route-${id}`;

function summary(n) {
	const who = `${raceLabel(n.character.race)} ${classLabel(n.character.cls)}`;
	const where = n.screen ? `${n.screen.name}${n.screen.kind === 'hub' ? ` visit ${n.screen.visit} of ${n.screen.of}` : ' (out)'}` : `step ${n.step}`;
	return { who, where };
}

function dashboardAdd(n, { dir, url }) {
	const d = dashboard(dir);
	if (!d) return false;
	const { who, where } = summary(n);
	const target = n.target && n.target.label ? ` (${n.target.label})` : '';
	const source = n.file ? `${n.file}:${n.line}` : `step ${n.step}`;
	const item = {
		id: keyOf(n.id),
		what: `Route review, ${who}, ${where}${target}: ${n.text}`,
		why: `Fitz's note in the planner's review mode at step ${n.step} (${source}).`,
		how: `Check the route there and fix the guide or the route writer; the note is ${n.id} in data/local/route-feedback/review-notes.jsonl.`,
		risk: null,
		links: url ? [{ label: 'Open in the planner', url }] : [],
	};
	const list = fs.existsSync(d.needsFile) ? JSON.parse(fs.readFileSync(d.needsFile, 'utf8')) : [];
	writeAtomic(d.needsFile, `${JSON.stringify([...list.filter((x) => x.id !== item.id), item], null, 1)}\n`);
	d.comments.add(`needs-manual:${item.id}`, { from: d.comments.FITZ, text: `${n.text}\n\n${who}, ${where}${target}, step ${n.step}, ${source}.` });
	return true;
}

function dashboardRemove(id, dir) {
	const d = dashboard(dir);
	if (!d) return;
	const key = keyOf(id);
	if (fs.existsSync(d.needsFile)) {
		const list = JSON.parse(fs.readFileSync(d.needsFile, 'utf8'));
		if (list.some((x) => x.id === key)) writeAtomic(d.needsFile, `${JSON.stringify(list.filter((x) => x.id !== key), null, 1)}\n`);
	}
	fs.rmSync(path.join(d.comments.DIR, `needs-manual:${key}.jsonl`), { force: true });
}

// note: the fields above but id and at. opts: { file, dashboardDir, url } -> the note.
function addNote(note, opts = {}) {
	const text = String(note.text || '').trim();
	if (!text) throw new Error('the note is empty');
	const n = { id: `${Date.now().toString(36)}-${crypto.randomBytes(3).toString('hex')}`, at: new Date().toISOString(), ...note, text };
	const file = opts.file || NOTES_FILE;
	fs.mkdirSync(path.dirname(file), { recursive: true });
	fs.appendFileSync(file, `${JSON.stringify(n)}\n`);
	n.dashboard = dashboardAdd(n, { dir: opts.dashboardDir, url: opts.url });
	return n;
}

// -> whether the note was there (its dashboard item goes too).
function deleteNote(id, opts = {}) {
	const file = opts.file || NOTES_FILE;
	const list = readNotes(file);
	const kept = list.filter((n) => n.id !== id);
	if (kept.length !== list.length) writeAtomic(file, kept.map((n) => JSON.stringify(n)).join('\n') + (kept.length ? '\n' : ''));
	dashboardRemove(id, opts.dashboardDir);
	return kept.length !== list.length;
}

module.exports = { addNote, deleteNote, readNotes, NOTES_FILE, DASHBOARD };
