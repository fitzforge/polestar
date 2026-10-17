'use strict';
// Wowhead's Forever database (https://www.wowhead.com/forever): the quest
// facts Forever changed. Facts only (ids, XP, levels); results stay in data/,
// which is gitignored.
//
// `data build` reads the zone quest lists cached in data/sources/wowhead/,
// when there are any, and builds without them otherwise.
//
// Cache: <sources>/wowhead/zones.json ({ fetchedAt, zones: { "<area>": rows } }),
// one list per zone, class (a negative category per class) and instance (the
// dungeon and raid lists, each row under its instance's area: 1581 The
// Deadmines). A row: { id, name, zone, level, reqlevel, xp, type (Wowhead's
// quest type: 81 Dungeon, 62 Raid, 1 Elite, 41 PvP), side (1 Alliance, 2
// Horde, 3 both), choices (one of them), items (every one) [[item, count]],
// money (copper), rep [[faction, value]], status (new | updated |
// unchanged), lines (the change notes) }; an older cache's rows lack `zone`
// (their list's key gives it).
//
// What the build does with it:
// - applyChangeNotes: a note "Experience X instead of Y", "Level X instead of
//   Y" or "Requires level X instead of Y" sets X where our value is still Y
//   (or, for XP, missing), and "Renamed from Y" gives the quest Wowhead's
//   Forever name where our title is still Y: the note says Forever changed
//   it, and we still hold the old value. A different value of ours is left
//   alone.
// - fillWowheadXp: XP for quests still without any after QuestieDB and the web
//   XP sources, from the zone list's xp.
// - applyWowheadFacts: each listed quest's `wowhead` record { zone, type,
//   side, choices, items, money, rep } (zone: the row's category), which
//   `codex build` reads for the Dungeons journal (Wowhead's instance
//   category, rewards a recording or ForeverLevelingBiS lack).
// Wowhead's Forever database also lists datamined quests that are not live
// (<NYI> placeholders, Season of Discovery leftovers), so a quest's presence
// there says nothing about whether it is in the game.

const fs = require('node:fs');
const path = require('node:path');

const BASE = 'https://www.wowhead.com/forever';

const NOTES = [
	['xp', /^Experience ([\d,]+) instead of ([\d,]+|none)$/],
	['minLevel', /^Requires level (\d+) instead of (\d+|none)$/],
	['level', /^Level (\d+) instead of (\d+|none)$/],
];

// Change-note lines -> [{ field, value, was }] (was: null for "none").
function parseChangeNotes(lines) {
	const out = [];
	for (const line of lines) {
		for (const [field, re] of NOTES) {
			const m = re.exec(line);
			if (!m) continue;
			const num = (s) => (s === 'none' ? null : Number(s.replace(/,/g, '')));
			out.push({ field, value: num(m[1]), was: num(m[2]) });
			break;
		}
	}
	return out;
}

// The cached zone lists. -> { rows: Map<id, row>, file, fetchedAt, warnings }
function loadZoneQuests({ sourcesDir }) {
	const file = path.join(sourcesDir, 'wowhead', 'zones.json');
	const cache = fs.existsSync(file) ? JSON.parse(fs.readFileSync(file, 'utf8')) : null;
	const rows = new Map();
	if (cache) for (const [zone, list] of Object.entries(cache.zones)) for (const r of list) rows.set(r.id, r.zone === undefined ? { ...r, zone: Number(zone) } : r);
	return { rows, file, fetchedAt: cache ? cache.fetchedAt : null, warnings: cache ? [] : ['no cached Wowhead zone lists'] };
}

function tag(q, source) {
	if (!q.source.includes(source)) q.source.push(source);
}

// quests: the merged table (mutated). rows: Map from loadZoneQuests.
// -> { xp, level, minLevel, title } counts of values changed
function applyChangeNotes(quests, rows) {
	const changed = { xp: 0, level: 0, minLevel: 0, title: 0 };
	for (const r of rows.values()) {
		const q = quests[r.id];
		if (!q || r.status !== 'updated') continue;
		for (const n of parseChangeNotes(r.lines)) {
			const cur = q[n.field];
			const stale = n.field === 'xp' ? !Number.isFinite(cur) || cur === n.was : cur === n.was;
			if (!stale || cur === n.value || !(n.value > 0)) continue;
			q[n.field] = n.value;
			tag(q, `wowhead:${n.field}`);
			changed[n.field]++;
		}
		for (const line of r.lines) {
			const m = /^Renamed from (.+)$/.exec(line);
			if (!m || typeof r.name !== 'string' || !r.name || q.title !== m[1] || q.title === r.name) continue;
			q.title = r.name;
			tag(q, 'wowhead:title');
			changed.title++;
		}
	}
	return changed;
}

// XP from the zone lists for quests that still have none. -> count
function fillWowheadXp(quests, rows) {
	let n = 0;
	for (const r of rows.values()) {
		const q = quests[r.id];
		if (!q || Number.isFinite(q.xp) || !(r.xp > 0)) continue;
		q.xp = r.xp;
		tag(q, 'wowhead:xp');
		n++;
	}
	return n;
}

// Wowhead's instance category, type, side and rewards on each listed quest
// (`wowhead`, read by `codex build`). -> count of quests given one
//
// Where Forever changed a quest's rewards, Wowhead's row can name an item as
// both a choice and a reward: Deviate Hides (1486) lists Deviate Hide Pack and
// Slick Deviate Leggings in both, its notes saying "Rewards: adds Deviate Hide
// Pack, Slick Deviate Leggings" and "no longer Choice of ..." (both given
// now); Serpentbloom (962) lists Apothecary Gloves in both, its note "adds
// Choice of Heat Resistant Mitts, Choice of Safety Boots" (the gloves became
// one of three choices). So an item in both is a reward when a note says
// "no longer Choice of", else a choice. A reputation of 1 (Magram Alliance's
// Gelkis Clan Centaur, a Silithus quest's Stormwind) is no amount Wowhead
// knows: left out.
function applyWowheadFacts(quests, rows) {
	let n = 0;
	for (const r of rows.values()) {
		const q = quests[r.id];
		if (!q || r.type === undefined) continue;
		const choiceIds = new Set(r.choices.map((p) => p[0]));
		const noLongerChoice = r.lines.some((l) => /^Rewards: no longer Choice of /.test(l));
		const both = r.items.filter((p) => choiceIds.has(p[0])).map((p) => p[0]);
		const choices = noLongerChoice ? r.choices.filter((p) => !both.includes(p[0])) : r.choices;
		const items = noLongerChoice ? r.items : r.items.filter((p) => !choiceIds.has(p[0]));
		q.wowhead = { zone: r.zone ?? null, type: r.type, side: r.side, choices, items, money: r.money, rep: r.rep.filter((p) => Math.abs(p[1]) > 1) };
		n++;
	}
	return n;
}

module.exports = { BASE, parseChangeNotes, loadZoneQuests, applyChangeNotes, fillWowheadXp, applyWowheadFacts };
