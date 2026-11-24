#!/usr/bin/env node
'use strict';
// The reported-problems gate (#2042): every player-reported problem that was fixed stays fixed. In one run it plays
// the tests tests/reported-gate.json names for each confirmed report (node suites and the forge crates' tests), the
// whole of tests/guides-reported.test.js, the judge's player-report seeds on the shipped guides (forge judge
// seed-tests) and the danger-at-the-spot gate (tools/danger-gate.js, #1575), then names the reports whose tests fail.
//
//   npm run test:reported -- --levels <Alliance.json>,<Horde.json> [options]
//   node tools/reported-gate.js [options]
//     --levels FILES   the calibrated level model's output per faction, for the danger gate (as tools/danger-gate.js)
//     --only PARTS     run only these parts, comma-separated: node, seeds, cargo, danger (default all four)
//     --forge BIN      the forge binary the seeds run with (default $FORGE, else rust/target/quick/forge)
//     --threads N      test threads for each cargo run (default 4)
//     --list           print what each part would run, and run nothing
// The data tests need data/forever (forge data build): without it they would skip and pass, so the gate stops.
// A seed that fails only on a guide file the shipped tree doesn't have (the route builder's folder layout, such as
// horde/orc-troll) is listed as not applicable. A seed in the map's seedDrift (the guides-reported case it ports has
// changed since and passes; the seed still asserts the earlier form) is listed as behind, not failed, and one that no
// longer fails is named so its entry can go.
// Exit 0: every part ran and passed; 1: a test failed (the reports it pins are listed); 2: a part could not run.

const fs = require('node:fs');
const path = require('node:path');
const { spawn } = require('node:child_process');
const { parseArgs } = require('./lib/cli');

const ROOT = path.join(__dirname, '..');
const GATE = path.join(ROOT, 'tests', 'reported-gate.json');
const PARTS = ['node', 'seeds', 'cargo', 'danger'];
// Run whole, whatever the map names: every case in it is a reported problem.
const ALWAYS_NODE = ['tests/guides-reported.test.js'];

function loadGate(file = GATE) {
	return JSON.parse(fs.readFileSync(file, 'utf8'));
}

// Every test the map names, as { issue, test } with `test` the map's entry.
function pins(gate) {
	return Object.entries(gate.issues).flatMap(([issue, v]) => (v.tests || []).map((test) => ({ issue: Number(issue), test })));
}

function nodeFiles(gate) {
	return [...new Set([...ALWAYS_NODE, ...pins(gate).filter((p) => p.test.node).map((p) => p.test.node)])].sort();
}

// The cargo runs: one per crate and test target, each with the test names as filters.
function cargoGroups(gate) {
	const groups = new Map();
	for (const { test } of pins(gate)) {
		if (!test.cargo) continue;
		const key = `${test.cargo} ${test.target}`;
		if (!groups.has(key)) groups.set(key, { crate: test.cargo, target: test.target, names: new Set() });
		groups.get(key).names.add(test.test);
	}
	return [...groups.values()].map((g) => ({ ...g, names: [...g.names].sort() }));
}

function cargoArgs(group, threads) {
	const target = group.target === 'lib' ? ['--lib'] : ['--test', group.target];
	return ['test', '--manifest-path', 'rust/Cargo.toml', '--profile', 'quick', '-p', group.crate, ...target, '--', '--test-threads', String(threads), ...group.names];
}

// Whether a test name as it runs matches the map's name, whose `${...}` (node) or `{NAME}` (seed) parts stand for
// whatever the test fills in: the literal pieces appear in the name in order.
function matches(pattern, name) {
	const pieces = pattern.split(/\$\{[^}]*\}|\{[A-Z_][A-Z0-9_]*\}/).filter(Boolean);
	let at = 0;
	for (const piece of pieces) {
		const i = name.indexOf(piece, at);
		if (i < 0) return false;
		at = i + piece.length;
	}
	return true;
}

