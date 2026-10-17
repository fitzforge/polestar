'use strict';
// Emitter: compiled guides → Lua source for a guide pack addon
// (docs/ARCHITECTURE.md, "Guide data"). Output is deterministic: fixed key
// order, stable number formatting, sorted guides.

const { FORMAT, NEEDS, TOC_MARKER, TOC_TITLE_PREFIX } = require('../pack/format');
const { header } = require('../generated');

const GUIDE_KEYS = ['id', 'pack', 'title', 'faction', 'races', 'classes', 'minLevel', 'maxLevel', 'category', 'folder', 'keywords', 'collects', 'reward', 'why', 'zone', 'zoneName', 'next', 'nextChoices', 'pitch', 'pros', 'cons', 'author', 'version', 'group', 'names', 'written', 'steps'];
const STEP_KEYS = ['title', 'note', 'only', 'goals'];
// Keys only the profession/reputation/exploration/achievement verbs use sit
// where no other goal has a value, so adding them left older output unchanged.
// `z` (heights.js) follows y, `node` and `area` (places.js) precede map: a
// goal without them is emitted as before.
const GOAL_KEYS = [
	't', 'class', 'spell', 'spellName', 'faction', 'factionName', 'standing', 'achievement', 'achievementName', 'criteria',
	'quest', 'title', 'target', 'npc', 'npcName', 'object', 'objName', 'item', 'itemName', 'count', 'oi', 'skill', 'skillLine', 'rank', 'rankMax', 'level', 'untilSkill',
	'reagents', 'location', 'minLevel', 'qlvl', 'pre', 'preAll', 'closedBy', 'preTitles', 'text', 'node', 'area', 'map', 'x', 'y', 'z', 'f', 'r', 'spots', 'spread', 'optional', 'only', 'profLine', 'profName', 'profRank', 'note',
	'from', 'fromKind', 'fromRank', 'fromFaction', 'fromAlso', 'fromId', 'fromAlsoId', 'candidates', 'rewards', 'group', 'direct',
];
const REAGENT_KEYS = ['item', 'itemName', 'count'];
const CANDIDATE_KEYS = ['npc', 'npcName', 'map', 'x', 'y', 'f', 'faction', 'races', 'classes', 'lvl', 'rate', 'spawns'];
// Spawn areas: map-percent centre in the goal's map and frame, radius in yards,
// spawn count, and `alt` for a place the arrow reaches only when moved on to it.
const SPOT_KEYS = ['x', 'y', 'r', 'n', 'alt'];
// A turn-in's `rewards = { choices, items, money, xp }`: item lists in this order.
const REWARD_KEYS = ['item', 'itemName', 'quality'];
// A guide's `reward = { ... }`: an item (`choice` when one of several), a spell or words.
const GUIDE_REWARD_KEYS = ['item', 'itemName', 'quality', 'choice', 'spell', 'spellName', 'text'];
// Farm-spot rates (items per kill) need three decimals; coordinates are already rounded to two.
const LIST_DECIMALS = { candidates: 3 };
const LIST_KEYS = { reagents: REAGENT_KEYS, candidates: CANDIDATE_KEYS, spots: SPOT_KEYS, items: REWARD_KEYS, choices: REWARD_KEYS, reward: GUIDE_REWARD_KEYS };
const ONLY_KEYS = ['classes', 'races', 'factions'];
// RegisterPack's keys in order (`addon` and `format` are written by the compiler).
const PACK_KEYS = ['id', 'title', 'author', 'version', 'license', 'website', 'source', 'notes'];
const FRAME_KEYS = ['c', 'left', 'right', 'top', 'bottom'];

const HEADER = header('lua', 'compile', 'the .guide files');
// The fixed file set every pack loads, in order (a new guide changes Guides.lua, never this list).
const PACK_SCRIPTS = ['Pack.lua', 'MapFrames.lua', 'Guides.lua'];

function luaString(s) {
	let out = '"';
	for (const ch of String(s)) {
		const c = ch.codePointAt(0);
		if (ch === '\\') out += '\\\\';
		else if (ch === '"') out += '\\"';
		else if (ch === '\n') out += '\\n';
		else if (ch === '\r') out += '\\r';
		else if (ch === '\t') out += '\\t';
		else if (c < 32 || c === 127) out += `\\${String(c).padStart(3, '0')}`;
		else out += ch;
	}
	return `${out}"`;
}

