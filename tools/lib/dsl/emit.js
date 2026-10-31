'use strict';
// Emitter: compiled guides → Lua source for a guide pack addon
// (docs/ARCHITECTURE.md, "Guide data"). Output is deterministic: fixed key
// order, stable number formatting, sorted guides.

const { FORMAT, NEEDS, TOC_MARKER, TOC_TITLE_PREFIX, LEGACY_TOC_TITLE_PREFIX } = require('../pack/format');
const { header } = require('../generated');

const GUIDE_KEYS = ['id', 'pack', 'title', 'faction', 'races', 'classes', 'minLevel', 'maxLevel', 'category', 'folder', 'keywords', 'collects', 'reward', 'why', 'zone', 'zoneName', 'next', 'nextChoices', 'nextWhen', 'pitch', 'pros', 'cons', 'author', 'version', 'group', 'names', 'written', 'steps'];
// `image` follows note, so a step without one is emitted as before.
const STEP_KEYS = ['title', 'note', 'image', 'label', 'only', 'when', 'along', 'skipto', 'goals'];
// A step's picture: its path in the pack's addon folder (no extension) and its size in pixels.
const IMAGE_KEYS = ['file', 'w', 'h'];
// A step's `when` predicates and a `next` option's (`nextWhen`, format 4), in this key order.
const WHEN_KEYS = ['k', 'neg', 'op', 'n', 'frac', 'q', 'item', 'spell', 'name', 'label', 'area', 'map', 'skillLine', 'minLevel', 'pre', 'preAll', 'closedBy'];
// Keys only the profession/reputation/exploration/achievement verbs use sit
// where no other goal has a value, so adding them left older output unchanged.
// `z` (heights.js) follows y, `node` and `area` (places.js) precede map: a
// goal without them is emitted as before.
const GOAL_KEYS = [
	't', 'class', 'spell', 'spellName', 'faction', 'factionName', 'standing', 'achievement', 'achievementName', 'criteria',
	'quest', 'title', 'target', 'npc', 'npcName', 'object', 'objName', 'item', 'itemName', 'count', 'oi', 'skill', 'skillLine', 'rank', 'rankMax', 'level', 'frac', 'money', 'untilSkill',
	'reagents', 'location', 'minLevel', 'qlvl', 'pre', 'preAll', 'closedBy', 'preTitles', 'text', 'node', 'area', 'map', 'x', 'y', 'z', 'f', 'r', 'spots', 'spread', 'optional', 'only', 'profLine', 'profName', 'profRank', 'note',
	'from', 'fromKind', 'fromRank', 'fromFaction', 'fromAlso', 'fromId', 'fromAlsoId', 'fromNpcs', 'candidates', 'rewards', 'group', 'direct', 'escort',
];
const REAGENT_KEYS = ['item', 'itemName', 'count'];
// `z` (heights.js) follows y in candidates and spawn areas as in goals.
const CANDIDATE_KEYS = ['npc', 'npcName', 'map', 'x', 'y', 'z', 'f', 'faction', 'races', 'classes', 'lvl', 'rate', 'spawns'];
// A collect's `fromNpcs`: the creatures its point and spawn areas belong to.
const SOURCE_NPC_KEYS = ['npc', 'npcName'];
// Spawn areas: map-percent centre in the goal's map and frame, its height,
// radius in yards, spawn count, and `alt` for a place the arrow reaches only
// when moved on to it.
const SPOT_KEYS = ['x', 'y', 'z', 'r', 'n', 'alt'];
// A turn-in's `rewards = { choices, items, money, xp }`: item lists in this order.
const REWARD_KEYS = ['item', 'itemName', 'quality'];
// A guide's `reward = { ... }`: an item (`choice` when one of several), a spell or words.
const GUIDE_REWARD_KEYS = ['item', 'itemName', 'quality', 'choice', 'spell', 'spellName', 'text'];
// Farm-spot rates (items per kill) need three decimals; coordinates are already rounded to two.
const LIST_DECIMALS = { candidates: 3 };
const LIST_KEYS = { reagents: REAGENT_KEYS, candidates: CANDIDATE_KEYS, fromNpcs: SOURCE_NPC_KEYS, spots: SPOT_KEYS, items: REWARD_KEYS, choices: REWARD_KEYS, reward: GUIDE_REWARD_KEYS };
const ONLY_KEYS = ['classes', 'races', 'factions'];
// RegisterPack's keys in order (`addon` and `format` are written by the compiler).
const PACK_KEYS = ['id', 'title', 'author', 'version', 'license', 'website', 'source', 'notes'];
const FRAME_KEYS = ['c', 'left', 'right', 'top', 'bottom'];

