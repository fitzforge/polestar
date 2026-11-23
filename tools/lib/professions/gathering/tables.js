'use strict';
// Curated game-mechanics tables for the gathering profession guides
// (guides/forever/professions/{mining,herbalism,skinning,fishing}.guide).
// Classic rules, which Forever keeps for 1-300 as far as anything public says:
//
// - A node needs `req` skill. Gathering it raises the skill always while the
//   skill is below req+25 (orange), usually below req+50 (yellow), rarely below
//   req+100 (green), never after (grey).
// - Ranks: Apprentice (max 75), Journeyman (learn at 50, max 150), Expert
//   (learn at 125, max 225), Artisan (learn at 200, max 300). Forever asks no
//   character level for a gathering rank: its sniffed trainer lists carry
//   ReqLevel 0 for every Herbalism, Mining and Skinning rank, against 10 for
//   Journeyman Blacksmithing, Leatherworking, Tailoring and Fishing.
// - Skinning: a beast of level L needs skill 1 (L <= 10), (L - 10) * 10
//   (L 11-20) or L * 5 (L > 20).

// Relative skill-up value by color, used to weigh nodes against each other:
// orange always raises the skill, yellow usually, green seldom.
const COLOR_WEIGHT = { orange: 1, yellow: 0.6, green: 0.15, grey: 0 };

function color(skill, req) {
	if (skill < req) return null; // cannot gather
	if (skill < req + 25) return 'orange';
	if (skill < req + 50) return 'yellow';
	if (skill < req + 100) return 'green';
	return 'grey';
}

// Mean skill-up weight of a node across a skill band [from, to).
function bandWeight(req, from, to) {
	let sum = 0;
	for (let s = from; s < to; s++) {
		const c = color(s, req);
		sum += c ? COLOR_WEIGHT[c] : 0;
	}
	return to > from ? sum / (to - from) : 0;
}

// Ore nodes by objects.json name. Ooze-covered nodes (an ooze guards them),
// instance-only nodes (Indurium: Uldaman; Hakkari Thorium: Zul'Gurub;
// Obsidian: Ahn'Qiraj) and Alterac Valley are left out of routes.
const MINING_NODES = {
	'Copper Vein': 1,
	// Forever's starting-area vein (Copper Ore and Rough Stone, the Copper Vein's lock).
	'Poor Copper Vein': 1,
	// Forever's Teldrassil nodes (Rough Stone, Copper Ore, Pyrite): mined from skill 1 in players' recordings.
	'Chunk of Amber': 1,
	'Large Chunk of Amber': 1,
	'Tin Vein': 65,
	'Incendicite Mineral Vein': 65,
	'Silver Vein': 75,
	'Lesser Bloodstone Deposit': 75,
	'Iron Deposit': 125,
	'Gold Vein': 155,
	'Mithril Deposit': 175,
	'Truesilver Deposit': 230,
	'Dark Iron Deposit': 230,
	'Small Thorium Vein': 245,
	'Rich Thorium Vein': 275,
};

// Herb nodes by objects.json name.
const HERB_NODES = {
	Peacebloom: 1,
	Silverleaf: 1,
	// Forever's starting-area herbs (the Peacebloom and Silverleaf lock and loot).
	'Wilted Peacebloom': 1,
	'Stunted Silverleaf': 1,
	Earthroot: 15,
	Mageroyal: 50,
	Briarthorn: 70,
	Stranglekelp: 85,
	Bruiseweed: 100,
	'Wild Steelbloom': 115,
	'Grave Moss': 120,
	Kingsblood: 125,
	Liferoot: 150,
	Fadeleaf: 160,
	Goldthorn: 170,
	"Khadgar's Whisker": 185,
	Wintersbite: 195,
	Firebloom: 205,
	'Purple Lotus': 210,
	"Arthas' Tears": 220,
	Sungrass: 230,
	Blindweed: 235,
	'Ghost Mushroom': 245,
	Gromsblood: 250,
	'Golden Sansam': 260,
	Dreamfoil: 270,
	'Mountain Silversage': 280,
	Plaguebloom: 285,
	Icecap: 290,
	'Black Lotus': 300,
};

// Forever's starting-area nodes (sniffed on Forever's beta or listed in Forever's
// quest data; no role in objects.json).
const FOREVER_NODES = new Set(['Poor Copper Vein', 'Chunk of Amber', 'Large Chunk of Amber', 'Wilted Peacebloom', 'Stunted Silverleaf']);

