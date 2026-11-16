'use strict';
// #1735: Nearby services sent a player to Javnir Nashak outside Orgrimmar's gate, where nobody stands. He and the
// other vendors below are world-event vendors: Classic spawns them only for the event (CMaNGOS classicdb
// game_event_creature), Forever's world DB has no spawn of them, and players' recordings never met them. Their
// records (forever-db/corrections npcs.json, items.json) drop their roles and take them off the lists of the items
// they sell, so neither the data nor the Codex offers them as a vendor any more.
//
// Needs data/forever with its Codex (forge data build, forge data codex); skips without it.

const { test } = require('node:test');
const assert = require('node:assert/strict');
const fs = require('node:fs');
const path = require('node:path');
const { DATA, needs } = require('./helpers/data');

const EVENT_VENDORS = {
	13418: 'Kaymard Copperpinch', 13420: 'Penney Copperpinch', 13429: 'Nardstrum Copperpinch', 13430: 'Jaycrue Copperpinch',
	13432: 'Seersa Copperpinch', 13433: 'Wulmort Jinglepocket', 13434: 'Macey Jinglepocket', 13435: 'Khole Jinglepocket',
	13436: 'Guchie Jinglepocket', 14480: 'Alowicious Czervik', 14481: 'Emmithue Smails', 15011: 'Wagner Hammerstrike',
	15012: 'Javnir Nashak', 15197: 'Darkcaller Yanka', 15199: 'Sergeant Hartman', 15353: 'Katrina Shimmerstar',
	15354: 'Rachelle Gothena', 15734: 'Ironforge Commendation Officer', 15736: 'Orgrimmar Commendation Officer',
	15864: 'Valadar Starsong', 15898: 'Lunar Festival Vendor', 15909: 'Fariel Starsong',
};
const read = (f) => JSON.parse(fs.readFileSync(path.join(DATA, f), 'utf8'));

test('world-event vendors with no spawn in Forever are no vendor in the data or the Codex (#1735)', { skip: needs('npcs.json', 'items.json', 'codex/npcs.json') }, () => {
	const npcs = read('npcs.json');
	const items = read('items.json');
	const codex = read('codex/npcs.json');
	const sold = new Set();
	for (const it of Object.values(items)) for (const v of it.vendors || []) sold.add(v);
	for (const [id, name] of Object.entries(EVENT_VENDORS)) {
		assert.deepEqual(npcs[id]?.roles ?? [], [], `${name} (${id}): no roles in npcs.json`);
		assert.ok(!sold.has(Number(id)), `${name} (${id}): no item lists them as its vendor`);
		const roles = codex[id]?.roles ?? [];
		assert.ok(!roles.some((r) => r === 'vendor' || r.startsWith('sells:')), `${name} (${id}): no vendor role in the Codex (${roles})`);
	}
});
