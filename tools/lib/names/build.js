'use strict';
// `names build`: NPC and object names in the client's language, for the IDs
// Polestar's guides and data name -> the load-on-demand data addon
// addon/Polestar_Names: one file per locale (<locale>.lua), each loaded only
// by a client of that language (TOC `[AllowLoadTextLocale <locale>]`, and a
// GetLocale() guard in the file), read by Core/LocalNames.lua.
//
// Sources, first that has a name wins:
// - QuestieDB's Forever store (the installed copy `data build --questie`
//   reads; facts only): its localization blocks, ported from QuestieDB 1.0.6
//   src/l10n/overlay.lua and src/config.lua. `X-l10n-Version` is the format
//   (1); `X-l10n-<locale>-<Entity>` is base64 of a zlib-compressed CBOR table
//   of columns { [1] = names, [2] = subnames }, each indexed by the position of
//   the ID in the entity's ascending ID list `X-<Entity>-IDS`.
// - pfQuest's locale databases (MIT): db/<locale>/units.lua and objects.lua
//   (pfDB["units"]["frFR"] = { [id] = "name" }); the Era client's names.
// A name equal to the English is left out (the English shows anyway). An ID
// whose Era English (pfQuest's db/enUS) differs from ours was renamed for
// Forever: it keeps its English, since an Era translation names the old NPC.
// Same inputs give byte-identical output.

const fs = require('node:fs');
const path = require('node:path');
const zlib = require('node:zlib');
const { header } = require('../generated');
const { luaString } = require('../dsl/emit');
const { luaToJson } = require('../lua');
const { parseToc, storedValue, decodeCbor, luaGet, luaList, questieDbDir, TOC, REPO: QUESTIE_REPO } = require('../data/questie');
const { REPO: PFQUEST_REPO, ensurePfQuest, checkLicense } = require('../data/pfquest');
const { ROOT } = require('../paths');

const ADDON = 'Polestar_Names';
// QuestieDB's config.locales (enUS is the base data, never a block).
const LOCALES = ['deDE', 'esES', 'esMX', 'frFR', 'koKR', 'ptBR', 'ruRU', 'zhCN', 'zhTW'];
const KINDS = [
	{ kind: 'npc', questie: 'Npc', pfquest: 'units' },
	{ kind: 'object', questie: 'Object', pfquest: 'objects' },
];
const L10N_VERSION = '1';
// The compiled files whose goals name NPCs and objects.
const INPUTS = [path.join('addon', 'Polestar_Guides', 'Guides.lua'), path.join('addon', 'Polestar', 'Core', 'ClassTrainers.lua')];

// --- the IDs our guides name -------------------------------------------------

const LUA_STRING = '"((?:[^"\\\\]|\\\\.)*)"';
const ESCAPES = { n: '\n', r: '\r', t: '\t', '\\': '\\', '"': '"' };

// The body of a Lua string literal as the compiler writes it (emit.js luaString).
function unescapeLua(body) {
	return body.replace(/\\(\d{1,3}|.)/g, (_, e) => (/^\d/.test(e) ? String.fromCharCode(Number(e)) : (ESCAPES[e] ?? e)));
}

// Compiled Lua texts -> { npc: Map id -> Set of English names, object: ... }:
// talk/accept/turnin/... goals and candidates (`npc = 1, npcName = "..."`),
// kill goals (`target = "...", npc = 1`) and objects (`object = 1, objName = "..."`).
function usedNames(texts) {
	const out = { npc: new Map(), object: new Map() };
	const add = (kind, id, name) => {
		const set = out[kind].get(id) || new Set();
		set.add(unescapeLua(name));
		out[kind].set(id, set);
	};
	const patterns = [
		['npc', new RegExp(`\\bnpc = (\\d+), npcName = ${LUA_STRING}`, 'g'), 1, 2],
		['npc', new RegExp(`\\btarget = ${LUA_STRING}, npc = (\\d+)`, 'g'), 2, 1],
		['object', new RegExp(`\\bobject = (\\d+), objName = ${LUA_STRING}`, 'g'), 1, 2],
	];
	for (const text of texts) {
		for (const [kind, re, idAt, nameAt] of patterns) {
			for (const m of text.matchAll(re)) add(kind, Number(m[idAt]), m[nameAt]);
		}
	}
	return out;
}

// --- QuestieDB ---------------------------------------------------------------

