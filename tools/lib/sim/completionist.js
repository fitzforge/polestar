'use strict';
// Completionist coverage (docs/SIMULATION.md "Completionist"): for one
// character and its best completionist route, every quest of its faction the
// character could meet, per zone of the quest giver: eligible (the run's
// quests), routed (turned in by the route), optional (elite: the guides mark
// them optional), missed (eligible, not turned in, with why) and every quest
// that is not eligible with its one reason.
//
//   const cov = coverage({ world, run, ev, route, data });
//   writeCoverage(cov, file)   // file.json + file.md

const fs = require('node:fs');
const { questOpen, onIsle, raceBit, popcount } = require('./run');
const { ALL_CLASSES } = require('../game/races');

// Reasons a quest open to the character's race is not routed, in report
// order. `where` says which guides cover it instead (if any).
const REASONS = [
	['class', 'class quest', 'Class guides'],
	['dungeon', 'dungeon quest', 'Dungeons'],
	['raid', 'raid quest', 'Dungeons'],
	['pvp', 'PvP / battleground', null],
	['profession', 'profession quest (optional, noted in the guides)', 'Professions'],
	['reputation', 'needs more than Friendly', 'Reputation'],
	['seasonal', 'seasonal event', null],
	['repeatable', 'repeatable', null],
	['rareDrop', 'rare drop', null],
	['endgame', 'needs level 60', null],
	['unused', 'unused / test / placeholder', null],
	['alternative', 'alternative branch of an exclusive choice', null],
	['blocked', 'needs an excluded quest first', null],
	['isle', 'Zephras Isle (Skyborne only)', null],
	['data', 'not placeable from the data', null],
];
const REASON_LABEL = Object.fromEntries(REASONS.map(([k, l]) => [k, l]));

// world.excluded entry -> reason key.
function exclusionReason(e) {
	if (e.category === 'elite') return 'data'; // listed elite exclusions the completionist world keeps out (969, 8308)
	if (e.category) return e.category;
	const r = String(e.reason || '');
	if (r === 'profession') return 'profession';
	if (r === 'seasonal event' || /Midsummer|seasonal/i.test(r)) return 'seasonal';
	if (r.startsWith('unused')) return 'unused';
	if (r.startsWith('needs level 60')) return 'endgame';
	return 'data';
}

// Zone of a quest giver from the data: the zone map (zones.json type 3)
// holding most of the first giver's spawns; an item-started quest: its
// droppers' zone.
function giverZoneOf(data) {
	const zones = data.zones || {};
	const best = (spawns) => {
		let m = null;
		let n = 0;
		for (const [map, sp] of Object.entries(spawns || {})) {
			const z = zones[map];
			if (!z || z.type !== 3) continue;
			const c = ((sp && sp.pts) || []).length;
			if (c > n) {
				n = c;
				m = z.name;
			}
		}
		return m;
	};
	return (raw) => {
		const s = (raw && raw.start) || {};
		for (const id of s.npc || []) {
			const z = best((data.npcs[String(id)] || {}).spawns);
			if (z) return z;
		}
		for (const id of s.object || []) {
			const z = best(((data.objects || {})[String(id)] || {}).spawns);
			if (z) return z;
		}
		for (const id of s.item || []) {
			const drops = (((data.items || {})[String(id)] || {}).drops || {}).npc || {};
			for (const nid of Object.keys(drops)) {
				const z = best((data.npcs[nid] || {}).spawns);
				if (z) return z;
			}
		}
		return '(unknown)';
	};
}

// Why an eligible quest was not turned in by the route (ev holds the state
// after evaluating it).
function missReason(ev, qi) {
	const r = ev.run;
	if (ev.active[qi]) return 'accepted, not finished';
	if (r.qParent[qi] >= 0 && !ev.done[r.qParent[qi]]) return 'its parent quest was not in the log';
	for (let i = r.qExcl0[qi]; i < r.qExcl1[qi]; i++) if (ev.done[r.exclList[i]]) return `closed by ${r.quests[r.exclList[i]].id} (exclusive)`;
	if (!ev.prereqOk(qi)) return 'prerequisite not done';
	return 'never reached';
}

