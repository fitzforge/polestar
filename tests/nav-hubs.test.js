'use strict';
// The hostile hubs layer (tools/lib/nav/layers/hubs.js): hostility from the
// client's FactionTemplate rows, guards and service NPCs clustered into
// hubs on synthetic spawns, the creature_template extract of the CMaNGOS
// dump, and known towns on the built layer (data/local/nav-layers/hubs.json;
// skipped until `nav layers hubs` has run).

const { test } = require('node:test');
const assert = require('node:assert/strict');
const fs = require('node:fs');
const { makeHostileTo, buildHubs, roleOf, HUBS_FILE, GUARD_RADIUS, SERVICE_RADIUS } = require('../tools/lib/nav/layers/hubs');
const { extractCreatureTemplates } = require('../tools/lib/travel/cmangos');

// --- synthetic client tables -------------------------------------------------

// A FactionTemplate CSV row (the wago.tools export's columns).
function ftRow(ID, Faction, FactionGroup, FriendGroup, EnemyGroup, enemies = [], friends = []) {
	const r = { ID: String(ID), Faction: String(Faction), Flags: '0', FactionGroup: String(FactionGroup), FriendGroup: String(FriendGroup), EnemyGroup: String(EnemyGroup) };
	for (let i = 0; i < 8; i++) {
		r[`Enemies_${i}`] = String(enemies[i] || 0);
		r[`Friend_${i}`] = String(friends[i] || 0);
	}
	return r;
}

// The player templates (ChrRaces.FactionID of the eight races) and four creature templates.
const FACTION_TEMPLATES = [
	ftRow(1, 1, 3, 2, 12), ftRow(3, 3, 3, 2, 12), ftRow(4, 4, 3, 2, 12), ftRow(115, 8, 3, 2, 12),
	ftRow(2, 2, 5, 4, 10), ftRow(5, 5, 5, 4, 10), ftRow(6, 6, 5, 4, 10), ftRow(116, 9, 5, 4, 10),
	ftRow(11, 72, 3, 2, 12), // Stormwind: Alliance, enemy group Horde + monsters
	ftRow(85, 76, 5, 4, 10), // Orgrimmar: Horde, enemy group Alliance + monsters
	ftRow(121, 21, 1, 0, 8, [], [21]), // Booty Bay: enemy group monsters only
	ftRow(900, 900, 0, 0, 0, [2]), // enemy of the Orc faction only, by faction id
];

const AREAS = [
	{ ID: '10', AreaName_lang: 'Testshire Fields', ParentAreaID: '0' },
	{ ID: '11', AreaName_lang: 'Testshire', ParentAreaID: '10' },
];

// Templates: { entry: { name, faction, npcFlags, extraFlags, rank, minLevel } }.
const TEMPLATES = {
	100: { name: 'Testshire Guard', faction: 11, npcFlags: 0, extraFlags: 0x400, rank: 0, minLevel: 55 },
	101: { name: 'Testshire Vendor', faction: 11, npcFlags: 0x4, extraFlags: 0, rank: 0, minLevel: 30 },
	102: { name: 'Booty Bay Bruiser', faction: 121, npcFlags: 0, extraFlags: 0x400, rank: 0, minLevel: 57 },
	103: { name: 'Booty Bay Vendor', faction: 121, npcFlags: 0x4, extraFlags: 0, rank: 0, minLevel: 30 },
	104: { name: 'Testshire Peasant', faction: 11, npcFlags: 0, extraFlags: 0, rank: 0, minLevel: 5 },
};

const areaAt = () => 11;
const hubsOf = (npc) => buildHubs({ spawns: npc, templates: TEMPLATES, factionTemplates: FACTION_TEMPLATES, areaTable: AREAS, areaAt });

// --- hostility ---------------------------------------------------------------

test('hostility from the client\'s faction templates: group masks and enemy factions', () => {
	const hostileTo = makeHostileTo(FACTION_TEMPLATES);
	assert.deepEqual(hostileTo(11), { Alliance: false, Horde: true });
	assert.deepEqual(hostileTo(85), { Alliance: true, Horde: false });
	assert.deepEqual(hostileTo(121), { Alliance: false, Horde: false });
	assert.deepEqual(hostileTo(900), { Alliance: false, Horde: true });
	assert.equal(hostileTo(12345), null);
});

// --- clustering ----------------------------------------------------------------

