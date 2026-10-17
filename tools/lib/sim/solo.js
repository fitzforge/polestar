'use strict';
// Solo feasibility (docs/SIMULATION.md §1 "Solo filter"): which quests a
// levelling character can do alone. The world builder (world.js) applies
// these rules, the instance areas from `loadQuestAreas` and the explicit
// `OVERRIDES` per quest; every exclusion carries one category, counted in
// `world.solo.counts`.
//
// Categories follow the Forever client's QuestInfo types (wago.tools
// QuestInfo.csv, build 1.60.1.70338: 1 Elite, 41 PvP, 62 Raid, 81 Dungeon).
// The client table only names the types; which quest has which type is
// server data, absent from the client tables and from QuestieDB (no group
// size or quest-type field). So the types are derived:
//   dungeon / raid / pvp  the quest's Questie area (zoneOrSort) lies in an
//                         instance (Map.csv InstanceType 1 / 2 / 3), or the
//                         quest is a dungeons.json dungeon quest, AND its
//                         giver or ender has no open-world site or one of its
//                         objectives cannot be placed in the open world (the
//                         area is the story zone: breadcrumbs and outer-cave
//                         quests stay);
//   elite                 a kill objective on an elite (rank 1-3), or a
//                         collect / quest-starting item whose only droppers
//                         are elites or 5+ levels above the quest;
//   rareDrop              a collect objective whose every dropper is below
//                         1% (Kum'isha's sphere, 0.01%);
//   reputation            needs more than Friendly with a faction (Questie
//                         reputation requirement), or listed below;
//   repeatable            a repeatable without a recorded reward, needed by
//                         no other quest. Every quest counts once; a needed
//                         repeatable without a reward gives no XP (`noXp`).
// A quest whose prerequisite was excluded is unreachable at run time
// (run.js), so a chain after an excluded quest goes with it.

const fs = require('node:fs');
const path = require('node:path');
const { parseCsv } = require('../data/csv');

const CATEGORIES = ['dungeon', 'raid', 'pvp', 'elite', 'rareDrop', 'reputation', 'repeatable'];
const FRIENDLY = 3000; // reputation points; more needs grinding a faction
const HIGH_DROPPER = 5; // a dropper this many levels above the quest is not soloed
const MIN_DROP = 1; // % below which a dropper is not a source

// Explicit hook: corrections the data cannot express.
//   exclude      quests to drop (category, reason; category null: excluded
//                without a solo category, like professions);
//   allow        quests to keep whatever the rules say, the profession rule
//                included (reason);
//   turninAfter  parent -> quests that must be turned in before the parent
//                can be (their rewards or effects are its objectives);
//   startItemFrom  quest -> the quest whose turn-in hands over its starting
//                item (the data has no quest rewards): it starts at that
//                quest's ender once that quest is done.
const range = (a, b) => Array.from({ length: b - a + 1 }, (_, i) => a + i);
const OVERRIDES = {
	exclude: [
		{ ids: range(9124, 9142), category: 'reputation', reason: "Naxxramas-era Argent Dawn turn-ins at Light's Hope (patch 1.11 endgame materials)" },
		{ ids: range(9221, 9228), category: 'reputation', reason: 'Argent Dawn armaments: Scourge Invasion insignia and Friendly-Exalted ranks' },
		{ ids: [969], category: 'elite', reason: "Frostmaul Shards lie in the Frostmaul giants' cave (elite 59-60); opens the Mau'ari E'ko chain" },
		{ ids: [8308], category: 'elite', reason: "the letter drops from Hive'Ashi elites; its non-elite droppers are hive-event spawns (3 recorded)" },
		{ ids: [8371, 8385], category: 'pvp', reason: 'Concerted Efforts: one mark from each battleground' },
		{ ids: [9664, 9665], category: 'pvp', reason: 'Eastern Plaguelands tower captures (world PvP objective)' },
		{ ids: [996, 998, 1514, 2523, 2878, 3363, 4113, 4114, 4115, 4116, 4117, 4118, 4119, 4221, 4222, 4343, 4401, 4403, 4443, 4444, 4445, 4446, 4447, 4448, 4461, 4462, 4464, 4465, 4466, 4467], category: null, reason: 'corrupted plants: each needs a Cenarion Plant Salve (a Salve via ... turn-in item, not modelled)' },
		{ ids: [4103, 4104, 4105, 4106, 4107, 4108, 4109, 4110, 4111, 4112, 5882, 5883, 5884, 5885, 5886, 5887, 5888, 5889, 5890, 5891], category: null, reason: 'Salve via ...: salve turn-ins (gathering or profession items), only for the corrupted plants' },
		{ ids: [6026, 6041], category: null, reason: 'Smokey LaRue: crafted Thorium bars and bombs (profession items)' },
		{ ids: [9324, 9325, 9326, 9330, 9331, 9332], category: null, reason: "Midsummer Fire Festival: stealing the other faction's capital flames (seasonal; no event flag in the data)" },
	],
	allow: [
		{ ids: [384, 4161], reason: 'Cooking rank 1 (Beer Basted Boar Ribs, Recipe of the Kaldorei): the starting-zone guides train Cooking at the trainer next to the giver' },
		{ ids: [97291], reason: 'Unending Torment: its Blisterweed grows by the Undercity herbalism trainer (no object or drop in the data, so it would read as made inside the Ruins of Lordaeron area)' },
	],
	turninAfter: {
		348: [349], // Stranglethorn Fever: Unbagwa summons Mokk for the gorilla fangs (349)
		338: [339, 340, 341, 342], // Green Hills of Stranglethorn: the chapters are 339-342's rewards
		812: [813], // Need for a Cure: the Venomtail Antidote is Finding the Antidote's (813) reward
		5060: [5059], // Locked Away: opening the outhouse (5059) summons Farmer Dalson with the cabinet key
		1190: [1191], // Keeping Pace: Zamek's distraction (1191) lets you take Rizzle's plans
	},
	startItemFrom: {
		1642: 1641, // The Tome of Divinity (Human Paladin): the tome is 1641's turn-in
		1646: 1645, // The Tome of Divinity (Dwarf Paladin): the tome is 1645's turn-in
	},
};

