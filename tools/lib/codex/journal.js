'use strict';
// The Dungeons section's data (docs/ARCHITECTURE.md, "Dungeons"): a journal
// page per Codex dungeon and raid: every quest with where it starts and ends,
// its objective, its chain and its rewards, the bosses in kill order with the
// quests tied to them, and the entrance. No loot tables (the Codex's
// instances carry each boss's loot for Lookup). A release build reads only
// release-safe inputs; dungeons.json (DungeonJournal) is present only in a
// --local-extras build. Built by `codex build` and shipped inside the
// load-on-demand Codex pack as Dungeons1.lua, which registers into
// Polestar.Dungeons (addon/Polestar/Dungeons/Dungeons.lua).
//
//   instanceMapsOf(mapRows, areaRows)  Map (+ AreaTable) CSV rows -> [ { id, name, raid, players, area,
//                                      areas: [areaIds], inner: [areaIds on the map itself], zones: [areaIds], corpse: { c, x, y } | null } ]
//   zonePoint(frames, c, wx, wy, prefer) world point -> { map, x, y, f } on a zone frame
//   buildJournal(inputs, codex)        -> { meta, dungeons: { key: Page } }
//   emitJournal(journal)               -> [ { name: 'Dungeons1.lua', text } ]
//
// Inputs: `inputs` as tools/lib/codex/build.js loadInputs returns it
// (client.instanceMaps, forever.mapFrames / zones / quests / dungeons),
// `codex` the merged Codex (instances, items, npcs, objects, quests). Every
// input may be missing; the result then holds less.
//
// Page: { key, name, map (the instance's Map id), kind, forever, minLevel, maxLevel, players, zone, zoneName,
//   entrance: { map, x, y, f } | null,
//   quests: [ Quest ] (level order), chain: { id: Quest } (prerequisites not on the page),
//   bosses: [ { order, name, npc, level, object?, role?, encounter?, quests: [ { id, how, item?, itemName? } ] } ],
//   attunement: [ Attunement ] (tools/lib/codex/attunements.js; none: absent) }
//   (object: a chest boss's object id; role: rare | event | optional, the bosses after the encounters;
//   encounter: its DungeonEncounter id)
// Quest: { id, title, level, minLevel, faction 'A'|'H'|null, classes|null, inside, shareable,
//   objectives: [ { k, id?, n?, name } ]|null (objectivesOf), start|null, finish|null (each { kind, id, name, map, x, y, f, inside }),
//   startItem: { id, name }|null, chain: [ids, oldest first],
//   rewards: { items: [ { id, name, quality, choice } ], xp, money, rep: [ { faction, name, value } ] },
//   bosses: [names] }
//
// Facts only (ids, names, levels, coordinates, amounts); the objective line is
// our own wording, composed in the client's language from the objective facts.

const fs = require('node:fs');
const path = require('node:path');
const { header } = require('../generated');

const SCHEMA = 3; // 3: objective facts (objectives) instead of an English line, instance map, boss encounter

const num = (v) => {
	const n = Number(v);
	return Number.isFinite(n) ? n : 0;
};
const norm = (s) =>
	String(s || '')
		.toLowerCase()
		.replace(/^the\s+/, '')
		.replace(/[^a-z0-9]/g, '');
const round1 = (v) => Math.round(v * 10) / 10;

// ---------------------------------------------------------------------------
// Client tables
// ---------------------------------------------------------------------------

