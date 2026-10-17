'use strict';
// Name tokens (docs/GUIDE_FORMAT.md, "Names in texts"; docs/TRANSLATING.md,
// "Guide texts"): the game's names inside a guide's prose, written as
// {kind:id}, so the addon shows each in the client's language
// (Core/GuideTexts.lua, through Polestar.Names and the client) and a
// translator writes the words around them, never the names.
//
//   "{npc:234} and {npc:821} stand at the top of the stone tower."
//
// The compiler replaces the names the guide's own data identifies: its
// goals' quests, NPCs, objects, items, spells and factions (the quest givers
// and enders, kill targets, collect sources, smart-target candidates, reward
// and reagent items, quest objectives), the zones of its maps and the
// AreaTable areas inside them, then every zone and every open-world area
// whose name is unique, the professions and their reagents, and every NPC,
// object and item of the data whose name has two words or an apostrophe. A name is replaced where it stands as a whole word
// with its exact case ("Harvest Watchers" keeps its plural English, a
// sentence's "the Jansen Stead" its lower case); a one-word name that the
// pack's texts also use as a lower-case word ("Barracks", "barracks") is left
// alone. An NPC of the step's or the guide's own goals is also matched by its
// first name ("Dalinda" for Dalinda Malem) where that word has four letters
// or more, no other NPC there shares it, and no other NPC of the data starts
// with it ("Defias" stays words). A text may hold tokens its author wrote:
// their kind and id are checked against the data.
//
// A goal note that only names the goal's own NPC, object, target or item
// (`accept 6181 -- Quartermaster Lewis`) is dropped: the goal already shows
// that name, in the client's language (#133).
//
// The guide carries `names = { ["npc:234"] = "Gryan Stoutmantle", ... }`,
// the English of every token it uses (its first spelling in the guide): what
// an English client shows, and any client without a name for it. A text that
// spells a name otherwise ("Dalinda", "Molsen Farm" for The Molsen Farm) is
// in `written`, tokenised text -> the author's words, which an English client
// reads instead.

const fs = require('node:fs');
const path = require('node:path');
const { parseCsv } = require('../data/csv');

const KINDS = ['npc', 'object', 'item', 'quest', 'zone', 'area', 'spell', 'faction', 'skill'];
const TOKEN_RE = /\{(npc|object|item|quest|zone|area|spell|faction|skill):(\d+)\}/g;
// The guide fields a player reads as prose (the guide `folder` is the pack's:
// tools/lib/i18n/texts.js).
const GUIDE_FIELDS = ['title', 'why', 'pitch'];
const GUIDE_LISTS = ['pros', 'cons'];
const STEP_FIELDS = ['title', 'note'];
const GOAL_FIELDS = ['note', 'text'];
// A goal's prose fields: a kill of no NPC (`kill "enemy players for honor"`)
// names its target in words too.
const goalFields = (goal) => (goal.t === 'kill' && goal.npc === undefined && str(goal.target) ? [...GOAL_FIELDS, 'target'] : GOAL_FIELDS);
// Areas of the open world: Eastern Kingdoms (0) and Kalimdor (1).
const OPEN_WORLD = new Set([0, 1]);
// Where a name comes from, best first: the step's own goals, the guide's, the
// areas of the guide's zones, any zone, any open-world area, any NPC, object
// or item of two words or more.
const STEP = 0;
const GUIDE = 1;
const ZONE_AREA = 2;
const WORLD_ZONE = 3;
const WORLD_AREA = 4;
const WORLD_DATA = 5;
const WORLD_SPELL = 6;
const SOURCES = ['step', 'guide', 'zoneArea', 'worldZone', 'worldArea', 'worldData', 'worldSpell'];
const MIN_NAME = 3;
// The shortest first name matched for its NPC.
const MIN_FIRST = 4;
// Kinds whose names are matched without a leading "The" (and a zone's or
// area's without its trailing "City").
const ALIAS_KINDS = new Set(['area', 'zone', 'npc', 'object']);

const LETTER = /[\p{L}\p{N}]/u;

function isWordChar(ch) {
	return ch !== undefined && LETTER.test(ch);
}

function str(v) {
	return typeof v === 'string' && v.trim() !== '' ? v : null;
}

