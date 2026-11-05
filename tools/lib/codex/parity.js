'use strict';
// Parity of the release Codex ("ours", release-safe inputs) with the internal
// one ("theirs", `forge data codex --local-extras`: AtlasLoot, RareScanner,
// DungeonJournal on top of the same data), entity by entity. Both are the
// data/forever/codex JSON shape (docs/ARCHITECTURE.md, "Codex").
//
//   compareCodex(ours, theirs)  -> report (below)
//   readCodex(dir)              -> the JSON files of one build
//   summary(report)             -> { kind: { total, match, share } } (meta.parity)
//   markdown(report)            -> the human report (data/local/codex-parity.md)
//
// report = { kinds: { <kind>: { total, match, share, missing: [Row], different: [Row] } },
//            instanceMap: { theirKey: ourKey }, needsRecording: [ { kind, id, name, what, event } ] }
// Row = { id, name, field?, theirs?, ours?, reason? }. A difference whose
// value ours takes from a better-evidenced input (the Forever client, a
// recording) carries `reason` and counts as a match ("ours differs, reason").
// A confirmed missing drop or loot row that ours knows but a cap leaves out
// (`ours.evidence.cut`, a release build's) carries `reason` too and counts in
// `internalOnly.cut` (still a confirmed gap: the fact is real, not shipped).
//
// Kinds: instances (present), instance levels, instance entrances, bosses
// (present in the mapped instance), bosses with loot, boss loot items, drop
// chances (same item and npc on both sides; equal within 25% relative or 1
// point, else different: a match only when ours comes from recordings,
// QuestieDB's Forever rates or Forever's looted-kill counts), rares (present), rare positions,
// rare levels, rare loot, treasures, treasure positions, treasure loot,
// items with a source, items per source type, mounts / pets / tabards
// (present, kind, sources, status), journal quests (on the page), quest
// giver / ender positions, chains, quest rewards, quest XP.

const fs = require('node:fs');
const path = require('node:path');

const FILES = ['meta', 'items', 'npcs', 'objects', 'quests', 'instances', 'journal'];
const POS_TOLERANCE = 3; // map percent
const LEVEL_TOLERANCE = 2;
const CHANCE_TOLERANCE = 0.25; // relative
const SOURCE_TYPES = ['drop', 'vendor', 'quest', 'gift', 'craft', 'rep', 'pvp', 'container', 'object', 'world'];
const LIST_CAP = 400; // rows kept per list in the JSON (counts stay exact)

const norm = (s) =>
	String(s || '')
		.normalize('NFKD')
		.replace(/[\u0300-\u036f]/g, '')
		.toLowerCase()
		.replace(/^the\s+/, '')
		.replace(/[^a-z0-9]/g, '');

function readCodex(dir) {
	const out = {};
	for (const f of FILES) {
		const file = path.join(dir, `${f}.json`);
		out[f] = fs.existsSync(file) ? JSON.parse(fs.readFileSync(file, 'utf8')) : {};
	}
	return out;
}

function kind() {
	return { total: 0, match: 0, missing: [], different: [] };
}

function near(a, b, tol = POS_TOLERANCE) {
	return a && b && Number(a.map) === Number(b.map) && Math.hypot(Number(a.x) - Number(b.x), Number(a.y) - Number(b.y)) <= tol;
}