// InstanceType 1 dungeon, 2 raid. Corpse_0/1: the world point (x north, y
// west) on map CorpseMapID where a ghost comes back: the entrance. zones: the
// outdoor zone areas holding an area of the instance's name on that
// continent (Uldaman in the Badlands), to place the entrance on the right map.
function instanceMapsOf(mapRows, areaRows) {
	const areasByMap = {};
	const areaNames = {};
	const areaRow = {};
	for (const a of areaRows || []) {
		const id = num(a.ID);
		if (!id) continue;
		areaRow[id] = a;
		(areasByMap[num(a.ContinentID)] = areasByMap[num(a.ContinentID)] || []).push(id);
		const n = norm(a.AreaName_lang);
		if (n) (areaNames[n] = areaNames[n] || []).push(id);
	}
	const out = [];
	for (const r of mapRows || []) {
		const type = num(r.InstanceType);
		if (type !== 1 && type !== 2) continue;
		const id = num(r.ID);
		const name = r.MapName_lang || r.Directory || '';
		const c = num(r.CorpseMapID);
		const x = num(r.Corpse_0);
		const y = num(r.Corpse_1);
		const areas = new Set(areasByMap[id] || []);
		if (num(r.AreaTableID)) areas.add(num(r.AreaTableID));
		// The areas on the instance's own map (what Wowhead's `location` names).
		const inner = [...areas].sort((a, b) => a - b);
		// Areas of the same name outside the instance (Questie files some
		// dungeon quests under the outdoor sub-zone, e.g. Gnomeregan in Dun Morogh).
		const zones = new Set();
		for (const a of areaNames[norm(name)] || []) {
			areas.add(a);
			const row = areaRow[a];
			if (row && num(row.ContinentID) === c && num(row.ParentAreaID)) zones.add(num(row.ParentAreaID));
		}
		out.push({
			id,
			name,
			raid: type === 2,
			players: num(r.MaxPlayers) || null,
			area: num(r.AreaTableID) || null,
			areas: [...areas].sort((a, b) => a - b),
			inner,
			zones: [...zones].sort((a, b) => a - b),
			corpse: c >= 0 && (x || y) ? { c, x, y } : null,
		});
	}
	return out.sort((a, b) => a.id - b.id);
}

// World point -> { map, x, y } on a zone frame holding it: one of `prefer`
// (uiMapIDs) when it holds the point, else the one nearest the frame's centre
// (frames are rectangles and overlap: a zone's own places sit inside its art,
// a neighbour's near the edge). frames: { "<uiMapID>": { c, left, right, top,
// bottom } } (live frames); continent frames are skipped.
const ZONE_MAX = 20000; // yards; continents are larger
function zonePoint(frames, c, wx, wy, prefer = []) {
	let best = null;
	for (const [id, f] of Object.entries(frames || {})) {
		if (f.c !== c) continue;
		const w = f.left - f.right;
		const h = f.top - f.bottom;
		if (!(w > 0 && h > 0) || w > ZONE_MAX || h > ZONE_MAX) continue;
		const x = ((f.left - wy) / w) * 100;
		const y = ((f.top - wx) / h) * 100;
		if (x < 0 || x > 100 || y < 0 || y > 100) continue;
		const off = (prefer.includes(Number(id)) ? 0 : 1e6) + (x - 50) ** 2 + (y - 50) ** 2;
		if (!best || off < best.off) best = { map: Number(id), x: round1(x), y: round1(y), off };
	}
	return best ? { map: best.map, x: best.x, y: best.y, f: null } : null;
}

// ---------------------------------------------------------------------------
// Quests
// ---------------------------------------------------------------------------

// Every quest before `id`, oldest first: its prerequisites (`pre`, `preAll`,
// each `preAny` alternative) and the breadcrumbs that lead to it, and theirs,
// depth first so a quest follows the ones it needs; the other side's are left
// out (`side` 'A' | 'H' | null), at most 20. One prerequisite per quest left
// Nathanos Blightcaller's errands for The Call to Command (6144: 6135 and
// 6136) and the breadcrumbs (Speak with Shoni before Underground Assault) off
// the page.
const CHAIN_MAX = 20;
function chainOf(quests, fq, id, side) {
	const chain = [];
	const seen = new Set([id]);
	const visit = (qid) => {
		const c = quests[qid] || {};
		const f = fq[qid] || {};
		for (const pre of [...(c.pre || []), ...(f.pre || []), ...(f.preAll || []), ...(c.preAny || []), ...(f.preAny || []), ...(f.breadcrumbs || [])]) {
			if (seen.has(pre) || chain.length >= CHAIN_MAX) continue;
			seen.add(pre);
			const p = quests[pre] || fq[pre];
			if (!p) continue;
			const pside = SIDE[p.faction] || null;
			if (side && pside && pside !== side) continue;
			visit(pre);
			if (chain.length < CHAIN_MAX) chain.push(pre);
		}
	};
	visit(id);
	return chain;
}

const SIDE = { Alliance: 'A', Horde: 'H', A: 'A', H: 'H' };

