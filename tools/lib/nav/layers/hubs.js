'use strict';
// The hostile hubs layer: each faction's towns and outposts, where every
// guard attacks a player of the other faction. Built from the CMaNGOS
// classic-db spawns (spawnz.json) and creature templates, judged by the
// client's FactionTemplate table and named by its AreaTable:
//
//   a creature template is one side's when its faction template is hostile
//   to the other side's players and not to its own (FactionTemplateEntry::
//   IsHostileTo of mangos-classic, src/game/Server/DBCStructure.h, against
//   the player templates of the side's races);
//   a guard: one side's, with ExtraFlags CREATURE_EXTRA_FLAG_GUARD (0x400)
//   and at least MIN_GUARD_LEVEL (the flag also marks the level-6 Kul Tiras
//   Marines of Tiragarde Keep, a camp of mobs; Bloodhoof Village's Braves
//   are 14), or with a guard's name (GUARD_NAME: the dump leaves the flag
//   off many outpost guards, e.g. Southshore Guard, Hammerfall Grunt,
//   Stonard Grunt, Brackenwall Enforcer) and at least MIN_NAMED_GUARD_LEVEL (not the Dalaran
//   Watchers of Ambermill or the Pyrewood Watchers, mobs of 13-18);
//   a service NPC: one side's, not a guard, with a quest giver, vendor,
//   flight master, trainer, innkeeper, banker or repair NpcFlag.
//
// Guards and service NPCs of one side on one map are clustered by single
// linkage at LINK yd; a cluster with at least MIN_GUARDS guard or at least
// MIN_SERVICES service NPCs is a hub. Hubs of one side with spawns within
// JOIN yd of each other are listed as one hub under one name (a naming merge
// only: every disk is a hub cluster's, none is added). A hub's disks: one per
// spawn, GUARD_RADIUS around a guard, SERVICE_RADIUS around a service NPC.
// Named by the AreaTable: the capital (Flags_0 & AREA_CAPITAL) at least half
// its spawns stand in, by the grid's chunk area or by the zone map around
// them (zoneAt: Ironforge and Undercity lie under WMOs whose chunks carry
// Dun Morogh's and Tirisfal's areas), else the area under the hub's
// centroid (the grid's per-chunk area id) when it is a subzone, else the
// most common subzone under its spawns, else the zone.
//
//   data/local/nav-layers/hubs.json: { build, rev, maps: [...], rules, 0: [hub], 1: [hub], ... }
//   hub = { id, side (the owner: 'Alliance' | 'Horde'), name, areaId, guards, services, disks: [[x, y, r]] }
//   (x north, y west, the grid's and UnitPosition's frame)

const path = require('node:path');
const { ROOT } = require('../../paths');

const HUBS_FILE = path.join(ROOT, 'data', 'local', 'nav-layers', 'hubs.json');
// Maps with hubs: Eastern Kingdoms, Kalimdor, Zephras Isle (no CMaNGOS spawns: always empty).
const HUB_MAPS = [0, 1, 2991];

// FactionTemplate group mask bits (mangos-classic src/game/Server/DBCEnums.h FactionGroupMask).
const GROUP = { PLAYER: 1, ALLIANCE: 2, HORDE: 4, MONSTER: 8 };
// The player faction templates of each side: ChrRaces.FactionID of Human,
// Dwarf, Night Elf, Gnome / Orc, Undead, Tauren, Troll.
const PLAYER_TEMPLATES = { Alliance: [1, 3, 4, 115], Horde: [2, 5, 6, 116] };
const SIDES = ['Alliance', 'Horde'];

// CreatureExtraFlags (mangos-classic src/game/Entities/Creature.h).
const EXTRA_INVISIBLE = 0x80;
const EXTRA_GUARD = 0x400;
// AreaTable.Flags_0: a capital city (Stormwind City, Orgrimmar, ...).
const AREA_CAPITAL = 0x100;
// NPCFlags (mangos-classic src/game/Entities/Unit.h): quest giver, vendor,
// flight master, trainer, innkeeper, banker, repair.
const NPC = { QUESTGIVER: 0x2, VENDOR: 0x4, FLIGHTMASTER: 0x8, TRAINER: 0x10, INNKEEPER: 0x80, BANKER: 0x100, REPAIR: 0x4000 };
const SERVICE_FLAGS = Object.values(NPC).reduce((a, b) => a | b, 0);