test('three Alliance guards and two vendors within 40 yd make one Alliance hub of five disks', () => {
	const hubs = hubsOf({
		100: [[0, 1000, 1000, 5], [0, 1020, 1000, 5], [0, 1000, 1020, 5]],
		101: [[0, 1030, 1030, 5], [0, 1010, 1035, 5]],
		104: [[0, 1005, 1005, 5]],
	});
	assert.deepEqual(Object.keys(hubs).sort(), ['0', '1', '2991']);
	assert.equal(hubs[0].length, 1);
	assert.equal(hubs[1].length, 0);
	const h = hubs[0][0];
	assert.equal(h.side, 'Alliance');
	assert.equal(h.name, 'Testshire');
	assert.equal(h.areaId, 11);
	assert.equal(h.id, 'alliance-testshire');
	assert.equal(h.disks.length, 5);
	assert.equal(h.disks.filter((d) => d[2] === GUARD_RADIUS).length, 3);
	assert.equal(h.disks.filter((d) => d[2] === SERVICE_RADIUS).length, 2);
	assert.equal(GUARD_RADIUS, 50);
	assert.equal(SERVICE_RADIUS, 25);
	assert.deepEqual({ guards: h.guards, services: h.services }, { guards: 3, services: 2 });
});

test('three isolated Alliance vendors 200 yd apart make no hub', () => {
	const hubs = hubsOf({ 101: [[0, 0, 0, 0], [0, 200, 0, 0], [0, 400, 0, 0]] });
	assert.equal(hubs[0].length, 0);
});

test('a goblin (neutral) guard cluster makes no hub', () => {
	const hubs = hubsOf({
		102: [[1, 0, 0, 0], [1, 20, 0, 0], [1, 0, 20, 0]],
		103: [[1, 30, 30, 0], [1, 10, 35, 0]],
	});
	assert.equal(hubs[1].length, 0);
});

test('a lone guard is a hub; four service NPCs with no guard are a hub; three are not', () => {
	const guard = hubsOf({ 100: [[0, 3000, 3000, 5]] });
	assert.equal(guard[0].length, 1);
	assert.deepEqual({ guards: guard[0][0].guards, services: guard[0][0].services, disks: guard[0][0].disks }, { guards: 1, services: 0, disks: [[3000, 3000, GUARD_RADIUS]] });
	const four = hubsOf({ 101: [[0, 0, 0, 0], [0, 40, 0, 0], [0, 80, 0, 0], [0, 120, 0, 0]] });
	assert.equal(four[0].length, 1);
	assert.deepEqual({ guards: four[0][0].guards, services: four[0][0].services }, { guards: 0, services: 4 });
	const three = hubsOf({ 101: [[0, 0, 0, 0], [0, 40, 0, 0], [0, 80, 0, 0]] });
	assert.equal(three[0].length, 0);
});

test('hubs within 100 yd are listed as one (a naming merge, disks unchanged); a non-hub cluster beside a hub adds no disk', () => {
	const hubs = hubsOf({
		100: [[0, 1000, 1000, 5], [0, 1090, 1000, 5]],
		101: [[0, 1000, 1100, 5], [0, 1000, 1170, 5], [0, 1000, 1240, 5]],
	});
	assert.equal(hubs[0].length, 1);
	assert.deepEqual(hubs[0][0].disks, [[1000, 1000, GUARD_RADIUS], [1090, 1000, GUARD_RADIUS]]);
});

test('a hub most of whose spawns stand in a capital\'s zone map is named by the capital', () => {
	const areaTable = AREAS.concat([{ ID: '20', AreaName_lang: 'Capital City', ParentAreaID: '0', Flags_0: '256' }]);
	const zoneAt = (c, x) => (x < 1050 ? 20 : 0);
	const hubs = buildHubs({ spawns: { 100: [[0, 1000, 1000, 5], [0, 1020, 1000, 5], [0, 1100, 1000, 5]] }, templates: TEMPLATES, factionTemplates: FACTION_TEMPLATES, areaTable, areaAt, zoneAt });
	assert.deepEqual(hubs[0].map((h) => [h.name, h.areaId]), [['Capital City', 20]]);
	const fewer = buildHubs({ spawns: { 100: [[0, 1000, 1000, 5], [0, 1060, 1000, 5], [0, 1100, 1000, 5]] }, templates: TEMPLATES, factionTemplates: FACTION_TEMPLATES, areaTable, areaAt, zoneAt });
	assert.deepEqual(fewer[0].map((h) => h.name), ['Testshire']);
});

test('guards: the guard flag from level 10, a guard\'s name from level 20; service NPCs by their flags', () => {
	const hostileTo = makeHostileTo(FACTION_TEMPLATES);
	const t = (name, minLevel, extraFlags, npcFlags = 0) => roleOf({ name, faction: 85, npcFlags, extraFlags, rank: 0, minLevel }, hostileTo);
	assert.deepEqual(t('Bloodhoof Brave', 14, 0x400), { side: 'Horde', guard: true });
	assert.equal(t('Camp Marine', 6, 0x400), null);
	assert.deepEqual(t('Hammerfall Grunt', 34, 0), { side: 'Horde', guard: true });
	assert.deepEqual(t('Brackenwall Enforcer', 60, 0), { side: 'Horde', guard: true });
	assert.deepEqual(t('Valormok Soldier', 50, 0), { side: 'Horde', guard: true });
	assert.equal(t('Ambermill Watcher', 18, 0), null);
	assert.deepEqual(t('Innkeeper', 30, 0, 0x80), { side: 'Horde', guard: false });
	assert.equal(t('Peon', 5, 0, 0x1), null);
	assert.equal(roleOf({ name: 'Booty Bay Bruiser', faction: 121, npcFlags: 0, extraFlags: 0x400, rank: 0, minLevel: 57 }, hostileTo), null);
});

