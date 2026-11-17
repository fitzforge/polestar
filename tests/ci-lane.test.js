'use strict';
// tools/ci-lane.js and the pull request workflows it serves (docs/CI.md, "Lanes"): which changes take ci.yml's
// docs lane and skip forge.yml's suites, that the Tests and Format, lints, tests jobs report on every pull request
// and run every step in a lane, that the Rust suites run on every document their tests read, and that a newer push
// cancels a pull request's older run.

const { test } = require('node:test');
const assert = require('node:assert/strict');
const fs = require('node:fs');
const path = require('node:path');
const { spawnSync } = require('node:child_process');
const { lane, forgeLane, isDocPath, globRe, DOCS_TESTS, FORGE_PATHS } = require('../tools/ci-lane');

const ROOT = path.join(__dirname, '..');
const WORKFLOWS = path.join(ROOT, '.github', 'workflows');
const workflow = (name) => fs.readFileSync(path.join(WORKFLOWS, name), 'utf8');

test('documentation alone takes the docs lane; code, fragments, workflows and a mix take the full lane', () => {
	const docs = lane(['README.md', 'docs/CI.md', 'docs/preview/settings-theme.svg', '.github/ISSUE_TEMPLATE/bug.yml', '.github/pull_request_template.md']);
	assert.equal(docs.lane, 'docs', docs.reasons.join('; '));
	assert.deepEqual(docs.tests, DOCS_TESTS);
	for (const files of [
		['addon/Polestar/Core/Core.lua'],
		['guides/forever/horde/02-the-barrens.guide'],
		['rust/crates/forge/src/main.rs'],
		['changes/some-fix.md'],
		['tools/discord-bot/README.md'],
		['skills/polestar-triage/SKILL.md'],
		['tests/fixtures/discord/elwynn-trainer.md'],
		['.github/workflows/ci.yml'],
		['docs/CI.md', 'tools/ci-lane.js'],
		[],
	]) {
		const r = lane(files);
		assert.equal(r.lane, 'full', `${files.join(', ') || '(none)'}: ${r.reasons.join('; ')}`);
		assert.deepEqual(r.tests, []);
	}
});

test('a document the full lane reads takes the full lane: a Node test reads it, or ci.yml checks it', () => {
	const cheatsheet = lane(['docs/GUIDE_CHEATSHEET.md']);
	assert.equal(cheatsheet.lane, 'full');
	assert.ok(cheatsheet.reasons.some((r) => r.startsWith('tests/docs-cheatsheet.test.js')), cheatsheet.reasons.join('; '));
	assert.equal(lane(['CHANGELOG.md']).lane, 'full', 'the changelog check reads it');
	// Tests outside the docs lane's own reading a document send it to the full lane; the docs lane's own do not.
	const reads = (test) => () => ({ selected: new Map([[path.join(ROOT, test), ['reads docs/X.md']]]) });
	assert.equal(lane(['docs/X.md'], { select: reads('tests/other.test.js') }).lane, 'full');
	assert.equal(lane(['docs/X.md'], { select: reads(DOCS_TESTS[0]) }).lane, 'docs');
});

test('the docs lane runs test files that exist', () => {
	for (const t of DOCS_TESTS) assert.ok(fs.existsSync(path.join(ROOT, t)), t);
});

// The steps of a workflow's job: [{ name, if, id }], read by indentation (two spaces a level).
function jobSteps(text, job) {
	const lines = text.split('\n');
	const start = lines.findIndex((l) => l === `  ${job}:`);
	assert.ok(start >= 0, `a ${job} job`);
	const steps = [];
	let inSteps = false;
	for (const l of lines.slice(start + 1)) {
		if (/^ {0,2}\S/.test(l)) break;
		if (/^ {4}steps:\s*$/.test(l)) inSteps = true;
		else if (/^ {4}\S/.test(l)) inSteps = false;
		else if (inSteps && /^ {6}- /.test(l)) steps.push({ name: (/(?:name|uses): (.*)$/.exec(l) || [])[1], if: null, id: null });
		if (inSteps && steps.length) {
			const at = /^ {6}(?:- | {2})(if|id): (.*)$/.exec(l);
			if (at) steps[steps.length - 1][at[1]] = at[2].trim();
		}
	}
	return steps;
}

