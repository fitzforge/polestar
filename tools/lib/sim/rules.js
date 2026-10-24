'use strict';
// Game facts players reported, which the model can't know: one
// entry per fact with its provenance. Loaded and checked against the world
// before any route uses them; an unknown kind or id is an error, never ignored.

const fs = require('node:fs');
const path = require('node:path');
const { CLASS_BY_FILE } = require('../game/races');

const FILE = path.join(__dirname, '..', '..', '..', 'data', 'rules.json');
const DATA = path.join(__dirname, '..', '..', '..', 'data', 'forever');
const DATA_FILES = ['quests.json', 'npcs.json', 'items.json'];

// Required fields per kind (the closed list). Optional ones: at/requires
// `objective`; buy `price`, `stock`; make `tool`; ride `seconds`; learn `cost`;
// buy/avoid/make `quest` (the quest the fact serves, for the index). Any rule
// may carry `unconfirmed: '<why>'` (a soft rule). `objective` is the index
// in the quest's objectives (0-based; the guide's `quest <q>.<n>` is n - 1).
// handover: the NPC who hands the objective's item over in gossip (the data
// has no source for it; the world builder counts it sourced, R9b).
const FIELDS = {
	before: ['a', 'b'],
	together: ['a', 'b'],
	notBefore: ['quest', 'level'],
	afterTurnin: ['quest', 'after'],
	at: ['quest', 'objective', 'map', 'x', 'y'],
	avoid: ['npc'],
	timer: ['item', 'seconds', 'from', 'to'],
	skip: ['quest', 'reason'],
	requires: ['quest', 'item', 'place'],
	buy: ['item', 'vendor'],
	make: ['item', 'from'],
	patrol: ['npc', 'path'],
	ride: ['quest', 'from', 'to'],
	exclusive: ['quest', 'closes'],
	classLock: ['quest', 'classes'],
	learn: ['quest', 'trainer', 'skill'],
	handover: ['quest', 'objective', 'item', 'npc'],
};
const KINDS = new Set(Object.keys(FIELDS));
const STEPS = ['accept', 'turnin', 'objective'];

const isNum = (x) => typeof x === 'number' && Number.isFinite(x);
const isRef = (x) => x != null && x.quest != null && STEPS.includes(x.step);
const isPlace = (x) => x != null && x.map != null && isNum(x.x) && isNum(x.y);
const isPart = (x) => x != null && x.item != null && isNum(x.count) && x.count > 0;

// Per kind: [field, test, what it must be] beyond presence.
const REF = [isRef, `{ quest, step: ${STEPS.join('|')} }`];
const PLACE = [isPlace, '{ map, x, y }'];
const SHAPES = {
	before: { a: REF, b: REF },
	together: { a: REF, b: REF },
	timer: { from: REF, to: REF },
	requires: { place: PLACE },
	ride: { from: PLACE, to: PLACE },
	patrol: { path: [(p) => Array.isArray(p) && p.length > 0 && p.every(isPlace), '[{ map, x, y }]'] },
	make: { from: [(p) => Array.isArray(p) && p.length > 0 && p.every(isPart), '[{ item, count }]'] },
	exclusive: { closes: [(c) => Array.isArray(c) && c.length > 0 && c.every((q) => q != null), '[quest ids]'] },
	classLock: { classes: [(c) => Array.isArray(c) && c.length > 0 && c.every((k) => Object.hasOwn(CLASS_BY_FILE, k)), `[${Object.keys(CLASS_BY_FILE).join('|')}]`] },
	handover: { objective: [(n) => Number.isInteger(n) && n >= 0, 'an objective index (0-based)'] },
};

function loadRules(file = FILE) {
	const doc = JSON.parse(fs.readFileSync(file, 'utf8'));
	if (doc.schema !== 1 || !Array.isArray(doc.rules)) throw new Error(`${file}: expected { schema: 1, rules: [...] }`);
	return doc.rules;
}

// The ids data/forever knows, for rules naming the other faction's quests,
// NPCs and items. -> { quests, npcs, items } of Sets
function dataIds(dir = DATA) {
	return { quests: idsOf(path.join(dir, 'quests.json')), npcs: idsOf(path.join(dir, 'npcs.json')), items: idsOf(path.join(dir, 'items.json')) };
}

