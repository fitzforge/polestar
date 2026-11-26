'use strict';
// Fishing waters (tools/lib/professions/gathering/fishing-waters.json): per zone map, what its water gives
// and where players stand to fish it.
//
//   node tools/polestar.js profession gathering waters [--tdb FILE] [--recordings DIR]
//
// - `full`: the Fishing skill from which the zone loses no fish (the Forever TrinityCore world database's
//   skill_fishing_base_level for the zone's area, + 95);
// - `loot`: the zone's fishing loot in percent (its fishing_loot_template rows; a group's rows without a
//   chance share what the rows with one leave; quest-only rows left out);
// - `stands`: where players stood when they caught fish. The Recorder writes a `loot` record for every
//   catch with the player's position (Polestar_Recorder/Finds.lua); those positions, per map, are
//   clustered at STAND_YARDS around the densest ones, and a stand is kept when at least MIN_PEOPLE
//   independent people fished there (the recordings' spot threshold). Each stand has its catches and the
//   items caught there. A stand is a place on a shore, a dock or a boat within cast range of the water,
//   so the arrow can lead there.
//
// People: the contributors, installs and characters of the session file names joined (one person may
// record from several installs and characters); the archive's config.json `exclude` contributors are
// left out.

const fs = require('node:fs');
const path = require('node:path');
const { dist } = require('../../route/geo');

const FILE = path.join(__dirname, 'fishing-waters.json');
const ABOUT =
	"Fishing waters per zone map: full (the Fishing skill from which the zone loses no fish: the Forever TrinityCore world database's base skill + 95), loot (its fishing loot, percent) and stands (where players stood when they caught fish, from Polestar_Recorder sessions: clusters of catch positions kept at 3 or more people, with catches and the items caught). Written by `node tools/polestar.js profession gathering waters` (tools/lib/professions/gathering/waters.js); read by the Fishing + Cooking guide.";
const STAND_YARDS = 20;
const MIN_PEOPLE = 3;
const MIN_LOOT = 0.5;

const round1 = (v) => Math.round(v * 10) / 10;
const round2 = (v) => Math.round(v * 100) / 100;

// Fishing loot of one area: { item: percent }. Rows of group 0 drop by their own chance; in a group, the
// rows without a chance split what the others leave of 100. A reference row (ItemType 1) adds its
// reference table's items at the row's chance times theirs.
function areaLoot(db, area) {
	const rows = db.prepare('SELECT ItemType AS t, Item AS item, Chance AS chance, QuestRequired AS q, GroupId AS g FROM fishing_loot_template WHERE Entry = ?').all(area);
	const refs = db.prepare('SELECT Item AS item, Chance AS chance, GroupId AS g FROM reference_loot_template WHERE Entry = ? AND ItemType = 0');
	const out = {};
	const add = (item, p) => {
		if (p > 0) out[item] = (out[item] || 0) + p;
	};
	const groups = new Map();
	for (const r of rows) {
		if (r.q) continue;
		if (r.t === 1) {
			for (const x of share(refs.all(r.item))) add(x.item, (r.chance / 100) * x.p);
		} else if (r.g === 0) add(r.item, r.chance);
		else {
			if (!groups.has(r.g)) groups.set(r.g, []);
			groups.get(r.g).push(r);
		}
	}
	for (const list of groups.values()) for (const x of share(list)) add(x.item, x.p);
	return out;
}

// Rows of one group (or a reference table) -> [{ item, p }]: rows with a chance keep it, the others split
// the rest of 100 equally (group 0 rows keep their own chance).
function share(rows) {
	const out = [];
	const byGroup = new Map();
	for (const r of rows) {
		if (!r.g) out.push({ item: r.item, p: r.chance });
		else {
			if (!byGroup.has(r.g)) byGroup.set(r.g, []);
			byGroup.get(r.g).push(r);
		}
	}
	for (const list of byGroup.values()) {
		const fixed = list.reduce((s, r) => s + (r.chance > 0 ? r.chance : 0), 0);
		const open = list.filter((r) => !(r.chance > 0));
		for (const r of list) out.push({ item: r.item, p: r.chance > 0 ? r.chance : Math.max(0, 100 - fixed) / open.length });
	}
	return out;
}

