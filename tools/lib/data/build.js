'use strict';
// `data build`: pfQuest + QuestieDB (Forever) + Blizzard map tables +
// recordings -> data/forever/*.json (schema: docs/ARCHITECTURE.md, Toolchain ->
// Reference data). Precedence: recordings > questie-forever > pfQuest; Wowhead
// Forever's change notes update values we still hold from before Forever
// (tools/lib/data/wowhead.js).

const crypto = require('node:crypto');
const fs = require('node:fs');
const path = require('node:path');
const { ensurePfQuest, checkLicense, loadPfQuest, REPO } = require('./pfquest');
const { loadWago, PRODUCT } = require('./wago');
const { buildMaps } = require('./maps');
const { buildFactions } = require('./factions');
const { buildRaces } = require('./races');
const { normalizePfQuest } = require('./normalize');
const { readRecordings, applyRecordings } = require('./recordings');
const { DEFAULTS: SPAWN_DEFAULTS } = require('./spawns');
const { readQuestie, REPO: QUESTIEDB_REPO, QUESTIE_REPO } = require('./questie');
const { applyQuestie } = require('./questie-merge');
const { loadWebXp, WFT, FC } = require('./webxp');
const { loadZoneQuests, applyChangeNotes, fillWowheadXp, applyWowheadFacts, BASE: WOWHEAD } = require('./wowhead');
const { loadSpawnHeights, HEIGHTS_SOURCE } = require('../travel/cmangos');
const CORRECTIONS = require('./corrections.json');

// tools/lib/data/corrections.json: quests `set` fields; items `removeDrops`/`removeVendors`; npcs/objects `set`
// fields and `addSpawns` maps. Every corrected record's source gains "polestar-correction".
function applyCorrections(tables) {
	let n = 0;
	const tag = (e) => {
		if (!e.source) e.source = [];
		if (!e.source.includes('polestar-correction')) e.source.push('polestar-correction');
		n++;
	};
	for (const [id, c] of Object.entries(CORRECTIONS.quests || {})) {
		const q = tables.quests[id];
		if (!q) continue;
		Object.assign(q, c.set);
		tag(q);
	}
	for (const [id, c] of Object.entries(CORRECTIONS.items || {})) {
		const it = tables.items[id];
		if (!it) continue;
		for (const kind of ['npc', 'object']) for (const x of (c.removeDrops || {})[kind] || []) delete it.drops[kind][x];
		if (c.removeVendors) it.vendors = it.vendors.filter((v) => !c.removeVendors.includes(v));
		tag(it);
	}
	for (const kind of ['npcs', 'objects']) {
		for (const [id, c] of Object.entries(CORRECTIONS[kind] || {})) {
			const e = tables[kind][id];
			if (!e) continue;
			if (c.set) Object.assign(e, c.set);
			if (c.addSpawns) {
				const spawns = { ...e.spawns, ...c.addSpawns };
				e.spawns = {};
				for (const k of Object.keys(spawns).map(Number).sort((a, b) => a - b)) e.spawns[k] = spawns[k];
			}
			tag(e);
		}
	}
	return n;
}

// ItemSparse rows -> `duration` (seconds an item lasts once looted, its
// DurationInInventory) on the items we hold. -> how many items got one.
function itemDurations(rows, items) {
	let n = 0;
	for (const r of rows || []) {
		const seconds = Number(r.DurationInInventory);
		const it = items[Number(r.ID)];
		if (!it || !(seconds > 0)) continue;
		it.duration = seconds;
		n++;
	}
	return n;
}

const { ROOT } = require('../paths');
// Always written; races.json too when the Forever client tables include ChrRaces, ChrClasses and CharBaseInfo,
// spawnz.json when CMaNGOS classic-db's dump is cached or can be fetched (loadSpawnHeights).
const FILES = ['quests', 'npcs', 'objects', 'items', 'zones', 'map-frames', 'factions', 'instances', 'meta'];

// Id-keyed table, one entry per line. Integer keys enumerate in ascending
// order in JS, and every record is built with a fixed field order, so the
// output is a pure function of the inputs.
function serializeTable(obj) {
	const keys = Object.keys(obj);
	if (!keys.length) return '{}\n';
	return `{\n${keys.map((k) => `${JSON.stringify(k)}:${JSON.stringify(obj[k])}`).join(',\n')}\n}\n`;
}

function serializePretty(obj) {
	return `${JSON.stringify(obj, null, '\t')}\n`;
}

