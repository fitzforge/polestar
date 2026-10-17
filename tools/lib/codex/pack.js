'use strict';
// Codex JSON (data/forever/codex/*.json, docs/SUITE.md "Data layer") -> the
// load-on-demand data addon Polestar_Codex, decoded in game by
// addon/Polestar/Lookup/Codex.lua. Same input gives byte-identical output.
//
//   const { emitPack } = require('./pack');
//   const files = emitPack(codex, { version: '0.1.0', build: '1.60.1.70338' });
//   // { 'Polestar_Codex.toc': text, 'Meta.lua': text, 'Items1.lua': text, ... }
//
// Every data file is a list of `C.Register(group, names, records, lo, hi)`
// calls whose arguments are long strings, not table constructors (a client
// parses a string literal several times faster than the same data as
// `[id]="..."` pairs, and Codex.lua indexes a chunk only when it is first
// read):
//   names   = "\n<id>\t<flags>\t<display name>" per entry (flags: item kinds'
//             quality digit + status letter, else empty)
//   records = "\n<id>\t<record>" per entry, or nil for names-only groups
//   lo, hi  = the chunk's first and last numeric id (nil for string keys)
// Files hold at most CHUNK entries each.
//
// Groups: item mount pet recipe tabard (items by kind), npc rare (NPCs),
// object treasure (objects), quest, instance, zone, faction, spell, skill
// (skillLine -> profession name, names only), role (npc role -> "id,id,...",
// names only). Meta.lua first registers the Era map frames (codex.frames) and
// C.Register("meta", { ...meta.json... }); Index.lua then registers one search
// index per searchable kind (SEARCH_KINDS), C.RegisterIndex(kind, blob):
//   "\2" .. folded .. "\1" .. id .. "," .. quality .. "," .. status .. "," .. #name .. "\n"
// per entry, folded = foldName(name) (Core/Search.lua's Search.Fold without its
// leading space), quality '' when unknown, status r|n|'' (items only), #name the
// display name's length in bytes. `extraFiles` load last.
//
// Record strings (fields split by ";", lists by ","; empty field = nil;
// strings escape % ; , ~ as %XX; coordinates are percent * 10, integers):
//   item     quality[status];reqLevel;spell;repFaction;repStanding;reqSkill;reqSkillRank;<source>;<source>...
//            status = r (retired: no longer obtainable) | n (no known source), right after the quality digit
//            source = <type letter><f1>,<f2>,...,<from letters>
//              v vendor npc,cost,limited   d drop npc,chance,instance   o object object,chance
//              q quest quest,choice        g gift npc,spell (an NPC hands it out)   c craft spell,skillLine,skill
//              r rep faction,standing,npc  p pvp rank,npc               n container item,chance
//              w world minLevel,maxLevel
//   npc      level;levelMax;faction;flags(r e b);instance;roles;loot;<spawns>...
//            spawns = map,f,x,y,x,y...   (one group per map); loot = item,item,...
//   object   treasure(1|empty);loot;<spawns>...
//   quest    level;minLevel;faction;races;classes;zone;startNpc;startObject;startItem;
//            endNpc;endObject;pre;rewards;choices;preAny;<objective>...[;<rep>]
//            objective = <k|i|o|e><id>,<count>,<text>
//            rep = r<faction>,<standing>: the standing its rewards need (an older
//                  reader skips it: no objective kind is r)
//   instance kind;forever(1|empty);areaId;map;entrance(map,x,y,f[,a]);levels;<boss>...
//            a: approximate (the client's corpse point, not the way in)
//            boss = name,ref,item,item...   ref = <npc> | o<object> (a chest boss), then
//                   r|e|x when its role is rare|event|optional (none: an encounter);
//                   an old pack's ref is the bare npc id, which still reads
//   faction  side            spell  kind;item;class            zone, skill: names only

const { header } = require('../generated');