// The English name data gives `kind` `id`, or null.
function dataName(data, kind, id) {
	let rec = null;
	if (kind === 'npc') rec = data.npc(id);
	else if (kind === 'object') rec = data.object(id);
	else if (kind === 'item') rec = data.item(id);
	else if (kind === 'quest') return (data.quest(id) && str(data.quest(id).title)) || null;
	else if (kind === 'zone') rec = data.zone(id);
	else if (kind === 'area') rec = data.areas ? data.areas.byId.get(id) : null;
	else if (kind === 'faction') rec = data.faction(id);
	else if (kind === 'skill') rec = data.profession(id);
	else if (kind === 'spell') return spellById(data).get(id) || null;
	return (rec && str(rec.name)) || null;
}

// Every { kind, id, name } a goal names, its own (the NPC, object, target or
// item it shows) flagged `own`.
function goalNames(goal, data) {
	const out = [];
	const add = (kind, id, name, own = false) => {
		if (Number.isInteger(id) && str(name)) out.push({ kind, id, name, own });
	};
	add('quest', goal.quest, goal.title);
	add('npc', goal.npc, goal.npcName, true);
	if (goal.t === 'kill') add('npc', goal.npc, goal.target, true);
	add('object', goal.object, goal.objName, true);
	add('item', goal.item, goal.itemName, true);
	add('spell', goal.spell, goal.spellName);
	add('faction', goal.faction, goal.factionName);
	add('skill', goal.skillLine, goal.skill);
	add('skill', goal.profLine, goal.profName);
	// A collect's sources (resolve.js fromId, fromAlsoId: the kind of fromKind).
	if (goal.fromKind === 'npc' || goal.fromKind === 'object') {
		add(goal.fromKind, goal.fromId, goal.from);
		add(goal.fromKind, goal.fromAlsoId, goal.fromAlso);
	}
	for (const c of goal.candidates || []) add('npc', c.npc, c.npcName, true);
	for (const r of goal.reagents || []) add('item', r.item, r.itemName);
	for (const list of [goal.rewards && goal.rewards.items, goal.rewards && goal.rewards.choices]) {
		for (const r of list || []) add('item', r.item, r.itemName);
	}
	for (const [id, title] of Object.entries(goal.preTitles || {})) add('quest', Number(id), title);
	if (Number.isInteger(goal.area)) add('area', goal.area, dataName(data, 'area', goal.area));
	if (Number.isInteger(goal.quest)) {
		for (const o of data.questObjectives(goal.quest)) {
			const kind = o.kind === 'kill' ? 'npc' : o.kind === 'item' ? 'item' : o.kind === 'object' ? 'object' : null;
			if (kind && Number.isInteger(o.id)) add(kind, o.id, dataName(data, kind, o.id));
		}
	}
	return out;
}

// Whether area `id` lies in the area `zone` (its ParentAreaID chain).
function within(areas, id, zone) {
	let a = areas.byId.get(id);
	for (let hops = 0; a && hops < 8; hops++) {
		if (a.id === zone) return true;
		a = a.parent ? areas.byId.get(a.parent) : null;
	}
	return false;
}

