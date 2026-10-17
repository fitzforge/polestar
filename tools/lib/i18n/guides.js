'use strict';
// A guide pack's texts in other languages (docs/TRANSLATING.md, "Guide
// texts"): one file per guide and language, <pack>/locales/<locale>/<guide
// path>.lua, plus <pack>/locales/<locale>/_pack.lua for the pack's own texts
// (its title and notes, its guides' folders). Each file returns a table that
// maps the English, with its name tokens (tools/lib/dsl/tokens.js), to the
// translation:
//
//   return {
//   	-- Step 1: Sentinel Hill
//   	-- {npc:234} Gryan Stoutmantle · {npc:821} Captain Danuvin
//   	["{npc:234} and {npc:821} stand at the top of the stone tower."] = "",
//   }
//
// "" is not translated yet: the English shows. `i18n guides sync` writes the
// files whole, in reading order, keeping every translation; one whose English
// the guide no longer has goes, commented out, to a block at the end. The
// compiler (project.js buildPackFiles) puts each language's translations into
// the pack's texts addon for it, <folder>_<locale>. Adapted from Ding! by
// Yendi (@moust4ki), GPL-3.0: https://github.com/moust4ki/DingGuideWoWForever

const fs = require('node:fs');
const path = require('node:path');
const { luaString, readLocaleFiles } = require('./files');
const { LOCALES } = require('./locales');
const { forEachText, onlyTokens, tokensOf, fillTokens, TOKEN_RE, KINDS } = require('../dsl/tokens');

const PACK_FILE = '_pack.lua';
const RETIRED = '-- No longer in the guide (its English changed or it went away): reuse or delete.';

function rel(file) {
	const r = path.relative(process.cwd(), file);
	return r.startsWith('..') ? file : r.split(path.sep).join('/');
}

// A compiled guide's texts that need words, each once, in reading order:
// [{ text, where, tokens: [[token, English]], plurals: [[token, English]]
// (names the text has in the English plural, left as words) }]. `guide` is the compiled
// guide; its `_localised` copy (project.js) holds the tokens.
function guideTexts(guide) {
	const g = guide._localised || guide;
	const out = [];
	const seen = new Set();
	forEachText(g, (text, holder, key, level, si) => {
		if (seen.has(text) || onlyTokens(text)) return;
		seen.add(text);
		const step = si === null ? null : g.steps[si];
		const where = si === null ? 'Guide' : `Step ${si + 1}${step.title ? `: ${fillTokens(step.title, g.names)}` : ''}`;
		const tokens = [...new Set(tokensOf(text))].map((t) => [t, (g.names && g.names[t]) || '?']);
		const plurals = [];
		for (const p of (g._plurals && g._plurals.get(text)) || []) if (!plurals.some((x) => x[0] === `${p.kind}:${p.id}`)) plurals.push([`${p.kind}:${p.id}`, p.name]);
		out.push({ text, where, tokens, plurals });
	});
	return out;
}

// The classes of the game: LOCALIZED_CLASS_NAMES_MALE names them on every client.
const CLASSES = new Set(['Warrior', 'Paladin', 'Hunter', 'Rogue', 'Priest', 'Shaman', 'Mage', 'Warlock', 'Druid']);

// The pack's own texts: its title and notes, then its guides' folders.
function packTexts(manifest, guides) {
	const out = [];
	const seen = new Set();
	const add = (text, where) => {
		if (typeof text !== 'string' || !text.trim() || seen.has(text)) return;
		seen.add(text);
		out.push({ text, where, tokens: [], plurals: [] });
	};
	add(manifest.title, 'Pack');
	add(manifest.notes, 'Pack');
	// A folder named after a class shows the client's class name (Core/GuideTexts.lua).
	for (const f of [...new Set(guides.map((g) => g.folder).filter(Boolean))].sort()) if (!CLASSES.has(f)) add(f, 'Folders');
	return out;
}

function localeDir(packDir, locale) {
	return path.join(packDir, 'locales', locale);
}

function guideFile(packDir, locale, source) {
	return path.join(localeDir(packDir, locale), source.replace(/\.guide$/, '.lua'));
}

// Every .lua under dir, relative and with / separators.
function luaFiles(dir, prefix = '') {
	if (!fs.existsSync(dir)) return [];
	const out = [];
	for (const e of fs.readdirSync(dir, { withFileTypes: true })) {
		const r = prefix ? `${prefix}/${e.name}` : e.name;
		if (e.isDirectory()) out.push(...luaFiles(path.join(dir, e.name), r));
		else if (e.isFile() && e.name.endsWith('.lua')) out.push(r);
	}
	return out.sort();
}