const SCHEMA = 1;
const ADDON = 'Polestar_Codex';
const CHUNK = 4000;

const ITEM_KINDS = ['item', 'mount', 'pet', 'recipe', 'tabard'];

// Provenance names <-> one letter each (Codex.lua holds the same table).
const FROM = {
	atlasloot: 'a',
	client: 'c',
	dungeons: 'd',
	flbis: 'f',
	journal: 'j',
	guides: 'g',
	curated: 'u',
	recordings: 'l',
	pfquest: 'p',
	questie: 'q',
	rarescanner: 'r',
	wowhead: 'w',
	forever: 'e',
};

const SOURCE = {
	vendor: ['v', ['npc', 'cost', 'limited']],
	drop: ['d', ['npc', 'chance', 'instance']],
	object: ['o', ['object', 'chance']],
	quest: ['q', ['quest', 'choice']],
	gift: ['g', ['npc', 'spell']],
	craft: ['c', ['spell', 'skillLine', 'skill']],
	rep: ['r', ['faction', 'standing', 'npc']],
	pvp: ['p', ['rank', 'npc']],
	container: ['n', ['item', 'chance']],
	world: ['w', ['minLevel', 'maxLevel']],
};
const BOOL_FIELDS = new Set(['limited', 'choice']);
const STRING_FIELDS = new Set(['instance']);

const OBJECTIVE = { kill: 'k', item: 'i', object: 'o', event: 'e' };

function luaStr(s) {
	return `"${String(s).replace(/\\/g, '\\\\').replace(/"/g, '\\"').replace(/\n/g, '\\n').replace(/\r/g, '\\r').replace(/\0/g, '\\0')}"`;
}

// Record text: % ; , ~ and line breaks/tabs as %XX (Codex.lua's unesc).
function esc(s) {
	if (s === null || s === undefined) return '';
	return String(s).replace(/[%;,~\t\n\r]/g, (c) => `%${c.charCodeAt(0).toString(16).toUpperCase().padStart(2, '0')}`);
}

// A long Lua string literal: decimal escapes are 3 digits wide, so the digits
// that follow \1 and \2 in index lines never join them.
function luaBlob(s) {
	return `"${s.replace(/[\\"\n\r\t\0\x01\x02]/g, (c) => {
		if (c === '\\') return '\\\\';
		if (c === '"') return '\\"';
		if (c === '\n') return '\\n';
		if (c === '\r') return '\\r';
		if (c === '\t') return '\\t';
		return `\\${String(c.charCodeAt(0)).padStart(3, '0')}`;
	})}"`;
}

// A display name on one blob line.
function oneLine(s) {
	return String(s == null ? '' : s).replace(/[\t\n\r]/g, ' ');
}

// Core/Search.lua's fold (lines "Folding"), byte for byte: lower case (ASCII),
// Latin-1 letters (UTF-8 lead byte 0xC3) to ASCII, Œ œ to oe, Cyrillic
// capitals to lower case and Ё ё to е, ’ and ' dropped, other
// punctuation and control characters to spaces, runs of spaces collapsed,
// trimmed. Search.Fold returns it with a leading space; this does not.
const FOLD = {};
for (const [lo, hi, to] of [
	[0x80, 0x85, 'a'], [0x86, 0x86, 'ae'], [0x87, 0x87, 'c'], [0x88, 0x8b, 'e'],
	[0x8c, 0x8f, 'i'], [0x90, 0x90, 'd'], [0x91, 0x91, 'n'], [0x92, 0x96, 'o'],
	[0x98, 0x98, 'o'], [0x99, 0x9c, 'u'], [0x9d, 0x9d, 'y'], [0x9e, 0x9e, 'th'],
	[0x9f, 0x9f, 'ss'],
	[0xa0, 0xa5, 'a'], [0xa6, 0xa6, 'ae'], [0xa7, 0xa7, 'c'], [0xa8, 0xab, 'e'],
	[0xac, 0xaf, 'i'], [0xb0, 0xb0, 'd'], [0xb1, 0xb1, 'n'], [0xb2, 0xb6, 'o'],
	[0xb8, 0xb8, 'o'], [0xb9, 0xbc, 'u'], [0xbd, 0xbd, 'y'], [0xbe, 0xbe, 'th'],
	[0xbf, 0xbf, 'y'],
]) {
	for (let b = lo; b <= hi; b++) FOLD[String.fromCharCode(0xc3, b)] = to;
}
FOLD['\xc5\x92'] = FOLD['\xc5\x93'] = 'oe';
for (let b = 0x90; b <= 0x9f; b++) FOLD[String.fromCharCode(0xd0, b)] = String.fromCharCode(0xd0, b + 0x20);
for (let b = 0xa0; b <= 0xaf; b++) FOLD[String.fromCharCode(0xd0, b)] = String.fromCharCode(0xd1, b - 0x20);
FOLD['\xd0\x81'] = FOLD['\xd1\x91'] = '\xd0\xb5';