// { <uiMap>: { area, full, loot } } for every zone map of zones.json with an area that has fishing data.
function zoneWaters(tdbFile, zones) {
	const { DatabaseSync } = require('node:sqlite');
	const db = new DatabaseSync(tdbFile, { readOnly: true });
	try {
		const base = db.prepare('SELECT skill FROM skill_fishing_base_level WHERE entry = ?');
		const out = {};
		for (const z of Object.values(zones).sort((a, b) => a.id - b.id)) {
			if (!z.areaId) continue;
			const b = base.get(z.areaId);
			const loot = areaLoot(db, z.areaId);
			if (!b && !Object.keys(loot).length) continue;
			const kept = {};
			for (const [item, p] of Object.entries(loot).sort((a, b) => b[1] - a[1] || a[0] - b[0])) if (p >= MIN_LOOT) kept[item] = round1(p);
			out[z.id] = { area: z.areaId, full: b ? b.skill + 95 : null, loot: kept };
		}
		return out;
	} finally {
		db.close();
	}
}

// Union-find over the session file names' contributor, install and character: one person.
function peopleOf(names) {
	const parent = new Map();
	const find = (a) => {
		if (!parent.has(a)) parent.set(a, a);
		let r = a;
		while (parent.get(r) !== r) r = parent.get(r);
		parent.set(a, r);
		return r;
	};
	const union = (a, b) => {
		const ra = find(a);
		const rb = find(b);
		if (ra !== rb) parent.set(ra < rb ? rb : ra, ra < rb ? ra : rb);
	};
	const byFile = new Map();
	for (const name of names) {
		const parts = name.replace(/\.json$/, '').split('-');
		if (parts.length !== 4) continue;
		const [, c, install, char] = parts;
		union(c, `i:${install}`);
		union(c, `h:${char}`);
		byFile.set(name, c);
	}
	return { person: (name) => (byFile.has(name) ? find(byFile.get(name)) : null), contributor: (name) => byFile.get(name) || null };
}

// Every catch in the archive's session files: { map, x, y (live frame), person, items: [[item, n]] }.
function readCatches(dir) {
	const names = fs.readdirSync(dir).filter((n) => n.endsWith('.json') && n !== 'config.json').sort();
	const cfgFile = path.join(dir, 'config.json');
	const exclude = new Set(fs.existsSync(cfgFile) ? JSON.parse(fs.readFileSync(cfgFile, 'utf8')).exclude || [] : []);
	const P = peopleOf(names);
	const out = [];
	for (const name of names) {
		if (exclude.has(P.contributor(name))) continue;
		const text = fs.readFileSync(path.join(dir, name), 'utf8');
		if (!/"gather":\s*"fish"/.test(text)) continue;
		const s = JSON.parse(text);
		if (exclude.has(s.contributor)) continue;
		const person = P.person(name) || s.contributor;
		for (const e of s.events || []) {
			if (!e || e.e !== 'drop' || e.gather !== 'fish' || !Number.isFinite(e.x) || !Number.isFinite(e.y) || !e.map) continue;
			out.push({ map: e.map, x: e.x, y: e.y, person, items: (e.items || []).map((i) => [i.item, i.count || 1]) });
		}
	}
	return out;
}