function skinningReq(level) {
	if (level <= 10) return 1;
	if (level <= 20) return (level - 10) * 10;
	return level * 5;
}

const RANKS = [
	{ name: 'Apprentice', learnAt: 0, max: 75 },
	{ name: 'Journeyman', learnAt: 50, max: 150 },
	{ name: 'Expert', learnAt: 125, max: 225 },
	{ name: 'Artisan', learnAt: 200, max: 300 },
];

// Open-world zones a gathering route may use. side: which factions can work
// there with a nearby friendly town ('AH' = both). Classic level ranges.
// Waypoints are written in the Era frame of the node data (`coords era`); the
// engine converts them on maps whose frame Forever changed (Mulgore,
// Redridge Mountains, Eastern Plaguelands).
const ZONES = {
	1429: { name: 'Elwynn Forest', min: 1, max: 10, side: 'A' },
	1426: { name: 'Dun Morogh', min: 1, max: 10, side: 'A' },
	1438: { name: 'Teldrassil', min: 1, max: 10, side: 'A' },
	1411: { name: 'Durotar', min: 1, max: 10, side: 'H' },
	1412: { name: 'Mulgore', min: 1, max: 10, side: 'H' },
	1420: { name: 'Tirisfal Glades', min: 1, max: 10, side: 'H' },
	2521: { name: 'Zephras Isle', min: 1, max: 15, side: 'AH' },
	1436: { name: 'Westfall', min: 10, max: 20, side: 'A' },
	1432: { name: 'Loch Modan', min: 10, max: 20, side: 'A' },
	1439: { name: 'Darkshore', min: 10, max: 20, side: 'A' },
	1413: { name: 'The Barrens', min: 10, max: 25, side: 'H' },
	1421: { name: 'Silverpine Forest', min: 10, max: 20, side: 'H' },
	1442: { name: 'Stonetalon Mountains', min: 15, max: 27, side: 'AH' },
	1431: { name: 'Duskwood', min: 18, max: 30, side: 'A' },
	1440: { name: 'Ashenvale', min: 18, max: 30, side: 'AH' },
	1433: { name: 'Redridge Mountains', min: 15, max: 25, side: 'A' },
	1437: { name: 'Wetlands', min: 20, max: 30, side: 'A' },
	1424: { name: 'Hillsbrad Foothills', min: 20, max: 30, side: 'AH' },
	1441: { name: 'Thousand Needles', min: 25, max: 35, side: 'AH' },
	1416: { name: 'Alterac Mountains', min: 30, max: 40, side: 'AH' },
	1417: { name: 'Arathi Highlands', min: 30, max: 40, side: 'AH' },
	1443: { name: 'Desolace', min: 30, max: 40, side: 'AH' },
	1434: { name: 'Stranglethorn Vale', min: 30, max: 45, side: 'AH' },
	1418: { name: 'Badlands', min: 35, max: 45, side: 'AH' },
	1435: { name: 'Swamp of Sorrows', min: 35, max: 45, side: 'AH' },
	1445: { name: 'Dustwallow Marsh', min: 35, max: 45, side: 'AH' },
	1444: { name: 'Feralas', min: 40, max: 50, side: 'AH' },
	1446: { name: 'Tanaris', min: 40, max: 50, side: 'AH' },
	1425: { name: 'The Hinterlands', min: 40, max: 50, side: 'AH' },
	1427: { name: 'Searing Gorge', min: 43, max: 50, side: 'AH' },
	1419: { name: 'Blasted Lands', min: 45, max: 55, side: 'AH' },
	1447: { name: 'Azshara', min: 45, max: 55, side: 'AH' },
	1448: { name: 'Felwood', min: 48, max: 55, side: 'AH' },
	1449: { name: "Un'Goro Crater", min: 48, max: 55, side: 'AH' },
	1428: { name: 'Burning Steppes', min: 50, max: 58, side: 'AH' },
	1422: { name: 'Western Plaguelands', min: 51, max: 58, side: 'AH' },
	1423: { name: 'Eastern Plaguelands', min: 53, max: 60, side: 'AH' },
	1452: { name: 'Winterspring', min: 55, max: 60, side: 'AH' },
	1451: { name: 'Silithus', min: 55, max: 60, side: 'AH' },
};

module.exports = {
	COLOR_WEIGHT,
	color,
	bandWeight,
	MINING_NODES,
	HERB_NODES,
	FOREVER_NODES,
	skinningReq,
	RANKS,
	ZONES,
};