function foldName(name) {
	// One JS char per byte, as Lua sees the string.
	let s = Buffer.from(String(name == null ? '' : name), 'utf8').toString('latin1');
	s = s.replace(/[A-Z]/g, (c) => c.toLowerCase());
	if (/[\x80-\xff]/.test(s)) {
		s = s.replace(/[\xc3\xc5\xd0\xd1][\x80-\xbf]/g, (m) => FOLD[m] ?? m);
		s = s.split('\xe2\x80\x99').join('');
	}
	s = s.replace(/'/g, '');
	s = s.replace(/[\x00-\x1f\x7f!-/:-@[-`{-~]/g, ' ');
	s = s.replace(/[ \t\n\v\f\r]+/g, ' ');
	if (s.charCodeAt(0) !== 32) s = ` ${s}`;
	if (s.charCodeAt(s.length - 1) === 32) s = s.slice(0, -1);
	return Buffer.from(s.slice(1), 'latin1').toString('utf8');
}

function num(v) {
	if (v === null || v === undefined || v === '') return '';
	const n = Number(v);
	if (!Number.isFinite(n)) throw new Error(`codex pack: not a number: ${v}`);
	return String(n);
}

function list(arr) {
	return (Array.isArray(arr) ? arr : []).map(num).join(',');
}

function coord(v) {
	return String(Math.round(Number(v) * 10));
}

function fromLetters(from) {
	let out = '';
	for (const f of Array.isArray(from) ? from : []) {
		const c = FROM[f];
		if (!c) throw new Error(`codex pack: unknown source provenance "${f}" (add it to FROM in pack.js and Codex.lua)`);
		if (!out.includes(c)) out += c;
	}
	return out;
}

function encodeSource(src) {
	const def = SOURCE[src.type];
	if (!def) throw new Error(`codex pack: unknown source type "${src.type}"`);
	const [letter, fields] = def;
	const parts = fields.map((f) => {
		if (BOOL_FIELDS.has(f)) return src[f] ? '1' : '';
		if (STRING_FIELDS.has(f)) return esc(src[f]);
		return num(src[f]);
	});
	parts.push(fromLetters(src.from));
	return letter + parts.join(',');
}

function statusLetter(rec) {
	return rec.status === 'retired' ? 'r' : rec.status === 'nosource' ? 'n' : '';
}

function encodeItem(rec) {
	const head = [num(rec.quality) + statusLetter(rec), num(rec.reqLevel), num(rec.spell), num(rec.repFaction), num(rec.repStanding), num(rec.reqSkill), num(rec.reqSkillRank)];
	return [...head, ...(rec.sources || []).map(encodeSource)].join(';');
}

// [{ map, x, y, f }] -> ["map,f,x,y,x,y", ...] grouped per map in first-seen order.
function encodeSpawns(spawns) {
	const groups = new Map();
	for (const s of spawns || []) {
		const key = `${s.map}|${s.f || ''}`;
		if (!groups.has(key)) groups.set(key, [num(s.map), s.f || '']);
		groups.get(key).push(coord(s.x), coord(s.y));
	}
	return [...groups.values()].map((g) => g.join(','));
}

function encodeNpc(rec) {
	const flags = `${rec.rare ? 'r' : ''}${rec.elite ? 'e' : ''}${rec.boss ? 'b' : ''}`;
	const head = [num(rec.level), num(rec.levelMax), rec.faction || '', flags, esc(rec.instance), (rec.roles || []).map(esc).join(','), list(rec.loot)];
	return [...head, ...encodeSpawns(rec.spawns)].join(';');
}

function encodeObject(rec) {
	return [rec.treasure ? '1' : '', list(rec.loot), ...encodeSpawns(rec.spawns)].join(';');
}

function encodeQuest(rec) {
	const start = rec.start || {};
	const end = rec.end || {};
	const head = [
		num(rec.level),
		num(rec.minLevel),
		rec.faction || '',
		num(rec.races),
		num(rec.classes),
		num(rec.zone),
		list(start.npc),
		list(start.object),
		list(start.item),
		list(end.npc),
		list(end.object),
		list(rec.pre),
		list(rec.rewards),
		list(rec.choices),
		list(rec.preAny),
	];
	const objectives = (rec.objectives || []).map((o) => {
		const t = OBJECTIVE[o.type];
		if (!t) throw new Error(`codex pack: quest ${rec.id}: unknown objective type "${o.type}"`);
		return `${t}${num(o.id)},${num(o.count)},${esc(o.text)}`;
	});
	const rep = rec.repFaction && rec.repStanding ? [`r${num(rec.repFaction)},${num(rec.repStanding)}`] : [];
	return [...head, ...objectives, ...rep].join(';');
}

function encodeInstance(rec) {
	const e = rec.entrance;
	const head = [
		esc(rec.kind),
		rec.forever ? '1' : '',
		num(rec.areaId),
		num(rec.map),
		e ? [num(e.map), coord(e.x), coord(e.y), e.f || '', ...(e.approx ? ['a'] : [])].join(',') : '',
		list(rec.levels),
	];
	const bosses = (rec.bosses || []).map((b) => [esc(b.name), bossRef(b), ...(b.items || []).map(num)].join(','));
	return [...head, ...bosses].join(';');
}

const ROLE = { rare: 'r', event: 'e', optional: 'x' };
function bossRef(b) {
	const id = b.npc ? num(b.npc) : b.object ? `o${num(b.object)}` : '';
	if (b.role && !ROLE[b.role]) throw new Error(`codex pack: boss ${b.name}: unknown role "${b.role}"`);
	return `${id}${b.role ? ROLE[b.role] : ''}`;
}

function encodeSpell(rec) {
	return [esc(rec.kind), num(rec.item), esc(rec.class)].join(';');
}

function encodeFaction(rec) {
	return esc(rec.side);
}

// Lua literal for meta (plain JSON values; keys sorted).
function luaValue(v, indent = '') {
	if (v === null || v === undefined) return 'nil';
	if (typeof v === 'boolean') return v ? 'true' : 'false';
	if (typeof v === 'number') return Number.isFinite(v) ? String(v) : 'nil';
	if (typeof v === 'string') return luaStr(v);
	const inner = `${indent}\t`;
	if (Array.isArray(v)) {
		if (!v.length) return '{}';
		return `{\n${v.map((x) => `${inner}${luaValue(x, inner)},`).join('\n')}\n${indent}}`;
	}
	const keys = Object.keys(v)
		.filter((k) => v[k] !== null && v[k] !== undefined)
		.sort();
	if (!keys.length) return '{}';
	const key = (k) => (/^[A-Za-z_][A-Za-z0-9_]*$/.test(k) ? k : `[${luaStr(k)}]`);
	return `{\n${keys.map((k) => `${inner}${key(k)} = ${luaValue(v[k], inner)},`).join('\n')}\n${indent}}`;
}

function sortedIds(obj) {
	return Object.keys(obj || {}).sort((a, b) => {
		const na = Number(a);
		const nb = Number(b);
		if (Number.isFinite(na) && Number.isFinite(nb)) return na - nb;
		return a < b ? -1 : a > b ? 1 : 0;
	});
}

// Kinds with a search index (Codex.Index), in Search.KINDS order.
const SEARCH_KINDS = ['mount', 'pet', 'item', 'recipe', 'tabard', 'quest', 'npc', 'rare', 'instance', 'zone', 'treasure'];

const HEADER = [
	header('lua', 'codex build', 'the sources listed in Meta.lua'),
	'-- Facts (ids, names, levels, coordinates, rates, relations), merged. Decoded by',
	'-- Polestar/Lookup/Codex.lua.',
	'',
	'local C = Polestar and Polestar.Codex',
	'if not (C and C.Register) then return end',
	'',
];

// One file per chunk of `entries` ([id, name, record|null, flags|undefined]).
function emitGroup(group, entries, prefix, out, order) {
	for (let i = 0, part = 1; i < entries.length; i += CHUNK, part++) {
		const slice = entries.slice(i, i + CHUNK);
		const file = `${prefix}${part}.lua`;
		const names = slice.map(([id, name, , flags]) => `\n${id}\t${flags || ''}\t${oneLine(name)}`).join('');
		const withRecords = slice.some(([, , rec]) => rec !== null);
		const records = withRecords ? slice.map(([id, , rec]) => (rec === null ? '' : `\n${id}\t${rec}`)).join('') : null;
		const numeric = slice.every(([id]) => /^\d+$/.test(String(id)));
		const args = [luaStr(group), luaBlob(names), records === null ? 'nil' : luaBlob(records)];
		if (numeric) args.push(String(slice[0][0]), String(slice[slice.length - 1][0]));
		out[file] = [...HEADER, `C.Register(${args.join(', ')})`, ''].join('\n');
		order.push(file);
	}
}

// Index.lua: one search blob per searchable kind (see the header).
function emitIndex(index, out, order) {
	const lines = [...HEADER, 'if not C.RegisterIndex then return end', ''];
	for (const kind of SEARCH_KINDS) {
		const entries = index[kind] || [];
		const blob = entries
			.map(([id, name, quality, status]) => `\x02${foldName(name)}\x01${id},${num(quality)},${status || ''},${Buffer.byteLength(oneLine(name))}\n`)
			.join('');
		lines.push(`C.RegisterIndex(${luaStr(kind)}, ${luaBlob(blob)})`);
	}
	lines.push('');
	out['Index.lua'] = lines.join('\n');
	order.push('Index.lua');
}

function cap(s) {
	return s.charAt(0).toUpperCase() + s.slice(1);
}

function emitToc(version, files) {
	return [
		'## Interface: 16001',
		'## Title: Polestar Codex',
		'## Notes: Part of Polestar: items, mounts, pets, NPCs, quests and where to get them, dungeons and rares, for Lookup, Dungeons and Rares. Loaded on demand.',
		...require('../i18n/toc').tocLines('Polestar_Codex'),
		'## Author: Polestar',
		`## Version: ${version}`,
		'## Category: Quests',
		'## LoadOnDemand: 1',
		'## Dependencies: Polestar',
		'',
		...files,
		'',
	].join('\n');
}

// -> { [relativePath]: text } including Polestar_Codex.toc. `extraFiles`
// ([{ name, text }]) are copied verbatim and load last, in the given order
// (Journal's Dungeons1.lua).
function emitPack(codex, { version = '0.0.0', build = null, extraFiles = [] } = {}) {
	const out = {};
	const order = [];
	const items = codex.items || {};
	const npcs = codex.npcs || {};
	const objects = codex.objects || {};

	// skillLine -> profession, from the craft sources themselves.
	const skills = {};
	for (const id of sortedIds(items)) {
		for (const s of items[id].sources || []) {
			if (s.type === 'craft' && s.skillLine != null && s.profession) skills[s.skillLine] = s.profession;
		}
	}

	const meta = { ...(codex.meta || {}), schema: (codex.meta && codex.meta.schema) || SCHEMA };
	if (build && !meta.build) meta.build = build;
	const metaLines = [...HEADER];
	const frames = codex.frames || {};
	const frameIds = sortedIds(frames);
	if (frameIds.length) {
		metaLines.push('-- Era bounds of every map the Codex places points on (f = "e").', 'if Polestar.RegisterMapFrames then', '\tPolestar.RegisterMapFrames({ era = {');
		for (const id of frameIds) {
			const f = frames[id];
			metaLines.push(`\t\t[${id}] = { c = ${num(f.c)}, left = ${num(f.left)}, right = ${num(f.right)}, top = ${num(f.top)}, bottom = ${num(f.bottom)} },`);
		}
		metaLines.push('\t} })', 'end', '');
	}
	metaLines.push(`C.Register("meta", ${luaValue(meta)})`, '');
	out['Meta.lua'] = metaLines.join('\n');
	order.push('Meta.lua');
	const skillEntries = sortedIds(skills).map((id) => [id, skills[id], null]);
	if (skillEntries.length) emitGroup('skill', skillEntries, 'Skills', out, order);

	const index = {};
	for (const kind of ITEM_KINDS) {
		const ids = sortedIds(items).filter((id) => (items[id].kind || 'item') === kind);
		index[kind] = ids.map((id) => [id, items[id].name, items[id].quality, statusLetter(items[id])]);
		const entries = ids.map((id) => [id, items[id].name, encodeItem(items[id]), num(items[id].quality) + statusLetter(items[id])]);
		emitGroup(kind, entries, kind === 'item' ? 'Items' : `${cap(kind)}s`, out, order);
	}
	const npcIds = (rare) => sortedIds(npcs).filter((id) => !!npcs[id].rare === rare);
	for (const [group, prefix, rare] of [['npc', 'Npcs', false], ['rare', 'Rares', true]]) {
		const ids = npcIds(rare);
		index[group] = ids.map((id) => [id, npcs[id].name]);
		emitGroup(group, ids.map((id) => [id, npcs[id].name, encodeNpc(npcs[id])]), prefix, out, order);
	}
	// role -> "npc,npc,..." (names only), for Codex.WithRole.
	const roles = {};
	for (const id of sortedIds(npcs)) for (const r of npcs[id].roles || []) (roles[r] = roles[r] || []).push(id);
	const roleEntries = Object.keys(roles)
		.sort()
		.map((r) => [r, roles[r].join(','), null]);
	if (roleEntries.length) emitGroup('role', roleEntries, 'Roles', out, order);
	const objEntries = (treasure) =>
		sortedIds(objects)
			.filter((id) => !!objects[id].treasure === treasure)
			.map((id) => [id, objects[id].name, encodeObject(objects[id])]);
	emitGroup('object', objEntries(false), 'Objects', out, order);
	const treasures = objEntries(true);
	index.treasure = treasures.map(([id, name]) => [id, name]);
	emitGroup('treasure', treasures, 'Treasures', out, order);
	const simple = (group, obj, nameOf, enc, prefix) => {
		const entries = sortedIds(obj).map((id) => [id, nameOf(obj[id]), enc ? enc(obj[id]) : null]);
		if (SEARCH_KINDS.includes(group)) index[group] = entries.map(([id, name]) => [id, name]);
		emitGroup(group, entries, prefix, out, order);
	};
	simple('quest', codex.quests || {}, (q) => q.title, encodeQuest, 'Quests');
	simple('instance', codex.instances || {}, (i) => i.name, encodeInstance, 'Instances');
	simple('zone', codex.zones || {}, (z) => z.name, null, 'Zones');
	simple('faction', codex.factions || {}, (f) => f.name, encodeFaction, 'Factions');
	simple('spell', codex.spells || {}, (s) => s.name, encodeSpell, 'Spells');
	emitIndex(index, out, order);

	for (const f of extraFiles) {
		if (!/^[A-Za-z0-9_]+\.lua$/.test(f.name) || out[f.name]) throw new Error(`codex pack: bad or duplicate extra file "${f.name}"`);
		out[f.name] = f.text;
		order.push(f.name);
	}
	out[`${ADDON}.toc`] = emitToc(version, order);
	out['LICENSE-DATA.txt'] = licenseText(meta);
	return out;
}

// LICENSE-DATA.txt: the sources meta.sources lists (data/forever/meta.json's
// plus the Codex's own inputs), each with its version and licence.
function licenseText(meta) {
	const out = [
		'Polestar Codex: third-party notices',
		'===================================',
		'',
		'The data in this folder was generated for Polestar by `codex build` from the',
		'sources below: item, NPC, object, quest, zone and instance facts (ids, names,',
		'levels, coordinates, drop chances, requirements). No text, images or code',
		'were copied from them; the Dungeons journal is written in our own words.',
		'',
	];
	if (meta.localExtras) out.push('LOCAL BUILD (--local-extras): holds facts from inputs that may not be', 'redistributed. Do not share this folder.', '');
	for (const s of meta.sources || []) {
		const title = String(s.name || 'source');
		out.push(title, '-'.repeat(title.length));
		if (s.version) out.push(`Version: ${s.version}`);
		if (s.licence) out.push(`Licence: ${s.licence}`);
		out.push('');
	}
	return `${out.join('\n').trimEnd()}\n`;
}

// TOC order of an emitted pack's Lua files.
function packOrder(files) {
	const toc = files[`${ADDON}.toc`] || '';
	return toc
		.split('\n')
		.map((l) => l.trim())
		.filter((l) => l && !l.startsWith('#'));
}

// Inputs a release must not hold (their licences forbid it or are unknown).
const LOCAL_ONLY_SOURCES = /AtlasLoot|RareScanner|DungeonJournal|dungeons\.json/i;

// A built pack folder -> null when it may ship, else why not (`pack`).
function releaseRefusal(dir) {
	const fs = require('node:fs');
	const path = require('node:path');
	const file = (name) => path.join(dir, name);
	if (!fs.existsSync(file(`${ADDON}.toc`))) return 'not built (run `node tools/polestar.js codex build`)';
	if (!fs.existsSync(file('Meta.lua'))) return 'Meta.lua is missing (run `node tools/polestar.js codex build`)';
	if (!fs.existsSync(file('LICENSE-DATA.txt'))) return 'LICENSE-DATA.txt is missing (rebuild it with `node tools/polestar.js codex build`)';
	const meta = fs.readFileSync(file('Meta.lua'), 'utf8');
	if (/\blocalExtras = true\b/.test(meta)) return 'it is a --local-extras build (AtlasLoot, RareScanner, DungeonJournal); rebuild it with `node tools/polestar.js codex build`';
	const named = [...meta.matchAll(/\bname = "([^"]*)"/g)].map((m) => m[1]).find((n) => LOCAL_ONLY_SOURCES.test(n));
	if (named) return `its sources include a local-only input (${named}); rebuild it with \`node tools/polestar.js codex build\``;
	return null;
}

module.exports = { emitPack, releaseRefusal, packOrder, emitToc, licenseText, foldName, ADDON, SCHEMA, CHUNK, FROM, SOURCE };
