'use strict';
const test = require('node:test');
const assert = require('node:assert/strict');
const { extractSpawnHeights, extractTraining } = require('../tools/lib/travel/cmangos');

const lines = (arr) => (async function* () { for (const l of arr) yield l; })();

// Column order of the pinned dump's `creature` table.
const CREATE = [
	'CREATE TABLE `creature` (',
	'  `guid` int,', '  `id` int,', '  `map` int,', '  `spawnMask` int,', '  `position_x` float,', '  `position_y` float,', '  `position_z` float,', '  `orientation` float,', '  `spawntimesecsmin` int,', '  `spawntimesecsmax` int,', '  `spawndist` float,', '  `MovementType` int,',
	') ENGINE=MyISAM;',
];

test('spawn heights carry the respawn seconds as a 5th element', async () => {
	const out = await extractSpawnHeights(lines([...CREATE, "INSERT INTO `creature` VALUES (1,3,0,1,-10422.5,190.4,36.7,0,300,420,0,0);"]));
	assert.deepEqual(out.npc[3], [[0, -10422.5, 190.4, 36.7, 300]]);
});

test('training sums each class trainer template spell cost at its level, once per spell', async () => {
	const T = [
		'CREATE TABLE `creature_template` (', '  `Entry` int,', '  `Name` varchar,', '  `ModelId1` int,', '  `TrainerClass` int,', '  `TrainerTemplateId` int,', ') ENGINE=MyISAM;',
		'CREATE TABLE `npc_trainer_template` (', '  `entry` int,', '  `spell` int,', '  `spellcost` int,', '  `reqskill` int,', '  `reqskillvalue` int,', '  `reqlevel` int,', '  `condition_id` int,', ') ENGINE=MyISAM;',
		"INSERT INTO `creature_template` VALUES (911,'Llane',5,1,10),(912,'Other',6,1,10);",
		'INSERT INTO `npc_trainer_template` VALUES (10,100,10,0,0,4,0),(10,101,90,0,0,4,0),(10,102,200,0,0,6,0);',
	];
	const out = await extractTraining(lines(T));
	assert.deepEqual(out.classes.WARRIOR, { 4: 100, 6: 200 });
});

test('object facts: template type, the least positive spawn respawn and a chest\'s own loot rows', async () => {
	const { extractObjectFacts } = require('../tools/lib/travel/cmangos');
	const T = [
		'CREATE TABLE `gameobject` (', '  `guid` int,', '  `id` int,', '  `map` int,', '  `spawnMask` int,', '  `position_x` float,', '  `position_y` float,', '  `position_z` float,', '  `orientation` float,', '  `rotation0` float,', '  `rotation1` float,', '  `rotation2` float,', '  `rotation3` float,', '  `spawntimesecsmin` int,', '  `spawntimesecsmax` int,', ') ENGINE=MyISAM;',
		'CREATE TABLE `gameobject_loot_template` (', '  `entry` int,', '  `item` int,', '  `ChanceOrQuestChance` float,', '  `groupid` int,', '  `mincountOrRef` int,', '  `maxcount` int,', '  `condition_id` int,', '  `comments` varchar,', ') ENGINE=MyISAM;',
		'CREATE TABLE `gameobject_template` (', '  `entry` int,', '  `type` int,', '  `displayId` int,', '  `name` varchar,', '  `faction` int,', '  `flags` int,', '  `ExtraFlags` int,', '  `size` float,', '  `data0` int,', '  `data1` int,', ') ENGINE=MyISAM;',
		'INSERT INTO `gameobject` VALUES (1,177464,0,1,1,2,3,0,0,0,0,0,300,300),(2,177464,0,1,5,6,7,0,0,0,0,0,240,240),(3,152598,1,1,1,2,3,0,0,0,0,0,180,180),(4,152598,1,1,9,9,9,0,0,0,0,0,-1,-1),(5,177464,0,1,8,8,8,0,0,0,0,0,0,0);',
		"INSERT INTO `gameobject_loot_template` VALUES (14360,15043,-100,0,1,20,0,''),(14360,99,5,0,-7,1,0,'');",
		"INSERT INTO `gameobject_template` VALUES (177464,3,1,'Large Termite Mound',0,0,0,1,43,14360),(152598,8,1,'the First Tide Pool',0,0,0,1,0,20),(5,3,1,'Unused',0,0,0,1,0,0);",
	];
	const out = await extractObjectFacts(lines(T));
	assert.deepEqual(out[177464], { type: 3, respawn: 240, loot: { 15043: [-100, 1, 20] } });
	assert.deepEqual(out[152598], { type: 8, respawn: 180 });
	assert.equal(out[5], undefined);
});
