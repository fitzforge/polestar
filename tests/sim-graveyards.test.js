'use strict';
const test = require('node:test');
const assert = require('node:assert/strict');
const { extractGraveyards } = require('../tools/lib/travel/cmangos');
const { graveyardsFor, HEALER_YD } = require('../tools/lib/sim/graveyards');

async function* linesOf(text) {
	for (const l of text.split('\n')) yield l;
}

test('classic-db graveyards: game_graveyard_zone links (link_kind 0) and world_safe_locs by column name', async () => {
	const dump = [
		'CREATE TABLE `game_graveyard_zone` (',
		'  `id` mediumint unsigned NOT NULL DEFAULT \'0\',',
		'  `ghost_loc` mediumint unsigned NOT NULL,',
		'  `link_kind` tinyint unsigned NOT NULL DEFAULT \'0\',',
		'  `faction` smallint unsigned NOT NULL DEFAULT \'0\',',
		') ENGINE=MyISAM;',
		'INSERT INTO `game_graveyard_zone` VALUES (709,14,0,67),(32,14,0,0),(32,14,1,0),(5,1,0,469);',
		'CREATE TABLE `world_safe_locs` (',
		'  `id` int unsigned NOT NULL,',
		'  `map` int unsigned NOT NULL DEFAULT \'0\',',
		'  `x` float NOT NULL DEFAULT \'0\',',
		'  `y` float NOT NULL DEFAULT \'0\',',
		'  `z` float NOT NULL DEFAULT \'0\',',
		'  `o` float NOT NULL DEFAULT \'0\',',
		'  `name` varchar(50) NOT NULL DEFAULT \'\',',
		') ENGINE=InnoDB;',
		'INSERT INTO `world_safe_locs` VALUES (709,1,-634.62,-4296.04,40.5,0,\'Durotar, Valley of Trials\'),(32,1,233.458,-4793.73,10.1881,0.2,\'Durotar, Razor Hill\');',
	].join('\n');
	const g = await extractGraveyards(linesOf(dump));
	assert.deepEqual(g.links, [[5, 1, 469], [32, 14, 0], [709, 14, 67]]);
	assert.deepEqual(g.locs['709'], [1, -634.6, -4296, 40.5, 'Durotar, Valley of Trials']);
	assert.deepEqual(g.locs['32'], [1, 233.5, -4793.7, 10.2, 'Durotar, Razor Hill']);
});

test('a faction\'s graveyards: its team\'s and either team\'s links, continents only, each with a Spirit Healer nearby', () => {
	const extract = {
		links: [[1, 14, 67], [2, 14, 0], [3, 14, 469], [4, 14, 67], [5, 14, 67], [2, 17, 0]],
		locs: {
			1: [1, 100, 100, 0, 'Horde\'s'],
			2: [1, 1000, 1000, 0, 'either\'s'],
			3: [1, 2000, 2000, 0, 'Alliance\'s'],
			4: [1, 3000, 3000, 0, 'no healer'],
			5: [389, 0, 0, 0, 'an instance'],
		},
	};
	// Map 1411's frame: map percent (x, y) -> world (100 y, 100 x) on continent 1.
	const frames = { era: { 1411: { c: 1, left: 0, right: 10000, top: 0, bottom: 10000 } } };
	const healer = (x, y) => [y / 100, x / 100];
	const npcs = {
		6491: { id: 6491, name: 'Spirit Healer', roles: ['spirithealer'], spawns: { 1411: { pts: [healer(110, 100), healer(1000, 1050), healer(2000, 2000), healer(3000, 3000 + HEALER_YD + 1)] } } },
		7: { id: 7, name: 'Innkeeper', roles: ['innkeeper'], spawns: { 1411: { pts: [healer(5, 5)] } } },
	};
	const zones = { 1411: { id: 1411, name: 'Durotar', areaId: 14 } };
	const g = graveyardsFor(extract, 'Horde', { zones, npcs, frames });
	assert.deepEqual(g.areaOfMap, { 1411: 14 });
	assert.deepEqual(g.list.map((x) => [x.id, x.areas]), [[1, [14]], [2, [14, 17]]]);
	assert.deepEqual(g.noHealer, [{ id: 4, name: 'no healer', yd: HEALER_YD + 1 }]);
	assert.deepEqual(graveyardsFor(extract, 'Alliance', { zones, npcs, frames }).list.map((x) => x.id), [2, 3]);
});