// A data file's ids (its keys, as numbers, in its order), kept by the file's content: in the
// temp dir's polestar-ids/<sha1>.json (parsing items.json, 24 MB, for its keys took 0.3 s on
// every compile) and, in a sim server, in memory (memo.js).
function idsOf(file) {
	const { fileHash } = require('../requires');
	const hash = fileHash(file);
	return require('./memo').memo(`ids:${file}|${hash}`, () => {
		const cache = path.join(require('node:os').tmpdir(), 'polestar-ids', `${hash}.json`);
		try {
			return new Set(JSON.parse(fs.readFileSync(cache, 'utf8')));
		} catch {
			// not cached yet
		}
		const keys = Object.keys(JSON.parse(fs.readFileSync(file, 'utf8'))).map(Number);
		try {
			fs.mkdirSync(path.dirname(cache), { recursive: true });
			fs.writeFileSync(`${cache}.${process.pid}.tmp`, JSON.stringify(keys));
			fs.renameSync(`${cache}.${process.pid}.tmp`, cache);
		} catch {
			// a read-only temp dir: parsed again next time
		}
		return new Set(keys);
	});
}

// dataIds() of the default data/forever, read once; null when it isn't built.
let defaultIds;
function defaultKnown() {
	if (defaultIds === undefined) defaultIds = DATA_FILES.every((f) => fs.existsSync(path.join(DATA, f))) ? dataIds() : null;
	return defaultIds;
}

// Shape only (no world): kind known, fields present and well formed,
// provenance present. -> error string | null; never throws.
function checkShape(r) {
	if (!r || typeof r.id !== 'string') return 'rule without an id';
	if (!KINDS.has(r.kind)) return `${r.id}: unknown kind ${r.kind}`;
	for (const f of FIELDS[r.kind]) if (r[f] == null) return `${r.id}: ${r.kind} needs ${f}`;
	for (const [f, [ok, want]] of Object.entries(SHAPES[r.kind] || {})) if (!ok(r[f])) return `${r.id}: ${f} must be ${want}`;
	if (r.unconfirmed != null && (typeof r.unconfirmed !== 'string' || !r.unconfirmed)) return `${r.id}: unconfirmed must be a reason`;
	if (!r.source || !Array.isArray(r.source.refs) || !r.source.refs.length) return `${r.id}: no source refs`;
	if (typeof r.fact !== 'string' || !r.fact) return `${r.id}: no fact text`;
	return null;
}

// Every quest, NPC and item id a rule names.
function questsOf(r) {
	const refs = [r.a, r.b, r.from, r.to].filter((x) => x && x.quest != null).map((x) => x.quest);
	return [r.quest, r.after, ...refs, ...(r.closes || [])].filter((x) => x != null).map(Number);
}
const npcsOf = (r) => [r.npc, r.vendor, r.trainer].filter((x) => x != null).map(Number);
function itemsOf(r) {
	const parts = Array.isArray(r.from) ? r.from.map((p) => p.item) : [];
	return [r.item, r.tool, ...parts].filter((x) => x != null).map(Number);
}

// world: { quests: [{ id }], npcs?: Set, items?: Set }; known: { quests,
// npcs, items } Sets for ids the world doesn't hold, by default data/forever's
// (dataIds()). An id with no set to check it against is an error: the check
// fails closed. -> { ok: Rule[], errors: [{ id, message, source }] }
function checkRules(rules, world, known = defaultKnown()) {
	const sets = {
		quest: [new Set(world.quests.map((q) => q.id)), known && known.quests].filter(Boolean),
		npc: [world.npcs, known && known.npcs].filter(Boolean),
		item: [world.items, known && known.items].filter(Boolean),
	};
	const ok = [];
	const errors = [];
	for (const r of rules) {
		const bad = (message) => errors.push({ id: r && r.id, message, source: (r && r.source) || null });
		const shape = checkShape(r);
		if (shape) {
			bad(shape);
			continue;
		}
		let message = null;
		for (const [kind, ids] of [['quest', questsOf(r)], ['npc', npcsOf(r)], ['item', itemsOf(r)]]) {
			if (!ids.length) continue;
			if (!sets[kind].length) message = `${r.id}: no ${kind} ids to check ${ids.join(', ')} against`;
			else {
				const miss = ids.find((id) => !sets[kind].some((s) => s.has(id)));
				if (miss !== undefined) message = `${r.id}: ${kind} ${miss} not in the world or the data`;
			}
			if (message) break;
		}
		if (message) bad(message);
		else ok.push(r);
	}
	return { ok, errors };
}

// -> { byQuest, byNpc, byItem }: Map<id, Rule[]>
function rulesFor(rules) {
	const byQuest = new Map();
	const byNpc = new Map();
	const byItem = new Map();
	const push = (m, ids, r) => {
		for (const k of new Set(ids)) (m.get(k) || m.set(k, []).get(k)).push(r);
	};
	for (const r of rules) {
		push(byQuest, questsOf(r), r);
		push(byNpc, npcsOf(r), r);
		push(byItem, itemsOf(r), r);
	}
	return { byQuest, byNpc, byItem };
}

module.exports = { FILE, KINDS, FIELDS, loadRules, dataIds, checkShape, checkRules, rulesFor };