// -> { info: { version, commit }, names: { locale: { npc: Map, object: Map } } }
// with only the IDs of `used` read.
function readQuestieNames(dir, used, locales = LOCALES) {
	const qdir = questieDbDir(dir);
	if (!qdir) throw new Error(`QuestieDB: no ${TOC} under ${dir}`);
	const meta = parseToc(fs.readFileSync(path.join(qdir, TOC), 'utf8'));
	const format = meta.get('X-l10n-Version');
	if (format !== L10N_VERSION) throw new Error(`QuestieDB: localization format ${format === undefined ? 'missing' : format}, expected ${L10N_VERSION}`);
	const block = (key) => {
		const v = storedValue(meta, key);
		return v === null ? null : decodeCbor(zlib.inflateSync(Buffer.from(v, 'base64')));
	};
	const names = {};
	for (const locale of locales) names[locale] = { npc: new Map(), object: new Map() };
	for (const { kind, questie } of KINDS) {
		const ids = block(`X-${questie}-IDS`);
		if (!ids) throw new Error(`QuestieDB: missing metadata key X-${questie}-IDS`);
		const position = new Map(luaList(ids).map((id, i) => [id, i + 1]));
		for (const locale of locales) {
			const b = block(`X-l10n-${locale}-${questie}`);
			const column = b && luaGet(b, 1);
			if (!column) continue;
			for (const id of used[kind].keys()) {
				const name = position.has(id) ? luaGet(column, position.get(id)) : undefined;
				if (typeof name === 'string' && name !== '') names[locale][kind].set(id, name);
			}
		}
	}
	return { info: { version: meta.get('Version') || null, commit: meta.get('X-BUILD-COMMIT') || null }, names };
}

// --- pfQuest ------------------------------------------------------------------

const PF_PRELUDE = `
pfDB = setmetatable({}, { __index = function(t, k) local v = {} rawset(t, k, v) return v end })
`;

// -> { revision, notice, en: { npc: Map, object: Map }, names: { locale: { npc, object } } }
function readPfQuestNames(dir, locales = LOCALES) {
	const { revision } = ensurePfQuest({ dir, explicit: true });
	const { notice } = checkLicense(dir);
	const db = path.join(dir, 'db');
	const present = ['enUS', ...locales].filter((l) => fs.existsSync(path.join(db, l)));
	if (!present.includes('enUS')) throw new Error(`pfQuest: missing ${path.join('db', 'enUS')}`);
	const files = [];
	for (const l of present) for (const { pfquest } of KINDS) {
		const f = path.join(db, l, `${pfquest}.lua`);
		if (fs.existsSync(f)) files.push(f);
	}
	const expr = `
local function list(t)
  local out = {}
  for k, v in pairs(t or {}) do if type(k) == "number" and type(v) == "string" then out[#out + 1] = { k, v } end end
  return out
end
local out = {}
for _, l in ipairs({ ${present.map(luaString).join(', ')} }) do
  out[l] = { npc = list(rawget(pfDB.units, l)), object = list(rawget(pfDB.objects, l)) }
end
return out`;
	const raw = luaToJson({ files, prelude: PF_PRELUDE, expr });
	// An empty Lua table comes back as {}.
	const map = (list) => new Map((Array.isArray(list) ? list : []).map(([k, v]) => [Number(k), v]));
	const maps = (r) => ({ npc: map(r?.npc), object: map(r?.object) });
	const names = {};
	for (const l of locales) names[l] = maps(raw[l]);
	return { revision, notice, en: maps(raw.enUS), names };
}

// --- merge ----------------------------------------------------------------------

// used: usedNames(); questie / pfquest: their readers' results (either may be
// null). -> { locale: { npc: [[id, name]], object: [[id, name]] (ascending),
//   counts: { questie, pfquest, renamed } } } for the locales with a name.
function mergeNames(used, { questie, pfquest }, locales = LOCALES) {
	const out = {};
	for (const locale of locales) {
		const counts = { questie: 0, pfquest: 0, renamed: 0 };
		const res = { npc: [], object: [], counts };
		for (const { kind } of KINDS) {
			for (const id of [...used[kind].keys()].sort((a, b) => a - b)) {
				const english = used[kind].get(id);
				const era = pfquest && pfquest.en[kind].get(id);
				if (era !== undefined && !english.has(era)) {
					counts.renamed++;
					continue;
				}
				let name = questie && questie.names[locale] && questie.names[locale][kind].get(id);
				let from = 'questie';
				if (!name && era !== undefined) {
					name = pfquest.names[locale] && pfquest.names[locale][kind].get(id);
					from = 'pfquest';
				}
				if (!name || english.has(name)) continue;
				res[kind].push([id, name]);
				counts[from]++;
			}
		}
		if (res.npc.length || res.object.length) out[locale] = res;
	}
	return out;
}

// --- output --------------------------------------------------------------------

const SOURCES = "QuestieDB's Forever store and pfQuest's locale databases";

