'use strict';
// Candidate quests for a draft route (reference data schema: docs/ARCHITECTURE.md).
//
// A quest is a candidate when it starts in the selected zones (an NPC/object
// spawn there, or an item that drops there), is available to the faction,
// race and class, has minLevel <= the range maximum, is not a profession or
// seasonal quest, and every objective and its turn-in can be done inside the
// zones. Breadcrumbs (no objectives, turn-in outside the zones) are kept apart
// for an optional final accept. Prerequisites are "any one of" `pre` (the
// pfQuest meaning); `next` adds the implied prerequisite; one quest of each
// `excl` group survives (a quest already done closes its group). Quests grey
// at the range minimum (level + 10 <= min) are dropped unless a kept quest
// needs them as its prerequisite; quests in `done` count as turned in.

const fs = require('node:fs');
const path = require('node:path');
const { makeProjector, clusters, dist } = require('./geo');
const { baseQuestXp } = require('../game/xp');
const { CLASSES, ALL_CLASSES, RACES, FACTION_RACES, SKYBORNE_BIT, hasBit, raceLabel, classLabel } = require('../game/races');

// Class names as drafts write them, with their mask bits.
const CLASS_NAMES = Object.values(CLASSES).map((c) => [classLabel(c.file), c.bit]);
// QuestSort ids of professions (quests.json `zone` < 0 is a sort, not a map).
const PROFESSION_SORTS = new Set([24, 101, 121, 181, 182, 201, 264, 304, 324]);

// Yards. Spawns this close form one cluster; quest-start items need this drop chance.
const CLUSTER_R = 50;
const MIN_START_DROP = 10;
const GREY_GAP = 10; // quest level this far below the range minimum is grey (10% XP)

const FILES = ['quests', 'npcs', 'objects', 'items', 'zones', 'map-frames'];

function loadData(dir) {
	const out = {};
	for (const name of FILES) {
		const file = path.join(dir, `${name}.json`);
		if (!fs.existsSync(file)) {
			if (name === 'quests' || name === 'npcs') throw new Error(`${file} not found (run \`forge data build\` or pass --data)`);
			out[name] = {};
			continue;
		}
		out[name] = JSON.parse(fs.readFileSync(file, 'utf8'));
	}
	return out;
}

function normName(s) {
	return String(s).toLowerCase().replace(/[^a-z0-9]/g, '');
}

function className(input) {
	const hit = CLASS_NAMES.find(([n]) => normName(n) === normName(input));
	return hit ? hit[0] : null;
}

function classList(mask) {
	if (mask == null || (mask & ALL_CLASSES) === ALL_CLASSES || (mask & ALL_CLASSES) === 0) return null;
	return CLASS_NAMES.filter(([, b]) => mask & b).map(([n]) => n);
}

// { name, bits: { Alliance?, Horde? }, faction } for a race: a known name,
// or any name with a numeric bit ("Newrace:512", the bit on both sides);
// unknown races without a bit get no bits and keep only quests open to their
// whole faction. `faction` is the race's only side, null when it has two.
function raceInfo(input) {
	const [nm, bitStr] = String(input).split(':');
	const known = RACES[normName(nm)];
	if (bitStr != null && bitStr !== '') {
		const bit = Number(bitStr);
		if (!Number.isInteger(bit) || bit < 0) throw new Error(`bad race bit in "${input}"`);
		const sides = known ? Object.keys(known.sides) : ['Alliance', 'Horde'];
		return { name: known ? raceLabel(known.file) : nm, bits: Object.fromEntries(sides.map((f) => [f, bit])), faction: known && sides.length === 1 ? sides[0] : null };
	}
	if (!known) return { name: nm, bits: {}, faction: null };
	const sides = Object.keys(known.sides);
	return { name: raceLabel(known.file), bits: { ...known.sides }, faction: sides.length === 1 ? sides[0] : null };
}

