'use strict';
// The wording rule: player-facing text, every doc, the guides, the code, the
// tests, the workflows and the agent skills name no other guide product and
// never invite players to bring or convert other guides. Every path
// listed must exist, so a moved folder fails here instead of being scanned as
// nothing. Names are matched as whole tokens, so the game's own "rested XP"
// (two tokens) is not a product name.

const { test } = require('node:test');
const assert = require('node:assert/strict');
const crypto = require('node:crypto');
const fs = require('node:fs');
const path = require('node:path');
const { spawnSync } = require('node:child_process');

const ROOT = path.join(__dirname, '..');
const PATHS = ['addon', 'guides', 'docs', 'skills', 'tools', 'rust', 'tests', 'services', 'apps', 'forever-db', '.github', 'README.md', 'CONTRIBUTING.md', 'CHANGELOG.md', 'changes', 'THIRD_PARTY.md', 'LICENSE-EXCEPTION.md', 'AGENTS.md'];
// Names of other guide products, kept as hashes so the repository never
// spells them: SHA-256 of each name's lower-case form.
const NAME_HASHES = new Set([
	'380d1810dc2d0473959dea98e3428eb772588b3cb0c4d2d32768987a85b74e8c',
	'ec9eefd3b3811601e900635d5b02d34c6f13aed885de2fe3a748f6d497354b1a',
	'3c6efb268bde2923e4f7cbc086995f6158a606e66df45e307829e6b28f7aaf0e',
	'766f4a2eab6065a164747b05230961a0330679e107cfec7d32398233a16e06c0',
	'adb440d3141ea93a3050652202bf4b6a9a6f9e7872b082e939046a03fe3f4f86',
]);
// "import your existing guides", "converting paid guides", "bring your paid guides"...
// (\b: "report other guides" or "support other guides" is not an invitation).
const INVITE = /\b(import|convert|port|bring)(ing)? (your )?(existing|paid|other)[^\n]{0,40}guides?/i;

const sha256 = (s) => crypto.createHash('sha256').update(s).digest('hex');

// Tokens repeat endlessly across the tree: hash each distinct one once.
const tokenHash = new Map();
const hashOf = (t) => {
	let h = tokenHash.get(t);
	if (h === undefined) tokenHash.set(t, (h = sha256(t)));
	return h;
};

// Each lower-case alphanumeric token of text whose hash is in hashes, with its index.
// Tokens longer than any product name (40+ characters: packed data) are not hashed.
function namedTokens(text, hashes) {
	const out = [];
	const lower = text.toLowerCase();
	for (const m of lower.matchAll(/[a-z0-9]{1,40}(?![a-z0-9])/g)) {
		if (m.index > 0 && /[a-z0-9]/.test(lower[m.index - 1])) continue;
		if (hashes.has(hashOf(m[0]))) out.push({ token: m[0], index: m.index });
	}
	return out;
}

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

// This file spells the invitations it looks for; the golden test data under rust/tests is
// generated game data, not anyone's words.
const SKIP = [path.join(ROOT, 'tests', 'wording.test.js'), path.join(ROOT, 'rust', 'tests', 'golden') + path.sep];

function scan() {
	for (const rel of PATHS) assert.ok(fs.existsSync(path.join(ROOT, rel)), `${rel} is listed for the wording rule but does not exist`);
	return repoFiles().filter((f) => !SKIP.some((s) => f === s || f.startsWith(s))).map(textFile).filter(Boolean);
}

const where = (file, text, index) => `${path.relative(ROOT, file)}:${text.slice(0, index).split('\n').length}`;

// The language folders' Names.lua hold the game's own names in each language, not Polestar's
// words: a Portuguese NPC may share a first name with a product.
const GAME_NAMES = /[/\\]addon[/\\]Polestar_[a-z]{2}[A-Z]{2}[/\\]Names\.lua$/;

test('no other guide product is named', () => {
	const files = scan();
	assert.ok(files.length > 20, `expected the addon, docs and template files, got ${files.length}`);
	const hits = [];
	for (const { file, text } of files.filter((f) => !GAME_NAMES.test(f.file))) {
		for (const { token, index } of namedTokens(text, NAME_HASHES)) hits.push(`${where(file, text, index)}: ${token}`);
	}
	assert.deepEqual(hits, []);
});

test('nothing invites bringing or converting other guides', () => {
	const hits = [];
	for (const { file, text } of scan()) {
		const re = new RegExp(INVITE.source, 'gi');
		for (const m of text.matchAll(re)) hits.push(`${where(file, text, m.index)}: ${m[0]}`);
	}
	assert.deepEqual(hits, []);
});

test('the checks catch what they are for, and the game\'s rested XP passes', () => {
	assert.equal(NAME_HASHES.size, 5);
	for (const h of NAME_HASHES) assert.match(h, /^[0-9a-f]{64}$/);
	const sample = new Set([sha256('acmeguides')]);
	assert.deepEqual(namedTokens('Works like AcmeGuides does', sample), [{ token: 'acmeguides', index: 11 }]);
	assert.deepEqual(namedTokens('Works like Acme Guides does', sample), []);
	assert.deepEqual(namedTokens('You have rested XP; Rested XP doubles kill XP', NAME_HASHES), []);
	assert.match('Import your existing guides here', INVITE);
	assert.match('converting paid guides is easy', INVITE);
	assert.match('Bring your paid guides into Polestar', INVITE);
	assert.doesNotMatch('Guide packs are addons made by other players.', INVITE);
	assert.doesNotMatch('Report other guides\' problems to their authors', INVITE);
});