// The objective facts a page shows: [ { k, id?, n?, name } ] in the quest's
// order, k 'kill' | 'item' | 'object' (id the NPC, item or object) or
// 'event' (no id: name is the data's text); n the count when over one;
// name the English name (the line in another language is composed at run
// time from these: Dungeons.ObjectiveText). An objective without a name is
// left out; none left: null.
function objectivesOf(objectives, names) {
	const out = [];
	for (const o of objectives || []) {
		const k = o.type === 'kill' || o.type === 'item' || o.type === 'object' ? o.type : 'event';
		const id = k === 'event' ? null : o.id ?? null;
		const name = (k === 'kill' && names.npc(id)) || (k === 'item' && names.item(id)) || (k === 'object' && names.object(id)) || o.text || null;
		if (!name) continue;
		const part = { k };
		if (id) part.id = id;
		if (Number(o.count) > 1 && k !== 'object') part.n = Number(o.count);
		part.name = name;
		out.push(part);
	}
	return out.length ? out : null;
}

// A giver or ender from its kind and id: name and first spawn from the Codex.
function placeOf(kind, id, codex) {
	if (!id) return null;
	const rec = kind === 'object' ? codex.objects && codex.objects[id] : codex.npcs && codex.npcs[id];
	if (!rec) return null;
	const s = (rec.spawns || [])[0];
	return { kind, id, name: rec.name || null, map: s ? s.map : null, x: s ? s.x : null, y: s ? s.y : null, f: s && s.f === 'e' ? 'e' : null, inside: false };
}

// dungeons.json place -> ours.
function djPlace(p) {
	if (!p) return null;
	return {
		kind: p.kind || 'npc',
		id: p.id ?? null,
		name: p.name || null,
		map: p.map ?? null,
		x: p.x == null ? null : round1(p.x),
		y: p.y == null ? null : round1(p.y),
		f: p.f === 'e' ? 'e' : null,
		inside: !!p.inDungeon,
	};
}

// The reputation a quest gives: Wowhead Forever's list row (quests.json
// `wowhead.rep`). QuestieDB's `reputation` is the standing a quest asks for
// (Friendly is 3000), not what it gives.
function repOf(fq, factions) {
	const r = fq && fq.wowhead && fq.wowhead.rep;
	if (!Array.isArray(r)) return [];
	return r.map(([faction, value]) => ({ faction, name: (factions[faction] && factions[faction].name) || null, value: value ?? null }));
}

// count: how many of it (Wowhead's lists; omitted for one).
function rewardItem(id, choice, codex, given, count) {
	const it = codex.items && codex.items[id];
	const out = { id, name: (given && given.name) || (it && it.name) || null, quality: (given && given.quality) ?? (it && it.quality) ?? null, choice };
	if (count > 1) out.count = count;
	return out;
}

