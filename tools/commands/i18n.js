'use strict';
// i18n: Polestar's translations (docs/TRANSLATING.md). `i18n fit` (it needs
// the preview renderer, tools/preview) runs here; every other subcommand is
// `forge i18n` (rust/crates/forge-i18n), and `names` is `forge data names`.
// Adapted from Ding! by Yendi (@moust4ki), GPL-3.0:
// https://github.com/moust4ki/DingGuideWoWForever

const fs = require('node:fs');
const path = require('node:path');
const { parseArgs, plural } = require('../lib/cli');
const { LOCALE_CODES, checkLocale } = require('../lib/i18n/locales');

// The subcommands Forge runs now.
const RETIRED = ['status', 'check', 'sync', 'keys', 'import', 'leaks', 'guides'];

const usage = `usage: node tools/polestar.js i18n fit [options]

Polestar's translations (docs/TRANSLATING.md). status, check, sync, keys,
import, leaks and guides are forge i18n (forge i18n --help); names
is forge data names. Locales:
${LOCALE_CODES.join(', ')}.

  i18n fit [<locale>[=<file>]...]
                             lays out every preview scene and every Options
                             page and tab in English and in each locale (or
                             those named; <file> stands in for the shipped
                             file, such as a pull request's), in the game
                             font and in Inter, and lists the text the
                             window cuts with an ellipsis, cuts after its
                             last line or lets cross its edge. Text cut the
                             same way in English (a long guide or item name)
                             is left out. Fails (exit 1) when a locale has
                             any. CJK is measured 1em wide.

options:
  --json            one JSON document on stdout
  --slack <n>       measure every glyph n times wider (1.15: about the
                    client's own font)`;

// Every locale (or those named, each with the file standing in for its
// shipped one) laid out in every preview scene and Options page: the
// translated text that does not fit (tools/preview/fit.js).
async function runFit(opts, positional) {
	const { fitLocales, describe } = require('../preview/fit');
	const slack = opts.slack === undefined ? 1 : Number(opts.slack);
	if (!(slack > 0)) throw new Error(`--slack ${opts.slack}: a number above 0`);
	const targets = (positional.length ? positional : LOCALE_CODES).map((a) => {
		const [locale, file] = a.split('=');
		checkLocale(locale);
		if (file && !fs.existsSync(file)) throw new Error(`${file}: no such file`);
		return { locale, file: file ? path.resolve(file) : null };
	});
	const results = await fitLocales(targets, { slack });
	const failed = results.some((r) => r.translated.length);
	if (opts.json) {
		console.log(JSON.stringify(results, null, 1));
		return failed ? 1 : 0;
	}
	const where = (f) => {
		const places = [...new Set(f.places)];
		return `      in ${places.slice(0, 2).join('; ')}${places.length > 2 ? ` and ${places.length - 2} more` : ''}`;
	};
	const english = results[0].found;
	console.log(`English: ${plural(english.length, 'string')} cut in every language alike (left out below)`);
	for (const f of english) console.log(`  ${describe(f)}`);
	for (const r of results.slice(1)) {
		console.log(`${r.locale}${r.file ? ` (${path.relative(process.cwd(), r.file)})` : ''}: ${r.translated.length ? `${plural(r.translated.length, 'string')} that do not fit` : 'everything fits'}`);
		for (const f of r.translated) console.log(`  ${describe(f)}\n${where(f)}`);
	}
	return failed ? 1 : 0;
}

async function run(argv) {
	const { opts, positional, error } = parseArgs(argv, {
		flags: ['--json', '--no-questie', '--no-tables', '--offline'],
		options: ['--ding', '--pfquest', '--guides', '--questdb', '--codex', '--travel', '--chokepoints', '--out', '--build', '--sources', '--slack'],
	});
	const [sub, ...rest] = positional;
	if (sub === 'names') {
		console.error('polestar i18n names was retired: forge data names [<locale>...] (docs/forge/data.md)');
		return 2;
	}
	if (RETIRED.includes(sub)) {
		console.error(`polestar i18n ${sub} was retired: forge i18n ${sub} (forge i18n --help)`);
		return 2;
	}
	if (error || !sub) {
		console.error(`${error || 'i18n needs a subcommand'}\n\n${usage}`);
		return 2;
	}
	try {
		if (sub === 'fit') return await runFit(opts, rest);
	} catch (e) {
		console.error(`error: ${e.message}`);
		return 1;
	}
	console.error(`unknown i18n subcommand "${sub}"\n\n${usage}`);
	return 2;
}

module.exports = { name: 'i18n', summary: 'translated text that does not fit (fit); the rest is forge i18n, names is forge data names', usage, run };
