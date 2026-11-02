#!/usr/bin/env node
// Polestar Client's translations (src/lib/i18n.svelte.ts, src-tauri/src/i18n.rs).
//
//   pnpm i18n           adds every text the code gained to each src/locales/<locale>.json
//                       (as "", shown in English until translated), moves translations of
//                       texts the code lost to the file's "@unused", and prints the table
//   pnpm i18n status    prints the table (Markdown) without writing
//   pnpm i18n check     lists what is wrong with the files (tests/client-i18n.test.js runs it)
//
// The keys are the US English texts as the code writes them: t('…'), tn('…', '…', n) and
// msg('…') in src/, t!("…") and tn!("…", "…", n) in src-tauri/src/. A plural is keyed by its
// English `other` and holds a form per plural category of the language.

import { readdirSync, readFileSync, writeFileSync } from 'node:fs';
import { dirname, join, relative } from 'node:path';
import { fileURLToPath } from 'node:url';

export const ROOT = join(dirname(fileURLToPath(import.meta.url)), '..');
export const LOCALES_DIR = join(ROOT, 'src/locales');
/** The languages besides English, in file order; i18n.svelte.ts LANGUAGES and i18n.rs CATALOGS list the same. */
export const LOCALES = ['deDE', 'esES', 'esMX', 'frFR', 'koKR', 'ptBR', 'ruRU', 'zhCN', 'zhTW'];
const TAGS = { deDE: 'de-DE', esES: 'es-ES', esMX: 'es-MX', frFR: 'fr-FR', koKR: 'ko-KR', ptBR: 'pt-BR', ruRU: 'ru-RU', zhCN: 'zh-CN', zhTW: 'zh-TW' };
/** Files that name t() in their comments or speak only for the dev mock. */
const SKIP = new Set(['src/lib/i18n.svelte.ts', 'src/lib/mock.ts', 'src-tauri/src/i18n.rs']);

function walk(dir, exts, out = []) {
	for (const e of readdirSync(dir, { withFileTypes: true }).sort((a, b) => a.name.localeCompare(b.name))) {
		const p = join(dir, e.name);
		if (e.isDirectory()) walk(p, exts, out);
		else if (exts.some((x) => e.name.endsWith(x))) out.push(p);
	}
	return out;
}

/** Reads the string literal starting at `src[i]` (a quote): its value and where it ends, or null. */
function literal(src, i, rust) {
	const q = src[i];
	if (!(rust ? q === '"' : q === "'" || q === '"' || q === '`')) return null;
	let out = '';
	let j = i + 1;
	for (; j < src.length && src[j] !== q; j++) {
		const c = src[j];
		if (!rust && q === '`' && c === '$' && src[j + 1] === '{') return null;
		if (c !== '\\') {
			out += c;
			continue;
		}
		const n = src[++j];
		if (n === 'n') out += '\n';
		else if (n === 't') out += '\t';
		else if (n === 'r') out += '\r';
		else if (n === '0') out += '\0';
		else if (n === '\n' || (n === '\r' && src[j + 1] === '\n')) {
			// A line continuation: Rust drops the break and the next line's indent; JS only the break.
			if (n === '\r') j++;
			if (rust) while (/\s/.test(src[j + 1])) j++;
		} else if (n === 'u') {
			const m = src[j + 1] === '{' ? /^\{([0-9a-fA-F]+)\}/.exec(src.slice(j + 1)) : /^([0-9a-fA-F]{4})/.exec(src.slice(j + 1));
			if (!m) return null;
			out += String.fromCodePoint(parseInt(m[1], 16));
			j += m[0].length;
		} else if (n === 'x') {
			out += String.fromCharCode(parseInt(src.slice(j + 1, j + 3), 16));
			j += 2;
		} else out += n;
	}
	return j < src.length ? { value: out, end: j + 1 } : null;
}

/** The literals at the start of a call's arguments (`count` of them), or null when one isn't. */
function literals(src, i, count, rust) {
	const values = [];
	for (let k = 0; k < count; k++) {
		while (/\s/.test(src[i])) i++;
		const lit = literal(src, i, rust);
		if (!lit) return null;
		values.push(lit.value);
		i = lit.end;
		while (/\s/.test(src[i])) i++;
		if (k < count - 1) {
			if (src[i] !== ',') return null;
			i++;
		}
	}
	return values;
}

