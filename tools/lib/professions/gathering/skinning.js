'use strict';
// Skinnable beasts per zone (curated: npcs.json has no creature type). Only
// plain beasts are listed: wolves, cats, boars, bears, raptors, crocolisks,
// plainstriders, kodos, scorpids, basilisks, turtles, apes, yetis, owlbeasts,
// hippogryphs, stags, dinosaurs. Spiders, humanoids, demons, dragonkin and
// birds of prey are left out. Levels and spawns come from npcs.json.
// A creature is only taken when the Forever world database can skin it
// (skinnable.json: type Beast, or skinning loot): Forever makes some of the
// listed kinds humanoids or demons with no skinning loot, the owlbeasts among
// them (#4504).

const fs = require('node:fs');
const path = require('node:path');
const { bandWeight, skinningReq } = require('./tables');
const { dist } = require('../../route/geo');
const { allPoints } = require('./route');

const SKINNABLE_FILE = path.join(__dirname, 'skinnable.json');
const SKINNABLE_ABOUT = 'The creatures of npcs.json the Forever TrinityCore world database lets a player skin: creature_template type 1 (Beast), or a SkinLootID in creature_template_difficulty (difficulty 0). Written by `node tools/polestar.js profession gathering skinnable`; read by the Skinning loops (tools/lib/professions/gathering/skinning.js).';
let skinnableSet = null;
function skinnable() {
	if (!skinnableSet) skinnableSet = new Set(fs.existsSync(SKINNABLE_FILE) ? JSON.parse(fs.readFileSync(SKINNABLE_FILE, 'utf8')).ids : []);
	return skinnableSet;
}

// The skinnable creature ids among `npcs` (npcs.json), from the world database file.
function deriveSkinnable(tdbFile, npcs) {
	const { DatabaseSync } = require('node:sqlite');
	const db = new DatabaseSync(tdbFile, { readOnly: true });
	try {
		const rows = db.prepare('SELECT t.entry AS id, t.type AS type, COALESCE(d.SkinLootID, 0) AS skin FROM creature_template t LEFT JOIN creature_template_difficulty d ON d.Entry = t.entry AND d.DifficultyID = 0').all();
		return rows.filter((r) => npcs[r.id] && (Number(r.type) === 1 || Number(r.skin) > 0)).map((r) => Number(r.id)).sort((a, b) => a - b);
	} finally {
		db.close();
	}
}

function renderSkinnable(ids) {
	const lines = [];
	for (let i = 0; i < ids.length; i += 20) lines.push(`\t\t${ids.slice(i, i + 20).join(', ')}`);
	return `{\n\t"about": ${JSON.stringify(SKINNABLE_ABOUT)},\n\t"ids": [\n${lines.join(',\n')}\n\t]\n}\n`;
}

