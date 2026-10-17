'use strict';
// Reference data (data/forever/*.json, schema in docs/ARCHITECTURE.md) with
// the lookups the resolver needs. Missing files load as empty tables so a
// guide made only of explicit names still compiles; the caller is told which
// files were missing. The optional files (professions, factions, trainers,
// races, travel, spawnz) are also treated as missing when they cannot be parsed, so a
// half-built data folder never stops compilation. dungeons.json is not read:
// its DungeonJournal facts stay local (THIRD_PARTY.md), so a quest only it
// knows needs its title (and `lvl`) in the guide. The instances (group
// content) come from the cached client tables in the `sources` folder beside
// the data folder (data/sources for data/forever), when there is one.

const fs = require('node:fs');
const path = require('node:path');
const SOLO = require('../sim/solo');
const { loadAreas } = require('../data/areas');

const FILES = ['quests', 'npcs', 'objects', 'items', 'zones', 'map-frames', 'meta'];
const OPTIONAL = ['professions', 'factions', 'trainers', 'races', 'travel', 'spawnz'];

// Classic skill lines (game facts), so `skill <Profession> <N>` resolves even
// without professions.json. Riding (762) is Forever's one riding skill: the
// client's SkillLineAbility puts every racial riding spell under it
// (Apprentice Riding = 75, Journeyman Riding = 150).
const BUILTIN_PROFESSIONS = [
	{ id: 171, name: 'Alchemy' },
	{ id: 164, name: 'Blacksmithing' },
	{ id: 333, name: 'Enchanting' },
	{ id: 202, name: 'Engineering' },
	{ id: 182, name: 'Herbalism' },
	{ id: 165, name: 'Leatherworking' },
	{ id: 186, name: 'Mining' },
	{ id: 393, name: 'Skinning' },
	{ id: 197, name: 'Tailoring' },
	{ id: 185, name: 'Cooking' },
	{ id: 356, name: 'Fishing' },
	{ id: 129, name: 'First Aid' },
	{ id: 762, name: 'Riding' },
];

function zoneTypeRank(type) {
	// Prefer real zones (UIMapType 3), then dungeons/micro maps, then the rest.
	if (type === 3) return 0;
	if (type === 4 || type === 5 || type === 6) return 1;
	return 2;
}

function loadData(dir) {
	const raw = {};
	const missing = [];
	for (const name of [...FILES, ...OPTIONAL]) {
		const file = path.join(dir, `${name}.json`);
		if (!fs.existsSync(file)) {
			missing.push(`${name}.json`);
			raw[name] = {};
			continue;
		}
		try {
			raw[name] = JSON.parse(fs.readFileSync(file, 'utf8'));
		} catch (e) {
			if (!OPTIONAL.includes(name)) throw new Error(`${file}: ${e.message}`);
			missing.push(`${name}.json`);
			raw[name] = {};
		}
	}
	raw.instances = SOLO.loadInstances(path.join(dir, '..', 'sources'));
	raw.areas = loadAreas(path.join(dir, '..', 'sources'));
	return new Data(raw, { dir, missing });
}

function lowerKey(s) {
	return String(s).trim().toLowerCase();
}

class Data {
	constructor(raw, info = {}) {
		this.quests = raw.quests || {};
		this.npcs = raw.npcs || {};
		this.objects = raw.objects || {};
		this.items = raw.items || {};
		this.zones = raw.zones || {};
		this.mapFrames = raw['map-frames'] || {};
		this.meta = raw.meta || {};
		this.dir = info.dir || null;
		this.missing = info.missing || [];
		this.missingCore = this.missing.filter((f) => FILES.includes(f.replace(/\.json$/, '')));
		this.hasProfessions = !this.missing.includes('professions.json');
		this.hasFactions = !this.missing.includes('factions.json');
		this.indexProfessions(raw.professions || {});
		this.indexFactions(raw.factions || {});
		this.hasTrainers = !this.missing.includes('trainers.json');
		this.trainersRaw = raw.trainers || {};
		this.races = raw.races || {};
		this.travel = raw.travel || {};
		// Spawn heights (spawnz.json, CMaNGOS classic-db): { npc, object } ->
		// id -> [[instance map, x, y, z]], or null without the file (heights.js).
		this.spawnz = raw.spawnz && typeof raw.spawnz === 'object' && !this.missing.includes('spawnz.json') ? raw.spawnz : null;
		// Instances from the client's Map/AreaTable/UiMapAssignment (solo.js
		// loadInstances): { areas, maps } or null. Group content (group.js).
		this.instances = raw.instances || null;
		// The client's AreaTable (tools/lib/data/areas.js: the newest Forever
		// build cached beside the data folder), or null. Place IDs (places.js).
		this.areas = raw.areas || null;
		this.zoneByName = new Map();
		for (const z of Object.values(this.zones)) {
			if (!z || !z.name) continue;
			const key = String(z.name).toLowerCase();
			const list = this.zoneByName.get(key) || [];
			list.push(z);
			this.zoneByName.set(key, list);
		}
		for (const list of this.zoneByName.values()) {
			list.sort((a, b) => zoneTypeRank(a.type) - zoneTypeRank(b.type) || (a.system || 0) - (b.system || 0) || a.id - b.id);
		}
		this.hasXp = Object.values(this.quests).some((q) => q && typeof q.xp === 'number' && q.xp > 0);
	}