function zonesByName(zones) {
	const map = new Map();
	for (const z of Object.values(zones)) {
		if (!z || z.name == null) continue;
		const k = normName(z.name);
		if (!map.has(k)) map.set(k, []);
		map.get(k).push(z);
	}
	for (const list of map.values()) list.sort((a, b) => (a.type === 3 ? 0 : 1) - (b.type === 3 ? 0 : 1) || a.id - b.id);
	return map;
}

// "Elwynn Forest", "1429" or "map 1429" -> { id, name, unique }
function resolveZone(zones, spec) {
	const s = String(spec).trim();
	const m = /^(?:map\s+)?(\d+)$/i.exec(s);
	const byName = zonesByName(zones);
	if (m) {
		const z = zones[m[1]];
		const name = z && z.name != null ? String(z.name) : null;
		return { id: Number(m[1]), name, unique: !!name && byName.get(normName(name)).length === 1 };
	}
	const list = byName.get(normName(s));
	if (!list) throw new Error(`unknown zone "${s}" (not in zones.json)`);
	return { id: Number(list[0].id), name: String(list[0].name), unique: list.length === 1 };
}

// "AH", "A", "H", "Alliance", "Horde", "both"... -> may this faction use it?
function friendly(fac, faction) {
	if (typeof fac !== 'string' || !fac) return true;
	const f = fac.toLowerCase();
	if (f === 'a' || f === 'alliance') return faction === 'Alliance';
	if (f === 'h' || f === 'horde') return faction === 'Horde';
	return true;
}

function mobLevel(v, fallback) {
	if (typeof v === 'number') return v;
	if (typeof v === 'string') {
		const nums = v.split(/[^0-9]+/).filter(Boolean).map(Number);
		if (nums.length) return Math.round(nums.reduce((a, b) => a + b, 0) / nums.length);
	}
	return fallback;
}

const TRAINER_RE = /^(Warrior|Paladin|Hunter|Rogue|Priest|Shaman|Mage|Warlock|Druid) Trainer$/i;