const BEASTS = {
	// Zephras Isle (Forever): the beasts the Forever TrinityCore DB gives skinning loot (SkinLootID).
	2521: ['Juvenile Vuldren', 'Vuldren', 'Vuldren Alpha', 'Prideclaw', 'Galestrider', 'Ornery Galestrider', 'Scrawny Ursera', 'Ursera Scavenger', 'Highlands Ursera', 'Hippogryph Youth', 'Hippogryph Protector', 'Shriekling Fledgling', 'Shadowgale Shriekling', 'Windsong Crawler', 'Cloudrunner'],
	1429: ['Young Wolf', 'Timber Wolf', 'Mangy Wolf', 'Stonetusk Boar', 'Rockhide Boar', 'Gray Forest Wolf', 'Young Forest Bear', 'Prowler'],
	1426: ['Ragged Young Wolf', 'Ragged Timber Wolf', 'Small Crag Boar', 'Crag Boar', 'Large Crag Boar', 'Elder Crag Boar', 'Scarred Crag Boar', 'Young Black Bear', 'Ice Claw Bear', 'Winter Wolf', 'Snow Tracker Wolf', 'Juvenile Snow Leopard', 'Snow Leopard'],
	1438: ['Young Thistle Boar', 'Thistle Boar', 'Young Nightsaber', 'Mangy Nightsaber', 'Nightsaber', 'Nightsaber Stalker', 'Elder Nightsaber'],
	1411: ['Mottled Boar', 'Dire Mottled Boar', 'Elder Mottled Boar', 'Durotar Tiger', 'Bloodtalon Taillasher', 'Bloodtalon Scythemaw', 'Scorpid Worker', 'Clattering Scorpid', 'Armored Scorpid', 'Venomtail Scorpid', 'Dreadmaw Crocolisk', 'Thunder Lizard'],
	1420: ['Duskbat', 'Mangy Duskbat', 'Greater Duskbat', 'Vampiric Duskbat', 'Decrepit Darkhound', 'Cursed Darkhound', 'Ravenous Darkhound'],
	1412: ['Plainstrider', 'Adult Plainstrider', 'Elder Plainstrider', 'Prairie Wolf', 'Prairie Stalker', 'Prairie Wolf Alpha', 'Mountain Cougar', 'Flatland Cougar', 'Flatland Prowler', 'Battleboar', 'Kodo Calf'],
	1433: ['Great Goretusk', 'Redridge Thrasher'],
	1423: ['Plaguehound Runt', 'Plaguehound', 'Frenzied Plaguehound'],
	1413: ['Plainstrider', 'Elder Plainstrider', 'Greater Plainstrider', 'Fleeting Plainstrider', 'Ornery Plainstrider', 'Prairie Wolf', 'Prairie Wolf Alpha', 'Dreadmaw Crocolisk', 'Zhevra Runner', 'Zhevra Charger', 'Savannah Huntress', 'Savannah Prowler', 'Savannah Highmane', 'Savannah Patriarch', 'Sunscale Lashtail', 'Sunscale Screecher', 'Sunscale Scytheclaw', 'Lost Barrens Kodo', 'Barrens Kodo', 'Thunder Lizard', 'Thunderhead', 'Venomtail Scorpid'],
	1436: ['Young Goretusk', 'Goretusk', 'Great Goretusk', 'Coyote', 'Coyote Packleader'],
	1432: ['Mountain Boar', 'Mangy Mountain Boar', 'Elder Mountain Boar', 'Elder Black Bear', 'Grizzled Black Bear', 'Black Bear Patriarch', 'Loch Crocolisk'],
	1439: ['Moonstalker Runt', 'Moonstalker', 'Moonstalker Sire', 'Moonstalker Matriarch', 'Thistle Bear', 'Rabid Thistle Bear', 'Grizzled Thistle Bear', 'Ghostpaw Runner'],
	1421: ['Worg', 'Mottled Worg', 'Bloodsnout Worg', 'Ferocious Grizzled Bear', 'Giant Grizzled Bear'],
	1424: ['Gray Bear', 'Vicious Gray Bear', 'Elder Gray Bear', 'Starving Mountain Lion', 'Feral Mountain Lion', 'Mountain Lion', 'Hulking Mountain Lion', 'Snapjaw', 'Cave Yeti', 'Ferocious Yeti', 'Mountain Yeti', 'Giant Yeti'],
	1416: ['Gray Bear', 'Elder Gray Bear', 'Mountain Lion', 'Hulking Mountain Lion', 'Snapjaw', 'Cave Yeti', 'Ferocious Yeti', 'Mountain Yeti', 'Giant Yeti'],
	1437: ['Mottled Raptor', 'Mottled Screecher', 'Mottled Scytheclaw', 'Mottled Razormaw', 'Highland Raptor', 'Highland Lashtail', 'Highland Razormaw', 'Elder Razormaw', 'Young Wetlands Crocolisk', 'Wetlands Crocolisk', 'Giant Wetlands Crocolisk'],
	1431: ['Starving Dire Wolf', 'Rabid Dire Wolf', 'Black Ravager Mastiff'],
	1440: ['Ashenvale Bear', 'Elder Ashenvale Bear', 'Giant Ashenvale Bear', 'Shadowhorn Stag', 'Elder Shadowhorn Stag', 'Ghostpaw Runner'],
	1442: ['Pridewing Wyvern', 'Blackened Basilisk', 'Singed Basilisk', 'Scorched Basilisk', 'Gritjaw Basilisk', 'Fledgling Chimaera', 'Twilight Runner'],
	1441: ['Highperch Wyvern', 'Needles Cougar', 'Crag Stalker', 'Scorpid Reaver', 'Scorpid Terror', 'Sparkleshell Tortoise', 'Sparkleshell Snapper', 'Saltstone Basilisk', 'Pesterhide Hyena'],
	1417: ['Highland Strider', 'Highland Thrasher', 'Highland Fleshstalker', 'Elder Gray Bear'],
	1434: ['Young Stranglethorn Tiger', 'Stranglethorn Tiger', 'Elder Stranglethorn Tiger', 'Young Panther', 'Panther', 'Shadowmaw Panther', 'Elder Shadowmaw Panther', 'Young Stranglethorn Raptor', 'Stranglethorn Raptor', 'Lashtail Raptor', 'Jungle Stalker', 'Young Jungle Stalker', 'Stone Maw Basilisk', 'Crystal Spine Basilisk', 'Cold Eye Basilisk', 'Thrashtail Basilisk', 'Ironjaw Basilisk', 'Mistvale Gorilla', 'Elder Mistvale Gorilla', 'Silverback Patriarch', 'River Crocolisk', 'Saltwater Crocolisk', 'Snapjaw Crocolisk'],
	1418: ['Crag Coyote', 'Feral Crag Coyote', 'Elder Crag Coyote', 'Rabid Crag Coyote', 'Ridge Stalker', 'Ridge Huntress', 'Ridge Stalker Patriarch'],
	1443: ['Scorpashi Snapper', 'Scorpashi Lasher', 'Scorpashi Venomlash', 'Aged Kodo', 'Dying Kodo', 'Ancient Kodo', 'Raging Thunder Lizard', 'Elder Thunder Lizard', 'Gritjaw Basilisk', 'Hulking Gritjaw Basilisk', 'Bonepaw Hyena'],
	1435: ['Young Sawtooth Crocolisk', 'Sawtooth Crocolisk', 'Sawtooth Snapper', 'Shadow Panther'],
	1445: ['Drywallow Crocolisk', 'Drywallow Snapper', 'Mottled Drywallow Crocolisk', 'Bloodfen Raptor', 'Bloodfen Screecher', 'Bloodfen Razormaw', 'Bloodfen Lashtail', 'Mudrock Tortoise', 'Mudrock Snapjaw'],
	1444: ['Groddoc Ape', 'Groddoc Thunderer', 'Ironfur Bear', 'Grizzled Ironfur Bear', 'Ironfur Patriarch', 'Longtooth Runner', 'Longtooth Howler', 'Rabid Longtooth', 'Feral Scar Yeti', 'Rage Scar Yeti', 'Frayfeather Hippogryph', 'Frayfeather Stagwing'],
	1446: ['Glasshide Basilisk', 'Scorpid Hunter', 'Scorpid Tail Lasher', 'Scorpid Dunestalker', 'Blisterpaw Hyena', 'Steeljaw Snapper', 'Fledgling Pterrordax'],
	1425: ['Silvermane Wolf', 'Silvermane Stalker', 'Vicious Owlbeast', 'Primitive Owlbeast', 'Savage Owlbeast', 'Saltwater Snapjaw'],
	1419: ['Snickerfang Hyena', 'Redstone Basilisk', 'Ashmane Boar'],
	1447: ['Thunderhead Hippogryph', 'Thunderhead Stagwing', 'Thunderhead Skystormer', 'Thunderhead Patriarch', 'Thunderhead Consort', 'Mosshoof Runner', 'Mosshoof Stag', 'Coralshell Tortoise'],
	1448: ['Angerclaw Bear', 'Angerclaw Grizzly', 'Angerclaw Mauler', 'Felpaw Wolf', 'Felpaw Scavenger', 'Felpaw Ravager'],
	1449: ['Ravasaur', 'Ravasaur Runner', 'Ravasaur Hunter', 'Venomhide Ravasaur', 'Un\'Goro Stomper', 'Un\'Goro Gorilla', 'Un\'Goro Thunderer', 'Young Diemetradon', 'Diemetradon', 'Elder Diemetradon', 'Fledgling Pterrordax', 'Pterrordax', 'Frenzied Pterrordax', 'Stonelash Scorpid'],
	1452: ['Frostsaber Cub', 'Frostsaber', 'Frostsaber Stalker', 'Frostsaber Huntress', 'Shardtooth Bear', 'Shardtooth Mauler', 'Elder Shardtooth', 'Rabid Shardtooth', 'Chillwind Chimaera', 'Ragged Owlbeast', 'Raging Owlbeast', 'Crazed Owlbeast', 'Moontouched Owlbeast', 'Berserk Owlbeast', 'Ice Thistle Yeti'],
	1428: ['Ember Worg', 'Slavering Ember Worg', 'Giant Ember Worg', 'Blackrock Worg', 'Venomtip Scorpid', 'Deathlash Scorpid', 'Firetail Scorpid'],
	1422: ['Diseased Black Bear', 'Diseased Grizzly', 'Diseased Wolf'],
	1451: ['Stonelash Scorpid'],
};