// Their instance key -> ours: the same area, the same name, or theirs a wing
// of ours (Dire Maul - East in Dire Maul) or a renamed one.
const ALIASES = {
	stockade: 'stormwind-stockade',
	onyxia: 'onyxias-lair',
	'the-temple-of-atalhakkar': 'sunken-temple',
	'the-ruinsof-ahn-qiraj': 'ruins-of-ahnqiraj',
	'the-templeof-ahn-qiraj': 'ahnqiraj-temple',
	'lower-blackrock-spire': 'blackrock-spire',
	'upper-blackrock-spire': 'blackrock-spire',
	'hall-of-thanes': 'the-hall-of-thanes',
};
function mapInstances(ours, theirs) {
	const map = {};
	const byArea = {};
	const byName = {};
	for (const [k, i] of Object.entries(ours)) {
		if (i.areaId) byArea[i.areaId] = k;
		byName[norm(i.name)] = k;
	}
	for (const [k, i] of Object.entries(theirs)) {
		let o = ALIASES[k] && ours[ALIASES[k]] ? ALIASES[k] : null;
		if (!o && ours[k]) o = k;
		if (!o && byName[norm(i.name)]) o = byName[norm(i.name)];
		if (!o && i.areaId && byArea[i.areaId]) o = byArea[i.areaId];
		if (!o) {
			const n = norm(i.name);
			const hit = Object.entries(byName).filter(([on]) => on.length >= 6 && n.startsWith(on));
			if (hit.length === 1) o = hit[0][1];
		}
		map[k] = o || null;
	}
	return map;
}

function bossKey(b) {
	return b.npc ? `n${b.npc}` : `s${norm(b.name)}`;
}

// Evidence for a disagreement, strongest first: recordings > the Forever
// client's tables > Forever's data > pfQuest / QuestieDB > AtlasLoot /
// RareScanner / DungeonJournal. `verify` = { web: loadWeb(),
// clientInstances: Set(normalised Map names), instanceAreas: Set(AreaTable
// ids on instance maps) | null } checks each internal-only
// entity or value: `confirmed` (Forever has it: a gap of ours), `not in
// Forever` (the internal build is wrong or ahead of the game), `unverified`
// (no checked source says either way).
function verdictOf(kindName, row, verify, theirs) {
	if (!verify) return 'unverified';
	const wh = verify.web || { npc: {}, object: {}, item: {} };
	const [a, b, c] = String(row.id).split('/');
	if (kindName === 'instances') return verify.clientInstances && verify.clientInstances.has(norm((theirs.instances[a] || {}).name)) ? 'confirmed' : 'not in Forever';
	if (['rares', 'rare positions', 'rare levels'].includes(kindName)) {
		const w = wh.npc[a];
		if (!w) return 'unverified';
		if (kindName === 'rares') return w.classification === 'rare' || w.classification === 'rareelite' ? 'confirmed' : 'not in Forever';
		return Object.keys(w.spawns || {}).length ? 'confirmed' : 'not in Forever';
	}
	if (kindName === 'bosses') {
		const w = wh.npc[b];
		if (!w) return 'unverified';
		return w.drops.length || Object.keys(w.spawns || {}).length || w.classification ? 'confirmed' : 'not in Forever';
	}
	const dropCheck = (npc, item) => {
		const w = wh.npc[npc];
		if (!w) return 'unverified';
		return w.drops.some((d) => d.item === Number(item)) ? 'confirmed' : 'not in Forever';
	};
	if (kindName === 'boss loot items') return dropCheck(b, c);
	if (kindName === 'rare loot') return dropCheck(a, b);
	if (kindName === 'drop chances') return dropCheck(b, a);
	if (kindName === 'items: rep') {
		// A standing on the tooltip confirms; none proves nothing (a vendor's
		// or a quest's gate is on no tooltip, and Forever's Sells standing is
		// the same ItemSparse MinReputation).
		const t = wh.item[a];
		if (!t) return 'unverified';
		return (t.rep || []).length ? 'confirmed' : 'unverified';
	}
	if (kindName === 'items: pvp') {
		const t = wh.item[a];
		if (!t) return 'unverified';
		return t.pvpRank ? 'confirmed' : 'not in Forever';
	}
	if (kindName === 'treasure loot') {
		const w = wh.object[a];
		if (!w) return 'unverified';
		return w.drops.some((d) => d.item === Number(b)) ? 'confirmed' : 'not in Forever';
	}
	return 'unverified';
}

