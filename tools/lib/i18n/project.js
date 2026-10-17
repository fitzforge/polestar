'use strict';
// The state of every interface translation (addon/Polestar/Locales), per
// locale: translated, missing, stale and broken entries and glossary
// warnings; and the files `i18n sync` writes. Adapted from Ding! by Yendi
// (@moust4ki), GPL-3.0: https://github.com/moust4ki/DingGuideWoWForever

const fs = require('node:fs');
const path = require('node:path');
const { extractKeys } = require('./keys');
const { formatProblems } = require('./check');
const { readGlossary, glossaryWarnings } = require('./glossary');
const { localeFile, readLocaleFiles, updateLocaleText, newLocaleText } = require('./files');

function rel(file) {
	const r = path.relative(process.cwd(), file);
	return r.startsWith('..') ? file : r.split(path.sep).join('/');
}

// -> { keys, locales: { [locale]: { file, exists, error, translated, missing,
// stale, problems: [{ key, problem }], warnings: [{ key, value, id, term }] } } }
function localeState(addonDir, locales, { glossaryDir } = {}) {
	const keys = extractKeys(addonDir);
	const entries = locales.map((locale) => ({ locale, file: localeFile(addonDir, locale) })).filter((e) => fs.existsSync(e.file));
	const read = new Map(readLocaleFiles(entries).map((r, i) => [entries[i].locale, r]));
	const out = {};
	for (const locale of locales) {
		const file = localeFile(addonDir, locale);
		const r = read.get(locale);
		const s = { file, exists: !!r, error: r && !r.ok ? r.error : null, translated: {}, missing: [], stale: {}, problems: [], warnings: [] };
		if (r && r.ok && r.layout !== 'L') s.error = `written as ${r.layout === 'return' ? 'a returned table' : 'ns.AddTranslations(...)'}, not as L["..."] = "..." lines (docs/TRANSLATING.md; \`i18n import\` reads such files)`;
		if (r && r.ok && !s.error) {
			for (const k of r.bad) s.problems.push({ key: k, problem: 'the key or the value is not a string' });
			for (const k of r.twice) s.problems.push({ key: k, problem: 'set twice (the second wins); keep one line' });
			for (const [k, v] of Object.entries(r.strings)) {
				if (!keys.has(k)) {
					s.stale[k] = v;
					continue;
				}
				if (v === '') continue;
				s.translated[k] = v;
				for (const p of formatProblems(k, v)) s.problems.push({ key: k, problem: p });
			}
			s.warnings = glossaryWarnings(readGlossary(locale, glossaryDir), s.translated);
		}
		for (const k of keys.keys()) if (!(k in s.translated)) s.missing.push(k);
		out[locale] = s;
	}
	return { keys, locales: out };
}

// The files sync writes: { [file]: { text, added, retired, dropped, filled, kept } },
// for each locale that has a file and each locale in `create` that has none
// (headed "<language> (<locale>): <title>.").
// `fill` and `retire` ({ [locale]: { key: value } }) are updateLocaleText's.
// A locale whose file has an error is left out.
function syncFiles(state, { create = [], fill = {}, retire = {}, title } = {}) {
	const files = {};
	for (const [locale, s] of Object.entries(state.locales)) {
		if (s.error) continue;
		const opts = { keys: state.keys, fill: fill[locale] || {}, retire: retire[locale] || {} };
		if (s.exists) files[s.file] = updateLocaleText({ text: fs.readFileSync(s.file, 'utf8'), file: rel(s.file), ...opts });
		else if (create.includes(locale)) files[s.file] = newLocaleText({ locale, title, ...opts });
	}
	return files;
}

module.exports = { localeState, syncFiles, rel };