// -> { character, summary, zones: [{ zone, eligible, routed, optional, missed, out: { reason: n } }], missed: [...], out: [...], branches: [...] }
function coverage({ world, run, ev, route, data }) {
	ev.evaluate(route);
	const faction = world.faction;
	const rbit = raceBit(run.race, {}, faction);
	const skyborne = run.race === 'Skyborne';
	const zoneOfData = giverZoneOf(data);
	const zones = new Map();
	const zoneRow = (z) => {
		if (!zones.has(z)) zones.set(z, { zone: z, eligible: 0, routed: 0, optional: 0, missed: 0, out: {} });
		return zones.get(z);
	};
	const out = [];
	const missed = [];
	const addOut = (id, title, zone, reason, detail) => {
		zoneRow(zone).out[reason] = (zoneRow(zone).out[reason] || 0) + 1;
		out.push({ id, title, zone, reason, detail: detail || null });
	};
	// Masks: open to this race? Class quests (1-4 classes) are the Class
	// guides' (the run is classless, "any").
	const forRace = (q) => questOpen({ races: q.races, classes: null }, faction, rbit, null);
	const classQuest = (classes) => !!classes && (classes & ALL_CLASSES) !== ALL_CLASSES && popcount(classes & ALL_CLASSES) < 5;
	let otherRaces = 0;
	const branchOf = new Map();
	for (const b of run.branches) for (const d of b.dropped) branchOf.set(d, b.kept);
	// World quests (eligible or not).
	for (const q of world.quests) {
		const zone = world.zones[q.zone] || `map ${q.zone}`;
		if (!forRace(q)) {
			otherRaces++;
			continue;
		}
		const qi = run.qIndex.get(q.id);
		if (qi != null) {
			const row = zoneRow(zone);
			row.eligible++;
			if (q.elite) row.optional++;
			if (ev.done[qi]) row.routed++;
			else {
				row.missed++;
				missed.push({ id: q.id, title: q.title, zone, level: q.level, elite: !!q.elite, why: missReason(ev, qi) });
			}
			continue;
		}
		if (classQuest(q.classes)) addOut(q.id, q.title, zone, 'class');
		else if (!skyborne && onIsle(world, q)) addOut(q.id, q.title, zone, 'isle');
		else if (q.dungeon !== undefined) addOut(q.id, q.title, zone, 'dungeon');
		else if (branchOf.has(q.id)) addOut(q.id, q.title, zone, 'alternative', `alternative to ${branchOf.get(q.id)}`);
		else if (run.blockedBy.has(q.id)) addOut(q.id, q.title, zone, 'blocked', `needs ${run.blockedBy.get(q.id)}`);
		else addOut(q.id, q.title, zone, 'data');
	}
	// Quests the world builder excluded.
	for (const e of world.excluded) {
		const raw = data.quests[String(e.id)];
		const races = raw ? Number(raw.races) || null : null;
		if (!forRace({ races })) {
			otherRaces++;
			continue;
		}
		const zone = zoneOfData(raw);
		const classes = raw ? Number(raw.classes) || null : null;
		// Endgame, placeholders and events first: a level-60 class quest
		// (tier 0.5) is not the Class guides' either.
		const why = exclusionReason(e);
		addOut(e.id, e.title, zone, ['endgame', 'unused', 'seasonal'].includes(why) || !classQuest(classes) ? why : 'class', e.reason);
	}
	const rows = [...zones.values()].sort((a, b) => b.eligible - a.eligible || a.zone.localeCompare(b.zone));
	const sum = (k) => rows.reduce((n, r) => n + r[k], 0);
	const outCounts = {};
	for (const o of out) outCounts[o.reason] = (outCounts[o.reason] || 0) + 1;
	out.sort((a, b) => a.zone.localeCompare(b.zone) || REASONS.findIndex(([k]) => k === a.reason) - REASONS.findIndex(([k]) => k === b.reason) || a.id - b.id);
	missed.sort((a, b) => a.zone.localeCompare(b.zone) || a.id - b.id);
	return {
		character: { faction, race: run.race, class: run.cls || 'any' },
		summary: { eligible: sum('eligible'), routed: sum('routed'), optional: sum('optional'), missed: sum('missed'), notEligible: out.length, byReason: outCounts, otherRaces },
		zones: rows,
		missed,
		branches: run.branches.map((b) => ({ kept: b.kept, dropped: b.dropped })),
		out,
	};
}

function coverageMarkdown(cov, meta = {}) {
	const s = cov.summary;
	const L = [];
	L.push(`# Completionist coverage: ${cov.character.faction} ${cov.character.race} (${cov.character.class})`);
	L.push('');
	if (meta.label) L.push(meta.label, '');
	L.push(`Eligible quests ${s.eligible}: routed ${s.routed} (${s.optional} of the eligible are elite: optional in the guides), missed ${s.missed}. Not eligible for this character: ${s.notEligible} (by reason below); ${s.otherRaces} more are other races' quests.`);
	L.push('');
	const keys = REASONS.map(([k]) => k).filter((k) => s.byReason[k]);
	L.push('| reason | quests | covered by |', '|---|---|---|');
	for (const [k, label, where] of REASONS) if (s.byReason[k]) L.push(`| ${label} | ${s.byReason[k]} | ${where || '-'} |`);
	L.push('');
	L.push(`| zone | eligible | routed | elite (optional) | missed | ${keys.map((k) => REASON_LABEL[k]).join(' | ')} |`);
	L.push(`|---|---|---|---|---|${keys.map(() => '---|').join('')}`);
	for (const r of cov.zones) L.push(`| ${r.zone} | ${r.eligible} | ${r.routed} | ${r.optional} | ${r.missed} | ${keys.map((k) => r.out[k] || 0).join(' | ')} |`);
	if (cov.missed.length) {
		L.push('', '## Missed', '', '| id | quest | zone | level | why |', '|---|---|---|---|---|');
		for (const m of cov.missed) L.push(`| ${m.id} | ${m.title}${m.elite ? ' (elite)' : ''} | ${m.zone} | ${m.level} | ${m.why} |`);
	}
	if (cov.branches.length) {
		L.push('', '## Exclusive choices', '', 'Kept: most quests depending on it, then the higher reward, then the lower id.', '', '| kept | left out |', '|---|---|');
		for (const b of cov.branches) L.push(`| ${b.kept} | ${b.dropped.join(', ')} |`);
	}
	L.push('', '## Not eligible, by zone', '', '| zone | id | quest | reason | detail |', '|---|---|---|---|---|');
	for (const o of cov.out) L.push(`| ${o.zone} | ${o.id} | ${o.title} | ${REASON_LABEL[o.reason] || o.reason} | ${o.detail || ''} |`);
	return `${L.join('\n')}\n`;
}

// Writes <base>.json and <base>.md -> [files].
function writeCoverage(cov, base, meta = {}) {
	fs.writeFileSync(`${base}.json`, `${JSON.stringify({ schema: 1, ...meta, ...cov }, null, 1)}\n`);
	fs.writeFileSync(`${base}.md`, coverageMarkdown(cov, meta));
	return [`${base}.json`, `${base}.md`];
}

module.exports = { coverage, coverageMarkdown, writeCoverage, exclusionReason, REASONS };
