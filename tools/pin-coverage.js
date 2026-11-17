#!/usr/bin/env node
'use strict';
// The pin coverage guard: every fix has a pin, every record still matches something. Fixes were
// pinned one report at a time and records written one step at a time; some never got a test and
// some outlived the step they fixed, and the reports came back on another path. Two lists:
//
// - fixed issues with no pin: every issue closed as completed (GitHub's state reason COMPLETED,
//   without a `resolution:*`, `duplicate`, `invalid` or `wontfix` label) that no test names: not in
//   tests/reported-gate.json (tests, same or uncheckable) and no test file mentions `#N` (node tests,
//   the forge crates' tests and test modules, the judge's seeds);
// - records that match nothing: a data/route-fixes.json, data/guide-fixes.json or data/places.json
//   record whose quests no guide has any more (for a pair, either side): it changes nothing, so a
//   fix it once carried is gone without a failing check.
//
// tests/pin-coverage.json holds the gaps known when the guard came in (each with why); the guard
// fails on any other, and names a known gap that is closed now so its entry goes.
//
//   node tools/pin-coverage.js [--issues FILE] [--offline]
//     --issues FILE  closed issues as `gh issue list --state closed --json number,title,stateReason,labels`
//                    prints them (default: that command, run here)
//     --offline      records only (no issues)
// Exit 0: no new gap; 1: new gaps (listed); 2: could not run.

const fs = require('node:fs');
const path = require('node:path');
const { spawnSync } = require('node:child_process');

const ROOT = path.join(__dirname, '..');
const BASELINE = path.join(ROOT, 'tests', 'pin-coverage.json');
const NOT_FIXES = /^(resolution:|duplicate$|invalid$|wontfix$)/;

const read = (rel) => fs.readFileSync(path.join(ROOT, rel), 'utf8');

function walk(dir, keep, out = []) {
	if (!fs.existsSync(dir)) return out;
	for (const e of fs.readdirSync(dir, { withFileTypes: true })) {
		const p = path.join(dir, e.name);
		if (e.isDirectory()) {
			if (e.name !== 'node_modules' && e.name !== 'target' && e.name !== 'fixtures') walk(p, keep, out);
		} else if (keep(p)) out.push(p);
	}
	return out;
}

// The tracked files under `dirs` (git ls-files), else every file found there (a tree outside git): files a run
// leaves behind (another test's scratch, a build) never count as pins.
function testFiles(root, dirs, keep) {
	const r = spawnSync('git', ['ls-files', '-z', '--', ...dirs], { cwd: root, encoding: 'utf8', maxBuffer: 1 << 26 });
	if (r.status === 0 && r.stdout) return r.stdout.split('\0').filter((f) => f && keep(f)).map((f) => path.join(root, f));
	return dirs.flatMap((d) => walk(path.join(root, d), keep));
}

// The text of every test: node tests, the forge crates' test folders, the test modules of their sources
// (from the first `#[cfg(test)]` on), and the judge's seeds.
function testTexts(root = ROOT) {
	const texts = [];
	const skip = (f) => f.split(/[\\/]/).some((p) => p === 'fixtures' || p === 'target' || p === 'node_modules');
	for (const f of testFiles(root, ['tests'], (f) => f.endsWith('.js') && !skip(f))) texts.push(fs.readFileSync(f, 'utf8'));
	for (const f of testFiles(root, ['rust/crates'], (f) => f.endsWith('.rs') && !skip(f))) {
		const t = fs.readFileSync(f, 'utf8');
		const rel = path.relative(root, f).split(path.sep);
		if (rel.includes('tests') || rel.includes('seed')) texts.push(t);
		else {
			const at = t.indexOf('#[cfg(test)]');
			if (at >= 0) texts.push(t.slice(at));
		}
	}
	return texts.join('\n');
}