function compileOverrides(o = OVERRIDES) {
	const exclude = new Map();
	for (const e of o.exclude || []) for (const id of e.ids) exclude.set(id, { category: e.category, reason: e.reason });
	const allow = new Map();
	for (const e of o.allow || []) for (const id of e.ids) allow.set(id, e.reason);
	const turninAfter = new Map(Object.entries(o.turninAfter || {}).map(([k, v]) => [Number(k), v.map(Number)]));
	const startItemFrom = new Map(Object.entries(o.startItemFrom || {}).map(([k, v]) => [Number(k), Number(v)]));
	return { exclude, allow, turninAfter, startItemFrom };
}

// Newest cached Forever client build (1.6x) with Map.csv and AreaTable.csv.
function foreverBuild(sourcesDir) {
	const root = path.join(sourcesDir, 'wago');
	if (!fs.existsSync(root)) return null;
	const ok = fs.readdirSync(root).filter((b) => /^1\.6\d\./.test(b) && ['Map.csv', 'AreaTable.csv'].every((f) => fs.existsSync(path.join(root, b, f))));
	ok.sort((a, b) => {
		const pa = a.split('.').map(Number);
		const pb = b.split('.').map(Number);
		for (let i = 0; i < 4; i++) if ((pa[i] || 0) !== (pb[i] || 0)) return (pa[i] || 0) - (pb[i] || 0);
		return 0;
	});
	return ok.length ? path.join(root, ok[ok.length - 1]) : null;
}

const KIND = { 1: 'dungeon', 2: 'raid', 3: 'pvp' };

// Instance maps of Map.csv rows: map id -> { kind, name, area, map }.
function instanceMaps(mapRows) {
	const maps = new Map();
	for (const m of mapRows) {
		const k = KIND[Number(m.InstanceType)];
		if (k) maps.set(Number(m.ID), { kind: k, name: m.MapName_lang, area: Number(m.AreaTableID) || 0, map: Number(m.ID) });
	}
	return maps;
}

// AreaTable ids inside instances -> { kind: 'dungeon' | 'raid' | 'pvp', name, map }
// (the instance's name and Map.csv id): areas on an instance map, each instance map's own
// area, and the entrance subzones named after the instance (Gnomeregan 133
// in Dun Morogh, Uldaman 1517).
function instancesByArea(mapRows, areaRows) {
	const maps = instanceMaps(mapRows);
	const byName = new Map([...maps.values()].map((m) => [m.name, m]));
	const out = {};
	for (const m of maps.values()) if (m.area) out[m.area] = { kind: m.kind, name: m.name, map: m.map };
	for (const a of areaRows) {
		const id = Number(a.ID);
		const m = maps.get(Number(a.ContinentID)) || (Number(a.ParentAreaID) ? byName.get(a.AreaName_lang) : null);
		if (m) out[id] = { kind: m.kind, name: m.name, map: m.map };
	}
	return out;
}

