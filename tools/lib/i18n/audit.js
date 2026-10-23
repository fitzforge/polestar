'use strict';
// `i18n audit`: the names the client has in each language, held against the
// translations. A text whose English names a spell, a talent, an area or a
// skill line (a talent tree) should carry the client's name for it, as the
// player reads it in the game. `i18n check` knows no client table; this does,
// so it is its own read-only command (tools/lib/i18n/names-wago.js loads the
// tables and keeps them cached).
//
// A name of one word is also an everyday word (Fire, Shadow, Charge): it
// counts only as the whole English text, never inside a sentence. A name of
// several words counts wherever the English has it as whole words. A talent
// tree is also asked for by the first words of its name, as a whole text (the
// addon's "Shadow" is the client's "Shadow Magic"); a role in brackets after
// the text ("Holy (healer)") is left out. The
// translation may inflect it and put it in any case: each word of the client's
// name needs only its first letters, without the last three, in the text.

const fs = require('node:fs');
const path = require('node:path');
const { unescapeLua } = require('./keys');

// A translation line: L["English"] = "Translation" (the interface) or
// ["English"] = "Translation", (guide texts); one entry per line.
const LINE = /^\s*(?:L)?\["((?:[^"\\]|\\.)*)"\]\s*=\s*"((?:[^"\\]|\\.)*)"\s*,?\s*$/;
const MIN_LENGTH = 6;
const PLACEHOLDERS = /\{[a-z]+:\d+\}|%(?:\d+\$)?[-+ #0-9.]*[a-zA-Z]|\|c[0-9a-fA-F]{8}|\|r|\|T[^|]*\|t/g;

// Lua files -> [{ file, line, en, tr }] for each filled-in line (file is as
// given; empty translations are no translation).
function readTexts(files) {
	const out = [];
	for (const file of files) {
		const lines = fs.readFileSync(file, 'utf8').split(/\r?\n/);
		lines.forEach((text, i) => {
			const m = LINE.exec(text);
			if (!m) return;
			const en = unescapeLua(m[1], file, i + 1);
			const tr = unescapeLua(m[2], file, i + 1);
			if (tr.trim()) out.push({ file, line: i + 1, en, tr });
		});
	}
	return out;
}

// Every .lua file under dir, sorted.
function luaFiles(dir) {
	if (!fs.existsSync(dir)) return [];
	const out = [];
	for (const e of fs.readdirSync(dir, { withFileTypes: true })) {
		const p = path.join(dir, e.name);
		if (e.isDirectory()) out.push(...luaFiles(p));
		else if (e.name.endsWith('.lua')) out.push(p);
	}
	return out.sort();
}

const ARTICLES = new Set(['der', 'die', 'das', 'el', 'la', 'le', 'les', 'los', 'las', 'the']);
const stems = (name) => {
	const words = name.toLowerCase().split(/[^\p{L}\p{N}]+/u).filter(Boolean);
	if (words.length > 1 && ARTICLES.has(words[0])) words.shift();
	return words.map((w) => (w.length > 4 ? w.slice(0, Math.max(4, w.length - 3)) : w));
};
// The client's name in the text, word by word. Hyphens and spaces of the text
// are left out first, so "Heilig-Spezialisierung" carries "Heiligspezialisierung".
// A stem is not word-bounded: "Feuer" is also in "Feuerball". That is the price
// of letting the endings change.
const carries = (tr, name) => {
	const text = tr.toLowerCase().replace(/[\s-]+/g, '');
	return stems(name).every((w) => text.includes(w));
};

// The English names of one locale: Map name -> { kind, client: [names] }. A
// name keeps only the client names that differ from the English; one the
// client leaves in English somewhere (Ratchet) is none. The talent trees
// (kind tree) are in treeIndex.
function nameIndex({ names, english }) {
	const by = new Map();
	for (const kind of Object.keys(english)) {
		if (kind === 'tree') continue;
		for (const [id, en] of english[kind]) {
			const tr = names[kind].get(id);
			if (!tr || en.length < 2) continue;
			const e = by.get(en) || { kind, client: new Set(), untranslated: false };
			if (kind === 'skill') e.kind = 'skill';
			if (tr === en) e.untranslated = true;
			else e.client.add(tr);
			by.set(en, e);
		}
	}
	const out = new Map();
	for (const [en, e] of by) if (!e.untranslated && e.client.size) out.set(en, { kind: e.kind, client: [...e.client].sort() });
	return out;
}

// The talent trees by the first words of their English name, shorter than the
// whole: Map words -> { kind: 'tree', client: [names] }. A pet's skill line
// ("Pet - Wolf") is no tree.
function treeIndex({ names, english }) {
	const out = new Map();
	for (const [id, en] of english.tree || []) {
		const tr = names.tree.get(id);
		if (!tr || tr === en || / - /.test(en)) continue;
		const words = en.split(/\s+/);
		for (let n = 1; n < words.length; n++) {
			const key = words.slice(0, n).join(' ');
			const e = out.get(key) || { kind: 'tree', client: [] };
			if (!e.client.includes(tr)) e.client.push(tr);
			out.set(key, e);
		}
	}
	return out;
}

const escapeRe = (s) => s.replace(/[.*+?^${}()|[\]\\]/g, '\\$&');

// Texts of one locale against its client names -> [{ kind, en, client, file,
// line, text, tr }]: a name the English text has, that the translation lacks.
function auditTexts({ texts, index, trees = new Map() }) {
	// The names of several words by their first word; the one-word names by themselves.
	const multi = new Map();
	const single = new Map();
	for (const [en, e] of index) {
		if (/\s/.test(en)) {
			if (en.length < MIN_LENGTH) continue;
			const first = en.split(/\s+/)[0];
			if (!multi.has(first)) multi.set(first, []);
			multi.get(first).push(en);
		} else single.set(en, e);
	}
	for (const list of multi.values()) list.sort((a, b) => b.length - a.length);
	const rows = [];
	for (const t of texts) {
		const plain = t.en.replace(PLACEHOLDERS, ' ');
		const found = [];
		const key = plain.trim().replace(/\s*\([^)]*\)$/, '');
		const whole = single.get(key);
		if (whole) found.push([key, whole]);
		// A tree's short name, unless the client names a skill line so.
		const tree = trees.get(key);
		if (tree && !(whole && whole.kind === 'skill')) found.push([key, tree]);
		let rest = plain;
		const firsts = new Set(plain.split(/[^\p{L}'-]+/u).filter(Boolean));
		const cands = [];
		for (const f of firsts) if (multi.has(f)) cands.push(...multi.get(f));
		cands.sort((a, b) => b.length - a.length);
		for (const en of cands) {
			if (!rest.includes(en)) continue;
			if (!new RegExp(`(?<![\\p{L}'])${escapeRe(en)}(?![\\p{L}'])`, 'u').test(rest)) continue;
			found.push([en, index.get(en)]);
			rest = rest.split(en).join(' ');
		}
		for (const [en, e] of found) {
			if (e.client.some((c) => carries(t.tr, c))) continue;
			rows.push({ kind: e.kind, en, client: e.client, file: t.file, line: t.line, text: t.en, tr: t.tr });
		}
	}
	return rows;
}

// Findings -> the lines of their table: kind, English name, the client's
// name(s), file:line, the English text cut at 60 characters.
function formatTable(rows) {
	const cut = (t, n) => (t.length > n ? `${t.slice(0, n - 1)}…` : t);
	const table = [['kind', 'English name', 'client name', 'file:line', 'English text'], ...rows.map((r) => [r.kind, r.en, r.client.join(' | '), `${r.file}:${r.line}`, cut(r.text.replace(/\s+/g, ' '), 60)])];
	const width = table[0].map((_, c) => Math.max(...table.map((row) => [...row[c]].length)));
	return table.map((row) => `  ${row.map((cell, c) => (c === row.length - 1 ? cell : cell + ' '.repeat(width[c] - [...cell].length))).join('  ')}`);
}

module.exports = { readTexts, luaFiles, nameIndex, treeIndex, auditTexts, formatTable };
