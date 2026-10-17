'use strict';
// i18n: Polestar's interface translations (docs/TRANSLATING.md), the files
// addon/Polestar/Locales/<locale>.lua. Adapted from Ding! by Yendi
// (@moust4ki), GPL-3.0: https://github.com/moust4ki/DingGuideWoWForever

const fs = require('node:fs');
const path = require('node:path');
const { parseArgs, plural } = require('../lib/cli');
const { ROOT } = require('../lib/paths');
const { LOCALES, LOCALE_CODES, checkLocale } = require('../lib/i18n/locales');
const { localeState, syncFiles, rel } = require('../lib/i18n/project');

// The addons with interface translations, each with Locales/<locale>.lua:
// Polestar's own (loaded by Core/Core.xml) and the Recorder's (its TOC).
const ADDONS = {
	Polestar: { dir: path.join(ROOT, 'addon', 'Polestar'), title: "Polestar's interface strings" },
	Polestar_Recorder: { dir: path.join(ROOT, 'addon', 'Polestar_Recorder'), title: "Polestar Recorder's interface strings" },
};
const ADDON = ADDONS.Polestar.dir;

// --addon <name> -> that addon; else every addon, or Polestar's alone for
// the commands that read one (status, keys, import).
function addons(opts, { one = false } = {}) {
	if (opts.addon) {
		const a = ADDONS[opts.addon];
		if (!a) throw new Error(`unknown addon "${opts.addon}" (${Object.keys(ADDONS).join(', ')})`);
		return [a];
	}
	return one ? [ADDONS.Polestar] : Object.values(ADDONS);
}

// Words wrapped to 79 columns, every line indented `indent` spaces.
function wrapWords(text, indent) {
	const lines = [];
	let line = '';
	for (const w of text.split(' ')) {
		if (line && indent + line.length + 1 + w.length > 79) { lines.push(line); line = w; } else line = line ? `${line} ${w}` : w;
	}
	if (line) lines.push(line);
	return lines.map((l) => ' '.repeat(indent) + l).join('\n');
}