// Stable numbers: integers as-is, others rounded to `decimals` with no
// exponent and no trailing zeros.
function luaNumber(n, decimals = 2) {
	if (!Number.isFinite(n)) throw new Error(`cannot emit non-finite number ${n}`);
	if (Number.isInteger(n)) return String(n);
	let s = n.toFixed(decimals);
	if (s.includes('.')) s = s.replace(/0+$/, '').replace(/\.$/, '');
	if (s === '-0') s = '0';
	return s;
}

function luaKey(k) {
	return /^[A-Za-z_][A-Za-z0-9_]*$/.test(k) ? k : `[${luaString(k)}]`;
}

function scalar(v, decimals) {
	if (typeof v === 'string') return luaString(v);
	if (typeof v === 'number') return luaNumber(v, decimals);
	if (typeof v === 'boolean') return v ? 'true' : 'false';
	throw new Error(`cannot emit ${typeof v} as a scalar`);
}

// Arrays of scalars, or of tables (reagents) with a fixed key order.
function list(arr, keys, decimals) {
	return `{ ${arr.map((v) => (v !== null && typeof v === 'object' ? inline(v, keys || Object.keys(v).sort(), decimals) : scalar(v))).join(', ')} }`;
}

// Integer-keyed map (e.g. preTitles: quest id -> title), keys ascending.
function idMap(obj) {
	const keys = Object.keys(obj)
		.map(Number)
		.sort((a, b) => a - b);
	return `{ ${keys.map((k) => `[${k}] = ${scalar(obj[k])}`).join(', ')} }`;
}

function inline(obj, keys, decimals) {
	const parts = [];
	for (const k of keys) {
		const v = obj[k];
		if (v === undefined || v === null) continue;
		if (Array.isArray(v)) parts.push(`${k} = ${list(v, LIST_KEYS[k] || null, LIST_DECIMALS[k])}`);
		else if (k === 'preTitles') parts.push(`${k} = ${idMap(v)}`);
		else if (typeof v === 'object') parts.push(`${k} = ${inline(v, k === 'only' ? ONLY_KEYS : k === 'lvl' ? ['min', 'max'] : Object.keys(v).sort(), decimals)}`);
		else parts.push(`${k} = ${scalar(v, decimals)}`);
	}
	return parts.length ? `{ ${parts.join(', ')} }` : '{}';
}

// One guide's block of Guides.lua: its table is built inside its own
// function, so Lua 5.1's per-function constant limit applies per guide.
function emitGuide(guide, sourceRel) {
	const out = [];
	if (sourceRel) out.push(`-- Source: ${sourceRel.replace(/[\r\n]/g, ' ')}`);
	out.push('do', '\tlocal function register()', '\t\tPolestar.RegisterGuide({');
	for (const k of GUIDE_KEYS) {
		const v = guide[k];
		if (v === undefined || v === null) continue;
		if (k === 'steps') {
			out.push('\t\t\tsteps = {');
			for (const step of v) {
				out.push('\t\t\t\t{');
				for (const sk of STEP_KEYS) {
					const sv = step[sk];
					if (sv === undefined || sv === null) continue;
					if (sk === 'goals') {
						out.push('\t\t\t\t\tgoals = {');
						for (const goal of sv) out.push(`\t\t\t\t\t\t${inline(goal, GOAL_KEYS)},`);
						out.push('\t\t\t\t\t},');
					} else if (sk === 'only') out.push(`\t\t\t\t\tonly = ${inline(sv, ONLY_KEYS)},`);
					else out.push(`\t\t\t\t\t${sk} = ${scalar(sv)},`);
				}
				out.push('\t\t\t\t},');
			}
			out.push('\t\t\t},');
		} else if (k === 'names' || k === 'written') {
			// The English of the texts' name tokens (tools/lib/dsl/tokens.js), "kind:id" -> name;
			// written: the author's words of a text that spells a name otherwise, tokenised text -> words.
			out.push(`\t\t\t${k} = { ${Object.keys(v).sort().map((t) => `[${luaString(t)}] = ${luaString(v[t])}`).join(', ')} },`);
		} else if (Array.isArray(v)) out.push(`\t\t\t${k} = ${list(v, LIST_KEYS[k] || null)},`);
		else out.push(`\t\t\t${k} = ${scalar(v)},`);
	}
	out.push('\t\t})', '\tend', '\tregister()', 'end');
	return `${out.join('\n')}\n`;
}

