'use strict';
// Whole-project compilation: find a pack's .guide files, parse, resolve,
// validate, and build/write the pack's addon folder. Used by the compile,
// lint and pack commands.

const fs = require('node:fs');
const path = require('node:path');
const { Diagnostics } = require('./diag');
const { parseGuide } = require('./parse');
const { resolveGuide } = require('./resolve');
const { validateGuides, validatePackFrames, forEachGoalMap } = require('./validate');
const { loadData } = require('./data');
const { tokeniseGuides } = require('./tokens');
const { emitGuides, emitPack, emitToc, emitTextsToc, emitTexts, emitMapFrames, emitLicense } = require('./emit');
const { ownsGuideId, GENERATED_MARKER } = require('../pack/format');
const { heightCounts } = require('./heights');
const { HEIGHTS_SOURCE } = require('../travel/cmangos');

const { ROOT, DATA } = require('../paths');
const { LOCALES, LOCALE_CODES } = require('../i18n/locales');
const { ADDON_PREFIX: NAMES_PREFIX } = require('../i18n/names');
// Our own pack: guides/pack.json and the guides beside it.
const OFFICIAL_DIR = path.join(ROOT, 'guides');

function packageVersion() {
	return JSON.parse(fs.readFileSync(path.join(ROOT, 'package.json'), 'utf8')).version;
}

// The whole `## Interface:` value of addon/Polestar/Polestar.toc (a
// multi-version line like "11507, 16001" included), copied into every pack's TOC.
function coreInterface(tocFile = path.join(ROOT, 'addon', 'Polestar', 'Polestar.toc')) {
	const m = /^## Interface:\s*(.+?)\s*$/m.exec(fs.readFileSync(tocFile, 'utf8'));
	if (!m) throw new Error(`${tocFile} has no ## Interface line`);
	return m[1];
}

function toPosix(p) {
	return p.split(path.sep).join('/');
}

// Sorted .guide paths (relative to packDir, forward slashes): every .guide in
// the pack folder except under dist/ (build output) and drafts/ (Recorder
// drafts, only with includeDrafts); dot folders and node_modules are skipped.
function findGuideFiles(packDir, includeDrafts = false) {
	const out = [];
	if (!fs.existsSync(packDir)) return out;
	const walk = (abs, rel) => {
		for (const d of fs.readdirSync(abs, { withFileTypes: true })) {
			if (d.name.startsWith('.')) continue;
			const r = rel ? `${rel}/${d.name}` : d.name;
			if (d.isDirectory()) {
				if (d.name === 'node_modules' || r === 'dist' || (!includeDrafts && r === 'drafts')) continue;
				walk(path.join(abs, d.name), r);
			} else if (d.isFile() && d.name.endsWith('.guide')) out.push(r);
		}
	};
	walk(packDir, '');
	return out.sort();
}

// Reference data from dataDir; a missing folder or core file is a warning in diag.
function loadProjectData(dataDir, diag) {
	const data = loadData(dataDir);
	if (!fs.existsSync(dataDir)) {
		diag.warn(dataDir, 0, 'reference data not found (run `node tools/polestar.js data build` or pass --data); nothing can be filled in');
	} else if (data.missingCore.length) {
		// professions.json / factions.json are reported where a guide needs them.
		diag.warn(dataDir, 0, `missing ${data.missingCore.join(', ')}`);
	}
	return data;
}

// [{ source, file, text }] for the .guide paths `sources` (relative to dir);
// `file` is relative to the working directory when inside it.
function readSources(dir, sources) {
	return sources.map((rel) => {
		const abs = path.join(dir, rel);
		const shown = path.relative(process.cwd(), abs);
		return { source: rel, file: shown.startsWith('..') ? abs : toPosix(shown), text: fs.readFileSync(abs, 'utf8') };
	});
}

// Compile every guide of the pack in packDir; its guides carry the pack id of
// `manifest` (pack.json, tools/lib/pack/manifest.js) and must own their ids.
// Returns { guides, diag, data, sources } with sources the .guide paths
// relative to packDir.
// With `contextDir` (our guides, for another pack): its guides are parsed,
// resolved (with `contextData`, else `contextDataDir`, else the pack's data)
// and validated together with the pack's, so `next` and turn-in checks see
// their chains; their own diagnostics are dropped and nothing of them is
// returned or emitted. Folders the user named are checked by commandPack; a
// missing default context data folder is loadProjectData's warning.
// Diagnostics name files relative to the working directory.
function compileProject({ packDir, manifest, dataDir, includeDrafts = false, data = null, contextDir = null, contextData = null, contextDataDir = null }) {
	const diag = new Diagnostics();
	if (!data) data = loadProjectData(dataDir, diag);
	const sources = findGuideFiles(packDir, includeDrafts);
	let context = null;
	if (contextDir) {
		if (!contextData) contextData = contextDataDir && path.resolve(contextDataDir) !== path.resolve(dataDir || '') ? loadProjectData(contextDataDir, diag) : data;
		context = { sources: readSources(contextDir, findGuideFiles(contextDir)), data: contextData };
	}
	return { ...compileSources(readSources(packDir, sources), data, diag, { pack: manifest && manifest.id, author: manifest && manifest.author, context }), data, sources };
}