const usage = `usage: node tools/polestar.js i18n <status|check|sync|keys|import|fit|leaks|names|guides> [options]

Polestar's interface translations (docs/TRANSLATING.md): one file per
locale, addon/Polestar/Locales/<locale>.lua, and the same for the Recorder,
addon/Polestar_Recorder/Locales/<locale>.lua. Locales: ${LOCALE_CODES.join(', ')}.
check and sync read both addons; status, keys and import read Polestar's
unless --addon names the other.

  i18n status                per locale: its language, status (reviewed or
                             ai), translators, and how many keys it
                             translates. --markdown prints a table for the
                             README and release notes.
  i18n check [<locale>...]   fails (exit 1) on a file Lua cannot load, a
                             stale key (one the code no longer has), a key
                             set twice, or a translation whose %s/%d/%1$s,
                             |4one:many; or |c/|r/|T escapes differ from the
                             English. Warns where a translation leaves out its
                             glossary's word (tools/lib/i18n/glossary). Missing
                             translations are fine: the English shows.
  i18n sync [<locale>...]    adds the keys the code gained to each file as
                             -- L["English"] = "" lines under their file's
                             group, and moves translations of keys it lost to
                             a commented block at the end. Never rewrites a
                             translation. A locale named that has no file
                             gets one, loaded from Core/Core.xml (the
                             Recorder's TOC lists its own).
  i18n keys                  every interface key with where it is used.
  i18n import <locale> <file.lua>...
                             merges translations written apart (a file that
                             returns { ["English"] = "translation" }, sets
                             L["English"], or calls ns.AddTranslations) into
                             the locale's file: only into keys not translated
                             yet; a broken format is refused; keys the code
                             lacks go to the commented block at the end.
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
  i18n leaks [<locale>...]   runs the addon on the client stub in each locale
                             (or those named) with its shipped translations,
                             names pack and guide texts, the client's own
                             names as placeholders, through every scene (or
                             those --scene names), and lists the English left
                             on screen: a Latin word of 3+ letters in a text,
                             tooltip, chat line or menu that none of the
                             locale's own texts uses and
                             tools/lib/i18n/leaks-allow.json does not allow,
                             grouped by where it came from (an untranslated
                             interface string or guide text, a name missing
                             from the names pack, a name Polestar.Names was
                             not asked for, English in the code). Fails (exit
                             1) on any, or on a scene that errors. Scenes
                             (--scene; default all):
${wrapWords(require('../lib/i18n/leaks').SCENE_NAMES.join(', ') + '.', 29)}
  i18n names [<locale>...]   builds the names addons addon/Polestar_Names_<locale>:
                             the names of quests, NPCs, objects, items,
                             instances, encounters, factions and flight points
                             (and the objectives of dungeon event quests) in
                             each language. Per id, the first source with a
                             name wins: the Forever client's tables
                             (wago.tools, &locale=), Wowhead's Forever
                             database in that language (list pages and
                             tooltips, read only from what is already cached
                             in data/sources/wowhead/names),
                             DingDB (pinned commit and sha256s, cloned into
                             data/sources/ding), then pfQuest's db/<locale>.
                             Only the ids the compiled guides, the quest
                             database, the Codex's data and the travel data
                             name. A language left without names loses its
                             folder.

  i18n guides sync [<locale>...]
                             writes a guide pack's texts in other languages
                             (docs/TRANSLATING.md, "Guide texts"):
                             <pack>/locales/<locale>/<guide path>.lua per
                             guide and _pack.lua for the pack's own texts,
                             each with every text that needs words, the
                             game's names as {kind:id} tokens, "" while not
                             translated. Keeps every translation; one whose
                             English the guide lost moves to a commented
                             block at the end. Without a locale: every
                             language the pack has a folder for.
  i18n guides check [<locale>...]
                             fails (exit 1) on a texts file Lua cannot load,
                             a translation that leaves out or adds a name
                             token or a line break, a stale translation (its
                             English changed or went away: the new English
                             is named when it can be told) or a file no
                             guide has. Missing translations are fine.
  i18n guides stats          the texts to translate: unique texts, words and
                             characters (tokens left out), in all and by
                             guide folder; the names the compiler made
                             tokens, by kind and source; the notes dropped
                             for naming only their goal.

options:
  --json            status, check, keys, names, fit, leaks, guides: one JSON document on stdout
  --scene <a,b>     leaks: only these scenes
  --guide <id,...>  leaks: the guides the guide scene shows (default a few)
  --jobs <n>        leaks: runs at a time (default one per core)
  --update-baseline leaks: write tools/lib/i18n/leaks-baseline.json: add the
                    names no source has that the runs showed in English,
                    drop the entries that no longer show
  --slack <n>       fit: measure every glyph n times wider (1.15: about the
                    client's own font)
  --pack <dir>      guides: the guide pack (default our guides/)
  --data <dir>      guides: the reference data (default data/forever)
  --markdown        status: a Markdown table
  --no-questie      names: leave DingDB out (its base data is QuestieDB's)
  --no-tables       names: leave the client tables out (otherwise a missing
                    table stops the build)
  --offline         names: no downloads; the cached clones and tables
  --build <version> names: this Forever client build (default the newest wago.tools lists)
  --sources <dir>   names: the client-table and Wowhead cache (default data/sources)
  --ding <dir>      names: this DingDB checkout (default data/sources/ding)
  --pfquest <dir>   names: this pfQuest checkout (default data/sources/pfQuest)
  --guides <file>   names: the compiled guides (default addon/Polestar_Guides/Guides.lua)
  --questdb <dir>   names: the built quest database (default addon/Polestar_QuestDB)
  --codex <dir>     names: the Codex's data (default data/forever/codex)
  --travel <file>   names: the travel data (default addon/Polestar/Nav/TravelData.lua)
  --chokepoints <file> names: the walking map's chokepoints, for the lifts' objects
                    (default addon/Polestar_Nav/Nav/Chokepoints.lua)
  --out <dir>       names: where the addon folders go (default addon/)
  --addon <name>    status, check, sync, keys, import: Polestar or
                    Polestar_Recorder only`;

function locales(positional) {
	if (!positional.length) return LOCALE_CODES.slice();
	return positional.map(checkLocale);
}

function count(o) {
	return Object.keys(o).length;
}

// Locales/<x>.lua files that are not one of LOCALES.
function strayFiles(addonDir) {
	const dir = path.join(addonDir, 'Locales');
	if (!fs.existsSync(dir)) return [];
	return fs.readdirSync(dir).filter((f) => f.endsWith('.lua') && !LOCALES[f.replace(/\.lua$/, '')]).map((f) => path.join(dir, f));
}

function runStatus(opts) {
	const st = localeState(addons(opts, { one: true })[0].dir, LOCALE_CODES);
	const total = st.keys.size;
	const rows = LOCALE_CODES.map((locale) => {
		const s = st.locales[locale];
		const meta = LOCALES[locale];
		return { locale, language: meta.language, status: meta.status, translators: meta.translators, file: s.exists, translated: count(s.translated), keys: total };
	});
	if (opts.json) {
		console.log(JSON.stringify({ keys: total, locales: rows }, null, 1));
		return 0;
	}
	const pct = (r) => `${Math.floor((r.translated / r.keys) * 100)}%`;
	if (opts.markdown) {
		console.log('| Language | Locale | Translated | Status | Translators |');
		console.log('|---|---|---|---|---|');
		for (const r of rows) {
			const done = r.file ? `${r.translated}/${r.keys} (${pct(r)})` : 'not yet';
			console.log(`| ${r.language} | ${r.locale} | ${done} | ${r.status === 'ai' ? 'AI-made' : 'reviewed'} | ${r.translators.join(', ') || '-'} |`);
		}
		return 0;
	}
	console.log(`${total} interface keys`);
	for (const r of rows) {
		const done = r.file ? `${r.translated}/${r.keys} (${pct(r)})` : 'no file yet';
		console.log(`${r.locale}  ${r.language.padEnd(24)}${done.padEnd(18)}${r.status.padEnd(10)}${r.translators.join(', ')}`);
	}
	return 0;
}

