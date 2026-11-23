'use strict';
// tools/ci-lane.js and the pull request workflows it serves (docs/CI.md, "Lanes"): which changes take ci.yml's
// docs, part or full lane and forge.yml's run, addon or skip lane, that the Tests and Format, lints, tests jobs
// report on every pull request and run every step in a lane, that the Rust suites run on every document their
// tests read, and that a newer push cancels a pull request's older run.

const { test } = require('node:test');
const assert = require('node:assert/strict');
const fs = require('node:fs');
const path = require('node:path');
const { spawnSync } = require('node:child_process');
const { lane, forgeLane, guideTextLocales, areaOf, isDocPath, globRe, DOCS_TESTS, FORGE_PATHS, RUST_PATHS } = require('../tools/ci-lane');

const ROOT = path.join(__dirname, '..');
const WORKFLOWS = path.join(ROOT, '.github', 'workflows');
const workflow = (name) => fs.readFileSync(path.join(WORKFLOWS, name), 'utf8');

test('documentation alone takes the docs lane; guides, Lua, data and fragments the part lane; anything else the full lane', () => {
	const docs = lane(['README.md', 'docs/CI.md', 'docs/preview/settings-theme.svg', '.github/ISSUE_TEMPLATE/bug.yml', '.github/pull_request_template.md']);
	assert.equal(docs.lane, 'docs', docs.reasons.join('; '));
	assert.deepEqual(docs.tests, DOCS_TESTS);
	for (const [files, areas] of [
		[['addon/Polestar/Core/Core.lua'], ['lua']],
		[['tests/lua/stub.lua'], ['lua']],
		[['guides/forever/horde/02-the-barrens.guide', 'addon/Polestar_Guides_Horde/Guides.lua', 'addon/Polestar_deDE/Texts.lua', 'guides/locales/deDE/forever/horde/40-50/04-tanaris.lua'], ['guides']],
		[['experimental/guides/x.guide', 'addon/Polestar/Experimental/Guides.lua', 'forge/seed/SEED.json'], ['guides']],
		[['data/guide-fixes.json', 'forever-db/corrections/quests.json'], ['data']],
		[['changes/some-fix.md'], ['changes']],
		[['addon/Polestar_deDE/Interface.lua', 'changes/x.md', 'docs/CI.md'], ['changes', 'lua']],
		[['guides/forever/horde/02-the-barrens.guide', 'data/guide-fixes.json', 'tests/guides-reported.test.js'], ['data', 'guides', 'tests']],
		[['addon/Polestar/Core/Core.lua', 'tests/helpers/cli.js'], null],
	]) {
		const r = lane(files);
		if (!areas) {
			assert.equal(r.lane, 'full', `${files.join(', ')}: ${r.reasons.join('; ')}`);
			continue;
		}
		assert.equal(r.lane, 'part', `${files.join(', ')}: ${r.reasons.join('; ')}`);
		assert.deepEqual(r.areas, areas, files.join(', '));
		for (const t of DOCS_TESTS) assert.ok(r.tests.includes(t), `${files.join(', ')}: runs ${t}`);
	}
	for (const files of [
		['rust/crates/forge/src/main.rs'],
		['tests/fixtures/dsl/x.guide'],
		['tools/discord-bot/README.md'],
		['skills/polestar-triage/SKILL.md'],
		['tests/fixtures/discord/elwynn-trainer.md'],
		['.github/workflows/ci.yml'],
		['docs/CI.md', 'tools/ci-lane.js'],
		['addon/Polestar/Core/Core.lua', 'rust/Cargo.toml'],
		[],
	]) {
		const r = lane(files);
		assert.equal(r.lane, 'full', `${files.join(', ') || '(none)'}: ${r.reasons.join('; ')}`);
		assert.deepEqual(r.tests, []);
	}
});

test("the part lane runs the Node tests its changes can break: a guide's the guide suites, the addon's those loading it", () => {
	const guide = lane(['guides/forever/horde/40-50/04-tanaris.guide']);
	for (const t of ['tests/guides-reported.test.js', 'tests/guides-patterns.test.js']) assert.ok(guide.tests.includes(t), `a guide runs ${t}: ${guide.tests.join(' ')}`);
	const lua = lane(['addon/Polestar/Core/Core.lua']);
	assert.ok(lua.tests.length > DOCS_TESTS.length, lua.tests.join(' '));
	// A test the pull request deletes is not run.
	const reads = (test) => () => ({ selected: new Map([[path.join(ROOT, test), ['reads data/x.json']]]) });
	assert.ok(lane(['data/x.json'], { select: reads('tests/other.test.js'), exists: () => true }).tests.includes('tests/other.test.js'));
	assert.ok(!lane(['data/x.json'], { select: reads('tests/other.test.js'), exists: () => false }).tests.includes('tests/other.test.js'));
});

