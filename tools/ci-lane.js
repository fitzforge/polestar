#!/usr/bin/env node
'use strict';
// CI lanes (.github/workflows/ci.yml and forge.yml, docs/CI.md "Lanes"): a pull request runs the checks for what it
// changes. Each changed file falls in an area: documentation, a guide (with its compiled output), the addon's Lua,
// data, Rust, a changelog fragment, a Node test file; anything else (the Node tools, the tests' helpers and
// fixtures, workflows, the apps) has none.
//
// ci.yml's Tests job takes one of three lanes:
//   docs   documentation alone: the checks every tracked file gets (DOCS_TESTS: wording, names, SVGs)
//   part   guides, Lua, data, fragments, test files and documentation only: forge from the cache, the Node tests
//          the changes can break (tools/testsel.js's selection, a changed test file itself, plus DOCS_TESTS), the
//          changelog and translation checks, and each area's own checks (AREAS below, `areas=` on the output)
//   full   Rust, the Node tools, the tests' helpers and fixtures, workflows, anything unsure, every push: the whole
//          Node suite and every check (a Rust change can change what forge's commands answer, which the Node tests
//          check)
// forge.yml's Format, lints, tests takes one of three:
//   run    Rust (RUST_PATHS): format, Clippy, the Rust tests, the documented commands, MSRV, wasm32 and the
//          addon's Lua tests (forge-addontest)
//   addon  any other path the addon's Lua tests read (FORGE_PATHS: the addon, the guides, the data): those tests
//          alone, from the test binary next's runs cached; no Rust is built unless the cache has none for this code
//   skip   none of them: the check passes at once
// Both checks report on every pull request either way, so a required check never waits on a job that never started.
//
//   node tools/ci-lane.js <file>...         the lane and why
//   node tools/ci-lane.js --files <list>    the changed paths from a file, one a line (git diff --name-only)
//   --forge                                 forge.yml's lane instead: run, addon or skip
//   --github                                also lane=<lane>, areas=<list> and tests=<files> (with --forge,
//                                           forge=<run|addon|skip>) to $GITHUB_OUTPUT, the reasons to
//                                           $GITHUB_STEP_SUMMARY
//
// A changed file is documentation when it is under docs/ or .github/ISSUE_TEMPLATE/, or a .md at the
// repository's root or under .github/, and nothing the full lane runs reads it: no Node test
// (tools/testsel.js's mapping, the DOCS_TESTS aside) and none of the job's own checks (CI_READS: the changelog
// check reads CHANGELOG.md). Markdown in the code folders (tools/, tests/, skills/, addon/, guides/...) is a
// template, a fixture or shipped with something.

const fs = require('node:fs');
const path = require('node:path');

// Run in every lane (`npm test` holds them too): each reads every tracked file, documentation included.
const DOCS_TESTS = ['tests/wording.test.js', 'tests/nameguard.test.js', 'tests/svg-assets.test.js'];
// Read by ci.yml's checks other than the Node suite.
const CI_READS = ['CHANGELOG.md'];
// Name documents without reading them: this script's own test, whose example paths testsel takes for reads.
const NOT_READERS = ['tests/ci-lane.test.js'];
// The documents the Rust tests read (tests/ci-lane.test.js holds this list to every document a Rust test reads).
const RUST_DOCS = ['docs/FORGE.md', 'docs/forge/**', 'docs/API.md', 'docs/GUIDE_FORMAT.md', 'docs/PACK_FORMAT.md', 'docs/PACKS.md', 'README.md', 'THIRD_PARTY.md'];
// What makes forge.yml run everything, as GitHub path globs (`*` within a folder, `**` across folders): the Rust
// code, the compiler's fixtures, the documents the Rust tests read and the workflow itself.
const RUST_PATHS = ['rust/**', 'tests/fixtures/dsl/**', ...RUST_DOCS, '.github/workflows/forge.yml'];
// Everything forge.yml's suites read: RUST_PATHS and what the addon's Lua tests read (the addon and its client stub,
// the committed data and guides). forge.yml's push trigger lists the same paths (tests/ci-lane.test.js holds them
// equal).
const FORGE_PATHS = ['rust/**', 'addon/**', 'data/**', 'forever-db/**', 'guides/**', 'tests/lua/**', 'tests/fixtures/dsl/**', ...RUST_DOCS, '.github/workflows/forge.yml'];