// Parse and resolve sources into guides of `pack` (ours when absent); a
// guide without an `author` header is credited to `author` (the pack's).
function resolveSources(sources, data, diag, pack, author) {
	const guides = [];
	for (const s of sources) {
		const ast = parseGuide(s.text, s.file, diag);
		if (!ast || !ast.id) continue;
		ast.source = s.source || s.file;
		guides.push(resolveGuide(ast, data, diag, { pack, author }));
	}
	return guides;
}

// Parse, resolve and validate in-memory sources: [{ file, text, source? }]
// (`file` names it in diagnostics, `source` in the emitted comment). The
// guides belong to pack `opts.pack` (ours when absent), by `opts.author`
// (the pack's author) unless they name their own; when `opts.pack` is given,
// each guide id must be one the pack owns. `opts.context` ({ sources, data }):
// our guides, read as context (see compileProject).
function compileSources(sources, data, diag = new Diagnostics(), opts = {}) {
	const guides = resolveSources(sources, data, diag, opts.pack, opts.author);
	if (opts.pack !== undefined) {
		for (const g of guides) {
			if (ownsGuideId(g.pack, g.id)) continue;
			const prefix = g.pack === 'guides' ? '"forever/" or "draft/"' : `"${g.pack}/"`;
			diag.error(g._ast.file, g._ast.lines.guide || g._ast.line, `guide id "${g.id}" is outside pack "${g.pack}": its guide ids start with ${prefix}`, `start the id with \`${g.pack === 'guides' ? 'forever' : g.pack}/\``);
		}
	}
	if (!opts.context) {
		validateGuides(guides, data, diag);
		return { guides, diag, tokens: localise(guides, data, diag) };
	}
	const ours = resolveSources(opts.context.sources, opts.context.data, new Diagnostics(), 'guides');
	const ourFiles = new Set(opts.context.sources.map((s) => s.file));
	// Ours first: a pack guide reusing one of our ids is the duplicate reported.
	const all = new Diagnostics();
	validateGuides([...ours, ...guides], data, all);
	for (const d of all.list) if (!ourFiles.has(d.file)) diag.list.push(d);
	validatePackFrames(guides, data, ours, opts.context.data, diag);
	return { guides, diag, tokens: localise(guides, data, diag) };
}

// Gives each guide `_localised`: the copy Guides.lua holds, its prose with
// name tokens (tokens.js), which the pack's translations are keyed by. A token
// its author wrote that the data does not know is an error. -> tokens.js's
// stats.
function localise(guides, data, diag) {
	const r = tokeniseGuides(guides, data);
	guides.forEach((g, i) => hidden(g, '_localised', r.guides[i]));
	for (const p of r.problems) diag.error(p.guide._ast.file, p.line, p.message, 'write a name token as {kind:id}, kind one of npc object item quest zone area spell faction skill, with an id the data has');
	return r.stats;
}

function hidden(obj, key, value) {
	Object.defineProperty(obj, key, { value, enumerable: false, configurable: true, writable: true });
}

// Era bounds for every map any emitted coordinate uses: the goal's own
// map/x/y and any coordinate list on it (smart-target `candidates`).
function referencedFrames(guides, data) {
	const frames = {};
	forEachGoalMap(guides, (map) => {
		if (frames[map]) return;
		const fr = data.eraFrame(map);
		if (fr) frames[map] = { c: fr.c, left: fr.left, right: fr.right, top: fr.top, bottom: fr.bottom };
	});
	return frames;
}