// Catches -> { <uiMap>: [stand] }: per map, each catch's neighbours within STAND_YARDS (a grid of that
// size); the densest catch not yet taken seeds a stand of every untaken catch within STAND_YARDS of it.
// The stand is the seed's position (a place a player stood). Kept at MIN_PEOPLE people.
function stands(catches, project) {
	const byMap = new Map();
	for (const c of catches) {
		const pt = project.point(c.map, c.x, c.y, 'l');
		if (!byMap.has(pt.map)) byMap.set(pt.map, []);
		byMap.get(pt.map).push({ ...c, pt });
	}
	const out = {};
	for (const map of [...byMap.keys()].sort((a, b) => a - b)) {
		const pts = byMap.get(map);
		const cell = (p) => `${Math.floor(p.pt.wx / STAND_YARDS)},${Math.floor(p.pt.wy / STAND_YARDS)}`;
		const grid = new Map();
		for (const p of pts) {
			const k = cell(p);
			if (!grid.has(k)) grid.set(k, []);
			grid.get(k).push(p);
		}
		const near = (p) => {
			const cx = Math.floor(p.pt.wx / STAND_YARDS);
			const cy = Math.floor(p.pt.wy / STAND_YARDS);
			const list = [];
			for (let dx = -1; dx <= 1; dx++) for (let dy = -1; dy <= 1; dy++) for (const q of grid.get(`${cx + dx},${cy + dy}`) || []) if (dist(p.pt, q.pt) <= STAND_YARDS) list.push(q);
			return list;
		};
		for (const p of pts) p.n = near(p).length;
		const order = pts.slice().sort((a, b) => b.n - a.n || a.pt.x - b.pt.x || a.pt.y - b.pt.y);
		const list = [];
		for (const seed of order) {
			if (seed.taken) continue;
			const members = near(seed).filter((q) => !q.taken);
			for (const q of members) q.taken = true;
			const people = new Set(members.map((q) => q.person));
			if (people.size < MIN_PEOPLE) continue;
			const fish = {};
			for (const q of members) for (const [item, n] of q.items) fish[item] = (fish[item] || 0) + n;
			const stand = { x: round2(seed.pt.x), y: round2(seed.pt.y) };
			if (seed.pt.f === 'l') stand.f = 'l';
			stand.people = people.size;
			stand.catches = members.length;
			stand.fish = Object.fromEntries(Object.entries(fish).sort((a, b) => b[1] - a[1] || a[0] - b[0]));
			list.push(stand);
		}
		if (list.length) out[map] = list.sort((a, b) => b.people - a.people || b.catches - a.catches || a.x - b.x || a.y - b.y);
	}
	return out;
}

// The table: { maps: { <uiMap>: { area, full, loot, stands } } }.
function derive({ tdbFile, recordingsDir, zones, project }) {
	const maps = zoneWaters(tdbFile, zones);
	const st = stands(readCatches(recordingsDir), project);
	for (const [map, list] of Object.entries(st)) {
		if (!maps[map]) maps[map] = { area: null, full: null, loot: {} };
		maps[map].stands = list;
	}
	return { maps };
}

// The file's text: one line per zone's numbers and one per stand.
function render(table) {
	const ids = Object.keys(table.maps).sort((a, b) => a - b);
	const L = ['{', `\t"about": ${JSON.stringify(ABOUT)},`, '\t"maps": {'];
	ids.forEach((map, i) => {
		const z = table.maps[map];
		L.push(`\t\t${JSON.stringify(map)}: {`);
		L.push(`\t\t\t"area": ${JSON.stringify(z.area)}, "full": ${JSON.stringify(z.full)},`);
		L.push(`\t\t\t"loot": ${JSON.stringify(z.loot)}${z.stands ? ',' : ''}`);
		if (z.stands) {
			L.push('\t\t\t"stands": [');
			z.stands.forEach((s, j) => L.push(`\t\t\t\t${JSON.stringify(s)}${j < z.stands.length - 1 ? ',' : ''}`));
			L.push('\t\t\t]');
		}
		L.push(`\t\t}${i < ids.length - 1 ? ',' : ''}`);
	});
	L.push('\t}', '}', '');
	return L.join('\n');
}

let cached = null;
// The committed table's maps, or {} without it.
function load() {
	if (!cached) cached = fs.existsSync(FILE) ? JSON.parse(fs.readFileSync(FILE, 'utf8')).maps : {};
	return cached;
}

module.exports = { FILE, ABOUT, STAND_YARDS, MIN_PEOPLE, areaLoot, share, zoneWaters, peopleOf, readCatches, stands, derive, render, load };
