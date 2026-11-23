#!/usr/bin/env node
'use strict';
// The route-integrity gate (#3654, docs/CI.md "Route integrity"): what a pull request that edits leveling guides does
// to the route, against the branch it merges into. The Release data job runs it (tools/ci-route-gate.sh); each
// command here is one of its checks.
//
//   node tools/ci-route-gate.js chain <base dir> <changed list>
//       the leveling guides the change edits and the next 3 of each one's `next` chain, one id a line
//   node tools/ci-route-gate.js removals <base dir> <changed list> [--body-env NAME] [--md FILE]
//       every accept, hand-in, complete, kill and collect the edited guides lose, and where each quest is now (another
//       step or guide of the route, or gone). Exit 1 when a quest leaves the route and the pull request's description
//       (the environment variable NAME) does not name it by its id.
//   node tools/ci-route-gate.js levels <base model json> <head model json> [--md FILE]
//       the level model's level at each guide's end, per race and class, before and after. Exit 1 on a drop over
//       0.3 level at any guide end.
//   node tools/ci-route-gate.js honest <base json> <head json> [--md FILE]
//       playtest --honest's findings (its --format json) the head has and the base does not. Exit 1 on any.

const fs = require('node:fs');
const path = require('node:path');

const DROP = 0.3; // the largest drop in a guide-end level the gate lets through
const CHAIN = 3; // how many guides after an edited one are replayed
const LEVELING = /^guides\/forever\/.+\.guide$/;
const GOAL = /^\s*(accept|turnin|complete|kill|collect)\s+(\d+)(?:\s+quest\s+(\d+(?:\.\d+)?))?/;

const readLines = (file) => fs.readFileSync(file, 'utf8').split('\n').map((l) => l.trim()).filter(Boolean);
const header = (text, key) => (new RegExp(`^${key}\\s+(.+)$`, 'm').exec(text) || [])[1] || null;

// Every leveling guide of a tree: id -> { file, text }.
function guides(root) {
	const out = new Map();
	const walk = (dir) => {
		if (!fs.existsSync(dir)) return;
		for (const e of fs.readdirSync(dir, { withFileTypes: true })) {
			const p = path.join(dir, e.name);
			if (e.isDirectory()) walk(p);
			else if (e.name.endsWith('.guide')) {
				const text = fs.readFileSync(p, 'utf8');
				const id = header(text, 'guide');
				if (id) out.set(id, { file: path.relative(root, p).split(path.sep).join('/'), text });
			}
		}
	};
	walk(path.join(root, 'guides', 'forever'));
	return out;
}

// The leveling guides a change list edits: ids, from the head's file or (deleted) the base's.
function edited(base, changed) {
	const ids = [];
	for (const f of changed.filter((x) => LEVELING.test(x))) {
		const p = fs.existsSync(f) ? f : path.join(base, f);
		if (!fs.existsSync(p)) continue;
		const id = header(fs.readFileSync(p, 'utf8'), 'guide');
		if (id && !ids.includes(id)) ids.push(id);
	}
	return ids;
}

// The edited guides and the next CHAIN of each one's chain on the head, in order, each once.
function chain(base, changed, head = guides('.')) {
	const out = [];
	for (const id of edited(base, changed)) {
		let at = id;
		for (let i = 0; i <= CHAIN && at; i++) {
			if (head.has(at) && !out.includes(at)) out.push(at);
			at = head.has(at) ? header(head.get(at).text, 'next') : null;
		}
	}
	return out;
}

// A guide's goals: [{ key, verb, id, quest, step }] (key: "verb id quest" without the step).
function goals(text) {
	const out = [];
	let step = '';
	for (const line of text.split('\n')) {
		const s = /^step\s+(.+)$/.exec(line);
		if (s) step = s[1].trim();
		const g = GOAL.exec(line);
		if (g) out.push({ key: `${g[1]} ${g[2]}${g[3] ? ` quest ${g[3]}` : ''}`, verb: g[1], id: g[2], quest: g[3] ? g[3].split('.')[0] : ['accept', 'turnin', 'complete'].includes(g[1]) ? g[2] : null, step });
	}
	return out;
}

// What the edited guides lose -> { rows: [{ guide, goal, step, now }], gone: [quest id] }.
function removals(base, changed) {
	const before = guides(base);
	const after = guides('.');
	// Where each quest's accept, hand-in and goals are on the head: quest -> [guide: step].
	const where = new Map();
	for (const [id, g] of after) for (const x of goals(g.text)) if (x.quest) where.set(x.quest, [...(where.get(x.quest) || []), `${id}: ${x.step}`]);
	const rows = [];
	const gone = new Set();
	for (const id of edited(base, changed)) {
		const old = before.has(id) ? goals(before.get(id).text) : [];
		const now = after.has(id) ? goals(after.get(id).text) : [];
		const left = new Map();
		for (const x of now) left.set(x.key, (left.get(x.key) || 0) + 1);
		for (const x of old) {
			if (left.get(x.key)) {
				left.set(x.key, left.get(x.key) - 1);
				continue;
			}
			const places = x.quest ? where.get(x.quest) || [] : [];
			if (x.quest && !places.length) gone.add(x.quest);
			rows.push({ guide: id, goal: x.key, step: x.step, now: places.length ? places.slice(0, 3).join('; ') : x.quest ? 'gone from the route' : 'gone' });
		}
	}
	return { rows, gone: [...gone].sort((a, b) => a - b) };
}