function runCheck(opts, positional) {
	const list = locales(positional);
	const report = { ok: true, keys: 0, locales: {}, addons: {} };
	let failures = 0;
	const fail = (msg) => {
		failures++;
		if (!opts.json) console.error(`error: ${msg}`);
	};
	const all = addons(opts);
	for (const [i, addon] of all.entries()) {
		const st = localeState(addon.dir, list);
		const part = { keys: st.keys.size, locales: {} };
		report.addons[path.basename(addon.dir)] = part;
		if (i === 0) Object.assign(report, part);
		if (all.length > 1 && !opts.json) console.log(`${path.basename(addon.dir)}:`);
		if (!positional.length) for (const f of strayFiles(addon.dir)) fail(`${rel(f)}: not a locale Polestar ships (tools/lib/i18n/locales.js)`);
		for (const locale of list) {
			const s = st.locales[locale];
			const file = rel(s.file);
			const r = { file, exists: s.exists, translated: count(s.translated), missing: s.missing.length, stale: Object.keys(s.stale), problems: s.problems, warnings: s.warnings, error: s.error };
			part.locales[locale] = r;
			if (!s.exists) {
				if (!opts.json) console.log(`${locale}: no file yet (\`node tools/polestar.js i18n sync ${locale}\` starts one)`);
				continue;
			}
			if (s.error) fail(`${file}: ${s.error}`);
			for (const k of r.stale) fail(`${file}: stale key ${JSON.stringify(k)} (not in the code; \`i18n sync ${locale}\` moves it to the end as a comment)`);
			for (const p of s.problems) fail(`${file}: ${JSON.stringify(p.key)}: ${p.problem}`);
			if (!opts.json) {
				for (const w of s.warnings) console.warn(`warning: ${file}: ${JSON.stringify(w.key)} = ${JSON.stringify(w.value)}: the glossary says "${w.term}" for ${w.id}`);
				console.log(`${locale}: ${r.translated}/${st.keys.size} translated, ${r.missing} missing${r.stale.length ? `, ${r.stale.length} stale` : ''}${s.warnings.length ? `, ${plural(s.warnings.length, 'glossary warning')}` : ''}`);
			}
		}
	}
	report.ok = failures === 0;
	if (opts.json) console.log(JSON.stringify(report, null, 1));
	else if (failures) console.error(`i18n check failed: ${plural(failures, 'problem')}`);
	return failures ? 1 : 0;
}

// The Core/Core.xml line that loads a locale file, added after the last one.
function loadInCoreXml(locale) {
	const xml = path.join(ADDON, 'Core', 'Core.xml');
	const text = fs.readFileSync(xml, 'utf8');
	const line = `\t<Script file="..\\Locales\\${locale}.lua"/>`;
	if (text.includes(line)) return false;
	const lines = text.split('\n');
	let at = -1;
	lines.forEach((l, i) => {
		if (l.includes('file="..\\Locales\\')) at = i;
	});
	if (at < 0) at = lines.findIndex((l) => l.includes('file="Init.lua"'));
	lines.splice(at + 1, 0, line);
	fs.writeFileSync(xml, lines.join('\n'));
	return true;
}

// A new Polestar locale file is loaded from Core/Core.xml; another addon's
// TOC lists its files.
function writeSync(files) {
	let written = 0;
	for (const [file, r] of Object.entries(files)) {
		if (fs.existsSync(file) && fs.readFileSync(file, 'utf8') === r.text) continue;
		fs.mkdirSync(path.dirname(file), { recursive: true });
		const created = !fs.existsSync(file);
		fs.writeFileSync(file, r.text);
		const own = path.dirname(file) === path.join(ADDON, 'Locales');
		if (created && own && loadInCoreXml(path.basename(file, '.lua'))) console.log(`Core/Core.xml loads ${rel(file)}`);
		if (created && !own) console.log(`${rel(file)} is new: list it in its addon's TOC`);
		written++;
	}
	return written;
}

