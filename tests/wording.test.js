'use strict';
// The wording rule (the public-text rule, CONTRIBUTING.md "Commits and pull
// requests"): player-facing text, every doc, the guides, the code, the tests,
// the data, the workflows and the agent skills name no other guide product,
// never invite players to import guides from elsewhere and never say a route
// was compared with, follows or matches another guide. The words are in
// tools/lib/public-text.json, the one file this test does not read; every
// tracked file is held to its `tree` rules (tools/public-text.js holds commit
// messages and pull request text to all of them). A failure names the file,
// line and rule, never the words, since CI logs are public. Every path listed
// must exist, so a moved folder fails here instead of being scanned as nothing.

const { test } = require('node:test');
const assert = require('node:assert/strict');
const fs = require('node:fs');
const path = require('node:path');
const { spawnSync } = require('node:child_process');
const { RULES_FILE, SCOPES, loadRules, hashedHits, hits, sha256 } = require('../tools/lib/public-text');

const ROOT = path.join(__dirname, '..');
const PATHS = ['addon', 'guides', 'docs', 'skills', 'tools', 'rust', 'tests', 'services', 'apps', 'forever-db', '.github', 'README.md', 'CONTRIBUTING.md', 'CHANGELOG.md', 'changes', 'THIRD_PARTY.md', 'LICENSE-EXCEPTION.md', 'AGENTS.md'];
const RULES = loadRules();
const NAMES = RULES.hashed.filter((g) => g.id === 'product-name');
// Lines that said so before the rule covered their wording, kept as they are
// (tests/wording-known.txt: SHA-256 of "<path>\t<trimmed line>"). Any other
// line, an edited one included, is held to the rule.
const KNOWN_FILE = path.join(__dirname, 'wording-known.txt');
const KNOWN = new Set(fs.readFileSync(KNOWN_FILE, 'utf8').split('\n').map((l) => l.trim()).filter((l) => l && !l.startsWith('#')));
const knownKey = (rel, line) => sha256(`${rel}\t${line.trim()}`);

// A text file's entry, or null for a binary one (a NUL byte).
function textFile(file) {
	const buf = fs.readFileSync(file);
	return buf.includes(0) ? null : { file, text: buf.toString('utf8') };
}

// Every file under p (p itself when it is a file).
function walk(p) {
	if (fs.statSync(p).isFile()) return [p];
	return fs.readdirSync(p).sort().flatMap((name) => walk(path.join(p, name)));
}

// The files the repository holds under the listed paths: tracked ones and new
// ones git would add, never ignored local files (a maintainer's notes, local
// data packs). Outside a git checkout, every file under them.
function repoFiles() {
	const git = spawnSync('git', ['ls-files', '-z', '--cached', '--others', '--exclude-standard', '--', ...PATHS], { cwd: ROOT, encoding: 'utf8' });
	if (git.status === 0) return git.stdout.split('\0').filter(Boolean).sort().map((rel) => path.join(ROOT, rel)).filter((f) => fs.existsSync(f));
	return PATHS.flatMap((rel) => walk(path.join(ROOT, rel)));
}

// The rules' own file spells what they ban; the golden test data under
// rust/tests is generated game data, not anyone's words; the Nav packs are
// random-looking packed data.
const SKIP = [RULES_FILE, path.join(ROOT, 'rust', 'tests', 'golden') + path.sep];
const NAV = /[/\\]addon[/\\]Polestar_Nav/;
const skipped = (f) => SKIP.some((s) => f === s || f.startsWith(s)) || NAV.test(f);

function scan() {
	for (const rel of PATHS) assert.ok(fs.existsSync(path.join(ROOT, rel)), `${rel} is listed for the wording rule but does not exist`);
	return repoFiles().filter((f) => !skipped(f)).map(textFile).filter(Boolean);
}

const rel = (file) => path.relative(ROOT, file).split(path.sep).join('/');
const lineAt = (text, index) => text.slice(0, index).split('\n').length;

// The language folders' Names.lua hold the game's own names in each language, not Polestar's
// words: a Portuguese NPC may share a first name with a product.
const GAME_NAMES = /[/\\]addon[/\\]Polestar_[a-z]{2}[A-Z]{2}[/\\]Names\.lua$/;

test('no other guide product is named', () => {
	const files = scan();
	assert.ok(files.length > 20, `expected the addon, docs and template files, got ${files.length}`);
	const found = [];
	for (const { file, text } of files.filter((f) => !GAME_NAMES.test(f.file))) {
		for (const { index } of hashedHits(text, NAMES)) found.push(`${rel(file)}:${lineAt(text, index)}: product-name`);
	}
	assert.deepEqual(found, []);
});