// The issues tests/reported-gate.json pins (tests, same or uncheckable) and those a test mentions as #N.
function pinnedIssues(root = ROOT) {
	const gate = JSON.parse(fs.readFileSync(path.join(root, 'tests', 'reported-gate.json'), 'utf8'));
	const pinned = new Set(Object.keys(gate.issues).map(Number));
	for (const m of testTexts(root).matchAll(/#(\d{1,5})\b/g)) pinned.add(Number(m[1]));
	return pinned;
}

// Closed issues -> the fixed ones (completed, no label saying nothing changed), sorted by number.
function fixedIssues(closed) {
	return closed
		.filter((i) => i.stateReason === 'COMPLETED' && !(i.labels || []).some((l) => NOT_FIXES.test(typeof l === 'string' ? l : l.name)))
		.map((i) => ({ number: i.number, title: i.title }))
		.sort((a, b) => a.number - b.number);
}

// Every quest id a guide names: accepts, hand-ins, completes, `quest Q[.O]` and tasks.
function guideQuests(root = ROOT) {
	const out = new Set();
	for (const f of walk(path.join(root, 'guides'), (p) => p.endsWith('.guide'))) {
		for (const m of fs.readFileSync(f, 'utf8').matchAll(/^\s+(?:accept|turnin|complete|abandon|task)\s+(\d+)|\bquest\s+(\d+)/gm)) out.add(Number(m[1] || m[2]));
	}
	return out;
}

// The quests a record names (route-fixes `q`, `a`/`b`/`s` goals; guide-fixes `at.quest`; places `quest`).
const goalQuest = (g) => (Array.isArray(g) && typeof g[1] === 'number' ? g[1] : null);
function recordQuests(r) {
	const out = [];
	if (typeof r.q === 'number') out.push(r.q);
	for (const k of ['a', 'b', 's']) if (goalQuest(r[k]) != null) out.push(goalQuest(r[k]));
	if (r.at && typeof r.at.quest === 'number') out.push(r.at.quest);
	if (typeof r.quest === 'number') out.push(r.quest);
	return out;
}

// A record's key, stable across edits elsewhere in its file: `<file> <section> <what it names>`.
function recordKey(file, section, r) {
	if (r.id) return `${file} ${section} ${r.id}`;
	const parts = ['a', 'b', 's'].filter((k) => Array.isArray(r[k])).map((k) => `${k}=${r[k].slice(0, 2).join(' ')}`);
	if (typeof r.q === 'number') parts.unshift(`q=${r.q}`);
	if (r.faction) parts.push(r.faction);
	return `${file} ${section} ${parts.join(' ')}`;
}

// Records whose quests no guide has any more -> [{ key, quests }].
function deadRecords(root = ROOT) {
	const have = guideQuests(root);
	const out = [];
	const check = (file, section, list) => {
		for (const r of Array.isArray(list) ? list : []) {
			if (!r || typeof r !== 'object') continue;
			const qs = recordQuests(r);
			const gone = qs.filter((q) => !have.has(q));
			if (qs.length && gone.length) out.push({ key: recordKey(file, section, r), quests: gone });
		}
	};
	const rf = JSON.parse(fs.readFileSync(path.join(root, 'data', 'route-fixes.json'), 'utf8'));
	for (const part of ['deliberate', 'overrides']) {
		for (const [section, list] of Object.entries(rf[part] || {})) check('data/route-fixes.json', `${part}.${section}`, list);
	}
	check('data/guide-fixes.json', 'fixes', JSON.parse(fs.readFileSync(path.join(root, 'data', 'guide-fixes.json'), 'utf8')).fixes);
	check('data/places.json', 'places', JSON.parse(fs.readFileSync(path.join(root, 'data', 'places.json'), 'utf8')).places);
	return out.sort((a, b) => (a.key < b.key ? -1 : a.key > b.key ? 1 : 0));
}

function loadBaseline(file = BASELINE) {
	return JSON.parse(fs.readFileSync(file, 'utf8'));
}

// -> { newIssues, closedIssues, newRecords, closedRecords }: gaps the baseline lacks, and baseline
// entries that are no gap any more (pinned now, or the record matches again or is gone).
function compare({ fixed = null, pinned, dead, baseline }) {
	const knownIssues = baseline.issues || {};
	const knownRecords = baseline.records || {};
	const gaps = fixed ? fixed.filter((i) => !pinned.has(i.number)) : [];
	const newIssues = gaps.filter((i) => !(String(i.number) in knownIssues));
	const closedIssues = Object.keys(knownIssues).map(Number).filter((n) => pinned.has(n));
	const deadKeys = new Set(dead.map((d) => d.key));
	const newRecords = dead.filter((d) => !(d.key in knownRecords));
	const closedRecords = Object.keys(knownRecords).filter((k) => !deadKeys.has(k));
	return { newIssues, closedIssues, newRecords, closedRecords };
}

function main(argv) {
	let issuesFile = null;
	let offline = false;
	for (let i = 0; i < argv.length; i++) {
		if (argv[i] === '--issues') issuesFile = argv[++i];
		else if (argv[i] === '--offline') offline = true;
		else {
			console.error(`unknown option ${argv[i]}\nusage: node tools/pin-coverage.js [--issues FILE] [--offline]`);
			return 2;
		}
	}
	let fixed = null;
	if (!offline) {
		let text;
		if (issuesFile) text = fs.readFileSync(issuesFile, 'utf8');
		else {
			const r = spawnSync('gh', ['issue', 'list', '--state', 'closed', '--limit', '10000', '--json', 'number,title,stateReason,labels'], { cwd: ROOT, encoding: 'utf8', maxBuffer: 1 << 28 });
			if (r.status !== 0) {
				console.error(`pin-coverage: gh issue list failed (${(r.stderr || '').trim() || r.error}); --issues FILE or --offline`);
				return 2;
			}
			text = r.stdout;
		}
		fixed = fixedIssues(JSON.parse(text));
	}
	const r = compare({ fixed, pinned: pinnedIssues(), dead: deadRecords(), baseline: loadBaseline() });
	for (const i of r.newIssues) console.log(`unpinned #${i.number} ${i.title}: add its test to tests/reported-gate.json (or, with why, to tests/pin-coverage.json)`);
	for (const d of r.newRecords) console.log(`matches nothing: ${d.key} (no guide has quest ${d.quests.join(', ')}): drop or fix the record`);
	for (const n of r.closedIssues) console.log(`pinned now: #${n}: drop it from tests/pin-coverage.json`);
	for (const k of r.closedRecords) console.log(`matches again or gone: ${k}: drop it from tests/pin-coverage.json`);
	const bad = r.newIssues.length + r.newRecords.length + r.closedIssues.length + r.closedRecords.length;
	console.log(`pin-coverage ${bad ? 'failed' : 'ok'}: ${fixed ? `${fixed.length} fixed issues, ${r.newIssues.length} new unpinned; ` : ''}${r.newRecords.length} new records matching nothing; ${r.closedIssues.length + r.closedRecords.length} known gaps closed`);
	return bad ? 1 : 0;
}

if (require.main === module) process.exit(main(process.argv.slice(2)));

module.exports = { fixedIssues, pinnedIssues, deadRecords, recordQuests, recordKey, compare, loadBaseline, guideQuests };