	quest(id) {
		return this.quests[id] || null;
	}

	npc(id) {
		return this.npcs[id] || null;
	}

	object(id) {
		return this.objects[id] || null;
	}

	item(id) {
		return this.items[id] || null;
	}

	zone(id) {
		return this.zones[id] || null;
	}

	// Classes a race file can be on one side (races.json, the Forever client's
	// CharBaseInfo); [] for an unknown race or side, or without races.json.
	raceClasses(raceFile, side) {
		const r = this.races[raceFile];
		return (r && r[side] && r[side].classes) || [];
	}

	// A quest's objectives in data order as [{ index (1-based, the `O` of
	// `quest Q.O`), kind (kill, item, object or event), id (null when the
	// data has none), name, count (null when the data has none) }]; [] for an
	// unknown quest or one without objectives.
	questObjectives(questId) {
		const q = this.quest(questId);
		if (!q || !Array.isArray(q.objectives)) return [];
		return q.objectives.map((o, i) => {
			const kind = o && o.type ? String(o.type) : 'event';
			const id = o && o.id != null ? o.id : null;
			const e = id == null ? null : kind === 'kill' ? this.npc(id) : kind === 'item' ? this.item(id) : kind === 'object' ? this.object(id) : null;
			const name = (e && e.name && String(e.name)) || (o && o.text ? String(o.text) : null);
			return { index: i + 1, kind, id, name, count: o && Number(o.count) > 0 ? Number(o.count) : null };
		});
	}

	indexProfessions(raw) {
		this.professions = new Map(); // skillLine -> profession
		this.professionByName = new Map();
		this.recipeBySpell = new Map(); // spell -> { recipe, profession }
		const ids = Object.keys(raw)
			.map(Number)
			.filter((id) => Number.isInteger(id) && raw[id] && typeof raw[id] === 'object')
			.sort((a, b) => a - b);
		for (const id of ids) {
			const p = { ...raw[id], id };
			this.professions.set(id, p);
			if (p.name) this.professionByName.set(lowerKey(p.name), p);
			for (const r of Array.isArray(p.recipes) ? p.recipes : []) {
				const spell = r && Number(r.spell);
				if (Number.isInteger(spell) && spell > 0 && !this.recipeBySpell.has(spell)) this.recipeBySpell.set(spell, { recipe: r, profession: p });
			}
		}
		for (const b of BUILTIN_PROFESSIONS) {
			if (!this.professionByName.has(lowerKey(b.name))) this.professionByName.set(lowerKey(b.name), b);
		}
	}

	// Profession by name (professions.json, else the Classic built-ins) or null.
	professionNamed(name) {
		return this.professionByName.get(lowerKey(name)) || null;
	}

	profession(skillLine) {
		return this.professions.get(Number(skillLine)) || BUILTIN_PROFESSIONS.find((b) => b.id === Number(skillLine)) || null;
	}

	// -> { recipe, profession } | null
	recipe(spell) {
		return this.recipeBySpell.get(Number(spell)) || null;
	}

	indexFactions(raw) {
		this.factions = new Map();
		this.factionByName = new Map();
		const ids = Object.keys(raw)
			.map(Number)
			.filter((id) => Number.isInteger(id) && raw[id] && typeof raw[id] === 'object')
			.sort((a, b) => a - b);
		for (const id of ids) {
			const f = { ...raw[id], id };
			this.factions.set(id, f);
			if (!f.name) continue;
			const key = lowerKey(f.name);
			if (!this.factionByName.has(key)) this.factionByName.set(key, []);
			this.factionByName.get(key).push(f);
		}
	}

	// Class trainers as [{ id, classes }], sorted by id: trainers.json when
	// present (`node tools/polestar.js trainers build`), else the curated list
	// resolved against npcs.json.
	classTrainers() {
		if (this._classTrainers) return this._classTrainers;
		let list;
		if (this.hasTrainers) {
			list = Object.values(this.trainersRaw)
				.filter((t) => t && Number(t.id) > 0 && Array.isArray(t.classes) && t.classes.length)
				.map((t) => ({ id: Number(t.id), classes: t.classes.map(String) }));
		} else {
			const { curatedTrainers } = require('./trainers');
			list = [...curatedTrainers(this).entries.values()].map((e) => ({ id: e.id, classes: [...e.classes] }));
		}
		this._classTrainers = list.sort((a, b) => a.id - b.id);
		return this._classTrainers;
	}