function buildPages(inputs, codex, warnings = []) {
	const fv = inputs.forever || {};
	const client = inputs.client || {};
	const maps = client.instanceMaps || [];
	const frames = (fv.mapFrames && fv.mapFrames.forever) || {};
	const instances = codex.instances || {};
	const cq = codex.quests || {};
	const fq = fv.quests || {};
	const npcs = codex.npcs || {};
	const items = codex.items || {};
	const factions = codex.factions || {};
	const zones = { ...(fv.zones || {}), ...(codex.zones || {}) };
	const names = {
		npc: (id) => (npcs[id] && npcs[id].name) || null,
		item: (id) => (items[id] && items[id].name) || null,
		object: (id) => (codex.objects && codex.objects[id] && codex.objects[id].name) || null,
	};
	const djByKey = {};
	for (const d of (fv.dungeons && fv.dungeons.dungeons) || []) djByKey[d.key] = d;
	const djByName = {};
	for (const d of Object.values(djByKey)) djByName[norm(d.name)] = d;

	const mapOf = {};
	const areaKeys = {};
	const mapKeys = {}; // client map id -> instance keys
	for (const [key, inst] of Object.entries(instances)) {
		const m = matchMap(inst, maps);
		mapOf[key] = m;
		const areas = new Set(m ? m.areas : []);
		if (inst.areaId) areas.add(inst.areaId);
		for (const a of areas) (areaKeys[a] = areaKeys[a] || new Set()).add(key);
		if (m) (mapKeys[m.id] = mapKeys[m.id] || new Set()).add(key);
	}

	// Which instance an NPC or an item (by its drops) belongs to; which boss
	// drops an item. A quest's start item also belongs to the one instance an
	// object holding it is placed in (the Treaty of Understanding in the Hall
	// of Thanes' vault); objective items do not (chests inside hold world
	// loot). An objective item that is also sold, crafted, dropped or held
	// outside every instance links its quest to none (`outside`): the Bronze
	// Tube of Look to the Stars (sold, and one Gnomeregan drop), Rite of
	// Vision's Well Stone (a Mulgore object, one Maraudon drop), the Indurium
	// Flakes of the Badlands' Stonevault, the Kor Gem the Blackfathom ruins'
	// priestesses drop. Nor does a stray drop: one only Wowhead's lists
	// record, under 5% (QuestieDB and pfQuest hold the quest drops), such as
	// a boss's trade good: the Nexus Crystal in Blackwing Lair (The Dread
	// Citadel), the Greater Eternal Essence from Gri'lek and Maexxna (The
	// Ectoplasmic Distiller), the Copper Modulator from Sneed's Shredder.
	const STRAY = 5;
	const stray = (s) => Array.isArray(s.from) && s.from.length > 0 && s.from.every((f) => f === 'wowhead') && typeof s.chance === 'number' && s.chance < STRAY;
	const npcInstance = {};
	for (const [id, n] of Object.entries(npcs)) if (n.instance) npcInstance[id] = n.instance;
	const itemInstances = {};
	const itemLinks = {}; // itemInstances without stray drops: what ties an objective
	const itemObjectInstances = {};
	const outside = new Set();
	const dropNpcs = {};
	for (const [id, it] of Object.entries(items)) {
		let out = 0;
		for (const s of it.sources || []) {
			if (s.type === 'drop') {
				(dropNpcs[id] = dropNpcs[id] || new Set()).add(s.npc);
				const key = s.instance || npcInstance[s.npc];
				if (key) {
					(itemInstances[id] = itemInstances[id] || new Set()).add(key);
					if (!stray(s)) (itemLinks[id] = itemLinks[id] || new Set()).add(key);
				} else out++;
			} else if (s.type === 'object') {
				const maps = (fv.objects && fv.objects[s.object] && fv.objects[s.object].instances) || [];
				if (!maps.length) out++;
				if (maps.length !== 1) continue;
				for (const k of mapKeys[maps[0]] || []) (itemObjectInstances[id] = itemObjectInstances[id] || new Set()).add(k);
			} else if (s.type === 'vendor' || s.type === 'craft') out++;
		}
		if (out) outside.add(id);
	}
	const startItemKeys = (q) => {
		const keys = new Set();
		for (const it of (q.start && q.start.item) || []) for (const k of [...(itemInstances[it] || []), ...(itemObjectInstances[it] || [])]) keys.add(k);
		return keys;
	};
	const linked = (q) => {
		const keys = startItemKeys(q);
		for (const o of q.objectives || []) {
			if (o.type === 'kill' && npcInstance[o.id]) keys.add(npcInstance[o.id]);
			if (o.type === 'item' && itemLinks[o.id] && !outside.has(String(o.id))) for (const k of itemLinks[o.id]) keys.add(k);
		}
		return keys;
	};
	// In the game: QuestieDB's Forever store or a recording knows it (Wowhead's
	// lists also carry datamined quests that are not: <UNUSED>, <NYI>, the
	// Classic Attunement to the Core 7487 that 7848 replaced).
	const live = (id) => ((fq[id] && fq[id].source) || []).some((s) => /^questie|^recorder/.test(s));

	// How many of a reward item Wowhead's list row gives (quests.json `wowhead`).
	const countIn = (id, list, it) => ((((fq[id] && fq[id].wowhead) || {})[list] || []).find((p) => p[0] === it) || [])[1];
	// A quest from the Codex (and quests.json) alone.
	const codexQuest = (id) => {
		const q = cq[id];
		const f = fq[id] || {};
		if (!q && !f.title) return null;
		const src = q || f;
		const s = src.start || {};
		const e = src.end || {};
		const start = placeOf('npc', (s.npc || [])[0], codex) || placeOf('object', (s.object || [])[0], codex);
		const startItem = (s.item || [])[0] ? { id: s.item[0], name: names.item(s.item[0]) } : null;
		const wh = f.wowhead || {};
		const faction = SIDE[src.faction] || null;
		return {
			id: Number(id),
			title: src.title || null,
			level: src.level ?? null,
			minLevel: src.minLevel ?? null,
			faction,
			classes: null,
			inside: false,
			shareable: null,
			objectives: objectivesOf(src.objectives, names),
			start: start || (startItem ? { kind: 'item', id: startItem.id, name: startItem.name, map: null, x: null, y: null, f: null, inside: false } : null),
			finish: placeOf('npc', (e.npc || [])[0], codex) || placeOf('object', (e.object || [])[0], codex),
			startItem,
			chain: chainOf(cq, fq, Number(id), faction),
			rewards: {
				items: [
					...(src.rewards || []).map((i) => rewardItem(i, false, codex, null, countIn(id, 'items', i))),
					...(src.choices || []).map((i) => rewardItem(i, true, codex, null, countIn(id, 'choices', i))),
				],
				xp: f.xp ?? null,
				money: (f.rewards && f.rewards.money) ?? (wh.money || null),
				rep: repOf(f, factions),
			},
			bosses: [],
		};
	};
	// A quest from dungeons.json, filled from the Codex where it is silent.
	const djQuest = (q, base) => {
		const c = codexQuest(q.id);
		const rewards = q.rewards || {};
		const out = {
			id: q.id,
			title: (c && c.title) || q.title || null,
			level: (c && c.level) ?? q.level ?? null,
			minLevel: (c && c.minLevel) ?? q.minLevel ?? null,
			faction: SIDE[q.faction] || (c && c.faction) || null,
			classes: q.classes && q.classes.length ? q.classes : null,
			inside: !!(q.start && q.start.inDungeon),
			shareable: typeof q.shareable === 'boolean' ? q.shareable : null,
			objectives: c ? c.objectives : null,
			start: djPlace(q.start) || (c && c.start),
			finish: djPlace(q.end) || (c && c.finish),
			startItem: q.startItem ? { id: q.startItem.item, name: q.startItem.name || names.item(q.startItem.item) } : c ? c.startItem : null,
			chain: (q.chain || []).filter((x) => x !== q.id),
			rewards: {
				items: [
					...(rewards.items || []).map((i) => rewardItem(i.item, false, codex, i, countIn(q.id, 'items', i.item))),
					...(rewards.choices || []).map((i) => rewardItem(i.item, true, codex, i, countIn(q.id, 'choices', i.item))),
				],
				xp: q.xp ?? (c && c.rewards.xp) ?? null,
				money: q.money ?? (c && c.rewards.money) ?? null,
				rep: c ? c.rewards.rep : [],
			},
			bosses: base ? q.bosses || [] : [],
		};
		if (!out.rewards.items.length && c) out.rewards.items = c.rewards.items;
		if (base && q.startBoss && !out.bosses.includes(q.startBoss)) out.bosses.push(q.startBoss);
		return out;
	};

	const pages = {};
	const onPage = {};
	for (const key of Object.keys(instances)) onPage[key] = new Map();
	// 1. dungeons.json.
	const djOf = {};
	for (const [key, inst] of Object.entries(instances)) {
		const d = djByKey[key] || djByName[norm(inst.name)];
		if (!d) continue;
		djOf[key] = d;
		for (const q of d.quests || []) if (!q.hidden) onPage[key].set(q.id, djQuest(q, true));
	}
	// 2. Quests filed under the instance's areas (QuestieDB's area, or the
	//    instance Wowhead Forever lists a quest in, for a quest in the game),
	//    narrowed to the wing their objectives point to when wings share an
	//    area, plus the instance their start item drops or lies in (An Unholy
	//    Alliance starts with Charlga Razorflank's scroll in Razorfen Kraul and
	//    is filed under Razorfen Downs); 3. quests whose objectives or start
	//    item point into at most two instances. A quest of a game event
	//    (pfQuest's `event`: the Darkmoon Faire's turn-ins, the holidays, the
	//    war efforts) is on a page only where it is filed (the Cenarion
	//    Circle's Qiraji rings and cloaks under Ahn'Qiraj): an item of it that
	//    drops inside ties it to nothing (Rinling's Copper Modulator, a Faire
	//    ticket turn-in in Mulgore or Elwynn, was on the Deadmines and
	//    Gnomeregan pages in 0.2.3: the modulator drops in both).
	for (const sid of new Set([...Object.keys(cq), ...Object.keys(fq)])) {
		const id = Number(sid);
		const q = cq[id] || fq[id];
		if (!q) continue;
		const f = fq[id] || {};
		const byArea = new Set();
		for (const area of [f.area, live(id) && f.wowhead ? f.wowhead.zone : null]) if (area && areaKeys[area]) for (const k of areaKeys[area]) byArea.add(k);
		const byLink = [...linked(q)];
		let keys = [...byArea];
		if (keys.length > 1) {
			const narrowed = keys.filter((k) => byLink.includes(k));
			if (narrowed.length) keys = narrowed;
		}
		const event = !!f.event;
		const byStart = event ? [] : [...startItemKeys(q)];
		if (keys.length && byStart.length <= 2) for (const k of byStart) if (!keys.includes(k)) keys.push(k);
		if (!keys.length && !event) keys = byLink.length <= 2 ? byLink : [];
		for (const key of keys) {
			if (onPage[key].has(id)) continue;
			const rec = codexQuest(id);
			if (rec) onPage[key].set(id, rec);
		}
	}
	// 3b. The cited table's quests (tools/lib/codex/journal-quests.json): what
	//     no rule places (Shards of the Felvine: Moonglade giver, an item made
	//     from Alzzin's Felvine in Dire Maul). A row of an instance this build
	//     lacks is skipped; one whose quest it lacks is a warning.
	for (const r of inputs.journalQuests || loadJournalQuests()) {
		if (!onPage[r.instance]) continue;
		const rec = codexQuest(r.quest);
		if (!rec) warnings.push(`journal-quests.json: quest ${r.quest} is not in the Codex`);
		else if (!onPage[r.instance].has(r.quest)) onPage[r.instance].set(r.quest, rec);
	}
	// 4. The rest of a page quest's story: a follow-up of the same name with no
	//    objectives of its own, taken where that quest is turned in (Hidden
	//    Enemies: Thrall sends you to Neeru Fireblade, who sends you back to
	//    him), in the game and for the same side.
	const sameTitle = (a, b) => !!a && !!b && norm(a) === norm(b);
	const followers = {};
	for (const sid of Object.keys(fq)) {
		const f = fq[sid];
		const c = cq[sid] || {};
		for (const pre of new Set([...(c.pre || []), ...(f.pre || []), ...(f.preAll || []), ...(c.preAny || []), ...(f.preAny || [])])) (followers[pre] = followers[pre] || []).push(Number(sid));
	}
	for (const key of Object.keys(onPage)) {
		for (let round = 0; round < 3; round++) {
			let added = 0;
			for (const p of [...onPage[key].values()]) {
				const pe = (cq[p.id] || fq[p.id] || {}).end || {};
				for (const id of followers[p.id] || []) {
					if (onPage[key].has(id) || !live(id)) continue;
					const q = cq[id] || fq[id];
					if (!q || !sameTitle(q.title, p.title) || (q.objectives || []).length) continue;
					const side = SIDE[q.faction] || null;
					if (side && p.faction && side !== p.faction) continue;
					const qs = q.start || {};
					const at = (qs.npc || []).some((n) => (pe.npc || []).includes(n)) || (qs.object || []).some((o) => (pe.object || []).includes(o));
					if (!at) continue;
					const rec = codexQuest(id);
					if (rec) {
						onPage[key].set(id, rec);
						added++;
					}
				}
			}
			if (!added) break;
		}
	}

	for (const key of Object.keys(instances).sort()) {
		const inst = instances[key];
		const m = mapOf[key];
		const d = djOf[key];
		let entrance = inst.entrance ? { map: inst.entrance.map, x: inst.entrance.x, y: inst.entrance.y, f: inst.entrance.f || null } : null;
		if (!entrance && m && m.corpse) {
			const prefer = Object.values(fv.zones || {}).filter((z) => z.areaId && m.zones.includes(z.areaId)).map((z) => z.id);
			entrance = zonePoint(frames, m.corpse.c, m.corpse.x, m.corpse.y, prefer);
		}
		const quests = [...onPage[key].values()].sort((a, b) => (a.level || 0) - (b.level || 0) || a.id - b.id);
		// Chain quests not on the page itself.
		const chain = {};
		const djChain = (d && d.chainQuests) || {};
		for (const q of quests) {
			for (const cid of q.chain) {
				if (onPage[key].has(cid) || chain[cid]) continue;
				const rec = djChain[cid] ? djQuest(djChain[cid], false) : codexQuest(cid);
				if (rec) {
					rec.chain = [];
					chain[cid] = rec;
				}
			}
		}
		// Bosses in kill order, with the quests tied to each. A chest boss
		// (object) ties the quests whose item it holds; role marks the bosses
		// after the encounters (rare, event, optional); encounter is the
		// DungeonEncounter id (DungeonJournal's bosses take the one of the
		// Codex boss of the same name).
		const encounterOf = {};
		for (const b of inst.bosses || []) if (b.encounter && b.name) encounterOf[norm(b.name)] = b.encounter;
		const bossList = d
			? (d.bosses || []).map((b) => ({ name: b.name, npc: b.npc ?? null, level: b.level ?? null, encounter: encounterOf[norm(b.name)] || null }))
			: (inst.bosses || [])
					.filter((b) => b.name && b.name !== 'Trash')
					.map((b) => ({ name: b.name, npc: b.npc ?? null, object: b.object ?? null, role: b.role ?? null, encounter: b.encounter ?? null, items: b.items || [], level: (npcs[b.npc] && npcs[b.npc].level) || null }));
		const bosses = bossList.map((b, i) => {
			const tied = [];
			const add = (id, how, item) => {
				if (tied.some((t) => t.id === id && t.how === how && t.item === item)) return;
				const t = { id, how };
				if (item) {
					t.item = item;
					t.itemName = names.item(item);
				}
				tied.push(t);
			};
			for (const q of quests) {
				const src = cq[q.id] || fq[q.id] || {};
				for (const o of src.objectives || []) {
					if (o.type === 'kill' && b.npc && o.id === b.npc) add(q.id, 'kill');
					if (o.type === 'item' && b.npc && dropNpcs[o.id] && dropNpcs[o.id].has(b.npc)) add(q.id, 'item', o.id);
					if (o.type === 'item' && b.object && b.items.includes(o.id)) add(q.id, 'item', o.id);
				}
				if (q.startItem && b.npc && dropNpcs[q.startItem.id] && dropNpcs[q.startItem.id].has(b.npc)) add(q.id, 'starts', q.startItem.id);
				if (q.startItem && b.object && b.items.includes(q.startItem.id)) add(q.id, 'starts', q.startItem.id);
				if (q.bosses.includes(b.name) && !tied.some((t) => t.id === q.id)) add(q.id, 'involved');
			}
			const page = { order: i + 1, name: b.name, npc: b.npc, level: b.level, quests: tied };
			if (b.object) page.object = b.object;
			if (b.role) page.role = b.role;
			if (b.encounter) page.encounter = b.encounter;
			return page;
		});
		const lv = inst.levels;
		const zone = entrance ? entrance.map : null;
		pages[key] = {
			key,
			name: inst.name || key,
			map: inst.map ?? (m && m.id) ?? null,
			kind: inst.kind === 'raid' || (m && m.raid) ? 'raid' : 'dungeon',
			forever: !!inst.forever,
			minLevel: lv ? (lv[1] ?? lv[0]) : null,
			maxLevel: lv ? (lv[2] ?? lv[1] ?? lv[0]) : null,
			players: (m && m.players) || null,
			zone,
			zoneName: zone && zones[zone] ? zones[zone].name : null,
			entrance,
			quests,
			chain,
			bosses,
		};
	}
	return pages;
}