function builtAtFrom(value) {
	if (value) return new Date(value).toISOString();
	const epoch = process.env.SOURCE_DATE_EPOCH;
	if (epoch && /^\d+$/.test(epoch)) return new Date(Number(epoch) * 1000).toISOString();
	return new Date().toISOString();
}

function countPoints(table, frame) {
	let n = 0;
	for (const e of Object.values(table)) {
		for (const s of Object.values(e.spawns)) if (s.f === frame) n += s.pts.length;
	}
	return n;
}

// Frames further apart than this (yards, any edge) count as changed.
const FRAME_TOLERANCE = 1;

function frameChanged(a, b) {
	return a.c !== b.c || ['left', 'right', 'top', 'bottom'].some((k) => Math.abs(a[k] - b[k]) > FRAME_TOLERANCE);
}

// Maps whose points must be live-frame ("l"): no Era bounds (Forever-only
// or unplaceable maps), or Forever bounds that differ from the Era ones.
// Without Forever tables, QuestieDB's eraToForever list names the changed ones.
function liveMapsFrom(eraFrames, foreverFrames, qz) {
	const changed = new Set();
	if (foreverFrames) {
		for (const id of Object.keys(foreverFrames)) if (eraFrames[id] && frameChanged(eraFrames[id], foreverFrames[id])) changed.add(Number(id));
	} else if (qz) {
		for (const id of qz.eraToForever.uiMapToArea.keys()) changed.add(id);
	}
	return { changed, has: (map) => changed.has(map) || !eraFrames[map] };
}

// Area id -> the dungeon or raid map id it lies in: the AreaTable row's
// ContinentID when its Map row is InstanceType 1 (party) or 2 (raid); null
// for the open world. Without the Map table, an area no UiMap shows
// (`mapped(area)` falsy) on a continent other than 0 (Eastern Kingdoms) and 1
// (Kalimdor) counts.
function instanceAreas(areaRows, mapRows, mapped) {
	const continent = new Map((areaRows || []).map((r) => [Number(r.ID), Number(r.ContinentID)]));
	const instanceMaps = mapRows ? new Set(mapRows.filter((r) => [1, 2].includes(Number(r.InstanceType))).map((r) => Number(r.ID))) : null;
	return (area) => {
		const c = continent.get(area);
		if (!Number.isInteger(c)) return null;
		if (instanceMaps) return instanceMaps.has(c) ? c : null;
		return c > 1 && !mapped(area) ? c : null;
	};
}

const QUESTIE_LICENSE =
	'No license file in Questie/Questie or Questie/QuestieDB; CurseForge lists GPL-3.0, and the maintainers ask that it be treated as all rights reserved (https://github.com/Questie/Questie/issues/4447). Read from the local install; facts only (quest, NPC, object and item facts, no code or text) ship in Polestar\'s packs, credited here, and come out if the maintainers ask (data build --no-questie).';