function runSync(opts, positional) {
	let code = 0;
	const files = {};
	for (const addon of addons(opts)) {
		const list = positional.length ? locales(positional) : LOCALE_CODES.filter((l) => fs.existsSync(path.join(addon.dir, 'Locales', `${l}.lua`)));
		const st = localeState(addon.dir, list);
		for (const locale of list) {
			const s = st.locales[locale];
			if (s.error) {
				console.error(`error: ${rel(s.file)}: ${s.error}; fix it first (nothing written for ${locale})`);
				code = 1;
			}
		}
		Object.assign(files, syncFiles(st, { create: positional.length ? list : [], title: addon.title }));
	}
	for (const [file, r] of Object.entries(files)) {
		const parts = [];
		if (r.added.length) parts.push(`${plural(r.added.length, 'key')} added`);
		if (r.retired.length) parts.push(`${plural(r.retired.length, 'translation')} of keys the code lost moved to the end`);
		if (r.dropped.length) parts.push(`${plural(r.dropped.length, 'untranslated key')} the code lost removed`);
		if (parts.length) console.log(`${rel(file)}: ${parts.join(', ')}`);
	}
	console.log(`${plural(writeSync(files), 'file')} written`);
	return code;
}

function runKeys(opts) {
	const { extractKeys } = require('../lib/i18n/keys');
	const keys = extractKeys(addons(opts, { one: true })[0].dir);
	const where = (w) => w.map((x) => (x.data ? `${x.file} (data)` : `${x.file}:${x.line}`));
	if (opts.json) {
		console.log(JSON.stringify(Object.fromEntries([...keys].map(([k, w]) => [k, where(w)])), null, 1));
		return 0;
	}
	for (const [k, w] of keys) console.log(`${JSON.stringify(k)}\t${where(w).join(', ')}`);
	console.log(`${keys.size} keys`);
	return 0;
}

function runImport(opts, positional) {
	const [locale, ...files] = positional;
	if (!locale || !files.length) {
		console.error(usage);
		return 2;
	}
	checkLocale(locale);
	const { readLocaleFiles } = require('../lib/i18n/files');
	const { formatProblems } = require('../lib/i18n/check');
	const addon = addons(opts, { one: true })[0];
	const st = localeState(addon.dir, [locale]);
	const s = st.locales[locale];
	if (s.error) throw new Error(`${rel(s.file)}: ${s.error}`);
	const fill = {};
	const retire = {};
	let bad = 0;
	for (const r of readLocaleFiles(files.map((f) => ({ file: path.resolve(f), locale })))) {
		if (!r.ok) {
			console.error(`error: ${rel(r.file)}: ${r.error}`);
			bad++;
			continue;
		}
		for (const [k, v] of Object.entries(r.strings)) {
			if (v === '') continue;
			if (!st.keys.has(k)) {
				retire[k] = v;
				continue;
			}
			const problems = formatProblems(k, v);
			if (problems.length) {
				console.error(`error: ${rel(r.file)}: ${JSON.stringify(k)}: ${problems.join('; ')}`);
				bad++;
				continue;
			}
			fill[k] = v;
		}
	}
	const out = syncFiles(st, { create: [locale], fill: { [locale]: fill }, retire: { [locale]: retire }, title: addon.title });
	writeSync(out);
	const r = out[s.file];
	console.log(`${locale}: ${plural(r.filled.length, 'translation')} imported into ${rel(s.file)}`
		+ `${r.kept.length ? `, ${plural(r.kept.length, 'key')} kept as translated before` : ''}`
		+ `${r.retired.length ? `, ${plural(r.retired.length, 'key')} the code lacks put in the block at the end` : ''}`
		+ `${bad ? `, ${plural(bad, 'problem')}` : ''}`);
	return bad ? 1 : 0;
}

const KIND_WORDS = {
	quest: 'quest', npc: 'NPC', object: 'object', item: 'item', map: 'instance', encounter: 'encounter',
	faction: 'faction', taxi: 'flight point', objective: 'quest objective',
};
const SOURCE_WORDS = { wago: 'client tables', wowhead: 'Wowhead', ding: 'DingDB', pfquest: 'pfQuest' };