// The cited table of journal quests no rule places
// (tools/lib/codex/journal-quests.json) -> [{ quest, instance, source, note }].
// A malformed row throws.
function loadJournalQuests(file = path.join(__dirname, 'journal-quests.json')) {
	if (!fs.existsSync(file)) return [];
	const rows = JSON.parse(fs.readFileSync(file, 'utf8')).quests || [];
	for (const r of rows) {
		if (!Number.isInteger(r.quest) || typeof r.instance !== 'string' || !/^https?:\/\//.test(r.source || '')) throw new Error(`journal-quests.json: bad row ${JSON.stringify(r)}`);
	}
	return rows;
}

function matchMap(inst, maps) {
	const n = norm(inst.name);
	const k = norm(inst.key);
	let m = maps.find((x) => norm(x.name) === n || norm(x.name) === k);
	if (!m && inst.areaId) m = maps.find((x) => x.area === inst.areaId);
	// Wings: "Scarlet Monastery Armory" in "Scarlet Monastery".
	if (!m) m = maps.find((x) => norm(x.name).length > 6 && n.startsWith(norm(x.name)));
	return m || null;
}

function buildJournal(inputs = {}, codex = {}) {
	const pageWarnings = [];
	const dungeons = buildPages(inputs, codex, pageWarnings);
	const { attunementsOf } = require('./attunements');
	const att = attunementsOf(codex, { table: inputs.attunementTable });
	let attunements = 0;
	for (const [key, list] of Object.entries(att.byKey)) {
		if (!dungeons[key]) continue;
		dungeons[key].attunement = list;
		attunements += list.length;
	}
	let quests = 0;
	let entrances = 0;
	for (const p of Object.values(dungeons)) {
		quests += p.quests.length;
		if (p.entrance) entrances++;
	}
	const meta = { schema: SCHEMA, counts: { dungeons: Object.keys(dungeons).length, quests, entrances, attunements } };
	// warnings: the attunement table's goals and the journal-quests table's rows the Codex lacks (codex build reports them).
	return { meta, dungeons, warnings: [...pageWarnings, ...att.warnings] };
}

// ---------------------------------------------------------------------------
// Pack file
// ---------------------------------------------------------------------------
// Dungeons1.lua registers, per dungeon, a small summary table (for the list,
// read without decoding anything) and its page as Lua source in a string,
// compiled by Dungeons.lua only when that page is opened.

function luaStr(s) {
	return `"${String(s).replace(/\\/g, '\\\\').replace(/"/g, '\\"').replace(/\n/g, '\\n').replace(/\r/g, '\\r')}"`;
}
function luaKey(k) {
	return /^[A-Za-z_][A-Za-z0-9_]*$/.test(k) ? k : `[${/^\d+$/.test(String(k)) ? k : luaStr(k)}]`;
}
// JSON-shaped value -> Lua constructor (nulls dropped).
function lua(v) {
	if (v === null || v === undefined) return 'nil';
	if (typeof v === 'boolean') return v ? 'true' : 'false';
	if (typeof v === 'number') return String(v);
	if (typeof v === 'string') return luaStr(v);
	if (Array.isArray(v)) return `{${v.map(lua).join(',')}}`;
	const parts = [];
	for (const [k, x] of Object.entries(v)) if (x !== null && x !== undefined) parts.push(`${luaKey(k)}=${lua(x)}`);
	return `{${parts.join(',')}}`;
}

function summaryOf(p) {
	const count = (side) => p.quests.filter((q) => !q.faction || q.faction === side).length;
	return {
		name: p.name,
		map: p.map,
		kind: p.kind,
		forever: p.forever || null,
		minLevel: p.minLevel,
		maxLevel: p.maxLevel,
		players: p.players,
		zone: p.zone,
		zoneName: p.zoneName,
		entrance: p.entrance,
		quests: { A: count('A'), H: count('H') },
		bosses: p.bosses.length,
		attune: p.attunement && p.attunement.length ? { A: p.attunement.filter((a) => a.faction !== 'H').length, H: p.attunement.filter((a) => a.faction !== 'A').length } : null,
	};
}

const HEADER = [
	header('lua', 'codex build', 'the sources listed in Meta.lua (tools/lib/codex/journal.js)'),
	'-- Dungeon facts (ids, names, levels, coordinates, amounts). Read by',
	'-- Polestar/Dungeons/Dungeons.lua; each page compiles when opened.',
	'',
	'local D = Polestar and Polestar.Dungeons',
	'if not (D and D.Register) then return end',
	'',
];

function emitJournal(journal) {
	const lines = [...HEADER];
	const meta = journal.meta || { schema: SCHEMA, counts: {} };
	lines.push(`D.Register("meta", ${lua(meta)})`, '');
	const keys = Object.keys(journal.dungeons || {}).sort();
	lines.push('D.Register("dungeon", {');
	for (const k of keys) lines.push(`${luaKey(k)}=${lua(summaryOf(journal.dungeons[k]))},`);
	lines.push('}, {');
	for (const k of keys) {
		const p = journal.dungeons[k];
		const page = { entrance: p.entrance, quests: p.quests, chain: p.chain, bosses: p.bosses, attunement: p.attunement };
		lines.push(`${luaKey(k)}=${luaStr(`return ${lua(page)}`)},`);
	}
	lines.push('})', '');
	return [{ name: 'Dungeons1.lua', text: lines.join('\n') }];
}

module.exports = { instanceMapsOf, zonePoint, chainOf, objectivesOf, buildJournal, emitJournal, loadJournalQuests, SCHEMA };