const HEADER = header('lua', 'forge guide compile', 'the .guide files');
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

const LUA_KEYWORDS = new Set(['and', 'break', 'do', 'else', 'elseif', 'end', 'false', 'for', 'function', 'goto', 'if', 'in', 'local', 'nil', 'not', 'or', 'repeat', 'return', 'then', 'true', 'until', 'while']);

// A table key: a Lua identifier bare, anything else as a quoted string, so
// no key can break out of the table it sits in.
function luaKey(k) {
	const s = String(k);
	return /^[A-Za-z_][A-Za-z0-9_]*$/.test(s) && !LUA_KEYWORDS.has(s) ? s : `[${luaString(s)}]`;
}

// A key in canonical integer form ("123", "-4"), emitted as `[123]`.
function isIntKey(k) {
	const n = Number(k);
	return Number.isSafeInteger(n) && String(n) === k;
}

function scalar(v, decimals) {
	if (typeof v === 'string') return luaString(v);
	if (typeof v === 'number') return luaNumber(v, decimals);
	if (typeof v === 'boolean') return v ? 'true' : 'false';
	throw new Error(`cannot emit ${typeof v} as a scalar`);
}

// Arrays of scalars, or of tables (reagents) with a fixed key order.
// `records`: a guide's shared candidate records (sharing(), #574), emitted
// as references; two entries of one list stay distinct tables (ranking keys
// by identity), so a record is referenced at most once per list.
function list(arr, keys, decimals, records) {
	const used = new Set();
	return `{ ${arr
		.map((v) => {
			const value = v !== null && typeof v === 'object' ? inline(v, keys || Object.keys(v).sort(), decimals) : scalar(v);
			const shared = records && records.get(value);
			if (!shared || used.has(shared)) return value;
			used.add(shared);
			return `candidateRecords[${shared}]`;
		})
		.join(', ')} }`;
}

// Integer-keyed map (e.g. preTitles: quest id -> title), keys ascending.
// Any key that is not an integer is emitted as a string, after the integers.
function idMap(obj) {
	const keys = Object.keys(obj);
	const ints = keys.filter(isIntKey).sort((a, b) => a - b);
	const rest = keys.filter((k) => !isIntKey(k)).sort();
	const parts = [...ints.map((k) => `[${k}] = ${scalar(obj[k])}`), ...rest.map((k) => `${luaKey(k)} = ${scalar(obj[k])}`)];
	return `{ ${parts.join(', ')} }`;
}

// `shared`: a guide's sharing() (goals only), for its candidate lists.
function inline(obj, keys, decimals, shared) {
	const parts = [];
	for (const k of keys) {
		const v = obj[k];
		if (v === undefined || v === null) continue;
		if (Array.isArray(v)) {
			const value = list(v, LIST_KEYS[k] || null, LIST_DECIMALS[k], k === 'candidates' && shared ? shared.records : null);
			const ref = k === 'candidates' && shared && shared.lists.get(value);
			parts.push(`${luaKey(k)} = ${ref ? `candidateLists[${ref}]` : value}`);
		} else if (k === 'preTitles') parts.push(`${luaKey(k)} = ${idMap(v)}`);
		else if (typeof v === 'object') parts.push(`${luaKey(k)} = ${inline(v, k === 'only' ? ONLY_KEYS : k === 'lvl' ? ['min', 'max'] : Object.keys(v).sort(), decimals)}`);
		else parts.push(`${luaKey(k)} = ${scalar(v, decimals)}`);
	}
	return parts.length ? `{ ${parts.join(', ')} }` : '{}';
}

