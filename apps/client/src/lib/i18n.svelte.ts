// The client in the player's language. Every text the window shows is written
// in US English where it is used, through t() (or tn() for a count, msg() for
// a text kept in a table and translated where it is shown), and that English
// is the key into src/locales/<locale>.json: one file per language, shared
// with the backend (src-tauri/src/i18n.rs). A text a file leaves out or has
// as "" shows in English. `pnpm i18n` adds new texts to every file and prints
// how much of each is translated; tests/client-i18n.test.js checks the files.
//
// The language is Settings > Language: Automatic (the system's, from
// navigator.languages) or one of LANGUAGES; settings.json keeps the choice.

import { detect, LANGUAGES, type Locale } from './languages';

export { LANGUAGES, type LanguageChoice, type Locale } from './languages';

/** A catalog: per English text, its translation, or for a plural (keyed by its English
 * `other`) the forms by plural category. `@meta` says who made it. */
export interface Catalog {
	'@meta'?: Meta;
	[key: string]: string | Partial<Record<Intl.LDMLPluralRule, string>> | Meta | undefined;
}
export interface Meta {
	/** The language in English. */
	language: string;
	/** 'ai': made by a machine and not yet read by a native speaker; 'reviewed': checked by one. */
	status: 'ai' | 'reviewed';
	translators: string[];
}

export type Params = Record<string, string | number>;

const files = import.meta.glob<Catalog>('../locales/*.json', { import: 'default' });

let current = $state<Locale>('enUS');
let catalog = $state.raw<Catalog>({});
let numbers = new Intl.NumberFormat('en-US');
let plurals = new Intl.PluralRules('en-US');

/** The language on screen. */
export function locale(): Locale {
	return current;
}

/** The BCP 47 tag of the language on screen, for Intl. */
export function tag(): string {
	return LANGUAGES.find((l) => l.code === current)?.tag ?? 'en-US';
}

/** Who made the translation on screen; null for English. */
export function meta(): Meta | null {
	return current === 'enUS' ? null : (catalog['@meta'] ?? null);
}

/** The language a choice means on this system. */
export function resolve(choice: string | null | undefined): Locale {
	const known = LANGUAGES.find((l) => l.code === choice);
	return known ? known.code : detect(navigator.languages ?? [navigator.language]);
}

/** Puts `code` on screen (English when its file can't be loaded). */
export async function show(code: Locale): Promise<void> {
	let next: Catalog = {};
	if (code !== 'enUS') {
		try {
			next = await files[`../locales/${code}.json`]();
		} catch (e) {
			console.error(`The ${code} translations could not be loaded`, e);
			code = 'enUS';
		}
	}
	const t = LANGUAGES.find((l) => l.code === code)?.tag ?? 'en-US';
	numbers = new Intl.NumberFormat(t);
	plurals = new Intl.PluralRules(t);
	catalog = next;
	current = code;
	document.documentElement.lang = t;
}

function fill(text: string, params?: Params): string {
	if (!params) return text;
	return text.replace(/\{(\w+)\}/g, (whole, name: string) => {
		const v = params[name];
		return v === undefined ? whole : typeof v === 'number' ? numbers.format(v) : v;
	});
}

/** `key` (US English, with `{name}` placeholders) in the language on screen. Numbers among the
 * params are written the language's way (1,234 / 1.234 / 1 234). */
export function t(key: string, params?: Params): string {
	const v = catalog[key];
	return fill(typeof v === 'string' && v ? v : key, params);
}

/** The form for `count` of a text that counts something: `tn('{count} file', '{count} files', n)`.
 * The catalog keys it by the English `other`, with a form per plural category of the language
 * (Russian one/few/many, Chinese and Korean only other). */
export function tn(one: string, other: string, count: number, params?: Params): string {
	const forms = catalog[other];
	let text = count === 1 ? one : other;
	if (forms && typeof forms === 'object') {
		const f = forms as Record<string, string | undefined>;
		text = f[plurals.select(count)] || f.other || text;
	}
	return fill(text, { count, ...params });
}

/** Marks a text kept in a table (shown later through t(key)) so `pnpm i18n` finds it. */
export function msg<T extends string>(key: T): T {
	return key;
}

/** `key` cut at its placeholders, for a sentence with something live in it (a link, a
 * button): `{#each parts(t('See {link}.'), ['link']) ...}`. Names in `slots` come back as
 * `{ slot }`, the rest as text. */
export function parts(text: string, slots: string[]): ({ text: string; slot?: undefined } | { slot: string; text?: undefined })[] {
	const out: ({ text: string; slot?: undefined } | { slot: string; text?: undefined })[] = [];
	const re = new RegExp(`\\{(${slots.join('|')})\\}`, 'g');
	let at = 0;
	for (const m of text.matchAll(re)) {
		if (m.index > at) out.push({ text: text.slice(at, m.index) });
		out.push({ slot: m[1] });
		at = m.index + m[0].length;
	}
	if (at < text.length) out.push({ text: text.slice(at) });
	return out;
}