// The issues whose map entries of a part match a failing test name (a seed's entry is its name).
function issuesFor(gate, kind, name) {
	const hit = (t) => (kind === 'cargo' ? t.test === name : matches(kind === 'seed' ? t.seed : t.test, name));
	return [...new Set(pins(gate).filter((p) => p.test[kind] !== undefined && hit(p.test)).map((p) => p.issue))].sort((a, b) => a - b);
}

// Runs a command with its output shown as it comes and kept. -> { code, out }
function run(cmd, args, env = {}) {
	return new Promise((resolve) => {
		console.log(`\n$ ${[cmd, ...args].map((a) => (/[\s'"$]/.test(a) ? JSON.stringify(a) : a)).join(' ')}`);
		const child = spawn(cmd, args, { cwd: ROOT, env: { ...process.env, ...env }, stdio: ['ignore', 'pipe', 'pipe'] });
		let out = '';
		child.stdout.on('data', (d) => {
			out += d;
			process.stdout.write(d);
		});
		child.stderr.on('data', (d) => {
			out += d;
			process.stderr.write(d);
		});
		child.on('error', (e) => resolve({ code: 127, out: `${out}\n${e.message}` }));
		child.on('close', (code) => resolve({ code: code ?? 1, out }));
	});
}

// node --test's TAP: the names of failing, skipped and todo tests (subtests too). TAP escapes `#` and `\` in a
// name; a ` # ` that is not escaped starts a SKIP or TODO directive.
function readTap(out) {
	const failed = [];
	const skipped = [];
	const todo = [];
	for (const line of out.split('\n')) {
		const m = /^\s*(not ok|ok) \d+ - (.*?)(?: # (SKIP|TODO)\b.*)?$/.exec(line);
		if (!m) continue;
		const name = m[2].replace(/\\([\\#])/g, '$1');
		if (m[3] === 'SKIP') skipped.push(name);
		else if (m[3] === 'TODO') todo.push(name);
		else if (m[1] === 'not ok') failed.push(name);
	}
	return { failed, skipped, todo };
}

// cargo test's lines: `test <path> ... ok|FAILED|ignored`.
function readCargo(out) {
	const ran = new Map();
	for (const line of out.split('\n')) {
		const m = /^test (\S+) \.\.\. (ok|FAILED|ignored)/.exec(line);
		if (m) ran.set(m[1].split('::').pop(), m[2]);
	}
	return ran;
}

// A seed that fails only because a guide it names is not in the shipped tree (the route builder's layout, such as
// horde/orc-troll): its name opens with that guide, or every failure names one.
function notApplicable(t, guidesDir) {
	const gone = (p) => !fs.existsSync(path.join(guidesDir, p));
	const own = /^(forever\/\S+?\.guide):/.exec(t.name);
	if (own && gone(own[1])) return true;
	return t.failures.length > 0 && t.failures.every((f) => (f.match(/forever\/[\w/.-]+?\.guide/g) || []).some(gone));
}

async function main(argv) {
	const { opts, error } = parseArgs(argv, { flags: ['--list'], options: ['--levels', '--only', '--forge', '--threads'] });
	const usage = 'usage: node tools/reported-gate.js [--levels <Alliance.json>,<Horde.json>] [--only node,seeds,cargo,danger] [--forge BIN] [--threads N] [--list]';
	if (opts.help || error) {
		console.error((error ? error + '\n' : '') + usage);
		return opts.help ? 0 : 2;
	}
	const only = opts.only ? opts.only.split(',').map((s) => s.trim()) : PARTS;
	const unknown = only.filter((p) => !PARTS.includes(p));
	if (unknown.length) {
		console.error(`unknown part ${unknown.join(', ')}\n${usage}`);
		return 2;
	}
	const threads = Number(opts.threads || 4);
	const gate = loadGate();
	const forge = path.resolve(opts.forge || process.env.FORGE || path.join(ROOT, 'rust', 'target', 'quick', 'forge'));
	const files = nodeFiles(gate);
	const groups = cargoGroups(gate);
	const counts = Object.values(gate.issues).reduce((c, v) => ((c[v.tests ? 'pinned' : v.uncheckable ? 'uncheckable' : 'same'] += 1), c), { pinned: 0, uncheckable: 0, same: 0 });
	console.log(`reported-problems gate: ${Object.keys(gate.issues).length} reports (${counts.pinned} pinned by tests, ${counts.same} duplicates of another, ${counts.uncheckable} with nothing to check)`);

	if (opts.list) {
		if (only.includes('node')) console.log(`node: node --test ${files.join(' ')}`);
		if (only.includes('seeds')) console.log(`seeds: ${forge} judge seed-tests --guides guides --root .`);
		if (only.includes('cargo')) for (const g of groups) console.log(`cargo: ${g.crate} ${g.target === 'lib' ? 'lib' : `--test ${g.target}`}: ${g.names.length} tests`);
		if (only.includes('danger')) console.log(`danger: node tools/danger-gate.js --levels ${opts.levels || '<Alliance.json>,<Horde.json>'}`);
		return 0;
	}

	if ((only.includes('node') || only.includes('seeds')) && !fs.existsSync(path.join(ROOT, 'data', 'forever', 'quests.json'))) {
		console.error('reported-problems gate: data/forever is missing (forge data build); without it the guide checks skip, so nothing would be checked');
		return 2;
	}
	if (only.includes('danger') && !opts.levels) {
		console.error(`reported-problems gate: the danger gate needs --levels (the calibrated level model's output per faction), or leave it out with --only\n${usage}`);
		return 2;
	}

	const report = [];
	const regressed = new Map();
	const blame = (issues, what) => {
		for (const n of issues) regressed.set(n, [...(regressed.get(n) || []), what]);
	};

	if (only.includes('node')) {
		const { code, out } = await run(process.execPath, ['--test', '--test-concurrency=1', '--test-timeout=900000', '--test-reporter=tap', ...files]);
		const { failed, skipped, todo } = readTap(out);
		const unmapped = [];
		for (const name of failed) {
			const issues = issuesFor(gate, 'node', name);
			if (issues.length) blame(issues, `node: ${name}`);
			else unmapped.push(name);
		}
		// A case marked todo is a known failure waiting for its fix; a release ships with none.
		for (const name of todo) blame(issuesFor(gate, 'node', name), `node (todo): ${name}`);
		const pinnedSkips = skipped.filter((name) => issuesFor(gate, 'node', name).length);
		report.push({ part: 'node', ok: code === 0 && !failed.length && !todo.length, lines: [`${files.length} files, ${failed.length} failing, ${todo.length} todo, ${skipped.length} skipped (${pinnedSkips.length} of them pinning a report)`, ...unmapped.map((n) => `failing, no report in the map: ${n}`), ...todo.map((n) => `todo (a release ships with none): ${n}`), ...pinnedSkips.map((n) => `skipped, pins a report: ${n}`)] });
	}

	if (only.includes('seeds')) {
		if (!fs.existsSync(forge)) {
			report.push({ part: 'seeds', ok: false, broken: true, lines: [`no forge binary at ${forge} (cargo build --profile quick -p forge, or --forge)`] });
		} else {
			const { code, out } = await run(forge, ['judge', 'seed-tests', '--guides', path.join(ROOT, 'guides'), '--root', ROOT, '--json']);
			let tests = null;
			try {
				tests = JSON.parse(out.slice(out.indexOf('{'))).tests;
			} catch {
				report.push({ part: 'seeds', ok: false, broken: true, lines: [`forge judge seed-tests gave no result (exit ${code})`] });
			}
			if (tests) {
				const guidesDir = path.join(ROOT, 'guides');
				const drift = gate.seedDrift || {};
				const na = tests.filter((t) => !t.passed && notApplicable(t, guidesDir));
				const behind = tests.filter((t) => !t.passed && !notApplicable(t, guidesDir) && drift[t.name]);
				const failed = tests.filter((t) => !t.passed && !notApplicable(t, guidesDir) && !drift[t.name]);
				for (const t of failed) {
					const issues = issuesFor(gate, 'seed', t.name);
					if (issues.length) blame(issues, `seed: ${t.name}`);
				}
				// A drift entry whose seed passes now (or is gone) can be dropped.
				const caughtUp = Object.keys(drift).filter((name) => !behind.some((t) => t.name === name));
				report.push({
					part: 'seeds',
					ok: !failed.length,
					lines: [
						`${tests.length} seeds: ${tests.filter((t) => t.passed && !t.skipped).length} pass, ${failed.length} fail, ${behind.length} behind their guides-reported case (seedDrift), ${tests.filter((t) => t.skipped).length} skip, ${na.length} name a guide the shipped tree doesn't have`,
						...failed.map((t) => `failing: ${t.name}: ${t.failures.slice(0, 3).join('; ')}`),
						...behind.map((t) => `behind its guides-reported case: ${t.name}`),
						...caughtUp.map((name) => `in seedDrift but not failing (drop it from tests/reported-gate.json): ${name}`),
						...na.map((t) => `not applicable: ${t.name} (${t.failures[0]})`),
					],
				});
			}
		}
	}

	if (only.includes('cargo')) {
		for (const g of groups) {
			const { code, out } = await run('cargo', cargoArgs(g, threads));
			const ran = readCargo(out);
			const failed = g.names.filter((n) => ran.get(n) === 'FAILED');
			const missing = g.names.filter((n) => !ran.has(n));
			// A name filter also runs the tests whose names contain it.
			const others = [...ran].filter(([n, st]) => st === 'FAILED' && !g.names.includes(n)).map(([n]) => n);
			for (const n of failed) blame(issuesFor(gate, 'cargo', n), `cargo ${g.crate}: ${n}`);
			const label = `${g.crate} ${g.target === 'lib' ? 'lib' : g.target}`;
			report.push({ part: `cargo ${label}`, ok: code === 0 && !failed.length && !missing.length, lines: [`${g.names.length} tests: ${failed.length} failing, ${missing.length} not run`, ...missing.map((n) => `not run (no such test, or it did not build): ${n}`), ...others.map((n) => `failing, no report in the map: ${n}`)] });
		}
	}

	if (only.includes('danger')) {
		const { code } = await run(process.execPath, [path.join('tools', 'danger-gate.js'), '--levels', opts.levels]);
		if (code === 1) blame([1575], 'danger gate: a new flag');
		report.push({ part: 'danger', ok: code === 0, broken: code > 1, lines: [code === 0 ? 'no new flag' : code === 1 ? 'new flags: fix the guide or review them into data/danger-baseline.json' : `could not run (exit ${code})`] });
	}

	console.log('\nreported-problems gate:');
	for (const r of report) {
		console.log(`  ${r.ok ? 'pass' : 'FAIL'}  ${r.part}: ${r.lines[0]}`);
		for (const l of r.lines.slice(1)) console.log(`        ${l}`);
	}
	if (regressed.size) {
		console.log(`\nreports whose tests fail (${regressed.size}):`);
		for (const [n, what] of [...regressed].sort((a, b) => a[0] - b[0])) console.log(`  #${n}: ${what.join(' | ')}`);
	}
	if (report.some((r) => r.broken)) return 2;
	return report.every((r) => r.ok) ? 0 : 1;
}

if (require.main === module) main(process.argv.slice(2)).then((code) => (process.exitCode = code));

module.exports = { main, loadGate, pins, nodeFiles, cargoGroups, cargoArgs, matches, issuesFor, readTap, readCargo, notApplicable };