test("ci.yml's Tests job: the lane step decides, and every step after it runs in one lane", () => {
	const text = workflow('ci.yml');
	assert.match(text, /^ {4}name: Tests$/m, 'the required check keeps its name');
	assert.doesNotMatch(text, /^ {2}pull_request:\n {4}paths/m, 'Tests starts on every pull request');
	const steps = jobSteps(text, 'test');
	const at = steps.findIndex((s) => s.id === 'lane');
	assert.ok(at > 0, `a step with id lane: ${JSON.stringify(steps)}`);
	assert.equal(steps.slice(0, at).filter((s) => s.if).length, 0, 'the steps before the lane run in both lanes');
	const after = steps.slice(at + 1);
	assert.ok(after.some((s) => s.if === "steps.lane.outputs.lane == 'docs'"));
	for (const s of after) {
		assert.ok(["steps.lane.outputs.lane == 'full'", "steps.lane.outputs.lane == 'docs'"].includes(s.if), `${s.name}: runs in one lane (if: ${s.if})`);
	}
	assert.match(text, /node "\$base\/tools\/ci-lane\.js" --github/, "the lane comes from the base's copy of the script");
});

// The documents a Rust test or script reads: a path joined onto the repository's root or read by name in a
// test file, and the docs/ paths a script names. Globs as written.
function rustReadDocs() {
	const files = spawnSync('git', ['ls-files', '-z', '--', 'rust/*/tests/*.rs', 'rust/scripts/*.sh'], { cwd: ROOT, encoding: 'utf8' }).stdout.split('\0').filter(Boolean);
	const found = new Map();
	const add = (p, where) => isDocPath(p) && found.set(p, [...(found.get(p) || []), where]);
	for (const f of files) {
		fs.readFileSync(path.join(ROOT, f), 'utf8').split('\n').forEach((l, i) => {
			// A comment, or a test writing its own copy into a temporary root.
			if (/^\s*(\/\/|#)/.test(l) || /\bwrite\(/.test(l)) return;
			const where = `${f}:${i + 1}`;
			if (f.endsWith('.sh')) for (const m of l.matchAll(/(?:^|\s)(docs\/[\w.*/-]+|[A-Z][A-Z_-]*\.md)\b/g)) add(m[1], where);
			else for (const m of l.matchAll(/\b(?:root|repo)\w*(?:\(\))?\.join\(\s*"([^"]+)"\s*\)|\bread(?:_to_string)?\(\s*"([^"]+)"\s*\)/g)) add(m[1] || m[2], where);
		});
	}
	return found;
}

test("forge.yml's suites run on every document a Rust test reads, and its pushes start on the same paths", () => {
	const text = workflow('forge.yml');
	const lists = [...text.matchAll(/^ {4}paths: \[(.*)\]$/gm)].map((m) => JSON.parse(`[${m[1]}]`));
	assert.equal(lists.length, 1, 'push paths only: every pull request runs forge.yml');
	assert.deepEqual(lists[0], FORGE_PATHS, "push starts on tools/ci-lane.js's FORGE_PATHS");
	const read = rustReadDocs();
	assert.ok(read.has('docs/API.md') && read.has('docs/forge/*.md'), `the reader finds the known reads: ${[...read.keys()]}`);
	const missing = [...read].filter(([p]) => !FORGE_PATHS.some((g) => globRe(g).test(p) || globRe(g).test(p.replace(/\*/g, 'x')))).map(([p, w]) => `${p} (${w.join(', ')})`);
	assert.deepEqual(missing, [], "add these to FORGE_PATHS in tools/ci-lane.js and forge.yml's push paths");
});

test("forge.yml's lane: its paths run the suites, anything else skips them, no list runs them", () => {
	for (const files of [['rust/crates/forge/src/main.rs'], ['addon/Polestar/Core/Core.lua'], ['guides/forever/horde/02-the-barrens.guide'], ['forever-db/corrections/quests.json'], ['data/route-fixes.json'], ['tests/lua/stub.lua'], ['docs/forge/routes.md'], ['README.md'], ['.github/workflows/forge.yml'], ['docs/CI.md', 'rust/Cargo.toml'], []]) {
		assert.equal(forgeLane(files).forge, 'run', files.join(', ') || '(none)');
	}
	for (const files of [['docs/CI.md'], ['CONTRIBUTING.md'], ['tools/ci-lane.js', 'tests/ci-lane.test.js'], ['changes/x.md'], ['.github/workflows/ci.yml'], ['skills/polestar-guide-fix/SKILL.md'], ['docs/forgery.md'], ['addons/x.lua']]) {
		const r = forgeLane(files);
		assert.equal(r.forge, 'skip', `${files.join(', ')}: ${r.reasons.join('; ')}`);
	}
});

test("forge.yml's Format, lints, tests: reports on every pull request, the base's lane decides, every later step runs in it", () => {
	const text = workflow('forge.yml');
	assert.match(text, /^ {2}pull_request:\s*$/m, 'every pull request starts forge.yml');
	assert.match(text, /^ {4}name: Format, lints, tests$/m, 'the required check keeps its name');
	assert.match(text, /node "\$base\/tools\/ci-lane\.js" --forge --github/, "the lane comes from the base's copy of the script");
	const job = (name) => {
		const m = new RegExp(`^ {2}${name}:\\n((?: {4}.*\\n|\\s*\\n)*)`, 'm').exec(text);
		assert.ok(m, `forge.yml has a ${name} job`);
		return m[1];
	};
	const check = job('check');
	assert.match(check, /^ {4}needs: lane$/m);
	assert.match(check, /^ {4}if: \$\{\{ !cancelled\(\) \}\}$/m, 'the check runs whatever the lane job did, so it always reports');
	const steps = jobSteps(text, 'check');
	assert.equal(steps[0].if, null, 'the first step runs in both lanes');
	assert.match(check, /needs\.lane\.result/, 'the first step fails when the lane job did not finish');
	for (const s of steps.slice(1)) assert.equal(s.if, "needs.lane.outputs.forge != 'skip'", `${s.name}: runs unless the lane skips`);
	for (const name of ['msrv', 'wasm']) assert.match(job(name), /^ {4}if: needs\.lane\.outputs\.forge != 'skip'$/m, `${name} skips with the lane`);
});

test('every pull request workflow cancels its run for the same pull request when a newer push comes', () => {
	// pr-links edits issue comments: its runs queue one at a time, none cancelled (a cancelled run would skip an
	// update).
	const QUEUED = ['pr-links.yml'];
	const seen = [];
	for (const f of fs.readdirSync(WORKFLOWS).filter((n) => /\.ya?ml$/.test(n))) {
		const text = workflow(f);
		if (!/^ {2}pull_request(_target)?:/m.test(text) || QUEUED.includes(f)) continue;
		seen.push(f);
		const group = /^concurrency:\n {2}group: (.*)\n {2}cancel-in-progress: (.*)$/m.exec(text);
		assert.ok(group, `${f}: a workflow-level concurrency group with cancel-in-progress`);
		assert.match(group[1], /github\.ref|pull_request\.number/, `${f}: one group per pull request`);
		assert.ok(["true", "${{ github.event_name == 'pull_request' }}"].includes(group[2]), `${f}: cancel-in-progress for pull requests (${group[2]})`);
	}
	assert.ok(seen.includes('ci.yml') && seen.includes('forge.yml') && seen.includes('pr-base.yml'), seen.join(', '));
});