// Guides.lua: every guide's block, sorted by id. entries: [{ guide, source }].
function emitGuides(entries) {
	const sorted = entries.slice().sort((a, b) => (a.guide.id < b.guide.id ? -1 : a.guide.id > b.guide.id ? 1 : 0));
	return [`${HEADER}\n`, ...sorted.map((e) => emitGuide(e.guide, e.source))].join('\n');
}

// Pack.lua: the pack's registration with its credits (manifest: pack.json, read by tools/lib/pack/manifest.js).
function emitPack(manifest) {
	const parts = ['addon = ADDON', `id = ${luaString(manifest.id)}`, `format = ${FORMAT}`];
	for (const k of PACK_KEYS.slice(1)) if (manifest[k] !== undefined && manifest[k] !== null) parts.push(`${k} = ${luaString(manifest[k])}`);
	return `${header('lua', 'compile', 'pack.json')}\nlocal ADDON = ...\n\nPolestar.RegisterPack({ ${parts.join(', ')} })\n`;
}

// <folder>.toc: the pack's metadata for the client and for Polestar's pack
// list (optional lines only when the value exists), then the fixed file set.
// A pack other than ours reads "Polestar Pack: <title>" in the AddOns list and
// sits in Polestar's group there, under Polestar's own entry, like
// Polestar_Guides; Polestar's menus show the plain title (Pack.lua).
function emitToc(manifest, iface) {
	const ours = manifest.id === 'guides';
	const title = ours || manifest.title.startsWith(TOC_TITLE_PREFIX) ? manifest.title : `${TOC_TITLE_PREFIX}${manifest.title}`;
	const lines = [
		`## Interface: ${iface}`,
		`## Title: ${title}`,
		`## Notes: ${manifest.notes || `Guide pack for Polestar by ${manifest.author}`}`,
		// Polestar's own pack: the AddOns list in the client's language too.
		...(ours ? require('../i18n/toc').tocLines('Polestar_Guides') : []),
		`## Author: ${manifest.author}`,
		`## Version: ${manifest.version}`,
		'## Category: Quests',
	];
	if (!ours) lines.push('## Group: Polestar');
	lines.push(
		'## Dependencies: Polestar',
		`## X-Polestar-Pack: ${manifest.id}`,
		`## X-Polestar-Format: ${FORMAT}`,
		`## X-Polestar-Needs: ${NEEDS[FORMAT]}`,
		`## X-License: ${manifest.license}`,
	);
	if (manifest.website) lines.push(`## X-Website: ${manifest.website}`);
	lines.push(TOC_MARKER, '', ...PACK_SCRIPTS);
	return `${lines.join('\n')}\n`;
}

// A pack's texts addon for one language (docs/TRANSLATING.md, "Guide
// texts"): <folder>_<locale>, which Polestar loads on demand on that client
// only, once the pack's own files are in (Core/GuideTexts.lua). Its TOC
// names the pack it translates; the client lists it under Polestar.
function emitTextsToc(manifest, locale, language, iface) {
	const lines = [
		`## Interface: ${iface}`,
		`## Title: ${manifest.title} (${locale})`,
		`## Notes: ${language} texts of ${manifest.title}. Loaded on demand on a ${language} client.`,
		// Polestar's own pack: the AddOns list in every client language too.
		...(manifest.id === 'guides' ? require('../i18n/toc').tocLines(`Polestar_Guides_${locale}`) : []),
		`## Author: ${manifest.author}`,
		`## Version: ${manifest.version}`,
		'## Category: Quests',
		'## Group: Polestar',
		'## LoadOnDemand: 1',
		'## Dependencies: Polestar',
		`## X-Polestar-Texts: ${manifest.id}`,
		`## X-Polestar-Locale: ${locale}`,
		`## X-License: ${manifest.license}`,
		TOC_MARKER,
		'',
		'Texts.lua',
	];
	return `${lines.join('\n')}\n`;
}

// Texts.lua: t = { pack: { english: translation }, guides: { [id]: { ... } } },
// registered for the pack in `locale`. Each guide's table is built in its own
// function: Lua 5.1 limits the constants of one.
function emitTexts(packId, locale, t) {
	const entries = (o) => Object.keys(o).sort().map((k) => `\t[${luaString(k)}] = ${luaString(o[k])},`);
	const out = [header('lua', 'compile', `the pack's locales/${locale}/ files`), '', 'local t = { guides = {} }', 't.pack = {', ...entries(t.pack || {}), '}'];
	const guides = t.guides || {};
	for (const id of Object.keys(guides).sort()) out.push(`t.guides[${luaString(id)}] = (function() return {`, ...entries(guides[id]).map((l) => `\t${l}`), '} end)()');
	out.push('', `Polestar.RegisterGuideTexts(${luaString(locale)}, ${luaString(packId)}, t)`, '');
	return out.join('\n');
}