async function buildData(options = {}) {
	const root = options.root || ROOT;
	const sourcesDir = options.sourcesDir || path.join(root, 'data', 'sources');
	const outDir = options.outDir || path.join(root, 'data', 'forever');
	const recordingsDir = options.recordingsDir || path.join(root, 'data', 'recordings');
	const log = options.log || (() => {});
	const offline = Boolean(options.offline);
	const spawnOptions = { cap: options.cap ?? SPAWN_DEFAULTS.cap, dedupe: options.dedupe ?? SPAWN_DEFAULTS.dedupe };
	const warnings = [];

	const pf = ensurePfQuest({
		dir: options.pfquestDir || path.join(sourcesDir, 'pfQuest'),
		explicit: Boolean(options.pfquestDir),
		offline,
		log,
	});
	warnings.push(...pf.warnings);
	const license = checkLicense(pf.dir);

	const wago = await loadWago({ sourcesDir, build: options.build, offline, fetchImpl: options.fetchImpl, log });
	warnings.push(...wago.warnings);
	const maps = buildMaps({ uiMap: wago.tables.UiMap, assignment: wago.tables.UiMapAssignment, area: wago.tables.AreaTable });
	warnings.push(...maps.warnings);

	// Forever client tables: zone names and frames as the game has them now.
	let fwago = null;
	let fmaps = null;
	if (options.forever) {
		try {
			fwago = await loadWago({ sourcesDir, build: options.foreverBuild, offline, fetchImpl: options.fetchImpl, log, product: 'forever' });
			warnings.push(...fwago.warnings);
			fmaps = buildMaps({ uiMap: fwago.tables.UiMap, assignment: fwago.tables.UiMapAssignment, area: fwago.tables.AreaTable });
			warnings.push(...fmaps.warnings.map((w) => `forever ${w}`));
		} catch (err) {
			warnings.push(`Forever map tables unavailable (${err.message}); zones and frames from Classic Era, changed frames from QuestieDB's eraToForever list`);
		}
	}

	log(`loading pfQuest database from ${pf.dir}`);
	const raw = loadPfQuest(pf.dir);
	const norm = normalizePfQuest(raw, { resolveArea: maps.resolveArea, spawnOptions });

	const qz = options.questieDir ? readQuestie(options.questieDir, { log }) : null;
	const zones = { ...maps.zones, ...(fmaps ? fmaps.zones : {}) };
	if (qz && !fmaps) {
		// Forever-only maps QuestieDB knows, without names or frames.
		for (const [map, areaId] of qz.uiMapToArea) {
			if (map > 0 && !zones[map]) zones[map] = { id: map, name: (maps.areaNames.get(areaId) || null), areaId, parent: null, type: 3 };
		}
	}
	const live = liveMapsFrom(maps.frames, fmaps && fmaps.frames, qz);
	let qstats = null;
	if (qz) {
		const areaToUiMap = (area) => {
			if (qz.areaToUiMap.has(area)) return qz.areaToUiMap.get(area) > 0 ? qz.areaToUiMap.get(area) : null;
			return (fmaps && fmaps.resolveArea(area)) || maps.resolveArea(area);
		};
		// Map percent -> world yards in the point's frame (docs/ARCHITECTURE.md, Map frames).
		const toWorld = (map, f, x, y) => {
			const fr = (f === 'l' && fmaps && fmaps.frames[map]) || maps.frames[map] || (fmaps && fmaps.frames[map]);
			return fr ? { c: fr.c, wx: fr.top + ((fr.bottom - fr.top) * y) / 100, wy: fr.left + ((fr.right - fr.left) * x) / 100 } : null;
		};
		const instanceOfArea = instanceAreas((fwago && fwago.tables.AreaTable) || wago.tables.AreaTable, fwago && fwago.tables.Map, areaToUiMap);
		qstats = applyQuestie(norm, qz, { areaToUiMap, liveMaps: live, spawnOptions, toWorld, instanceOfArea });
	}

	// Wowhead Forever's change notes (the cached zone lists), before our own corrections.
	let wh = null;
	if (qz && options.wowhead) {
		const zl = loadZoneQuests({ sourcesDir });
		warnings.push(...zl.warnings);
		wh = { zl, changed: applyChangeNotes(norm.quests, zl.rows), facts: applyWowheadFacts(norm.quests, zl.rows), xpFilled: 0 };
	}
	if (qz) qstats.corrections = applyCorrections(norm);

	// Quest XP still missing after QuestieDB, from the Forever web databases.
	let webxp = null;
	if (options.webXp) {
		const want = Object.values(norm.quests).filter((q) => !Number.isFinite(q.xp)).map((q) => q.id);
		webxp = await loadWebXp({ sourcesDir, ids: want, offline, fetchImpl: options.fetchImpl, log });
		warnings.push(...webxp.warnings);
		for (const [id, { xp, source }] of webxp.xp) {
			const q = norm.quests[id];
			q.xp = xp;
			if (!q.source.includes(source)) q.source.push(source);
		}
	}
	if (wh) wh.xpFilled = fillWowheadXp(norm.quests, wh.zl.rows);

	// Forever's Faction rows win by id; Era rows fill the rest (Forever-only reputations: 2740 Kirin Tor, ...).
	const factionRows = new Map(wago.tables.Faction.map((r) => [Number(r.ID), r]));
	if (fwago && fwago.tables.Faction) for (const r of fwago.tables.Faction) factionRows.set(Number(r.ID), r);
	const factions = buildFactions([...factionRows.values()]);
	const ft = fwago && fwago.tables;
	const races = ft && ft.ChrRaces && ft.ChrClasses && ft.CharBaseInfo ? buildRaces(ft) : null;
	const recordings = readRecordings(recordingsDir);
	// Instances (dungeon/raid map id -> entrances, encounters) are recorded facts only.
	const instances = {};
	const rec = applyRecordings(
		{ quests: norm.quests, npcs: norm.npcs, objects: norm.objects, items: norm.items, zones, factions, instances },
		recordings,
		{ spawnOptions, liveMaps: live },
	);
	// Items that vanish a while after they are looted (the Forever client's
	// ItemSparse DurationInInventory, seconds): the timed-item lint reads them.
	const durations = itemDurations(ft && ft.ItemSparse, norm.items);

	// Spawn heights for the compiler's goal `z` (tools/lib/dsl/heights.js). The
	// dump is fetched once and cached; without it (--offline, a failed download)
	// the build goes on without spawnz.json. `classicDb` ({ url, hash }): a test's own dump.
	let heights = null;
	try {
		heights = await loadSpawnHeights({ sourcesDir, offline, fetchImpl: options.fetchImpl, log, ...(options.classicDb || {}) });
	} catch (err) {
		warnings.push(`CMaNGOS classic-db spawn heights unavailable (${err.message}); spawnz.json not written, so compiled goals carry no z`);
	}

	const sources = [
		{ name: 'pfQuest', url: REPO, revision: pf.revision, license: license.license, copyright: license.copyright, notice: license.notice },
		{
			name: 'World of Warcraft Classic Era client tables (UiMap, UiMapAssignment, AreaTable, Faction) via wago.tools',
			url: `https://wago.tools/db2?build=${wago.build}`,
			revision: `${PRODUCT} ${wago.build}`,
			license: 'Blizzard Entertainment game client data; factual map geometry, names and faction hierarchy only',
			copyright: 'World of Warcraft (c) Blizzard Entertainment, Inc.',
			tables: Object.values(wago.urls),
		},
	];
	if (qz) {
		const q = qz.info.questie;
		sources.push({
			name: 'QuestieDB (Questie-Forever), baked Forever store and support data',
			url: QUESTIEDB_REPO,
			revision: `${qz.info.version} ${qz.info.buildCommit}`,
			license: QUESTIE_LICENSE,
			copyright: qz.info.author,
			builtAt: qz.info.buildTime,
			flavor: qz.info.flavor,
			contract: qz.info.contract,
			questie: q ? { url: QUESTIE_REPO, version: q.version, revision: q.buildCommit, authors: q.author } : null,
			dir: qz.dir,
		});
	}
	if (webxp && webxp.xp.size) {
		sources.push({
			name: 'Quest XP for quests QuestieDB lacks: wowforevertalents.com (Forever beta client quest cache), else foreverchanges.pro (Wowhead Forever database)',
			url: `${WFT} ; ${FC}`,
			revision: `${webxp.xp.size} quests; cache ${path.relative(root, webxp.file).split(path.sep).join('/')}`,
			license: 'Public web pages; facts (XP numbers) only, used locally with permission',
			copyright: null,
		});
	}
	if (wh) {
		sources.push({
			name: 'Wowhead Forever database: zone quest lists (XP, levels, Forever change notes)',
			url: WOWHEAD,
			revision: `${wh.zl.rows.size} listed quests${wh.zl.fetchedAt ? ` read ${wh.zl.fetchedAt}` : ''}; cache ${path.relative(root, wh.zl.file).split(path.sep).join('/')}`,
			license: 'Public web pages; facts (ids, XP, levels, instance categories, rewards) only, used locally',
			copyright: null,
		});
	}
	if (fwago) {
		sources.push({
			name: `World of Warcraft: Forever client tables (UiMap, UiMapAssignment, AreaTable${races ? ', ChrRaces, ChrClasses, CharBaseInfo' : ''}${fwago.tables.Faction ? ', Faction' : ''}${fwago.tables.Map ? ', Map' : ''}${fwago.tables.ItemSparse ? ', ItemSparse' : ''}${fwago.tables.QuestV2 ? ', QuestV2' : ''}) via wago.tools`,
			url: `https://wago.tools/db2?build=${fwago.build}`,
			revision: `${fwago.product} ${fwago.build}`,
			license: `Blizzard Entertainment game client data; factual map geometry, names${fwago.tables.ItemSparse ? ', item durations' : ''} and race/class combinations only`,
			copyright: 'World of Warcraft (c) Blizzard Entertainment, Inc.',
			tables: Object.values(fwago.urls),
		});
	}
	if (recordings.length) {
		const hash = crypto.createHash('sha256');
		for (const { file, rec: r } of recordings) hash.update(file).update('\0').update(JSON.stringify(r)).update('\0');
		sources.push({
			name: 'Polestar recordings',
			url: null,
			revision: hash.digest('hex').slice(0, 16),
			license: 'Polestar original work',
			copyright: null,
			sessions: recordings.map((r) => r.file),
		});
	}
	if (heights) sources.push({ ...HEIGHTS_SOURCE });

	const out = {
		quests: serializeTable(norm.quests),
		npcs: serializeTable(norm.npcs),
		objects: serializeTable(norm.objects),
		items: serializeTable(norm.items),
		zones: serializeTable(zones),
		'map-frames': serializePretty(fmaps ? { era: maps.frames, forever: fmaps.frames } : { era: maps.frames }),
		factions: serializeTable(factions),
		instances: serializeTable(instances),
		...(races ? { races: serializeTable(races) } : {}),
		...(heights ? { spawnz: heights.text } : {}),
	};
	const files = {};
	for (const name of Object.keys(out)) files[`${name}.json`] = Buffer.byteLength(out[name]);

	const meta = {
		builtAt: builtAtFrom(options.builtAt),
		sources,
		counts: {
			quests: Object.keys(norm.quests).length,
			npcs: Object.keys(norm.npcs).length,
			objects: Object.keys(norm.objects).length,
			items: Object.keys(norm.items).length,
			zones: Object.keys(zones).length,
			mapFrames: Object.keys(maps.frames).length,
			...(fmaps ? { foreverMapFrames: Object.keys(fmaps.frames).length } : {}),
			factions: Object.keys(factions).length,
			...(races ? { races: Object.keys(races).length } : {}),
			...(fwago && fwago.tables.ItemSparse ? { timedItems: durations } : {}),
			...(heights ? { spawnHeightNpcs: Object.keys(heights.npc).length, spawnHeightObjects: Object.keys(heights.object).length } : {}),
			recorderOnlyFactions: rec.recorderOnlyFactions,
			eraSpawnPoints: countPoints(norm.npcs, 'e') + countPoints(norm.objects, 'e'),
			liveSpawnPoints: countPoints(norm.npcs, 'l') + countPoints(norm.objects, 'l'),
			unmappedSpawnPoints: norm.stats.unmappedPoints,
			untitledQuestsSkipped: norm.stats.skippedQuests,
			recordings: rec.recordings,
			recordingEvents: rec.events,
			recordedQuests: rec.touchedQuests,
			recorderOnlyQuests: rec.recorderOnlyQuests,
			recordedKills: rec.recordedKills,
			recordedLoots: rec.recordedLoots,
			recordedSightings: rec.recordedSightings,
			recordedDropChances: rec.recordedDropChances,
			recordedTreasures: rec.recordedTreasures,
			recordedInstances: rec.recordedInstances,
			recordedEncounters: rec.recordedEncounters,
			spawnCap: spawnOptions.cap,
			...(qstats
				? {
						questieQuests: qstats.questieQuests,
						questieOnlyQuests: qstats.questieOnlyQuests,
						questieNpcs: qstats.questieNpcs,
						questieOnlyNpcs: qstats.questieOnlyNpcs,
						questieObjects: qstats.questieObjects,
						questieOnlyObjects: qstats.questieOnlyObjects,
						questieItems: qstats.questieItems,
						questieOnlyItems: qstats.questieOnlyItems,
						unmappedQuestiePoints: qstats.unmappedQuestiePoints,
						questsWithXp: Object.values(norm.quests).filter((q) => Number.isFinite(q.xp)).length,
						questXpFromQuestie: qstats.questXp,
						questXpFromWeb: webxp ? webxp.xp.size : 0,
						questXpFromWowhead: wh ? wh.xpFilled : 0,
						wowheadChanged: wh ? wh.changed : null,
						wowheadFacts: wh ? wh.facts : 0,
						prereqsCleaned: qstats.prereqsCleaned,
						reverseLinks: qstats.reverseLinks,
						itemsRegainedEntries: qstats.itemsRegainedEntries,
						npcsRegainedRoles: qstats.npcsRegainedRoles,
						questsRegainedGivers: qstats.questsRegainedGivers,
						corrections: qstats.corrections,
					}
				: {}),
		},
		liveFrameMaps: [...live.changed].sort((a, b) => a - b),
		...(qstats ? { questie: { notInStore: qstats.removedQuests, changedFields: qstats.changedQuests } } : {}),
		files,
		warnings,
	};
	out.meta = serializePretty(meta);

	if (options.write !== false) {
		fs.mkdirSync(outDir, { recursive: true });
		for (const name of Object.keys(out)) {
			const file = path.join(outDir, `${name}.json`);
			fs.writeFileSync(`${file}.tmp`, out[name]);
			fs.renameSync(`${file}.tmp`, file);
		}
		// No heights this time: an older spawnz.json would not match the rest.
		if (!heights) fs.rmSync(path.join(outDir, 'spawnz.json'), { force: true });
	}
	return { outDir, out, meta };
}

module.exports = { buildData, serializeTable, FILES };