// Candidate lists and records repeated inside one guide, built once and
// referenced (#574, HershelW): { records, lists } value -> index, and the
// Lua lines declaring them. Candidates are read-only; a goal's pick and
// ranking are its own. Nothing is shared across guides (a guide of the other
// faction keeps none of this one's data), nor spawn spots (visits key by
// identity).
function sharing(steps) {
	const counts = new Map();
	const records = new Map();
	for (const step of steps) {
		for (const goal of step.goals || []) {
			if (!goal.candidates) continue;
			const value = list(goal.candidates, CANDIDATE_KEYS, LIST_DECIMALS.candidates);
			if (!counts.has(value)) {
				counts.set(value, { candidates: goal.candidates, n: 0 });
				// Each distinct list counts its records once: a repeated list is shared whole.
				for (const c of goal.candidates) {
					const record = inline(c, CANDIDATE_KEYS, LIST_DECIMALS.candidates);
					records.set(record, (records.get(record) || 0) + 1);
				}
			}
			counts.get(value).n++;
		}
	}
	const shared = { records: new Map(), lists: new Map() };
	for (const [value, n] of records) if (n > 1) shared.records.set(value, shared.records.size + 1);
	for (const { candidates, n } of counts.values()) {
		if (n > 1) shared.lists.set(list(candidates, CANDIDATE_KEYS, LIST_DECIMALS.candidates, shared.records), shared.lists.size + 1);
	}
	const lines = [];
	for (const [name, map] of [['candidateRecords', shared.records], ['candidateLists', shared.lists]]) {
		if (!map.size) continue;
		lines.push(`local ${name} = {`, ...[...map.keys()].map((value) => `\t${value},`), '}');
	}
	shared.lines = lines;
	return shared;
}

// One guide's block of Guides.lua: its table is built inside its own
// function, so Lua 5.1's per-function constant limit applies per guide.
// A guide's steps as Lua table source lines, each line indented by `ind`.
function stepLines(steps, ind, shared) {
	const out = [`${ind}{`];
	for (const step of steps) {
		out.push(`${ind}\t{`);
		for (const sk of STEP_KEYS) {
			const sv = step[sk];
			if (sv === undefined || sv === null) continue;
			if (sk === 'goals') {
				out.push(`${ind}\t\tgoals = {`);
				for (const goal of sv) out.push(`${ind}\t\t\t${inline(goal, GOAL_KEYS, undefined, shared)},`);
				out.push(`${ind}\t\t},`);
			} else if (sk === 'only') out.push(`${ind}\t\tonly = ${inline(sv, ONLY_KEYS)},`);
			else if (sk === 'image') out.push(`${ind}\t\timage = ${inline(sv, IMAGE_KEYS)},`);
			else if (sk === 'when') out.push(`${ind}\t\twhen = ${list(sv, WHEN_KEYS)},`);
			// `skipto` (format 5): each jump's label, then its one predicate.
			else if (sk === 'skipto') out.push(`${ind}\t\tskipto = { ${sv.map((k) => `{ to = ${luaString(k.to)}, when = ${inline(k.when, WHEN_KEYS)} }`).join(', ')} },`);
			else out.push(`${ind}\t\t${sk} = ${scalar(sv)},`);
		}
		out.push(`${ind}\t},`);
	}
	out.push(`${ind}}`);
	return out;
}

