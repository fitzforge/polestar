'use strict';
// The public-text rule (CONTRIBUTING.md, "Commits and pull requests"): the
// repository, its commit messages, branch names and pull request text name no
// other guide product and never say a route was compared with, follows or
// matches another guide. The words live in tools/lib/public-text.json (its
// `_about` says how); tests/wording.test.js holds every tracked file to the
// `tree` rules and tools/public-text.js holds messages to all of them. A hit
// carries the rule's id and where it is, never the text it matched, so a
// check's log never repeats the words.
//
//   const set = loadRules();
//   hits('some text', set) // -> [{ rule: 'route-compared', index: 12 }]
//
// Names (other guide products', private material's) are kept as hashes of
// their tokens, matched as whole consecutive tokens; phrases are regular
// expressions.

const crypto = require('node:crypto');
const fs = require('node:fs');
const path = require('node:path');

const RULES_FILE = path.join(__dirname, 'public-text.json');
const SCOPES = ['tree', 'message'];

const sha256 = (s) => crypto.createHash('sha256').update(s).digest('hex');

// { hashed: [{ id, scope, phrases: [[token hash, ...], ...] }], rules: [{ id, scope, re, match, pass }] } from file.
function loadRules(file = RULES_FILE) {
	const raw = JSON.parse(fs.readFileSync(file, 'utf8'));
	return { hashed: raw.hashed || [], rules: raw.rules || [] };
}

// Tokens repeat endlessly across a tree: hash each distinct one once.
const tokenHash = new Map();
const hashOf = (t) => {
	let h = tokenHash.get(t);
	if (h === undefined) tokenHash.set(t, (h = sha256(t)));
	return h;
};

// The lower-case alphanumeric tokens of text, each { token, index, hash, sep }
// (sep: the characters between it and the next token). A token over 40
// characters, or inside a run of over 40 base64 characters (an embedded image,
// packed data), is never a name: no hash.
function tokens(text) {
	const packed = [...text.matchAll(/[A-Za-z0-9+/=]{41,}/g)].map((m) => [m.index, m.index + m[0].length]);
	const out = [];
	let p = 0;
	const lower = text.toLowerCase();
	for (const m of lower.matchAll(/[a-z0-9]+/g)) {
		while (p < packed.length && packed[p][1] <= m.index) p++;
		const inPacked = p < packed.length && packed[p][0] <= m.index;
		if (out.length) out[out.length - 1].sep = text.slice(out[out.length - 1].index + out[out.length - 1].token.length, m.index);
		out.push({ token: m[0], index: m.index, hash: m[0].length <= 40 && !inPacked ? hashOf(m[0]) : null, sep: '' });
	}
	return out;
}

// Tokens of one name: joined by one space, hyphen, underscore, dot or slash,
// or by a line break ("decoded. Guides" is two sentences, not a name).
const JOIN = /^(?:[ \-_./]|\s*\n\s*)$/;

// Where text holds a phrase of a hashed group -> [{ rule, index }]: its
// tokens, one after another, hash to the phrase's.
function hashedHits(text, groups) {
	const out = [];
	if (!groups.length) return out;
	const toks = tokens(text);
	for (const g of groups) {
		const byFirst = new Map();
		for (const p of g.phrases) {
			if (!byFirst.has(p[0])) byFirst.set(p[0], []);
			byFirst.get(p[0]).push(p);
		}
		toks.forEach((t, i) => {
			for (const p of byFirst.get(t.hash) || []) {
				if (p.every((h, k) => toks[i + k] && toks[i + k].hash === h && (k === 0 || JOIN.test(toks[i + k - 1].sep)))) out.push({ rule: g.id, index: t.index });
			}
		});
	}
	return out;
}

// Where text breaks the rules of `scopes` -> [{ rule, index }] in text order.
function hits(text, { hashed, rules }, scopes = SCOPES) {
	const out = hashedHits(text, hashed.filter((g) => scopes.includes(g.scope)));
	for (const r of rules) {
		if (!scopes.includes(r.scope)) continue;
		for (const m of text.matchAll(new RegExp(r.re, 'gi'))) out.push({ rule: r.id, index: m.index });
	}
	return out.sort((a, b) => a.index - b.index);
}

// A phrase's entry for a hashed group: the hash of each of its tokens.
const phraseHashes = (phrase) => (phrase.toLowerCase().match(/[a-z0-9]+/g) || []).map(sha256);

// The 1-based line and column of index in text.
function lineCol(text, index) {
	const before = text.slice(0, index);
	const nl = before.lastIndexOf('\n');
	return { line: before.split('\n').length, col: index - nl };
}

// A commit message as git keeps it: no comment lines, nothing from the
// scissors line down (the diff `git commit -v` shows).
function commitMessage(text, comment = '#') {
	const out = [];
	for (const line of text.split('\n')) {
		if (line.startsWith(`${comment} ------------------------ >8 ------------------------`)) break;
		if (!line.startsWith(comment)) out.push(line);
	}
	return out.join('\n');
}

module.exports = { RULES_FILE, SCOPES, loadRules, tokens, hashedHits, hits, phraseHashes, lineCol, commitMessage, sha256 };