test('a document the full lane reads leaves the docs lane: a Node test reads it, or ci.yml checks it', () => {
	const cheatsheet = lane(['docs/GUIDE_CHEATSHEET.md']);
	assert.equal(cheatsheet.lane, 'part');
	assert.ok(cheatsheet.tests.includes('tests/docs-cheatsheet.test.js'), cheatsheet.tests.join(' '));
	assert.equal(lane(['CHANGELOG.md']).lane, 'part', 'the changelog check reads it');
	// Tests outside the docs lane's own reading a document send it to the part lane; the docs lane's own do not.
	const reads = (test) => () => ({ selected: new Map([[path.join(ROOT, test), ['reads docs/X.md']]]) });
	assert.equal(lane(['docs/X.md'], { select: reads('tests/other.test.js'), exists: () => true }).lane, 'part');
	assert.equal(lane(['docs/X.md'], { select: reads(DOCS_TESTS[0]) }).lane, 'docs');
	assert.equal(areaOf('docs/CI.md'), null);
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

test("ci.yml's Tests job: the lane step decides, and every step after it runs in a lane", () => {
	const text = workflow('ci.yml');
	assert.match(text, /^ {4}name: Tests$/m, 'the required check keeps its name');
	assert.doesNotMatch(text, /^ {2}pull_request:\n {4}paths/m, 'Tests starts on every pull request');
	const steps = jobSteps(text, 'test');
	const at = steps.findIndex((s) => s.id === 'lane');
	assert.ok(at > 0, `a step with id lane: ${JSON.stringify(steps)}`);
	assert.equal(steps.slice(0, at).filter((s) => s.if).length, 0, 'the steps before the lane run in every lane');
	const after = steps.slice(at + 1);
	for (const want of ["steps.lane.outputs.lane == 'docs'", "steps.lane.outputs.lane == 'part'", "steps.lane.outputs.lane == 'full'"]) {
		assert.ok(after.some((s) => s.if === want), `a step for ${want}`);
	}
	for (const s of after) assert.match(s.if || '', /^steps\.lane\.outputs\.lane [!=]= '(docs|part|full)'/, `${s.name}: runs by the lane (if: ${s.if})`);
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
	for (const g of RUST_PATHS) assert.ok(FORGE_PATHS.includes(g), `${g}: in FORGE_PATHS too`);
	const read = rustReadDocs();
	assert.ok(read.has('docs/API.md') && read.has('docs/forge/*.md'), `the reader finds the known reads: ${[...read.keys()]}`);
	const missing = [...read].filter(([p]) => !RUST_PATHS.some((g) => globRe(g).test(p) || globRe(g).test(p.replace(/\*/g, 'x')))).map(([p, w]) => `${p} (${w.join(', ')})`);
	assert.deepEqual(missing, [], "add these to RUST_DOCS in tools/ci-lane.js");
});

test('the guide texts check: a guide change checks every language, a language\'s texts that language, anything else none', () => {
	assert.equal(guideTextLocales(['guides/forever/horde/40-50/04-tanaris.guide', 'guides/locales/deDE/forever/horde/40-50/04-tanaris.lua']), 'all');
	assert.equal(guideTextLocales(['experimental/guides/x.guide']), 'all');
	assert.deepEqual(guideTextLocales(['guides/locales/frFR/forever/a.lua', 'addon/Polestar_deDE/Texts.lua', 'guides/locales/frFR/forever/b.lua']), ['deDE', 'frFR']);
	assert.deepEqual(guideTextLocales(['addon/Polestar_deDE/Interface.lua', 'docs/CI.md', 'data/guide-fixes.json']), []);
});

test("forge.yml's lane: Rust runs everything, the rest of its paths the Lua tests, anything else skips, no list runs", () => {
	for (const files of [['rust/crates/forge/src/main.rs'], ['tests/fixtures/dsl/x.guide'], ['docs/forge/routes.md'], ['README.md'], ['.github/workflows/forge.yml'], ['docs/CI.md', 'rust/Cargo.toml'], ['addon/Polestar/Core/Core.lua', 'rust/Cargo.toml'], []]) {
		assert.equal(forgeLane(files).forge, 'run', files.join(', ') || '(none)');
	}
	for (const files of [['addon/Polestar/Core/Core.lua'], ['guides/forever/horde/02-the-barrens.guide'], ['forever-db/corrections/quests.json'], ['data/route-fixes.json'], ['tests/lua/stub.lua'], ['addon/Polestar_Guides/Guides.lua', 'changes/x.md']]) {
		assert.equal(forgeLane(files).forge, 'addon', files.join(', '));
	}
	for (const files of [['docs/CI.md'], ['CONTRIBUTING.md'], ['tools/ci-lane.js', 'tests/ci-lane.test.js'], ['changes/x.md'], ['.github/workflows/ci.yml'], ['skills/polestar-guide-fix/SKILL.md'], ['docs/forgery.md'], ['addons/x.lua']]) {
		const r = forgeLane(files);
		assert.equal(r.forge, 'skip', `${files.join(', ')}: ${r.reasons.join('; ')}`);
	}
});

test("forge.yml's Format, lints, tests: reports on every pull request, the base's lane decides, each job runs in its lane", () => {
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
	assert.match(check, /^ {4}needs: \[lane, rust, addontest-bin, addontest\]$/m, 'the check waits for every job a lane runs');
	assert.match(check, /^ {4}if: \$\{\{ !cancelled\(\) \}\}$/m, 'the check runs whatever the other jobs did, so it always reports');
	assert.match(check, /needs\.lane\.result/, 'the check fails when the lane job did not finish');
	for (const name of ['rust', 'addontest']) assert.match(check, new RegExp(`needs\\.${name}\\.result`), `the check reads ${name}'s result`);
	assert.equal(jobSteps(text, 'check').length, 1, 'the check checks out and runs nothing');
	for (const name of ['rust', 'msrv', 'wasm']) assert.match(job(name), /^ {4}if: needs\.lane\.outputs\.forge == 'run'$/m, `${name} runs in the run lane only`);
	assert.match(job('addontest-bin'), /^ {4}if: needs\.lane\.outputs\.forge == 'run' \|\| needs\.lane\.outputs\.forge == 'addon'$/m);
	assert.match(job('addontest'), /^ {4}needs: \[lane, addontest-bin\]$/m);
	assert.match(job('rust'), /--exclude forge-addontest/, 'the Rust suites leave the Lua tests to the addontest jobs');
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

// The checks next requires (docs/RELEASING.md, "Branch rules"), by the workflow that reports each for a merge group.
const REQUIRED = { Tests: 'ci.yml', 'Format, lints, tests': 'forge.yml', 'Base branch': 'merge-queue.yml' };

test('every check next requires reports for a merge group, from a workflow that starts on one', () => {
	for (const [check, f] of Object.entries(REQUIRED)) {
		const text = workflow(f);
		assert.match(text, /^ {2}merge_group:\s*$/m, `${f} starts on merge_group`);
		assert.ok(text.includes(`    name: ${check}\n`), `${f} has a job named ${check}`);
	}
	for (const f of ['ci.yml', 'forge.yml']) {
		const text = workflow(f);
		assert.match(text, /merge_group\) git fetch --no-tags --quiet --depth=1 origin "\$GROUP_BASE" && from=\$GROUP_BASE ;;/, `${f}: a merge group's lane is what the group changes on top of its base`);
		assert.match(text, /GROUP_BASE: \$\{\{ github\.event\.merge_group\.base_sha \}\}/, f);
	}
	// pr-base.yml runs on pull_request_target, held to it by the repository's Actions event policy; the merge
	// queue's Base branch comes from merge-queue.yml, which runs nothing else and checks out nothing.
	assert.doesNotMatch(workflow('pr-base.yml'), /^ {2}merge_group:/m);
	const mq = workflow('merge-queue.yml');
	assert.match(mq, /^on:\n {2}merge_group:\n\n/m, 'merge-queue.yml starts on merge groups only');
	assert.doesNotMatch(mq, /actions\/checkout|uses:/, 'merge-queue.yml runs no code from the repository');
	assert.match(workflow('forge.yml'), /^ {4}if: github\.event_name == 'push'$/m, 'the release builds run on pushes only, not for merge groups');
});
