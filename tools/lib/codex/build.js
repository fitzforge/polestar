'use strict';
// `codex build`: every importer + data/forever + the Forever client's tables
// -> the Codex (data/forever/codex/*.json, shapes in docs/ARCHITECTURE.md,
// "Codex (`codex build`)", and tools/lib/codex/pack.js) and the load-on-demand pack addon/Polestar_Codex.
// Same inputs give byte-identical output.
//
//   loadInputs(opts)      -> inputs (runs importers, reads files, client tables)
//   mergeCodex(inputs)    -> codex  (pure; tests inject synthetic inputs)
//   buildCodex(opts)      -> writes JSON + pack, measures pack memory
//
// inputs = {
//   forever: { items, npcs, objects, quests, zones, factions, professions, trainers,
//              mapFrames, meta, instances (recorded), dungeons|null },  (data/forever/*.json)
//   flbis|null,                                           (tools/lib/consume/foreverlevelingbis.js)
//   atlasloot|null, rarescanner|null                      (--local-extras only)
//   client: clientFacts(tables) + { instanceMaps, instances: instanceFacts() }|null,
//   curated: [item ids guides collect], curatedGates: curatedRepGates(), entrances: curatedEntrances(),
//   entranceTable: loadEntranceTable() (tools/lib/codex/entrances.json),
//   repTable: loadRepGateTable() (tools/lib/codex/repgates.json), localExtras,
// }
// Without AtlasLoot and dungeons.json the instances come from the client
// tables (tools/lib/codex/instances.js).
//
// Precedence for one fact found in several inputs (docs/SUITE.md, "Data
// layer"): recordings > client tables > Forever-specific (QuestieDB Forever,
// ForeverLevelingBiS, RareScanner, DungeonJournal) > Era (pfQuest, AtlasLoot)
// > Wowhead. Sources of one item dedupe by type + npc/object/quest/spell/
// faction; each field comes from the highest-ranked input that has it and
// `from` keeps every input.

const fs = require('node:fs');
const os = require('node:os');
const path = require('node:path');
const { spawnSync } = require('node:child_process');
const { emitPack, packOrder, ADDON, SCHEMA } = require('./pack');
const { instanceFacts, buildInstances, curatedEntrances, loadEntranceTable } = require('./instances');
const { loadWowhead, chanceOf } = require('./wowhead');
const { blockingPrereqs } = require('../data/prereqs');

const { ROOT, DATA, SOURCES } = require('../paths');
const { CLASSES, FACTION_RACES } = require('../game/races');
// Map, AreaTable, DungeonEncounter, LFGDungeons, MapDifficulty and ContentTuning
// give the dungeons and raids (tools/lib/codex/instances.js); Mount and
// BattlePetSpecies the mount and companion summon spells.
const TABLES = [
	'Item', 'ItemSparse', 'ItemEffect', 'ItemXItemEffect', 'SpellEffect', 'SpellName', 'SkillLine', 'SkillLineAbility', 'Map', 'AreaTable',
	'DungeonEncounter', 'LFGDungeons', 'MapDifficulty', 'ContentTuning', 'Mount', 'BattlePetSpecies',
];
// The Forever client's ItemSparse lacks ~5k items Forever still has; their
// names, quality and levels fall back to the Classic Era client (lower rank).
const ERA_BUILD = '1.15.9.70003';
const ERA_TABLES = ['Item', 'ItemSparse', 'ItemEffect', 'Map'];

// curated: the cited reputation gate table (tools/lib/codex/repgates.json);
// guides: Polestar's own curated guides (a collectible's `rep` before its
// `buy`). A gate from the client beats the table, the table a guide's.
const RANK = { recordings: 0, client: 1, curated: 2, guides: 3, questie: 4, flbis: 4, rarescanner: 4, dungeons: 4, journal: 4, forever: 4, pfquest: 5, atlasloot: 5, wowhead: 6 };
const RANK_UNKNOWN = 7;
// gift: an NPC hands the item out (casts a spell that creates it).
const KEY_FIELD = { vendor: 'npc', drop: 'npc', object: 'object', quest: 'quest', gift: 'npc', craft: 'spell', rep: 'faction', pvp: null, container: 'item', world: null };
const TYPE_ORDER = ['vendor', 'quest', 'gift', 'craft', 'rep', 'pvp', 'drop', 'object', 'container', 'world'];
const SOURCE_FIELDS = {
	vendor: ['npc', 'cost', 'limited'],
	drop: ['npc', 'chance', 'instance'],
	object: ['object', 'chance'],
	quest: ['quest', 'choice'],
	gift: ['npc', 'spell'],
	craft: ['spell', 'skillLine', 'profession', 'skill'],
	rep: ['faction', 'standing', 'npc'],
	pvp: ['rank', 'npc'],
	container: ['item', 'chance'],
	world: ['minLevel', 'maxLevel'],
};

// Per item: the strongest drops/objects/vendors are kept; an item many
// creatures drop also gets one `world` source with their level range.
const CAP = { drop: 10, object: 6, vendor: 10, container: 6 };
const WORLD_DROP_NPCS = 12;
// Spawns: clusters per map, maps per entity.
const SPAWN = { radius: 3, perMap: 5, maps: 4 };
// Loot listed on a rare NPC or treasure (Codex.Loot; the Rares view picks its
// signature drop from it): its own drops (items nothing else drops or holds)
// first, then best-known chance. A rare's candidates run to hundreds (the
// world-drop pool; median 286), so the list is cut: 150 keeps every drop
// RareScanner names for a rare or treasure Wowhead Forever confirms.
const LOOT_CAP = 150;

// Class mount spells the client tables give no class for (SkillLineAbility
// ClassMask 0 and no SpellClassOptions row on 1.60.1.70338).
const CLASS_MOUNT_FALLBACK = { 5784: 'WARLOCK', 23161: 'WARLOCK' };


const SKILL_MOUNTS = 777;
const SKILL_COMPANIONS = 778;
const AURA_MOUNTED = 78;
const EFFECT_AURA = 6;
const EFFECT_CREATE_ITEM = 24;
const TRIGGER_LEARN = 6;
const TRIGGER_USE = 0;

const JUNK = /^(?:Monster - |Deprecated |zz|\[PH\]|\[UNUSED\]|TEST |Test |OLD ?(?=[A-Z]))|\bDEPRECATED\b|Only GM can see|\(DND\)|\bDND\b|\[DNT\]/;

function int(v) {
	if (v === null || v === undefined || v === '') return null;
	const n = Number(v);
	return Number.isFinite(n) ? n : null;
}

function round1(v) {
	return Math.round(Number(v) * 10) / 10;
}