async function runNames(opts, positional) {
	const names = require('../lib/i18n/names');
	const { ensurePfQuest, loadPfQuestNames } = require('../lib/data/pfquest');
	const { loadClientNames } = require('../lib/i18n/names-wago');
	const wh = require('../lib/i18n/names-wowhead');
	const wanted = locales(positional);
	const abs = (p) => (p ? path.resolve(p) : undefined);
	const log = opts.json ? () => {} : (m) => console.log(m);
	const warn = (m) => console.error(`warning: ${m}`);
	const offline = Boolean(opts.offline);
	const sourcesDir = abs(opts.sources) || names.DEFAULTS.sources;
	const codex = abs(opts.codex) || names.DEFAULTS.codex;
	const ids = names.usedIds({ guides: abs(opts.guides), questdb: abs(opts.questdb), codex });
	const { liftObject, ...extra } = names.extraIds({ codex, travel: abs(opts.travel) || names.DEFAULTS.travel, chokepoints: abs(opts.chokepoints) || names.DEFAULTS.chokepoints });
	Object.assign(ids, extra);
	for (const id of liftObject) ids.object.add(id);
	const pfInfo = ensurePfQuest({ dir: abs(opts.pfquest) || names.DEFAULTS.pfquest, explicit: Boolean(opts.pfquest), offline, log });
	for (const w of pfInfo.warnings) warn(w);
	const ding = opts.noQuestie ? null : names.ensureDing({ dir: abs(opts.ding) || names.DEFAULTS.ding, explicit: Boolean(opts.ding), offline, log });
	const pf = loadPfQuestNames(pfInfo.dir, [...wanted, 'enUS']);
	const dingNames = ding ? names.readDing(ding, wanted) : null;

	// The client's tables in each language: Forever's, then the Era client's
	// items. Missing tables stop the build (--no-tables leaves them out).
	let wago = null;
	let wagoInfo = null;
	const english = {};
	if (!opts.noTables) {
		const tables = await loadClientNames({ sourcesDir, locales: wanted, forever: opts.build, offline, log });
		wago = tables.names;
		wagoInfo = { builds: tables.builds, urls: tables.urls };
		for (const [kind, m] of Object.entries(tables.english)) for (const [id, n] of m) names.addEnglish(english, kind, id, n);
	}
	// The data's English names: a name equal to one of them is no translation.
	for (const [kind, file] of Object.entries({ quest: 'quests.json', npc: 'npcs.json', object: 'objects.json', item: 'items.json' })) {
		const f = path.join(codex, file);
		if (!fs.existsSync(f)) continue;
		for (const [id, r] of Object.entries(JSON.parse(fs.readFileSync(f, 'utf8')))) names.addEnglish(english, kind, Number(id), r && (r.name || r.title));
	}

	// Wowhead: only what is already cached.
	const whNames = Object.fromEntries(wanted.map((l) => [l, wh.loadWowheadNames(sourcesDir, l)]));
	const out = names.buildNames({ locales: wanted, ids, ding: dingNames, pf, wago, wowhead: whNames, english });
	for (const l of wanted) {
		for (const kind of ['map', 'faction', 'taxi']) {
			if (wago && ids[kind] && ids[kind].size && !out[l].names[kind].size) throw new Error(`${l}: no ${kind} names from the client tables (${ids[kind].size} wanted); nothing written`);
		}
	}
	const outDir = abs(opts.out) || names.DEFAULTS.out;
	const sources = { wago: wagoInfo, wowhead: Object.fromEntries(wanted.map((l) => [l, whNames[l]])), ding, pf: pfInfo };
	if (!Object.values(sources.wowhead).some((x) => x.fetched)) sources.wowhead = null;
	const written = names.writeNamesAddons(out, outDir, { sources });
	// The ids whose every name in a language is the English one, for
	// `i18n leaks --update-baseline` (data/local, not shipped); only for a
	// build into the addon folder.
	if (outDir === names.DEFAULTS.out) names.writeSameAsEnglish(out);
	const idCount = (k) => (ids[k] === null ? null : ids[k].size);
	// Ids with no name in a language, and those whose every name there is the
	// English one (not stored: the English shows, as the game does).
	const lacking = (l) => Object.fromEntries(names.PACK_KINDS.filter((k) => ids[k]).map((k) => [k, [...ids[k]].filter((id) => !out[l].names[k].has(id) && !out[l].english[k].has(id)).length]));
	const sameAsEnglish = (l) => Object.fromEntries(names.PACK_KINDS.filter((k) => ids[k]).map((k) => [k, out[l].english[k].size]));
	if (opts.json) {
		const kinds = (f) => Object.fromEntries(names.PACK_KINDS.map((k) => [k, f(k)]));
		console.log(JSON.stringify({
			ids: { ...kinds(idCount), sources: ids.counts },
			wago: wagoInfo ? wagoInfo.builds : null,
			wowhead: sources.wowhead ? Object.fromEntries(wanted.map((l) => [l, whNames[l].fetched])) : null,
			ding: ding ? { version: ding.pin.version, commit: ding.pin.commit, revision: ding.revision } : null,
			pfquest: { revision: pfInfo.revision },
			locales: Object.fromEntries(wanted.map((l) => {
				const w = written.find((x) => x.locale === l);
				return [l, { names: kinds((k) => out[l].names[k].size), lacking: lacking(l), sameAsEnglish: sameAsEnglish(l), from: out[l].from, bytes: w ? w.bytes : 0 }];
			})),
		}, null, 2));
		return 0;
	}
	const idLine = (c, kinds = names.PACK_KINDS) => kinds.filter((k) => c[k] != null).map((k) => plural(c[k], KIND_WORDS[k])).join(', ');
	console.log(`ids Polestar's data names: ${idLine(Object.fromEntries(names.PACK_KINDS.map((k) => [k, idCount(k)])))}${ids.encounter === null ? ', every encounter' : ''}`);
	for (const [src, c] of Object.entries(ids.counts)) console.log(`  ${src}: ${idLine(c, names.NAME_KINDS)}`);
	console.log(wagoInfo ? `client tables: ${Object.entries(wagoInfo.builds).map(([p, b]) => `${p} ${b}`).join(', ')}` : 'client tables left out');
	const whDates = wanted.flatMap((l) => (whNames[l].fetched ? [whNames[l].fetched.first, whNames[l].fetched.last] : [])).sort();
	console.log(whDates.length ? `Wowhead: the cache, read ${whDates[0].slice(0, 10)} to ${whDates[whDates.length - 1].slice(0, 10)}` : 'Wowhead: nothing cached');
	console.log(ding ? `DingDB ${ding.pin.version} (${ding.pin.commit.slice(0, 7)}): every pinned file matches its sha256` : 'DingDB left out (--no-questie)');
	console.log(`pfQuest ${pfInfo.revision ? pfInfo.revision.slice(0, 7) : '(revision unknown)'}`);
	for (const l of wanted) {
		const b = out[l];
		const w = written.find((x) => x.locale === l);
		const from = Object.fromEntries(names.SOURCE_KEYS.map((s) => [s, names.PACK_KINDS.reduce((n, k) => n + b.from[k][s], 0)]));
		const sizes = Object.fromEntries(names.PACK_KINDS.map((k) => [k, b.names[k].size]));
		const fromLine = names.SOURCE_KEYS.map((s) => `${SOURCE_WORDS[s]} ${from[s]}`).join(', ');
		const miss = lacking(l);
		console.log(w
			? `${l}: ${idLine(sizes)} (${fromLine}); the English one for ${idLine(sameAsEnglish(l))}; none for ${idLine(miss)}; ${path.relative(process.cwd(), w.dir) || '.'}, ${(w.bytes / 1024).toFixed(0)} KB`
			: `${l}: no names; no folder`);
	}
	return 0;
}

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