function buildModel(data, opts, warn = () => {}) {
	const project = makeProjector(data['map-frames'], warn);
	const zoneMaps = new Set(opts.zones.map((z) => String(z.id)));
	const doneBefore = new Set(opts.done || []);
	const faction = opts.faction;
	const race = opts.race;
	const cls = opts.class || null;

	// Entities with their in-zone spawn clusters, cached.
	const cache = new Map();
	function entity(kind, id) {
		const key = `${kind}:${id}`;
		if (cache.has(key)) return cache.get(key);
		const raw = (kind === 'npc' ? data.npcs : data.objects)[String(id)];
		let ent = null;
		if (raw) {
			const pts = [];
			for (const [map, sp] of Object.entries(raw.spawns || {})) {
				if (!zoneMaps.has(map) || !sp || !Array.isArray(sp.pts)) continue;
				for (const p of sp.pts) if (Array.isArray(p) && p.length >= 2) pts.push(project.point(map, p[0], p[1], sp.f || null));
			}
			if (pts.length) {
				ent = {
					kind,
					id: Number(id),
					name: raw.name != null ? String(raw.name) : `${kind} ${id}`,
					raw,
					friendly: friendly(raw.faction, faction),
					clusters: clusters(pts, CLUSTER_R, project),
				};
			}
		}
		cache.set(key, ent);
		return ent;
	}
	const ents = (kind, ids) => (Array.isArray(ids) ? ids : []).map((id) => entity(kind, id)).filter(Boolean);
	const friendlyEnts = (kind, ids) => ents(kind, ids).filter((e) => e.friendly);

	// Best in-zone drop source of an item: highest chance, then most spawns, then id.
	function dropSource(itemId) {
		const item = data.items[String(itemId)];
		if (!item) return null;
		const sources = [];
		for (const kind of ['npc', 'object']) {
			const table = (item.drops && item.drops[kind]) || {};
			for (const [id, chance] of Object.entries(table)) {
				const e = entity(kind, id);
				if (e) sources.push({ ent: e, chance: Number(chance) || 0 });
			}
		}
		sources.sort((a, b) => b.chance - a.chance || b.ent.clusters[0].size - a.ent.clusters[0].size || (a.ent.kind < b.ent.kind ? -1 : a.ent.kind > b.ent.kind ? 1 : 0) || a.ent.id - b.ent.id);
		return sources.length ? { item, ...sources[0] } : null;
	}

	function locateObjective(q, o, oi) {
		const count = Number(o.count) > 0 ? Number(o.count) : 1;
		const base = { oi, type: o.type, id: Number(o.id), count };
		if (o.type === 'kill') {
			const e = entity('npc', o.id);
			if (!e) return null;
			return { ...base, verb: 'kill', ent: e, pt: e.clusters[0].pt, label: e.name, mobLevel: mobLevel(e.raw.level, q.level), kills: count };
		}
		if (o.type === 'object') {
			const e = entity('object', o.id);
			if (!e) return null;
			return { ...base, verb: 'interact', ent: e, pt: e.clusters[0].pt, label: e.name, kills: 0 };
		}
		if (o.type === 'item') {
			const src = dropSource(o.id);
			const itemName = (data.items[String(o.id)] && data.items[String(o.id)].name) || null;
			if (src) {
				const kills = src.ent.kind === 'npc' ? Math.ceil((count * 100) / Math.max(src.chance, 5)) : 0;
				return { ...base, verb: 'collect', ent: src.ent, pt: src.ent.clusters[0].pt, label: src.ent.name, itemName, mobLevel: mobLevel(src.ent.raw.level, q.level), kills };
			}
			const item = data.items[String(o.id)];
			const vendors = item ? friendlyEnts('npc', item.vendors) : [];
			if (vendors.length) {
				const v = vendors[0];
				return { ...base, verb: 'buy', ent: v, pt: v.clusters[0].pt, label: v.name, itemName, kills: 0 };
			}
			return null;
		}
		return null;
	}

	// Exploration: every `event` objective of a quest is one of its area
	// triggers (map/f/x/y per ARCHITECTURE); reaching any one completes the
	// exploration, so the draft goes to the in-zone trigger nearest the quest
	// giver (ties: data order). Returns { loc } or { reason }.
	function locateExploration(q, events, oi) {
		const placed = events.filter((o) => o.map != null && Number.isFinite(o.x) && Number.isFinite(o.y));
		if (!placed.length) return { reason: 'exploration objective has no location in data' };
		const inZone = placed.filter((o) => zoneMaps.has(String(o.map)));
		if (!inZone.length) return { reason: `exploration objective outside the zones (map ${placed[0].map})` };
		const anchor = q.starters.length ? q.starters[0].clusters[0].pt : q.pickup.pt;
		let best = null;
		for (const o of inZone) {
			const pt = project.point(o.map, o.x, o.y, o.f || null);
			if (!best || dist(anchor, pt) < dist(anchor, best.pt)) best = { o, pt };
		}
		const label = best.o.text ? String(best.o.text) : q.title;
		return { loc: { oi, type: 'event', id: Number(best.o.id), count: 1, verb: 'goto', ent: null, pt: best.pt, label, kills: 0 } };
	}

	const excluded = [];
	const exclude = (q, reason) => excluded.push({ id: q.id, title: q.title, reason });
	const quests = new Map();
	const breadcrumbs = [];
	const ids = Object.keys(data.quests).map(Number).filter(Number.isFinite).sort((a, b) => a - b);

	for (const id of ids) {
		const raw = data.quests[String(id)];
		if (!raw || doneBefore.has(id)) continue;
		const start = raw.start || {};
		const starters = friendlyEnts('npc', start.npc).concat(friendlyEnts('object', start.object));
		let pickup = null;
		if (!starters.length) {
			for (const itemId of (Array.isArray(start.item) ? start.item : []).slice().sort((a, b) => a - b)) {
				const src = dropSource(itemId);
				if (src && src.chance >= MIN_START_DROP) {
					pickup = { item: Number(itemId), itemName: src.item.name != null ? String(src.item.name) : null, ent: src.ent, pt: src.ent.clusters[0].pt, chance: src.chance };
					break;
				}
			}
		}
		if (!starters.length && !pickup) continue; // starts elsewhere: not part of this area
		const q = {
			id,
			raw,
			title: raw.title != null ? String(raw.title) : `Quest ${id}`,
			level: Number(raw.level) || Number(raw.minLevel) || opts.levelMin,
			minLevel: Number(raw.minLevel) || 1,
			starters,
			pickup,
			only: null,
			pre: (Array.isArray(raw.pre) ? raw.pre : []).map(Number).filter(Number.isFinite),
			excl: (Array.isArray(raw.excl) ? raw.excl : []).map(Number).filter(Number.isFinite),
			xp: typeof raw.xp === 'number' && raw.xp > 0 ? raw.xp : baseQuestXp(Number(raw.level) || 1),
		};
		const sortId = typeof raw.zone === 'number' && raw.zone < 0 ? -raw.zone : null;
		if (raw.event) {
			exclude(q, 'seasonal event');
			continue;
		}
		if (raw.skill || raw.requiredSkill || (sortId != null && PROFESSION_SORTS.has(sortId))) {
			exclude(q, 'profession');
			continue;
		}
		if (q.minLevel > opts.levelMax) {
			exclude(q, `minimum level ${q.minLevel} above range`);
			continue;
		}
		const races = raw.races;
		if (races != null && races !== 0) {
			const fm = FACTION_RACES[faction];
			const low = races % 2 ** 32;
			const ok = race.bit ? hasBit(races, race.bit) : (low & fm) === fm;
			if (!ok) {
				exclude(q, (low & fm) === 0 && !hasBit(races, SKYBORNE_BIT[faction] || 0) ? 'other faction' : 'other race');
				continue;
			}
		}
		const classes = classList(raw.classes);
		if (classes) {
			if (cls) {
				if (!classes.includes(cls)) {
					exclude(q, 'other class');
					continue;
				}
			} else {
				q.only = classes;
			}
		}
		const end = raw.end || {};
		q.enders = friendlyEnts('npc', end.npc).concat(friendlyEnts('object', end.object));
		const objs = Array.isArray(raw.objectives) ? raw.objectives : [];
		if (!q.enders.length) {
			const hasEnd = (end.npc && end.npc.length) || (end.object && end.object.length);
			if (hasEnd && !objs.length && q.starters.length) breadcrumbs.push(q);
			else exclude(q, hasEnd ? 'turn-in outside the zones' : 'no turn-in in data');
			continue;
		}
		q.objectives = [];
		let missing = null;
		// All event objectives share one slot: the quest's exploration.
		const events = [];
		let oi = 0;
		let eventOi = 0;
		for (const raw of objs) {
			const o = raw || {};
			if (o.type === 'event') {
				if (!eventOi) eventOi = ++oi;
				events.push(o);
				continue;
			}
			oi++;
			const loc = locateObjective(q, o, oi);
			if (loc) q.objectives.push(loc);
			else if (!missing) missing = `objective ${oi} (${o.type || '?'} ${o.id || ''}) outside the zones`;
		}
		if (events.length && !missing) {
			const ex = locateExploration(q, events, eventOi);
			if (ex.loc) q.objectives.push(ex.loc);
			else missing = ex.reason;
		}
		if (missing) {
			exclude(q, missing);
			continue;
		}
		quests.set(id, q);
	}

	// `next` implies the prerequisite when the follow-up has none.
	for (const q of quests.values()) {
		const n = Number(q.raw.next);
		const f = quests.get(n);
		if (f && !f.pre.length) f.pre = [q.id];
	}

	// A quest done earlier closes its exclusive group.
	const exclOf = (id) => (data.quests[String(id)] && Array.isArray(data.quests[String(id)].excl) ? data.quests[String(id)].excl : []);
	for (const q of [...quests.values()]) {
		const d = [...doneBefore].sort((a, b) => a - b).find((id) => q.excl.includes(id) || exclOf(id).includes(q.id));
		if (d == null) continue;
		exclude(q, `exclusive with ${d} (done)`);
		quests.delete(q.id);
	}

	const reachable = (q, set) => !q.pre.length || q.pre.some((p) => set.has(p) || doneBefore.has(p));

	// Grey quests stay only as prerequisites of quests worth doing.
	const grey = new Set([...quests.values()].filter((q) => q.level + GREY_GAP <= opts.levelMin).map((q) => q.id));
	if (grey.size) {
		const keep = new Set([...quests.keys()].filter((id) => !grey.has(id)));
		let changed = true;
		while (changed) {
			changed = false;
			for (const id of [...keep].sort((a, b) => a - b)) {
				const q = quests.get(id);
				if (reachable(q, keep)) continue;
				const g = q.pre.filter((p) => grey.has(p) && !keep.has(p)).sort((a, b) => a - b)[0];
				if (g != null) {
					keep.add(g);
					changed = true;
				}
			}
		}
		for (const id of grey) {
			if (keep.has(id)) continue;
			exclude(quests.get(id), 'grey for the level range');
			quests.delete(id);
		}
	}

	function cascade() {
		let changed = true;
		while (changed) {
			changed = false;
			for (const q of [...quests.values()]) {
				if (reachable(q, quests)) continue;
				exclude(q, `prerequisite ${q.pre.join('/')} not in this route`);
				quests.delete(q.id);
				changed = true;
			}
		}
	}
	cascade();

	// Exclusive groups: keep the member that unlocks the most, then most XP, then lowest id.
	const unlocks = (id, seen = new Set()) => {
		for (const q of quests.values()) if (!seen.has(q.id) && q.pre.includes(id)) {
			seen.add(q.id);
			unlocks(q.id, seen);
		}
		return seen.size;
	};
	const groupSeen = new Set();
	for (const q of [...quests.values()]) {
		if (groupSeen.has(q.id) || !q.excl.length) continue;
		const group = new Set([q.id]);
		const stack = [q.id];
		while (stack.length) {
			const cur = quests.get(stack.pop());
			const links = cur.excl.concat([...quests.values()].filter((o) => o.excl.includes(cur.id)).map((o) => o.id));
			for (const l of links) if (quests.has(l) && !group.has(l)) {
				group.add(l);
				stack.push(l);
			}
		}
		for (const g of group) groupSeen.add(g);
		if (group.size < 2) continue;
		const ranked = [...group].map((g) => quests.get(g)).map((g) => ({ g, u: unlocks(g.id), xp: g.xp }));
		ranked.sort((a, b) => b.u - a.u || b.xp - a.xp || a.g.id - b.g.id);
		for (const { g } of ranked.slice(1)) {
			exclude(g, `exclusive with ${ranked[0].g.id}`);
			quests.delete(g.id);
		}
	}
	cascade();

	// Class trainers known in the zones.
	const trainers = new Map();
	const addTrainer = (c, ent) => {
		if (!ent || !ent.friendly) return;
		if (!trainers.has(c)) trainers.set(c, []);
		if (!trainers.get(c).some((e) => e.id === ent.id)) trainers.get(c).push(ent);
	};
	for (const [c, id] of opts.trainers || []) addTrainer(c, entity('npc', id));
	const npcIds = Object.keys(data.npcs).map(Number).filter(Number.isFinite).sort((a, b) => a - b);
	for (const id of npcIds) {
		const raw = data.npcs[String(id)];
		const sub = raw && (raw.trainer || raw.title || raw.subname);
		if (!sub) continue;
		const m = TRAINER_RE.exec(String(sub).trim()) || TRAINER_RE.exec(`${String(sub).trim()} Trainer`);
		if (!m) continue;
		const ent = entity('npc', id);
		if (ent) addTrainer(className(m[1]), ent);
	}

	excluded.sort((a, b) => a.id - b.id);
	return { quests, breadcrumbs, excluded, trainers, project, doneBefore, entity };
}

module.exports = {
	FILES, loadData, buildModel, resolveZone, raceInfo, className, classList,
};