// A pack's addon folder as { name: content }, deterministic: exactly
// <folder>.toc, Pack.lua, MapFrames.lua, Guides.lua and LICENSE-DATA.txt,
// plus LICENSE.txt holding `license` (the pack's LICENSE file) when given.
// LICENSE-DATA.txt names meta.json's sources, and CMaNGOS classic-db when a
// goal, smart-target candidate or spawn spot carries a height (heights.js)
// and meta.json does not name it already.
// `translations` (tools/lib/i18n/guides.js packTranslations: { [locale]: {
// pack, guides } }) add a texts addon per language beside the folder,
// named `../<folder>_<locale>/<file>` (writePackDir writes them there).
function buildPackFiles({ guides, manifest, data, license = null, translations = {} }) {
	const sources = (data.meta && Array.isArray(data.meta.sources) && data.meta.sources) || [];
	const h = heightCounts(guides);
	const meta = h.withZ + h.candidatesWithZ + h.spotsWithZ && !sources.some((s) => s && s.name === HEIGHTS_SOURCE.name) ? { ...data.meta, sources: [...sources, HEIGHTS_SOURCE] } : data.meta;
	const iface = coreInterface();
	const files = {
		[`${manifest.folder}.toc`]: emitToc(manifest, iface),
		'Pack.lua': emitPack(manifest),
		'MapFrames.lua': emitMapFrames(referencedFrames(guides, data), manifest.id),
		'Guides.lua': emitGuides(guides.map((g) => ({ guide: g._localised || g, source: g._ast && g._ast.source ? g._ast.source : null }))),
		'LICENSE-DATA.txt': emitLicense(meta),
	};
	if (license != null) files['LICENSE.txt'] = license;
	for (const locale of Object.keys(translations).sort()) {
		const name = textsAddon(manifest.folder, locale);
		files[`../${name}/${name}.toc`] = emitTextsToc(manifest, locale, LOCALES[locale].language, iface);
		files[`../${name}/Texts.lua`] = emitTexts(manifest.id, locale, translations[locale]);
		if (license != null) files[`../${name}/LICENSE.txt`] = license;
	}
	return files;
}

// The texts addon of pack folder `folder` in `locale` (Core/GuideTexts.lua).
function textsAddon(folder, locale) {
	return `${folder}_${locale}`;
}

// Whether dir is a folder we generated: a TOC carrying the marker, or the
// old layout's Pack.xml carrying it.
function isGeneratedDir(dir) {
	let entries;
	try {
		entries = fs.readdirSync(dir, { withFileTypes: true });
	} catch {
		return false;
	}
	const has = (name) => fs.readFileSync(path.join(dir, name), 'utf8').includes(GENERATED_MARKER);
	return entries.some((e) => e.isFile() && (e.name.toLowerCase().endsWith('.toc') || e.name === 'Pack.xml') && has(e.name));
}

// The pack id a generated TOC names (its `## X-Polestar-Pack:` line).
const PACK_ID_LINE = /^## X-Polestar-Pack:[ \t]*(\S+)[ \t]*$/m;

// The pack id dir's generated TOC names, or null.
function generatedPackId(dir) {
	let entries;
	try {
		entries = fs.readdirSync(dir, { withFileTypes: true });
	} catch {
		return null;
	}
	for (const e of entries) {
		if (!e.isFile() || !e.name.toLowerCase().endsWith('.toc')) continue;
		const text = fs.readFileSync(path.join(dir, e.name), 'utf8');
		const m = text.includes(GENERATED_MARKER) && PACK_ID_LINE.exec(text);
		if (m) return m[1];
	}
	return null;
}

// The one rule for replacing a pack folder (compile, dev, install, pack,
// play): an absent or empty folder, or one we generated (isGeneratedDir),
// may be replaced; with `packId`, a generated folder of another pack may not
// (two packs can default to the same folder name). -> null, or why not (the
// caller names its action): `--out` pointed at the repository on a
// case-insensitive filesystem, or at someone's own addon, must never be touched.
function packDirRefusal(dir, packId = null) {
	let entries;
	try {
		entries = fs.readdirSync(dir);
	} catch {
		return fs.existsSync(dir) ? 'it is not a folder' : null;
	}
	if (!entries.length) return null;
	if (!isGeneratedDir(dir)) return `it is not a generated community addon (no TOC with the "${GENERATED_MARKER}" line); move it away first`;
	const owner = packId ? generatedPackId(dir) : null;
	if (owner && owner !== packId) return `it holds the community addon "${owner}", not "${packId}"; set "folder" in pack.json to a folder name of your own`;
	return null;
}