// English left on screen in each locale (tools/lib/i18n/leaks.js).
async function runLeaks(opts, positional) {
	const L = require('../lib/i18n/leaks');
	const chosen = locales(positional);
	const scenes = opts.scene ? opts.scene.split(',').map((s) => s.trim()).filter(Boolean) : L.SCENE_NAMES;
	const guides = opts.guide ? opts.guide.split(',').map((s) => s.trim()).filter(Boolean) : [];
	const jobs = opts.jobs === undefined ? undefined : Number(opts.jobs);
	if (jobs !== undefined && !(jobs >= 1)) throw new Error(`--jobs ${opts.jobs}: a number of 1 or more`);
	const results = await L.findLeaks(chosen, scenes, {
		guides,
		jobs,
		onResult: opts.json ? null : (r) => console.error(`${r.locale} ${r.scene}: ${r.skipped ? `skipped (${r.skipped})` : `${plural(r.leaks.length, 'English text')}${r.errors.length ? `, ${plural(r.errors.length, 'error')}` : ''}`}`),
	});
	const errors = results.flatMap((r) => (r.errors || []).map((e) => ({ locale: r.locale, scene: r.scene, ...e })));
	if (opts.updateBaseline) {
		if (errors.length) throw new Error(`${plural(errors.length, 'scene error')}: fix them before the baseline is written`);
		const before = L.loadBaseline();
		const next = L.updatedBaseline(results, before);
		const count = (b) => Object.values(b.entries).reduce((n, e) => n + Object.keys(e).length, 0);
		fs.writeFileSync(L.BASELINE_FILE, `${JSON.stringify(next, null, '\t')}\n`);
		const left = results.reduce((n, r) => n + (r.leaks || []).filter((l) => !l.names.length && !l.textKey).length, 0);
		console.log(`${rel(L.BASELINE_FILE)}: ${count(before)} -> ${count(next)} names; ${plural(left, 'English text')} it cannot take (not a missing name: fix the code or translation)`);
		return left ? 1 : 0;
	}
	const leaks = results.reduce((n, r) => n + (r.leaks ? r.leaks.length : 0), 0);
	const stale = L.staleBaseline(results);
	const groups = L.groupBySource(results);
	const failed = leaks || errors.length || stale.length;
	if (opts.json) {
		console.log(JSON.stringify({
			ok: !failed,
			runs: results.map((r) => ({ locale: r.locale, scene: r.scene, skipped: r.skipped || undefined, texts: r.texts, leaks: r.leaks ? r.leaks.length : undefined, baselined: r.baselined ? r.baselined.length : undefined })),
			errors,
			stale: stale.map((s) => ({ locale: s.locale, name: s.key, scenes: s.entry.scenes })),
			groups: groups.map((g) => ({ source: g.source, label: g.key, entries: [...g.entries].map(([words, e]) => ({ words, locales: Object.fromEntries(e.locales), scenes: [...e.scenes], sites: [...e.sites] })) })),
		}, null, 1));
		return failed ? 1 : 0;
	}
	for (const e of errors) console.log(`error: ${e.locale} ${e.scene}: ${e.scene === e.error ? '' : `${e.scene}: `}${e.error.split('\n')[0]}`);
	for (const s of stale) console.log(`stale: ${rel(L.BASELINE_FILE)}: ${s.locale} ${s.key} no longer shows in English (${s.entry.scenes.join(', ')}): remove it, or run with --update-baseline`);
	for (const g of groups) {
		console.log(`\n${g.key} (${plural(g.entries.size, 'text')})`);
		for (const [words, e] of g.entries) {
			const [locale, text] = [...e.locales][0];
			console.log(`  ${words}  [${[...e.locales.keys()].join(' ')}]`);
			console.log(`    ${locale}: ${text.length > 160 ? `${text.slice(0, 157)}...` : text}`);
			console.log(`    in ${[...e.scenes][0]}${e.scenes.size > 1 ? ` and ${e.scenes.size - 1} more` : ''}; set at ${[...e.sites][0] || '?'}`);
		}
	}
	const ran = results.filter((r) => !r.skipped);
	console.log(`\n${ran.length} of ${plural(results.length, 'run')} (${plural(chosen.length, 'locale')}, ${plural(scenes.length, 'scene')}): ${leaks ? `${plural(leaks, 'English text')} from ${plural(groups.length, 'source')}` : 'no English left'}${errors.length ? `, ${plural(errors.length, 'scene error')}` : ''}${stale.length ? `, ${plural(stale.length, 'stale baseline name')}` : ''}`);
	return failed ? 1 : 0;
}