function compareCodex(ours, theirs, verify = null) {
	const K = {};
	const k = (name) => (K[name] = K[name] || kind());
	const needs = [];
	const oi = ours.instances || {};
	const ti = theirs.instances || {};
	const instanceMap = mapInstances(oi, ti);
	const oItems = ours.items || {};
	const tItems = theirs.items || {};
	const oNpcs = ours.npcs || {};
	const noPvp = new Set(((ours.evidence || {}).noPvp || []).map(Number));
	const tNpcs = theirs.npcs || {};

	// ----- instances
	for (const [key, t] of Object.entries(ti)) {
		const ok = instanceMap[key];
		const o = ok && oi[ok];
		const row = { id: key, name: t.name };
		k('instances').total++;
		if (!o) {
			k('instances').missing.push(row);
			if (t.forever) needs.push({ kind: 'instance', id: key, name: t.name, what: 'the instance (not in the Forever client tables Polestar reads)', event: 'enter, encounter' });
			continue;
		}
		k('instances').match++;
		if (t.levels) {
			k('instance levels').total++;
			const same = o.levels && t.levels.every((v, i) => v == null || (o.levels[i] != null && Math.abs(o.levels[i] - v) <= LEVEL_TOLERANCE));
			if (same) k('instance levels').match++;
			else if (o.levels) {
				k('instance levels').match++;
				k('instance levels').different.push({ ...row, theirs: t.levels, ours: o.levels, reason: 'Forever client: MapDifficulty entry level, ContentTuning minimum, highest boss level' });
			} else k('instance levels').missing.push(row);
		}
		if (t.entrance) {
			k('instance entrances').total++;
			// A corpse point (where a ghost returns) is no entrance: a different place is a difference.
			if (near(o.entrance, t.entrance)) k('instance entrances').match++;
			else if (o.entrance) k('instance entrances').different.push({ ...row, theirs: t.entrance, ours: o.entrance });
			else {
				k('instance entrances').missing.push(row);
				if (o.forever) needs.push({ kind: 'entrance', id: key, name: t.name, what: 'the entrance (no corpse point in the client for Forever instances)', event: 'enter' });
			}
		}
		// Bosses: by npc, else by name (a chest boss by its object's name too).
		const ob = new Map();
		for (const b of o.bosses || []) {
			ob.set(bossKey(b), b);
			ob.set(`s${norm(b.name)}`, b);
			const chest = b.object && (ours.objects || {})[b.object];
			if (chest && chest.name && !ob.has(`s${norm(chest.name)}`)) ob.set(`s${norm(chest.name)}`, b);
		}
		for (const b of t.bosses || []) {
			if (!b.name || norm(b.name) === 'trash') continue;
			const brow = { id: `${key}/${b.npc || norm(b.name)}`, name: `${b.name} (${t.name})` };
			k('bosses').total++;
			const mine = ob.get(bossKey(b)) || ob.get(`s${norm(b.name)}`);
			if (!mine) {
				k('bosses').missing.push(brow);
				continue;
			}
			k('bosses').match++;
			if ((b.items || []).length) {
				k('bosses with loot').total++;
				if ((mine.items || []).length) k('bosses with loot').match++;
				else {
					k('bosses with loot').missing.push(brow);
					if (o.forever) needs.push({ kind: 'boss loot', id: brow.id, name: brow.name, what: 'boss loot in a Forever instance', event: 'slain + drop (inst)' });
				}
				const have = new Set(mine.items || []);
				for (const it of b.items) {
					k('boss loot items').total++;
					if (have.has(it)) k('boss loot items').match++;
					else k('boss loot items').missing.push({ id: `${brow.id}/${it}`, name: `${(tItems[it] && tItems[it].name) || it} from ${b.name}` });
				}
			}
		}
	}

	// ----- drop chances: the same (item, npc) drop on both sides
	for (const [id, t] of Object.entries(tItems)) {
		const o = oItems[id];
		for (const s of t.sources || []) {
			if (s.type !== 'drop' || s.chance == null) continue;
			k('drop chances').total++;
			const mine = o && (o.sources || []).find((x) => x.type === 'drop' && x.npc === s.npc);
			const row = { id: `${id}/${s.npc}`, name: `${t.name} from ${(tNpcs[s.npc] && tNpcs[s.npc].name) || s.npc}` };
			if (!mine || mine.chance == null) {
				k('drop chances').missing.push(row);
				continue;
			}
			// Within CHANCE_TOLERANCE (relative) or 1 point: the same chance.
			const gap = Math.abs(mine.chance - s.chance);
			if (gap === 0) {
				k('drop chances').match++;
				continue;
			}
			if (gap <= 1 || gap <= CHANCE_TOLERANCE * Math.max(mine.chance, s.chance)) {
				k('drop chances').match++;
				k('drop chances').withinTolerance = (k('drop chances').withinTolerance || 0) + 1;
				continue;
			}
			const from = mine.from || [];
			const reason = from.includes('recordings')
				? 'recorded kills and loot'
				: from.includes('questie')
					? 'QuestieDB Forever drop rate'
					: from[0] === 'web'
						? "the web quest database's Forever looted-kill counts"
						: null;
			if (reason) k('drop chances').match++;
			k('drop chances').different.push({ ...row, theirs: s.chance, ours: mine.chance, reason });
		}
	}

	// ----- rares and treasures
	const spot = (list, spawns) => (spawns || []).some((s) => list.some((x) => near(x, s, 5)));
	for (const [id, t] of Object.entries(tNpcs)) {
		if (!t.rare) continue;
		const o = oNpcs[id];
		const row = { id: Number(id), name: t.name };
		k('rares').total++;
		if (!o || !o.rare) {
			k('rares').missing.push({ ...row, ours: o ? 'not rare' : 'absent' });
			needs.push({ kind: 'rare', id: Number(id), name: t.name, what: 'rank, spawns and loot of a rare our data does not rank', event: 'rare, slain + drop' });
			continue;
		}
		k('rares').match++;
		if ((t.spawns || []).length) {
			k('rare positions').total++;
			if (spot(o.spawns || [], t.spawns)) k('rare positions').match++;
			else if ((o.spawns || []).length) k('rare positions').different.push({ ...row, theirs: t.spawns[0], ours: o.spawns[0] });
			else {
				k('rare positions').missing.push(row);
				needs.push({ kind: 'rare position', id: Number(id), name: t.name, what: "the rare's spawn points", event: 'rare' });
			}
		}
		if (t.level) {
			k('rare levels').total++;
			if (o.level && Math.abs(o.level - t.level) <= LEVEL_TOLERANCE) k('rare levels').match++;
			else if (o.level) k('rare levels').different.push({ ...row, theirs: t.level, ours: o.level });
			else k('rare levels').missing.push(row);
		}
		for (const it of t.loot || []) {
			k('rare loot').total++;
			if ((o.loot || []).includes(it)) k('rare loot').match++;
			else k('rare loot').missing.push({ id: `${id}/${it}`, name: `${(tItems[it] && tItems[it].name) || it} from ${t.name}` });
		}
	}
	const oObj = ours.objects || {};
	for (const [id, t] of Object.entries(theirs.objects || {})) {
		if (!t.treasure) continue;
		const o = oObj[id];
		const row = { id: Number(id), name: t.name };
		k('treasures').total++;
		if (!o || !o.treasure) {
			k('treasures').missing.push(row);
			needs.push({ kind: 'treasure', id: Number(id), name: t.name, what: 'a treasure our data does not mark as a chest', event: 'drop (object)' });
			continue;
		}
		k('treasures').match++;
		if ((t.spawns || []).length) {
			k('treasure positions').total++;
			if (spot(o.spawns || [], t.spawns)) k('treasure positions').match++;
			else k('treasure positions').missing.push(row);
		}
		for (const it of t.loot || []) {
			k('treasure loot').total++;
			if ((o.loot || []).includes(it)) k('treasure loot').match++;
			else k('treasure loot').missing.push({ id: `${id}/${it}`, name: `${(tItems[it] && tItems[it].name) || it} from ${t.name}` });
		}
	}

	// ----- items: with a source, per source type; collectibles
	for (const [id, t] of Object.entries(tItems)) {
		const o = oItems[id];
		const row = { id: Number(id), name: t.name };
		const types = new Set((t.sources || []).map((s) => s.type));
		const mine = new Set(((o && o.sources) || []).map((s) => s.type));
		if (types.size) {
			k('items with a source').total++;
			if (mine.size) k('items with a source').match++;
			else k('items with a source').missing.push(row);
		}
		for (const ty of SOURCE_TYPES) {
			if (!types.has(ty)) continue;
			k(`items: ${ty}`).total++;
			if (mine.has(ty)) k(`items: ${ty}`).match++;
			else if (ty === 'pvp' && noPvp.has(Number(id))) {
				// Forever's own tooltip asks for no rank: ours keeps the vendor only.
				k(`items: ${ty}`).match++;
				k(`items: ${ty}`).different.push({ ...row, theirs: ty, ours: [...mine], reason: "the web quest database's Forever tooltip shows no PvP rank requirement" });
			} else k(`items: ${ty}`).missing.push(row);
		}
		if (['mount', 'pet', 'tabard'].includes(t.kind)) {
			const c = k(`${t.kind}s`);
			c.total++;
			if (!o) c.missing.push(row);
			else if (o.kind !== t.kind) c.different.push({ ...row, field: 'kind', theirs: t.kind, ours: o.kind });
			else {
				c.match++;
				if ((t.status || null) !== (o.status || null)) {
					const reason = t.kind === 'mount' && o.status === 'retired' ? "Forever client: the Mount row is hidden until known, and only Era vendors list it" : null;
					c.different.push({ ...row, field: 'status', theirs: t.status || null, ours: o.status || null, reason });
				}
				// A pvp source Forever's tooltip does not ask for is no gap (a
				// reputation gate sits on the vendor or quest: no tooltip disproves it).
				const lack = [...types].filter((ty) => !mine.has(ty) && !(ty === 'pvp' && noPvp.has(Number(id))));
				if (lack.length) c.different.push({ ...row, field: 'sources', theirs: [...types], ours: [...mine] });
			}
		}
	}

	// ----- journal quests
	const tPages = ((theirs.journal || {}).dungeons) || {};
	const oPages = ((ours.journal || {}).dungeons) || {};
	for (const [key, page] of Object.entries(tPages)) {
		const ok = instanceMap[key];
		const mine = ok && oPages[ok];
		const qs = new Map(((mine && mine.quests) || []).map((q) => [q.id, q]));
		for (const q of page.quests || []) {
			const row = { id: `${key}/${q.id}`, name: `${q.title} (${page.name})` };
			k('journal quests').total++;
			const o = qs.get(q.id);
			if (!o) {
				k('journal quests').missing.push(row);
				continue;
			}
			k('journal quests').match++;
			for (const [field, label] of [['start', 'quest givers'], ['finish', 'quest enders']]) {
				if (!q[field] || q[field].x == null) continue;
				k(label).total++;
				if (o[field] && near(o[field], q[field])) k(label).match++;
				else if (o[field] && o[field].x != null) {
					// Ours places them from npcs.json/objects.json (QuestieDB, recordings).
					k(label).match++;
					k(label).different.push({ ...row, theirs: q[field], ours: o[field], reason: (q[field].inside ? 'inside the instance: ours gives the place outside' : 'QuestieDB / recorded spawn') });
				} else {
					k(label).missing.push(row);
					needs.push({ kind: field === 'start' ? 'quest giver' : 'quest ender', id: q.id, name: q.title, what: `where the quest ${field === 'start' ? 'starts' : 'ends'}`, event: field === 'start' ? 'accept' : 'turnin' });
				}
			}
			if ((q.chain || []).length) {
				k('quest chains').total++;
				const a = (q.chain || []).join(',');
				const b = (o.chain || []).join(',');
				if (a === b) k('quest chains').match++;
				else if ((o.chain || []).length) k('quest chains').different.push({ ...row, theirs: q.chain, ours: o.chain });
				else k('quest chains').missing.push(row);
			}
			const ti2 = ((q.rewards && q.rewards.items) || []).map((i) => i.id).sort();
			if (ti2.length) {
				k('quest rewards').total++;
				const oi2 = ((o.rewards && o.rewards.items) || []).map((i) => i.id).sort();
				if (ti2.join() === oi2.join()) k('quest rewards').match++;
				else if (oi2.length) k('quest rewards').different.push({ ...row, theirs: ti2, ours: oi2 });
				else {
					k('quest rewards').missing.push(row);
					needs.push({ kind: 'quest rewards', id: q.id, name: q.title, what: 'the items the quest gives or offers', event: 'turnin (items, choices)' });
				}
			}
			if (q.rewards && q.rewards.xp) {
				k('quest XP').total++;
				const ox = o.rewards && o.rewards.xp;
				if (ox === q.rewards.xp) k('quest XP').match++;
				else if (ox) k('quest XP').different.push({ ...row, theirs: q.rewards.xp, ours: ox, reason: 'QuestieDB / web quest database XP' });
				else {
					k('quest XP').missing.push(row);
					needs.push({ kind: 'quest XP', id: q.id, name: q.title, what: 'the XP the quest gives', event: 'turnin (xpReward)' });
				}
			}
		}
	}

	// Ours only: entities the internal build lacks.
	const oursOnly = {
		instances: Object.keys(oi).filter((key) => !Object.values(instanceMap).includes(key)).length,
		rares: Object.entries(oNpcs).filter(([id, n]) => n.rare && !(tNpcs[id] && tNpcs[id].rare)).length,
		treasures: Object.entries(ours.objects || {}).filter(([id, o]) => o.treasure && !((theirs.objects || {})[id] || {}).treasure).length,
		'items with a source': Object.entries(oItems).filter(([id, it]) => it.sources.length && !((tItems[id] || {}).sources || []).length).length,
		'journal quests': Object.entries((ours.journal || {}).dungeons || {}).reduce((n, [key, p]) => {
			const tkey = Object.keys(instanceMap).find((tk) => instanceMap[tk] === key);
			const tq = new Set(((((theirs.journal || {}).dungeons || {})[tkey] || {}).quests || []).map((q) => q.id));
			return n + p.quests.filter((q) => !tq.has(q.id)).length;
		}, 0),
	};
	for (const [name, n] of Object.entries(oursOnly)) if (K[name]) K[name].oursOnly = n;
	// Each internal-only row: confirmed in Forever (ours lacks it), not in Forever, unverified.
	// A confirmed row ours knows but a cap leaves out (ours.evidence.cut, from
	// the build) carries that reason and counts in internalOnly.cut too.
	// Row id `<a>/<b>`: what the cap cut from a's list (an item's droppers, a rare's or treasure's loot) holds b.
	const cut = (ours.evidence || {}).cut || {};
	const cutBy = { 'drop chances': cut.drop, 'rare loot': cut.rare, 'treasure loot': cut.treasure };
	const CUT_REASON = {
		'drop chances': "cut by a cap: ours keeps an item's likeliest droppers (and its instances' bosses); this one ranks below them",
		'rare loot': "cut by a cap: ours keeps a rare's own drops, then its likeliest; this one ranks below them",
		'treasure loot': "cut by a cap: ours keeps a treasure's own contents, then its likeliest; this one ranks below them",
	};
	for (const [name, c] of Object.entries(K)) {
		c.internalOnly = { confirmed: 0, notInForever: 0, unverified: 0 };
		for (const r of c.missing) {
			r.verdict = verdictOf(name, r, verify, theirs);
			c.internalOnly[r.verdict === 'confirmed' ? 'confirmed' : r.verdict === 'not in Forever' ? 'notInForever' : 'unverified']++;
			if (r.verdict !== 'confirmed' || !cutBy[name]) continue;
			const [a, b] = String(r.id).split('/').map(Number);
			if ((cutBy[name][a] || []).includes(b)) {
				r.reason = CUT_REASON[name];
				c.internalOnly.cut = (c.internalOnly.cut || 0) + 1;
			}
		}
	}
	// A confirmed missing boss (Forever has the NPC) that Forever's sources do
	// not make a boss of this instance says why: Forever's NPC data (or ours)
	// places it outside every instance (verify.instanceAreas: the AreaTable
	// areas on instance maps), or ranks it an ordinary NPC (no boss flag, not
	// rare) without loot of its own. Still a confirmed row; counted in
	// internalOnly.notBoss.
	const wh = (verify && verify.web && verify.web.npc) || {};
	const areas = (verify && verify.instanceAreas) || null;
	for (const r of (K.bosses && K.bosses.missing) || []) {
		const npc = Number(String(r.id).split('/')[1]);
		const w = wh[npc];
		if (r.verdict !== 'confirmed' || !w) continue;
		const loc = w.location || [];
		const maps = [...new Set([...Object.keys(w.spawns || {}), ...((oNpcs[npc] && oNpcs[npc].spawns) || []).map((s) => String(s.map))])];
		if (areas && !loc.some((a) => areas.has(a)) && (loc.length || maps.length)) {
			r.reason = `Forever's sources place it outside the instance (${[...loc.map((a) => `area ${a}`), ...maps.map((m) => `map ${m}`)].join(', ')})`;
		} else if (!w.boss && !['boss', 'rare', 'rareelite'].includes(w.classification)) {
			r.reason = `The web quest database's Forever page ranks it an ordinary ${w.classification || 'normal'} NPC (no boss flag, not rare), and no green or better item only it drops at 5% or more`;
		} else continue;
		K.bosses.internalOnly.notBoss = (K.bosses.internalOnly.notBoss || 0) + 1;
	}
	// Differences with a reason count as matches already; the rest are not.
	for (const c of Object.values(K)) {
		c.share = c.total ? Math.round((c.match / c.total) * 1000) / 1000 : 1;
		c.differentCount = c.different.length;
		c.missingCount = c.missing.length;
	}
	const seen = new Set();
	// What Forever does not have is no recording target.
	const notInForever = new Set();
	for (const [name, c] of Object.entries(K)) for (const r of c.missing) if (r.verdict === 'not in Forever') notInForever.add(`${name}|${r.id}`);
	const needsRecording = needs.filter((n) => {
		if (n.kind === 'instance' && notInForever.has(`instances|${n.id}`)) return false;
		if (n.kind === 'rare' && notInForever.has(`rares|${n.id}`)) return false;
		const key = `${n.kind}|${n.id}`;
		return !seen.has(key) && seen.add(key);
	});
	return { kinds: K, instanceMap, needsRecording };
}

