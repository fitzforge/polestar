'use strict';
// Curated creature IDs for skinning routes: each has a positive SkinLootID
// with skinning loot in the Forever world database (npcs.json supplies levels
// and spawns but no creature type or skinning loot). IDs, not names, since a
// name can belong to more than one creature.

const { bandWeight, skinningReq } = require('./tables');
const { dist } = require('../../route/geo');
const { allPoints } = require('./route');

const BEASTS = {
	2521: [ // Zephras Isle
		250873 /* Juvenile Vuldren */, 250868 /* Vuldren */, 250874 /* Vuldren Alpha */,
		251245 /* Prideclaw */, 251661 /* Galestrider */, 251707 /* Ornery Galestrider */,
		250926 /* Scrawny Ursera */, 250937 /* Ursera Scavenger */, 250928 /* Highlands Ursera */,
		251291 /* Hippogryph Youth */, 251284 /* Hippogryph Protector */,
		253282 /* Shriekling Fledgling */, 256092 /* Shadowgale Shriekling */,
		254588 /* Windsong Crawler */, 271712 /* Cloudrunner */,
	],
	1429: [ // Elwynn Forest
		299 /* Young Wolf */, 69 /* Timber Wolf */, 525 /* Mangy Wolf */, 113 /* Stonetusk Boar */,
		524 /* Rockhide Boar */, 1922 /* Gray Forest Wolf */, 822 /* Young Forest Bear */,
		118 /* Prowler */,
	],
	1426: [ // Dun Morogh
		705 /* Ragged Young Wolf */, 704 /* Ragged Timber Wolf */, 708 /* Small Crag Boar */,
		1125 /* Crag Boar */, 1126 /* Large Crag Boar */, 1127 /* Elder Crag Boar */,
		1689 /* Scarred Crag Boar */, 1128 /* Young Black Bear */, 1196 /* Ice Claw Bear */,
		1131 /* Winter Wolf */, 1138 /* Snow Tracker Wolf */, 1199 /* Juvenile Snow Leopard */,
		1201 /* Snow Leopard */,
	],
	1438: [ // Teldrassil
		1984 /* Young Thistle Boar */, 1985 /* Thistle Boar */, 2031 /* Young Nightsaber */,
		2032 /* Mangy Nightsaber */, 2042 /* Nightsaber */, 2043 /* Nightsaber Stalker */,
		2033 /* Elder Nightsaber */,
	],
	1411: [ // Durotar
		3098 /* Mottled Boar */, 3099 /* Dire Mottled Boar */, 3100 /* Elder Mottled Boar */,
		3121 /* Durotar Tiger */, 3122 /* Bloodtalon Taillasher */, 3123 /* Bloodtalon Scythemaw */,
		3124 /* Scorpid Worker */, 3125 /* Clattering Scorpid */, 3126 /* Armored Scorpid */,
		3127 /* Venomtail Scorpid */, 3110 /* Dreadmaw Crocolisk */, 3130 /* Thunder Lizard */,
	],
	1420: [ // Tirisfal Glades
		1512 /* Duskbat */, 1513 /* Mangy Duskbat */, 1553 /* Greater Duskbat */,
		1554 /* Vampiric Duskbat */, 1547 /* Decrepit Darkhound */, 1548 /* Cursed Darkhound */,
		1549 /* Ravenous Darkhound */,
	],
	1412: [ // Mulgore
		2955 /* Plainstrider */, 2956 /* Adult Plainstrider */, 2957 /* Elder Plainstrider */,
		2958 /* Prairie Wolf */, 2959 /* Prairie Stalker */, 2960 /* Prairie Wolf Alpha */,
		2961 /* Mountain Cougar */, 3035 /* Flatland Cougar */, 3566 /* Flatland Prowler */,
		2966 /* Battleboar */, 2972 /* Kodo Calf */,
	],
	1433: [ // Redridge Mountains
		547 /* Great Goretusk */,
	],
	1423: [ // Eastern Plaguelands
		8596 /* Plaguehound Runt */, 8597 /* Plaguehound */, 8598 /* Frenzied Plaguehound */,
	],
	1413: [ // The Barrens
		2955 /* Plainstrider */, 2957 /* Elder Plainstrider */, 3244 /* Greater Plainstrider */,
		3246 /* Fleeting Plainstrider */, 3245 /* Ornery Plainstrider */, 2958 /* Prairie Wolf */,
		2960 /* Prairie Wolf Alpha */, 3110 /* Dreadmaw Crocolisk */, 3242 /* Zhevra Runner */,
		3426 /* Zhevra Charger */, 3415 /* Savannah Huntress */, 3425 /* Savannah Prowler */,
		3243 /* Savannah Highmane */, 3241 /* Savannah Patriarch */, 3254 /* Sunscale Lashtail */,
		3255 /* Sunscale Screecher */, 3256 /* Sunscale Scytheclaw */, 3234 /* Lost Barrens Kodo */,
		3236 /* Barrens Kodo */, 3130 /* Thunder Lizard */, 3239 /* Thunderhead */,
		3127 /* Venomtail Scorpid */,
	],
	1436: [ // Westfall
		454 /* Young Goretusk */, 157 /* Goretusk */, 547 /* Great Goretusk */, 834 /* Coyote */,
		833 /* Coyote Packleader */,
	],
	1432: [ // Loch Modan
		1190 /* Mountain Boar */, 1191 /* Mangy Mountain Boar */, 1192 /* Elder Mountain Boar */,
		1186 /* Elder Black Bear */, 1188 /* Grizzled Black Bear */, 1189 /* Black Bear Patriarch */,
		1693 /* Loch Crocolisk */,
	],
	1439: [ // Darkshore
		2070 /* Moonstalker Runt */, 2069 /* Moonstalker */, 2237 /* Moonstalker Sire */,
		2071 /* Moonstalker Matriarch */, 2163 /* Thistle Bear */, 2164 /* Rabid Thistle Bear */,
		2165 /* Grizzled Thistle Bear */, 3823 /* Ghostpaw Runner */,
	],
	1421: [ // Silverpine Forest
		1765 /* Worg */, 1766 /* Mottled Worg */, 1923 /* Bloodsnout Worg */,
		1778 /* Ferocious Grizzled Bear */, 1797 /* Giant Grizzled Bear */,
	],
	1424: [ // Hillsbrad Foothills
		2351 /* Gray Bear */, 2354 /* Vicious Gray Bear */, 2356 /* Elder Gray Bear */,
		2384 /* Starving Mountain Lion */, 2385 /* Feral Mountain Lion */, 2406 /* Mountain Lion */,
		2407 /* Hulking Mountain Lion */, 2408 /* Snapjaw */, 2248 /* Cave Yeti */,
		2249 /* Ferocious Yeti */, 2250 /* Mountain Yeti */, 2251 /* Giant Yeti */,
	],
	1416: [ // Alterac Mountains
		2351 /* Gray Bear */, 2356 /* Elder Gray Bear */, 2406 /* Mountain Lion */,
		2407 /* Hulking Mountain Lion */, 2408 /* Snapjaw */, 2248 /* Cave Yeti */,
		2249 /* Ferocious Yeti */, 2250 /* Mountain Yeti */, 2251 /* Giant Yeti */,
	],
	1437: [ // Wetlands
		1020 /* Mottled Raptor */, 1021 /* Mottled Screecher */, 1022 /* Mottled Scytheclaw */,
		1023 /* Mottled Razormaw */, 1015 /* Highland Raptor */, 1016 /* Highland Lashtail */,
		1018 /* Highland Razormaw */, 1019 /* Elder Razormaw */, 1417 /* Young Wetlands Crocolisk */,
		1400 /* Wetlands Crocolisk */, 2089 /* Giant Wetlands Crocolisk */,
	],
	1431: [ // Duskwood
		213 /* Starving Dire Wolf */, 565 /* Rabid Dire Wolf */, 1258 /* Black Ravager Mastiff */,
	],
	1440: [ // Ashenvale
		3809 /* Ashenvale Bear */, 3810 /* Elder Ashenvale Bear */, 3811 /* Giant Ashenvale Bear */,
		3817 /* Shadowhorn Stag */, 3818 /* Elder Shadowhorn Stag */, 3823 /* Ghostpaw Runner */,
	],
	1442: [ // Stonetalon Mountains
		4012 /* Pridewing Wyvern */, 4044 /* Blackened Basilisk */, 4042 /* Singed Basilisk */,
		4041 /* Scorched Basilisk */, 4728 /* Gritjaw Basilisk */, 4031 /* Fledgling Chimaera */,
		4067 /* Twilight Runner */,
	],
	1441: [ // Thousand Needles
		4107 /* Highperch Wyvern */, 4124 /* Needles Cougar */, 4126 /* Crag Stalker */,
		4140 /* Scorpid Reaver */, 4139 /* Scorpid Terror */, 4142 /* Sparkleshell Tortoise */,
		4143 /* Sparkleshell Snapper */, 4147 /* Saltstone Basilisk */, 4248 /* Pesterhide Hyena */,
	],
	1417: [ // Arathi Highlands
		2559 /* Highland Strider */, 2560 /* Highland Thrasher */, 2561 /* Highland Fleshstalker */,
		2356 /* Elder Gray Bear */,
	],
	1434: [ // Stranglethorn Vale
		681 /* Young Stranglethorn Tiger */, 682 /* Stranglethorn Tiger */,
		1085 /* Elder Stranglethorn Tiger */, 683 /* Young Panther */, 736 /* Panther */,
		684 /* Shadowmaw Panther */, 1713 /* Elder Shadowmaw Panther */,
		855 /* Young Stranglethorn Raptor */, 685 /* Stranglethorn Raptor */, 686 /* Lashtail Raptor */,
		687 /* Jungle Stalker */, 854 /* Young Jungle Stalker */, 688 /* Stone Maw Basilisk */,
		689 /* Crystal Spine Basilisk */, 690 /* Cold Eye Basilisk */, 1550 /* Thrashtail Basilisk */,
		1551 /* Ironjaw Basilisk */, 1108 /* Mistvale Gorilla */, 1557 /* Elder Mistvale Gorilla */,
		1558 /* Silverback Patriarch */, 1150 /* River Crocolisk */, 1151 /* Saltwater Crocolisk */,
		1152 /* Snapjaw Crocolisk */,
	],
	1418: [ // Badlands
		2727 /* Crag Coyote */, 2728 /* Feral Crag Coyote */, 2729 /* Elder Crag Coyote */,
		2730 /* Rabid Crag Coyote */, 2731 /* Ridge Stalker */, 2732 /* Ridge Huntress */,
		2734 /* Ridge Stalker Patriarch */,
	],
	1443: [ // Desolace
		4696 /* Scorpashi Snapper */, 4697 /* Scorpashi Lasher */, 4699 /* Scorpashi Venomlash */,
		4700 /* Aged Kodo */, 4701 /* Dying Kodo */, 4702 /* Ancient Kodo */,
		4726 /* Raging Thunder Lizard */, 4727 /* Elder Thunder Lizard */, 4728 /* Gritjaw Basilisk */,
		4729 /* Hulking Gritjaw Basilisk */, 4688 /* Bonepaw Hyena */,
	],
	1435: [ // Swamp of Sorrows
		1084 /* Young Sawtooth Crocolisk */, 1082 /* Sawtooth Crocolisk */, 1087 /* Sawtooth Snapper */,
		768 /* Shadow Panther */,
	],
	1445: [ // Dustwallow Marsh
		4341 /* Drywallow Crocolisk */, 4343 /* Drywallow Snapper */,
		4344 /* Mottled Drywallow Crocolisk */, 4351 /* Bloodfen Raptor */, 4352 /* Bloodfen Screecher */,
		4356 /* Bloodfen Razormaw */, 4357 /* Bloodfen Lashtail */, 4396 /* Mudrock Tortoise */,
		4400 /* Mudrock Snapjaw */,
	],
	1444: [ // Feralas
		5260 /* Groddoc Ape */, 5262 /* Groddoc Thunderer */, 5268 /* Ironfur Bear */,
		5272 /* Grizzled Ironfur Bear */, 5274 /* Ironfur Patriarch */, 5286 /* Longtooth Runner */,
		5287 /* Longtooth Howler */, 5288 /* Rabid Longtooth */, 5292 /* Feral Scar Yeti */,
		5296 /* Rage Scar Yeti */, 5300 /* Frayfeather Hippogryph */, 5304 /* Frayfeather Stagwing */,
	],
	1446: [ // Tanaris
		5419 /* Glasshide Basilisk */, 5422 /* Scorpid Hunter */, 5423 /* Scorpid Tail Lasher */,
		5424 /* Scorpid Dunestalker */, 5426 /* Blisterpaw Hyena */, 14123 /* Steeljaw Snapper */,
		9165 /* Fledgling Pterrordax */,
	],
	1425: [ // The Hinterlands
		2924 /* Silvermane Wolf */, 2926 /* Silvermane Stalker */, 2505 /* Saltwater Snapjaw */,
	],
	1419: [ // Blasted Lands
		5985 /* Snickerfang Hyena */, 5990 /* Redstone Basilisk */, 5992 /* Ashmane Boar */,
	],
	1447: [ // Azshara
		6375 /* Thunderhead Hippogryph */, 6377 /* Thunderhead Stagwing */,
		6378 /* Thunderhead Skystormer */, 6379 /* Thunderhead Patriarch */,
		6380 /* Thunderhead Consort */, 8759 /* Mosshoof Runner */, 8760 /* Mosshoof Stag */,
		6369 /* Coralshell Tortoise */,
	],
	1448: [ // Felwood
		8956 /* Angerclaw Bear */, 8957 /* Angerclaw Grizzly */, 8958 /* Angerclaw Mauler */,
		8959 /* Felpaw Wolf */, 8960 /* Felpaw Scavenger */, 8961 /* Felpaw Ravager */,
	],
	1449: [ // Un'Goro Crater
		6505 /* Ravasaur */, 6506 /* Ravasaur Runner */, 6507 /* Ravasaur Hunter */,
		6508 /* Venomhide Ravasaur */, 6513 /* Un'Goro Stomper */, 6514 /* Un'Goro Gorilla */,
		6516 /* Un'Goro Thunderer */, 9162 /* Young Diemetradon */, 9163 /* Diemetradon */,
		9164 /* Elder Diemetradon */, 9165 /* Fledgling Pterrordax */, 9166 /* Pterrordax */,
		9167 /* Frenzied Pterrordax */, 11735 /* Stonelash Scorpid */,
	],
	1452: [ // Winterspring
		7430 /* Frostsaber Cub */, 7431 /* Frostsaber */, 7432 /* Frostsaber Stalker */,
		7433 /* Frostsaber Huntress */, 7444 /* Shardtooth Bear */, 7443 /* Shardtooth Mauler */,
		7445 /* Elder Shardtooth */, 7446 /* Rabid Shardtooth */, 7448 /* Chillwind Chimaera */,
		7458 /* Ice Thistle Yeti */,
	],
	1428: [ // Burning Steppes
		9690 /* Ember Worg */, 9694 /* Slavering Ember Worg */, 9697 /* Giant Ember Worg */,
		7055 /* Blackrock Worg */, 9691 /* Venomtip Scorpid */, 9695 /* Deathlash Scorpid */,
		9698 /* Firetail Scorpid */,
	],
	1422: [ // Western Plaguelands
		1815 /* Diseased Black Bear */, 1816 /* Diseased Grizzly */, 1817 /* Diseased Wolf */,
	],
	1451: [ // Silithus
		11735 /* Stonelash Scorpid */,
	],
};

// Hostile, non-elite spawns on `map` of the listed beasts, weighted for the
// band [from, to). Point fields: name, req, level, w, pt.
function SKINNING_POINTS(ctx, map, from, to) {
	const ids = BEASTS[map] || [];
	const out = [];
	for (const id of ids) {
		const n = ctx.data.npcs[id];
		if (!n) continue;
		const name = n.name;
		if (n.faction !== null && n.faction !== undefined) continue;
		if (n.rank && n.rank !== 'normal' && n.rank !== 0) continue;
		const s = n.spawns && n.spawns[String(map)];
		if (!s) continue;
		const req = skinningReq(n.level);
		const w = bandWeight(req, from, to);
		if (w <= 0) continue;
		for (const [x, y] of allPoints(s)) {
			const pt = ctx.project.point(map, x, y, s.f);
			if (out.some((p) => p.name === name && dist(p.pt, pt) < 5)) continue;
			out.push({ name, req, level: n.level, w, pt });
		}
	}
	return out;
}

module.exports = { BEASTS, SKINNING_POINTS };