// --- guide texts (tools/lib/i18n/guides.js) ----------------------------------

// The pack (--pack, else ours) compiled in memory, with its tokenised texts.
function packGuides(opts) {
	const { commandPack } = require('../lib/pack/locate');
	const { buildPack } = require('../lib/pack/build');
	const { DATA } = require('../lib/paths');
	const pack = commandPack({ pack: opts.pack ? path.resolve(opts.pack) : undefined });
	if (pack.error) throw new Error(pack.error);
	if (!pack.manifest) throw new Error(`${pack.dir}: no valid pack.json`);
	// Our guides as context only check routes across packs: the texts need none.
	const r = buildPack({ ...pack, contextDir: null }, { dataDir: opts.data ? path.resolve(opts.data) : DATA, files: false });
	if (r.noData) throw new Error('no reference data: run `node tools/polestar.js data build` (or pass --data)');
	if (r.diag.errors.length) throw new Error(`the pack does not compile (${plural(r.diag.errors.length, 'error')}): run \`node tools/polestar.js lint\``);
	return { dir: pack.dir, manifest: pack.manifest, guides: r.guides.filter((g) => g._ast && g._ast.source), tokens: r.tokens };
}

function runGuides(opts, positional) {
	const G = require('../lib/i18n/guides');
	const [what, ...rest] = positional;
	if (!['sync', 'check', 'stats'].includes(what)) {
		console.error(`i18n guides needs sync, check or stats\n\n${usage}`);
		return 2;
	}
	const pack = packGuides(opts);
	if (what === 'stats') {
		const st = G.textStats(pack.manifest, pack.guides);
		if (opts.json) {
			console.log(JSON.stringify({ ...st, tokens: pack.tokens }, null, 1));
			return 0;
		}
		const row = (name, r) => `${name.padEnd(34)}${String(r.guides === undefined ? '' : r.guides).padStart(7)}${String(r.texts).padStart(8)}${String(r.words).padStart(9)}${String(r.chars).padStart(10)}`;
		console.log(`${'folder'.padEnd(34)}${'guides'.padStart(7)}${'texts'.padStart(8)}${'words'.padStart(9)}${'chars'.padStart(10)}`);
		for (const f of Object.keys(st.byFolder).sort()) console.log(row(f, st.byFolder[f]));
		console.log(row('all (each text once)', { ...st.total, guides: pack.guides.length }));
		const t = pack.tokens;
		const sum = (o) => Object.values(o).reduce((a, b) => a + b, 0);
		console.log(`\nnames made tokens: ${sum(t.replaced)} (${Object.entries(t.replaced).filter(([, n]) => n).map(([k, n]) => `${k} ${n}`).join(', ')})`);
		console.log(`  by source: ${Object.entries(t.bySource).map(([k, n]) => `${k} ${n}`).join(', ')}`);
		console.log(`notes dropped for naming only their goal: ${t.dropped}`);
		return 0;
	}
	const chosen = rest.length ? locales(rest) : G.packLocales(pack.dir);
	if (!chosen.length) {
		console.log(`${rel(path.join(pack.dir, 'locales'))}: no languages yet (\`node tools/polestar.js i18n guides sync <locale>\` starts one)`);
		return 0;
	}
	const st = G.guideState(pack.dir, pack.manifest, pack.guides, chosen);
	if (what === 'sync') {
		let code = 0;
		for (const locale of chosen) {
			for (const s of st[locale].files) {
				if (!s.error) continue;
				console.error(`error: ${rel(s.file)}: ${s.error}; fix it first (left as it is)`);
				code = 1;
			}
			for (const f of st[locale].orphans) console.log(`note: ${rel(f)}: no guide has this path (left alone: rename it after its guide, or delete it)`);
		}
		let written = 0;
		for (const [file, text] of Object.entries(G.syncFiles(st))) {
			if (fs.existsSync(file) && fs.readFileSync(file, 'utf8') === text) continue;
			fs.mkdirSync(path.dirname(file), { recursive: true });
			fs.writeFileSync(file, text);
			written++;
		}
		for (const locale of chosen) {
			const files = st[locale].files;
			const texts = files.reduce((n, s) => n + s.texts.length, 0);
			const done = files.reduce((n, s) => n + count(s.translated), 0);
			console.log(`${locale}: ${done}/${texts} texts translated`);
		}
		console.log(`${plural(written, 'file')} written`);
		return code;
	}
	const report = { ok: true, locales: {} };
	let failures = 0;
	const fail = (msg) => {
		failures++;
		if (!opts.json) console.error(`error: ${msg}`);
	};
	for (const locale of chosen) {
		const files = st[locale].files;
		const r = { texts: 0, translated: 0, missing: 0, stale: 0, problems: 0, orphans: st[locale].orphans.map(rel), files: files.filter((s) => s.exists).length };
		for (const s of files) {
			r.texts += s.texts.length;
			r.translated += count(s.translated);
			r.missing += s.missing.length;
			if (!s.exists) continue;
			const file = rel(s.file);
			if (s.error) fail(`${file}: ${s.error}`);
			for (const p of s.problems) {
				r.problems++;
				fail(`${file}: ${JSON.stringify(p.text)}: the translation ${p.problem}`);
			}
			for (const k of Object.keys(s.stale)) {
				r.stale++;
				const next = s.successors[k];
				fail(`${file}: stale translation of ${JSON.stringify(k)} (${next ? `its English is now ${JSON.stringify(next)}` : 'the guide no longer has it'}; \`i18n guides sync ${locale}\` moves it to the end)`);
			}
		}
		for (const f of r.orphans) fail(`${f}: no guide has this path`);
		report.locales[locale] = r;
		if (!opts.json) console.log(`${locale}: ${r.translated}/${r.texts} texts translated in ${plural(r.files, 'file')}, ${r.missing} missing${r.stale ? `, ${r.stale} stale` : ''}`);
	}
	report.ok = failures === 0;
	if (opts.json) console.log(JSON.stringify(report, null, 1));
	return failures ? 1 : 0;
}