function summary(report) {
	const out = {};
	for (const [name, c] of Object.entries(report.kinds)) out[name] = { total: c.total, match: c.match, share: c.share, internalOnly: c.internalOnly, oursOnly: c.oursOnly ?? null };
	return out;
}

function capped(report) {
	const kinds = {};
	for (const [name, c] of Object.entries(report.kinds)) kinds[name] = { ...c, missing: c.missing.slice(0, LIST_CAP), different: c.different.slice(0, LIST_CAP) };
	return { ...report, kinds };
}

function markdown(report, { theirs = 'internal (--local-extras)', ours = 'release' } = {}) {
	const pct = (v) => `${(v * 100).toFixed(1)}%`;
	const lines = ['# Codex parity', '', `Ours: ${ours}. Theirs: ${theirs}. A difference with a reason (ours from a better-evidenced input) counts as a match.`, ''];
	lines.push(
		'Evidence for a disagreement, strongest first: recordings > Forever client tables > the web quest database (Forever) > pfQuest / QuestieDB > AtlasLoot / RareScanner / DungeonJournal. Internal only: confirmed = Forever has it and ours lacks it (a gap); not in Forever = the internal build is wrong or ahead of the game; unverified = no checked source says.',
		'',
		'| Kind | Internal | Agree | Match | Internal only: confirmed | not in Forever | unverified | Ours only | Value differs, unresolved |',
		'|---|---:|---:|---:|---:|---:|---:|---:|---:|',
	);
	for (const [name, c] of Object.entries(report.kinds)) {
		const bad = c.different.filter((d) => !d.reason).length;
		const io = c.internalOnly || { confirmed: 0, notInForever: 0, unverified: 0 };
		lines.push(`| ${name} | ${c.total} | ${c.match} | ${pct(c.share)} | ${io.confirmed} | ${io.notInForever} | ${io.unverified} | ${c.oursOnly ?? ''} | ${bad} |`);
		if (c.withinTolerance) lines.push(`| ${name}: within tolerance | | ${c.withinTolerance} | | | | | | |`);
		if (io.cut) lines.push(`| ${name}: confirmed, cut by a cap | | | | ${io.cut} | | | | |`);
		if (io.notBoss) lines.push(`| ${name}: confirmed, no boss of it in Forever's sources | | | | ${io.notBoss} | | | | |`);
	}
	lines.push('');
	for (const [name, c] of Object.entries(report.kinds)) {
		if (!c.missing.length && !c.different.length) continue;
		lines.push(`## ${name}`, '');
		if (c.missing.length) {
			lines.push(`Missing (${c.missingCount}):`, '');
			const order = { confirmed: 0, unverified: 1, 'not in Forever': 2 };
			for (const r of c.missing.slice().sort((x, y) => (order[x.verdict] ?? 1) - (order[y.verdict] ?? 1)).slice(0, 60)) lines.push(`- ${r.id} ${r.name || ''}${r.ours ? ` (ours: ${r.ours})` : ''} [${r.verdict || 'unverified'}]${r.reason ? ` (${r.reason})` : ''}`);
			if (c.missing.length > 60) lines.push(`- ... ${c.missingCount - 60} more (codex-parity.json)`);
			lines.push('');
		}
		if (c.different.length) {
			lines.push(`Different (${c.differentCount}):`, '');
			for (const r of c.different.slice(0, 40)) lines.push(`- ${r.id} ${r.name || ''}${r.field ? ` ${r.field}` : ''}: theirs ${JSON.stringify(r.theirs)}, ours ${JSON.stringify(r.ours)}${r.reason ? ` (ours differs: ${r.reason})` : ''}`);
			if (c.different.length > 40) lines.push(`- ... ${c.differentCount - 40} more (codex-parity.json)`);
			lines.push('');
		}
	}
	lines.push(`## Needs recording (${report.needsRecording.length})`, '', 'Facts only play can give (the Forever beta caps at level 30 until 4 November); the Recorder event that fills each:', '');
	const byKind = {};
	for (const n of report.needsRecording) (byKind[n.kind] = byKind[n.kind] || []).push(n);
	for (const [kindName, list] of Object.entries(byKind)) {
		lines.push(`- ${kindName} (${list.length}; Recorder \`${list[0].event}\`): ${list.slice(0, 25).map((n) => n.name).join(', ')}${list.length > 25 ? ', ...' : ''}`);
	}
	lines.push('');
	return lines.join('\n');
}

module.exports = { compareCodex, readCodex, summary, markdown, capped, mapInstances };