function slug(s) {
	return String(s)
		.normalize('NFKD')
		.replace(/[\u0300-\u036f]/g, '')
		.toLowerCase()
		.replace(/['’]/g, '')
		.replace(/[^a-z0-9]+/g, '-')
		.replace(/^-+|-+$/g, '');
}

function normName(s) {
	return slug(s).replace(/^the-/, '').replace(/-/g, '');
}

function byId(a, b) {
	return Number(a) - Number(b);
}

function sortKeysDeep(v) {
	if (Array.isArray(v)) return v.map(sortKeysDeep);
	if (v && typeof v === 'object') {
		const out = {};
		const keys = Object.keys(v).sort((a, b) => {
			const na = Number(a);
			const nb = Number(b);
			if (Number.isFinite(na) && Number.isFinite(nb) && String(na) === a && String(nb) === b) return na - nb;
			return a < b ? -1 : a > b ? 1 : 0;
		});
		for (const k of keys) out[k] = sortKeysDeep(v[k]);
		return out;
	}
	return v;
}

// ---------------------------------------------------------------------------
// Client tables -> facts
// ---------------------------------------------------------------------------

// tables: { Item, ItemSparse, ItemEffect, ItemXItemEffect, SpellEffect, SpellName,
//           SkillLine, SkillLineAbility } rows (wago.tools CSV) ->
// { build, items: { id: { name, quality, reqLevel, buyPrice, classId, subclassId, inventoryType,
//   minFaction, minStanding, pvpRank, learn, use } }, spellNames: { id: name },
//   mountAura: Set(spellId), skillLines: { id: name }, skillAbility: { spell: skillLine },
//   mountSkill: [spellId], companionSkill: [spellId], spellClass: { spell: CLASS },
//   creates: { item: [spellId] } (SpellEffect 24, create item; no profession's spell) }
function clientFacts(tables, build = null) {
	const items = {};
	for (const r of tables.ItemSparse || []) {
		const id = int(r.ID);
		if (!id) continue;
		const minFaction = int(r.MinFactionID);
		// RequiredPVPRank is the client's rank index: 5..18 = title ranks 1..14
		// (Private/Scout .. Grand Marshal/High Warlord); 1..4 are the dishonoured ranks.
		const rawRank = int(r.RequiredPVPRank);
		const pvpRank = rawRank >= 5 ? rawRank - 4 : null;
		items[id] = {
			name: r.Display_lang || null,
			quality: int(r.OverallQualityID),
			reqLevel: int(r.RequiredLevel) || null,
			buyPrice: int(r.BuyPrice) || null,
			minFaction: minFaction > 0 ? minFaction : null,
			minStanding: minFaction > 0 ? (int(r.MinReputation) || 0) + 1 : null,
			pvpRank,
			reqSkill: int(r.RequiredSkill) || null,
			reqSkillRank: int(r.RequiredSkill) ? int(r.RequiredSkillRank) || null : null,
		};
	}
	for (const r of tables.Item || []) {
		const it = items[int(r.ID)];
		if (!it) continue;
		it.classId = int(r.ClassID);
		it.subclassId = int(r.SubclassID);
		it.inventoryType = int(r.InventoryType);
	}
	const effects = {};
	for (const r of tables.ItemEffect || []) effects[r.ID] = r;
	const links = (tables.ItemXItemEffect || []).map((r) => ({ item: int(r.ItemID), effect: effects[r.ItemEffectID] }));
	// Older layouts carry ParentItemID on ItemEffect itself.
	for (const r of tables.ItemEffect || []) if (r.ParentItemID) links.push({ item: int(r.ParentItemID), effect: r });
	links.sort((a, b) => a.item - b.item || int(a.effect && a.effect.ID) - int(b.effect && b.effect.ID));
	for (const { item, effect } of links) {
		const it = items[item];
		if (!it || !effect) continue;
		const spell = int(effect.SpellID);
		if (!spell) continue;
		const trig = int(effect.TriggerType);
		if (trig === TRIGGER_LEARN && !it.learn) it.learn = spell;
		else if (trig === TRIGGER_USE && !it.use) it.use = spell;
	}
	const spellNames = {};
	for (const r of tables.SpellName || []) spellNames[int(r.ID)] = r.Name_lang;
	const mountAura = new Set();
	const teaches = {}; // spell -> the spell it teaches (Effect 36, learn spell)
	const petCreatures = new Set((tables.BattlePetSpecies || []).map((r) => int(r.CreatureID)).filter(Boolean));
	const summonsPet = new Set(); // spells that summon a companion creature (Effect 28)
	for (const r of tables.SpellEffect || []) {
		if (int(r.Effect) === 28 && petCreatures.has(int(r.EffectMiscValue_0))) summonsPet.add(int(r.SpellID));
		if (int(r.Effect) === EFFECT_AURA && int(r.EffectAura) === AURA_MOUNTED) mountAura.add(int(r.SpellID));
		if (int(r.Effect) === 36 && int(r.EffectTriggerSpell) && !teaches[int(r.SpellID)]) teaches[int(r.SpellID)] = int(r.EffectTriggerSpell);
	}
	const skillLines = {};
	for (const r of tables.SkillLine || []) skillLines[int(r.ID)] = r.DisplayName_lang;
	const skillAbility = {};
	const mountSkill = [];
	const companionSkill = [];
	const spellClass = {};
	for (const r of tables.SkillLineAbility || []) {
		const spell = int(r.Spell);
		const line = int(r.SkillLine);
		if (!spell) continue;
		if (!(spell in skillAbility)) skillAbility[spell] = line;
		if (line === SKILL_MOUNTS) mountSkill.push(spell);
		if (line === SKILL_COMPANIONS) companionSkill.push(spell);
		const mask = int(r.ClassMask) || 0;
		const classes = Object.values(CLASSES).filter((c) => mask & c.bit).map((c) => c.file);
		if (classes.length === 1) spellClass[spell] = classes[0];
	}
	for (const [spell, cls] of Object.entries(CLASS_MOUNT_FALLBACK)) if (!spellClass[spell]) spellClass[spell] = cls;
	// Spells that create an item (Effect 24) outside a skill line: an NPC's
	// gift (Duke Hydraxis's Create Aqual Quintessence), an item's use.
	const creates = {};
	for (const r of tables.SpellEffect || []) {
		const spell = int(r.SpellID);
		const item = int(r.EffectItemType);
		if (int(r.Effect) !== EFFECT_CREATE_ITEM || !item || !spell || spell in skillAbility) continue;
		const list = (creates[item] = creates[item] || []);
		if (!list.includes(spell)) list.push(spell);
	}
	for (const list of Object.values(creates)) list.sort(byId);
	// Summon spells the client names as mounts (Mount.SourceSpellID) and companions (BattlePetSpecies.SummonSpellID).
	const mountSpells = new Set((tables.Mount || []).map((r) => int(r.SourceSpellID)).filter(Boolean));
	// A miscellaneous item whose spell carries a Mount row's name casts that mount
	// by script (Black Qiraji Resonating Crystal: 26656 "Summon Black Qiraji Battle Tank").
	const mountNames = new Set((tables.Mount || []).map((r) => r.Name_lang).filter(Boolean));
	for (const it of Object.values(items)) {
		const sp = it.use || it.learn;
		if (it.classId === 15 && sp && mountNames.has(spellNames[sp])) mountSpells.add(sp);
	}
	// Mount.Flags 0x40: hidden from the mount journal until known (retired mounts).
	const mountHidden = new Set((tables.Mount || []).filter((r) => (int(r.Flags) || 0) & 0x40).map((r) => int(r.SourceSpellID)).filter(Boolean));
	const petSpells = new Set([...(tables.BattlePetSpecies || []).map((r) => int(r.SummonSpellID)).filter(Boolean), ...summonsPet]);
	return { build, items, spellNames, mountAura, teaches, mountSpells, mountHidden, petSpells, skillLines, skillAbility, mountSkill: [...new Set(mountSkill)].sort(byId), companionSkill: [...new Set(companionSkill)].sort(byId), spellClass, creates };
}

// ---------------------------------------------------------------------------
// Spawns
// ---------------------------------------------------------------------------

// [[x, y], ...] -> [{ x, y, n }] greedy clusters (radius in map percent), biggest first.
function cluster(points, radius = SPAWN.radius) {
	const pts = points
		.filter((p) => Array.isArray(p) && Number.isFinite(Number(p[0])) && Number.isFinite(Number(p[1])))
		.map(([x, y]) => [Number(x), Number(y)])
		.sort((a, b) => a[0] - b[0] || a[1] - b[1]);
	const clusters = [];
	for (const [x, y] of pts) {
		let best = null;
		for (const c of clusters) {
			const dx = c.sx / c.n - x;
			const dy = c.sy / c.n - y;
			if (dx * dx + dy * dy <= radius * radius) {
				best = c;
				break;
			}
		}
		if (best) {
			best.sx += x;
			best.sy += y;
			best.n++;
		} else clusters.push({ sx: x, sy: y, n: 1 });
	}
	return clusters
		.map((c) => ({ x: round1(c.sx / c.n), y: round1(c.sy / c.n), n: c.n }))
		.sort((a, b) => b.n - a.n || a.x - b.x || a.y - b.y);
}

// { map: { f, pts } } (data/forever) -> [{ map, x, y, f }] capped; only maps in `zones`.
function spawnsOf(byMap, zones) {
	const maps = Object.entries(byMap || {})
		.filter(([map]) => !zones || zones[map])
		.map(([map, s]) => ({ map: Number(map), f: s && s.f === 'e' ? 'e' : null, clusters: cluster((s && s.pts) || []) }))
		.filter((m) => m.clusters.length)
		.sort((a, b) => b.clusters.reduce((n, c) => n + c.n, 0) - a.clusters.reduce((n, c) => n + c.n, 0) || a.map - b.map)
		.slice(0, SPAWN.maps);
	const out = [];
	for (const m of maps) for (const c of m.clusters.slice(0, SPAWN.perMap)) out.push({ map: m.map, x: c.x, y: c.y, f: m.f });
	return out;
}

// ---------------------------------------------------------------------------
// Merge
// ---------------------------------------------------------------------------

function fromLabels(list) {
	const out = new Set();
	for (const s of list || []) {
		if (/^questie/.test(s)) out.add('questie');
		else if (s === 'pfquest') out.add('pfquest');
		else if (/^record/.test(s)) out.add('recordings');
		else if (RANK[s] !== undefined) out.add(s);
	}
	if (!out.size) out.add('forever');
	return [...out];
}

// Reputation value -> standing 1..8 (Hated..Exalted): the lowest value of each.
const STANDING_FLOOR = [-42000, -6000, -3000, 0, 3000, 9000, 21000, 42000];
function standingOf(value) {
	let s = 1;
	for (let i = 0; i < STANDING_FLOOR.length; i++) if (value >= STANDING_FLOOR[i]) s = i + 1;
	return s;
}

// The standing a quest's rewards need (data/forever quests.json, QuestieDB):
// `minRep` to take it, or a `reputation` objective to finish it, the higher
// of the two -> { faction, standing } | null. Neutral counts (Timbermaw Hold
// starts below it); Hated gates nothing.
function questRep(q) {
	let best = null;
	for (const r of [q && q.minRep, q && q.reputation]) {
		if (!r || !r.faction || typeof r.value !== 'number') continue;
		const standing = standingOf(r.value);
		if (standing <= 1) continue;
		if (!best || standing > best.standing) best = { faction: r.faction, standing };
	}
	return best;
}

function rankOf(from) {
	return Math.min(...from.map((f) => (RANK[f] === undefined ? RANK_UNKNOWN : RANK[f])));
}

function sortFrom(from) {
	return [...new Set(from)].sort((a, b) => (RANK[a] ?? RANK_UNKNOWN) - (RANK[b] ?? RANK_UNKNOWN) || (a < b ? -1 : 1));
}

function sideOf(side) {
	if (side === 'Alliance' || side === 'A' || side === 1) return 'A';
	if (side === 'Horde' || side === 'H' || side === 2) return 'H';
	return null;
}

function factionOfRaces(races) {
	const r = int(races);
	if (!r) return null;
	const a = (r & FACTION_RACES.Alliance) !== 0;
	const h = (r & FACTION_RACES.Horde) !== 0;
	if (a && !h) return 'A';
	if (h && !a) return 'H';
	return null;
}

// Candidate sources -> deduped, field-merged, capped, ordered list.
// isBoss(npc): a boss's drops stay past the cap (its instance's loot list).
// onCut(source): each merged source the cap leaves out (parity's evidence).
function finalizeSources(cands, npcLevel, isBoss = () => true, onCut = null) {
	const groups = new Map();
	for (const c of cands) {
		const kf = KEY_FIELD[c.type];
		const key = `${c.type}|${kf ? c[kf] : ''}`;
		if (!groups.has(key)) groups.set(key, []);
		groups.get(key).push(c);
	}
	let out = [];
	for (const list of groups.values()) {
		list.sort((a, b) => rankOf(a.from) - rankOf(b.from));
		const merged = { type: list[0].type };
		for (const f of SOURCE_FIELDS[merged.type]) {
			for (const c of list) {
				if (c[f] !== null && c[f] !== undefined && c[f] !== false) {
					merged[f] = c[f];
					break;
				}
			}
		}
		merged.from = sortFrom(list.flatMap((c) => c.from));
		out.push(merged);
	}
	const drops = out.filter((s) => s.type === 'drop');
	if (drops.length > WORLD_DROP_NPCS && !out.some((s) => s.type === 'world')) {
		const levels = drops.map((s) => npcLevel(s.npc)).filter((l) => l);
		if (levels.length) {
			const from = sortFrom(drops.flatMap((s) => s.from));
			out.push({ type: 'world', minLevel: Math.min(...levels.map((l) => l[0])), maxLevel: Math.max(...levels.map((l) => l[1])), from });
		}
	}
	const keyOf = (s) => {
		const kf = KEY_FIELD[s.type];
		return kf ? Number(s[kf]) || 0 : 0;
	};
	out.sort(
		(a, b) =>
			TYPE_ORDER.indexOf(a.type) - TYPE_ORDER.indexOf(b.type) ||
			(b.chance ?? -1) - (a.chance ?? -1) ||
			(b.instance ? 1 : 0) - (a.instance ? 1 : 0) ||
			keyOf(a) - keyOf(b),
	);
	const seen = {};
	out = out.filter((s) => {
		seen[s.type] = (seen[s.type] || 0) + 1;
		const keep = !CAP[s.type] || seen[s.type] <= CAP[s.type] || (s.type === 'drop' && s.instance && isBoss(s.npc));
		if (!keep && onCut) onCut(s);
		return keep;
	});
	return out;
}

function mergeCodex(inputs) {
	const fv = inputs.forever || {};
	const al = inputs.atlasloot || null;
	const rs = inputs.rarescanner || null;
	const flb = inputs.flbis || null;
	const cl = inputs.client || null;
	const zonesIn = fv.zones || {};
	const warnings = [];

	// ----- zones, factions
	const zones = {};
	for (const [id, z] of Object.entries(zonesIn)) zones[id] = { id: Number(id), name: z.name };
	const factions = {};
	for (const [id, f] of Object.entries(fv.factions || {})) factions[id] = { id: Number(id), name: f.name, side: f.side || null };
	for (const f of (al && al.factions) || []) {
		if (f.factionId && !factions[f.factionId] && f.name) factions[f.factionId] = { id: f.factionId, name: f.name, side: null };
	}

	// ----- npcs
	const npcs = {};
	const npcRoles = {};
	for (const [id, n] of Object.entries(fv.npcs || {})) {
		if (!n.name || JUNK.test(n.name)) continue;
		const rank = int(n.rank);
		npcs[id] = {
			id: Number(id),
			name: n.name,
			level: int(n.level),
			levelMax: int(n.levelMax),
			faction: ['A', 'H', 'AH'].includes(n.faction) ? n.faction : null,
			rare: rank === 2 || rank === 4 || (n.roles || []).includes('rare'),
			elite: rank === 1 || rank === 2 || rank === 3,
			boss: rank === 3,
			instance: null,
			roles: [],
			spawns: spawnsOf(n.spawns, zonesIn),
		};
		npcRoles[id] = new Set(n.roles || []);
	}
	// Wowhead Forever per-entity facts (tools/lib/codex/wowhead.js), release
	// build only: a level, rare rank or spawns our data lacks, and the rares
	// only Wowhead knows (with a name and a place).
	const wh = (!al && inputs.wowhead) || null;
	if (wh) {
		for (const [id, w] of Object.entries(wh.npc)) {
			const rareW = w.classification === 'rare' || w.classification === 'rareelite';
			const live = Object.fromEntries(Object.entries(w.spawns || {}).map(([m, pts]) => [m, { f: null, pts }]));
			const spawns = spawnsOf(live, zonesIn);
			let rec = npcs[id];
			if (!rec) {
				// An NPC only Wowhead knows: a rare with a place, or anything that drops.
				if (!w.name || JUNK.test(w.name) || !(rareW ? spawns.length : spawns.length || (w.drops || []).length)) continue;
				const elite = ['rareelite', 'elite', 'boss'].includes(w.classification);
				rec = npcs[id] = { id: Number(id), name: w.name, level: null, levelMax: null, faction: null, rare: rareW, elite, boss: w.classification === 'boss', instance: null, roles: [], spawns };
				npcRoles[id] = new Set(rareW ? ['rare'] : []);
			}
			if (rec.level == null && w.level) {
				rec.level = w.level[0];
				rec.levelMax = w.level[1] !== w.level[0] ? w.level[1] : null;
			}
			if (rareW && !rec.rare) {
				rec.rare = true;
				if (w.classification === 'rareelite') rec.elite = true;
				npcRoles[id].add('rare');
			}
			if (!rec.spawns.length && spawns.length) rec.spawns = spawns;
		}
		// Wowhead's cached NPC list rows (data/sources/wowhead/codex/lists):
		// the level of an NPC neither our data nor a page gives one. Only the
		// level: a row's rank and place are no page's (rares and bosses stay
		// the pages' and the data's).
		for (const [id, r] of Object.entries((wh.listed && wh.listed.npc) || {})) {
			const rec = npcs[id];
			if (!rec || rec.level != null || !r.level) continue;
			rec.level = r.level[0];
			rec.levelMax = r.level[1] !== r.level[0] ? r.level[1] : null;
		}
	}
	const addRole = (id, role) => {
		if (!npcs[id]) return;
		(npcRoles[id] = npcRoles[id] || new Set()).add(role);
	};
	const skillLineOf = {}; // profession name -> skillLine
	for (const [id, p] of Object.entries(fv.professions || {})) {
		skillLineOf[p.name] = Number(id);
		const trainers = new Set();
		for (const list of Object.values(p.trainers || {})) for (const t of list) trainers.add(t);
		for (const r of p.ranks || []) for (const list of Object.values(r.trainers || {})) for (const t of list) trainers.add(t);
		for (const t of trainers) {
			addRole(t, 'trainer');
			addRole(t, `trainer:${id}`);
		}
	}
	if (cl) for (const [id, name] of Object.entries(cl.skillLines)) if (name && !(name in skillLineOf)) skillLineOf[name] = Number(id);
	for (const [id, t] of Object.entries(fv.trainers || {})) {
		for (const c of t.classes || []) {
			addRole(id, 'trainer');
			addRole(id, `class:${c}`);
		}
	}

	// RareScanner rares (rows outside Forever's zones dropped).
	const rareLoot = {}; // npc -> Set(items)
	if (rs) {
		const rows = new Map();
		for (const r of rs.rares || []) {
			if (!r.npc || !zonesIn[r.map]) continue;
			if (!rows.has(r.npc)) rows.set(r.npc, []);
			rows.get(r.npc).push(r);
		}
		for (const [npc, list] of [...rows.entries()].sort((a, b) => a[0] - b[0])) {
			let rec = npcs[npc];
			const name = rec ? rec.name : list.find((r) => r.name)?.name;
			if (!name) continue;
			if (!rec) {
				rec = npcs[npc] = { id: npc, name, level: null, levelMax: null, faction: null, rare: true, elite: false, boss: false, instance: null, roles: [], spawns: [] };
				npcRoles[npc] = new Set();
			}
			rec.rare = true;
			if (!rec.spawns.length) {
				const byMap = {};
				for (const r of list) {
					const pts = (r.points && r.points.length ? r.points : r.x != null ? [[r.x, r.y]] : []).slice();
					(byMap[r.map] = byMap[r.map] || { f: null, pts: [] }).pts.push(...pts);
				}
				rec.spawns = spawnsOf(byMap, zonesIn);
			}
			const loot = (rareLoot[npc] = rareLoot[npc] || new Set());
			for (const r of list) for (const it of r.loot || []) loot.add(it);
		}
	}

	// ----- instances. A release build: the client tables, npcs.json and
	// items.json (tools/lib/codex/instances.js). A --local-extras build:
	// AtlasLoot dungeons and raids, entrances and Forever bosses from dungeons.json.
	const instances = {};
	const bossInstance = {}; // npc -> key
	const npcInstance = {}; // npc -> key: bosses and the NPCs placed inside (drop sources' `instance`)
	const dungeonsByName = {};
	for (const d of (fv.dungeons && fv.dungeons.dungeons) || []) dungeonsByName[normName(d.name)] = d;
	const usedDungeons = new Set();
	const dungeonKey = {}; // dungeons.json key -> instance key
	const atlasKey = {}; // AtlasLoot instance key -> instance key
	// AtlasLoot names are sometimes key-derived ("Ragefire" for Ragefire Chasm):
	// exact normalised name first, then a unique prefix match either way.
	const dungeonList = Object.entries(dungeonsByName);
	const matchDungeon = (inst) => {
		for (const n of [normName(inst.name || ''), normName(inst.key || '')]) {
			if (n && dungeonsByName[n]) return dungeonsByName[n];
		}
		const n = normName(inst.name || inst.key || '');
		if (n.length < 6) return null;
		const hits = dungeonList.filter(([dn]) => dn.startsWith(n) || n.startsWith(dn));
		return hits.length === 1 ? hits[0][1] : null;
	};
	for (const inst of (al && al.instances) || []) {
		if (inst.kind !== 'dungeon' && inst.kind !== 'raid') continue;
		const d = matchDungeon(inst);
		// The DungeonJournal key when it covers the instance (what Dungeons and Journal use).
		const key = d ? slug(d.key) : slug(inst.name || inst.key);
		if (!key || instances[key]) continue;
		atlasKey[inst.key || inst.name] = key;
		if (d) {
			usedDungeons.add(d.key);
			dungeonKey[d.key] = key;
		}
		const entrance = d && d.entrance ? { map: d.entrance.map, x: round1(d.entrance.x), y: round1(d.entrance.y), f: d.entrance.f === 'e' ? 'e' : null } : null;
		const bosses = [];
		for (const b of inst.bosses || []) {
			const npc = Array.isArray(b.npc) ? b.npc[0] ?? null : (b.npc ?? null);
			bosses.push({ name: b.name, npc, items: [...new Set((b.items || []).map((i) => i.item).filter(Boolean))] });
			for (const n of Array.isArray(b.npc) ? b.npc : b.npc ? [b.npc] : []) bossInstance[n] = bossInstance[n] || key;
		}
		// DungeonJournal bosses AtlasLoot lacks (Forever's own encounters).
		for (const b of (d && d.bosses) || []) {
			if (!b.npc || bosses.some((x) => x.npc === b.npc)) continue;
			bosses.push({ name: b.name, npc: b.npc, items: (b.loot || []).map((l) => l.item).filter(Boolean) });
			bossInstance[b.npc] = bossInstance[b.npc] || key;
		}
		instances[key] = {
			key,
			name: (d && d.name) || inst.name,
			kind: inst.kind,
			forever: !!inst.forever,
			areaId: inst.areaId ?? null,
			map: null,
			entrance,
			levels: inst.levels || (d && d.levels ? [d.levels.min, d.levels.min, d.levels.max] : null),
			bosses,
		};
	}
	for (const d of (fv.dungeons && fv.dungeons.dungeons) || []) {
		if (usedDungeons.has(d.key)) continue;
		const key = slug(d.key || d.name);
		if (instances[key]) continue;
		dungeonKey[d.key] = key;
		instances[key] = {
			key,
			name: d.name,
			kind: 'dungeon',
			forever: true,
			areaId: null,
			map: null,
			entrance: d.entrance ? { map: d.entrance.map, x: round1(d.entrance.x), y: round1(d.entrance.y), f: d.entrance.f === 'e' ? 'e' : null } : null,
			levels: d.levels ? [d.levels.min, d.levels.min, d.levels.max] : null,
			bosses: (d.bosses || []).map((b) => ({ name: b.name, npc: b.npc ?? null, items: (b.loot || []).map((l) => l.item).filter(Boolean) })),
		};
		for (const b of d.bosses || []) if (b.npc) bossInstance[b.npc] = bossInstance[b.npc] || key;
	}
	if (!al && !fv.dungeons && cl && cl.instances) {
		const built = buildInstances(cl.instances, {
			npcs: fv.npcs,
			items: fv.items,
			objects: fv.objects,
			zones: zonesIn,
			frames: (fv.mapFrames && fv.mapFrames.forever) || {},
			recorded: fv.instances || {},
			entranceTable: inputs.entranceTable || {},
			curated: inputs.entrances || [],
			quality: (id) => (cl.items[id] ? cl.items[id].quality : null),
			wowhead: wh,
		});
		Object.assign(instances, built.instances);
		Object.assign(bossInstance, built.bossInstance);
		Object.assign(npcInstance, built.npcInstance);
	}
	for (const [npc, key] of Object.entries(bossInstance)) if (!npcInstance[npc]) npcInstance[npc] = key;
	for (const [npc, key] of Object.entries(npcInstance)) if (npcs[npc] && !bossInstance[npc]) npcs[npc].instance = key;
	for (const [npc, key] of Object.entries(bossInstance)) {
		if (!npcs[npc]) {
			const boss = instances[key].bosses.find((b) => b.npc === Number(npc));
			if (!boss || !boss.name) continue;
			npcs[npc] = { id: Number(npc), name: boss.name, level: null, levelMax: null, faction: null, rare: false, elite: true, boss: true, instance: key, roles: [], spawns: [] };
			npcRoles[npc] = new Set();
		}
		npcs[npc].boss = true;
		npcs[npc].elite = true;
		npcs[npc].instance = key;
	}
	// A rare is met in the open world (Rares detects none inside an instance):
	// an instance's boss or mob that the data ranks rare elite (Edwin VanCleef)
	// is not one, unless RareScanner lists it.
	for (const [npc, key] of Object.entries(npcInstance)) {
		if (npcs[npc] && npcs[npc].rare && key && !rareLoot[npc] && !npcs[npc].spawns.length) {
			npcs[npc].rare = false;
			if (npcRoles[npc]) npcRoles[npc].delete('rare');
		}
	}
	for (const [id, set] of Object.entries(npcRoles)) if (npcs[id]) npcs[id].roles = [...set].sort();

	// ----- items
	const cands = {}; // item -> [source]
	const add = (item, src) => {
		item = Number(item);
		if (!item) return;
		(cands[item] = cands[item] || []).push(src);
	};
	const names = {};
	for (const [id, it] of Object.entries(fv.items || {})) {
		names[id] = it.name;
		const from = fromLabels(it.source);
		for (const [npc, chance] of Object.entries((it.drops && it.drops.npc) || {})) {
			if (npcs[npc]) add(id, { type: 'drop', npc: Number(npc), chance: Number(chance) || null, instance: npcInstance[npc] || null, from });
		}
		for (const [obj, chance] of Object.entries((it.drops && it.drops.object) || {})) add(id, { type: 'object', object: Number(obj), chance: Number(chance) || null, from });
		// Vendors nobody can find (no spawns, e.g. Forever's GM "World Mount Vendor") are left out.
		for (const npc of it.vendors || []) {
			if (npcs[npc] && npcs[npc].spawns.length) add(id, { type: 'vendor', npc: Number(npc), cost: (cl && cl.items[id] && cl.items[id].buyPrice) || null, from });
		}
		for (const c of it.containers || []) add(id, { type: 'container', item: Number(c), from });
	}
	if (wh) {
		for (const [npc, w] of Object.entries(wh.npc)) {
			if (!npcs[npc]) continue;
			for (const d of w.drops) add(d.item, { type: 'drop', npc: Number(npc), chance: chanceOf(d), instance: npcInstance[npc] || null, from: ['wowhead'] });
		}
		for (const [obj, w] of Object.entries(wh.object)) for (const d of w.drops) add(d.item, { type: 'object', object: Number(obj), chance: chanceOf(d), from: ['wowhead'] });
	}
	// Professions: craft sources, recipe items.
	const recipeSpell = {}; // recipe item -> craft spell
	for (const [line, p] of Object.entries(fv.professions || {})) {
		for (const r of p.recipes || []) {
			if (r.item) add(r.item, { type: 'craft', spell: r.spell, skillLine: Number(line), profession: p.name, skill: r.learnedAt ?? null, from: ['forever'] });
			if (r.recipeItem) recipeSpell[r.recipeItem] = r.spell;
		}
	}
	if (al) {
		const rates = al.droprates || {};
		for (const inst of al.instances || []) {
			const key = inst.kind === 'dungeon' || inst.kind === 'raid' ? atlasKey[inst.key || inst.name] || null : null;
			for (const b of inst.bosses || []) {
				const npc = Array.isArray(b.npc) ? b.npc[0] : b.npc;
				for (const i of b.items || []) {
					if (!i.item) continue;
					if (npc) add(i.item, { type: 'drop', npc, chance: i.chance ?? (rates[npc] && rates[npc][i.item]) ?? null, instance: key, from: ['atlasloot'] });
					for (const obj of b.object || []) add(i.item, { type: 'object', object: obj, chance: i.chance ?? null, from: ['atlasloot'] });
				}
			}
		}
		for (const c of al.crafting || []) {
			if (!c.item || !c.spell) continue;
			const line = skillLineOf[c.profession] ?? null;
			if (line !== null) add(c.item, { type: 'craft', spell: c.spell, skillLine: line, profession: c.profession, skill: c.skill ?? null, from: ['atlasloot'] });
		}
		for (const f of al.factions || []) {
			if (!f.factionId) continue;
			for (const r of f.rewards || []) add(r.item, { type: 'rep', faction: f.factionId, standing: r.standing ?? null, from: ['atlasloot'] });
		}
		for (const p of al.pvp || []) add(p.item, { type: 'pvp', rank: p.rank ?? null, from: ['atlasloot'] });
	}
	for (const [npc, loot] of Object.entries(rareLoot)) {
		for (const it of loot) add(it, { type: 'drop', npc: Number(npc), from: ['rarescanner'] });
	}
	// Quest rewards (recordings, ForeverLevelingBiS quests, dungeons.json quests).
	const questRewards = {}; // quest -> { rewards: Set, choices: Set }
	const reward = (quest, item, choice) => {
		const q = (questRewards[quest] = questRewards[quest] || { rewards: new Set(), choices: new Set() });
		(choice ? q.choices : q.rewards).add(Number(item));
	};
	// Recorded quest rewards (quests.json `rewards`, Recorder `turnin` / `accept`).
	for (const [qid, q] of Object.entries(fv.quests || {})) {
		const r = q.rewards;
		if (!r) continue;
		const from = fromLabels(q.source);
		for (const it of r.items || []) {
			reward(qid, it, false);
			add(it, { type: 'quest', quest: Number(qid), from });
		}
		for (const it of r.choices || []) {
			reward(qid, it, true);
			add(it, { type: 'quest', quest: Number(qid), choice: true, from });
		}
	}
	// The cited gate table's quest rows: the quest hands the item out
	// (QuestieDB lists no rewards for Rin'wosho the Trader's barters).
	const repTable = inputs.repTable || {};
	for (const rows of Object.values(repTable)) {
		for (const g of rows) {
			if (!g.quest) continue;
			if (!(fv.quests || {})[g.quest]) {
				warnings.push(`repgates.json: ${g.item} ${g.name || ''}: quest ${g.quest} is not in the Codex`);
				continue;
			}
			reward(g.quest, g.item, !!g.choice);
			add(g.item, { type: 'quest', quest: g.quest, choice: g.choice ? true : null, from: ['curated'] });
		}
	}
	const flbQuests = (flb && flb.quests) || {};
	for (const [qid, q] of Object.entries(flbQuests)) {
		for (const it of (q.rewards && q.rewards.items) || []) {
			reward(qid, it, false);
			add(it, { type: 'quest', quest: Number(qid), from: ['flbis'] });
		}
		for (const it of (q.rewards && q.rewards.choices) || []) {
			reward(qid, it, true);
			add(it, { type: 'quest', quest: Number(qid), choice: true, from: ['flbis'] });
		}
	}
	const dungeonQuests = {};
	const dungeonItems = {}; // item -> { name, quality } (Forever dungeon loot the other tables may lack)
	const itemRef = (x) => {
		if (x && typeof x === 'object') {
			if (x.item && x.name && !dungeonItems[x.item]) dungeonItems[x.item] = { name: x.name, quality: x.quality ?? null };
			return x.item;
		}
		return x;
	};
	for (const d of (fv.dungeons && fv.dungeons.dungeons) || []) {
		const key = dungeonKey[d.key] || null;
		for (const b of d.bosses || []) {
			for (const l of b.loot || []) {
				const item = itemRef(l);
				if (item && b.npc) add(item, { type: 'drop', npc: b.npc, instance: key, from: ['dungeons'] });
			}
		}
		for (const q of d.quests || []) {
			dungeonQuests[q.id] = q;
			for (const x of (q.rewards && q.rewards.items) || []) {
				const it = itemRef(x);
				reward(q.id, it, false);
				add(it, { type: 'quest', quest: q.id, from: ['dungeons'] });
			}
			for (const x of (q.rewards && q.rewards.choices) || []) {
				const it = itemRef(x);
				reward(q.id, it, true);
				add(it, { type: 'quest', quest: q.id, choice: true, from: ['dungeons'] });
			}
		}
	}
	for (const [id, x] of Object.entries(dungeonItems)) if (!names[id]) names[id] = x.name;
	// Wowhead Forever's quest lists (quests.json `wowhead`, data build), last:
	// the reward items no recording, ForeverLevelingBiS or dungeons.json row
	// names, each as Wowhead files it (one of `choices`, or every one of
	// `items`). Its lists carry most dungeon quests' rewards these lack.
	for (const [qid, q] of Object.entries(fv.quests || {})) {
		const w = q.wowhead;
		if (!w) continue;
		const have = questRewards[qid];
		const known = (it) => have && (have.rewards.has(it) || have.choices.has(it));
		for (const [list, choice] of [
			[w.choices || [], true],
			[w.items || [], false],
		]) {
			for (const [it] of list) {
				if (known(it)) continue;
				reward(qid, it, choice);
				add(it, { type: 'quest', quest: Number(qid), choice: choice || null, from: ['wowhead'] });
			}
		}
	}
	if (flb) {
		for (const [id, it] of Object.entries(flb.items || {})) {
			if (it.name && !names[id]) names[id] = it.name;
			for (const s of it.sources || []) {
				if (s.type === 'quest' && s.id) {
					const choice = !!(flbQuests[s.id] && flbQuests[s.id].rewards && (flbQuests[s.id].rewards.choices || []).includes(Number(id)));
					add(id, { type: 'quest', quest: s.id, choice: choice || null, from: ['flbis'] });
				} else if (s.type === 'drop' && s.npcId) {
					add(id, { type: 'drop', npc: s.npcId, chance: s.pct || null, instance: npcInstance[s.npcId] || null, from: ['flbis'] });
				} else if (s.type === 'crafted' && s.spellId) {
					const line = skillLineOf[s.profession] ?? null;
					if (line !== null) add(id, { type: 'craft', spell: s.spellId, skillLine: line, profession: s.profession, skill: s.skill ?? null, from: ['flbis'] });
				}
			}
		}
	}
	if (al) for (const c of al.collections || []) if (c.item && !names[c.item] && cl && cl.items[c.item]) names[c.item] = cl.items[c.item].name;

	// Collectible classification.
	const mountItems = new Set();
	const petItems = new Set();
	const tabardItems = new Set();
	for (const c of (al && al.collections) || []) {
		if (c.group === 'Mounts') mountItems.add(Number(c.item));
		else if (c.group === 'Companions') petItems.add(Number(c.item));
		else if (c.group === 'Tabards') tabardItems.add(Number(c.item));
	}
	for (const list of Object.values((rs && rs.mounts) || {})) for (const it of list) mountItems.add(Number(it));
	for (const list of Object.values((rs && rs.pets) || {})) for (const it of list) petItems.add(Number(it));
	if (cl) {
		const mountSpells = cl.mountSpells || new Set();
		const petSpells = cl.petSpells || new Set();
		for (const [id, it] of Object.entries(cl.items)) {
			const learn = it.learn;
			// The item's spell, or the spell it teaches (Orange Murloc Egg's use spell teaches the summon).
			const spells = [learn, it.use].filter(Boolean).flatMap((x) => [x, (cl.teaches || {})[x]]).filter(Boolean);
			const spell = spells.find((x) => mountSpells.has(x) || petSpells.has(x)) || learn || it.use;
			if ((it.classId === 15 && it.subclassId === 5) || (learn && cl.mountAura.has(learn)) || (spell && mountSpells.has(spell))) {
				mountItems.add(Number(id));
				if (!names[id] && !it.era) names[id] = it.name;
			} else if ((it.classId === 15 && it.subclassId === 2 && learn) || (spell && petSpells.has(spell))) {
				petItems.add(Number(id));
				if (!names[id] && !it.era) names[id] = it.name;
			}
		}
	}

	// Mounts and pets that are no longer obtainable. The Era databases
	// (pfQuest, and Questie where it inherits them) still list vendor stock
	// that was retired or replaced (the pre-1.4 epic mounts the exchange quests
	// traded in). A mount or pet whose every source is such an Era vendor row
	// is retired when, in a release build, the Forever client's Mount row for
	// its summon spell is flagged hidden until known (Mount.Flags 0x40: the
	// client keeps it only for those who already have it; Black Stallion,
	// still sold, is not flagged), or, in a --local-extras build, when
	// AtlasLoot's collection lists do not name it. Polestar's own curated
	// guides (`collects`) name collectibles the game hands out: never retired.
	// Forever-only rows (Questie without pfQuest) are trusted. Companions have
	// no such client flag, so a release build retires none.
	const listed = new Set([...((al && al.collections) || []).map((c) => Number(c.item)), ...(inputs.curated || []).map(Number)]);
	// { item: [{ npc, faction|factionName, standing }] } (curatedRepGates).
	const curatedGates = inputs.curatedGates || {};
	const hiddenMount = (spell) => !!(cl && cl.mountHidden && spell && cl.mountHidden.has(spell));
	const statusOf = (id, kind, sources, spell) => {
		if (!sources.length) return 'nosource';
		if (kind !== 'mount' && kind !== 'pet') return null;
		if (listed.has(id)) return null;
		if (!al && !(kind === 'mount' && hiddenMount(spell))) return null;
		const eraVendor = (s) => s.type === 'vendor' && (s.from || []).includes('pfquest');
		return sources.every(eraVendor) ? 'retired' : null;
	};

	const npcLevel = (id) => {
		const n = npcs[id];
		if (!n || !n.level) return null;
		return [n.level, n.levelMax || n.level];
	};
	const items = {};
	const factionByName = {};
	for (const f of Object.values(factions)) factionByName[normName(f.name)] = f.id;
	// noPvp: items Wowhead's Forever tooltip shows without a PvP rank. cut:
	// what a cap left out (parity's reason, not shipped): drop { item: [npc] },
	// rare { npc: [item] }, treasure { object: [item] }.
	const evidence = { noPvp: [], cut: { drop: {}, rare: {}, treasure: {} } };
	const allIds = new Set([...Object.keys(names), ...Object.keys(cands)].map(Number));
	for (const id of [...allIds].sort(byId)) {
		const c = cl && cl.items[id];
		const name = names[id] || (c && c.name);
		if (!name) continue;
		const list = (cands[id] || []).slice();
		if (c && c.minFaction) {
			const vendor = list.find((s) => s.type === 'vendor');
			list.push({ type: 'rep', faction: c.minFaction, standing: c.minStanding, npc: vendor ? vendor.npc : null, from: ['client'] });
		}
		// Wowhead Forever's tooltip: the reputation and PvP rank the item asks for.
		const tip = wh && wh.item[id];
		if (tip) {
			const vendor = list.find((s) => s.type === 'vendor');
			for (const r of tip.rep || []) {
				const faction = factionByName[normName(r.faction)];
				if (faction) list.push({ type: 'rep', faction, standing: r.standing, npc: vendor ? vendor.npc : null, from: ['wowhead'] });
			}
			if (tip.pvpRank) list.push({ type: 'pvp', rank: tip.pvpRank, npc: vendor ? vendor.npc : null, from: ['wowhead'] });
			if (!tip.pvpRank) evidence.noPvp.push(id);
		}
		// A curated guide that collects the item reaches a standing before it
		// buys the item from a vendor: that vendor's gate (13086 Winterspring
		// Frostsaber: Exalted, server-side, on no tooltip).
		for (const g of curatedGates[id] || []) {
			const faction = g.faction || factionByName[normName(g.factionName)];
			if (faction) list.push({ type: 'rep', faction, standing: g.standing, npc: g.npc, from: ['guides'] });
		}
		// An NPC that casts a spell creating the item (the client's SpellEffect;
		// who casts it, Wowhead Forever's spell page) hands it out.
		for (const spell of (cl && cl.creates && cl.creates[id]) || []) {
			for (const npc of (wh && wh.spell && wh.spell[spell] && wh.spell[spell].usedBy) || []) {
				if (npcs[npc]) list.push({ type: 'gift', npc, spell, from: ['wowhead'] });
			}
		}
		// The cited gate table (repgates.json): the standing its vendor or
		// giver asks (the Alterac Valley and Warsong Gulch supply officers,
		// the Argent Dawn quartermasters). A row naming an npc that neither
		// sells nor hands out the item is stale: a warning, never a gate.
		for (const g of repTable[id] || []) {
			if (g.name && g.name !== name) warnings.push(`repgates.json: ${id} is "${name}" in the Codex, not "${g.name}"`);
			for (const npc of g.npcs || []) {
				if (list.some((s) => (s.type === 'vendor' || s.type === 'gift') && s.npc === npc)) list.push({ type: 'rep', faction: g.faction, standing: g.standing, npc, from: ['curated'] });
				else warnings.push(`repgates.json: ${id} ${name}: npc ${npc} neither sells nor gives it in the Codex`);
			}
		}
		if (c && c.pvpRank) {
			const vendor = list.find((s) => s.type === 'vendor');
			list.push({ type: 'pvp', rank: c.pvpRank, npc: vendor ? vendor.npc : null, from: ['client'] });
		}
		for (const s of list) {
			if (s.type === 'rep' && s.npc == null) {
				const vendor = list.find((v) => v.type === 'vendor');
				if (vendor) s.npc = vendor.npc;
			}
		}
		// A quest's reputation gate (questRep, QuestieDB's): its rewards need
		// that standing. It names no vendor (added after the fill above), so it
		// never gates a purchase; the quest record carries it too.
		for (const s of list.filter((x) => x.type === 'quest')) {
			const g = questRep((fv.quests || {})[s.quest]);
			if (g) list.push({ type: 'rep', faction: g.faction, standing: g.standing, npc: null, from: ['questie'] });
		}
		for (const g of repTable[id] || []) {
			if (g.quest && list.some((s) => s.type === 'quest' && s.quest === g.quest)) list.push({ type: 'rep', faction: g.faction, standing: g.standing, npc: null, from: ['curated'] });
		}
		const sources = finalizeSources(
			list,
			npcLevel,
			(npc) => !!bossInstance[npc],
			(s) => s.type === 'drop' && (evidence.cut.drop[id] = evidence.cut.drop[id] || []).push(s.npc),
		);
		if (!sources.length && JUNK.test(name)) continue;
		let kind = 'item';
		if (mountItems.has(id)) kind = 'mount';
		else if (petItems.has(id)) kind = 'pet';
		else if ((c && c.classId === 9) || recipeSpell[id]) kind = 'recipe';
		else if (tabardItems.has(id) || (c && c.inventoryType === 19)) kind = 'tabard';
		let spell = null;
		if (kind === 'mount' || kind === 'pet') spell = (c && (c.learn || c.use)) || null;
		else if (kind === 'recipe') spell = recipeSpell[id] || (c && c.learn) || null;
		// Purchase requirements: reputation (standing 1..8, Hated..Exalted, as
		// Compat.GetFactionStanding) and profession skill, from the client tables.
		// Some reputation vendors gate items in their gossip, not in ItemSparse
		// (13086 Winterspring Frostsaber): an item sold or handed out by the npc
		// a reputation source stands at takes that source's faction and
		// standing. A quest's gate (its giver's) stays on the quest.
		let repFaction = (c && c.minFaction) || null;
		let repStanding = repFaction ? c.minStanding : null;
		const vendors = new Set(sources.filter((s) => s.type === 'vendor' || s.type === 'gift').map((s) => s.npc));
		const rep = !repFaction ? sources.find((s) => s.type === 'rep' && s.faction && s.standing && vendors.has(s.npc)) : null;
		if (rep) {
			repFaction = rep.faction;
			repStanding = rep.standing;
		}
		items[id] = {
			id,
			name,
			quality: c && c.quality != null ? c.quality : dungeonItems[id] ? dungeonItems[id].quality : null,
			kind,
			spell,
			reqLevel: c ? c.reqLevel : null,
			repFaction,
			repStanding,
			reqSkill: c ? c.reqSkill : null,
			reqSkillRank: c ? c.reqSkillRank : null,
			status: statusOf(id, kind, sources, spell),
			sources,
		};
	}
	for (const [id, rows] of Object.entries(repTable)) {
		if (!items[id]) warnings.push(`repgates.json: item ${id} ${rows[0].name || ''} is not in the Codex`);
	}

	// ----- spells (mount / pet summons, class mounts)
	const spells = {};
	if (cl) {
		for (const id of Object.keys(items).map(Number).sort(byId)) {
			const it = items[id];
			if ((it.kind === 'mount' || it.kind === 'pet') && it.spell && !spells[it.spell]) {
				spells[it.spell] = { kind: it.kind, item: id, name: cl.spellNames[it.spell] || it.name, class: cl.spellClass[it.spell] || null };
			}
		}
		for (const spell of cl.mountSkill) {
			if (spells[spell] || !cl.mountAura.has(spell)) continue;
			spells[spell] = { kind: 'mount', item: null, name: cl.spellNames[spell] || `Spell ${spell}`, class: cl.spellClass[spell] || null };
		}
		for (const spell of cl.companionSkill) {
			if (spells[spell]) continue;
			spells[spell] = { kind: 'pet', item: null, name: cl.spellNames[spell] || `Spell ${spell}`, class: null };
		}
	}

	// ----- objects: treasures, item sources, quest starts/ends/objectives
	const wantObjects = new Set();
	for (const it of Object.values(items)) for (const s of it.sources) if (s.type === 'object') wantObjects.add(s.object);
	for (const inst of Object.values(instances)) for (const b of inst.bosses || []) if (b.object) wantObjects.add(b.object);
	const questsIn = fv.quests || {};
	for (const q of Object.values(questsIn)) {
		for (const o of (q.start && q.start.object) || []) wantObjects.add(o);
		for (const o of (q.end && q.end.object) || []) wantObjects.add(o);
		for (const o of q.objectives || []) if (o.type === 'object' && o.id) wantObjects.add(o.id);
	}
	const objects = {};
	for (const [id, o] of Object.entries(fv.objects || {})) {
		const treasure = (o.roles || []).includes('chest');
		if (!treasure && !wantObjects.has(Number(id))) continue;
		if (!o.name || JUNK.test(o.name)) continue;
		objects[id] = { id: Number(id), name: o.name, treasure, spawns: spawnsOf(o.spawns, zonesIn) };
	}
	const treasureLoot = {}; // object -> Set(items) (RareScanner)
	for (const t of (rs && rs.treasures) || []) {
		if (!t.object || !zonesIn[t.map]) continue;
		let o = objects[t.object];
		if (!o) {
			const name = (fv.objects && fv.objects[t.object] && fv.objects[t.object].name) || t.name;
			if (!name) continue;
			o = objects[t.object] = { id: t.object, name, treasure: true, spawns: [] };
		}
		o.treasure = true;
		if (!o.spawns.length) o.spawns = spawnsOf({ [t.map]: { f: null, pts: t.points && t.points.length ? t.points : [[t.x, t.y]] } }, zonesIn);
		const loot = (treasureLoot[t.object] = treasureLoot[t.object] || new Set());
		for (const it of t.loot || []) loot.add(Number(it));
	}

	// ----- quests
	const quests = {};
	const questIds = new Set([...Object.keys(questsIn), ...Object.keys(questRewards)].map(Number));
	// Blocking prerequisites only (breadcrumbs, the quest itself and exclusives dropped).
	const prereqs = (q) => {
		const { all, any } = blockingPrereqs(q, (qid) => questsIn[qid] || null);
		return { pre: [...all], preAny: [...any] };
	};
	for (const id of [...questIds].sort(byId)) {
		const q = questsIn[id];
		const r = questRewards[id];
		const rewards = r ? [...r.rewards].sort(byId) : [];
		const choices = r ? [...r.choices].sort(byId) : [];
		if (q) {
			quests[id] = {
				id,
				title: q.title,
				level: int(q.level),
				minLevel: int(q.minLevel),
				faction: factionOfRaces(q.races),
				races: int(q.races),
				classes: int(q.classes),
				start: { npc: (q.start && q.start.npc) || [], object: (q.start && q.start.object) || [], item: (q.start && q.start.item) || [] },
				end: { npc: (q.end && q.end.npc) || [], object: (q.end && q.end.object) || [] },
				objectives: (q.objectives || []).filter((o) => ['kill', 'item', 'object', 'event'].includes(o.type)).map((o) => ({ type: o.type, id: o.id ?? null, count: o.count ?? null, text: o.text ?? null })),
				...prereqs(q),
				zone: int(q.zone),
				rewards,
				choices,
			};
			// The standing its rewards need (questRep): an unmet one blocks its reward row.
			const gate = questRep(q);
			if (gate) Object.assign(quests[id], { repFaction: gate.faction, repStanding: gate.standing });
			continue;
		}
		const f = flbQuests[id];
		const d = dungeonQuests[id];
		const title = (f && f.name) || (d && d.title);
		if (!title) continue;
		quests[id] = {
			id,
			title,
			level: int((f && f.level) ?? (d && d.level)),
			minLevel: int((f && (f.minLevel ?? f.reqLevel)) ?? (d && d.minLevel)),
			faction: f ? sideOf(f.side) : d ? sideOf(d.faction) : null,
			races: null,
			classes: null,
			start: { npc: f && f.start && f.start.id ? [f.start.id] : [], object: [], item: [] },
			end: { npc: [], object: [] },
			objectives: [],
			pre: [],
			preAny: [],
			zone: null,
			rewards,
			choices,
		};
	}
	// The table's quest rows gate their quest too: the table's standing over
	// QuestieDB's (a difference is worth a look: a warning).
	for (const rows of Object.values(repTable)) {
		for (const g of rows) {
			const q = g.quest && quests[g.quest];
			if (!q) continue;
			if (q.repFaction && (q.repFaction !== g.faction || q.repStanding !== g.standing)) warnings.push(`repgates.json: quest ${g.quest} asks ${g.faction}/${g.standing} here, ${q.repFaction}/${q.repStanding} in QuestieDB`);
			Object.assign(q, { repFaction: g.faction, repStanding: g.standing });
		}
	}

	// ----- loot of rares and treasures: RareScanner loot plus every drop/object
	// candidate naming them (before the per-item caps), items known to the Codex
	// only; its own drops first (the only drop or object candidate of the item).
	const holderOf = {}; // item -> 'n<npc>' | 'o<object>' when one alone drops or holds it, else null
	for (const [item, list] of Object.entries(cands)) {
		for (const s of list) {
			if (s.type !== 'drop' && s.type !== 'object') continue;
			const h = s.type === 'drop' ? `n${s.npc}` : `o${s.object}`;
			holderOf[item] = holderOf[item] === undefined || holderOf[item] === h ? h : null;
		}
	}
	const lootOf = (rec, holder, chances, listed, cut) => {
		const ids = new Set([...(listed || []), ...chances.keys()].filter((id) => items[id]));
		const own = (id) => (holderOf[id] === holder ? 0 : 1);
		const ranked = [...ids].sort((a, b) => own(a) - own(b) || (chances.get(b) ?? -1) - (chances.get(a) ?? -1) || (items[b].quality ?? -1) - (items[a].quality ?? -1) || a - b);
		rec.loot = ranked.slice(0, LOOT_CAP);
		if (ranked.length > LOOT_CAP) cut[rec.id] = ranked.slice(LOOT_CAP);
	};
	const npcChances = {};
	const objectChances = {};
	for (const [item, list] of Object.entries(cands)) {
		for (const s of list) {
			const table = s.type === 'drop' ? npcChances : s.type === 'object' ? objectChances : null;
			if (!table) continue;
			const key = s.type === 'drop' ? s.npc : s.object;
			const m = (table[key] = table[key] || new Map());
			const best = m.get(Number(item));
			const chance = s.chance ?? null;
			if (best === undefined || (chance !== null && (best === null || chance > best))) m.set(Number(item), chance);
		}
	}
	for (const [id, n] of Object.entries(npcs)) {
		if (n.rare) lootOf(n, `n${id}`, npcChances[id] || new Map(), rareLoot[id], evidence.cut.rare);
		else n.loot = [];
	}
	for (const [id, o] of Object.entries(objects)) {
		if (o.treasure) lootOf(o, `o${id}`, objectChances[id] || new Map(), treasureLoot[id], evidence.cut.treasure);
		else o.loot = [];
	}

	// ----- NPCs nobody can meet: no spawns, no role, and nothing refers to them
	const refNpcs = new Set();
	for (const it of Object.values(items)) for (const s of it.sources) if (s.npc) refNpcs.add(Number(s.npc));
	for (const q of Object.values(quests)) {
		for (const n of q.start.npc) refNpcs.add(Number(n));
		for (const n of q.end.npc) refNpcs.add(Number(n));
		for (const o of q.objectives) if (o.type === 'kill' && o.id) refNpcs.add(Number(o.id));
	}
	for (const i of Object.values(instances)) for (const b of i.bosses) if (b.npc) refNpcs.add(Number(b.npc));
	for (const [id, n] of Object.entries(npcs)) {
		if (!n.spawns.length && !n.roles.length && !n.rare && !n.boss && !refNpcs.has(Number(id))) delete npcs[id];
	}

	// ----- frames for every Era-frame map referenced
	const frames = {};
	const era = (fv.mapFrames && fv.mapFrames.era) || {};
	const want = (m, f) => {
		if (f === 'e' && era[m]) frames[m] = era[m];
	};
	for (const n of Object.values(npcs)) for (const s of n.spawns) want(s.map, s.f);
	for (const o of Object.values(objects)) for (const s of o.spawns) want(s.map, s.f);
	for (const i of Object.values(instances)) if (i.entrance) want(i.entrance.map, i.entrance.f);

	return { items, npcs, objects, quests, instances, zones, factions, spells, frames, evidence, warnings };
}

// counts / coverage for meta.json
function summarize(codex) {
	const counts = { item: 0, mount: 0, pet: 0, recipe: 0, tabard: 0, npc: 0, rare: 0, quest: 0, zone: 0, instance: 0, treasure: 0, object: 0 };
	let withSource = 0;
	const items = Object.values(codex.items);
	for (const it of items) {
		counts[it.kind]++;
		if (it.sources.length) withSource++;
	}
	for (const n of Object.values(codex.npcs)) counts[n.rare ? 'rare' : 'npc']++;
	for (const o of Object.values(codex.objects)) counts[o.treasure ? 'treasure' : 'object']++;
	counts.quest = Object.keys(codex.quests).length;
	counts.zone = Object.keys(codex.zones).length;
	counts.instance = Object.keys(codex.instances).length;
	return { counts, coverage: { items: items.length, withSource, share: items.length ? Math.round((withSource / items.length) * 1000) / 1000 : 0 } };
}

// ---------------------------------------------------------------------------
// Pack memory (lua5.1, the real Codex.lua)
// ---------------------------------------------------------------------------

function luaString(s) {
	return '"' + String(s).replace(/\\/g, '\\\\').replace(/"/g, '\\"').replace(/\n/g, '\\n') + '"';
}

// files: absolute pack files in TOC order -> { rawKB, decodedKB }
function measureMemory(files) {
	const { findLua } = require('../lua');
	const codexLua = path.join(ROOT, 'addon', 'Polestar', 'Lookup', 'Codex.lua');
	const program = `
local ns = {}
Polestar = ns
function ns.RegisterMapFrames() end
loadfile(${luaString(codexLua)})("Polestar", ns)
local C = ns.Codex
collectgarbage("collect"); collectgarbage("collect")
local base = collectgarbage("count")
local t0 = os.clock()
for _, f in ipairs({ ${files.map(luaString).join(', ')} }) do dofile(f) end
local loadMs = (os.clock() - t0) * 1000
collectgarbage("collect"); collectgarbage("collect")
local raw = collectgarbage("count") - base
local keep = {}
local get = { item = C.Item, mount = C.Item, pet = C.Item, recipe = C.Item, tabard = C.Item, npc = C.Npc, rare = C.Npc,
	object = C.Object, treasure = C.Object, quest = C.Quest, instance = C.Instance, zone = C.Zone, faction = C.Faction, spell = C.Spell }
for kind, fn in pairs(get) do
	C.Each(kind, function(id) keep[#keep + 1] = fn(id) end)
end
collectgarbage("collect"); collectgarbage("collect")
local decoded = collectgarbage("count") - base
io.write(string.format("%.1f %.1f %d %.1f\\n", raw, decoded, #keep, loadMs))
`;
	const file = path.join(os.tmpdir(), `polestar-codex-mem-${process.pid}.lua`);
	fs.writeFileSync(file, program);
	try {
		const r = spawnSync(findLua(), [file], { encoding: 'utf8', maxBuffer: 16 * 1024 * 1024 });
		if (r.status !== 0) throw new Error(`measuring pack memory failed:\n${r.stderr}`);
		const [rawKB, decodedKB, records, loadMs] = r.stdout.trim().split(/\s+/).map(Number);
		return { rawKB, decodedKB, records, loadMs };
	} finally {
		fs.rmSync(file, { force: true });
	}
}

// ---------------------------------------------------------------------------
// I/O
// ---------------------------------------------------------------------------

function readJson(file, optional = false) {
	if (!fs.existsSync(file)) {
		if (optional) return null;
		throw new Error(`missing ${path.relative(process.cwd(), file)} (run \`node tools/polestar.js data build\` first)`);
	}
	return JSON.parse(fs.readFileSync(file, 'utf8'));
}

function packageVersion() {
	try {
		return JSON.parse(fs.readFileSync(path.join(ROOT, 'package.json'), 'utf8')).version || '0.0.0';
	} catch {
		return '0.0.0';
	}
}

function writeAtomic(file, text) {
	fs.mkdirSync(path.dirname(file), { recursive: true });
	fs.writeFileSync(`${file}.tmp`, text);
	fs.renameSync(`${file}.tmp`, file);
}

// Replaces the pack folder as a whole: written beside it, then swapped in.
function writePackDir(dir, files) {
	const tmp = `${dir}.tmp-${process.pid}`;
	fs.rmSync(tmp, { recursive: true, force: true });
	fs.mkdirSync(tmp, { recursive: true });
	for (const [rel, text] of Object.entries(files)) fs.writeFileSync(path.join(tmp, rel), text);
	const old = `${dir}.old-${process.pid}`;
	if (fs.existsSync(dir)) fs.renameSync(dir, old);
	fs.renameSync(tmp, dir);
	fs.rmSync(old, { recursive: true, force: true });
}

// The Forever client build to read (tools/lib/data/wago.js, as `data build`
// --forever-build): `build` when given, else the newest 1.60+ build wago.tools
// lists, else (offline or unreachable) the newest cached one holding every
// table the Codex reads. -> { build, warnings }
function pickForeverBuild({ sourcesDir, build, offline = false, fetchImpl } = {}) {
	return require('../data/wago').pickBuild({ sourcesDir: sourcesDir || SOURCES, build, offline, fetchImpl, product: 'forever', tables: TABLES });
}

// localExtras: also merge the installed AtlasLoot (GPL-2.0), RareScanner (All
// Rights Reserved) and data/forever/dungeons.json (DungeonJournal, no
// licence). Such a build is for this machine only: its meta says `local`
// and `pack` refuses to ship it. Without it every input is release-safe
// (docs/ARCHITECTURE.md, "Codex (`codex build`)").
async function loadInputs({ addons, offline = false, dataDir, sourcesDir, build, fetchImpl, localExtras = false, guidesDir, log = () => {} } = {}) {
	dataDir = dataDir || DATA;
	sourcesDir = sourcesDir || SOURCES;
	guidesDir = guidesDir || path.join(ROOT, 'guides');
	const j = (f, opt) => readJson(path.join(dataDir, f), opt);
	const forever = {
		items: j('items.json'),
		npcs: j('npcs.json'),
		objects: j('objects.json'),
		quests: j('quests.json'),
		zones: j('zones.json'),
		factions: j('factions.json'),
		professions: j('professions.json', true) || {},
		trainers: j('trainers.json', true) || {},
		mapFrames: j('map-frames.json', true) || {},
		meta: j('meta.json', true) || {},
		// Recorder `enter` / `encounter` facts (tools/lib/data/recordings.js), when built.
		instances: j('instances.json', true) || {},
		dungeons: localExtras ? j('dungeons.json', true) : null,
	};
	// Wowhead Forever per-entity facts already cached in
	// data/sources/wowhead/codex/ (nothing is fetched), release builds only.
	const wowhead = localExtras ? null : loadWowhead(sourcesDir);
	const warnings = [];
	const { resolveAddonsDir } = require('../addons');
	const dir = resolveAddonsDir(addons);
	let atlasloot = null;
	let rarescanner = null;
	let flbis = null;
	if (!dir) warnings.push(`no Forever AddOns folder found (pass --addons): ForeverLevelingBiS${localExtras ? ', AtlasLoot and RareScanner' : ''} skipped`);
	else {
		log(`reading addons in ${dir}`);
		const { readForeverLevelingBiS } = require('../consume/foreverlevelingbis');
		if (localExtras) {
			const { readAtlasLoot } = require('../consume/atlasloot');
			const { readRareScanner } = require('../consume/rarescanner');
			atlasloot = readAtlasLoot(dir);
			rarescanner = readRareScanner(dir);
			for (const w of [...((atlasloot.meta && atlasloot.meta.warnings) || []), ...((rarescanner.meta && rarescanner.meta.warnings) || [])]) warnings.push(w);
		}
		try {
			flbis = readForeverLevelingBiS({ addons: dir });
		} catch (err) {
			warnings.push(err.message);
		}
	}
	const { loadTables } = require('../professions/tables');
	const picked = await pickForeverBuild({ sourcesDir, build, offline, fetchImpl });
	warnings.push(...picked.warnings);
	log(`Forever client build ${picked.build}${build ? ' (--build)' : ''}`);
	const loaded = await loadTables({ sourcesDir, build: picked.build, offline, fetchImpl, log, tables: TABLES });
	warnings.push(...loaded.warnings);
	const client = clientFacts(loaded.tables, loaded.build);
	client.instanceMaps = require('./journal').instanceMapsOf(loaded.tables.Map || [], loaded.tables.AreaTable || []);
	let eraMaps = null;
	try {
		const era = await loadTables({ sourcesDir, build: ERA_BUILD, offline, fetchImpl, log, tables: ERA_TABLES });
		const eraItems = clientFacts(era.tables, era.build).items;
		eraMaps = era.tables.Map || null;
		let filled = 0;
		for (const [id, it] of Object.entries(eraItems)) {
			if (client.items[id]) continue;
			client.items[id] = { ...it, era: true };
			filled++;
		}
		client.eraBuild = era.build;
		log(`${filled} items only in the Era client tables (${era.build})`);
	} catch (err) {
		warnings.push(`Era client tables ${ERA_BUILD}: ${err.message}`);
	}
	client.instances = instanceFacts(loaded.tables, eraMaps);
	return { forever, atlasloot, rarescanner, flbis, client, wowhead, curated: curatedCollects(guidesDir), curatedGates: curatedRepGates(guidesDir), entrances: curatedEntrances(guidesDir), entranceTable: loadEntranceTable(), repTable: loadRepGateTable(), localExtras: !!localExtras, warnings };
}

// Every .guide file under dir -> [{ file, text }], by path.
function guideTexts(dir) {
	const out = [];
	const walk = (d) => {
		if (!fs.existsSync(d)) return;
		for (const e of fs.readdirSync(d, { withFileTypes: true }).sort((a, b) => (a.name < b.name ? -1 : 1))) {
			const p = path.join(d, e.name);
			if (e.isDirectory()) walk(p);
			else if (e.name.endsWith('.guide')) out.push({ file: p, text: fs.readFileSync(p, 'utf8') });
		}
	};
	walk(dir);
	return out;
}

function collectsOf(text) {
	const m = text.match(/^collects\s+(.+)$/m);
	return m ? m[1].split(/[\s,]+/).filter((id) => /^\d+$/.test(id)).map(Number) : [];
}

// Item ids that Polestar's own guides obtain (`collects` headers under guides/).
function curatedCollects(dir = path.join(ROOT, 'guides')) {
	const out = new Set();
	for (const { text } of guideTexts(dir)) for (const id of collectsOf(text)) out.add(id);
	return [...out].sort(byId);
}

// The vendor gates Polestar's own guides state: in a guide that collects an
// item, the last `rep <faction> <Standing>` goal before `buy <item> npc <id>`
// -> { item: [{ npc, faction|null, factionName|null, standing }] }.
const GUIDE_STANDINGS = { hated: 1, hostile: 2, unfriendly: 3, neutral: 4, friendly: 5, honored: 6, revered: 7, exalted: 8 };
function curatedRepGates(dir = path.join(ROOT, 'guides')) {
	const out = {};
	for (const { text } of guideTexts(dir)) {
		const collects = new Set(collectsOf(text));
		if (!collects.size) continue;
		let rep = null;
		for (const line of text.split(/\r?\n/)) {
			const goal = line.replace(/\s--.*$/, '').trim();
			const r = /^rep\s+(?:(\d+)\s+)?(?:"([^"]+)"\s+)?([A-Za-z]+)$/.exec(goal);
			if (r && GUIDE_STANDINGS[r[3].toLowerCase()] && (r[1] || r[2])) {
				rep = { faction: r[1] ? Number(r[1]) : null, factionName: r[2] || null, standing: GUIDE_STANDINGS[r[3].toLowerCase()] };
				continue;
			}
			const b = /^buy\s+(\d+)\b.*\bnpc\s+(\d+)/.exec(goal);
			if (b && rep && collects.has(Number(b[1]))) (out[b[1]] = out[b[1]] || []).push({ npc: Number(b[2]), ...rep });
		}
	}
	return out;
}

// The cited reputation gate table (tools/lib/codex/repgates.json): rows
// { item, name, faction, standing (1..8), npcs: [vendor or giver] | quest
// (+ choice), source (URL), note? } -> { item: [row] }. A malformed row throws.
function loadRepGateTable(file = path.join(__dirname, 'repgates.json')) {
	if (!fs.existsSync(file)) return {};
	const out = {};
	for (const g of JSON.parse(fs.readFileSync(file, 'utf8')).gates || []) {
		const where = Array.isArray(g.npcs) && g.npcs.length && g.npcs.every(Number.isInteger) ? !g.quest : Number.isInteger(g.quest) && !g.npcs;
		if (!Number.isInteger(g.item) || !Number.isInteger(g.faction) || !(g.standing >= 1 && g.standing <= 8) || !where || !/^https:\/\//.test(g.source || '')) {
			throw new Error(`${path.basename(file)}: bad row ${JSON.stringify(g)}`);
		}
		(out[g.item] = out[g.item] || []).push(g);
	}
	return out;
}

function sourcesMeta(inputs) {
	const out = [];
	const fm = inputs.forever.meta || {};
	for (const s of fm.sources || []) out.push({ name: s.name, version: s.revision || s.version || null, licence: s.license || s.licence || null });
	const imp = [
		[inputs.atlasloot, 'AtlasLootClassic', 'GPL-2.0'],
		[inputs.rarescanner, 'RareScanner', 'All Rights Reserved'],
		[inputs.flbis, 'ForeverLevelingBiS', 'MIT'],
	];
	for (const [x, name, licence] of imp) if (x) out.push({ name, version: (x.meta && x.meta.version) || null, licence: (x.meta && x.meta.licence) || licence });
	const d = inputs.forever.dungeons;
	if (d && d.source) out.push({ name: `dungeons.json (${d.source.name || 'DungeonJournal'})`, version: d.source.version || null, licence: 'All Rights Reserved' });
	const wh = inputs.wowhead;
	if (wh) {
		const n = Object.keys(wh.npc).length + Object.keys(wh.object).length + Object.keys(wh.item).length;
		const listed = wh.listed && wh.listed.npc ? Object.keys(wh.listed.npc).length : 0;
		if (n || listed) out.push({ name: `Wowhead Forever database (wowhead.com/forever): NPC and object pages, item tooltips${listed ? ', NPC list levels' : ''}`, version: `${n} entities${listed ? `, ${listed} listed NPCs` : ''}; cache data/sources/wowhead/codex`, licence: 'Public web pages; facts only (levels, classification, positions, drop counts, requirements)' });
	}
	const ne = Object.keys(inputs.entranceTable || {}).length;
	if (ne && !inputs.atlasloot) out.push({ name: 'Curated instance entrances (tools/lib/codex/entrances.json): QuestieDB Forever dungeon table, warcraft.wiki.gg, Wowhead Forever', version: `${ne} entrances`, licence: 'Facts only (coordinates), each entry with its source' });
	const nr = Object.keys(inputs.repTable || {}).length;
	if (nr) out.push({ name: 'Curated reputation gates (tools/lib/codex/repgates.json): warcraft.wiki.gg, Wowhead Classic reputation guides, QuestieDB', version: `${nr} items`, licence: 'Facts only (standings), each row with its source' });
	const na = (inputs.attunementTable || require('./attunements').loadAttunementTable()).attunements.length;
	if (na) out.push({ name: 'Curated attunement goals (tools/lib/codex/attunements.json): Wowhead Forever, warcraft.wiki.gg', version: `${na} attunements`, licence: 'Facts only (quest and item ids), each entry with its sources' });
	const nj = (inputs.journalQuests || require('./journal').loadJournalQuests()).length;
	if (nj) out.push({ name: 'Curated Dungeons journal quests (tools/lib/codex/journal-quests.json): Wowhead Forever', version: `${nj} quests`, licence: 'Facts only (quest ids and instances), each row with its source' });
	if (inputs.client) out.push({ name: 'World of Warcraft: Forever client tables via wago.tools', version: inputs.client.build, licence: 'Blizzard Entertainment game data, facts only' });
	if (inputs.client && inputs.client.eraBuild) out.push({ name: 'World of Warcraft Classic Era client item tables via wago.tools (items missing from the Forever tables)', version: inputs.client.eraBuild, licence: 'Blizzard Entertainment game data, facts only' });
	return out;
}

// -> { codex, files, outDir, packDir, bytes, memory, warnings, ms }
async function buildCodex(opts = {}) {
	const t0 = Date.now();
	const log = opts.log || (() => {});
	const outDir = opts.outDir || path.join(ROOT, 'data', 'forever', 'codex');
	const packDir = opts.packDir || path.join(ROOT, 'addon', ADDON);
	const inputs = opts.inputs || (await loadInputs(opts));
	log('merging');
	const merged = mergeCodex(inputs);
	const { warnings: mergeWarnings, frames, evidence, ...codex } = merged;
	const { counts, coverage } = summarize(codex);
	const meta = {
		schema: SCHEMA,
		builtAt: opts.builtAt || (inputs.forever.meta && inputs.forever.meta.builtAt) || null,
		build: (inputs.client && inputs.client.build) || null,
		// A --local-extras build (AtlasLoot, RareScanner, DungeonJournal): never released.
		localExtras: !!(inputs.localExtras || inputs.atlasloot || inputs.rarescanner || (inputs.forever && inputs.forever.dungeons)),
		sources: sourcesMeta(inputs),
		counts,
		coverage,
		pack: null,
	};
	const version = opts.version || packageVersion();
	// The pack's own size goes into meta.json, not into the pack (that would be circular).
	const extraFiles = [];
	// The Dungeons journal (tools/lib/codex/journal.js) rides in this pack.
	const { buildJournal, emitJournal } = require('./journal');
	const { warnings: journalWarnings = [], ...journal } = buildJournal(inputs, codex);
	extraFiles.push(...emitJournal(journal));
	// Parity with the last --local-extras build (tools/lib/codex/parity.js):
	// a release build records the match per kind; without that build, none.
	const against = opts.parityAgainst || (opts.inputs ? null : path.join(ROOT, 'data', 'local', 'codex-extras'));
	let parity = null;
	if (!meta.localExtras && against && fs.existsSync(path.join(against, 'meta.json'))) {
		const { readCodex, summary } = require('./parity');
		parity = writeParity({ ...codex, journal, evidence }, readCodex(against), opts.parityOut || path.join(ROOT, 'data', 'local'), verifyOf(inputs));
		meta.parity = summary(parity.report);
	}
	const files = emitPack({ ...codex, meta, frames }, { version, build: meta.build, extraFiles });
	const bytes = Object.values(files).reduce((n, t) => n + Buffer.byteLength(t), 0);
	writePackDir(packDir, files);
	let memory = null;
	if (opts.measure !== false) {
		log('measuring pack memory');
		memory = measureMemory(packOrder(files).map((f) => path.join(packDir, f)));
	}
	meta.pack = {
		files: Object.keys(files).length,
		bytes,
		memoryKB: memory ? memory.rawKB : null,
		memoryKBDecoded: memory ? memory.decodedKB : null,
		loadMs: memory ? memory.loadMs : null,
	};
	const out = { meta, items: codex.items, npcs: codex.npcs, objects: codex.objects, quests: codex.quests, instances: codex.instances, zones: codex.zones, factions: codex.factions, spells: codex.spells, frames };
	out.journal = journal;
	for (const [name, value] of Object.entries(out)) writeAtomic(path.join(outDir, `${name}.json`), `${JSON.stringify(sortKeysDeep(value), null, '\t')}\n`);
	return { codex: out, files, outDir, packDir, bytes, memory, parity, warnings: [...(inputs.warnings || []), ...mergeWarnings, ...journalWarnings], ms: Date.now() - t0 };
}

// What checks an internal-only fact (tools/lib/codex/parity.js): Wowhead's
// cached pages and the Forever client's instance maps.
function verifyOf(inputs) {
	const norm = (x) => String(x || '').toLowerCase().replace(/^the\s+/, '').replace(/[^a-z0-9]/g, '');
	return {
		wowhead: inputs.wowhead || { npc: {}, object: {}, item: {} },
		clientInstances: new Set(((inputs.client && inputs.client.instanceMaps) || []).map((m) => norm(m.name))),
		// The AreaTable areas on instance maps (Wowhead's `location` inside one).
		instanceAreas: inputs.client ? new Set((inputs.client.instanceMaps || []).flatMap((m) => m.inner || [])) : null,
	};
}

// ours, theirs: Codex objects -> { report, files } with codex-parity.json and .md written to dir.
function writeParity(ours, theirs, dir, verify = null) {
	const { compareCodex, markdown } = require('./parity');
	const report = compareCodex(ours, theirs, verify);
	const files = [path.join(dir, 'codex-parity.json'), path.join(dir, 'codex-parity.md')];
	writeAtomic(files[0], `${JSON.stringify(report, null, '\t')}\n`);
	writeAtomic(files[1], markdown(report));
	return { report, files };
}

module.exports = { buildCodex, loadInputs, mergeCodex, clientFacts, curatedRepGates, loadRepGateTable, cluster, slug, writeParity, pickForeverBuild, TABLES };