// --- the dump's creature_template ---------------------------------------------

test('creature templates from the dump: columns by the CREATE TABLE, quoted names', async () => {
	const lines = [
		'CREATE TABLE `creature_template` (',
		'  `Entry` mediumint unsigned NOT NULL DEFAULT \'0\',',
		'  `Name` char(100) NOT NULL DEFAULT \'\',',
		'  `MinLevel` tinyint unsigned NOT NULL DEFAULT \'1\',',
		'  `Faction` smallint unsigned NOT NULL DEFAULT \'0\',',
		'  `NpcFlags` int unsigned NOT NULL DEFAULT \'0\',',
		'  `ExtraFlags` int unsigned NOT NULL DEFAULT \'0\',',
		'  `Rank` tinyint unsigned NOT NULL DEFAULT \'0\',',
		'  PRIMARY KEY (`Entry`)',
		') ENGINE=MyISAM;',
		'INSERT INTO `creature_template` VALUES (68,\'Stormwind City Guard\',55,11,1,1024,0),(2405,\'Tarren Mill Deathguard\',55,71,1,1024,0),(9,\'O\\\'Neil, the (Test)\',3,7,0,0,1);',
	];
	const t = await extractCreatureTemplates(lines);
	assert.deepEqual(t[68], { name: 'Stormwind City Guard', faction: 11, npcFlags: 1, extraFlags: 1024, rank: 0, minLevel: 55 });
	assert.equal(t[9].name, 'O\'Neil, the (Test)');
	assert.equal(t[2405].faction, 71);
});

// --- the built layer -------------------------------------------------------------

const built = fs.existsSync(HUBS_FILE);
const skip = !built && 'no hubs layer (node tools/polestar.js nav layers hubs)';
const hubNamed = (hubs, c, name) => (hubs[c] || []).filter((h) => h.name === name);

test('the built layer: Alliance and Horde towns are hubs of their side; goblin towns are none', { skip }, () => {
	const hubs = JSON.parse(fs.readFileSync(HUBS_FILE, 'utf8'));
	for (const [c, name, side] of [[0, 'Southshore', 'Alliance'], [1, 'Astranaar', 'Alliance'], [1, 'Auberdine', 'Alliance'], [1, 'The Crossroads', 'Horde'], [0, 'Tarren Mill', 'Horde'], [1, 'Splintertree Post', 'Horde']]) {
		const found = hubNamed(hubs, c, name);
		assert.ok(found.length, `${name} is a hub`);
		assert.ok(found.every((h) => h.side === side), `${name} is ${side}`);
	}
	// Brackenwall Village (Dustwallow Marsh): its Enforcers make it a Horde hub.
	const brackenwall = (hubs[1] || []).filter((h) => h.disks.some(([hx, hy]) => Math.hypot(-3149 - hx, -2842 - hy) <= 100));
	assert.ok(brackenwall.length && brackenwall.every((h) => h.side === 'Horde'), `Brackenwall Village is a Horde hub: ${brackenwall.map((h) => `${h.side} ${h.name}`)}`);
	// Capitals are named as capitals, not by the chunk area under their WMOs.
	for (const [c, name] of [[0, 'Stormwind City'], [0, 'Ironforge'], [0, 'Undercity'], [1, 'Orgrimmar'], [1, 'Thunder Bluff'], [1, 'Darnassus']]) assert.ok(hubNamed(hubs, c, name).length, `${name} is a hub`);
	for (const [c, name] of [[0, 'Gates of Ironforge'], [0, 'Ruins of Lordaeron']]) assert.equal(hubNamed(hubs, c, name).length, 0, `no hub named ${name}`);
	// No hub at all at the goblin towns: by name or by a disk over their middle.
	for (const [c, name, x, y] of [[0, 'Booty Bay', -14297, 530], [1, 'Ratchet', -956, -3754], [1, 'Gadgetzan', -7150, -3785], [1, 'Everlook', 6724, -4610]]) {
		assert.equal(hubNamed(hubs, c, name).length, 0, `${name} is no hub`);
		const over = (hubs[c] || []).filter((h) => h.disks.some(([hx, hy, r]) => Math.hypot(x - hx, y - hy) <= r + 100));
		assert.deepEqual(over.map((h) => h.name), [], `no hub within 100 yd of ${name}`);
	}
});