function emitLocale(locale, { npc, object }) {
	const rows = (list) => list.map(([id, name]) => `[${id}]=${luaString(name)},`);
	return [
		header('lua', 'names build', SOURCES),
		`-- ${locale} names of the NPCs and objects Polestar's guides name (facts only;`,
		'-- sources and their licences in LICENSE-DATA.txt). The TOC loads this file only',
		'-- in a client of this language; the guard covers a client that loads every file.',
		'',
		`if GetLocale() ~= ${luaString(locale)} then return end`,
		'local Names = Polestar and Polestar.LocalNames',
		'if not (Names and Names.Register) then return end',
		'',
		`Names.Register(${luaString(locale)}, {`,
		...rows(npc),
		'}, {',
		...rows(object),
		'})',
		'',
	].join('\n');
}

function emitToc(version, locales) {
	return [
		'## Interface: 16001',
		'## Title: Polestar Names',
		"## Notes: NPC and object names in your client's language for Polestar's guides. Loaded on demand.",
		'## Author: Polestar',
		'## X-License: GPL-3.0-only',
		`## Version: ${version}`,
		'## Category: Quests',
		'## LoadOnDemand: 1',
		'## Dependencies: Polestar',
		`## X-Locales: ${locales.join(', ')}`,
		'',
		...locales.map((l) => `${l}.lua [AllowLoadTextLocale ${l}]`),
		'',
	].join('\n');
}

function emitLicense({ questie, pfquest }) {
	const lines = [
		'Polestar names: third-party notices',
		'===================================',
		'',
		"The <locale>.lua files hold NPC and object names in the game client's",
		"languages, for the IDs Polestar's guides name: facts (game data names),",
		'filled in from the sources below.',
		'',
	];
	if (questie) {
		lines.push(
			'QuestieDB (Questie-Forever), baked Forever store: localized names',
			'----------------------------------------------------------------',
			`URL: ${QUESTIE_REPO}`,
			`Revision: ${[questie.info.version, questie.info.commit].filter(Boolean).join(' ') || 'unknown'}`,
			'License: No license file in Questie/Questie or Questie/QuestieDB; CurseForge lists GPL-3.0, and the maintainers ask that it be treated as all rights reserved (https://github.com/Questie/Questie/issues/4447). Read from the local install; facts only (NPC and object names) ship here, credited here, and come out if the maintainers ask.',
			'',
		);
	}
	if (pfquest) {
		lines.push('pfQuest', '-------', `URL: ${PFQUEST_REPO}`, `Revision: ${pfquest.revision || 'unknown'}`, 'License: MIT', '', pfquest.notice, '');
	}
	return lines.join('\n');
}

function packageVersion() {
	try {
		return JSON.parse(fs.readFileSync(path.join(ROOT, 'package.json'), 'utf8')).version || '0.0.0';
	} catch {
		return '0.0.0';
	}
}

// -> { outDir, locales: { locale: { npc, object, questie, pfquest, renamed, bytes } }, used: { npc, object } }
function buildNames({ questieDir, pfquestDir, inputs, outDir, version, log = () => {} } = {}) {
	if (!questieDir && !pfquestDir) throw new Error('names build: no source (QuestieDB or pfQuest)');
	inputs = inputs || INPUTS.map((f) => path.join(ROOT, f));
	outDir = outDir || path.join(ROOT, 'addon', ADDON);
	const used = usedNames(inputs.map((f) => fs.readFileSync(f, 'utf8')));
	log(`names: ${used.npc.size} NPCs and ${used.object.size} objects named by ${inputs.map((f) => path.relative(process.cwd(), f)).join(', ')}`);
	const questie = questieDir ? readQuestieNames(questieDir, used) : null;
	const pfquest = pfquestDir ? readPfQuestNames(pfquestDir) : null;
	const merged = mergeNames(used, { questie, pfquest });
	const locales = Object.keys(merged);
	if (!locales.length) throw new Error('names build: no localized name found');
	const files = {};
	const stats = {};
	for (const l of locales) {
		files[`${l}.lua`] = emitLocale(l, merged[l]);
		stats[l] = { npc: merged[l].npc.length, object: merged[l].object.length, ...merged[l].counts, bytes: Buffer.byteLength(files[`${l}.lua`]) };
	}
	files[`${ADDON}.toc`] = emitToc(version || packageVersion(), locales);
	files['LICENSE-DATA.txt'] = emitLicense({ questie, pfquest });
	fs.mkdirSync(outDir, { recursive: true });
	// A locale no longer built leaves no file behind.
	for (const f of fs.readdirSync(outDir)) if (f.endsWith('.lua') && !(f in files)) fs.rmSync(path.join(outDir, f));
	for (const [name, text] of Object.entries(files)) fs.writeFileSync(path.join(outDir, name), text);
	return { outDir, locales: stats, used: { npc: used.npc.size, object: used.object.size } };
}

module.exports = { buildNames, usedNames, readQuestieNames, readPfQuestNames, mergeNames, emitLocale, emitToc, emitLicense, unescapeLua, ADDON, LOCALES, INPUTS };