// The languages the pack has a folder for under locales/, known ones only.
function packLocales(packDir) {
	const dir = path.join(packDir, 'locales');
	if (!fs.existsSync(dir)) return [];
	return fs
		.readdirSync(dir, { withFileTypes: true })
		.filter((d) => d.isDirectory() && LOCALES[d.name])
		.map((d) => d.name)
		.sort();
}

const TOKEN_ONLY = new RegExp(TOKEN_RE.source, 'g');
const NAMES_ROOT = path.join(__dirname, '..', '..', '..', 'addon');

// The object ids Polestar's names addon of `locale`
// (addon/Polestar_Names_<locale>/Names.lua, `i18n names`) names, or null
// when it has none, cached.
const NAMED_OBJECTS = new Map();
function namedObjects(locale) {
	if (!NAMED_OBJECTS.has(locale)) {
		const file = path.join(NAMES_ROOT, `Polestar_Names_${locale}`, 'Names.lua');
		let ids = null;
		if (fs.existsSync(file)) {
			ids = new Set();
			const re = /add\("[A-Za-z]+", "object", \{([\s\S]*?)\n\}\)/g;
			const text = fs.readFileSync(file, 'utf8');
			for (let m = re.exec(text); m; m = re.exec(text)) for (const e of m[1].matchAll(/\[(\d+)\]=/g)) ids.add(`object:${e[1]}`);
		}
		NAMED_OBJECTS.set(locale, ids);
	}
	return NAMED_OBJECTS.get(locale);
}

// The tokens of `english` a translation into `locale` may write as words: the
// objects no source names in that language (a district's sign, a tavern),
// which the game would show in English.
function unnamedTokens(english, locale) {
	const named = namedObjects(locale);
	if (!named) return [];
	return [...new Set(tokensOf(english))].filter((t) => t.startsWith('object:') && !named.has(t));
}

// What is wrong with `translation` as the translation of `english`: [message].
// `plurals`: tokens the English names in the plural, as words (its
// "plural, as words" comment): the translation may use them as it likes.
// `unnamed`: tokens it may leave out, written as words (unnamedTokens).
function textProblems(english, translation, plurals = [], unnamed = []) {
	const out = [];
	const free = new Set(plurals);
	const loose = new Set(unnamed);
	const want = tokensOf(english).sort();
	const got = tokensOf(translation).filter((t) => !free.has(t) || want.includes(t)).sort();
	const missing = want.filter((t, i) => want.indexOf(t) === i && !loose.has(t) && got.filter((x) => x === t).length < want.filter((x) => x === t).length);
	const extra = got.filter((t, i) => got.indexOf(t) === i && want.filter((x) => x === t).length < got.filter((x) => x === t).length);
	if (missing.length) out.push(`leaves out ${missing.map((t) => `{${t}}`).join(', ')}`);
	if (extra.length) out.push(`has ${extra.map((t) => `{${t}}`).join(', ')}, which the English has ${extra.length > 1 ? 'fewer times or not at all' : 'fewer times or not at all'}`);
	const stray = translation.replace(TOKEN_ONLY, '');
	if (/[{}]/.test(stray)) out.push(`has a { or } outside a name token ({kind:id}, kind one of ${KINDS.join(' ')})`);
	if ((english.match(/\n/g) || []).length !== (translation.match(/\n/g) || []).length) out.push('has a different number of line breaks (\\n) than the English');
	return out;
}