// Write a pack folder where packDirRefusal allows it (for the pack the
// files' TOC names). The old layout (Pack.xml, Guides/) is removed, and a
// LICENSE.txt the build no longer has; generated files are replaced;
// anything else is left alone. Files named `../<folder>_<locale>/...` are the
// pack's texts addons (buildPackFiles), each written whole beside outDir; a
// texts addon of the pack whose language the build no longer has is removed.
function writePackDir(outDir, files) {
	const toc = Object.keys(files).find((name) => !name.startsWith('../') && name.toLowerCase().endsWith('.toc'));
	const m = toc ? PACK_ID_LINE.exec(String(files[toc])) : null;
	const packId = m ? m[1] : null;
	const siblings = new Map(); // folder -> { name: content }
	for (const name of Object.keys(files)) {
		if (!name.startsWith('../')) continue;
		const [folder, ...rest] = name.slice(3).split('/');
		if (!siblings.has(folder)) siblings.set(folder, {});
		siblings.get(folder)[rest.join('/')] = files[name];
	}
	const refusal = packDirRefusal(outDir, packId);
	if (refusal) throw new Error(`refusing to write into ${outDir}: ${refusal}`);
	const parent = path.dirname(outDir);
	const base = path.basename(outDir);
	for (const locale of LOCALE_CODES) {
		const dir = path.join(parent, textsAddon(base, locale));
		const why = textsDirRefusal(dir, packId);
		if (siblings.has(path.basename(dir)) && why) throw new Error(`refusing to write into ${dir}: ${why}`);
	}
	fs.mkdirSync(outDir, { recursive: true });
	fs.rmSync(path.join(outDir, 'Guides'), { recursive: true, force: true });
	fs.rmSync(path.join(outDir, 'Pack.xml'), { force: true });
	if (!('LICENSE.txt' in files)) fs.rmSync(path.join(outDir, 'LICENSE.txt'), { force: true });
	for (const name of Object.keys(files).sort()) if (!name.startsWith('../')) fs.writeFileSync(path.join(outDir, name), files[name]);
	for (const locale of LOCALE_CODES) {
		const folder = textsAddon(base, locale);
		const dir = path.join(parent, folder);
		const own = siblings.get(folder);
		if (!own) {
			if (fs.existsSync(dir) && !textsDirRefusal(dir, packId) && fs.readdirSync(dir).length) fs.rmSync(dir, { recursive: true, force: true });
			continue;
		}
		fs.rmSync(dir, { recursive: true, force: true });
		fs.mkdirSync(dir, { recursive: true });
		for (const name of Object.keys(own).sort()) fs.writeFileSync(path.join(dir, name), own[name]);
	}
}

// The pack id a generated texts addon's TOC names (`## X-Polestar-Texts:`).
const TEXTS_ID_LINE = /^## X-Polestar-Texts:[ \t]*(\S+)[ \t]*$/m;

// Whether dir may hold pack packId's texts addon: absent, empty, or one we
// generated for that pack. -> null, or why not.
function textsDirRefusal(dir, packId) {
	let entries;
	try {
		entries = fs.readdirSync(dir);
	} catch {
		return fs.existsSync(dir) ? 'it is not a folder' : null;
	}
	if (!entries.length) return null;
	const toc = entries.find((e) => e.toLowerCase().endsWith('.toc'));
	const text = toc ? fs.readFileSync(path.join(dir, toc), 'utf8') : '';
	const m = text.includes(GENERATED_MARKER) && TEXTS_ID_LINE.exec(text);
	if (!m) return `it is not a generated texts addon (no TOC with the "${GENERATED_MARKER}" line); move it away first`;
	if (packId && m[1] !== packId) return `it holds the texts of the community addon "${m[1]}", not "${packId}"`;
	return null;
}

// Addon folders of the release: always these (Polestar_Nav is committed:
// Polestar's walking router and maps, `nav pack`), plus the generated
// data addons when they have been built (each skipped while its folder or TOC
// is missing; `pack` refuses a release without the Codex, which Lookup,
// Dungeons and Rares read: tools/lib/codex/pack.js releaseRefusal), the names
// addons of each language last (`i18n names`, committed; the client loads only
// its own).
const RELEASE_ADDONS = ['Polestar', 'Polestar_Guides', 'Polestar_Nav'];
// Our guide pack's texts addons (buildPackFiles), each in the release once
// that language has a translation.
const RELEASE_TEXT_ADDONS = LOCALE_CODES.map((l) => textsAddon('Polestar_Guides', l));
const RELEASE_DATA_ADDONS = [
	'Polestar_QuestDB', 'Polestar_ItemDB', 'Polestar_Codex',
	...LOCALE_CODES.map((l) => `${NAMES_PREFIX}${l}`),
];

// -> { names, skipped }: the release addons present under addonsDir, in load order.
function releaseAddons(addonsDir) {
	const skipped = RELEASE_DATA_ADDONS.filter((n) => !fs.existsSync(path.join(addonsDir, n, `${n}.toc`)));
	const texts = RELEASE_TEXT_ADDONS.filter((n) => fs.existsSync(path.join(addonsDir, n, `${n}.toc`)));
	return { names: [...RELEASE_ADDONS, ...texts, ...RELEASE_DATA_ADDONS.filter((n) => !skipped.includes(n))], skipped };
}

module.exports = {
	OFFICIAL_DIR,
	packageVersion,
	coreInterface,
	findGuideFiles,
	loadProjectData,
	compileProject,
	compileSources,
	buildPackFiles,
	packDirRefusal,
	textsDirRefusal,
	writePackDir,
	referencedFrames,
	textsAddon,
	RELEASE_ADDONS,
	RELEASE_DATA_ADDONS,
	releaseAddons,
};