const GUARD_NAME = /\b(Guard|Sentinel|Grunt|Protector|Deathguard|Brave|Watcher|Watchman|Mountaineer|Peacekeeper|Defender|Enforcer|Soldier)\b/;
const MIN_GUARD_LEVEL = 10;
const MIN_NAMED_GUARD_LEVEL = 20;
const GUARD_RADIUS = 50;
const SERVICE_RADIUS = 25;
const LINK = 60;
const JOIN = 100;
const MIN_GUARDS = 1;
const MIN_SERVICES = 4;

const ids = (r, key) => {
	const out = [];
	for (let i = 0; i < 8; i++) {
		const v = Number(r[`${key}_${i}`]) || 0;
		if (v) out.push(v);
	}
	return out;
};

// FactionTemplate CSV rows -> hostileTo(templateId) -> { Alliance, Horde }
// (whether the template attacks that side's players) or null for an unknown id.
function makeHostileTo(factionTemplates) {
	const rows = new Map();
	for (const r of factionTemplates) {
		rows.set(Number(r.ID), { faction: Number(r.Faction) || 0, group: Number(r.FactionGroup) || 0, enemyGroup: Number(r.EnemyGroup) || 0, enemies: ids(r, 'Enemies'), friends: ids(r, 'Friend') });
	}
	for (const side of SIDES) for (const id of PLAYER_TEMPLATES[side]) if (!rows.has(id)) throw new Error(`FactionTemplate has no player template ${id} (${side})`);
	// mangos-classic FactionTemplateEntry::IsHostileTo.
	const hostile = (a, b) => {
		if (b.faction) {
			if (a.enemies.includes(b.faction)) return true;
			if (a.friends.includes(b.faction)) return false;
		}
		return (a.enemyGroup & b.group) !== 0;
	};
	const memo = new Map();
	return (templateId) => {
		const id = Number(templateId);
		if (memo.has(id)) return memo.get(id);
		const a = rows.get(id);
		const out = a ? { Alliance: PLAYER_TEMPLATES.Alliance.some((p) => hostile(a, rows.get(p))), Horde: PLAYER_TEMPLATES.Horde.some((p) => hostile(a, rows.get(p))) } : null;
		memo.set(id, out);
		return out;
	};
}

// A creature template -> { side, guard } (side: its owner) or null when it is
// neither a guard nor a service NPC of exactly one side.
function roleOf(t, hostileTo) {
	if (!t || t.extraFlags & EXTRA_INVISIBLE) return null;
	const h = hostileTo(t.faction);
	if (!h || h.Alliance === h.Horde) return null;
	const side = h.Horde ? 'Alliance' : 'Horde';
	const guard = t.extraFlags & EXTRA_GUARD ? t.minLevel >= MIN_GUARD_LEVEL : GUARD_NAME.test(t.name) && t.minLevel >= MIN_NAMED_GUARD_LEVEL;
	if (guard) return { side, guard: true };
	if (t.npcFlags & SERVICE_FLAGS) return { side, guard: false };
	return null;
}

// Single-linkage clusters of points within r of each other: [[point]].
function clusters(points, r) {
	const parent = points.map((_, i) => i);
	const find = (i) => {
		while (parent[i] !== i) i = parent[i] = parent[parent[i]];
		return i;
	};
	const cells = new Map();
	const key = (gx, gy) => `${gx},${gy}`;
	points.forEach((p, i) => {
		const k = key(Math.floor(p.x / r), Math.floor(p.y / r));
		if (!cells.has(k)) cells.set(k, []);
		cells.get(k).push(i);
	});
	points.forEach((p, i) => {
		const gx = Math.floor(p.x / r);
		const gy = Math.floor(p.y / r);
		for (let dx = -1; dx <= 1; dx++) {
			for (let dy = -1; dy <= 1; dy++) {
				for (const j of cells.get(key(gx + dx, gy + dy)) || []) {
					if (j > i && Math.hypot(p.x - points[j].x, p.y - points[j].y) <= r) parent[find(i)] = find(j);
				}
			}
		}
	});
	const out = new Map();
	points.forEach((p, i) => {
		const k = find(i);
		if (!out.has(k)) out.set(k, []);
		out.get(k).push(p);
	});
	return [...out.values()];
}