// The commented translations a file's retired block holds, so a second sync
// keeps them: { english: translation }.
function retiredEntries(text) {
	const at = text.indexOf(RETIRED);
	if (at < 0) return {};
	const out = {};
	const re = /^\s*-- \[("(?:[^"\\]|\\.)*")\] = ("(?:[^"\\]|\\.)*"),\s*$/gm;
	re.lastIndex = at;
	const unq = (s) => JSON.parse(s.replace(/\\(\d{1,3})/g, (_, d) => `\\u${Number(d).toString(16).padStart(4, '0')}`).replace(/\\'/g, "'"));
	let m;
	while ((m = re.exec(text))) {
		try {
			const v = unq(m[2]);
			if (v !== '') out[unq(m[1])] = v;
		} catch {
			// a line edited by hand that no longer parses: left out
		}
	}
	return out;
}

// Words of the closest current text with the same tokens, for a stale entry:
// the likely new English of a changed text, or null.
function successor(stale, texts, taken) {
	const words = (s) => new Set(s.replace(TOKEN_RE, ' ').toLowerCase().split(/[^\p{L}\p{N}']+/u).filter(Boolean));
	const a = words(stale);
	const tok = tokensOf(stale).sort().join(' ');
	let best = null;
	let score = 0.5;
	for (const t of texts) {
		if (taken.has(t.text) || tokensOf(t.text).sort().join(' ') !== tok) continue;
		const b = words(t.text);
		let both = 0;
		for (const w of a) if (b.has(w)) both++;
		const s = both / (a.size + b.size - both || 1);
		if (s > score) {
			score = s;
			best = t.text;
		}
	}
	return best;
}

// guides: the pack's compiled guides with `_ast.source`. -> { [locale]: {
// files: [{ file, kind ('guide' | 'pack'), id, source, exists, error, texts,
// translated, missing, stale, retired, problems: [{ text, problem }],
// successors: { stale: new English } }], orphans: [file] } }
function guideState(packDir, manifest, guides, locales) {
	const out = {};
	const planned = [];
	for (const locale of locales) {
		planned.push({ locale, kind: 'pack', id: null, source: null, file: path.join(localeDir(packDir, locale), PACK_FILE), texts: packTexts(manifest, guides) });
		for (const g of guides) planned.push({ locale, kind: 'guide', id: g.id, source: g._ast.source, file: guideFile(packDir, locale, g._ast.source), texts: guideTexts(g) });
	}
	const existing = planned.filter((p) => fs.existsSync(p.file));
	const read = new Map(readLocaleFiles(existing.map((p) => ({ locale: p.locale, file: p.file }))).map((r) => [r.file, r]));
	for (const locale of locales) out[locale] = { files: [], orphans: [] };
	for (const p of planned) {
		const r = read.get(p.file);
		const s = { ...p, exists: !!r, error: null, translated: {}, missing: [], stale: {}, retired: {}, problems: [], successors: {} };
		if (r && !r.ok) s.error = r.error;
		else if (r && r.layout !== 'return') s.error = 'does not return a table of { ["English"] = "translation" }';
		else if (r) {
			const known = new Set(p.texts.map((t) => t.text));
			const byText = new Map(p.texts.map((t) => [t.text, t.plurals]));
			for (const k of r.bad) s.problems.push({ text: k, problem: 'the key or the value is not a string' });
			for (const [k, v] of Object.entries(r.strings)) {
				if (!known.has(k)) {
					if (v !== '') s.stale[k] = v;
					continue;
				}
				if (v === '') continue;
				s.translated[k] = v;
				for (const problem of textProblems(k, v, (byText.get(k) || []).map(([t]) => t), p.kind === 'guide' ? unnamedTokens(k, p.locale) : [])) s.problems.push({ text: k, problem });
			}
			s.retired = retiredEntries(fs.readFileSync(p.file, 'utf8'));
			const taken = new Set(Object.keys(s.translated));
			for (const k of Object.keys(s.stale)) {
				const next = successor(k, p.texts, taken);
				if (next) s.successors[k] = next;
			}
		}
		for (const t of p.texts) if (!(t.text in s.translated)) s.missing.push(t.text);
		out[p.locale].files.push(s);
	}
	for (const locale of locales) {
		const want = new Set(out[locale].files.map((f) => path.relative(localeDir(packDir, locale), f.file).split(path.sep).join('/')));
		out[locale].orphans = luaFiles(localeDir(packDir, locale))
			.filter((f) => !want.has(f))
			.map((f) => path.join(localeDir(packDir, locale), f));
	}
	return out;
}

// `unnamed`: tokens no source names in the file's language (unnamedTokens).
function tokenLine(tokens, unnamed = new Set()) {
	return `\t-- ${tokens.map(([t, en]) => `{${t}} ${en}${unnamed.has(t) ? ' (no name in this language: may be words)' : ''}`).join(' · ')}`;
}

// A texts file whole: header, every text in reading order (translated or
// ""), then the retired block.
function writeTextsFile({ locale, kind, id, source, texts, translated, retired }) {
	const lang = (LOCALES[locale] && LOCALES[locale].language) || locale;
	const what = kind === 'pack' ? "the pack's own texts (its title and notes, its guides' folders)" : `the guide ${id} (${source})`;
	const lines = [
		`-- ${lang} (${locale}): ${what}.`,
		`-- Written by \`node tools/polestar.js i18n guides sync ${locale}\`, which keeps every translation (docs/TRANSLATING.md, "Guide texts").`,
		'-- Translate the right-hand sides; "" shows the English. Keep each {kind:id} as it is: the game shows its',
		`-- name there in ${lang} (the English is listed above the line). A name the English has in the plural, as words,`,
		'-- may be written with the singular\'s token from its "plural, as words" line: "Bandidos ({npc:251918})", "{npc:251918} ×8".',
		`-- A token marked "no name in this language" would show in English: write that name in ${lang} words instead.`,
		'-- The comments are rewritten by sync.',
		'return {',
	];
	let where = null;
	for (const t of texts) {
		if (t.where !== where) {
			if (where !== null) lines.push('');
			lines.push(`\t-- ${t.where.replace(/[\r\n]+/g, ' ')}`);
			where = t.where;
		}
		if (t.tokens.length) lines.push(tokenLine(t.tokens, new Set(kind === 'guide' ? unnamedTokens(t.text, locale) : [])));
		if (t.plurals.length) lines.push(`\t-- plural, as words: ${t.plurals.map(([tok, en]) => `${en}s = {${tok}} ${en}`).join(' · ')}`);
		lines.push(`\t[${luaString(t.text)}] = ${luaString(translated[t.text] || '')},`);
	}
	const old = Object.keys(retired).sort();
	if (old.length) {
		lines.push('', `\t${RETIRED}`);
		for (const k of old) lines.push(`\t-- [${luaString(k)}] = ${luaString(retired[k])},`);
	}
	lines.push('}', '');
	return lines.join('\n');
}

// The files sync writes, { file: text }: each of `state`'s files that reads
// (one Lua cannot load is left alone), translations of texts gone moved to
// the retired block.
function syncFiles(state) {
	const files = {};
	for (const s of Object.values(state).flatMap((l) => l.files)) {
		if (s.error) continue;
		files[s.file] = writeTextsFile({ ...s, retired: { ...s.retired, ...s.stale } });
	}
	return files;
}

// Translations for the compiler: { [locale]: { pack: {}, guides: { [id]: {} } } }
// with only well-formed translations of texts the pack has, and warnings
// ({ file, message }) for every problem, stale entry and orphan file.
function packTranslations(packDir, manifest, guides) {
	const locales = packLocales(packDir);
	if (!locales.length) return { translations: {}, warnings: [] };
	const state = guideState(packDir, manifest, guides.filter((g) => g._ast && g._ast.source), locales);
	const translations = {};
	const warnings = [];
	for (const locale of locales) {
		const into = { pack: {}, guides: {} };
		for (const s of state[locale].files) {
			const file = rel(s.file);
			if (s.error) warnings.push({ file, message: `not read: ${s.error}` });
			const bad = new Set(s.problems.map((p) => p.text));
			for (const p of s.problems) warnings.push({ file, message: `${JSON.stringify(p.text)}: the translation ${p.problem}; it is left out, the English shows` });
			for (const k of Object.keys(s.stale)) {
				const next = s.successors[k];
				warnings.push({
					file,
					message: `stale translation of ${JSON.stringify(k)}: ${next ? `its English changed to ${JSON.stringify(next)}` : 'the guide no longer has that text'}; \`node tools/polestar.js i18n guides sync ${locale}\` moves it to the end`,
				});
			}
			const ok = Object.fromEntries(Object.entries(s.translated).filter(([k]) => !bad.has(k)));
			if (!Object.keys(ok).length) continue;
			if (s.kind === 'pack') into.pack = ok;
			else into.guides[s.id] = ok;
		}
		for (const f of state[locale].orphans) warnings.push({ file: rel(f), message: 'no guide of the pack has this path (renamed or removed?)' });
		if (Object.keys(into.pack).length || Object.keys(into.guides).length) translations[locale] = into;
	}
	return { translations, warnings };
}

// The translation wave's size: the texts that need words, unique per
// language, with their words and characters (tokens left out), in all and
// by guide folder (the .guide's directory).
function textStats(manifest, guides) {
	const total = { texts: 0, words: 0, chars: 0 };
	const byFolder = {};
	const seen = new Set();
	const count = (into, text) => {
		const plain = text.replace(TOKEN_RE, '');
		into.texts++;
		into.words += plain.split(/\s+/).filter((w) => /\p{L}/u.test(w)).length;
		into.chars += [...plain].length;
	};
	const add = (folder, text) => {
		if (seen.has(text)) return;
		seen.add(text);
		count(total, text);
		count((byFolder[folder] ||= { guides: 0, texts: 0, words: 0, chars: 0 }), text);
	};
	for (const t of packTexts(manifest, guides)) add('(pack)', t.text);
	for (const g of guides) {
		const folder = path.posix.dirname(g._ast.source);
		(byFolder[folder] ||= { guides: 0, texts: 0, words: 0, chars: 0 }).guides++;
		for (const t of guideTexts(g)) add(folder, t.text);
	}
	return { total, byFolder };
}

module.exports = { PACK_FILE, RETIRED, guideTexts, packTexts, guideFile, localeDir, packLocales, textProblems, guideState, writeTextsFile, syncFiles, packTranslations, textStats };