// The model's guide-end levels: "race class guide" -> end level.
function ends(file) {
	const out = new Map();
	for (const run of JSON.parse(fs.readFileSync(file, 'utf8'))) {
		for (const row of run.rows || []) if (row.end != null) out.set(`${run.race} ${run.cls || run.class} ${row.id}`, row.end);
	}
	return out;
}

// Guide ends whose level dropped -> [{ key, before, after, drop }], biggest first.
function levelDrops(baseFile, headFile) {
	const before = ends(baseFile);
	const after = ends(headFile);
	const out = [];
	for (const [k, b] of before) {
		if (!after.has(k)) continue;
		const drop = b - after.get(k);
		if (drop > 1e-9) out.push({ key: k, before: b, after: after.get(k), drop: Math.round(drop * 100) / 100 });
	}
	return out.sort((x, y) => y.drop - x.drop);
}

// playtest --honest --format json ({ findings: [{ rule, severity, guide, step, line, title, reason }] }) -> its failing
// findings as comparable strings: rule, guide, step title and reason, never the step or line number, so an inserted
// step does not make every later finding new. Warnings are left out.
function honestFindings(file) {
	const doc = JSON.parse(fs.readFileSync(file, 'utf8'));
	return (doc.findings || []).filter((f) => f.severity === 'fail').map((f) => [f.rule, f.guide, f.title, f.reason].join(' | ').replace(/\bstep \d+/g, 'step #'));
}

function newHonest(baseFile, headFile) {
	const before = new Map();
	for (const f of honestFindings(baseFile)) before.set(f, (before.get(f) || 0) + 1);
	const out = [];
	for (const f of honestFindings(headFile)) {
		if (before.get(f)) before.set(f, before.get(f) - 1);
		else out.push(f);
	}
	return out;
}

const cell = (s) => String(s).replace(/\|/g, '\\|');

function main(argv) {
	const [cmd, ...rest] = argv;
	const opt = (name) => {
		const i = rest.indexOf(name);
		return i >= 0 ? rest.splice(i, 2)[1] : null;
	};
	const md = opt('--md');
	const bodyEnv = opt('--body-env');
	const write = (lines) => {
		const text = `${lines.join('\n')}\n`;
		if (md) fs.writeFileSync(md, text);
		process.stdout.write(text);
	};
	if (cmd === 'chain' && rest.length === 2) {
		for (const id of chain(rest[0], readLines(rest[1]))) console.log(id);
		return 0;
	}
	if (cmd === 'removals' && rest.length === 2) {
		const { rows, gone } = removals(rest[0], readLines(rest[1]));
		const body = bodyEnv ? process.env[bodyEnv] || '' : null;
		const unnamed = body == null ? [] : gone.filter((q) => !new RegExp(`\\b${q}\\b`).test(body));
		const lines = ['### Removed from the edited guides', ''];
		if (!rows.length) lines.push('Nothing: every accept, hand-in, complete, kill and collect is still there.');
		else lines.push('| guide | removed | its step | the quest now |', '|---|---|---|---|', ...rows.map((r) => `| ${cell(r.guide)} | ${cell(r.goal)} | ${cell(r.step)} | ${cell(r.now)} |`));
		if (unnamed.length) lines.push('', `Quests gone from the route that the description does not name: ${unnamed.join(', ')}. Say for each where its XP and time now come from.`);
		write(lines);
		return unnamed.length ? 1 : 0;
	}
	if (cmd === 'levels' && rest.length === 2) {
		const drops = levelDrops(rest[0], rest[1]);
		const bad = drops.filter((d) => d.drop > DROP);
		const lines = ['### Levels at guide ends (level model)', ''];
		if (!drops.length) lines.push('No guide end is reached at a lower level.');
		else lines.push(`${drops.length} guide end(s) lower, ${bad.length} by more than ${DROP} level:`, '', '| race, class, guide | before | after | drop |', '|---|---|---|---|', ...drops.slice(0, 40).map((d) => `| ${cell(d.key)} | ${d.before} | ${d.after} | ${d.drop}${d.drop > DROP ? ' **over**' : ''} |`));
		write(lines);
		return bad.length ? 1 : 0;
	}
	if (cmd === 'honest' && rest.length === 2) {
		const added = newHonest(rest[0], rest[1]);
		const lines = ['### Honest playtest', '', added.length ? `${added.length} finding(s) the base does not have:` : 'No finding the base does not have.', ...added.slice(0, 60).map((f) => `- ${f}`)];
		write(lines);
		return added.length ? 1 : 0;
	}
	console.error('usage: node tools/ci-route-gate.js chain|removals|levels|honest ... (see the head of this file)');
	return 2;
}

if (require.main === module) process.exitCode = main(process.argv.slice(2));

module.exports = { chain, removals, levelDrops, newHonest, goals, DROP, CHAIN };