const near = (a, b, r) => a.some((p) => b.some((q) => Math.hypot(p.x - q.x, p.y - q.y) <= r));
const tenth = (v) => {
	const r = Math.round(v * 10) / 10;
	return Object.is(r, -0) ? 0 : r;
};
const slug = (s) => String(s).toLowerCase().normalize('NFKD').replace(/[\u0300-\u036f]/g, '').replace(/'/g, '').replace(/[^a-z0-9]+/g, '-').replace(/^-+|-+$/g, '') || 'x';

// The hubs of one side on map c from its guards and service NPCs: [[point]].
function sideHubs(points) {
	const isHub = (g) => {
		const guards = g.filter((p) => p.guard).length;
		return guards >= MIN_GUARDS || g.length - guards >= MIN_SERVICES;
	};
	const hubs = clusters(points, LINK).filter(isHub);
	// The naming merge: hubs with spawns within JOIN yd become one listed hub (their disks unchanged).
	for (let changed = true; changed;) {
		changed = false;
		for (let a = 0; a < hubs.length && !changed; a++) {
			for (let b = a + 1; b < hubs.length; b++) {
				if (near(hubs[a], hubs[b], JOIN)) {
					hubs[a] = hubs[a].concat(hubs[b]);
					hubs.splice(b, 1);
					changed = true;
					break;
				}
			}
		}
	}
	return hubs;
}

// The hub's name: { areaId, name }. zoneAt(c, x, y) -> the area id of the zone map around a point, or 0.
function nameOf(c, members, areaAt, zoneAt, areas) {
	const cx = members.reduce((a, p) => a + p.x, 0) / members.length;
	const cy = members.reduce((a, p) => a + p.y, 0) / members.length;
	const isSub = (id) => areas.has(id) && areas.get(id).parent > 0;
	const capitalOf = (id) => {
		for (let cur = id, n = 0; areas.has(cur) && n < 8; cur = areas.get(cur).parent, n++) if (areas.get(cur).capital) return cur;
		return 0;
	};
	const most = (count) => {
		const best = [...count].sort((a, b) => b[1] - a[1] || a[0] - b[0])[0];
		return best || null;
	};
	const memberAreas = members.map((p) => Number(areaAt(c, p.x, p.y)) || 0);
	const capitals = new Map();
	const subs = new Map();
	members.forEach((p, i) => {
		const a = memberAreas[i];
		const cap = capitalOf(a) || (zoneAt ? capitalOf(Number(zoneAt(c, p.x, p.y)) || 0) : 0);
		if (cap) capitals.set(cap, (capitals.get(cap) || 0) + 1);
		if (isSub(a)) subs.set(a, (subs.get(a) || 0) + 1);
	});
	const capital = most(capitals);
	let id = capital && capital[1] * 2 >= members.length ? capital[0] : 0;
	if (!id) {
		id = Number(areaAt(c, cx, cy)) || 0;
		if (!isSub(id)) id = (most(subs) || [0])[0] || (areas.has(id) ? id : memberAreas.find((a) => areas.has(a)) || 0);
	}
	return { areaId: id, name: areas.has(id) ? areas.get(id).name : `map ${c} (${Math.round(cx)}, ${Math.round(cy)})` };
}

// spawns: { entry: [[map, x, y, z], ...] } (spawnz.json's npc table);
// templates: { entry: { name, faction, npcFlags, extraFlags, rank, minLevel } };
// factionTemplates, areaTable: client CSV rows; areaAt(c, x, y) -> area id
// (the grid's chunk); zoneAt(c, x, y) -> the area id of the zone map around
// the point, or 0 (optional)
// -> { [map]: [hub] } for every map of HUB_MAPS (maps = HUB_MAPS by default).
function buildHubs({ spawns, templates, factionTemplates, areaTable, areaAt, zoneAt = null, maps = HUB_MAPS }) {
	const hostileTo = makeHostileTo(factionTemplates);
	const areas = new Map();
	for (const r of areaTable) areas.set(Number(r.ID), { name: String(r.AreaName_lang).trim(), parent: Number(r.ParentAreaID) || 0, capital: (Number(r.Flags_0) & AREA_CAPITAL) !== 0 });
	const points = new Map(maps.map((c) => [c, { Alliance: [], Horde: [] }]));
	for (const entry of Object.keys(spawns).map(Number).sort((a, b) => a - b)) {
		const role = roleOf(templates[entry], hostileTo);
		if (!role) continue;
		for (const [c, x, y] of spawns[entry]) {
			const at = points.get(Number(c));
			if (at) at[role.side].push({ x: Number(x), y: Number(y), guard: role.guard, entry });
		}
	}
	const out = {};
	for (const c of maps) {
		const hubs = [];
		for (const side of SIDES) {
			for (const members of sideHubs(points.get(c)[side])) {
				const { areaId, name } = nameOf(c, members, areaAt, zoneAt, areas);
				const guards = members.filter((p) => p.guard).length;
				const seen = new Set();
				const disks = [];
				for (const p of members) {
					const d = [tenth(p.x), tenth(p.y), p.guard ? GUARD_RADIUS : SERVICE_RADIUS];
					const k = d.join(',');
					if (seen.has(k)) continue;
					seen.add(k);
					disks.push(d);
				}
				disks.sort((a, b) => a[0] - b[0] || a[1] - b[1] || a[2] - b[2]);
				hubs.push({ id: null, side, name, areaId, guards, services: members.length - guards, disks });
			}
		}
		hubs.sort((a, b) => a.side.localeCompare(b.side) || a.name.localeCompare(b.name) || a.disks[0][0] - b.disks[0][0] || a.disks[0][1] - b.disks[0][1]);
		const used = new Map();
		for (const h of hubs) {
			const base = `${slug(h.side)}-${slug(h.name)}`;
			const n = (used.get(base) || 0) + 1;
			used.set(base, n);
			h.id = n === 1 ? base : `${base}-${n}`;
		}
		out[c] = hubs;
	}
	return out;
}

// The rules buildHubs applies, for hubs.json.
const RULES = {
	guard: `one side's (hostile to the other side's players only) with ExtraFlags & 0x${EXTRA_GUARD.toString(16)} and MinLevel >= ${MIN_GUARD_LEVEL}, or named /${GUARD_NAME.source}/ and MinLevel >= ${MIN_NAMED_GUARD_LEVEL}`,
	service: `one side's, not a guard, NpcFlags & 0x${SERVICE_FLAGS.toString(16)} (quest giver, vendor, flight master, trainer, innkeeper, banker, repair)`,
	hub: `single linkage at ${LINK} yd; a cluster with >= ${MIN_GUARDS} guard or >= ${MIN_SERVICES} service NPCs is a hub; hubs of one side within ${JOIN} yd are listed as one (a naming merge: their disks unchanged, none added)`,
	name: 'AreaTable: the capital (Flags_0 & 0x100) at least half the spawns stand in (chunk area or zone map), else the subzone under the centroid, else the most common subzone, else the zone',
	disks: `${GUARD_RADIUS} yd around a guard, ${SERVICE_RADIUS} yd around a service NPC`,
};

module.exports = {
	makeHostileTo, buildHubs, roleOf, clusters,
	HUBS_FILE, HUB_MAPS, GROUP, PLAYER_TEMPLATES, NPC, EXTRA_GUARD, GUARD_NAME, MIN_GUARD_LEVEL, MIN_NAMED_GUARD_LEVEL,
	GUARD_RADIUS, SERVICE_RADIUS, LINK, JOIN, MIN_GUARDS, MIN_SERVICES, RULES,
};