	// Npc ids with a role ("vendor", "innkeeper", ...), sorted.
	npcsWithRole(role) {
		if (!this._roles) this._roles = new Map();
		if (!this._roles.has(role)) {
			const ids = Object.values(this.npcs)
				.filter((n) => n && Array.isArray(n.roles) && n.roles.includes(role))
				.map((n) => Number(n.id))
				.sort((a, b) => a - b);
			this._roles.set(role, ids);
		}
		return this._roles.get(role);
	}

	// Inns with an innkeeper (travel.json): [{ location, names (the bind
	// locations the game may report, first = location), npc, npcName, map,
	// x, y }]; [] without travel.json.
	inns() {
		return Array.isArray(this.travel.inns) ? this.travel.inns : [];
	}

	// Flight masters (travel.json): [{ id, name ("Stormwind, Elwynn"), short
	// ("Stormwind"), npc, npcName, map, x, y, faction (1 Alliance, 2 Horde,
	// 3 both) }]; [] without travel.json.
	flightNodes() {
		return this.travel.taxi && Array.isArray(this.travel.taxi.nodes) ? this.travel.taxi.nodes : [];
	}

	faction(id) {
		return this.factions.get(Number(id)) || null;
	}

	// -> { faction, ambiguous: [factions] | null } | null (lowest id wins)
	factionNamed(name) {
		const list = this.factionByName.get(lowerKey(name));
		if (!list || !list.length) return null;
		return { faction: list[0], ambiguous: list.length > 1 ? list : null };
	}

	// -> { zone, ambiguous: [zones] } | null
	zoneNamed(name) {
		const list = this.zoneByName.get(String(name).toLowerCase());
		if (!list || !list.length) return null;
		const best = list[0];
		const tied = list.filter((z) => zoneTypeRank(z.type) === zoneTypeRank(best.type) && (z.system || 0) === (best.system || 0));
		return { zone: best, ambiguous: tied.length > 1 ? tied : null };
	}

	eraFrame(map) {
		const era = this.mapFrames.era || {};
		return era[map] || null;
	}

	// Bounds for yard math: the Era frame, else the Forever one (a map Forever
	// added, such as Zephras Isle or Riverglades, has only that; its points are
	// in the live frame). Not for converting Era-frame coordinates.
	frame(map) {
		const forever = this.mapFrames.forever || {};
		return this.eraFrame(map) || forever[map] || null;
	}

	// Map size in yards for distance math: the map's bounds when known.
	mapSize(map) {
		const fr = this.frame(map);
		if (!fr) return null;
		const w = Math.abs(fr.right - fr.left);
		const h = Math.abs(fr.bottom - fr.top);
		return w > 0 && h > 0 ? { w, h } : null;
	}

	// Entity spawns as [{ map, f, pts, more }] sorted by map id: `pts` the
	// reference data's evenly spread points (at most its cap per map), `more`
	// the points the cap left out ([] when none), for what must know every
	// place an entity spawns.
	spawns(kind, id) {
		const e = kind === 'npc' ? this.npc(id) : kind === 'object' ? this.object(id) : null;
		if (!e || !e.spawns) return [];
		const ok = (p) => Array.isArray(p) && p.length >= 2;
		return Object.keys(e.spawns)
			.map((m) => ({ map: Number(m), f: e.spawns[m].f, pts: (e.spawns[m].pts || []).filter(ok), more: (e.spawns[m].more || []).filter(ok) }))
			.filter((s) => s.pts.length)
			.sort((a, b) => a.map - b.map);
	}
}

// The guide verb for each objective kind (an event has none: the game ticks it).
const OBJECTIVE_VERB = { kill: 'kill', item: 'collect', object: 'interact' };

// One objective of questObjectives as "7.1 = kill Kobold Vermin x10".
function objectiveLabel(questId, o) {
	const what = o.name || (o.id != null ? `${o.kind} ${o.id}` : 'unnamed');
	return `${questId}.${o.index} = ${OBJECTIVE_VERB[o.kind] || o.kind} ${what}${o.count ? ` x${o.count}` : ''}`;
}

// Whether dir holds any of the core files: without one, every quest, NPC and
// zone lookup fails.
function hasCoreData(dir) {
	return FILES.some((name) => fs.existsSync(path.join(dir, `${name}.json`)));
}

// No reference data at all (`--no-data`): every file counts as missing.
function emptyData() {
	return new Data({}, { missing: [...FILES, ...OPTIONAL].map((name) => `${name}.json`) });
}

module.exports = { loadData, Data, objectiveLabel, hasCoreData, emptyData, CORE_FILES: FILES.map((name) => `${name}.json`) };