const lineOf = (src, i) => src.slice(0, i).split('\n').length;

/** Every text in the code: Map key → { plural: { one, other } | null, where: ['file:line', …] }. */
export function extract() {
	const keys = new Map();
	const problems = [];
	const add = (key, plural, where) => {
		const had = keys.get(key);
		if (!had) return keys.set(key, { plural, where: [where] });
		had.where.push(where);
		if (!!had.plural !== !!plural || (plural && had.plural.one !== plural.one)) problems.push(`${where}: "${key}" is used both as a text and as a plural, or with two singulars`);
	};
	const files = [...walk(join(ROOT, 'src'), ['.svelte', '.ts']), ...walk(join(ROOT, 'src-tauri/src'), ['.rs'])];
	for (const file of files) {
		const rel = relative(ROOT, file).split('\\').join('/');
		if (SKIP.has(rel)) continue;
		const rust = file.endsWith('.rs');
		const src = readFileSync(file, 'utf8');
		const re = rust ? /(?<![\w:])(tn?)!\(/g : /(?<![\w$.])(tn?|msg)\(/g;
		for (const m of src.matchAll(re)) {
			const at = m.index + m[0].length;
			const where = `${rel}:${lineOf(src, m.index)}`;
			if (m[1] === 'tn') {
				const v = literals(src, at, 2, rust);
				if (v) add(v[1], { one: v[0], other: v[1] }, where);
				else problems.push(`${where}: tn needs its two texts written out as string literals`);
			} else {
				const v = literals(src, at, 1, rust);
				if (v) add(v[0], null, where);
				else if (rust || m[1] === 'msg') problems.push(`${where}: ${m[1]} needs its text written out as a string literal`);
			}
		}
	}
	return { keys, problems };
}

/** The plural categories a language's catalog must give, and those it may. */
export function categories(locale) {
	const may = new Intl.PluralRules(TAGS[locale]).resolvedOptions().pluralCategories;
	const must = locale.startsWith('ru') ? ['one', 'few', 'many', 'other'] : locale.startsWith('ko') || locale.startsWith('zh') ? ['other'] : ['one', 'other'];
	return { must, may };
}

const placeholders = (s) => [...new Set([...s.matchAll(/\{(\w+)\}/g)].map((m) => m[1]))].sort().join(',');

export const file = (locale) => join(LOCALES_DIR, `${locale}.json`);
export const load = (locale) => JSON.parse(readFileSync(file(locale), 'utf8'));

/** Every problem with the catalogs: a key the code doesn't have, a placeholder that differs, a
 * plural's forms, the @meta block. */
export function check() {
	const { keys, problems } = extract();
	const present = readdirSync(LOCALES_DIR).filter((f) => f.endsWith('.json')).map((f) => f.slice(0, -5)).sort();
	if (present.join() !== LOCALES.join()) problems.push(`src/locales has ${present.join(', ')}; expected ${LOCALES.join(', ')}`);
	for (const locale of LOCALES) {
		let cat;
		try {
			cat = load(locale);
		} catch (e) {
			problems.push(`${locale}.json: ${e.message}`);
			continue;
		}
		const meta = cat['@meta'];
		if (!meta || typeof meta.language !== 'string' || !['ai', 'reviewed'].includes(meta.status) || !Array.isArray(meta.translators)) problems.push(`${locale}.json: "@meta" needs language, status ("ai" or "reviewed") and translators`);
		else if (meta.status === 'reviewed' && meta.translators.length === 0) problems.push(`${locale}.json: a reviewed language names its translators`);
		const { must, may } = categories(locale);
		// German and Spanish `one` is only 1, so it may say "eine"/"un" instead of {count}.
		const oneIsOne = ['deDE', 'esES', 'esMX'].includes(locale);
		for (const [key, value] of Object.entries(cat)) {
			if (key === '@meta' || key === '@unused') continue;
			const english = keys.get(key);
			if (!english) {
				problems.push(`${locale}.json: "${key}" is not in the code (pnpm i18n moves it to "@unused")`);
				continue;
			}
			if (english.plural) {
				if (!value || typeof value !== 'object' || Array.isArray(value)) {
					problems.push(`${locale}.json: "${key}" is a plural: give its forms (${must.join(', ')})`);
					continue;
				}
				const want = placeholders(english.plural.other);
				const filled = Object.values(value).some((v) => v);
				for (const c of must) if (filled && !value[c]) problems.push(`${locale}.json: "${key}" lacks its "${c}" form`);
				for (const [c, form] of Object.entries(value)) {
					if (!may.includes(c)) problems.push(`${locale}.json: "${key}" has a "${c}" form the language has no use for (${may.join(', ')})`);
					else if (typeof form !== 'string') problems.push(`${locale}.json: "${key}" form "${c}" is not text`);
					else if (form && placeholders(form) !== want && !(oneIsOne && c === 'one' && placeholders(form) === placeholders(english.plural.other.replaceAll('{count}', ''))))
						problems.push(`${locale}.json: "${key}" form "${c}" has {${placeholders(form)}}, the English {${want}}`);
				}
			} else if (typeof value !== 'string') {
				problems.push(`${locale}.json: "${key}" is a text, not a plural`);
			} else if (value && placeholders(value) !== placeholders(key)) {
				problems.push(`${locale}.json: "${key}" has {${placeholders(value)}}, the English {${placeholders(key)}}`);
			}
		}
	}
	return problems;
}

const translated = (v) => (typeof v === 'string' ? v !== '' : !!v && typeof v === 'object' && Object.values(v).some((f) => f));

/** Per language: how many of the code's texts it translates. */
export function counts() {
	const { keys } = extract();
	return LOCALES.map((locale) => {
		const cat = load(locale);
		const done = [...keys.keys()].filter((k) => translated(cat[k])).length;
		return { locale, meta: cat['@meta'], done, total: keys.size };
	});
}

export function status() {
	const lines = ['| Language | Code | Status | Translated | Translators |', '|---|---|---|---|---|'];
	for (const { locale, meta, done, total } of counts()) {
		const pct = Math.floor((done / total) * 100);
		lines.push(`| ${meta.language} | ${locale} | ${meta.status} | ${done} / ${total} (${pct}%) | ${meta.translators.join(', ') || '-'} |`);
	}
	return lines.join('\n');
}

/** Writes every catalog with the code's keys in the code's order. */
export function sync() {
	const { keys } = extract();
	for (const locale of LOCALES) {
		let cat = {};
		try {
			cat = load(locale);
		} catch {}
		const { must } = categories(locale);
		const out = { '@meta': cat['@meta'] ?? { language: locale, status: 'ai', translators: [] } };
		const unused = { ...(cat['@unused'] ?? {}) };
		for (const [key, { plural }] of keys) {
			const had = cat[key] ?? unused[key];
			delete unused[key];
			if (plural) out[key] = had && typeof had === 'object' ? had : Object.fromEntries(must.map((c) => [c, '']));
			else out[key] = typeof had === 'string' ? had : '';
		}
		for (const [key, value] of Object.entries(cat)) if (key !== '@meta' && key !== '@unused' && !keys.has(key) && translated(value)) unused[key] = value;
		if (Object.keys(unused).length) out['@unused'] = unused;
		writeFileSync(file(locale), JSON.stringify(out, null, '\t') + '\n');
	}
}

if (process.argv[1] && fileURLToPath(import.meta.url) === process.argv[1]) {
	const cmd = process.argv[2] ?? 'sync';
	if (cmd === 'check') {
		const problems = check();
		for (const p of problems) console.log(p);
		process.exitCode = problems.length ? 1 : 0;
	} else if (cmd === 'status') {
		console.log(status());
	} else if (cmd === 'sync') {
		const { problems } = extract();
		for (const p of problems) console.log(p);
		sync();
		console.log(status());
	} else {
		console.error('usage: pnpm i18n [sync|status|check]');
		process.exitCode = 2;
	}
}
