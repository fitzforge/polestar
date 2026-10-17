'use strict';
// The interface's translation files, addon/Polestar/Locales/<locale>.lua, in
// the layout their translators write:
//
//   -- German (deDE). ...                <- the file's own header comments
//
//   local _, ns = ...
//   if not (GetLocale and GetLocale() == "deDE") then return end
//   local L = ns.L
//
//   -- Core/Commands.lua                  <- a group: the file that first uses its keys
//   L["Toggle guide window"] = "Guide-Fenster ein-/ausblenden"
//   -- L["Next step"] = ""               <- not translated yet: shows in English
//
// One entry per line. Values are read by the real Lua 5.1 (a file the game
// cannot load fails here too), with GetLocale answering the file's locale.
// `i18n sync` edits a file in place and never rewrites a line that holds a
// translation: it adds the keys the code gained, commented out, at the end of
// their file's group, and moves the translations of keys the code lost to a
// block at the end of the file for their translator to reuse. Adapted from
// Ding! by Yendi (@moust4ki), GPL-3.0:
// https://github.com/moust4ki/DingGuideWoWForever

const path = require('node:path');
const { luaToJson } = require('../lua');
const { tokenize } = require('./keys');
const { LOCALES } = require('./locales');

const RETIRED = '-- No longer in the code (its English changed or it went away): reuse or delete.';
const BODY_START = 'local L = ns.L';

function luaString(s) {
	let out = '"';
	for (const ch of String(s)) {
		if (ch === '\\') out += '\\\\';
		else if (ch === '"') out += '\\"';
		else if (ch === '\n') out += '\\n';
		else if (ch === '\r') out += '\\r';
		else if (ch === '\t') out += '\\t';
		else if (ch.charCodeAt(0) < 32) out += `\\${String(ch.charCodeAt(0)).padStart(3, '0')}`;
		else out += ch;
	}
	return `${out}"`;
}

function localeFile(addonDir, locale) {
	return path.join(addonDir, 'Locales', `${locale}.lua`);
}

// Loads translation files in one Lua run, each with GetLocale() answering its
// locale and ns = { L, locale, AddTranslations }. Reads Polestar's layout
// (assignments to ns.L), Ding!'s (ns.AddTranslations(locale, t)) and a file
// that returns a table. -> [{ file, ok, error, layout ('L' | 'AddTranslations'
// | 'return'), strings: { key: value }, bad: [key], twice: [key] }] in order.
function readLocaleFiles(entries) {
	if (!entries.length) return [];
	const list = entries.map((e) => `{ path = ${luaString(e.file)}, locale = ${luaString(e.locale)} }`).join(',\n');
	const expr = `
local list = { ${list} }
local current
function GetLocale() return current end
local out = {}
for i, e in ipairs(list) do
	current = e.locale
	local assigned, twice, got = {}, {}, nil
	local L = setmetatable({}, {
		__index = function(_, k) local v = assigned[k]; if v == nil then return k end return v end,
		__newindex = function(_, k, v)
			if assigned[k] ~= nil then twice[#twice + 1] = tostring(k) end
			assigned[k] = v
		end,
	})
	local ns = { L = L, locale = e.locale }
	function ns.AddTranslations(locale, t) got = t end
	local ok, ret = __polestar_loaddata(e.path, "Polestar", ns)
	local r = { ok = ok }
	if not ok then
		r.error = tostring(ret)
	else
		local t, layout = assigned, "L"
		if type(ret) == "table" then t, layout = ret, "return"
		elseif type(got) == "table" then t, layout = got, "AddTranslations" end
		local strings, bad = {}, {}
		for k, v in pairs(t) do
			if type(k) == "string" and type(v) == "string" then strings[k] = v
			else bad[#bad + 1] = tostring(k) end
		end
		r.layout, r.strings, r.bad, r.twice = layout, strings, bad, twice
	end
	out[i] = r
end
return out`;
	const res = luaToJson({ expr });
	const arr = Array.isArray(res) ? res : Object.keys(res).sort((a, b) => a - b).map((k) => res[k]);
	return entries.map((e, i) => {
		const r = arr[i] || { ok: false, error: 'not read' };
		const list = (v) => (Array.isArray(v) ? v : []);
		return {
			file: e.file,
			ok: !!r.ok,
			error: r.error || null,
			layout: r.layout || null,
			strings: r.strings && !Array.isArray(r.strings) ? r.strings : {},
			bad: list(r.bad),
			twice: list(r.twice),
		};
	});
}