// The areas of the part lane, first match wins. A guide's compile output (the guide packs, Polestar's experimental
// guides, each language's Texts.lua) goes with the guides: a guide pull request carries it.
const AREAS = [
	{ area: 'guides', re: /^(guides\/|experimental\/|forge\/seed\/|addon\/Polestar_Guides[^/]*\/|addon\/Polestar\/Experimental\/Guides\.lua$|addon\/Polestar_[a-z]{2}[A-Z]{2}\/Texts\.lua$)/ },
	{ area: 'lua', re: /^(addon\/|tests\/lua\/)/ },
	{ area: 'data', re: /^(data\/|forever-db\/)/ },
	{ area: 'rust', re: /^(rust\/|tests\/fixtures\/dsl\/)/ },
	{ area: 'changes', re: /^changes\/[^/]+\.md$/ },
	{ area: 'tests', re: /^tests\/[^/]+\.test\.js$/ },
];
const areaOf = (f) => (AREAS.find((a) => a.re.test(f)) || {}).area || null;

const isDocPath = (f) => f.startsWith('docs/') || f.startsWith('.github/ISSUE_TEMPLATE/') || (f.endsWith('.md') && (!f.includes('/') || f.startsWith('.github/')));
// A GitHub path glob as a regular expression.
const globRe = (g) => new RegExp(`^${g.replace(/[.+^${}()|[\]\\]/g, '\\$&').replace(/\*\*/g, '\u0000').replace(/\*/g, '[^/]*').replace(/\u0000/g, '.*')}$`);
const FORGE_RES = FORGE_PATHS.map(globRe);
const RUST_RES = RUST_PATHS.map(globRe);

const changedList = (files) => [...new Set(files.map((f) => f.trim()).filter(Boolean))];
const plural = (n, word) => `${n} ${word}${n === 1 ? '' : 's'}`;

// files: changed paths relative to the repository -> { lane: 'docs' | 'part' | 'full', areas: [area], reasons:
// [string], tests: [path] }. select: tools/testsel.js's select (a parameter for the tests); exists: whether a test
// file is in the checkout under test (a pull request may delete one).
function lane(files, { select = require('./testsel').select, exists = (rel) => fs.existsSync(rel) } = {}) {
	const changed = changedList(files);
	if (!changed.length) return { lane: 'full', areas: [], reasons: ['no changed files listed'], tests: [] };
	const root = path.join(__dirname, '..');
	const relTest = (t) => path.relative(root, t).split(path.sep).join('/');
	const full = [];
	const areas = new Set();
	for (const f of changed) {
		const area = areaOf(f);
		if (area === 'rust') full.push(`${f}: Rust (the Node tests run forge's commands)`);
		else if (area) areas.add(area);
		else if (!isDocPath(f)) full.push(`${f}: no area (the Node tools and tests, a workflow, the apps: everything runs)`);
		else if (CI_READS.includes(f)) areas.add('changes');
	}
	if (full.length) return { lane: 'full', areas: [], reasons: full, tests: [] };
	const docs = changed.filter(isDocPath);
	if (!areas.size) {
		const reasons = [];
		for (const [test, why] of select(docs).selected) {
			const rel = relTest(test);
			if (!DOCS_TESTS.includes(rel) && !NOT_READERS.includes(rel)) reasons.push(`${rel} ${why.join(', ')}`);
		}
		if (!reasons.length) return { lane: 'docs', areas: [], reasons: [`documentation only (${plural(changed.length, 'file')})`], tests: DOCS_TESTS };
	}
	const tests = new Set(DOCS_TESTS);
	for (const [test] of select(changed).selected) {
		const rel = relTest(test);
		if (exists(rel)) tests.add(rel);
	}
	const list = [...areas].sort();
	const reasons = [`${list.join(', ') || 'documentation'} (${plural(changed.length, 'file')}): ${plural(tests.size, 'Node test file')} they can break`];
	return { lane: 'part', areas: list, reasons, tests: [...tests].sort() };
}