// `deferred` (a race part's guide, docs/PACK_FORMAT.md "Race parts"): the
// steps as one source string (`stepsSrc`, `return { ... }`, run on first
// read) with `stepCount`, and the guide registers only for a character of
// one of its classes (Polestar.PartWants).
function emitGuide(guide, sourceRel, { deferred = false } = {}) {
	const out = [];
	if (sourceRel) out.push(`-- Source: ${sourceRel.replace(/[\r\n]/g, ' ')}`);
	const shared = sharing(guide.steps || []);
	out.push('do', '\tlocal function register()');
	// Deferred steps carry their shared candidates inside their own source.
	if (!deferred) for (const line of shared.lines) out.push(`\t\t${line}`);
	out.push('\t\tPolestar.RegisterGuide({');
	for (const k of GUIDE_KEYS) {
		const v = guide[k];
		if (v === undefined || v === null) continue;
		if (k === 'steps' && deferred) {
			out.push(`\t\t\tstepCount = ${v.length},`);
			// The group quests its steps ask about (`when group`), for the
			// options' list without reading the steps (Engine.GroupQuests).
			const groups = [];
			for (const step of v) {
				for (const p of step.when || []) {
					if (p.k !== 'group' || groups.some((x) => x.quest === p.q)) continue;
					const goal = (step.goals || []).find((g) => g.quest === p.q && g.title);
					groups.push({ quest: p.q, title: goal ? goal.title : step.title });
				}
			}
			if (groups.length) out.push(`\t\t\tgroupQuests = { ${groups.map((x) => `{ quest = ${x.quest}${x.title ? `, title = ${luaString(x.title)}` : ''} }`).join(', ')} },`);
			out.push(`\t\t\tstepsSrc = ${luaString([...shared.lines, `return ${stepLines(v, '', shared).join('\n')}`].join('\n'))},`);
		} else if (k === 'steps') {
			const lines = stepLines(v, '\t\t\t', shared);
			out.push(`\t\t\tsteps = {`, ...lines.slice(1, -1), '\t\t\t},');
		} else if (k === 'nextWhen') {
			// guide id -> its predicates, in the order of nextChoices.
			out.push(`\t\t\tnextWhen = { ${Object.keys(v).map((id) => `[${luaString(id)}] = ${list(v[id], WHEN_KEYS)}`).join(', ')} },`);
		} else if (k === 'names' || k === 'written') {
			// The English of the texts' name tokens (tools/lib/dsl/tokens.js), "kind:id" -> name;
			// written: the author's words of a text that spells a name otherwise, tokenised text -> words.
			out.push(`\t\t\t${k} = { ${Object.keys(v).sort().map((t) => `[${luaString(t)}] = ${luaString(v[t])}`).join(', ')} },`);
		} else if (Array.isArray(v)) out.push(`\t\t\t${k} = ${list(v, LIST_KEYS[k] || null)},`);
		else out.push(`\t\t\t${k} = ${scalar(v)},`);
	}
	const classes = deferred && Array.isArray(guide.classes) && guide.classes.length ? guide.classes : null;
	out.push('\t\t})', '\tend', classes ? `\tif Polestar.PartWants(${list(classes)}) then register() end` : '\tregister()', 'end');
	return `${out.join('\n')}\n`;
}

// The data emitGuide writes, as plain JSON values instead of Lua source: the
// same keys in the same places, numbers rounded as luaNumber rounds them, so
// a guide carried another way (an import string, tools/lib/pack/importstring.js)
// registers exactly as Guides.lua registers it. `pack` is left out: the
// carrier names the pack. preTitles keeps its quest ids as the object's keys.
function dataScalar(v, decimals) {
	if (typeof v === 'number') return Number(luaNumber(v, decimals));
	if (typeof v === 'string' || typeof v === 'boolean') return v;
	throw new Error(`cannot write ${typeof v} as a scalar`);
}