// One line of a file -> { kind, key, value } where kind is 'entry'
// (L["key"] = "value"), 'todo' (-- L["key"] = ""), 'retired' (a commented
// translation, -- L["key"] = "value"), 'comment', 'blank' or 'code'.
function classify(line, file, n) {
	const shape = (src) => {
		let t;
		try {
			t = tokenize(src, file);
		} catch {
			return null;
		}
		if (t.length === 6 && t[0].value === 'L' && t[1].value === '[' && t[2].type === 'string' && t[3].value === ']' && t[4].value === '=' && t[5].type === 'string') {
			return { key: t[2].value, value: t[5].value };
		}
		return null;
	};
	if (line.trim() === '') return { kind: 'blank' };
	if (line.startsWith('L[')) {
		const e = shape(line);
		if (!e) throw new Error(`${file}:${n}: not one L["English"] = "translation" on its own line`);
		return { kind: 'entry', ...e };
	}
	if (line.startsWith('-- L[')) {
		const e = shape(line.slice(3));
		if (e) return { kind: e.value === '' ? 'todo' : 'retired', ...e };
	}
	if (line.startsWith('--')) return { kind: 'comment' };
	return { kind: 'code' };
}

// The files a group header names: "-- UI/Options.lua", "-- Rares/View.lua,
// Rares/Options.lua", "-- UI/Packs.lua (a note)". [] for any other comment.
function headerFiles(line) {
	const text = line.replace(/^--\s*/, '').replace(/\s*\(.*\)\s*$/, '');
	return text.split(/,\s*/).filter((f) => /^[A-Za-z]+(?:\/[A-Za-z]+)*\.lua$/.test(f));
}

// A file's text -> { head: [line], groups: [{ header, files, lines: [{ text, kind, key, value }] }], tail: [line] }:
// head up to `local L = ns.L`, then a group at each comment line that is not a
// commented-out L line, and the retired block from its marker to the end.
// Windows line endings are read as plain ones (sync writes the file back with
// "\n").
function parseLocaleText(text, file) {
	const lines = text.replace(/\r\n/g, '\n').split('\n');
	if (lines[lines.length - 1] === '') lines.pop();
	const start = lines.indexOf(BODY_START);
	if (start < 0) throw new Error(`${file}: no "${BODY_START}" line, so not in the interface files' layout (docs/TRANSLATING.md)`);
	const head = lines.slice(0, start + 1);
	const marker = lines.indexOf(RETIRED, start + 1);
	const end = marker < 0 ? lines.length : marker;
	const tail = marker < 0 ? [] : lines.slice(marker);
	const groups = [{ header: null, files: [], lines: [] }];
	for (let i = start + 1; i < end; i++) {
		const c = classify(lines[i], file, i + 1);
		if (c.kind === 'comment') {
			groups.push({ header: lines[i], files: headerFiles(lines[i]), lines: [] });
			continue;
		}
		if (c.kind === 'code') throw new Error(`${file}:${i + 1}: code after "${BODY_START}" (only L["..."] = "..." lines and comments belong there)`);
		groups[groups.length - 1].lines.push({ text: lines[i], ...c });
	}
	return { head, groups, tail };
}

function entryLine(key, value) {
	return `L[${luaString(key)}] = ${luaString(value)}`;
}

function todoLine(key) {
	return `-- L[${luaString(key)}] = ""`;
}