async function run(argv) {
	const { opts, positional, error } = parseArgs(argv, {
		flags: ['--json', '--markdown', '--no-questie', '--no-tables', '--offline', '--update-baseline'],
		options: ['--ding', '--pfquest', '--guides', '--questdb', '--codex', '--travel', '--chokepoints', '--out', '--build', '--sources', '--slack', '--addon', '--pack', '--data', '--scene', '--guide', '--jobs'],
	});
	const [sub, ...rest] = positional;
	if (error || !sub) {
		console.error(`${error || 'i18n needs a subcommand'}\n\n${usage}`);
		return 2;
	}
	try {
		if (sub === 'status') return runStatus(opts);
		if (sub === 'check') return runCheck(opts, rest);
		if (sub === 'sync') return runSync(opts, rest);
		if (sub === 'keys') return runKeys(opts);
		if (sub === 'import') return runImport(opts, rest);
		if (sub === 'fit') return await runFit(opts, rest);
		if (sub === 'leaks') return await runLeaks(opts, rest);
		if (sub === 'names') return await runNames(opts, rest);
		if (sub === 'guides') return runGuides(opts, rest);
	} catch (e) {
		console.error(`error: ${e.message}`);
		return 1;
	}
	console.error(`unknown i18n subcommand "${sub}"\n\n${usage}`);
	return 2;
}

module.exports = { name: 'i18n', summary: 'interface translations (status, check, sync, keys, import, fit, leaks), guide texts (guides) and the names addons (names)', usage, run };