function dataList(arr, keys, decimals) {
	return arr.map((v) => (v !== null && typeof v === 'object' ? dataInline(v, keys || Object.keys(v).sort(), decimals) : dataScalar(v)));
}

function dataInline(obj, keys, decimals) {
	const out = {};
	for (const k of keys) {
		const v = obj[k];
		if (v === undefined || v === null) continue;
		if (Array.isArray(v)) out[k] = dataList(v, LIST_KEYS[k] || null, LIST_DECIMALS[k]);
		else if (k === 'preTitles') {
			const ids = {};
			for (const id of Object.keys(v).map(Number).sort((a, b) => a - b)) ids[id] = dataScalar(v[id]);
			out[k] = ids;
		} else if (typeof v === 'object') out[k] = dataInline(v, k === 'only' ? ONLY_KEYS : k === 'lvl' ? ['min', 'max'] : Object.keys(v).sort(), decimals);
		else out[k] = dataScalar(v, decimals);
	}
	return out;
}

function guideData(guide) {
	const out = {};
	for (const k of GUIDE_KEYS) {
		const v = guide[k];
		if (v === undefined || v === null || k === 'pack') continue;
		if (k === 'steps') {
			out.steps = v.map((step) => {
				const s = {};
				for (const sk of STEP_KEYS) {
					const sv = step[sk];
					if (sv === undefined || sv === null) continue;
					if (sk === 'goals') s.goals = sv.map((goal) => dataInline(goal, GOAL_KEYS));
					else if (sk === 'only') s.only = dataInline(sv, ONLY_KEYS);
					else if (sk === 'image') s.image = dataInline(sv, IMAGE_KEYS);
					else if (sk === 'when') s.when = dataList(sv, WHEN_KEYS);
					else if (sk === 'skipto') s.skipto = sv.map((k) => ({ to: k.to, when: dataInline(k.when, WHEN_KEYS) }));
					else s[sk] = dataScalar(sv);
				}
				return s;
			});
		} else if (k === 'nextWhen') {
			const m = {};
			for (const id of Object.keys(v)) m[id] = dataList(v[id], WHEN_KEYS);
			out[k] = m;
		} else if (k === 'names' || k === 'written') {
			const m = {};
			for (const t of Object.keys(v).sort()) m[t] = String(v[t]);
			out[k] = m;
		} else if (Array.isArray(v)) out[k] = dataList(v, LIST_KEYS[k] || null);
		else out[k] = dataScalar(v);
	}
	return out;
}

// Era frames as emitMapFrames writes them: { [mapId]: { c, left, right, top, bottom } }.
function framesData(frames) {
	const out = {};
	for (const id of Object.keys(frames).map(Number).sort((a, b) => a - b)) out[id] = dataInline(frames[id], FRAME_KEYS, 4);
	return out;
}

// Guides.lua: every guide's block, sorted by id. entries: [{ guide, source }].
function emitGuides(entries, opts) {
	const sorted = entries.slice().sort((a, b) => (a.guide.id < b.guide.id ? -1 : a.guide.id > b.guide.id ? 1 : 0));
	return [`${HEADER}\n`, ...sorted.map((e) => emitGuide(e.guide, e.source, opts))].join('\n');
}

// Pack.lua: the pack's registration with its credits (manifest: pack.json, read by tools/lib/pack/manifest.js).
// `format`: the one its guides need (pack/format.js formatFor), FORMAT by default.
function emitPack(manifest, format = FORMAT) {
	const parts = ['addon = ADDON', `id = ${luaString(manifest.id)}`, `format = ${format}`];
	for (const k of PACK_KEYS.slice(1)) if (manifest[k] !== undefined && manifest[k] !== null) parts.push(`${k} = ${luaString(manifest[k])}`);
	return `${header('lua', 'forge guide compile', 'pack.json')}\nlocal ADDON = ...\n\nPolestar.RegisterPack({ ${parts.join(', ')} })\n`;
}