// Every tracked text file (and new ones git would add).
function trackedFiles() {
	const git = spawnSync('git', ['ls-files', '-z', '--cached', '--others', '--exclude-standard'], { cwd: ROOT, encoding: 'utf8', maxBuffer: 1 << 28 });
	assert.equal(git.status, 0, 'the wording check runs in a git checkout');
	return git.stdout.split('\0').filter(Boolean)
		.map((r) => path.join(ROOT, r)).filter((f) => !skipped(f) && fs.existsSync(f) && fs.statSync(f).isFile()).map(textFile).filter(Boolean);
}

// Each hit of the `tree` rules in the tracked files (product names: the test
// above) -> { at: "path:line: rule", key, known }.
function treeHits(files) {
	const out = [];
	const set = { hashed: RULES.hashed.filter((g) => g.id !== 'product-name'), rules: RULES.rules };
	for (const { file, text } of files) {
		const lines = text.split('\n');
		for (const h of hits(text, set, ['tree'])) {
			const n = lineAt(text, h.index);
			const key = knownKey(rel(file), lines[n - 1]);
			out.push({ at: `${rel(file)}:${n}: ${h.rule}`, key, known: KNOWN.has(key) });
		}
	}
	return out;
}

test('no tracked file invites importing guides or says a route was compared with others', (t) => {
	const files = trackedFiles();
	assert.ok(files.length > 500, `expected the whole tree, got ${files.length}`);
	const found = treeHits(files);
	assert.deepEqual(found.filter((h) => !h.known).map((h) => h.at), [], 'reword each line named: drop the clause, never swap in another word');
	const present = new Set(found.map((h) => h.key));
	const gone = [...KNOWN].filter((k) => !present.has(k));
	if (gone.length) t.diagnostic(`${gone.length} entries of tests/wording-known.txt match no line any more and can go: ${gone.join(' ')}`);
});

test('every rule matches its examples and passes the plain uses it lists', () => {
	assert.equal(NAMES.length, 1, 'one product-name group');
	assert.ok(NAMES[0].phrases.length >= 12, `expected the product names, got ${NAMES[0].phrases.length}`);
	const ids = [...RULES.hashed, ...RULES.rules].map((r) => r.id);
	assert.deepEqual(ids, [...new Set(ids)], 'rule ids are unique');
	for (const g of RULES.hashed) {
		assert.ok(SCOPES.includes(g.scope), `${g.id}: scope ${g.scope}`);
		for (const p of g.phrases) for (const h of p) assert.match(h, /^[0-9a-f]{64}$/, `${g.id}: a phrase is token hashes`);
	}
	for (const r of RULES.rules) {
		assert.ok(SCOPES.includes(r.scope), `${r.id}: scope ${r.scope}`);
		assert.ok(r.match.length, `${r.id} has an example`);
		const set = { hashed: [], rules: [r] };
		for (const s of r.match) assert.equal(hits(s, set).length, 1, `${r.id} misses its example ${r.match.indexOf(s) + 1}`);
		for (const s of r.pass) assert.deepEqual(hits(s, set), [], `${r.id} matches its plain use ${r.pass.indexOf(s) + 1}`);
	}
});

test('names are matched as whole consecutive tokens, and the game\'s rested XP passes', () => {
	const group = (...phrases) => [{ id: 'sample', scope: 'tree', phrases: phrases.map((p) => p.split(' ').map(sha256)) }];
	const one = group('acmeguides');
	assert.deepEqual(hashedHits('Works like AcmeGuides does', one), [{ rule: 'sample', index: 11 }]);
	assert.deepEqual(hashedHits('Works like Acme Guides does', one), []);
	assert.deepEqual(hashedHits('Works like acmeguides2 does', one), [], 'part of a longer token');
	const two = group('acme convert');
	assert.deepEqual(hashedHits('the acme-convert output', two), [{ rule: 'sample', index: 4 }]);
	assert.deepEqual(hashedHits('acme then convert', two), []);
	assert.deepEqual(hashedHits('it is acme. Convert it', two), [], 'two sentences');
	assert.deepEqual(hashedHits('acme_convert and acme\n  convert', two).length, 2);
	assert.deepEqual(hashedHits(`data:image/png;base64,${'Q'.repeat(30)}/acmeguides+${'Q'.repeat(30)}`, one), [], 'inside packed data');
	assert.deepEqual(hashedHits('You have rested XP; Rested XP doubles kill XP', NAMES), []);
});