// AreaTable ids inside instances -> 'dungeon' | 'raid' | 'pvp' (instancesByArea).
function instanceAreas(mapRows, areaRows) {
	const out = {};
	for (const [id, inst] of Object.entries(instancesByArea(mapRows, areaRows))) out[id] = inst.kind;
	return out;
}

// UiMap ids drawn only on instance maps (UiMapAssignment.csv) -> { kind, name, map }.
function instancesByUiMap(mapRows, assignmentRows) {
	const maps = instanceMaps(mapRows);
	const seen = new Map(); // uiMap -> instance map, or null once it also shows another map
	for (const a of assignmentRows) {
		const ui = Number(a.UiMapID);
		const m = maps.get(Number(a.MapID)) || null;
		if (!seen.has(ui)) seen.set(ui, m);
		else if (seen.get(ui) !== m) seen.set(ui, null);
	}
	const out = {};
	for (const [ui, m] of seen) if (m) out[ui] = { kind: m.kind, name: m.name, map: m.map };
	return out;
}

// -> { build, files, areas } or null when no Forever build is cached.
function loadQuestAreas(sourcesDir) {
	const dir = sourcesDir && foreverBuild(sourcesDir);
	if (!dir) return null;
	const files = ['Map.csv', 'AreaTable.csv'].map((f) => path.join(dir, f));
	const [maps, areas] = files.map((f) => parseCsv(fs.readFileSync(f, 'utf8')));
	return { build: path.basename(dir), files, areas: instanceAreas(maps, areas) };
}

// The compiler's view of the same client tables (docs/GUIDE_FORMAT.md,
// "Group content"): -> { build, areas: AreaTable id -> { kind, name },
// maps: uiMap id -> { kind, name } } or null when no Forever build is cached.
// `maps` is empty without the build's UiMapAssignment.csv.
function loadInstances(sourcesDir) {
	const dir = sourcesDir && foreverBuild(sourcesDir);
	if (!dir) return null;
	const read = (f) => parseCsv(fs.readFileSync(path.join(dir, f), 'utf8'));
	const maps = read('Map.csv');
	const assignments = fs.existsSync(path.join(dir, 'UiMapAssignment.csv')) ? read('UiMapAssignment.csv') : [];
	return { build: path.basename(dir), areas: instancesByArea(maps, read('AreaTable.csv')), maps: instancesByUiMap(maps, assignments) };
}

// The solo filter's instance rule for one quest, as world.js applies it: the
// quest's Questie area lies in an instance (`areas`: instancesByArea), and
// its giver, its ender or one of its objectives has no open-world place
// (Questie's area is the story zone, so breadcrumbs and outer-cave quests
// stay open-world quests). `placed(kind, id)` tells whether an npc, object or
// item ('item': some npc or object that drops it) has an open-world spawn.
// The world builder decides the same while it places the quest (it also
// counts dungeons.json quests, which the compiler does not read).
// -> { kind: 'dungeon' | 'raid' | 'pvp', name, map } | null
function instanceQuest(quest, areas, placed) {
	const inst = quest && areas && areas[quest.area];
	if (!inst) return null;
	const anyPlaced = (ends) => ['npc', 'object'].some((kind) => ((ends || {})[kind] || []).some((id) => placed(kind, id)));
	if (!anyPlaced(quest.start) || !anyPlaced(quest.end)) return inst;
	for (const o of quest.objectives || []) {
		if (!o) continue;
		const kind = o.type === 'kill' ? 'npc' : o.type;
		if (kind === 'event' ? o.map == null : !placed(kind, o.id)) return inst;
	}
	return null;
}

module.exports = { CATEGORIES, FRIENDLY, HIGH_DROPPER, MIN_DROP, OVERRIDES, compileOverrides, instanceAreas, instancesByArea, instancesByUiMap, instanceQuest, loadQuestAreas, loadInstances, foreverBuild };