// <folder>.toc: the pack's metadata for the client and for Polestar's pack
// list (optional lines only when the value exists), then the fixed file set.
// A pack other than ours reads "Polestar Community: <title>" in the AddOns list.
// Every pack sits in Polestar's group there, under Polestar's own entry;
// Polestar's menus show the plain title (Pack.lua). A title
// already carrying that prefix or the legacy "Polestar Pack: " is kept.
function emitToc(manifest, iface, format = FORMAT) {
	const ours = manifest.id === 'guides';
	const prefixed = [TOC_TITLE_PREFIX, LEGACY_TOC_TITLE_PREFIX].some((p) => manifest.title.startsWith(p));
	const title = ours || prefixed ? manifest.title : `${TOC_TITLE_PREFIX}${manifest.title}`;
	const lines = [
		`## Interface: ${iface}`,
		`## Title: ${title}`,
		`## Notes: ${manifest.notes || `Community addon for Polestar by ${manifest.author}`}`,
		// Polestar's own pack: the AddOns list in the client's language too.
		...(ours ? require('../i18n/toc').tocLines('Polestar_Guides') : []),
		`## Author: ${manifest.author}`,
		`## Version: ${manifest.version}`,
		'## Category: Polestar',
		'## Group: Polestar',
	];
	lines.push(
		'## Dependencies: Polestar',
		`## X-Polestar-Pack: ${manifest.id}`,
		`## X-Polestar-Format: ${format}`,
		`## X-Polestar-Needs: ${NEEDS[format]}`,
		`## X-License: ${manifest.license}`,
	);
	if (manifest.website) lines.push(`## X-Website: ${manifest.website}`);
	lines.push(TOC_MARKER, '', ...PACK_SCRIPTS);
	return `${lines.join('\n')}\n`;
}

// A pack's race part (tools/lib/dsl/project.js buildPackFiles): the leveling
// guides for one race, <folder>_<race file>, which Polestar loads on demand
// once the pack is in, for a player of that race only (Core/Guides.lua). Its
// guides register into the pack; its TOC names the pack and the race, and
// (Polestar's own) the AddOns list in every client language. `files`:
// whether it holds guides (Guides.lua) and baked legs (Legs.lua).
function emitPartToc(manifest, race, iface, { guides = true, legs = false } = {}) {
	const lines = [
		`## Interface: ${iface}`,
		`## Title: ${manifest.title} (${race})`,
		guides
			? `## Notes: Leveling guides of ${manifest.title} for ${race} characters. Loaded on demand for that race.`
			: `## Notes: The walks of ${manifest.title}'s leveling guides for ${race} characters. Loaded on demand for that race.`,
		...(manifest.id === 'guides' ? require('../i18n/toc').tocLines(`Polestar_Guides_${race}`) : []),
		`## Author: ${manifest.author}`,
		`## Version: ${manifest.version}`,
		'## Category: Polestar',
		'## Group: Polestar',
		'## LoadOnDemand: 1',
		`## Dependencies: Polestar, ${manifest.folder}`,
		`## X-Polestar-Part: ${manifest.id}`,
		`## X-Polestar-Race: ${race}`,
		`## X-License: ${manifest.license}`,
		TOC_MARKER,
		'',
		...(guides ? ['Guides.lua'] : []),
		...(legs ? ['Legs.lua'] : []),
	];
	return `${lines.join('\n')}\n`;
}