// files: changed paths -> { forge: 'run' | 'addon' | 'skip', reasons: [string] }. No list runs it.
function forgeLane(files) {
	const changed = changedList(files);
	if (!changed.length) return { forge: 'run', reasons: ['no changed files listed'] };
	const rust = changed.filter((f) => RUST_RES.some((re) => re.test(f)));
	if (rust.length) return { forge: 'run', reasons: rust.map((f) => `${f}: Rust, or read by the Rust tests`) };
	const hits = changed.filter((f) => FORGE_RES.some((re) => re.test(f)));
	if (hits.length) return { forge: 'addon', reasons: hits.map((f) => `${f}: read by the addon's Lua tests`) };
	return { forge: 'skip', reasons: [`no path forge.yml's suites read (${plural(changed.length, 'file')})`] };
}

// The languages whose guide texts a change can break (forge i18n guides check): a guide or a pack file (a changed
// English text makes its translations stale until `forge i18n guides sync`) -> all; a language's texts files ->
// that language. files: changed paths -> 'all' | [locale] (empty: none).
const LOCALE_TEXTS = /^(?:guides|experimental)\/locales\/([a-z]{2}[A-Z]{2})\/|^addon\/Polestar_([a-z]{2}[A-Z]{2})\/Texts\.lua$/;
function guideTextLocales(files) {
	const changed = changedList(files);
	if (changed.some((f) => /^(guides|experimental)\/(?!locales\/).*\.(guide|json)$/.test(f))) return 'all';
	const out = new Set();
	for (const f of changed) {
		const m = LOCALE_TEXTS.exec(f);
		if (m) out.add(m[1] || m[2]);
	}
	return [...out].sort();
}

function main(argv) {
	const github = argv.includes('--github');
	const forge = argv.includes('--forge');
	const at = argv.indexOf('--files');
	const files = at >= 0 ? fs.readFileSync(argv[at + 1], 'utf8').split('\n') : argv.filter((a) => !a.startsWith('--'));
	const r = forge ? forgeLane(files) : lane(files);
	const name = forge ? `forge: ${r.forge}` : `lane: ${r.lane}${r.areas.length ? ` (${r.areas.join(', ')})` : ''}`;
	console.log(name);
	for (const why of r.reasons) console.log(`  ${why}`);
	if (!forge && r.lane === 'part') for (const t of r.tests) console.log(`  ${t}`);
	if (github) {
		const locales = guideTextLocales(files);
		fs.appendFileSync(process.env.GITHUB_OUTPUT, forge ? `forge=${r.forge}\n` : `lane=${r.lane}\nareas=${r.areas.join(',')}\ntests=${r.tests.join(' ')}\nlocales=${r.lane === 'full' ? 'all' : Array.isArray(locales) ? locales.join(' ') : locales}\n`);
		const title = forge ? `## Forge lane: ${r.forge}` : `## Lane: ${name.slice('lane: '.length)}`;
		const summary = [title, '', ...r.reasons.slice(0, 50).map((w) => `- ${w}`), r.reasons.length > 50 ? `- and ${r.reasons.length - 50} more` : '', ''];
		fs.appendFileSync(process.env.GITHUB_STEP_SUMMARY, summary.join('\n'));
	}
	return 0;
}

if (require.main === module) process.exitCode = main(process.argv.slice(2));

module.exports = { lane, forgeLane, guideTextLocales, areaOf, isDocPath, globRe, DOCS_TESTS, CI_READS, FORGE_PATHS, RUST_PATHS };