// frames: { [mapId]: { c, left, right, top, bottom } }, registered for packId.
function emitMapFrames(frames, packId) {
	const ids = Object.keys(frames)
		.map(Number)
		.sort((a, b) => a - b);
	const out = [HEADER, '', 'Polestar.RegisterMapFrames({', '\tera = {'];
	for (const id of ids) out.push(`\t\t[${id}] = ${inline(frames[id], FRAME_KEYS, 4)},`);
	out.push('\t},', `}, ${luaString(packId)})`);
	return `${out.join('\n')}\n`;
}

// Core/ClassTrainers.lua: the class trainers the training reminder picks
// from (candidates: { npc, npcName, map, x, y, f, faction, classes }), with
// the Era bounds of every map they stand on.
// trainers: the reminder's candidates (one per town and class); byClass:
// { classFile: [npcId, ...] }, every class trainer, for Engine.IsClassTrainer.
function emitClassTrainers(trainers, frames, byClass) {
	const ids = Object.keys(frames)
		.map(Number)
		.sort((a, b) => a - b);
	const out = [
		header('lua', 'trainers build', 'data/forever/trainers.json and the map frames'),
		'local ADDON, ns = ...',
		'',
		'ns.RegisterMapFrames({',
		'\tera = {',
	];
	for (const id of ids) out.push(`\t\t[${id}] = ${inline(frames[id], FRAME_KEYS, 4)},`);
	out.push('\t},', '})', '', 'ns.RegisterClassTrainers({');
	for (const t of trainers) out.push(`\t${inline(t, CANDIDATE_KEYS)},`);
	out.push('})', '', 'ns.RegisterClassTrainerIds({');
	for (const cls of Object.keys(byClass || {}).sort()) out.push(`\t${cls} = { ${byClass[cls].join(', ')} },`);
	out.push('})');
	return `${out.join('\n')}\n`;
}

const MIT_BODY = `Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.`;

// pfQuest's own LICENSE (github.com/shagu/pfQuest), used when meta.json does
// not carry the copyright line itself.
const PFQUEST_COPYRIGHT = 'Copyright (c) 2017-2021 Eric Mauser (Shagu)';

function isPfQuest(src) {
	return /pfquest/i.test(`${src.name || ''} ${src.url || ''}`);
}

function emitLicense(meta) {
	const sources = (meta && Array.isArray(meta.sources) ? meta.sources : []).slice().sort((a, b) => String(a.name || '').localeCompare(String(b.name || '')));
	const out = [
		'Polestar guide data: third-party notices',
		'========================================',
		'',
		'The guides in this folder were written for Polestar. Quest titles, names and',
		'coordinates in them were filled in from the reference data sources below.',
		'',
	];
	if (!sources.length) out.push('No reference data sources were recorded (data/forever/meta.json has none).', '');
	for (const src of sources) {
		const title = String(src.name || 'Unnamed source');
		out.push(title, '-'.repeat(title.length));
		if (src.url) out.push(`URL: ${src.url}`);
		if (src.revision) out.push(`Revision: ${src.revision}`);
		if (src.license) out.push(`License: ${src.license}`);
		const copyright = src.copyright || (isPfQuest(src) ? PFQUEST_COPYRIGHT : null);
		if (src.notice) {
			out.push('', String(src.notice).replace(/\r\n/g, '\n').trimEnd());
		} else if (/^mit$/i.test(String(src.license || '').trim())) {
			out.push('', 'MIT License', '', copyright || `Copyright: see ${src.url || 'the source'}`, '', MIT_BODY);
		} else if (copyright) {
			out.push(copyright);
		}
		out.push('');
	}
	out.push(
		'Guide pack permission',
		'---------------------',
		"This folder was produced by Polestar's compiler. Polestar's LICENSE-EXCEPTION.md",
		'gives permission to distribute guide packs produced by the compiler, including',
		"the parts of Polestar's reference data placed in them, under terms of your",
		"choice. It does not cover guide text copied from Polestar's own guides, or",
		"Polestar's code.",
		'',
	);
	return `${out.join('\n').trimEnd()}\n`;
}

module.exports = { emitGuides, emitPack, emitToc, emitTextsToc, emitTexts, emitMapFrames, emitClassTrainers, emitLicense, luaString, luaNumber, GUIDE_KEYS, GOAL_KEYS };