// A race part's Legs.lua (docs/PACK_FORMAT.md, "Format 7"): the baked legs of
// the leveling guides a player of that race may follow, one
// Polestar.RegisterLegs call per grid they were baked on, guides by id, each
// step's leg as one string (forge::bake, Nav/Baked.lua).
function emitLegs(packId, guides) {
	const grids = [...new Set(guides.map((g) => g._legsGrid))].sort();
	const out = [header('lua', 'forge guide compile', 'legs.json'), ''];
	for (const grid of grids) {
		out.push(`Polestar.RegisterLegs(${luaString(packId)}, ${luaString(grid)}, {`);
		for (const g of guides.filter((x) => x._legsGrid === grid).sort((a, b) => (a.id < b.id ? -1 : a.id > b.id ? 1 : 0))) {
			const steps = Object.keys(g._legs).map(Number).sort((x, y) => x - y);
			out.push(`\t[${luaString(g.id)}] = { ${steps.map((s) => `[${s}] = ${luaString(g._legs[s])}`).join(', ')} },`);
		}
		out.push('})');
	}
	return `${out.join('\n')}\n`;
}

// The ids of guides a cutover retired (retired.json), after the pack's guides
// in Guides.lua: Polestar opens a saved tab of one as its successor.
function emitRetired(packId, ids) {
	return `\nPolestar.RetireGuides(${luaString(packId)}, {\n${ids.map((id) => `\t${luaString(id)},`).join('\n')}\n})\n`;
}

// A pack's texts addon for one language (docs/TRANSLATING.md, "Guide
// texts"): <folder>_<locale>, which Polestar loads on demand on that client
// only, once the pack's own files are in (Core/GuideTexts.lua). Its TOC
// names the pack it translates; the client lists it under Polestar. Our own
// pack's texts go into the language folder Polestar_<locale> beside the
// game's names (tools/lib/i18n/toc.js languageToc).
function emitTextsToc(manifest, locale, language, iface) {
	if (manifest.id === 'guides') return require('../i18n/toc').languageToc(locale, iface, manifest.version);
	const lines = [
		`## Interface: ${iface}`,
		`## Title: ${manifest.title} (${locale})`,
		`## Notes: ${language} texts of ${manifest.title}. Loaded on demand on a ${language} client.`,
		`## Author: ${manifest.author}`,
		`## Version: ${manifest.version}`,
		'## Category: Polestar',
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
	const out = [header('lua', 'forge guide compile', `the pack's locales/${locale}/ files`), '', 'local t = { guides = {} }', 't.pack = {', ...entries(t.pack || {}), '}'];
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
// from (candidates: { npc, npcName, map, x, y, z?, f, faction, classes }), with
// the Era bounds of every map they stand on. `z`: the trainer's spawn height
// (heights.js); the header then names CMaNGOS classic-db.
// trainers: the reminder's candidates (one per town and class); byClass:
// { classFile: [npcId, ...] }, every class trainer, for Engine.IsClassTrainer.
function emitClassTrainers(trainers, frames, byClass) {
	const ids = Object.keys(frames)
		.map(Number)
		.sort((a, b) => a - b);
	const heights = trainers.some((t) => t.z !== undefined);
	const out = [
		header('lua', 'trainers build', heights ? 'data/forever/trainers.json, the map frames and data/forever/spawnz.json (CMaNGOS classic-db spawn heights, GPL-3.0, used as facts)' : 'data/forever/trainers.json and the map frames'),
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

// A pack with baked legs (Legs.lua in its race parts) also credits the maps they were routed on.
const LEGS_NOTICE = [
	'Baked walking legs',
	'------------------',
	'The walks into the guides\' steps (Legs.lua in the race parts) were routed on',
	"Leffe's navigation maps, used with Leffe's permission given to Polestar's author.",
	"Credit: Leffe's navigation maps.",
	'',
];

function emitLicense(meta, legs = false) {
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
	if (legs) out.push(...LEGS_NOTICE);
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

module.exports = { emitGuides, emitPack, emitToc, emitTextsToc, emitPartToc, emitLegs, emitRetired, emitTexts, emitMapFrames, emitClassTrainers, emitLicense, luaString, luaNumber, luaKey, inline, idMap, guideData, framesData, GUIDE_KEYS, STEP_KEYS, IMAGE_KEYS, WHEN_KEYS, GOAL_KEYS, ONLY_KEYS, LIST_KEYS, FRAME_KEYS };