// Brings an existing file in step with the code's keys (Map key -> [{ file }],
// in code order). Lines holding translations stay byte for byte; `fill`
// ({ key: value }) turns a key's commented-out line, or its new line, into a
// translation, never one already translated; `retire` ({ key: value }, keys
// the code lacks) goes to the retired block as comments.
// -> { text, added: [key], retired: [key], dropped: [key], filled: [key], kept: [key] }
function updateLocaleText({ text, file, keys, fill = {}, retire = {} }) {
	const doc = parseLocaleText(text, file);
	const out = { added: [], retired: [], dropped: [], filled: [], kept: [] };
	const retiredLines = [];
	const translated = new Set();
	for (const g of doc.groups) for (const l of g.lines) if (l.kind === 'entry') translated.add(l.key);
	const present = new Set();
	for (const g of doc.groups) {
		const had = g.lines.some((l) => l.kind === 'entry' || l.kind === 'todo');
		g.lines = g.lines.filter((l) => {
			if (l.kind !== 'entry' && l.kind !== 'todo') return true;
			if (!keys.has(l.key)) {
				if (l.kind === 'entry') {
					out.retired.push(l.key);
					retiredLines.push(`-- ${l.text}`);
				} else out.dropped.push(l.key);
				return false;
			}
			// A key twice: its translation stays; a second "to do" line goes.
			if (l.kind === 'todo' && (translated.has(l.key) || present.has(l.key))) return false;
			present.add(l.key);
			return true;
		});
		g.emptied = had && !g.lines.some((l) => l.kind !== 'blank');
		for (const l of g.lines) {
			if (l.kind === 'todo' && typeof fill[l.key] === 'string' && fill[l.key] !== '') {
				l.text = entryLine(l.key, fill[l.key]);
				l.kind = 'entry';
				out.filled.push(l.key);
			} else if (l.kind === 'entry' && typeof fill[l.key] === 'string' && fill[l.key] !== '' && fill[l.key] !== l.value) out.kept.push(l.key);
		}
	}
	// A group whose every line went goes with its header.
	doc.groups = doc.groups.filter((g) => !g.emptied);
	const insertAt = (g, line) => {
		let at = g.lines.length;
		while (at > 0 && g.lines[at - 1].kind === 'blank') at--;
		g.lines.splice(at, 0, { text: line, kind: 'new' });
	};
	const created = new Map();
	for (const [key, where] of keys) {
		if (present.has(key)) continue;
		const f = where[0].file;
		const v = fill[key];
		const line = typeof v === 'string' && v !== '' ? entryLine(key, v) : todoLine(key);
		if (line.startsWith('L[')) out.filled.push(key);
		out.added.push(key);
		let target = null;
		for (const g of doc.groups) if (g.files.includes(f)) target = g;
		if (!target) {
			target = created.get(f);
			if (!target) {
				target = { header: `-- ${f}`, files: [f], lines: [] };
				created.set(f, target);
			}
		}
		insertAt(target, line);
	}
	const lines = [...doc.head];
	const groups = [...doc.groups, ...created.values()];
	groups.forEach((g, i) => {
		if (g.header !== null) {
			if (lines.length && lines[lines.length - 1] !== '') lines.push('');
			lines.push(g.header);
		}
		lines.push(...g.lines.map((l) => l.text));
		if (i === groups.length - 1) while (lines.length && lines[lines.length - 1] === '') lines.pop();
	});
	const tail = [...doc.tail];
	for (const [k, v] of Object.entries(retire).sort(([a], [b]) => (a < b ? -1 : a > b ? 1 : 0))) {
		const line = `-- ${entryLine(k, v)}`;
		if (keys.has(k) || v === '' || tail.includes(line) || retiredLines.includes(line)) continue;
		out.retired.push(k);
		retiredLines.push(line);
	}
	if (retiredLines.length) {
		if (!tail.length) tail.push(RETIRED);
		tail.push(...retiredLines);
	}
	if (tail.length) lines.push('', ...tail);
	return { text: `${lines.join('\n')}\n`, ...out };
}

// A new locale file: its header, then every key grouped under the file that
// first uses it in load order, translated from `fill` or commented out.
function newLocaleText({ locale, keys, fill = {}, retire = {}, title = "Polestar's interface strings" }) {
	const meta = LOCALES[locale];
	const head = [
		`-- ${meta ? meta.language : locale} (${locale}): ${title}.`,
		'-- Keys are the English strings exactly as the code writes them; a key',
		'-- missing here, or commented out, shows in English. Grouped by the file that',
		'-- first uses each key. docs/TRANSLATING.md explains the rest.',
		'',
		'local _, ns = ...',
		`if not (GetLocale and GetLocale() == ${luaString(locale)}) then return end`,
		BODY_START,
	];
	return updateLocaleText({ text: `${head.join('\n')}\n`, file: `Locales/${locale}.lua`, keys, fill, retire });
}

module.exports = { RETIRED, luaString, localeFile, readLocaleFiles, parseLocaleText, updateLocaleText, newLocaleText };
