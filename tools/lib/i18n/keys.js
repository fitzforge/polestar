'use strict';
// The interface's translation keys: every literal L["..."] and ns.LC("context",
// "text") in addon/Polestar (docs/ARCHITECTURE.md, "Localisation"), read with
// a small Lua tokenizer so strings in comments and inside other strings never
// count, plus the keys code looks up from data (L[category], L[race], ...),
// listed below where they come from. Adapted from Ding! by Yendi (@moust4ki),
// GPL-3.0: https://github.com/moust4ki/DingGuideWoWForever

const fs = require('node:fs');
const path = require('node:path');
const { dirFiles } = require('../../../tests/helpers/lua');

const LONG_OPEN = /^\[(=*)\[/;

const SIMPLE_ESCAPES = { n: 10, t: 9, r: 13, a: 7, b: 8, f: 12, v: 11, '\\': 92, '"': 34, "'": 39, '\n': 10 };

// A quoted Lua string's body -> its text: the bytes it stands for (decimal
// escapes are bytes), read as UTF-8 like the client reads them.
function unescapeLua(body, file, line) {
	const bytes = [];
	for (let i = 0; i < body.length; i++) {
		const c = body[i];
		if (c !== '\\') {
			const cp = body.codePointAt(i);
			if (cp > 0xffff) i++;
			bytes.push(...Buffer.from(String.fromCodePoint(cp), 'utf8'));
			continue;
		}
		const n = body[++i];
		if (n in SIMPLE_ESCAPES) bytes.push(SIMPLE_ESCAPES[n]);
		else if (/[0-9]/.test(n)) {
			let digits = n;
			while (digits.length < 3 && /[0-9]/.test(body[i + 1])) digits += body[++i];
			bytes.push(Number(digits) & 255);
		} else throw new Error(`${file}:${line}: invalid escape \\${n}`);
	}
	return Buffer.from(bytes).toString('utf8');
}

// Lua source -> [{ type: 'name'|'string'|'punct', value, line }]; comments dropped.
// Strings are decoded to their bytes and returned as UTF-8 text.
function tokenize(src, file = '?') {
	const tokens = [];
	let i = 0;
	let line = 1;
	const len = src.length;
	while (i < len) {
		const c = src[i];
		if (c === '\n') {
			line++;
			i++;
			continue;
		}
		if (c === ' ' || c === '\t' || c === '\r') {
			i++;
			continue;
		}
		if (c === '-' && src[i + 1] === '-') {
			const rest = src.slice(i + 2, i + 2 + 64);
			const m = LONG_OPEN.exec(rest);
			if (m) {
				const close = `]${m[1]}]`;
				const end = src.indexOf(close, i + 2 + m[0].length);
				const stop = end < 0 ? len : end + close.length;
				line += (src.slice(i, stop).match(/\n/g) || []).length;
				i = stop;
			} else {
				while (i < len && src[i] !== '\n') i++;
			}
			continue;
		}
		if (c === '[') {
			const m = LONG_OPEN.exec(src.slice(i, i + 64));
			if (m) {
				const close = `]${m[1]}]`;
				const end = src.indexOf(close, i + m[0].length);
				if (end < 0) throw new Error(`${file}:${line}: unfinished long string`);
				let body = src.slice(i + m[0].length, end);
				const startLine = line;
				line += (src.slice(i, end).match(/\n/g) || []).length;
				if (body.startsWith('\n')) body = body.slice(1);
				tokens.push({ type: 'string', value: body, line: startLine });
				i = end + close.length;
				continue;
			}
		}
		if (c === '"' || c === "'") {
			let j = i + 1;
			while (j < len && src[j] !== c) {
				if (src[j] === '\\') j++;
				if (src[j] === '\n' && src[j - 1] !== '\\') throw new Error(`${file}:${line}: unfinished string`);
				j++;
			}
			if (j >= len) throw new Error(`${file}:${line}: unfinished string`);
			const raw = src.slice(i + 1, j);
			const value = unescapeLua(raw, file, line);
			tokens.push({ type: 'string', value, line });
			line += (raw.match(/\n/g) || []).length;
			i = j + 1;
			continue;
		}
		if (/[A-Za-z_]/.test(c)) {
			let j = i + 1;
			while (j < len && /[A-Za-z0-9_]/.test(src[j])) j++;
			tokens.push({ type: 'name', value: src.slice(i, j), line });
			i = j;
			continue;
		}
		if (/[0-9]/.test(c)) {
			let j = i + 1;
			while (j < len && /[0-9A-Fa-fxX.]/.test(src[j])) j++;
			if ((src[j] === '-' || src[j] === '+') && /[eEpP]/.test(src[j - 1])) {
				j++;
				while (j < len && /[0-9]/.test(src[j])) j++;
			}
			tokens.push({ type: 'number', value: src.slice(i, j), line });
			i = j;
			continue;
		}
		tokens.push({ type: 'punct', value: c, line });
		i++;
	}
	return tokens;
}

// Keys in one Lua source: [{ key, line }] for L["text"] and LC("ctx", "text").
function keysInSource(src, file) {
	const t = tokenize(src, file);
	const out = [];
	for (let i = 0; i < t.length; i++) {
		const a = t[i];
		if (a.type !== 'name') continue;
		if (a.value === 'L' && t[i + 1] && t[i + 1].value === '[' && t[i + 2] && t[i + 2].type === 'string' && t[i + 3] && t[i + 3].value === ']') {
			out.push({ key: t[i + 2].value, line: t[i + 2].line });
		} else if (a.value === 'LC' && t[i + 1] && t[i + 1].value === '(' && t[i + 2] && t[i + 2].type === 'string' && t[i + 3] && t[i + 3].value === ','
			&& t[i + 4] && t[i + 4].type === 'string' && t[i + 5] && t[i + 5].value === ')') {
			out.push({ key: `${t[i + 2].value}: ${t[i + 4].value}`, line: t[i + 4].line });
		}
	}
	return out;
}

// Keys code looks up with a variable (L[c]): text that comes from data.
// Each list names where its values come from; a value added there is added here.
const DATA_KEYS = {
	// The guide format's categories (docs/GUIDE_FORMAT.md, `category`; UI/Picker.lua CATEGORIES, UI.Category).
	'UI/Picker.lua': ['Leveling', 'Class', 'Professions', 'Reputation', 'Exploration', 'Legacy', 'Collectibles'],
	// UI.RaceName: Forever's race files (tools/lib/game/races.js) as RACE_NAMES words them,
	// where the client has no name for the race (Skyborne) or no C_CreatureInfo.GetRaceInfo;
	// UI.ClassName when the client has no LOCALIZED_CLASS_NAMES_MALE.
	'UI/UI.lua': ['Human', 'Orc', 'Dwarf', 'Night Elf', 'Undead', 'Tauren', 'Gnome', 'Troll', 'Skyborne',
		'Warrior', 'Paladin', 'Hunter', 'Rogue', 'Priest', 'Shaman', 'Mage', 'Warlock', 'Druid'],
	// Lookup.PROFESSIONS (Lookup/Sources.lua), shown through L[name] in Lookup/Guide.lua.
	'Lookup/Sources.lua': ['Alchemy', 'Blacksmithing', 'Enchanting', 'Engineering', 'Herbalism', 'Leatherworking', 'Mining', 'Skinning', 'Tailoring', 'Cooking', 'Fishing', 'First Aid'],
	// Engine's skillName: a skill goal's name through L when the client has no name for its
	// skill line (the professions above, and Riding).
	'Core/Engine.lua': ['Riding'],
	// ns.stage (Core/Init.lua), the chip beside the version (Theme/Widgets.lua).
	'Core/Init.lua': ['Beta'],
};

// The spec labels of Gear/Weights.lua (`label = "..."` in a spec row), shown through L[spec.label].
function specLabels(addonDir) {
	const file = path.join(addonDir, 'Gear', 'Weights.lua');
	if (!fs.existsSync(file)) return [];
	const out = [];
	const re = /\{\s*key\s*=\s*"[^"]+",\s*label\s*=\s*"((?:[^"\\]|\\.)*)"/g;
	let m;
	const src = fs.readFileSync(file, 'utf8');
	while ((m = re.exec(src))) out.push(m[1]);
	return out;
}

// The spec names of Talents/Builds.lua (`specs = { "...", ... }` per class), shown through
// L[...] (Talents.Register's specName).
function talentSpecs(addonDir) {
	const file = path.join(addonDir, 'Talents', 'Builds.lua');
	if (!fs.existsSync(file)) return [];
	const out = [];
	for (const m of fs.readFileSync(file, 'utf8').matchAll(/\bspecs\s*=\s*\{([^}]*)\}/g)) {
		for (const s of m[1].matchAll(/"((?:[^"\\]|\\.)*)"/g)) out.push(s[1]);
	}
	return out;
}

// The attunement table's notes (tools/lib/codex/attunements.json `note`),
// shown through L[a.note] on the Dungeons Attunement tab and in its guide.
function attunementNotes(addonDir) {
	const file = path.join(__dirname, '..', 'codex', 'attunements.json');
	if (!fs.existsSync(path.join(addonDir, 'Dungeons', 'Attune.lua')) || !fs.existsSync(file)) return [];
	const doc = JSON.parse(fs.readFileSync(file, 'utf8'));
	return [...new Set((doc.attunements || []).map((a) => a.note).filter((n) => typeof n === 'string' && n !== ''))];
}

function luaFiles(dir, skip) {
	const out = [];
	const walk = (abs) => {
		for (const d of fs.readdirSync(abs, { withFileTypes: true }).sort((a, b) => (a.name < b.name ? -1 : a.name > b.name ? 1 : 0))) {
			const p = path.join(abs, d.name);
			if (d.isDirectory()) {
				if (!skip(p)) walk(p);
			} else if (d.name.endsWith('.lua')) out.push(p);
		}
	};
	walk(dir);
	return out;
}

// The order addon/Polestar loads its files (TOC, XML manifests): keys group
// by the file that first uses them, in that order. A folder without a TOC
// (a test's) is read in name order.
function loadOrder(addonDir) {
	const toc = path.join(addonDir, `${path.basename(addonDir)}.toc`);
	return fs.existsSync(toc) ? dirFiles(addonDir) : [];
}

// -> Map key -> [{ file, line }] (file relative to addonDir), in load order.
function extractKeys(addonDir) {
	const locales = path.join(addonDir, 'Locales');
	const all = luaFiles(addonDir, (p) => p === locales);
	const order = loadOrder(addonDir).filter((f) => all.includes(f));
	const files = [...order, ...all.filter((f) => !order.includes(f))];
	const keys = new Map();
	const add = (key, where) => {
		if (!keys.has(key)) keys.set(key, []);
		keys.get(key).push(where);
	};
	for (const f of files) {
		const rel = path.relative(addonDir, f).split(path.sep).join('/');
		for (const { key, line } of keysInSource(fs.readFileSync(f, 'utf8'), rel)) add(key, { file: rel, line });
	}
	for (const [file, list] of Object.entries(DATA_KEYS)) {
		if (!fs.existsSync(path.join(addonDir, file))) continue;
		for (const key of list) add(key, { file, line: 0, data: true });
	}
	for (const key of specLabels(addonDir)) add(key, { file: 'Gear/Weights.lua', line: 0, data: true });
	for (const key of talentSpecs(addonDir)) add(key, { file: 'Talents/Builds.lua', line: 0, data: true });
	for (const key of attunementNotes(addonDir)) add(key, { file: 'Dungeons/Attune.lua', line: 0, data: true });
	return keys;
}

module.exports = { tokenize, keysInSource, extractKeys, unescapeLua, DATA_KEYS };