let byName = null;
function npcsByName(npcs) {
	if (byName && byName.src === npcs) return byName.map;
	const map = new Map();
	for (const n of Object.values(npcs)) {
		if (!map.has(n.name)) map.set(n.name, []);
		map.get(n.name).push(n);
	}
	byName = { src: npcs, map };
	return map;
}

// Hostile, non-elite, skinnable spawns on `map` of the listed beasts (the zone's curated list, or `names`: a
// route's own beasts, steps.js), weighted for the band [from, to). Point fields: id, name, req, level, w, pt.
function SKINNING_POINTS(ctx, map, from, to, names = BEASTS[map] || []) {
	const index = npcsByName(ctx.data.npcs);
	const can = skinnable();
	const out = [];
	for (const name of names) {
		for (const n of (index.get(name) || []).sort((a, b) => a.id - b.id)) {
			if (n.faction !== null && n.faction !== undefined) continue;
			if (n.rank && n.rank !== 'normal' && n.rank !== 0) continue;
			if (!can.has(Number(n.id))) continue;
			const s = n.spawns && n.spawns[String(map)];
			if (!s) continue;
			const req = skinningReq(n.level);
			const w = bandWeight(req, from, to);
			if (w <= 0) continue;
			for (const [x, y] of allPoints(s)) {
				const pt = ctx.project.point(map, x, y, s.f);
				if (out.some((p) => p.name === name && dist(p.pt, pt) < 5)) continue;
				out.push({ id: Number(n.id), name, req, level: n.level, w, pt });
			}
		}
	}
	return out;
}

module.exports = { BEASTS, SKINNING_POINTS, SKINNABLE_FILE, skinnable, deriveSkinnable, renderSkinnable };