// Lower-case words of every prose text of the pack: a one-word name that is
// also one of these is an ordinary word, never replaced.
function commonWords(guides) {
	const words = new Set();
	const scan = (s) => {
		for (const w of s.split(/[^\p{L}'’-]+/u)) if (w && w === w.toLowerCase() && w !== w.toUpperCase()) words.add(w);
	};
	for (const g of guides) forEachText(g, (s) => scan(s));
	return words;
}

// Calls fn(text, holder, key, level, stepIndex) for every prose text of a
// guide, in reading order (level: 'guide', 'step' or 'goal'; for a list,
// holder is the list and key the index).
function forEachText(guide, fn, { steps = true } = {}) {
	for (const f of GUIDE_FIELDS) if (str(guide[f])) fn(guide[f], guide, f, 'guide', null);
	for (const f of GUIDE_LISTS) {
		const list = guide[f];
		if (Array.isArray(list)) list.forEach((s, i) => str(s) && fn(s, list, i, 'guide', null));
	}
	for (const r of guide.reward || []) if (r && str(r.text)) fn(r.text, r, 'text', 'guide', null);
	if (!steps) return;
	(guide.steps || []).forEach((step, si) => {
		for (const f of STEP_FIELDS) if (str(step[f])) fn(step[f], step, f, 'step', si);
		for (const goal of step.goals || []) for (const f of goalFields(goal)) if (str(goal[f])) fn(goal[f], goal, f, 'goal', si);
	});
}

// Whether `before` ends in a capitalised word (or "<Capitalised> of") that
// makes a longer name with what follows: not "The", a possessive
// ("Darnassus's Mystic Ward"), a profession rank, nor a word opening its
// sentence ("Assist Walton"); "<Capitalised> of" counts anywhere ("Elixirs
// of Agility").
// A profession's rank before its name ("Apprentice {skill:182}"): the rank is words.
const RANKS = new Set(['Apprentice', 'Journeyman', 'Expert', 'Artisan']);
function capitalBefore(before) {
	const of = /(^|[^\p{L}\p{N}'’-])\p{Lu}[\p{L}\p{N}'’-]*[ \t]+of[ \t]+$/u.test(before);
	if (of) return true;
	const m = /(^|[\s\S]*?[^\p{L}\p{N}'’-])(\p{Lu}[\p{L}\p{N}'’-]*)[ \t]+$/u.exec(before);
	if (!m || m[2] === 'The' || RANKS.has(m[2]) || /['’]s$/u.test(m[2])) return false;
	return !opensSentence(m[1]);
}

// Whether a word after `before` opens its sentence.
function opensSentence(before) {
	return /(^|[.!?:;\n(])\s*$/u.test(before);
}

// Names by their first three characters, each name once (its best source
// kept), the longest first.
class NameIndex {
	constructor(common) {
		this.common = common;
		this.byStart = new Map();
		this.seen = new Map(); // name -> entry
		this.sorted = true;
	}

	add(kind, id, name, prio) {
		name = str(name) && name.trim();
		if (!name || !Number.isInteger(id) || id <= 0) return;
		this.put(name, name, kind, id, prio);
		if (!ALIAS_KINDS.has(kind)) return;
		// "Molsen Farm" for the game's "The Molsen Farm", "Stormwind" for
		// "Stormwind City": an English client reads the author's words
		// (`names`, `written`), the other languages the game's name. A worse
		// source than the name itself.
		// Without "The" only where the rest still reads as a name: two words or
		// more, or a place ("The Rot" is no "Rot": "Rot Hide" gnolls).
		const place = kind === 'zone' || kind === 'area';
		const bare = /^The (.+)$/.exec(name);
		if (bare && (place || bare[1].includes(' '))) this.put(bare[1], name, kind, id, prio + 0.5, true);
		const city = place && /^(.+) City$/.exec(name);
		if (city) this.put(city[1], name, kind, id, prio + 0.5, true);
	}

	// The first names of `npcs` ([{ id, name }], the step's or the guide's
	// own): each first word of four letters or more that one NPC there has, no
	// other NPC of the data starts with or is called ("Lunaclaw" and Lunaclaw
	// Spirit), and nothing else of the game is called (the area Terrordale,
	// the spell Polymorph), of an NPC whose last word the pack's texts do not
	// use in lower case (a creature: Shadowmaw Panther, Dreadsteed Spirit). A
	// worse source than a name itself.
	addFirsts(npcs, prio, data) {
		const byWord = new Map();
		for (const { id, name } of npcs) {
			const words = String(name).trim().split(/\s+/);
			if (words.length < 2 || words[0].length < MIN_FIRST) continue;
			if (!byWord.has(words[0])) byWord.set(words[0], new Map());
			byWord.get(words[0]).set(id, words);
		}
		const starts = firstWords(data);
		const taken = otherNames(data);
		for (const [word, ids] of byWord) {
			if (ids.size !== 1 || starts.get(word) !== 1 || taken.has(word.toLowerCase())) continue;
			const [[id, words]] = ids;
			const last = words[words.length - 1].toLowerCase();
			if (this.common.has(last) || this.common.has(`${last}s`)) continue;
			this.put(word, words.join(' '), 'npc', id, prio + 0.5, true, words[1].toLowerCase());
		}
	}

	// `match`: the words looked for; `english`: the token's English; `next`:
	// for a first name, its NPC's second word (lower case).
	put(match, english, kind, id, prio, alias = false, next = null) {
		if (match.length < MIN_NAME || !/^[\p{Lu}\p{N}]/u.test(match)) return;
		if (kind !== 'skill' && !match.includes(' ') && this.common.has(match.toLowerCase())) return;
		const had = this.seen.get(match);
		if (had && (had.prio < prio || (had.prio === prio && had.id <= id))) return;
		const entry = { name: match, english, kind, id, prio, alias, next };
		const start = match.slice(0, MIN_NAME);
		if (!this.byStart.has(start)) this.byStart.set(start, []);
		const list = this.byStart.get(start);
		if (had) list.splice(list.indexOf(had), 1, entry);
		else list.push(entry);
		this.seen.set(match, entry);
		this.sorted = false;
	}

	// The longest name starting at text[i] as a whole word, or null; with
	// `plural`, the longest whose English plural (name + "s") stands there.
	at(text, i, plural = false) {
		if (!this.sorted) {
			for (const list of this.byStart.values()) list.sort((a, b) => b.name.length - a.name.length);
			this.sorted = true;
		}
		const list = this.byStart.get(text.slice(i, i + MIN_NAME));
		if (!list) return null;
		for (const e of list) {
			if (!text.startsWith(e.name, i)) continue;
			const end = i + e.name.length;
			// A name next to a capitalised word is part of a longer name the data
			// lacks ("Rot Hide" gnolls, "Jade Oozes", "Lost Barrens Kodos"): not
			// this one.
			if (/^[ \t]+(of[ \t]+)?\p{Lu}/u.test(text.slice(end)) || capitalBefore(text.slice(0, i))) continue;
			// A first name before its NPC's next word is the creature, not the
			// NPC ("Lashtail raptors" of Lashtail Raptor).
			if (e.next) {
				const w = /^[ \t]+(\p{Ll}[\p{L}'’-]*)/u.exec(text.slice(end));
				if (w && w[1].startsWith(e.next)) continue;
			}
			if (e.kind === 'spell') {
				// A spell owning something is a name of its own ("Blizzard's designers", "Burning Blade's").
				if (/^['’]s\b/u.test(text.slice(end))) continue;
				// A one-word spell of the client's table taking an object, or opening a
				// sentence that goes on in lower case, is a verb ("Shatter the
				// crystal", "Polymorph a naga"); a guide's own spells are names.
				const rest = text.slice(end);
				if (!e.name.includes(' ') && e.prio >= WORLD_SPELL && (/^[ \t]+(the|a|an|your|its|their|it|them|him|her)\b/u.test(rest) || (opensSentence(text.slice(0, i)) && /^[ \t]+\p{Ll}/u.test(rest)))) continue;
			}
			if (plural ? text[end] === 's' && !isWordChar(text[end + 1]) : !isWordChar(text[end])) return e;
		}
		return null;
	}
}

// The longest name at text[i] over indexes ordered best first; a tie goes to
// the earlier index.
function longestAt(indexes, text, i, plural = false) {
	let best = null;
	for (const idx of indexes) {
		const e = idx.at(text, i, plural);
		if (e && (!best || e.name.length > best.name.length)) best = e;
	}
	return best;
}

// The names any guide of the pack may use beyond its own: each zone and each
// open-world area whose name nothing else has, the professions and their
// recipes' reagents, the NPCs, objects and items of the data with a name of
// two words or more or with an apostrophe, and the client's spell names
// (spellNames). Built once per data and pack.
const WORLD = new WeakMap();
function worldIndex(data, common) {
	const cached = WORLD.get(data);
	if (cached && cached.common === common) return { idx: cached.idx, abilities: cached.abilities };
	const idx = new NameIndex(common);
	const zoneCount = new Map();
	for (const z of Object.values(data.zones || {})) if (z && str(z.name)) zoneCount.set(z.name, (zoneCount.get(z.name) || 0) + 1);
	for (const z of Object.values(data.zones || {})) {
		if (z && str(z.name) && z.type >= 2 && zoneCount.get(z.name) === 1) idx.add('zone', z.id, z.name, WORLD_ZONE);
	}
	if (data.areas) {
		for (const list of data.areas.byName.values()) {
			const open = list.length === 1 ? list : list.filter((a) => OPEN_WORLD.has(a.c));
			if (open.length === 1 && !zoneCount.has(open[0].name)) idx.add('area', open[0].id, open[0].name, WORLD_AREA);
		}
	}
	for (const p of data.professions.values()) {
		idx.add('skill', p.id, p.name, WORLD_ZONE);
		// Reagents, one-word names too: the herbs, ores and cloth professions name.
		for (const r of p.recipes || []) for (const g of (r && r.reagents) || []) idx.add('item', g.item, dataName(data, 'item', g.item), WORLD_DATA);
	}
	for (const [kind, table] of [['npc', data.npcs], ['object', data.objects], ['item', data.items]]) {
		for (const rec of Object.values(table || {})) {
			// One-word names only with an apostrophe (Lar'korwi, U'cha): never a word.
			if (rec && str(rec.name) && /[ '’]/.test(rec.name.trim())) idx.add(kind, Number(rec.id), rec.name, WORLD_DATA);
		}
	}
	const abilities = new NameIndex(common);
	for (const [name, id] of spellNames(data)) (name.includes(' ') || /['’:]/.test(name) ? idx : abilities).add('spell', id, name, WORLD_SPELL);
	WORLD.set(data, { common, idx, abilities });
	return { idx, abilities };
}

// Spell names the client gives by id (GetSpellInfo), from the Forever
// SpellName table of the data's own client build (pinnedBuildDir): [[name, id]], each name once
// (its lowest id: a spell's ranks share their name in every language), none
// that another thing of the game is called. Names of
// two words or more, or with an apostrophe or colon ("Teleport: Moonglade"),
// of any spell; one-word names only of a class or profession ability
// (SkillLineAbility: "Polymorph", "Whirlwind").
const SPELLS = new WeakMap();
function spellNames(data) {
	if (!SPELLS.has(data)) SPELLS.set(data, readSpellNames(data));
	return SPELLS.get(data);
}

function readSpellNames(data) {
	const dir = data.dir && pinnedBuildDir(data, ['SpellName.csv', 'SkillLineAbility.csv']);
	if (!dir) return [];
	const abilities = new Set(parseCsv(fs.readFileSync(path.join(dir, 'SkillLineAbility.csv'), 'utf8')).map((r) => Number(r.Spell)));
	// A name something else of the game has too ("Burning Blade", "Zephras
	// Isle", "The Molten Core") is that thing in a text, not the spell.
	const taken = new Set();
	for (const t of [data.npcs, data.objects, data.items, data.zones]) for (const x of Object.values(t || {})) if (x && str(x.name)) taken.add(x.name.trim().toLowerCase());
	for (const q of Object.values(data.quests || {})) if (q && str(q.title)) taken.add(q.title.trim().toLowerCase());
	for (const f of data.factions.values()) if (f && str(f.name)) taken.add(f.name.trim().toLowerCase());
	// Every faction of the client's table, those without a reputation too.
	const factions = path.join(dir, 'Faction.csv');
	if (fs.existsSync(factions)) for (const r of parseCsv(fs.readFileSync(factions, 'utf8'))) if (str(r.Name_lang)) taken.add(r.Name_lang.trim().toLowerCase());
	if (data.areas) for (const key of data.areas.byName.keys()) taken.add(key);
	const best = new Map();
	for (const r of parseCsv(fs.readFileSync(path.join(dir, 'SpellName.csv'), 'utf8'))) {
		const id = Number(r.ID);
		const name = String(r.Name_lang || '').trim();
		if (!Number.isInteger(id) || !name || /[()[\]<>_]|\b(OLD|DND|TEST|Test|QA|zz)\b|^\d/.test(name)) continue;
		// A profession's rank spell reads as rank and profession: words and {skill:id}.
		if (/^(Apprentice|Journeyman|Expert|Artisan|Master) /.test(name) || / Reputation$/.test(name) || taken.has(name.toLowerCase())) continue;
		if (!/[ '’:]/.test(name) && !abilities.has(id)) continue;
		const had = best.get(name);
		if (had === undefined || id < had) best.set(name, id);
	}
	return [...best];
}

const SPELL_IDS = new WeakMap();
function spellById(data) {
	if (!SPELL_IDS.has(data)) SPELL_IDS.set(data, new Map(spellNames(data).map(([n, id]) => [id, n])));
	return SPELL_IDS.get(data);
}

// First word of every NPC name -> how many different names start with it
// (a one-word name counts too), cached per data.
const FIRST_WORDS = new WeakMap();
function firstWords(data) {
	if (!FIRST_WORDS.has(data)) {
		const names = new Map();
		for (const rec of Object.values(data.npcs || {})) {
			const words = rec && str(rec.name) ? rec.name.trim().split(/\s+/) : [];
			if (!words.length) continue;
			if (!names.has(words[0])) names.set(words[0], new Set());
			names.get(words[0]).add(words.join(' '));
		}
		FIRST_WORDS.set(data, new Map([...names].map(([w, s]) => [w, s.size])));
	}
	return FIRST_WORDS.get(data);
}

// Lower-case names of the game's zones, areas, objects, items, quests,
// factions and the client's spells, cached per data: a first name that is one
// of these is that thing.
const OTHER_NAMES = new WeakMap();
function otherNames(data) {
	if (!OTHER_NAMES.has(data)) {
		const set = new Set();
		for (const t of [data.objects, data.items, data.zones]) for (const x of Object.values(t || {})) if (x && str(x.name)) set.add(x.name.trim().toLowerCase());
		for (const q of Object.values(data.quests || {})) if (q && str(q.title)) set.add(q.title.trim().toLowerCase());
		for (const f of data.factions.values()) if (f && str(f.name)) set.add(f.name.trim().toLowerCase());
		if (data.areas) for (const key of data.areas.byName.keys()) set.add(key);
		for (const [name] of spellNames(data)) set.add(name.toLowerCase());
		OTHER_NAMES.set(data, set);
	}
	return OTHER_NAMES.get(data);
}

// The { id, name } of each NPC goals name.
function npcsOf(goals, data) {
	const out = [];
	for (const goal of goals) for (const n of goalNames(goal, data)) if (n.kind === 'npc') out.push({ id: n.id, name: n.name });
	return out;
}

// The Forever client build the data was built from (meta.json's "World of
// Warcraft: Forever client tables" source), as its cache folder beside the
// data, when it holds every file of `files`; else null: the same data
// compiles the same guides whatever else is cached.
function pinnedBuildDir(data, files) {
	const src = ((data.meta && data.meta.sources) || []).find((x) => x && /^World of Warcraft: Forever client tables/.test(String(x.name)));
	const m = src && /(\d+\.\d+\.\d+\.\d+)/.exec(String(src.revision || ''));
	if (!m) return null;
	const dir = path.join(data.dir, '..', 'sources', 'wago', m[1]);
	return files.every((f) => fs.existsSync(path.join(dir, f))) ? dir : null;
}

// The AreaTable areas inside the zone whose area is `zoneArea`, cached per data.
const ZONE_AREAS = new WeakMap();
function areasIn(data, zoneArea) {
	if (!ZONE_AREAS.has(data)) ZONE_AREAS.set(data, new Map());
	const cache = ZONE_AREAS.get(data);
	if (!cache.has(zoneArea)) {
		const list = [];
		for (const a of data.areas.byId.values()) if (a.id !== zoneArea && within(data.areas, a.id, zoneArea)) list.push(a);
		cache.set(zoneArea, list);
	}
	return cache.get(zoneArea);
}

function guideIndex(guide, data, common) {
	const idx = new NameIndex(common);
	const zones = new Set();
	if (Number.isInteger(guide.zone)) zones.add(guide.zone);
	for (const r of guide.reward || []) {
		if (!r) continue;
		if (Number.isInteger(r.item)) idx.add('item', r.item, r.itemName, GUIDE);
		if (Number.isInteger(r.spell)) idx.add('spell', r.spell, r.spellName, GUIDE);
	}
	for (const step of guide.steps || []) {
		for (const goal of step.goals || []) {
			for (const n of goalNames(goal, data)) idx.add(n.kind, n.id, n.name, GUIDE);
			if (Number.isInteger(goal.map)) zones.add(goal.map);
		}
	}
	idx.addFirsts(npcsOf((guide.steps || []).flatMap((s) => s.goals || []), data), GUIDE, data);
	for (const id of zones) idx.add('zone', id, dataName(data, 'zone', id), GUIDE);
	if (data.areas) {
		for (const id of zones) {
			const z = data.zone(id);
			if (z && Number.isInteger(z.areaId)) for (const a of areasIn(data, z.areaId)) idx.add('area', a.id, a.name, ZONE_AREA);
		}
	}
	return idx;
}

function stepIndex(step, data, common) {
	const idx = new NameIndex(common);
	for (const goal of step.goals || []) for (const n of goalNames(goal, data)) idx.add(n.kind, n.id, n.name, STEP);
	idx.addFirsts(npcsOf(step.goals || [], data), STEP, data);
	return idx;
}

// text -> { text, used: [{ kind, id, name, author }], plurals: [{ kind, id,
// name }] }: the names `indexes` know replaced by tokens, where
// `accept(entry)` allows; tokens already in the text are kept (and listed,
// `author`); `plurals`: names that stand there in their English plural.
function tokeniseText(text, indexes, accept = () => true) {
	const parts = []; // strings and { token, name, used }
	const plurals = [];
	let i = 0;
	let plain = '';
	const flush = () => {
		if (plain) parts.push(plain);
		plain = '';
	};
	while (i < text.length) {
		const ch = text[i];
		if (ch === '{') {
			TOKEN_RE.lastIndex = i;
			const m = TOKEN_RE.exec(text);
			if (m && m.index === i) {
				flush();
				parts.push({ token: m[0], used: { kind: m[1], id: Number(m[2]), name: null, author: true } });
				i += m[0].length;
				continue;
			}
		}
		if (!isWordChar(text[i - 1])) {
			const e = longestAt(indexes, text, i);
			if (e && accept(e)) {
				flush();
				parts.push({ token: `{${e.kind}:${e.id}}`, name: e.name, used: { kind: e.kind, id: e.id, name: e.name, prio: Math.floor(e.prio), alias: e.alias ? e.english : undefined } });
				i += e.name.length;
				continue;
			}
			// "Harvest Watchers": English plurals stay words, noted for the translator.
			const pl = !e && longestAt(indexes, text, i, true);
			if (pl) {
				// The whole plural stays words: no shorter name inside it is matched.
				plurals.push({ kind: pl.kind, id: pl.id, name: pl.name, english: pl.english });
				plain += text.slice(i, i + pl.name.length + 1);
				i += pl.name.length + 1;
				continue;
			}
		}
		plain += ch;
		i++;
	}
	flush();
	// Two names a space apart are one name the data lacks ("Longshore Murloc
	// Gills": an area and a quest): both stay words.
	for (let k = 0; k + 2 < parts.length; k++) {
		const a = parts[k];
		const b = parts[k + 2];
		if (a.name && b.name && parts[k + 1] === ' ') {
			parts[k] = a.name;
			parts[k + 2] = b.name;
		}
	}
	let out = '';
	const used = [];
	for (const p of parts) {
		if (typeof p === 'string') out += p;
		else {
			out += p.token;
			used.push(p.used);
		}
	}
	return { text: out, used, plurals };
}

// Whether a goal's note only names the goal itself.
function selfNote(goal, data) {
	const note = str(goal.note) && goal.note.trim();
	if (!note) return false;
	return goalNames(goal, data).some((n) => n.own && n.name.trim() === note) || (str(goal.from) !== null && goal.from === note);
}

// guides (compiled, English) -> { guides, stats, problems }: copies whose
// prose carries tokens, `names` and `written`, with self-naming notes
// dropped, each with `_plurals` (hidden): tokenised text -> [{ kind, id, name
// }] named there in the English plural. The
// originals are left as they are (lint, sim and the other tools read them).
// stats: { replaced: { kind: n }, bySource: { step, guide, zoneArea,
// worldZone, worldArea, worldData }, dropped }; problems: [{ guide, line,
// message }] for author-written tokens the data does not know; aliases: [{
// guide, line, words, token, english, text }], each name matched without its
// "The" or "City", or by its first name.
function tokeniseGuides(guides, data) {
	const common = commonWords(guides);
	const { idx: world, abilities } = worldIndex(data, common);
	const stats = { replaced: Object.fromEntries(KINDS.map((k) => [k, 0])), bySource: Object.fromEntries(SOURCES.map((k) => [k, 0])), dropped: 0 };
	const problems = [];
	const aliases = []; // names matched without their "The" or "City"
	const out = guides.map((guide) => {
		const base = guideIndex(guide, data, common);
		// One-word class and profession abilities ("Polymorph", "Whirlwind") where
		// the guide teaches them; elsewhere only right after "cast" or "your"
		// ("cast your Skysight racial ability").
		const cast = { at: (text, i, plural) => (/\b(cast|your)[ \t]+$/iu.test(text.slice(Math.max(0, i - 6), i)) ? abilities.at(text, i, plural) : null) };
		const worlds = [world, guide.category === 'Class' || guide.category === 'Professions' ? abilities : cast];
		const copy = { ...guide, steps: guide.steps.map((s) => ({ ...s, goals: s.goals.map((g) => ({ ...g })) })) };
		for (const k of GUIDE_LISTS) if (Array.isArray(copy[k])) copy[k] = copy[k].slice();
		if (Array.isArray(copy.reward)) copy.reward = copy.reward.map((r) => ({ ...r }));
		const names = {};
		const plurals = new Map(); // tokenised text -> plural names in it
		const seen = new Map(); // tokenised text -> the author's words
		const written = {};
		// Any spelling of a name is its token; the first one is the token's
		// English in `names`, the NPC's whole name for a first name (what a
		// client without the NPC's name shows; `written` keeps the author's
		// words for English).
		const any = (e) => {
			const k = `${e.kind}:${e.id}`;
			if (!(k in names)) names[k] = e.next ? e.english : e.name;
			return true;
		};
		// Only the token's English: for a text whose tokens read like another
		// text's of other words ("Back to Dendrite", "Back to Dendrite
		// Starblaze"), which `written` cannot tell apart. A first name stays
		// words there.
		const same = (e) => {
			if (e.next) return false;
			const k = `${e.kind}:${e.id}`;
			if (!(k in names)) names[k] = e.name;
			return names[k] === e.name;
		};
		const replace = (text, holder, key, indexes, ln) => {
			let r = tokeniseText(text, indexes, any);
			// The English of the tokens the author wrote, for the author's words.
			for (const u of r.used) if (u.author && !(`${u.kind}:${u.id}` in names) && dataName(data, u.kind, u.id)) names[`${u.kind}:${u.id}`] = dataName(data, u.kind, u.id);
			if (seen.has(r.text) && seen.get(r.text) !== fillTokens(text, names)) r = tokeniseText(text, indexes, same);
			for (const u of r.used) {
				const k = `${u.kind}:${u.id}`;
				const name = u.name || dataName(data, u.kind, u.id);
				if (!name) {
					problems.push({ guide, line: ln, message: `{${k}}: the data has no ${u.kind} ${u.id}` });
					continue;
				}
				if (!u.author) {
					stats.replaced[u.kind]++;
					stats.bySource[SOURCES[u.prio]]++;
					if (u.alias) aliases.push({ guide: guide.id, line: ln, words: name, token: k, english: u.alias, text });
				}
				if (!(k in names)) names[k] = name;
			}
			holder[key] = r.text;
			const english = fillTokens(text, names);
			seen.set(r.text, english);
			if (fillTokens(r.text, names) !== english) written[r.text] = english;
			if (r.plurals.length) plurals.set(r.text, [...(plurals.get(r.text) || []), ...r.plurals]);
			// A translation may name a plural by its singular's token: the guide carries its English too.
			for (const pl of r.plurals) if (!(`${pl.kind}:${pl.id}` in names) && pl.english) names[`${pl.kind}:${pl.id}`] = pl.english;
		};
		const guideLine = (guide._ast && guide._ast.line) || 0;
		forEachText(copy, (text, holder, key) => replace(text, holder, key, [base, ...worlds], guideLine), { steps: false });
		copy.steps.forEach((step, si) => {
			const orig = guide.steps[si];
			const indexes = [stepIndex(orig, data, common), base, ...worlds];
			for (const f of STEP_FIELDS) if (str(step[f])) replace(step[f], step, f, indexes, orig._line || guideLine);
			step.goals.forEach((goal, gi) => {
				const og = orig.goals[gi];
				if (selfNote(og, data)) {
					delete goal.note;
					stats.dropped++;
				}
				for (const f of goalFields(goal)) if (str(goal[f])) replace(goal[f], goal, f, indexes, og._line || orig._line || guideLine);
			});
		});
		if (Object.keys(names).length) copy.names = Object.fromEntries(Object.keys(names).sort().map((k) => [k, names[k]]));
		if (Object.keys(written).length) copy.written = Object.fromEntries(Object.keys(written).sort().map((k) => [k, written[k]]));
		Object.defineProperty(copy, '_ast', { value: guide._ast, enumerable: false });
		Object.defineProperty(copy, '_plurals', { value: plurals, enumerable: false });
		return copy;
	});
	return { guides: out, stats, problems, aliases };
}

// A text with its tokens filled by `names` (a guide's), as an English client
// reads it (Core/GuideTexts.lua fills them the same way).
function fillTokens(text, names) {
	let out = '';
	let at = 0;
	for (const m of String(text).matchAll(new RegExp(TOKEN_RE.source, 'g'))) {
		out += text.slice(at, m.index);
		const en = names && names[`${m[1]}:${m[2]}`];
		out += en || m[0];
		at = m.index + m[0].length;
	}
	return out + String(text).slice(at);
}

// The tokens of a text, in order: ["npc:234", ...].
function tokensOf(text) {
	return [...String(text).matchAll(new RegExp(TOKEN_RE.source, 'g'))].map((m) => `${m[1]}:${m[2]}`);
}

// Whether a text is nothing but tokens, digits, spaces and punctuation
// ("{item:765} & {item:2449}: {zone:1429} (1-50)"): it needs no translation.
function onlyTokens(text) {
	return !/\p{L}/u.test(String(text).replace(TOKEN_RE, ''));
}

module.exports = { KINDS, TOKEN_RE, GUIDE_FIELDS, GUIDE_LISTS, STEP_FIELDS, GOAL_FIELDS, tokeniseGuides, tokeniseText, fillTokens, tokensOf, onlyTokens, forEachText, dataName };
