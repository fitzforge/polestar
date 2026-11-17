'use strict';
// Player-reported guide fixes: checks across both factions' guides, and the records and data they read.
// tests/reported/helpers.js says what the cases check and where a new one goes.

const { test } = require('node:test');
const assert = require('node:assert/strict');
const fs = require('node:fs');
const path = require('node:path');
const {
	allGuides, ARATHI, ASHENVALE, ASHENVALE_30, ASHENVALE_HORDE, at, atAuctionHouse, BADLANDS, BARRENS, compiled,
	compileProject, DARKSHORE, DARKSHORE_RETURN, DATA, Diagnostics, directNeeds, dist, DUN_MOROGHS, dungeonKey, DUROTARS,
	ELWYNN, engineRun, forAllOnly, forClass, goals, headers, HILLSBRAD_ALLIANCE, HILLSBRAD_HORDE, hillsbradChains, is,
	loadCorrections, located, LOCH_MODAN, makeProjector, MULGORE, NAV, navIndex, needs, notesOf, OFFICIAL_DIR,
	parseGuide, REDRIDGE, refData, ROOT, routes, SILVERPINE, skip, stepsHolding, stepTips, stepView, STONETALON,
	STRANGLETHORN_HORDE, TELDRASSIL, TIRISFAL, UN_GORO_ALLIANCE, USE_ITEM_873, WESTFALL, WETLANDS, where, working, yards,
	ZEPHRAS_ALLIANCE, ZEPHRAS_HORDE,
} = require('./helpers');

const CAVES = [
	// Thazz'ril's Pick and Yarrog Baneshadow: "Go in the cave (45 56)".
	...DUROTARS.flatMap((guide) => [
		{ cave: 'the Burning Blade Coven (the pick)', guide, target: (g) => g.t === 'collect' && g.item === 16332, mouth: { map: 1411, x: 45, y: 56 } },
		{ cave: 'Skull Rock', guide, target: (g) => g.t === 'collect' && g.item === 4871, mouth: { map: 1411, x: 55, y: 10 } },
	]),
	...DUN_MOROGHS.flatMap((guide) => [
		// The troll cave's mouth as marked in game (thmastin, PR #16); players' reports put it near 26,79.
		{ cave: 'the Coldridge troll cave', guide, target: (g) => g.t === 'collect' && g.item === 2004, mouth: { map: 1426, x: 26.93, y: 80.03 } },
		// The Grizzled Den's mouth as marked in game (thmastin); Flintfire's shipments lie inside. Since the level tidy
		// (0.4.0) Frosthowl's fish, at the back of the same den, is taken on this one visit (no second visit from Brewnall).
		{ cave: 'the Grizzled Den', guide, target: (g) => g.t === 'collect' && g.item === 280413, mouth: { map: 1426, x: 42.57, y: 54.68 } },
		// Frostmane Hold's mouth as marked in game (thmastin); its Headhunters guard the way in.
		{ cave: 'Frostmane Hold', guide, target: (g) => g.t === 'kill' && g.quest === 287, mouth: { map: 1426, x: 25.1, y: 50.94 } },
	]),
	// The Mining Tools lie along the tunnel from the entrance: the first goal inside (#612).
	{ cave: 'the Jasperlode Mine', guide: ELWYNN, target: (g) => g.t === 'collect' && g.item === 247816, mouth: { map: 1429, x: 61.6, y: 54.1 } },
	// Pynte (#328): both mouths where the walk in reaches the cave's floor on the navigation grid, not a Classic comment's point beside it.
	{ cave: 'Shadowthread Cave', guide: TELDRASSIL, target: (g) => g.t === 'collect' && g.item === 5167, mouth: { map: 1438, x: 56.69, y: 31.29 } },
	{ cave: 'Fel Rock', guide: TELDRASSIL, target: (g) => g.t === 'collect' && g.item === 5221, mouth: { map: 1438, x: 54.59, y: 52.12 } },
	// The Webbed Forsaken are freed inside the cave: the cocoons' kill goal (#735).
	{ cave: "Night Web's Hollow", guide: TIRISFAL, target: (g) => g.t === 'kill' && g.npc === 271961, mouth: { map: 1420, x: 26, y: 60 } },
];

// Maazias's report (#1450): "walks you to a spot to do nothing": a travel-only step labelled with just the zone's name
// ("The Barrens", a goto south of Camp Taurajo on the way back from the Great Lift, where the hearth is bound) led a
// player who was already in Camp Taurajo back 1,200 yd. Guard over every leveling guide: a step whose only goal is a
// `goto` says where the walk leads (a town, an NPC, a camp), never just the zone's name (or "Back to"/"To" + the name).
// "Into <zone>" labels name a border crossing and stay. Exceptions go in ZONE_GOTO_ALLOW, "file|label" -> the reason.
// The same check for the release: ~/work/maintainer/zone-goto-sweep/srcsteps.py.
const ZONE_GOTO_ALLOW = {};

// The same pattern as #365: a quest item bought steps before its turn-in is
// asked for again on the turn-in step, from the same vendor (`nearest`: a
// vendor of the guide's faction), so a player who passed the first buy is
// not sent to the giver empty-handed. Done at once with the item in the bags.
// A buy earlier in the same town visit (every stop from it to the giver
// within a town's reach, no flight or hearth), or a tip on the turn-in step
// saying where to buy another, does the same.
const TOWN_YARDS = 200;
const BUY_AT_TURNIN = [
	// [guide, quest, item, count, vendor npc or 'H' for `nearest` on the Horde, what]
	['forever/alliance/30-40/01-hillsbrad-foothills.guide', 555, 3713, 1, 2381, 'the Soothing Spices for Chef Jessen'],
	['forever/alliance/40-50/01-stranglethorn-vale.guide', 1218, 3713, 3, 4897, 'the Soothing Spices for "Swamp Eye" Jarl, from Theramore'],
	['forever/horde/30-40/04-dustwallow-marsh.guide', 1218, 3713, 3, 'H', 'the Soothing Spices for "Swamp Eye" Jarl, bought in Orgrimmar at the start of the Dustwallow guide'],
	[TELDRASSIL, 99050, 3371, 1, 3614, 'the Empty Vial for Byancie'],
	[TELDRASSIL, 99050, 159, 1, 6736, 'the Refreshing Spring Water for Byancie'],
	['forever/collectibles/mounts/alliance/paladin-charger.guide', 7645, 13724, 20, 10857, 'the Enriched Manna Biscuits for Merideth Carlson, from Chillwind Camp'],
	['forever/collectibles/mounts/neutral/warlock-dreadsteed.guide', 7625, 18687, 1, 14522, "the Xorothian Stardust for Gorzeeki Wildeyes, from Ur'dan in Felwood"],
];
// Why step `st`'s required direct hand-in `goal` may sit there without its items, or null.
function directStuck(st, goal) {
	const before = st.goals.slice(0, st.goals.indexOf(goal));
	for (const [item, n] of directNeeds(goal.quest)) {
		const gated = (st.when || []).some((p) => p.k === 'has' && !p.neg && p.item === item && (p.n || 1) >= n);
		const gathered = before.some((g) => (g.t === 'collect' || g.t === 'buy') && g.item === item && !g.optional);
		if (!gated && !gathered) return `item ${item} x${n}: neither gathered in the step nor a \`when has\``;
	}
	return null;
}
const TANARIS_ALLIANCE = 'forever/alliance/40-50/04-tanaris.guide';

// Escorts and events start at their NPC in the step before and follow it, so
// a bare `complete` is right there: the arrow has the NPC to lead to.
const FOLLOWS_AN_NPC = new Set([
	5821, // Bodyguard for Hire: the Gizelton caravan escort (Desolace)
	665, // Sunken Treasure: escort Doctor Draxlegauge (Arathi Highlands)
	660, // Hints of a New Plague?: escort Kinelory (Arathi Highlands)
	4491, // A Little Help From My Friends: escort Ringo (Un'Goro Crater)
	863, // The Escape: escort Wizzlecrank (The Barrens)
	7622, // The Balance of Light and Shadow: the event at Eris Havenfire
]);

// A turn-in's place does not lead to the objective (Dun Morogh, Rumbleshot's
// Ammo: the arrow sent players to Hegnar while the Ammo Crate stands by
// Mountaineer Gretchen). When the data knows where every objective of a quest
// is (an item that drops from a spawned NPC or object, an object to use, or a
// place to reach: an area trigger with a position, like The Red Crystal's
// "Locate the large, red crystal", #241), a bare `complete` is not enough: the
// step needs a placed goal of its own for that quest (`collect <item> quest
// <id>.<n>`, `interact`, `complete <id> @x,y`) or a questless one (`goto`,
// `use @x,y`).
const OBJECTIVE_WITHOUT_A_PLACE = new Set([
	339, 340, 341, 342, // Green Hills of Stranglethorn: pages drop at random across the zone
	96605, 96608, // The Great Outdoors: the campfire is built with a spell, not clicked
	6134, // Ghost-o-plasm Round Up: the spectres come to the Ghost Magnets in the Kodo Graveyard, not their data spawn
	1149, // Test of Faith: the leap is from the planks beside Dorn Plainstalker (54,41.5); the data's trigger lies at 26.4,32.9, far from him
	1699, // The Rethban Gauntlet: the trigger is at the first fork inside the Rethban Caverns, and its mouth is not marked yet (tests/guides-caves.test.js)
]);
const navSkip =
	skip ||
	needs('travel.json', 'zones.json') ||
	(!navIndex ? 'no navigation build in data/local/nav (node tools/polestar.js nav build)' : navIndex.version !== require('../../tools/lib/nav/grid/format').VERSION ? `data/local/nav is tile version ${navIndex.version}: rebuild it (node tools/polestar.js nav build)` : false);

// --- Gnoll Paws (Bashidian Twotao, #385): Westfall's Gnoll Paws had no
// point, so the arrow searched every camp of every Gnoll Paw dropper in the
// zone, down to the level 16-19 Bandits, Taskmasters and Mystics in the
// south. A quest item whose droppers span level bands is hand-placed on the
// low ones the step means: the arrow leads to a camp of droppers at most two
// levels above the quest, not a search over the whole zone. The same
// held for Westfall's north coast murlocs, Darkshore's crawlers and
// threshers below Auberdine, the Barrens' plainstriders by the Crossroads,
// Silverpine's worgs and Vile Fins by the Yoricks' house and Hillsbrad's
// bears and lions west of Tarren Mill.
// (#1415: Westfall's murloc gills and eyes moved to a loop along the whole north coast, data/places.json's
// 385-westfall-murloc-gills path; their own test checks the loop stays on the north coast.)
const BY_LEVEL = [
	[WESTFALL, 725, 102],
	[DARKSHORE, 5385, 983],
	[DARKSHORE, 5412, 1001],
	['forever/horde/02-the-barrens.guide', 5087, 844],
	[SILVERPINE, 3164, 429],
	[SILVERPINE, 730, 91920],
	[HILLSBRAD_HORDE, 3476, 496],
	[HILLSBRAD_HORDE, 3496, 501],
];

// --- Fyurie's report (#977, Discord): Redridge "suddenly jumped from level 20/21 mobs to Fangore
// and a bunch of 24-25 mobs". The route took WANTED: Lieutenant Fangore (180, Fangore 26) and
// Solomon's Law (91) in Galardell Valley, whose Shadowhide gnolls are a median 24 (22-26), at the
// model's 21.4, and Bellygrub (34, level 24) at 20.3; the Old Lion Statue of A Watchful Eye (94) and
// Looking Further (248) stands among the same gnolls. The writer's level fit (docs/forge/writer.md,
// "Work at the player's level") leaves out work more than two levels above the player when the route
// never comes back to it at a level that fits; the statue's quests are route-fixes skips.
const LEVEL_FIT = [
	// [guide, quests left out, npcs no goal may send the player to]
	['forever/alliance/07-thousand-needles.guide', [1105, 1175, 1176], [4147, 4150, 4151]],
	['forever/horde/07-ashenvale.guide', [1105, 1175, 1176], [4147, 4150, 4151]],
	['forever/alliance/40-50/03-feralas.guide', [2844, 2845], [7774]],
	['forever/horde/50-60/01-un-goro-crater.guide', [5509], []],
];

// The #1699 sweep over the generated leveling guides, and the writer rule that keeps it (forge-writer
// post::direct_hand_ins, from quests.json `direct`: the server's quest type for a quest handed in on the
// spot). These quests never enter the log, so in every generated guide each is only a `direct` turn-in:
// no accept (it never ticks and held its step until the hand-in: the Videre Elixir, the Scourgestones,
// Salve via Hunting, Beads for Salfa), no objective bound to it (its collects are plain, with its count:
// Unbagwa's ten Gorilla Fangs) and no `when onquest`/`when complete` on it (never true: the Runecloth
// donations' steps read `when has 14047 x60`).
const HANDED_IN_ON_THE_SPOT = [
	247, 349, 1185, 1191, 1267, 1271, 1878, 2399, 2741, 2881, 3570, 3721, 3803, 3804, 4041, 5058, 5059, 5060, 5237, 5238, 5401,
	5402, 5403, 5405, 5407, 5408, 5503, 5505, 5509, 5510, 5658, 5676, 5680, 5887, 6383, 7791, 7793, 7794, 7795, 7802, 7803,
	7804, 7805, 7807, 7808, 7809, 7811, 7820, 7821, 7822, 7824, 7826, 7827, 7831, 7833, 7834, 7835, 7836, 8263, 8273, 8466,
	8467, 8469, 91899, 91904,
];

// Follow-ups a giver offers only once the quest before them is handed in: the route asked for both on one
// visit and the giver had nothing. A route may leave the follow-up out; it may never take it early.
const FOLLOW_UPS = [
	{ side: 'Horde', quest: 96656, after: [382], says: 'The Adventurer is never accepted before The Red Messenger is handed in (#792)' },
	{ side: 'Horde', quest: 99142, after: [5482], says: 'Tomb Weed is never accepted before Doom Weed is handed in (#800)' },
	{ side: 'Horde', quest: 98601, after: [364], says: 'A Difficult Path is never accepted before The Mindless Ones is handed in (#830)' },
	{ side: 'Horde', quest: 97225, after: [805], says: "Forgotten Loa Idols is never accepted before Report to Sen'jin Village is handed in (#796)" },
	{ side: 'Horde', quest: 97282, after: [97281], says: 'Stormy Potential is never accepted before A Simmering Storm is handed in (#807)' },
	{ side: 'Horde', quest: 95981, after: [482], says: "Watching the Roads is never accepted before Dalaran's Intentions is handed in (#872)" },
	{ side: 'Horde', quest: 97275, after: [97242], says: "Whuut's the Rush is never accepted before Yelmak's Medley is handed in (#891)" },
	{ side: 'Horde', quest: 98252, after: [98251], says: 'A Void Path is never accepted before Never Coming Back is handed in (#984, #1002)' },
	{ side: 'Horde', quest: 96261, after: [96259], says: 'The Broodmother is never accepted before Defending the Dead is handed in (#1083)' },
	{ side: 'Alliance', quest: 98189, after: [286], says: 'Karl Boran\'s second Return the Statuette is never accepted before the first is handed in (#1113)' },
	{ side: 'Alliance', quest: 98190, after: [286, 98189], says: 'A Friend of the Family is never accepted before both Return the Statuette quests are handed in (#1118)' },
	{ side: 'Alliance', quest: 526, after: [324], says: 'Lightforge Ingots is never accepted before The Lost Ingots is handed in (#1116)' },
	{ side: 'Alliance', quest: 98240, after: [98072], says: 'Crimson Crate Delivery is never accepted before Crocs of the Sky is handed in (#1134)' },
	{ side: 'Alliance', quest: 98310, after: [98216], says: 'Gleaning Our Future is never accepted before Understanding Our Present is handed in (#1184, #1206)' },
	{ side: 'Alliance', quest: 98313, after: [98310], says: 'For Further Study is never accepted before Gleaning Our Future is handed in (#1184)' },
];

// Second visits (#2635, from a Discord suggestion, 16 Nov): a character who starts the route between two visits to a
// zone never had the first visit's chain starter, so the second visit's follow-ups were hidden (Test of Endurance,
// 1150, in the Thousand Needles harpy den). Where the starter is quick, pays near-full XP and opens work on this
// visit, the second visit brings it back first, shown only to characters without it (`forge guide lint` checks the
// rest have a `leftout` record). `done` is what the earlier guide leaves a full-route character with: handed in, or
// carried in the log.
const SECOND_VISITS = [
	{ guide: 'forever/horde/30-40/02-thousand-needles.guide', who: { race: 'Tauren', raceName: 'Tauren', faction: 'Horde', cls: 'HUNTER', className: 'Hunter', level: 30 }, starters: [1149], opens: [1150], done: 'w.complete({ 1149 })' },
	{ guide: 'forever/horde/40-50/01-stranglethorn-vale.guide', who: { race: 'Orc', raceName: 'Orc', faction: 'Horde', cls: 'WARRIOR', className: 'Warrior', level: 39 }, starters: [583], opens: [338], done: 'w.complete({ 583 })' },
	{ guide: 'forever/alliance/nightelf/02-darkshore.guide', who: { race: 'NightElf', raceName: 'Night Elf', faction: 'Alliance', cls: 'HUNTER', className: 'Hunter', level: 12 }, starters: [3524, 4681], opens: [4722, 4723, 4728], done: 'w.complete({ 3524 }); w.onQuest(4681, { { required = 1 } })' },
	{ guide: 'forever/horde/50-60/02-felwood.guide', who: { race: 'Troll', raceName: 'Troll', faction: 'Horde', cls: 'MAGE', className: 'Mage', level: 53 }, starters: [5096], opens: [5098, 5228], done: 'w.onQuest(5096, { { required = 1, fulfilled = 1 } })' },
	{ guide: 'forever/alliance/50-60/04-western-plaguelands.guide', who: { race: 'Human', raceName: 'Human', faction: 'Alliance', cls: 'WARRIOR', className: 'Warrior', level: 55 }, starters: [4984], opens: [4985], done: 'w.onQuest(4984, { { required = 8 } })' },
	{ guide: 'forever/horde/50-60/06-silithus.guide', who: { race: 'Scourge', raceName: 'Undead', faction: 'Horde', cls: 'PRIEST', className: 'Priest', level: 58 }, starters: [4984], opens: [4985], done: 'w.complete({ 4984 })' },
	{ guide: 'forever/alliance/07-thousand-needles.guide', who: { race: 'Dwarf', raceName: 'Dwarf', faction: 'Alliance', cls: 'HUNTER', className: 'Hunter', level: 29 }, starters: [173], opens: [221], done: 'w.onQuest(173, { { required = 6 } })' },
	{ guide: 'forever/alliance/40-50/01-stranglethorn-vale.guide', who: { race: 'Gnome', raceName: 'Gnome', faction: 'Alliance', cls: 'MAGE', className: 'Mage', level: 39 }, starters: [606], opens: [607], done: 'w.onQuest(606, { { required = 5 } })' },
	{ guide: 'forever/alliance/40-50/07-un-goro-crater.guide', who: { race: 'Human', raceName: 'Human', faction: 'Alliance', cls: 'PALADIN', className: 'Paladin', level: 49 }, starters: [2605], opens: [2606], done: 'w.onQuest(2605, { { required = 1 } })' },
	{ guide: 'forever/horde/40-50/04-tanaris.guide', who: { race: 'Orc', raceName: 'Orc', faction: 'Horde', cls: 'SHAMAN', className: 'Shaman', level: 48 }, starters: [992], opens: [82], done: 'w.onQuest(992, { { required = 1 } })' },
];
// The statuses of the accepts of `quests` (comma-joined per quest when the guide has several), and what the plan left out.
function acceptStatuses(sv, before) {
	const set = [...sv.starters, ...sv.opens].map((q) => `[${q}] = 1`).join(', ');
	return engineRun(sv.guide, sv.who, {
		before,
		script: `local out, hidden = {}, {}
			for i = 1, #E.GetGuide().steps do
				for _, g in ipairs(E.GetStepView(i).goals) do
					if g.t == "accept" and ({ ${set} })[g.quest] then
						out[tostring(g.quest)] = (out[tostring(g.quest)] and out[tostring(g.quest)] .. "," or "") .. g.status
					end
				end
			end
			for q in pairs(E.GetGuide().hidden or {}) do hidden[#hidden + 1] = q end
			table.sort(hidden)
			emit({ accepts = out, hidden = hidden })`,
	});
}

// Dungeons in the route (0.3.8): a dungeon a character chose is injected into the one route as steps, every
// one behind `when dungeon` (pick-ups on stops the route makes, one run step at the door also guarded by
// `when onquest <its quests>`, hand-ins also behind `when complete`/`when onquest`), so a character who skips
// it (the default) has the solo route's steps and step numbers; data/dungeon-runs.json records each one so a
// Forge round reproduces the hand edits. One case per recorded dungeon: the guides hold what its record says.
const DUNGEON_RUNS = () => JSON.parse(fs.readFileSync(path.join(ROOT, 'data', 'dungeon-runs.json'), 'utf8')).runs;
const whenDungeonOf = (step, name) => (step.when || []).some((p) => p.k === 'dungeon' && !p.neg && dungeonKey(p.name) === dungeonKey(name));
const whenQuestOf = (step, kinds, quest) => (step.when || []).some((p) => kinds.includes(p.k) && !p.neg && [p.q].flat().includes(quest));
// The lowest level a step applies at by its `when level>=`/`level>` predicates (a point inside a level counts), 1 without
// one: forge-guide validate.rs `lowest_level`, rounded to a hundredth as the guide writes it.
const lowestLevel = (step) => Math.round(100 * (step.when || []).filter((p) => p.k === 'level' && (p.op === '>=' || p.op === '>')).reduce((lo, p) => Math.max(lo, p.frac ? p.n + p.frac : p.op === '>' ? p.n + 1 : p.n), 1)) / 100;

// #2612 (JeromeM, 0.4.0, Westfall): "Find the Lost Guards" sent the hand-in to Guard Thomas, who only gives it; the
// half-eaten body takes it. The build had added the giver to the quest's enders from the in-game dialog captures,
// on eight quests handed in at an object (players' recordings: none of their hand-ins in an NPC's window). Each
// is corrected to its object alone, and every guide's hand-in of them goes to the object.
const OBJECT_ENDERS = { 37: 55, 67: 3643, 944: 10076, 983: 17182, 4812: 175524, 91860: 566037, 94467: 61934, 94502: 619896 };

for (const c of CAVES) {
	test(`${c.guide}: Tom's report: the arrow reaches ${c.cave} through its mouth at ${c.mouth.x},${c.mouth.y}`, { skip }, () => {
		const list = goals(c.guide);
		const i = at(list, c.cave, c.target);
		const before = list.slice(0, i).reverse().find(located);
		assert.ok(before, 'a located goal comes before the target');
		const { t, map, x, y } = before.goal;
		assert.deepEqual({ t, map, x, y }, { t: 'goto', ...c.mouth }, `the waypoint before "${list[i].step.title}" is the mouth`);
	});
}
test('every leveling guide: no travel-only step is labelled with just a zone name (#1450)', { skip: skip || needs('zones.json') }, () => {
	const zones = new Set(['Orgrimmar', 'Thunder Bluff', 'Undercity', 'Stormwind City', 'Ironforge', 'Darnassus']);
	for (const z of Object.values(JSON.parse(fs.readFileSync(path.join(DATA, 'zones.json'), 'utf8')))) if (z && z.type === 3 && z.name) zones.add(z.name);
	const GOAL = /^\s+(accept|turnin|kill|collect|interact|use|complete|escort|goto|talk|task|buy|fly|getfp|sethome|hearth|level|train|vendor|explore|enter|cast|money|rep|skill|achieve|die|abandon|destroy|learn)\b/;
	const files = allGuides().filter((f) => /^forever\/(horde|alliance)\//.test(f));
	assert.ok(files.length > 50, `the leveling guides (${files.length})`);
	const bad = [];
	for (const f of files) {
		for (const s of fs.readFileSync(path.join(OFFICIAL_DIR, f), 'utf8').split(/\n(?=step\b)/)) {
			if (!s.startsWith('step')) continue;
			const goals = s.split('\n').filter((l) => GOAL.test(l));
			const m = goals.length === 1 && goals[0].match(/^\s+goto [\d.]+,[\d.]+(?: map \d+)?(?: "([^"]*)")?/);
			if (!m) continue;
			const label = m[1] || s.split('\n')[0].slice(4).trim();
			if (zones.has(label.replace(/^(Back to|To) /, '')) && !ZONE_GOTO_ALLOW[`${f}|${label}`]) bad.push(`${f}: ${s.split('\n')[0]} -> "${label}"`);
		}
	}
	assert.deepEqual(bad, []);
});
for (const [guide, quest, item, count, vendor, what] of BUY_AT_TURNIN) {
	test(`${guide}: the same pattern as #365, ${what}: asked for again on the step that hands in ${quest}`, { skip }, () => {
		const list = goals(guide);
		const hand = at(list, `turnin ${quest}`, is('turnin', quest));
		const buy = list.slice(0, hand).findLastIndex(({ goal }) => goal.t === 'buy' && goal.item === item);
		assert.ok(buy >= 0, `item ${item} is bought before handing in ${quest}`);
		const sameVisit = list.slice(buy, hand + 1).every(({ goal }) => !['fly', 'hearth'].includes(goal.t)
			&& (!['accept', 'turnin', 'buy', 'goto', 'train'].includes(goal.t) || !located({ goal })
				|| (goal.map === list[hand].goal.map && yards(goal, list[hand].goal) < TOWN_YARDS)));
		const tip = typeof list[hand].step.note === 'string' && /\bbuy\b/i.test(list[hand].step.note);
		assert.ok(list[buy].s === list[hand].s || sameVisit || tip, `the turn-in step, its town visit or its tip buys item ${item} before handing in ${quest}`);
		const { goal } = list[buy];
		assert.ok((goal.count || 1) >= count, `at least the ${count} the quest needs`);
		if (vendor === 'H') {
			assert.ok(goal.candidates && goal.candidates.length > 0, 'vendors to pick the nearest from');
			assert.ok(goal.candidates.some((c) => c.faction && c.faction.includes('H')), 'some of them sell to the Horde');
		} else {
			assert.equal(goal.npc, vendor, `from npc ${vendor}`);
		}
	});
}

test(`EpicTibbles's report (#532): an objective that is talking to someone reads "Talk to", not "Kill": the Skyborne visits to the Horde leaders`, { skip }, () => {
	// Where the data counts these as kill credit on the NPC, the goal stays a `kill` tracking the
	// objective and its text is what the guide window shows; where the game's own objective list
	// makes them talks (#859), the goal is a `talk` tracking the objective, which reads "Talk to".
	const talks = [
		// (Zarrin's Camping 101: Cooking is now done by training Cooking from him: #743.)
		['forever/horde/03-silverpine-forest.guide', 93739, 1, 'Nazgrel'],
		['forever/horde/03-silverpine-forest.guide', 93739, 2, "Vol'jin"],
		// (Sylvanas is talked to on the Undercity stop at the end of the Silverpine guide, since the Horde 12-30 re-chain.)
		['forever/horde/03-silverpine-forest.guide', 93739, 4, 'Lady Sylvanas Windrunner'],
		[ASHENVALE_HORDE, 93739, 3, 'Cairne Bloodhoof'],
		// Visur (#802): the Alliance Skyborne's Welcome to Shen'dar Village and The Missing Scholar.
		['forever/alliance/skyborne/01-zephras-isle.guide', 93461, 1, 'Rathiril Sunlance'],
		['forever/alliance/skyborne/01-zephras-isle.guide', 93461, 2, 'Coriella Calmbreeze'],
		['forever/alliance/skyborne/01-zephras-isle.guide', 92849, 1, 'Fillion Flamebreeze'],
	];
	for (const [guide, quest, oi, name] of talks) {
		const { goal } = goals(guide)[at(goals(guide), `${quest}.${oi} (${name})`, (g) => (g.t === 'kill' || g.t === 'talk') && g.quest === quest && g.oi === oi)];
		if (goal.t === 'talk') assert.equal(goal.npcName, name, `${guide}: ${name}`);
		else assert.equal(goal.text, `Talk to ${name}`, `${guide}: ${name}`);
	}
	// Every kill goal whose note says to speak with someone says so itself.
	for (const guide of allGuides()) {
		for (const { goal } of goals(guide)) {
			if (goal.t === 'kill' && /^Speak with /.test(goal.note || '')) {
				assert.match(goal.text || '', /^Talk to /, `${guide}: ${goal.note}`);
			}
		}
	}
});

// Fyurie's reports (#2535, #2539, #2543, Blackrock Depths' pick-up guide): stories heard from friendly NPCs said
// "Kill". The data build's talk rule (forge-data talk.rs) and forever-db corrections type them as talks, so the
// Codex, the quest database and every guide say "Talk to"; 273's phantom kill and 1560's "Kill Torta" are gone.
test('#2535 #2539 #2543: stories heard from friendly NPCs are talks in the data, not kills', { skip }, () => {
	refData();
	const kind = (q, i) => ((refData().quests[q] || {}).objectives || [])[i - 1]?.type;
	for (const [q, i, npc] of [[3702, 1, 8879], [4185, 1, 1749], [4224, 1, 9563], [3441, 1, 8479], [3453, 1, 8479], [4022, 2, 9459],
		[4001, 1, 9021], [4342, 1, 9021], [93016, 1, 253471], [93739, 1, 3230], [91294, 4, 246378], [5211, 1, 11064], [96989, 3, 267298]]) {
		assert.equal(kind(q, i), 'talk', `${q}.${i}`);
		assert.equal(refData().quests[q].objectives[i - 1].id, npc, `${q}.${i} is a talk to ${npc}`);
	}
	assert.equal(kind(4022, 1), 'item', 'A Taste of Flame keeps its molt');
	assert.deepEqual(refData().quests[273].objectives.map((o) => o.type), ['event'], 'Resupplying the Excavation: the game lists only its event');
	assert.deepEqual(refData().quests[1560].objectives.map((o) => o.type), ['event'], "Tooga's Quest is the escort to Torta");
	assert.deepEqual(refData().quests[96204].objectives.map((o) => o.type), ['talk', 'event'], "The Windshaper's Wrath: talk to Lumina, then the escort");
	// Fights stay kills: the NPC turns hostile and gives in.
	for (const q of [590, 1447, 1640]) assert.equal(kind(q, 1), 'kill', `${q}`);
});

test(`#873: data/places.json labels the Curing the Sick and Are We There, Yeti? objectives with the item use, not "Kill"`, () => {
	const { places } = JSON.parse(fs.readFileSync(path.join(ROOT, 'data', 'places.json'), 'utf8'));
	for (const [key, label] of Object.entries(USE_ITEM_873)) {
		const [quest, objective] = key.split('.').map(Number);
		assert.equal(places.find((p) => p.quest === quest && p.objective === objective && p.label)?.label, label, `data/places.json labels ${key}`);
	}
});

test('Forever follow-ups are taken only once the quests before them are handed in', { skip }, () => {
	for (const [guide, quest, after, optional] of [
		[MULGORE, 99081, [99079]],
		[MULGORE, 99101, [99081]],
		[MULGORE, 99080, [99101]],
		[MULGORE, 99082, [99080]],
		[MULGORE, 98435, [760]],
		[TIRISFAL, 96899, [96897, 96898]],
		[TIRISFAL, 99156, [356], true],
		[[LOCH_MODAN, REDRIDGE], 98386, [89]],
		[WESTFALL, 92745, [92742, 92744]],
		[[WESTFALL, LOCH_MODAN], 92747, [92745, 92744]],
		// Scout Support leads to Valuable Vantages, left out since the 0.4.0 level tidy (data/route-fixes.json skip).
		[HILLSBRAD_HORDE, 98094, [528], true],
		[SILVERPINE, 91920, [430]],
		[SILVERPINE, 91921, [91920], true],
		[HILLSBRAD_ALLIANCE, 98209, [98208], true],
		[HILLSBRAD_ALLIANCE, 88758, [88757], true],
		[HILLSBRAD_ALLIANCE, 98297, [98291], true],
		[ASHENVALE_30, 98418, [98417], true],
		[ARATHI, 92459, [92458], true],
		// The #51 sweep: Holy Diver after all nine beached remains, Ivar the
		// Foul after Return to Quinn (Again); 92911 and 98298 are left out.
		[[DARKSHORE, DARKSHORE_RETURN], 87760, [4722, 4723, 4725, 4727, 4728, 4730, 4731, 4732, 4733]],
		[SILVERPINE, 425, [91921]],
		[SILVERPINE, 98298, [99], true],
		[WESTFALL, 92911, [92910], true],
		// Lou-Saydus (#225): Forever puts From the Ashes before Nek'rosh's Gambit, so Captain
		// Stoutfist did not offer 465 when War Banners was handed in. From the Ashes itself is
		// offered together with War Banners (players' recordings), so it has no row here.
		[WETLANDS, 465, [98221]],
		// mtbhuskies, Soulevoker and mcclaskiem (#792): Executor Arren did not
		// offer The Adventurer at level 4 with Night Web's Hollow still open.
		[TIRISFAL, 96656, [382]],
		// Livnthedream (#800): Apothecary Holland offers Tomb Weed once Doom
		// Weed is handed in; the recordings show Sarvis giving the Paladin's
		// A Difficult Path only after The Mindless Ones.
		[TIRISFAL, 99142, [5482]],
		[TIRISFAL, 98601, [364]],
		// kieran1188 (#796): Master Vornal offers Forgotten Loa Idols once
		// Report to Sen'jin Village is handed in. Rohkin (#807): Rezlak offers
		// Stormy Potential once A Simmering Storm (the Dull Storm Orb's) is
		// handed in, so it is an optional extra.
		...DUROTARS.map((g) => [g, 97225, [805]]),
		...[...DUROTARS, 'forever/reputation/orgrimmar.guide', 'forever/reputation/darkspear-trolls.guide'].map((g) => [g, 97282, [97281], true]),
		// DexeeXI (#872): Shadow Priest Allister offers Watching the Roads only once Dalaran's Intentions
		// is handed in to him: Dalaran's Intentions is handed in in the Silverpine stay (12-15), Watching the
		// Roads taken on the ride to Hillsbrad at 22 (05-stonetalon-mountains, after it in every chain).
		// DexeeXI (#891): Yelmak offers Whuut's the Rush once Yelmak's Medley
		// is handed in to Kor'geld beside him.
		[SILVERPINE, 97275, [97242]],
		// The #872 sweep: James Halloran's Crocs of the Sky is his last favor
		// after Apprentice's Duties, and Lord Grayson Shadowbreaker's The
		// Shamed Lieutenant thanks you for the statuette A Friend of the Family
		// brings him.
		[WETLANDS, 98072, [471], true],
		[WETLANDS, 98072, [471]],
		[WETLANDS, 98219, [98191]],
		// Bennistrov (#1354): Bolvar offers his A Friend of the Family once Captain Stoutfist's is handed in to him.
		[WETLANDS, 98191, [98190]],
		// soockee (#1002) and jiskim (#984): Va'xug Firefure offers A Void Path
		// only once Never Coming Back is handed in to him.
		[STONETALON, 98252, [98251]],
		// The offer audit of players' recordings (2026-11-07): Karl Boran offers
		// Return the Statuette (98189) once the old one (286) is handed in
		// (#1113, #1118); Muln Earthfury offers The Broodmother once Defending the
		// Dead is handed in (#1083); Thrall offers a Skyborne Journey to the
		// Crossroads once Welcome to Azeroth is handed in.
		[WETLANDS, 98189, [286]],
		[ASHENVALE_HORDE, 96261, [96259]],
		['forever/reputation/thunder-bluff.guide', 96261, [96259]],
		[SILVERPINE, 98024, [95350]],
		[SILVERPINE, 93739, [95350], true],
		// #1134: James Halloran offers Crimson Crate Delivery only after Crocs of
		// the Sky; the route now leaves it out (data/route-fixes.json skip).
		[ASHENVALE, 98240, [98072], true],
		[HILLSBRAD_ALLIANCE, 98240, [98072], true],
	]) {
		const list = [].concat(guide).flatMap((g) => goals(g));
		const take = list.findIndex(({ goal }) => is('accept', quest)(goal));
		if (take < 0 && optional) continue;
		assert.ok(take >= 0, `${guide}: accept ${quest} is in the guide`);
		for (const pre of after) {
			assert.ok(at(list, `${guide}: turnin ${pre}`, is('turnin', pre)) < take, `${guide}: ${quest} is taken after ${pre} is handed in`);
		}
	}
});

// Rohkin (#807): Stormy Potential follows A Simmering Storm, which only a
// chance drop (the Storm Witches' Dull Storm Orb) starts: never a must-do, and
// its hand-in at Rezlak only for those who took it.
test('Rohkin\'s report (#807): Stormy Potential is an optional extra after the Dull Storm Orb\'s quest', { skip }, () => {
	for (const guide of [...DUROTARS, 'forever/reputation/orgrimmar.guide', 'forever/reputation/darkspear-trolls.guide']) {
		const accepts = goals(guide).filter(({ goal }) => is('accept', 97282)(goal));
		assert.ok(accepts.length > 0, `${guide}: Stormy Potential is offered`);
		for (const { goal } of accepts) assert.equal(goal.optional, true, `${guide}: accept 97282 is optional`);
		assert.ok(goals(guide).some(({ goal }) => is('accept', 97281)(goal) && goal.optional), `${guide}: the orb's quest is optional too`);
	}
});
for (const [guide, quest, items, also, keep] of [
	['forever/alliance/40-50/04-tanaris.guide', 1878, { 8483: 5 }, [], [['turnin', 1691]]],
	['forever/alliance/40-50/05-the-hinterlands.guide', 349, { 2799: 10 }, [], []],
	['forever/alliance/50-60/04-western-plaguelands.guide', 5402, { 12840: 20 }, [], [['turnin', 5220], ['accept', 5222]]],
	['forever/alliance/50-60/04-western-plaguelands.guide', 5403, { 12841: 10 }, [], [['turnin', 5220], ['accept', 5222]]],
	['forever/alliance/50-60/04-western-plaguelands.guide', 4041, { 11242: 1 }, ['collect 11243'], []],
	['forever/alliance/50-60/06-silithus.guide', 8469, { 21383: 5 }, [], []],
	['forever/horde/40-50/06-azshara.guide', 2741, { 8564: 1 }, [], [['turnin', 2641], ['accept', 4504], ['turnin', 2661], ['accept', 2662], ['turnin', 2662]]],
	['forever/horde/50-60/03-winterspring.guide', 4041, { 11242: 1 }, ['collect 11243'], []],
	['forever/horde/50-60/07-felwood.guide', 5887, { 11515: 6 }, [], []],
	['forever/horde/50-60/07-felwood.guide', 8469, { 21383: 5 }, [], []],
	['forever/class/warrior/whirlwind-weapon.guide', 1714, { 4479: 8, 4480: 8, 4481: 8 }, ['level', 'collect 6851'], []],
	['forever/collectibles/pets/bitter-baitling.guide', 8193, { 19807: 40 }, ['collect 274026'], []],
	['forever/horde/50-60/03-winterspring.guide', 3804, { 11040: 10 }, [], [['turnin', 3782], ['turnin', 3786]]],
]) {
	test(`${guide}: hand-in ${quest} straight from the bags shows only while they hold what it asks for (#2561 sweep)`, { skip }, () => {
		const { steps } = compiled(guide);
		const at = steps.filter((st) => st.goals.some((g) => g.t === 'turnin' && g.quest === quest));
		assert.equal(at.length, 1, `one hand-in of ${quest}`);
		const [st] = at;
		assert.ok(st.goals.find((g) => g.quest === quest && g.t === 'turnin').direct, `${quest} is handed in straight from the bags`);
		for (const [item, n] of Object.entries(items)) {
			assert.ok((st.when || []).some((p) => p.k === 'has' && !p.neg && p.item === Number(item) && (p.n || 1) === n), `"${st.title}" shows only with ${n} of item ${item} in the bags`);
		}
		// Nothing else holds the step but what the hand-in itself gives (its reward taken as a goal) or a level.
		const rest = st.goals.filter((g) => !(g.t === 'turnin' && g.quest === quest)).map((g) => (g.t === 'level' ? 'level' : `${g.t} ${g.item || g.quest}`));
		assert.deepEqual(rest, also, `"${st.title}" holds only the hand-in`);
		for (const [t, q] of keep) {
			const other = steps.find((s) => s.goals.some(is(t, q)));
			assert.ok(other && other !== st && !(other.when || []).some((p) => p.k === 'has'), `${t} ${q} still holds the route for everyone`);
		}
	});
}
// A step shown only while the bags hold an item (`when has I`) stops applying the moment the item is used up, so
// nothing may follow the goal that uses it up (a `use`, an accept the item starts, a hand-in that takes it) but what
// that goal hands over (a collect of its reward): the rest of the step would be passed half done.
test('Every guide: a step gated on carrying an item holds no work after the goal that uses the item up (#2561 sweep)', { skip }, () => {
	const bad = [];
	for (const guide of allGuides()) {
		for (const st of compiled(guide).steps) {
			for (const p of (st.when || []).filter((w) => w.k === 'has' && !w.neg)) {
				const uses = (g) => (g.t === 'use' && g.item === p.item) || (g.t === 'accept' && g.item === p.item)
					|| (g.t === 'turnin' && refData().quests[g.quest] && directNeeds(g.quest).has(p.item));
				const at = st.goals.findIndex(uses);
				if (at < 0) continue;
				const after = st.goals.slice(at + 1).filter((g) => !g.optional && g.t !== 'collect' && g.t !== 'note' && !uses(g));
				if (after.length) bad.push(`${guide} "${st.title}" (has ${p.item}): ${after.map((g) => `${g.t} ${g.quest || g.item || ''}`).join(', ')}`);
			}
		}
	}
	assert.deepEqual(bad, []);
});
test('Every guide: no required hand-in straight from the bags can hold the route without its items (#2561 sweep)', { skip }, () => {
	const bad = [];
	for (const guide of allGuides()) {
		for (const st of compiled(guide).steps) {
			for (const goal of st.goals) {
				if (goal.t !== 'turnin' || !goal.direct || goal.optional || !refData().quests[goal.quest]) continue;
				const why = directStuck(st, goal);
				if (why) bad.push(`${guide} "${st.title}" turnin ${goal.quest}: ${why}`);
			}
		}
	}
	assert.deepEqual(bad, []);
});

// Objective numbers written against an older objective list: A Moon-Kissed
// Blade (95036) has four lines, Trevan's notes first; The Tarnished (91317)
// lists Rudolph Gelhardt's Head first; both copies of Storm, Earth, and Fire
// (79358, 79361) list the Water, Earth, Fire and Air totems; Defending the
// Dead (96259) lists the Hatchlings first (players' recordings, Forever's
// quest data). A goal on another line's number ticks with that line. Read
// from the guide text, so it runs without data/forever.
test('Objective numbers point at the line the game counts for each target: A Moon-Kissed Blade, The Tarnished, Storm, Earth, and Fire, Defending the Dead', () => {
	const QUESTS = [95036, 91317, 79358, 79361, 96259];
	const order = fs.readFileSync(path.join(ROOT, 'forever-db', 'data', 'quest_objective.jsonl'), 'utf8').split('\n').filter(Boolean).map((l) => JSON.parse(l)).filter((o) => QUESTS.includes(o.quest));
	const n = (quest, target) => (order.find((o) => o.quest === quest && o.target === target) || {}).n;
	assert.deepEqual([n(95036, 267454), n(95036, 6994), n(95036, 267361), n(95036, 272448)], [1, 2, 3, 4], "Forever's quest data: the notes, the lumber, the ingot, the gem");
	assert.deepEqual([n(91317, 270435), n(91317, 259434), n(91317, 259433)], [1, 2, 3], "Forever's quest data: the head, the Drudges, the Zealots");
	for (const q of [79358, 79361]) assert.deepEqual([n(q, 274046), n(q, 274045), n(q, 274044), n(q, 274047)], [1, 2, 3, 4], `Forever's quest data: ${q} lists water, earth, fire, air`);
	assert.deepEqual([n(96259, 264079), n(96259, 264083)], [1, 2], "Forever's quest data: the Hatchlings, then the Soldiers");
	const target = { kill: 'npc', talk: 'npc', collect: 'item', interact: 'object' };
	const wrong = [];
	let checked = 0;
	const root = path.join(OFFICIAL_DIR, 'forever');
	for (const rel of fs.readdirSync(root, { recursive: true }).filter((f) => f.endsWith('.guide')).sort()) {
		const guide = parseGuide(fs.readFileSync(path.join(root, rel), 'utf8'), rel, new Diagnostics());
		for (const g of guide.steps.flatMap((s) => s.goals)) {
			if (!QUESTS.includes(g.quest) || g.oi === undefined || !target[g.verb]) continue;
			checked++;
			const want = n(g.quest, g[target[g.verb]]);
			if (g.oi !== want) wrong.push(`forever/${rel}:${g.line} quest ${g.quest}.${g.oi} for ${target[g.verb]} ${g[target[g.verb]]}: the game counts it on ${g.quest}.${want}`);
		}
	}
	assert.deepEqual(wrong, []);
	assert.equal(checked, 17, 'the lines of every guide that number these objectives');
});

// --- Silverpine (Wyatt R, #161; Rupert, #229): Dalar Dawnweaver did not offer
// Stop the Spread to an Undead at 19 or a Tauren at 21 on the route, though
// the data gives it to every Horde race with no prerequisite.

test(`Rupert's and Wyatt R's reports: no guide sends you to Dalar Dawnweaver or the refugees for Stop the Spread (#229, #161)`, { skip }, () => {
	for (const guide of allGuides()) {
		const asked = goals(guide).filter(({ goal }) => goal.quest === 98299);
		assert.deepEqual(asked.map(({ goal }) => goal.t), [], `${guide} has no goal for 98299`);
	}
});

// --- Never seen taken (#1314's pattern; the never-taken sweep, 2026-11-08): Hearts of the Lost turned
// out not to be in the game. Two more Forever quests nobody has been recorded taking or being offered, whose giver
// nobody has ever seen, from another addon's data and the web only, are optional, with a tip to skip them when the
// giver isn't there: every goal of theirs is optional, so nothing in the guide waits on them.
for (const [q, title, giver, files] of [
	[93176, 'My Little Friends', 'Amaryllis Webb', ['forever/alliance/30-40/05-arathi-highlands.guide', 'forever/alliance/40-50/01-stranglethorn-vale.guide']],
	[97265, 'Hate the Hatefury', "Aka'rai", ['forever/horde/30-40/02-thousand-needles.guide']],
]) {
	test(`${title} (${q}): every goal is optional and the accept says to skip it when ${giver} doesn't offer it (#1314)`, { skip }, () => {
		let n = 0;
		for (const file of files) {
			for (const { goal } of goals(file).filter(({ goal }) => goal.quest === q)) {
				n++;
				assert.ok(goal.optional, `${file}: ${goal.t} ${q} is optional`);
				if (goal.t === 'accept') assert.match(stepTips(file, new RegExp(`^\\s+accept ${q}\\b`)).join(' '), new RegExp(`${giver} may not be here on Forever: if ${giver} doesn't offer ${title}, skip it\\.`), `${file}: the accept's step says to skip it`);
			}
		}
		assert.ok(n >= 2, `the accept and the hand-in are found (${n})`);
	});
}

// --- DexeeXI's report (#1322, client 70862): Elixir of Agony (515) takes item 3388, which the game calls Lesser Troll's
// Blood Elixir (players' recordings: the objective reads so and ticks with it); the quest's own text still says Strong. The
// Undercity step told players to buy a Strong Troll's Blood Potion, the item's old name. Since the level tidy (2026-11-15)
// the route leaves 515 out (it could start only after Hillsbrad), so no Horde guide asks for the elixir at all. The
// Craftsman's Writs of the Supply Factions Reputation guide named old item names the same way (one, Elixir of Greater
// Defense, is now another item).
test("DexeeXI's report (#1322): the guides name the elixirs the quests take by their names in the game", { skip }, () => {
	assert.equal(refData().items[3388].name, "Lesser Troll's Blood Elixir");
	assert.ok(refData().quests[515].objectives.some((o) => o.type === 'item' && o.id === 3388), 'Elixir of Agony takes item 3388');
	for (const file of ['forever/horde/06-hillsbrad-foothills.guide', 'forever/horde/30-40/01-hillsbrad-foothills.guide']) {
		const said = goals(file).map(({ step }) => [step.tip, step.note, ...step.goals.map((g) => g.text)].flat().filter(Boolean).join(' ')).join(' ');
		assert.doesNotMatch(said, /Strong Troll's Blood Potion/, `${file}: never the old name`);
	}
	// Each writ's hand-in says which item it takes: one of the quest's item objectives, by the game's name.
	const writs = goals('forever/reputation/merchants-favor.guide').filter(({ goal }) => goal.t === 'turnin' && /^Craftsman's Writ/.test(refData().quests[goal.quest]?.title || ''));
	assert.ok(writs.length > 0, 'the writ hand-ins');
	for (const { goal } of writs) {
		const item = (goal.note || '').replace(/, \d+ reputation$/, '');
		const takes = refData().quests[goal.quest].objectives.filter((o) => o.type === 'item').map((o) => refData().items[o.id]?.name);
		assert.ok(takes.includes(item), `writ ${goal.quest}: "${item}" is one of ${takes.join(', ')}`);
	}
});

// Fitz's level rule (0.4.0) on the reputation, collectible, exploration, miscellaneous and legacy guides, as on the class
// guides above: every step that fights waits on its own `level` hold (the guide's opening level is the floor) for mobs at
// most 1 above it, 2 for a group step's elites. A city reputation guide of 12-60 sent a level 12 straight to the
// Plaguelands' cauldron lords (53-58); Gelkis and Magram's valley (38-43) waited only for 35. Left as they are, on
// purpose: raid and level 61+ bosses (past what a hold can wait for), the Legacy checklist's dungeon bands (held at each
// band's first level), one dropper among many (any thunder lizard drops the horn, any Shardtooth the meat), the Barrens'
// Echeyakee (the data's 60 is a summon's range), Chol'aruk (an optional group kill in a solo hub) and the Timbermaw
// feather and bead farms (any Deadwood or Winterfall furbolg).
test('side guides: every fighting step waits on its own level for mobs at most 1 above it (Fitz\'s rule, #2462)', { skip }, () => {
	const top = (id) => refData().npcs[id] && (refData().npcs[id].levelMax || refData().npcs[id].level);
	const LEFT = new Set(['legacy/legacy-challenges', 'reputation/orgrimmar 3475', 'reputation/orgrimmar 5832', 'reputation/orgrimmar 267307', 'reputation/wintersaber-trainers 7446', 'reputation/timbermaw-hold 7442']);
	const wrong = [];
	for (const G of allGuides().filter((g) => /^forever\/(reputation|collectibles|exploration|miscellaneous|legacy)\//.test(g))) {
		const id = G.replace(/^forever\//, '').replace(/\.guide$/, '');
		if (LEFT.has(id)) continue;
		const floor = compiled(G).minLevel || 1;
		for (const step of compiled(G).steps) {
			const own = Math.max(floor, ...step.goals.filter((g) => g.t === 'level').map((g) => g.level));
			for (const goal of step.goals) {
				const item = goal.t === 'collect' && !goal.gather && goal.fromKind !== 'object' ? refData().items[goal.item] : null;
				const droppers = item && item.drops && !(item.vendors || []).length && !Object.keys(item.drops.object || {}).length ? Object.entries(item.drops.npc || {}).filter(([, chance]) => typeof chance === 'number' && chance >= 1).map(([npc]) => Number(npc)).filter(top) : [];
				const mob = goal.t === 'kill' ? goal.npc : droppers.length ? droppers.reduce((a, b) => (top(b) < top(a) ? b : a)) : null;
				const n = mob && refData().npcs[mob];
				if (!n || n.faction || LEFT.has(`${id} ${mob}`) || top(mob) >= 61 || own >= 60) continue;
				const allow = goal.group ? 2 : 1;
				if (top(mob) > own + allow) wrong.push(`${G}, ${step.title}: ${goal.t} ${goal.item || goal.npc}, ${n.name} up to ${top(mob)}, the step waits for ${own}`);
			}
		}
	}
	assert.deepEqual(wrong, []);
});

// --- Darkshore (lax, #924): "Level 20" said "grind on Elder Darkshore
// Thresher" but its arrow led to 33.3,40.7 by Auberdine, a camp of the lower
// Darkshore Threshers (both drop the Thresher Eyes worked there). The Elders
// spawn only on the south and north coasts; players' recordings see them only
// there. The same pattern everywhere: a grind's arrow is at the mob it names.

test(`lax's report (#924): every grind's arrow leads to a spawn of the mob it names`, { skip }, () => {
	refData();
	const byName = new Map();
	for (const n of Object.values(refData().npcs)) if (n.name) byName.set(n.name, [...(byName.get(n.name) || []), n.id]);
	const world = (map, x, y, f) => {
		const fr = (f === 'e' ? refData().mapFrames.era : refData().mapFrames.forever || {})[map] || refData().eraFrame(map);
		return fr && { c: fr.c, wx: fr.top + ((fr.bottom - fr.top) * y) / 100, wy: fr.left + ((fr.right - fr.left) * x) / 100 };
	};
	const offenders = [];
	let grinds = 0;
	for (const guide of allGuides().filter((g) => /^forever\/(alliance|horde)\//.test(g))) {
		for (const step of compiled(guide).steps) {
			step.goals.forEach((goal, i) => {
				const next = step.goals[i + 1];
				if (goal.t !== 'goto' || goal.map == null || !next || next.t !== 'level' || next.note !== `grind on ${goal.text}`) return;
				grinds++;
				const g = world(goal.map, goal.x, goal.y, goal.f);
				const yd = Math.min(...(byName.get(goal.text) || []).flatMap((id) => refData().spawns('npc', id)).flatMap((s) => s.pts.map((p) => {
					const w = world(s.map, p[0], p[1], s.f);
					return w && g && w.c === g.c ? Math.hypot(w.wx - g.wx, w.wy - g.wy) : Infinity;
				})));
				if (!(yd <= 400)) offenders.push(`${guide} step ${step.title}: ${goal.text} at ${goal.x},${goal.y} map ${goal.map} (${Math.round(yd)} yd off)`);
			});
		}
	}
	assert.ok(grinds > 20, 'the grinds are found');
	assert.deepEqual(offenders, [], 'grind arrows away from the mob they name');
});

test('#213: quests whose giver the route already stands at are taken there, not on a walk back', { skip }, () => {
	// Each case: the quest, and the goals of a step at its giver the route stands at, any one of which may
	// hold its accept. Simmer stands beside Calvin at Solliden: Fields of Grief at either pass by him.
	for (const [guide, quest, withGoals, what] of [
		[TIRISFAL, 365, [is('accept', 590), is('accept', 8)], "Calvin's duel at Solliden or Calvin's letter on the walk in from Deathknell"],
		[TANARIS_ALLIANCE, 2781, [is('accept', 2875)], "Andre Firebeard's poster at Steamwheedle Port"],
		[STRANGLETHORN_HORDE, 192, [is('turnin', 191)], "Panther Mastery's second turn-in"],
	]) {
		const list = goals(guide);
		const take = at(list, `${guide}: accept ${quest}`, is('accept', quest));
		const steps = withGoals.map((p) => list.findIndex(({ goal }) => p(goal))).filter((i) => i >= 0).map((i) => list[i].step);
		assert.ok(steps.length > 0, `${guide}: ${what} is in the guide`);
		assert.ok(steps.includes(list[take].step), `${guide}: ${quest} is taken at ${what}`);
	}
});

// --- Sweep from Rohkin's #957 (PR #970): an item collected from mobs before the
// quest that kills the same mobs is taken, then those mobs cleared again for it.
// Badlands: Hammertoe's Digsite asked for the Rock Elemental Shards (Badlands
// Reagent Run, 2500.3), whose only droppers are rock elementals far from the dig;
// the Dustbowl's Lesser Rock Elementals are killed after Lotwil's Study of the
// Elements: Rock (710) at Agmond's End. Stranglethorn (Horde): Nesingwary's step
// asked for all 25 Bloody Bone Necklaces (596) from the Bloodscalps that Bloodscalp
// Ears (189) and Headhunting (582) kill again later; the Ruins of Zul'Kunda step,
// before the hand-in, finishes them.
test('Sweep from #957: a drop is collected with the later quest that kills the same mobs, not in a clear before it', { skip }, () => {
	for (const [guide, item, quest, take, what] of [
		[BADLANDS, 7848, 2500, 710, "Rock Elemental Shards after Lotwil's Study of the Elements: Rock"],
		[STRANGLETHORN_HORDE, 3915, 596, 582, "Bloody Bone Necklaces after Nimboya's Headhunting"],
	]) {
		const list = working(goals(guide));
		const accept = at(list, `${guide}: accept ${take}`, is('accept', take));
		const work = list.map((e, i) => [e, i]).filter(([{ goal }]) => goal.t === 'collect' && goal.quest === quest && goal.item === item);
		assert.ok(work.length > 0, `${guide}: the ${what} have a goal`);
		for (const [{ step }, i] of work) assert.ok(i > accept, `${guide}: ${what}, not in "${step.title}"`);
	}
});

test('a quest with objectives is completed or collected between its accept and its turn-in', { skip }, () => {
	for (const [guide, quest, t, count] of [
		[MULGORE, 96661, 'complete', 1],
		...DUN_MOROGHS.map((guide) => [guide, 96629, 'complete', 1]),
		[UN_GORO_ALLIANCE, 3845, 'collect', 3],
	]) {
		const list = goals(guide);
		const accept = at(list, `${guide}: accept ${quest}`, is('accept', quest));
		const turnin = at(list, `${guide}: turnin ${quest}`, is('turnin', quest));
		const between = list.slice(accept + 1, turnin).filter(({ goal }) => is(t, quest)(goal));
		assert.equal(between.length, count, `${guide}: ${count} ${t} goal(s) for ${quest} between its accept and its turn-in`);
	}
});

// The sweep for #1348: a Bronze Tube is never a buy that holds a step (every vendor of it keeps one or two),
// and a goal that must get one sends the player to the Stormwind Auction House, not to a vendor.
test('Every guide (#1348): no Bronze Tube buy holds a step; a required tube comes from the Auction House', { skip }, () => {
	let seen = 0;
	for (const guide of allGuides()) {
		if (!fs.readFileSync(path.join(OFFICIAL_DIR, guide), 'utf8').includes('4371')) continue;
		for (const { goal } of goals(guide)) {
			if (goal.item !== 4371 || (goal.t !== 'buy' && goal.t !== 'collect')) continue;
			seen++;
			if (goal.t === 'buy') assert.equal(goal.optional, true, `${guide}: buy 4371 is optional`);
			else if (!goal.optional) assert.ok(atAuctionHouse(goal), `${guide}: a required Bronze Tube is collected at the Auction House`);
			assert.ok(![5519, 3133].includes(goal.npc), `${guide}: not Billibub Cogspinner or Herble Baubbletump, sold out in every recorded window (#1348, #1792)`);
		}
	}
	assert.ok(seen >= 4, `the Bronze Tube goals were found (${seen})`);
});

// --- Strays (#175, Phear): a mob or two on their own, hundreds of yards from the camp
// that holds the rest, drew the point and the arrow away from the camp the step is about.

test('Phear\'s report: a kill or collect leads to the camp that holds its mobs, not a stray one or two far from it', { skip }, () => {
	// [guide, the goal, the camp's x and y range (map percent), its strays are another dropper's]
	// The Grizzled Scalp's far place is the Den Mother (6788), a different dropper alone at 51.5,38.3:
	// the step pins the bears' camp, so she is not marked at all (#273), rather than kept as an alternative.
	const cases = [
		...DUN_MOROGHS.map((guide) => [guide, 'Frostmane Headhunter (Frostmane Hold)', (g) => g.t === 'kill' && g.npc === 1123 && g.quest === 287, [20, 27, 49, 56]]),
		['forever/alliance/03-darkshore-return.guide', 'Grizzled Scalp', (g) => g.t === 'collect' && g.item === 5414, [37, 46, 69, 83], true],
		['forever/alliance/50-60/02-felwood.guide', 'Jadefire Hellcaller (Jadefire Run)', (g) => g.t === 'kill' && g.npc === 7111, [38, 44, 13, 23]],
		['forever/horde/04-the-barrens.guide', 'Stonetalon Sap', (g) => g.t === 'collect' && g.item === 5582, [32, 41, 9, 21]],
		['forever/horde/50-60/01-un-goro-crater.guide', 'Bloodpetal Lasher (east side)', (g) => g.t === 'kill' && g.npc === 6509, [55, 77, 20, 50]],
		['forever/horde/50-60/01-un-goro-crater.guide', 'Bloodpetal Thresher (east side)', (g) => g.t === 'kill' && g.npc === 6511, [55, 77, 20, 50]],
		['forever/horde/40-50/03-feralas.guide', 'Marsh Flesheater (huts on the western shore)', (g) => g.t === 'kill' && g.npc === 751, [60, 75, 75, 100]],
	];
	const inCamp = ([x0, x1, y0, y1]) => (p) => p.x >= x0 && p.x <= x1 && p.y >= y0 && p.y <= y1;
	for (const [guide, what, pred, camp, otherDropper] of cases) {
		for (const { goal } of goals(guide).filter(({ goal }) => pred(goal))) {
			assert.ok(inCamp(camp)(goal), `${guide}: ${what}: the point ${goal.x},${goal.y} is at the camp`);
			const arrow = goal.spots.filter((s) => !s.alt);
			assert.ok(arrow.length && arrow.every(inCamp(camp)), `${guide}: ${what}: the arrow picks only the camp: ${JSON.stringify(goal.spots)}`);
			if (otherDropper) assert.ok(!goal.spots.some((s) => !inCamp(camp)(s)), `${guide}: ${what}: the other dropper's place is not marked`);
			else assert.ok(goal.spots.some((s) => s.alt && !inCamp(camp)(s)), `${guide}: ${what}: the strays stay alternatives`);
		}
		assert.ok(goals(guide).some(({ goal }) => pred(goal)), `${guide}: ${what} is in the guide`);
	}
	// Not strays: a sparse trail of single spawns (the Lingering Highborne through the ruins), spawns all
	// over a zone (Scourgestones, the OOX beacon) and a target with six spawns or fewer (Pristine Black
	// Diamond). The walk still starts at the spawn nearest the previous goal, a spot the arrow searches.
	const kept = [
		['forever/alliance/50-60/01-burning-steppes.guide', 7972],
		['forever/class/priest/blood-of-morphaz.guide', 7972],
		// (forever/alliance/50-60/03-winterspring.guide's Scourgestones went with Corin's Crossing, left out at 55 in the
		// level tidy 0.4.0: its Scourge are 57-60.)
		['forever/horde/50-60/05-eastern-plaguelands.guide', 12840],
		['forever/horde/40-50/02-feralas.guide', 8705],
		['forever/class/shaman/darkreaver.guide', 18335],
	];
	for (const [guide, item] of kept) {
		const list = goals(guide);
		const { goal } = list[at(list, `${guide}: collect ${item}`, (g) => g.t === 'collect' && g.item === item)];
		const first = goal.spots[0];
		assert.ok(!first.alt && first.n === 1 && Math.hypot(first.x - goal.x, first.y - goal.y) <= 0.1, `${guide}: collect ${item}: the walk starts at the point ${goal.x},${goal.y}: ${JSON.stringify(first)}`);
	}
	const ichor = goals('forever/alliance/50-60/01-burning-steppes.guide').find(({ goal }) => goal.item === 7972).goal;
	const trail = ichor.spots.filter((s) => s.x >= 34 && s.x <= 41 && s.y >= 45 && s.y <= 62);
	assert.equal(trail.length, 6, JSON.stringify(ichor.spots));
	assert.ok(trail.every((s) => !s.alt), 'every spot of the Highborne trail is searched');
});

test('the cloth the guides tell you to buy leads to the Auction House: the capitals\' cloth donations and Grimand\'s Runecloth', { skip }, () => {
	// The auctioneers: Stormwind's Trade District (live frame) and Ironforge's (Era frame).
	const ah = { 1453: { x: 61.2, y: 71.3 }, 1455: { x: 24.2, y: 74.7 } };
	const cases = [
		['forever/alliance/50-60/06-silithus.guide', [7793, 7794, 7795, 7807, 7808, 7809, 7811, 7802, 7803, 7804, 7805]],
		['forever/collectibles/mounts/alliance/paladin-charger.guide', [7642]],
	];
	for (const [guide, quests] of cases) {
		for (const quest of quests) {
			// (The donations are handed in on the spot, #1699: their cloth is collected on the step that hands them in.)
			const at_step = goals(guide).filter(({ goal }) => is('turnin', quest)(goal)).map(({ step }) => step);
			const list = goals(guide).filter(({ goal, step }) => goal.t === 'collect' && (goal.quest === quest || (goal.quest === undefined && at_step.includes(step))) && [2592, 4306, 4338, 14047].includes(goal.item));
			assert.ok(list.length, `${guide}: the cloth of ${quest}`);
			for (const { goal } of list) {
				const at_ = ah[goal.map];
				assert.ok(at_ && goal.x === at_.x && goal.y === at_.y, `${guide}: ${quest} ${goal.itemName}: the point ${goal.map} ${goal.x},${goal.y} is the Auction House`);
				for (const s of (goal.spots || []).filter((o) => !o.alt)) assert.deepEqual([s.x, s.y], [at_.x, at_.y], `${guide}: ${quest}: the arrow picks only the Auction House`);
			}
		}
	}
});

test('every step with a quest objective to do has a goal the arrow can lead to', { skip }, () => {
	const offenders = [];
	for (const guide of allGuides()) {
		const steps = [...new Set(goals(guide).map(({ step }) => step))];
		steps.forEach((step, i) => {
			const open = step.goals.filter((g) => g.t === 'complete' && !FOLLOWS_AN_NPC.has(g.quest));
			if (open.length && !step.goals.some((g) => g.map != null && g.x != null)) offenders.push(`${guide} step ${i + 1} (${step.title}): complete ${open.map((g) => g.quest).join(', ')}`);
		});
	}
	assert.deepEqual(offenders, [], 'steps whose objectives have no place');
});

test('Rumbleshot\'s Ammo, The Red Crystal: every objective the data can place has a goal of its own, not only the turn-in', { skip }, () => {
	const placed = (g) => g.map != null && g.x != null;
	const spawned = (x) => !!x && Object.keys(x.spawns || {}).length > 0;
	const knownPlace = (o) =>
		o.type === 'item'
			? Object.keys(refData().items[o.id]?.drops?.npc || {}).some((n) => spawned(refData().npcs[n])) || Object.keys(refData().items[o.id]?.drops?.object || {}).some((n) => spawned(refData().objects[n]))
			: o.type === 'object'
				? spawned(refData().objects[o.id])
				: o.type === 'event' && o.id != null && placed(o); // an area trigger; an escort's or a script's event has no id
	const offenders = [];
	for (const guide of allGuides()) {
		compiled(guide).steps.forEach((step, i) => {
			for (const g of step.goals) {
				if (g.t !== 'complete' || placed(g) || OBJECTIVE_WITHOUT_A_PLACE.has(g.quest)) continue;
				const objectives = refData().quests[g.quest]?.objectives || [];
				if (!objectives.length || !objectives.every(knownPlace)) continue;
				const leads = (o) => placed(o) && (o.quest === g.quest ? o.t !== 'accept' && o.t !== 'turnin' : o.quest == null && (o.t === 'goto' || o.t === 'use'));
				if (step.goals.some(leads)) continue;
				offenders.push(`${guide} step ${i + 1} (${step.title}): complete ${g.quest}`);
			}
		});
	}
	assert.deepEqual(offenders, [], 'objectives led to only by their turn-in, or not at all');
});

test("Fitz's playtest: every goto at a boat, zeppelin or tram stop is on its deck or pier, not in the water", { skip: navSkip }, () => {
	const { openNav } = require('../../tools/lib/nav/path');
	const { FLAG, TILE_CELLS, cellOf } = require('../../tools/lib/nav/grid/format');
	const { Geo } = require('../../tools/lib/planner/geo');
	const read = (f) => JSON.parse(fs.readFileSync(path.join(DATA, f), 'utf8'));
	const nav = openNav({ dir: NAV });
	const geo = new Geo(read('map-frames.json'), read('zones.json'));
	const stops = read('travel.json').transports.flatMap((t) => ['a', 'b'].map((side) => ({ id: `${t.id} (${t[side].name})`, ...t[side] })));
	// A dry walkable surface in the cell at (wx, wy): not swim or blocked, above any water there, in a region the
	// router snaps to (not a pocket under the deck).
	const dry = (c, wx, wy) => {
		const a = cellOf(wx, wy);
		const t = nav.tile(c, a.col, a.row);
		if (!t) return false;
		const k = a.j * TILE_CELLS + a.i;
		const s = [];
		for (let e = t.first[k]; e < t.first[k + 1]; e++) s.push({ e, z: t.z[e], f: t.flags[e] });
		const water = Math.max(-Infinity, ...s.filter((q) => q.f & FLAG.SWIM).map((q) => q.z));
		return s.some((q) => !(q.f & (FLAG.SWIM | FLAG.BLOCKED)) && q.z > water && (nav.regionSize(c, a.col, a.row, q.e) ?? 1000) >= 1000);
	};
	const nearDry = (c, wx, wy) => {
		if (dry(c, wx, wy)) return true;
		for (let r = 2; r <= 8; r += 2) for (let deg = 0; deg < 360; deg += 15) if (dry(c, wx + r * Math.cos((deg * Math.PI) / 180), wy + r * Math.sin((deg * Math.PI) / 180))) return true;
		return false;
	};
	const offenders = new Set();
	let checked = 0;
	for (const guide of allGuides()) {
		for (const { step, goal } of goals(guide)) {
			if (goal.t !== 'goto') continue;
			const w = geo.toWorld(goal.map, goal.x, goal.y, goal.f || 'l');
			if (!w) continue;
			const stop = stops.find((s) => s.c === w.c && Math.hypot(s.wx - w.wx, s.wy - w.wy) <= 40);
			if (!stop) continue;
			checked++;
			if (!nearDry(w.c, w.wx, w.wy)) offenders.add(`${guide} step "${step.title}": goto ${goal.x},${goal.y} "${goal.text}" by ${stop.id}`);
		}
	}
	assert.ok(checked >= 10, `the guides' transport gotos are found (${checked})`);
	assert.deepEqual([...offenders], [], 'transport gotos with no deck or pier within 8 yd');
});

// --- Typed coordinates on the wrong map (Fitz's playtest: Darkshore's "Boat to
// Stormwind" pointed into Moonglade). Coordinates without `map` are on the zone
// in effect, and a `zone` line holds for the steps after it, even when its step
// is for some characters only: the Night Elf Druids' Moonglade trip set zone
// Moonglade for the rest of Darkshore, and a Paladin trip set Thunder Bluff for
// the Barrens Warlocks' summoning circle in Orgrimmar. Each such goal is on the
// zone every character who sees it is in: the last `zone` line of the steps
// that character sees.

test("Fitz's playtest: typed coordinates are on the zone of every character who sees them", { skip: skip || needs('races.json') }, () => {
	const { characterKeys } = require('../../tools/lib/dsl/conditions');
	const races = JSON.parse(fs.readFileSync(path.join(DATA, 'races.json'), 'utf8'));
	const classesOf = (race, side) => (races[race] && races[race][side] ? races[race][side].classes : null);
	const offenders = [];
	for (const guide of allGuides()) {
		const g = compiled(guide);
		const ast = g._ast;
		const lines = fs.readFileSync(path.join(OFFICIAL_DIR, guide), 'utf8').split(/\r?\n/);
		const zoneAt = (ln) => (ln ? lines[ln - 1].trim() : 'no zone');
		const head = { factions: ast.header.faction ? [ast.header.faction] : null, races: ast.header.races || null, classes: ast.header.classes || null };
		// Every step's `zone` lines, with who sees the step.
		const zoneLines = ast.steps.flatMap((s, i) => {
			const end = i + 1 < ast.steps.length ? ast.steps[i + 1].line : lines.length + 1;
			const who = characterKeys([head, s.only], classesOf);
			const out = [];
			for (let ln = s.line + 1; ln < end; ln++) if (/^\s+zone\b/.test(lines[ln - 1])) out.push({ ln, who });
			return out;
		});
		ast.steps.forEach((s, si) => {
			s.goals.forEach((ag, gi) => {
				if (!ag.explicitCoords || ag.coordMap !== undefined) return;
				const compiledZone = zoneAt(ag.zone && ag.zone.line);
				const elsewhere = new Set();
				for (const k of characterKeys([head, s.only, ag.only], classesOf)) {
					let ln = ast.header.zone ? ast.header.zone.line : null;
					for (const z of zoneLines) if (z.ln < ag.line && z.who.has(k)) ln = z.ln;
					if (zoneAt(ln) !== compiledZone) elsewhere.add(zoneAt(ln));
				}
				const goal = g.steps[si].goals[gi];
				if (elsewhere.size) offenders.push(`${guide}:${ag.line} (${goal.t} ${goal.x},${goal.y}) is on ${compiledZone}, for characters in ${[...elsewhere].join(', ')}`);
			});
		});
	}
	assert.deepEqual(offenders, [], 'typed coordinates on a zone some of their characters are not in');
});

// Tirion's quests have two givers in the data: Tirion Fordring (1855) at his
// hut on the Thondroril, and Lord Tirion Fordring (12126), who stands in
// Hearthglen only during the In Dreams event. On Western Plaguelands' map the
// compiler picked the one spawned there, 12126, and sent players into the
// Scarlet town (the Alliance Western Plaguelands and Horde Felwood guides).
test('#246: every goal with Tirion leads to Tirion Fordring at his hut, never to Lord Tirion Fordring in Hearthglen', { skip }, () => {
	const tirion = [5542, 5543, 5544, 5742, 5781];
	const found = [];
	for (const guide of allGuides()) {
		for (const { step, goal } of goals(guide)) {
			if (!tirion.includes(goal.quest) || !['accept', 'turnin'].includes(goal.t)) continue;
			found.push(`${guide} ${goal.t} ${goal.quest}`);
			const picked = { npc: goal.npc, map: goal.map };
			assert.deepEqual(picked, { npc: 1855, map: 1423 }, `${guide} (step ${step.title}) ${goal.t} ${goal.quest}: Tirion Fordring on the Eastern Plaguelands' map`);
		}
	}
	// Horde: since the 0.4.0 level tidy Tirion's hunts are taken on 50-60/05's ride east past his hut, where they are done.
	for (const guide of ['forever/alliance/50-60/04-western-plaguelands.guide', 'forever/horde/50-60/05-eastern-plaguelands.guide']) {
		for (const q of [5542, 5543, 5544]) assert.ok(found.includes(`${guide} accept ${q}`), `${guide} takes ${q} from Tirion`);
	}
});

// --- Ashenvale (Zerkness #383, Ioney #396, soockee #1117; QuestieDB 1.0.14 check, 0.3.8): Alonso's Dragonslayer
// quests (78132-78134, Warriors only: corrections) are handed in at his window with the item each names, as the
// server's quest records in players' caches say: a helm from Shadowfang Keep, a wall-mounted shield the data places
// nowhere and a lance only the Dark Iron Entrepreneur in the Wetlands sells. The Ashenvale routes led Warriors to him
// to take and hand them in on the spot, which nobody can without the items and no recorded player has done; the
// route fixes leave all three out, so the Warriors-only step at Mystral Lake goes with them.

test('Alonso\'s Dragonslayer quests are left out of both Ashenvale guides: each needs an item a leveling route never gets (#383, #1117, QuestieDB 1.0.14)', { skip }, () => {
	const chain = [78132, 78133, 78134];
	const { overrides } = JSON.parse(fs.readFileSync(path.join(ROOT, 'data', 'route-fixes.json'), 'utf8'));
	for (const q of chain) assert.ok(overrides.skip.some((s) => s.q === q && !s.faction), `route-fixes leaves ${q} out on both sides`);
	for (const guide of [ASHENVALE, ASHENVALE_HORDE]) {
		const left = goals(guide).filter(({ goal }) => chain.includes(goal.quest)).map(({ goal }) => `${goal.t} ${goal.quest}`);
		assert.deepEqual(left, [], `${guide}: no Dragonslayer quest`);
	}
});

// --- Battleworn Axe (Tazul, #286): the Redridge guide typed the orcs' camp at
// Alther's Mill as @55.9,43.6, a live-frame spot from the data, in a guide
// whose coordinates are Era-frame by default. Redridge's Forever map is
// shifted 5 units from Classic's, so the arrow led into the tarantulas in the
// middle of the mill, 68 yd west of the nearest orc. A typed coordinate on a
// goal the data can place is near one of its spawns in the frame it is
// compiled in, not only in the other one.
test("#286: a typed coordinate is near its target's spawns in its own map frame, not only in the other one", { skip }, () => {
	refData();
	const { point } = makeProjector(refData().mapFrames);
	const offenders = [];
	for (const guide of allGuides()) {
		const g = compiled(guide);
		g._ast.steps.forEach((as, si) => as.goals.forEach((ag, gi) => {
			const goal = g.steps[si] && g.steps[si].goals[gi];
			if (!ag.explicitCoords || !goal || goal.map == null || goal.x == null) return;
			const targets = [];
			if (goal.t === 'collect') {
				const item = refData().item(goal.item);
				for (const id of Object.keys((item && item.drops && item.drops.npc) || {})) targets.push(['npc', id]);
				for (const id of Object.keys((item && item.drops && item.drops.object) || {})) targets.push(['object', id]);
			} else if (goal.npc) targets.push(['npc', goal.npc]);
			else if (goal.object) targets.push(['object', goal.object]);
			const pts = targets.flatMap(([kind, id]) => refData().spawns(kind, Number(id)).filter((s) => s.map === goal.map).flatMap((s) => s.pts.map((p) => point(s.map, p[0], p[1], s.f))));
			if (!pts.length) return;
			const f = goal.f || 'l';
			const near = (q) => Math.min(...pts.map((p) => Math.hypot(p.wx - q.wx, p.wy - q.wy)));
			const own = near(point(goal.map, goal.x, goal.y, f));
			const other = near(point(goal.map, goal.x, goal.y, f === 'l' ? 'e' : 'l'));
			if (own > 40 && other < 10) offenders.push(`${guide}:${ag.line} ${goal.t} @${goal.x},${goal.y} (step ${g.steps[si].title}) is ${Math.round(own)} yd from its target in its ${f === 'l' ? 'live' : 'Era'} frame, ${Math.round(other)} yd in the other`);
		}));
	}
	assert.deepEqual(offenders, [], 'typed coordinates written in the other map frame');
});
test("Bashidian Twotao's report (#385): a quest drop from droppers of several level bands leads to the low ones' camp, not over the whole zone", { skip }, () => {
	refData();
	for (const [guide, item, quest] of BY_LEVEL) {
		// The step that does the work: an along list (the Barrens' beaks, worked on the way, #1135) has
		// its place on the finish step.
		const list = working(goals(guide));
		const { goal } = list[at(list, `${guide} collect ${item}`, (g) => g.t === 'collect' && g.item === item && g.quest === quest)];
		const qlvl = refData().quest(quest).level;
		const what = `${guide} collect ${item} (quest ${quest}, level ${qlvl})`;
		assert.ok(located({ goal }) && !goal.spread, `${what} has a point and is no zone-wide search`);
		const droppers = Object.keys(refData().item(item).drops.npc).map((id) => refData().npc(Number(id))).filter((n) => n && n.spawns && n.spawns[goal.map]);
		const here = droppers.filter((n) => n.spawns[goal.map].pts.some((p) => Math.hypot(p[0] - goal.x, p[1] - goal.y) < 3));
		assert.ok(here.length && here.every((n) => n.level <= qlvl + 2), `${what} leads to droppers at most two levels above the quest (${here.map((n) => `${n.name} ${n.level}`).join(', ')})`);
	}
	const paws = goals(WESTFALL).find(({ goal }) => goal.t === 'collect' && goal.item === 725).goal;
	assert.ok(paws.y < 35, `the Gnoll Paws lead into the north hills (${paws.x},${paws.y})`);
});

test('#327: Pirate Hats Ahoy! names every pirate that drops the hat, not the Southsea Kidnapper alone, in both guides', { skip }, () => {
	for (const guide of [TANARIS_ALLIANCE, 'forever/horde/40-50/02-feralas.guide']) {
		const list = goals(guide);
		const { goal } = list[at(list, `${guide}: the Southsea Pirate Hat collect`, (g) => g.t === 'collect' && g.quest === 8365 && g.item === 20519)];
		const ids = (goal.fromNpcs || []).map((n) => n.npc);
		for (const pirate of [7855, 7856, 7857, 7858]) assert.ok(ids.includes(pirate), `${guide}: pirate ${pirate} is among the droppers (${ids.join(', ')})`);
		assert.notEqual(goal.from, 'Southsea Kidnapper', `${guide}: the goal does not send the player after the Kidnapper alone`);
	}
});

// gidi_'s report (#2648): Zimmix's Great Escape (97331) was accepted at his cell with the escort only in a note, so the
// step was done on the accept and the guide moved on while Zimmix walked out of Zul'Kunda. The merged data had no
// objective for it (players' recordings: one event line, "Escort Zimmix Sputterspark to safety", done east of the
// ruins), so no check saw a hand-in without work. Both Stranglethorn guides wait for the escort in the accept's step.
test("gidi_'s report (#2648): Zimmix's escort is a goal of his step in both Stranglethorn guides, before the hand-in", { skip }, () => {
	for (const file of [STRANGLETHORN_HORDE, 'forever/alliance/30-40/04b-stranglethorn-vale.guide']) {
		const list = goals(file);
		const accept = at(list, `${file}: accept 97331`, is('accept', 97331));
		const escort = at(list, `${file}: complete 97331`, is('complete', 97331));
		assert.equal(list[escort].s, list[accept].s, `${file}: in Zimmix's step`);
		assert.ok(accept < escort && escort < at(list, `${file}: turnin 97331`, is('turnin', 97331)), `${file}: accept, the escort, then the hand-in`);
		const { goal } = list[escort];
		assert.ok(goal.map === 1434 && Math.hypot(goal.x - 26.8, goal.y - 11.4) < 1, `${file}: where the escort ends (${goal.map} ${goal.x},${goal.y})`);
	}
});

// The same gap as Zimmix's (#2648), found by comparing the data with players' recordings: quests whose objectives the
// merged data lacks (two escorts, two spell casts, a ghost elixir) were taken and handed in with nothing between, so
// the step was done on the accept. Each guide now has the work as a goal between the accept and the hand-in, where
// players' recordings have it done.
test('quests the data had no objectives for: their work is a goal between the accept and the hand-in', { skip }, () => {
	const cases = [
		['forever/alliance/30-40/01-hillsbrad-foothills.guide', 87491, 'complete', { map: 1437, x: 47.8, y: 16.8 }], // Spark of Freedom, escort
		['forever/alliance/30-40/05-arathi-highlands.guide', 93585, 'complete', { map: 1435, x: 26.0, y: 31.7 }], // This Light of Mine, escort
		['forever/alliance/skyborne/01-zephras-isle.guide', 92474, 'complete', { x: 43.7, y: 24.1 }], // Falling With Style, on the watchtower
		['forever/horde/skyborne/01-zephras-isle.guide', 92474, 'complete', { x: 43.7, y: 24.1 }],
		['forever/alliance/nightelf/01-teldrassil.guide', 97979, 'complete', null], // The Goddess Provides, two casts at Shanda
		['forever/alliance/50-60/04-western-plaguelands.guide', 3912, 'use', { map: 1446, x: 54.0, y: 28.7 }], // Meet at the Grave: the Videre Elixir
	];
	for (const [file, q, t, at_] of cases) {
		const list = goals(file);
		const work = at(list, `${file}: ${t} for ${q}`, (g) => g.t === t && (t === 'use' ? g.item === 11243 : g.quest === q));
		const tin = at(list, `${file}: turnin ${q}`, is('turnin', q));
		assert.ok(work < tin, `${file}: the work before the hand-in of ${q}`);
		const acc = list.findIndex(({ goal }) => is('accept', q)(goal));
		if (acc >= 0) assert.ok(acc < work, `${file}: after the accept of ${q}`);
		if (at_) {
			const { goal } = list[work];
			if (at_.map) assert.equal(goal.map, at_.map, `${file}: ${q} on map ${at_.map}`);
			assert.ok(Math.hypot(goal.x - at_.x, goal.y - at_.y) < 1, `${file}: ${q} where players do it (${goal.map} ${goal.x},${goal.y})`);
		}
	}
});

// A bare `complete` gave the window no target, spawn area or progress for a
// quest whose objective is a plain one (#956). The Tome of Divinity's
// objective is a kill credit for using the Symbol of Life on Henze Faulk: the
// step uses it on him, tracked from the quest log, and never reads "Kill".
// The Northern Pylon is an object to click.
test(`${REDRIDGE}: the Henze Faulk step tracks 1786.1 with an objective goal, not \`complete\` (#956)`, { skip }, () => {
	const list = goals(REDRIDGE);
	assert.ok(!list.some(({ goal }) => is('complete', 1786)(goal)), 'no bare complete 1786');
	const i = at(list, 'use 6866 quest 1786.1', (g) => g.t === 'use' && g.quest === 1786 && g.oi === 1);
	assert.equal(list[i].step.title, 'Henze Faulk');
	assert.equal(list[i].goal.item, 6866, 'the Symbol of Life');
	const paladin = { race: 'Human', raceName: 'Human', faction: 'Alliance', cls: 'PALADIN', className: 'Paladin', level: 12 };
	const line = (fulfilled) => stepView(REDRIDGE, paladin, list[i].s, `w.onQuest(1786, { { required = 1, fulfilled = ${fulfilled} } })`).goals.find((g) => g.quest === 1786 && g.t === 'use');
	assert.ok(!/\bKill\b/.test(line(0).text), `"${line(0).text}" does not read Kill`);
	assert.notEqual(line(0).status, 'done', 'open while the quest log has Henze to do');
	assert.equal(line(1).status, 'done', 'done once the quest log counts him');
	// (Fix round 1, 0.4.0: the Alliance's Northern Pylon is on the Western Plaguelands guide's Un'Goro visit.)
	for (const guide of ['forever/alliance/50-60/04-western-plaguelands.guide', 'forever/horde/50-60/01-un-goro-crater.guide']) {
		const pylon = goals(guide);
		assert.ok(!pylon.some(({ goal }) => is('complete', 4285)(goal)), `${guide}: no bare complete 4285`);
		const { goal } = pylon[at(pylon, 'interact 164955 quest 4285.1', (g) => g.t === 'interact' && g.quest === 4285 && g.oi === 1)];
		assert.equal(goal.object, 164955, `${guide}: the Northern Crystal Pylon`);
	}
});

// --- mariusch's elite blocks (#639): the optional elites of the start zones
// and the Barrens are asked (`when group`), accept to turn-in, not offered
// to a solo player as bare optional goals.
test("mariusch's report (#639): Vulgara, Aggor the Young and Bruuz are asked as group quests, every goal of them", { skip }, () => {
	for (const [guide, quest] of [
		[ZEPHRAS_ALLIANCE, 93318],
		[ZEPHRAS_HORDE, 93318],
		...DUROTARS.map((guide) => [guide, 99052]),
		[BARRENS, 92706],
	]) {
		const mine = goals(guide).filter(({ goal }) => goal.quest === quest);
		assert.deepEqual([...new Set(mine.map(({ goal }) => goal.t))].sort(), ['accept', 'collect', 'turnin'], `${guide}: ${quest} accepted, done and handed in`);
		for (const { step, goal } of mine) {
			assert.ok((step.when || []).some((p) => p.k === 'group' && p.q === quest && !p.neg), `${guide}: ${goal.t} ${quest} is under when group ${quest}`);
		}
	}
});

// --- Snowiee's report (#912): the Night Elves' Goldshire training stop has no
// Druid trainer, so the Druids walked from Stormwind Harbor to Goldshire, back
// to Stormwind to train and back to Goldshire. A class the stop cannot train
// trains in the town the way to it passes, a few hundred yards from its
// trainer, before the way leaves that town: the Druids in Stormwind, the
// Paladins of the Felwood stop in Brill before the zeppelin to Orgrimmar.
test("Snowiee's report (#912): a class the training stop cannot train trains in the town the way passes with its trainer, before leaving it", { skip }, () => {
	for (const [guide, cls, after, before] of [
		['forever/alliance/nightelf/02-darkshore.guide', 'DRUID', (g) => g.t === 'getfp' && g.location === 'Stormwind', (g) => g.t === 'goto' && g.text === 'Goldshire'],
		['forever/horde/50-60/02-felwood.guide', 'PALADIN', (g) => g.t === 'goto' && g.text === 'Brill', (g) => g.t === 'goto' && g.text === 'Zeppelin to Orgrimmar'],
	]) {
		const mine = goals(guide).filter(forClass(cls));
		const into = at(mine, `${guide}: the way into town`, after);
		const train = mine.findIndex(({ goal }, i) => i > into && goal.t === 'train' && goal.class);
		assert.ok(train >= 0, `${guide}: the ${cls}s train after the way reaches the town`);
		assert.ok(train < at(mine, `${guide}: the way out of town`, before), `${guide}: the ${cls}s train before the way leaves the town`);
	}
});

// --- Fitz (0.4.0): "every time I go to Moonglade" the guides said to learn the
// flight path in Nighthaven, where Silva Fil'naveth (Alliance) and Bunthen
// Plainswind (Horde) only fly Druids from their gossip (travel.json class DRUID,
// taxi nodes 62 and 63) and teach no flight path. Moonglade's flight path is
// Sindrayl's (node 49, Alliance) or Faustron's (node 69, Horde). Every getfp in
// Moonglade resolves to the one of its side, with the arrow on him, never to
// Nighthaven's; a step tip that speaks of the flight path by Nighthaven names him.
test("Fitz (0.4.0): Moonglade's flight path is Sindrayl's or Faustron's, never Nighthaven's Druid flight masters", { skip: skip || needs('travel.json') }, () => {
	const master = { Alliance: [49, 10897, 'Sindrayl'], Horde: [69, 12740, 'Faustron'] };
	let seen = 0;
	for (const guide of allGuides()) {
		for (const { step, goal } of goals(guide)) {
			if (goal.t !== 'getfp' || !/moonglade|nighthaven/i.test(goal.location)) continue;
			seen++;
			const where = `${guide}: "${step.title}" getfp ${goal.location}`;
			const sides = [goal.only, step.only].map((o) => o && o.factions).find(Boolean) || [];
			const side = goal.node === 69 ? 'Horde' : 'Alliance';
			assert.deepEqual([goal.node, goal.npc, goal.npcName], master[side], `${where}: Sindrayl or Faustron`);
			assert.ok(!sides.length || sides.includes(side), `${where}: ${master[side][2]} serves ${side}, the goal is for ${sides}`);
			assert.equal(goal.map, 1450, `${where}: the arrow points at him`);
			const tip = [].concat(step.note || []).join(' ');
			if (/flight path/i.test(tip) && /Nighthaven/.test(tip)) assert.match(tip, /Sindrayl|Faustron/, `${where}: tip: ${tip}`);
		}
	}
	assert.ok(seen >= 6, `${seen} Moonglade flight path goals`);
});

// Final route review 0.3.6 (1-30, the same sweep): the class walks to a class quest carried from an earlier guide in
// Westfall (Human Priests to Laurena, 94774), Duskwood (Rogues to Agent Kearnen, 2360) and the Barrens (Orc and Troll
// Shamans to Telf Joolam, 1525; Shamans to Brine, 1536) wait for that quest in the log.
test('Leveling 1-30: a class walk to a carried class quest waits for that quest in the log', { skip }, () => {
	for (const [guide, quest] of [
		['forever/alliance/02-westfall.guide', 94774],
		['forever/alliance/05-duskwood.guide', 2360],
		['forever/horde/02-the-barrens.guide', 1525],
		['forever/horde/04-the-barrens.guide', 1536],
	]) {
		const steps = compiled(guide).steps;
		const hand = steps.findIndex((st) => st.goals.some(is('turnin', quest)));
		assert.ok(hand > 0, `${guide}: turnin ${quest} is in the guide`);
		const walk = steps[hand - 1];
		assert.ok(walk.only && walk.goals.length && walk.goals.every((g) => g.t === 'goto'), `${guide}: a class walk leads to turnin ${quest}`);
		assert.ok((walk.when || []).some((p) => p.k === 'onquest' && !p.neg && [].concat(p.q).includes(quest)), `${guide}: "${walk.title}" waits for ${quest} in the log`);
	}
});

// #960, after #941: the givers the data puts on an upper floor (spawn heights from classic-db and
// the Forever server agree; the walking grid has a floor under them and the ground floor below).
// The arrow has no height, so every step at one of them says to go up, in a goal note or the tip.
// #961 (Verium, Human Mage): the first `train class` in Northshire led a Mage to the Abbey's ground
// floor under Khelden Bremen. A `train class` step whose nearest trainer for a class (to the step's
// other goals) stands upstairs says so too.
test('Upper-floor givers (#960, #961): every step at one says to go up, train-class steps included', { skip: skip || needs('spawnz.json') }, () => {
	const givers = {
		2104: 'Stoutfist', 4964: 'Samaul', 7879: 'Quintis', 2316: "Gol'dir", 2501: 'MacKinley', 3391: 'Gazlowe',
		377: 'Josetta', 328: 'Zaldimar', 198: 'Khelden', 7880: 'Ginro', 7907: 'Daryn', 2107: 'Gaerolas',
		11802: 'Dendrite', 15189: 'Beetix', 15190: 'Noggle', 5394: 'Neeka', 14736: 'Primal Torntusk',
		// Class trainers: Goldshire's inn, Brill's inn, the ramps of Aldrassil.
		917: 'Keryn Sylvius', 2128: 'Cain Firesong', 2129: 'Beryl', 2127: 'Rupert Boch', 2130: 'Marion Call',
		3593: 'Alyissia', 3594: 'Frahun Shadewhisper', 3595: 'Shanda', 3596: 'Ayanna Everstride', 3597: 'Mardant Strongoak',
	};
	const near = (a, b) => {
		const f = a.map === b.map && (a.f || 'l') === (b.f || 'l') && refData().eraFrame(a.map);
		return f ? Math.hypot(((f.right - f.left) * (a.x - b.x)) / 100, ((f.bottom - f.top) * (a.y - b.y)) / 100) : Infinity;
	};
	const up = /\b(upstairs|top floor|upper level|second level|on top of)\b/i;
	const said = (step, npc) => {
		const key = givers[npc];
		const sentences = [].concat(step.note || []).join(' ').split(/(?<=\.)\s+/);
		const he = /^(He|Dendrite) stands upstairs/;
		return step.goals.some((g) => g.npc === npc && up.test(g.note || '')) || sentences.some((s) => up.test(s) && (s.includes(key) || (he.test(s) && sentences.join(' ').includes(key))));
	};
	const missing = [];
	let seen = 0;
	for (const guide of allGuides()) {
		for (const step of compiled(guide).steps) {
			if (step.along) continue;
			const atNpc = new Set(step.goals.filter((g) => (g.t === 'accept' || g.t === 'turnin') && givers[g.npc]).map((g) => g.npc));
			// The trainer each class walks to: the nearest candidate to the step's other goals, within 120 yd.
			const here = step.goals.filter((g) => g.t !== 'train' && g.map != null && g.x != null);
			for (const g of step.goals.filter((g) => g.t === 'train' && g.class && here.length)) {
				const byClass = new Map();
				for (const c of g.candidates || []) {
					const d = Math.min(...here.map((h) => near(h, c)));
					for (const cls of c.classes || []) if (!byClass.has(cls) || d < byClass.get(cls).d) byClass.set(cls, { npc: c.npc, d });
				}
				for (const { npc, d } of byClass.values()) if (d <= 120 && givers[npc]) atNpc.add(npc);
			}
			for (const npc of atNpc) {
				seen++;
				if (!said(step, npc)) missing.push(`${guide}: step "${step.title}" at ${givers[npc]}`);
			}
		}
	}
	assert.ok(seen > 50, `the givers' steps are found (${seen})`);
	assert.deepEqual(missing, []);
});

// --- Flight path sweep (#964), travel tips: tips kept from the seed sent players on
// flights they can't take where they stand: from a flight master in another zone, or
// to or from a flight path no chain of that side has learned by then (Ratchet and
// Talonbranch Glade for the Alliance at those levels, Zoram'gar, Undercity and Tarren
// Mill for the Horde, Stormwind for Humans in Westfall). Each tip now names the way
// the guide goes. Read from the guide files: a step is found by a line it holds.
test('flight path sweep (#972): travel tips name only flights the player can take there', () => {
	const cases = [
		// (Super Sticky 4504 is taken on the later Gadgetzan stop since the Alliance 40-60 order, #1228: the arrival step is found by Gaeriyan's hand-in.)
		['alliance/40-50/07-un-goro-crater', 'turnin 2941', /From Ratchet/],
		['alliance/50-60/02-felwood', 'turnin 5156', /Talonbranch/],
		['alliance/50-60/03-winterspring', 'turnin 6028', /Timbermaw|Auberdine/],
		['alliance/50-60/04-western-plaguelands', 'turnin 5158', /^Fly to Ratchet/],
		['alliance/50-60/06-silithus', 'turnin 4502', /Cenarion Hold/],
		['alliance/40-50/02-badlands', 'turnin 4488', /^Fly to Ratchet|Fly back to Theramore/],
		['alliance/02-westfall', 'accept 1638', /Fly or walk/],
		['alliance/02-westfall', 'turnin 94774', /Fly or walk/],
		['alliance/02-westfall', 'train class only Warrior,Paladin,Hunter,Rogue,Priest,Mage,Warlock,Druid', /Fly or walk/],
		['horde/05-stonetalon-mountains', 'accept 6442', /Fly from Ratchet/],
		['horde/05-stonetalon-mountains', 'accept 95883', /Tarren Mill flight path|fly from the Undercity/],
		['horde/07-ashenvale', 'accept 4542', /Fly from Thunder Bluff/],
		['horde/07-ashenvale', 'turnin 1534', /Fly from Thunder Bluff/],
		['horde/40-50/06-azshara', 'turnin 2932', /Valormok/],
		['horde/40-50/02-feralas', 'Alodan the Hopeful (Paladins).', /from Gadgetzan/],
		// (Since the Horde 30-40 re-order the Druids fly from Freewind Post, Orgrimmar and Shadowprey Village straight to Thunder Bluff.)
		['horde/30-40/01-hillsbrad-foothills', 'only Druid\n  zone Thunder Bluff\n  tip Fly from', /from Orgrimmar|from Shadowprey/],
		['horde/30-40/03-stranglethorn-vale', 'only Druid\n  zone Thunder Bluff\n  tip Fly from', /from Orgrimmar/],
		['horde/50-60/05-eastern-plaguelands', 'train class only Druid,Paladin', /Fly to the Undercity/],
	];
	for (const [guide, anchor, wrong] of cases) {
		const text = fs.readFileSync(path.join(ROOT, 'guides', 'forever', `${guide}.guide`), 'utf8');
		const steps = text.split('\nstep ').filter((s) => anchor.split('|').some((a) => s.includes(a)));
		assert.ok(steps.length > 0, `${guide}: a step with "${anchor}"`);
		for (const s of steps) {
			const tip = (s.match(/^\s+tip (.*)$/m) || [])[1] || '';
			assert.doesNotMatch(tip, wrong, `${guide}, step "${s.split('\n')[0]}": tip "${tip}"`);
		}
	}
});
for (const [guide, gone, mobs] of LEVEL_FIT) {
	test(`Fyurie's report (#977): ${guide.replace(/^forever\//, '')} sends nobody to work far above their level`, { skip }, () => {
		for (const { step, goal } of goals(guide)) {
			assert.ok(!gone.includes(goal.quest), `${guide}: "${step.title}" ${goal.t} ${goal.quest} is left out for the level`);
			assert.ok(!mobs.includes(goal.npc), `${guide}: "${step.title}" ${goal.t} targets npc ${goal.npc}`);
			const from = goal.fromNpcs || [];
			assert.ok(!(from.length && from.every((n) => mobs.includes(n.npc))), `${guide}: "${step.title}" ${goal.t} ${goal.item} drops only from ${from.map((n) => n.npcName).join(', ')}`);
		}
	});
}

// Danger-at-the-spot sweep (#1575): every leveling guide's kill/collect/use goal against the mobs around it (spawn data),
// the route's level there (the calibrated level model) and players' recordings (deaths at the spot, the levels the goal
// was done at). The clear cases are warned about at the step, each with a guide-fixes record, in every leveling guide
// that holds the goal.
test('Danger at the spot (#1575): the steps players died at among elites say so, in every leveling guide holding the goal', { skip }, () => {
	const fixes = JSON.parse(fs.readFileSync(path.join(ROOT, 'data', 'guide-fixes.json'), 'utf8')).fixes;
	const cases = [
		// [quest, objective, what the tip names, leveling guides holding the goal]
		[91723, 1, /Mother Fang \(7-10\)[^.]*elites/, ['forever/alliance/human/01-elwynn-forest.guide']],
		[87, 1, /Nimsy \(6\)[^.]*elite/, ['forever/alliance/human/01-elwynn-forest.guide']],
		[21, 1, /Shinyfinder Narf \(3\) is elite/, ['forever/alliance/human/01-elwynn-forest.guide']],
		[806, 1, /Halikor, a level 12 elite/, ['forever/horde/orc/01-durotar.guide', 'forever/horde/troll/01-durotar.guide']],
		[827, 1, /Gazz'uz \(14\)[^.]*own/, ['forever/horde/orc/01-durotar.guide', 'forever/horde/troll/01-durotar.guide']],
		[96821, 2, /Ukorsbane \(8\) is elite/, ['forever/horde/orc/01-durotar.guide', 'forever/horde/troll/01-durotar.guide']],
		[371, 2, /Riptear \(13\) is elite/, ['forever/horde/undead/01-tirisfal-glades.guide']],
		[1504, 1, /the voidwalker you summon hits hard/, ['forever/horde/orc/01-durotar.guide', 'forever/horde/troll/01-durotar.guide']],
		[1498, 1, /Halikor, a level 12 elite/, ['forever/horde/orc/01-durotar.guide', 'forever/horde/troll/01-durotar.guide', 'forever/horde/tauren/01-mulgore.guide']],
		[5041, 1, /Flesheaters and Berserkers \(18-19\) are elites/, ['forever/horde/02-the-barrens.guide']],
		[872, 1, /Flesheaters and Berserkers \(18-19\) are elites/, ['forever/horde/02-the-barrens.guide']],
		[966, 1, /Voidcallers \(28-29\)[^.]*Athrikus Narassin \(31\)/, ['forever/alliance/03-darkshore.guide']],
		[86585, 1, /Stonevault Cave Hunters \(36, elite\)/, ['forever/alliance/03-loch-modan.guide']],
	];
	for (const [quest, oi, says, files] of cases) {
		assert.ok(fixes.some((f) => f.at && f.at.quest === quest && f.at.objective === oi && says.test(f.tip || '')), `${quest}.${oi}: the tip is a guide-fixes record`);
		for (const file of files) {
			const here = goals(file).filter(({ goal }) => goal.quest === quest && goal.oi === oi && goal.t !== 'accept' && goal.t !== 'turnin');
			assert.ok(here.length > 0, `${file}: ${quest}.${oi} is worked`);
			for (const { step } of here) assert.match([step.note, step.tip].flat().filter(Boolean).join(' '), says, `${file}, "${step.title}": the step warns`);
		}
	}
});

test('Danger at the spot (#1575): goals an item several mobs drop point at the ones at the route\'s level, not a camp 4+ levels over (#1695\'s pattern)', { skip }, () => {
	const places = JSON.parse(fs.readFileSync(path.join(ROOT, 'data', 'places.json'), 'utf8')).places;
	for (const [file, quest, oi, box, notFrom] of [
		// Yeti Fur (Alliance, route level 31): the Foothill Caverns' Cave and Ferocious Yetis, not the northern cave's 32-34 yetis and Greench (36 elite).
		['forever/alliance/30-40/01-hillsbrad-foothills.guide', 565, 4, [42, 47, 25, 34], [2250, 2251]],
		// The Burning of Spirits (route level 33): Thunder Axe Fortress' cultists (30-33), not the Mannoroc Coven's Summoners and Invokers (38-40).
		['forever/horde/30-40/02-thousand-needles.guide', 1435, 1, [52, 58, 21, 34], [4668, 4705]],
	]) {
		assert.ok(places.some((p) => p.quest === quest && p.objective === oi && p.at), `${quest}.${oi}: the point is a places.json record`);
		const here = goals(file).filter(({ goal }) => goal.t === 'collect' && goal.quest === quest && goal.oi === oi);
		assert.ok(here.length > 0, `${file}: ${quest}.${oi} is collected`);
		for (const { goal } of here) {
			const [x0, x1, y0, y1] = box;
			for (const p of [goal, ...(goal.spots || [])]) assert.ok(p.x >= x0 && p.x <= x1 && p.y >= y0 && p.y <= y1, `${quest}.${oi}: every point is at the camp meant (${p.x},${p.y})`);
			const from = (goal.fromNpcs || []).map((n) => n.npc);
			for (const id of notFrom) assert.ok(!from.includes(id), `${quest}.${oi}: npc ${id} is not a target (${from.join(', ')})`);
		}
	}
});

test("Snowiee's report (#1003): the Great Cat Spirit's accepts and turn-ins point to where it stands in Moonglade, by the bridge", { skip }, () => {
	// Recorded hand-ins of 98394 and 98396 at Moonglade 54.30,75.01 and 54.69,75.01; the reporter stood
	// by it at 54.60,75.07. The merged data had 58.39,73.52, about 90 yards east.
	const spirit = { map: 1450, x: 54.5, y: 75 };
	const spawn = (loadCorrections().npcs[11957] || {}).addSpawns;
	assert.deepEqual(spawn && spawn[spirit.map].pts, [[spirit.x, spirit.y]], 'the correction places the spirit');
	// The generated guides keep the point through a build from data/places.json (giver and ender of each quest).
	const { places } = JSON.parse(fs.readFileSync(path.join(ROOT, 'data', 'places.json'), 'utf8'));
	for (const [quest, objective] of [[98394, 'ender'], [98396, 'giver'], [98396, 'ender'], [98731, 'giver'], [98405, 'ender'], [98342, 'giver'], [98342, 'ender'], [98739, 'giver']]) {
		const rec = places.find((p) => p.quest === quest && p.objective === objective);
		assert.deepEqual(rec && rec.at, { ...spirit, frame: 'era' }, `data/places.json places the ${objective} of ${quest}`);
	}
	for (const guide of ['forever/class/druid/cat-form.guide', 'forever/alliance/03-darkshore-return.guide', 'forever/horde/02-the-barrens.guide']) {
		const list = goals(guide).filter(({ goal }) => goal.npc === 11957 && ['accept', 'turnin'].includes(goal.t));
		assert.ok(list.length >= 4, `${guide}: the spirit's goals are in the guide`);
		for (const { goal } of list) {
			assert.deepEqual({ map: goal.map, x: goal.x, y: goal.y }, spirit, `${guide}: ${goal.t} ${goal.quest}`);
		}
	}
});

// #1024 (Pilk, Tauren Druid): Apothecary Zamah's arrow led up out of the Pools of Vision, the cave under
// Spirit Rise in Thunder Bluff. The NPCs down there (spawn heights 97 to 112; Spirit Rise above them at about
// 135-138): every step at one says so, since the arrow cannot tell the floors apart. Birgitte Cranston's tip
// had her "with the mage trainers on Spirit Rise".
test('Pools of Vision NPCs (#1024): every step at one says they stand down in the cave under Spirit Rise', { skip: skip || needs('spawnz.json') }, () => {
	const below = {
		3419: 'Apothecary Zamah', 3044: 'Miles Welsh', 3045: 'Malakai Cross', 3046: 'Father Cobb', 3047: 'Archmage Shymm',
		3048: 'Ursyn Ghull', 3049: 'Thurston Xane', 5543: 'Clarice Foster', 5957: 'Birgitte Cranston',
	};
	const down = /\b(Pools of Vision|cave under Spirit Rise)\b/;
	const missing = [];
	let seen = 0;
	for (const guide of allGuides()) {
		for (const step of compiled(guide).steps) {
			const at = step.goals.filter((g) => ['accept', 'turnin', 'talk', 'train'].includes(g.t) && below[g.npc]);
			if (at.length === 0) continue;
			seen++;
			const text = [].concat(step.note || [], at.map((g) => g.note || '')).join(' ');
			if (!down.test(text)) missing.push(`${guide}: step "${step.title}" at ${below[at[0].npc]}`);
			if (/\bon Spirit Rise\b/.test(text)) missing.push(`${guide}: step "${step.title}" puts ${below[at[0].npc]} on Spirit Rise`);
		}
	}
	assert.ok(seen >= 3, `the steps at them are found (${seen})`);
	assert.deepEqual(missing, []);
});

// Fitz's report (#1149): The Barrens' "The Zhevra" step sent the arrow to `goto 52.5,27.5 "Zhevra"` by the
// Crossroads, then 432 yards on to the nearest Zhevra Runner: a goto from the hand-written v1 route with nothing to
// do at it. In a written guide a goto right before a kill or collect leads to that work: its nearest spot is within
// 200 yards, or the goto is a way in (a cave or subzone, with its area). The others (the Razormane camp's prowler
// claws, Feralas' forest walkers, Corin's Crossing pointing at Nathanos) went with it.
test("Fitz's report (#1149): a goto before a kill or collect in a written guide leads to that work", { skip }, () => {
	refData();
	const { point } = makeProjector(refData().mapFrames);
	const at2 = (map, x, y, f) => point(map, x, y, f === 'e' ? 'e' : 'l');
	const bad = [];
	for (const guide of allGuides()) {
		if (!fs.readFileSync(path.join(OFFICIAL_DIR, guide), 'utf8').startsWith('# Generated')) continue;
		for (const step of compiled(guide).steps) {
			const gs = step.goals;
			for (let i = 0; i + 1 < gs.length; i++) {
				const a = gs[i], b = gs[i + 1];
				if (a.t !== 'goto' || a.map == null || a.area || !['kill', 'collect'].includes(b.t)) continue;
				const spots = b.spots && b.spots.length ? b.spots.map((p) => ({ map: p.map || b.map, ...p })) : b.map != null ? [b] : [];
				const from = at2(a.map, a.x, a.y, a.f);
				let best = Infinity;
				for (const p of spots) {
					const to = at2(p.map || b.map, p.x, p.y, p.f || b.f);
					if (to.c === from.c) best = Math.min(best, dist(from, to));
				}
				if (best > 200 && best < Infinity) bad.push(`${guide}: step "${step.title}": goto ${a.x},${a.y} is ${Math.round(best)} yd from ${b.t} ${b.quest || ''} ${b.item || b.npc || ''}`);
			}
		}
	}
	assert.deepEqual(bad, []);
});

// A Paladin's report on Discord (2026-11-07): the level 12 Redemption chain came up again and again though it was
// done. Duthorian Rall's The Tome of Divinity (1641; Tiza Battleforge's 1645) is a repeatable quest he takes back
// straight from the quest window: players' recordings have its hand-in and no accept, and the client never flags it
// completed, so an `accept` goal for it reopened after every reload. Such quests are `turnin <id> direct` (the
// Tomes of Valor, the Saptas too).
test('Repeatable quests handed straight back at their giver are direct turn-ins with no accept (the Tome of Divinity)', { skip }, () => {
	for (const [guide, quests] of [
		['forever/class/paladin/tome-of-divinity.guide', [1641, 1645]],
		['forever/alliance/02-westfall.guide', [1641]],
		['forever/class/paladin/verigans-fist.guide', [1793, 1794]],
		['forever/class/shaman/call-of-earth-alliance.guide', [94472]],
		['forever/class/shaman/call-of-earth-horde.guide', [1462, 1463]],
		['forever/class/shaman/call-of-fire-alliance.guide', [94473]],
		['forever/class/shaman/call-of-fire-horde.guide', [1464]],
		['forever/class/shaman/call-of-water-horde.guide', [972]],
	]) {
		const list = goals(guide);
		for (const q of quests) {
			assert.ok(!list.some(is('accept', q)), `${guide}: no accept ${q}`);
			const turnin = list.find(({ goal }) => is('turnin', q)(goal));
			assert.ok(turnin && turnin.goal.direct === true, `${guide}: turnin ${q} direct`);
		}
	}
});

// Fenn's report (#1699, Orc Warrior 30): Whirlwind Weapon said "Accept Essence of the Exile" at Bath'rah's Cauldron,
// but the cauldron opens straight on its hand-in window (his screenshot: the three charms it wants, then Continue)
// and the quest never enters the log, so the accept, and the charm goals tracked as its objectives, never ticked and
// held the guide. The game's data marks such quests as handed in on the spot, and players' recordings have never
// shown one accepted (66 of them handed in, none taken). The sweep over the hand-written guides: each is a
// `turnin <id> direct`, with no accept and no goal tracking it in the log (`quest <id>.<n>`); the generated
// leveling guides' cases are listed on the issue.
test("Fenn's report (#1699): quests handed in on the spot are direct turn-ins, never accepts or tracked objectives", { skip }, () => {
	for (const [guide, quests] of [
		['forever/class/warrior/whirlwind-weapon.guide', [1714]],
		['forever/class/rogue/ravenholdt.guide', [6701]],
		['forever/class/warlock/enchanted-gold-bloodrobe.guide', [4785]],
		['forever/collectibles/pets/bitter-baitling.guide', [8193]],
		['forever/reputation/argent-dawn.guide', [5227]],
		['forever/reputation/brood-of-nozdormu.guide', [8579]],
		['forever/reputation/darkspear-trolls.guide', [7833, 7834, 7835, 7836]],
		['forever/reputation/orgrimmar.guide', [7826, 7827, 7831, 7824]],
		['forever/reputation/thunder-bluff.guide', [7820, 7821, 7822, 7823]],
		['forever/reputation/undercity.guide', [7813, 7814, 7817, 7818]],
		['forever/reputation/nightclaw-druids.guide', [93459]],
		['forever/reputation/ravenholdt.guide', [6701, 8249]],
		['forever/reputation/steamwheedle-cartel.guide', [5525, 7429]],
	]) {
		const list = goals(guide);
		for (const q of quests) {
			const mine = list.filter(({ goal }) => goal.quest === q);
			assert.ok(mine.length > 0, `${guide}: ${q} is in the guide`);
			for (const { goal } of mine) assert.ok(goal.t === 'turnin' && goal.direct === true, `${guide}: ${goal.t} ${q} is a direct turn-in, nothing that waits on the log`);
		}
	}
	const list = goals('forever/class/warrior/whirlwind-weapon.guide');
	const essence = list.find(({ goal }) => is('turnin', 1714)(goal));
	assert.equal(essence.goal.object, 89931, "Essence of the Exile is handed in at Bath'rah's Cauldron");
	for (const charm of [4479, 4480, 4481]) {
		const at = list.findIndex(({ goal }) => goal.t === 'collect' && goal.item === charm && goal.count === 8);
		assert.ok(at >= 0 && at < list.indexOf(essence), `charm ${charm}: 8 collected before the cauldron`);
	}
});
test('generated leveling guides: quests handed in on the spot are direct turn-ins, with no accept, bound objective or quest condition (#1699 sweep)', { skip }, () => {
	const generated = allGuides().filter((g) => fs.readFileSync(path.join(OFFICIAL_DIR, g), 'utf8').startsWith('# Generated by forge'));
	assert.ok(generated.length > 40, 'the generated guides are found');
	const lists = generated.map((g) => [g, goals(g)]);
	const spot = new Set(HANDED_IN_ON_THE_SPOT);
	for (const [q, rec] of Object.entries(refData().quests)) if (rec && rec.direct === true) spot.add(Number(q));
	const bad = [];
	for (const [g, list] of lists) {
		for (const { step, goal } of list) {
			if (spot.has(goal.quest) && !(goal.t === 'turnin' && goal.direct === true)) bad.push(`${g} ${step.title}: ${goal.t} ${goal.quest}`);
			for (const w of [].concat(step.when || [])) {
				if ((w.k === 'onquest' || w.k === 'complete') && [].concat(w.q).some((q) => spot.has(q))) bad.push(`${g} ${step.title}: when ${w.k} ${w.q}`);
			}
		}
	}
	assert.deepEqual(bad, []);
	const stv = goals('forever/horde/40-50/01-stranglethorn-vale.guide');
	assert.ok(stv.some(({ goal }) => goal.t === 'collect' && goal.item === 2799 && goal.count === 10), "Unbagwa's ten Gorilla Fangs");
	const wpl = goals('forever/alliance/50-60/04-western-plaguelands.guide');
	assert.ok(wpl.some(({ goal }) => goal.t === 'collect' && goal.item === 12840 && goal.count === 20), 'twenty Minion\'s Scourgestones');
});

// #1117 (soockee, Tauren Shaman; #383 and #396 before it, Dwarf Paladins): Alonso's Dragonslayer quests
// at Mystral Lake are for Warriors; other classes find no Alonso there. The lock lived only in
// data/rules.json, which Forge does not read, so the generated Horde Ashenvale guide sent every class to
// him. The record is the class in forever-db/corrections/quests.json. Since the QuestieDB 1.0.14 check
// (0.3.8) no class is sent to him: each quest needs an item the route never gets (the test above).
test("soockee's report (#1117): only Warriors are sent to Alonso for the Dragonslayer quests", { skip }, () => {
	const corrections = JSON.parse(fs.readFileSync(path.join(ROOT, 'forever-db', 'corrections', 'quests.json'), 'utf8'));
	const ALONSO = [78132, 78133, 78134];
	for (const q of ALONSO) assert.equal(corrections[q] && corrections[q].set.classes, 1, `${q}: the Warrior class is a correction the build applies`);
	for (const guide of allGuides().filter((f) => /^forever\/(horde|alliance)\//.test(f))) {
		const list = goals(guide).filter(({ goal }) => ALONSO.includes(goal.quest));
		for (const cls of ['PALADIN', 'SHAMAN', 'DRUID', 'HUNTER', 'ROGUE', 'PRIEST', 'MAGE', 'WARLOCK']) {
			assert.deepEqual(list.filter(forClass(cls)).map(({ goal }) => `${goal.t} ${goal.quest}`), [], `${guide}: no Alonso quest for a ${cls}`);
		}
	}
});

// --- Timed-quest check (2026-11-08, #1319's pattern): A Meal Served Cold (212) must be back with Angus Stern in Stormwind
// within 30 minutes. The route took it in Stormwind in 30-40/05 and handed it in two guides later: it always ran out. Left out.
test('A Meal Served Cold (30-minute limit) is in no leveling guide', { skip }, () => {
	for (const guide of allGuides().filter((g) => /^forever\/(alliance|horde)\//.test(g))) {
		assert.equal(goals(guide).filter(({ goal }) => goal.quest === 212).length, 0, `${guide}: no 212`);
	}
});

// The whole pattern: a child quest (the data's `parent`) is offered only while its parent is in the log, so no leveling
// guide accepts one unless that guide, or a guide that leads into it, accepts the parent first.
test('Leveling guides: a child quest is accepted only after its parent (offer sweep, #1579)', { skip }, () => {
	refData();
	const guides = allGuides().filter((g) => /^forever\/(alliance|horde)\//.test(g));
	const read = (g) => fs.readFileSync(path.join(OFFICIAL_DIR, g), 'utf8');
	const accepts = new Map(guides.map((g) => [g, [...read(g).matchAll(/^\s*accept (\d+)/gm)].map((m) => Number(m[1]))]));
	const before = new Map(guides.map((g) => [g, new Set()]));
	for (const g of guides) {
		const next = (read(g).match(/^next (\S+)/m) || [])[1];
		if (next && before.has(`${next}.guide`)) before.get(`${next}.guide`).add(g);
	}
	const ancestors = (g, seen = new Set()) => {
		for (const p of before.get(g)) if (!seen.has(p)) { seen.add(p); ancestors(p, seen); }
		return seen;
	};
	const offenders = [];
	for (const g of guides) {
		const earlier = new Set([...ancestors(g)].flatMap((p) => accepts.get(p)));
		accepts.get(g).forEach((q, i) => {
			const parent = Number((refData().quests[q] || {}).parent) || 0;
			if (parent > 0 && !earlier.has(parent) && !accepts.get(g).slice(0, i).includes(parent)) offenders.push(`${g}: accept ${q} without its parent ${parent}`);
		});
	}
	assert.deepEqual(offenders, [], 'child quests accepted without their parent');
});

test("Edet's report (#2300): the route records keep the elite-camp quest a group quest, and available", () => {
	const fixes = JSON.parse(fs.readFileSync(path.join(ROOT, 'data', 'route-fixes.json'), 'utf8'));
	assert.ok(fixes.deliberate.group.some((r) => r.q === 3377 && r.size === 4), 'a build writes the group question for it');
	assert.ok(!fixes.overrides.skip.some((r) => r.q === 3377), 'the quest remains available for players who choose to do it');
});
test('Guide end: no leveling guide\'s last step for everyone waits on a vendor visit', { skip }, () => {
	const offenders = [];
	for (const guide of allGuides().filter((g) => /^forever\/(alliance|horde)\//.test(g))) {
		const c = compiled(guide);
		if (c.category && c.category !== 'Leveling') continue;
		const last = [...c.steps].reverse().find((st) => forAllOnly(st.only) && !st.along && st.goals.some((g) => g.t !== 'note' && !g.optional));
		if (last && last.goals.some((g) => g.t === 'vendor' && !g.optional && forAllOnly(g.only))) offenders.push(`${guide}: ${last.title}`);
	}
	assert.deepEqual(offenders, [], 'last steps with a vendor goal');
});
for (const { side, quest, after, says, todo } of FOLLOW_UPS) test(`Every ${side} route: ${says}`, { skip, todo }, () => {
	for (const { who, list } of routes(side)) {
		list.forEach((e, i) => {
			if (!is('accept', quest)(e.goal)) return;
			for (const pre of after) assert.ok(list.slice(0, i).some(({ goal }) => is('turnin', pre)(goal)), `${who}: ${where(e)} accepts ${quest} before ${pre} is handed in`);
		});
	}
});

// Zerkness (#383), Ioney (#396), soockee (#1117): Alonso's Dragonslayer quests are for Warriors only; a
// Paladin and a Shaman were sent to Mystral Lake for nothing.
test('Every route (#1117): only Warriors are sent to Alonso for the Dragonslayer quests', { skip }, () => {
	const ALONSO = 210995;
	for (const side of ['Horde', 'Alliance']) {
		for (const { who, cls, list } of routes(side)) {
			if (cls === 'WARRIOR') continue;
			const sent = list.find(({ goal }) => [78132, 78133, 78134].includes(goal.quest) || goal.npc === ALONSO);
			assert.ok(!sent, `${who}: ${sent && where(sent)} sends a ${cls} to Alonso`);
		}
	}
});

// Wetlands report (2026-11-07, Discord; #1184, #1206): on 0.3.4 "pretty much all the quests" the guide asked
// for at Menethil and the dig were chain quests nobody could take yet. Every leveling path (each start,
// each `next` option) is played as every race and class, and no accept may come before its blocking
// prerequisites are handed in on that path (tools/lib/route/prereq-order.js; lint's check counts a hand-in
// on any branch into the guide). Since #1299 it also takes the prerequisites players' recordings teach
// (data/recorded/quests.json): the data named none for This Land Was Their Land, so 0.3.5 passed this test
// while its accept came before Defeat Nek'rosh.
test('every leveling path hands in each accept\'s prerequisites before the accept, for every start, race and class', { skip }, () => {
	const { prereqOrder, recordedPrereqs } = require('../../tools/lib/route/prereq-order');
	const { guides, data: all } = compileProject({ packDir: OFFICIAL_DIR, manifest: { id: 'guides', author: 'Polestar' }, dataDir: DATA });
	const learned = JSON.parse(fs.readFileSync(path.join(ROOT, 'data', 'recorded', 'quests.json'), 'utf8'));
	const recorded = recordedPrereqs(learned, loadCorrections().quests);
	const found = prereqOrder(guides, all, { recorded }).map(
		(v) => `${path.relative(OFFICIAL_DIR, v.file).split(path.sep).join('/')}:${v.line} accept ${v.quest} (${v.title}) needs ${v.missing.join(v.any ? ' or ' : ' and ')} handed in first (${v.race} ${v.cls || ''}, path from ${v.path[0]}${v.groups === 'do' ? ', group quests on' : ''}${v.recorded ? '; players\' recordings show it offered only after one of these' : ''})`
	);
	assert.deepEqual(found, []);
});

// Gray's report (#1234): Kodo Roundup counts a tamed kodo only once you talk to it at Smeed's camp, and
// the Kombobulator tames no other until then (players' recordings: each of the five ticks came with the
// kodo's window). The tips said "five times" and nothing about talking to it. The tip is a guide-fixes
// record for each side, so a build writes it again.
test("Gray's report (#1234): Kodo Roundup's tip says to talk to each tamed kodo at Smeed's, one at a time", { skip }, () => {
	const fixes = JSON.parse(fs.readFileSync(path.join(ROOT, 'data', 'guide-fixes.json'), 'utf8')).fixes;
	for (const [guide, faction, re] of [
		['forever/horde/30-40/02-thousand-needles.guide', 'Horde', /quest 5561\.1\b/],
		['forever/alliance/30-40/02-desolace.guide', 'Alliance', /quest 5561\.1\b/],
	]) {
		const rec = fixes.find((f) => f.at.quest === 5561 && f.faction === faction && f.tip);
		assert.ok(rec, `${faction}: the tip is a record`);
		assert.deepEqual(stepTips(guide, re), [rec.tip], `${faction}: the step's tip is the record's`);
		assert.match(rec.tip, /talk to the kodo/);
		assert.match(rec.tip, /one at a time/);
	}
});

// Final route review for 0.3.5 (Arathi 36-39, both sides): Sunken Treasure's escort step said the
// professor goes down to the shore and naga ambush him; he walks up to the cave above Faldir's Cove and
// summons two water elementals there (the server's script), as the writer's own 'Careful' tip said.
// One guide-fixes tip for both sides.
test('Sunken Treasure: the escort tip sends you up to the cave, where two water elementals come', { skip }, () => {
	const rec = JSON.parse(fs.readFileSync(path.join(ROOT, 'data', 'guide-fixes.json'), 'utf8')).fixes.find((f) => f.at.quest === 665 && f.tip);
	assert.ok(rec, 'the tip is a record');
	assert.match(rec.tip, /cave/);
	assert.match(rec.tip, /water elementals/);
	assert.doesNotMatch(rec.tip, /naga|shore|beach/);
	for (const guide of ['forever/horde/30-40/05-arathi-highlands.guide', 'forever/alliance/30-40/05-arathi-highlands.guide']) {
		assert.deepEqual(stepTips(guide, /^\s+complete 665\b/), [rec.tip], `${guide}: the step's tip is the record's`);
	}
});

// Final route review for 0.3.5 (Fitz: grind if we must, but say so): every written grind step in 30-40
// names where to grind and a dungeon to run instead, in the writer's sentence.
test('30-40: every written grind step says where, and names a dungeon to run instead where the route runs one', { skip }, () => {
	const dir = path.join(OFFICIAL_DIR, 'forever');
	for (const side of ['horde', 'alliance']) {
		for (const f of fs.readdirSync(path.join(dir, side, '30-40'))) {
			const guide = `forever/${side}/30-40/${f}`;
			for (const { step, goal } of goals(guide)) {
				if (goal.t !== 'level') continue;
				// Since the 0.4.0 dungeons rule a grind step names a dungeon only where the route runs one in the same or the
				// next guide on the same continent: Horde Stranglethorn Vale and Dustwallow have none (the Horde 30-40 case
				// pins which guide names which).
				if (!/forever\/horde\/30-40\/0[34]-/.test(guide)) assert.match([step.note, step.tip].flat().filter(Boolean).join(' '), /Or, with a group, run the .+ dungeon( \(.+\))? instead\.$/, `${guide}: "${step.title}"`);
				assert.match([step.note, step.tip].flat().filter(Boolean).join(' '), /until level/, `${guide}: "${step.title}" says where`);
			}
		}
	}
});

test('Image of Archmage Modera is met at the Kirin Tor camp in Silverpine Forest, never by the Dalaran sewer entrance in Alterac (#1305)', { skip }, () => {
	// Players' windows with her are all at Silverpine 68.57-68.66,45.09-45.25; the merged data also had a point in
	// Alterac Mountains 14.3,59.57 (about 186 yd east), which the Arathi hand-in of An Alarming Request (92432) used.
	for (const [file, pred] of [
		['forever/alliance/30-40/05-arathi-highlands.guide', is('turnin', 92432)],
		['forever/reputation/kirin-tor.guide', is('turnin', 92432)],
		['forever/reputation/kirin-tor.guide', is('accept', 92458)],
	]) {
		const list = goals(file);
		const { goal } = list[at(list, `${file}: ${pred.toString()}`, pred)];
		assert.equal(goal.npc, 269127, `${file}: Image of Archmage Modera`);
		assert.equal(goal.map, 1421, `${file} ${goal.t} ${goal.quest}: Silverpine Forest, not Alterac Mountains`);
		assert.ok(Math.abs(goal.x - 68.6) < 0.5 && Math.abs(goal.y - 45.2) < 0.5, `${file} ${goal.t} ${goal.quest}: at the camp (${goal.x},${goal.y})`);
	}
});

// --- Level sweep (2026-11-08, #1320's class of report: a guide asks for a quest the character is too low to take).
// The calibrated level model, run at every accept of every start, had these taken 0.05-0.6 below the quest's
// minimum level; players' recordings had 8 Scourge Paladins at Aramis Hammerhand's Coming to Terms at levels 2-3
// (minimum 4). Each is now taken where every start is at its level, or behind a `level` gate for the players it is
// for (guide-fixes `only`); Tanaris (Horde 40-50) and the Barrens (Horde 15-21) start where every start enters them.
test('Level sweep: accepts below their minimum level are moved or gated', { skip }, () => {
	const step = (list, t, q) => list[at(list, `${t} ${q}`, is(t, q))].s;
	// A level goal of at least `n` for `cls` (none other) before the accept, in its step.
	const gated = (file, q, n, cls) => {
		const list = goals(file);
		const i = at(list, `${file}: accept ${q}`, is('accept', q));
		const gate = list.slice(0, i).reverse().find(({ goal, s }) => s === list[i].s && goal.t === 'level');
		assert.ok(gate && gate.goal.level >= n, `${file}: a level ${n} gate before accept ${q}`);
		if (cls) assert.match(JSON.stringify(gate.goal.only), new RegExp(cls, 'i'), `${file}: the gate before ${q} is for ${cls}`);
		else assert.equal(gate.goal.only, undefined, `${file}: the gate before ${q} is for everyone`);
	};
	const stv = goals('forever/alliance/40-50/01-stranglethorn-vale.guide');
	// Level tidy (0.4.0): Stranglethorn Fever (minimum 40) is taken on the level-48 Booty Bay stop of 40-50/05, where Mokk is fought.
	const hin = goals('forever/alliance/40-50/05-the-hinterlands.guide');
	assert.ok(!stv.some(({ goal }) => is('accept', 348)(goal)), 'Stranglethorn Fever is not taken at 41');
	assert.equal(step(hin, 'accept', 348), step(hin, 'turnin', 2874), 'Stranglethorn Fever on the level-48 Booty Bay stop');
	assert.equal(step(stv, 'accept', 2872), step(stv, 'turnin', 606), "Stoley's Debt on the Booty Bay stop after the gorilla hills");
	const ungoro = goals('forever/alliance/40-50/07-un-goro-crater.guide');
	const gate = ungoro.findIndex(({ goal }) => goal.t === 'level' && goal.level >= 50 && /priest/i.test(JSON.stringify(goal.only)));
	assert.ok(gate >= 0 && gate < at(ungoro, 'accept 8254', is('accept', 8254)), "Priests reach 50 in Un'Goro before Cenarion Aid");
	// #1485's class-chain sweep: Magecraft (8250, Dink, Mages only, minimum 50) is on the same Ironforge stop, reached
	// at 49.79 by Human, Gnome and Skyborne Mages; the level-up in Azshara would have sent them back to Ironforge.
	const mages = ungoro.findIndex(({ goal }) => goal.t === 'level' && goal.level >= 50 && /mage/i.test(JSON.stringify(goal.only)));
	assert.ok(mages >= 0 && mages < at(ungoro, 'accept 8250', is('accept', 8250)), "Mages reach 50 in Un'Goro before Magecraft");
	// Fix round 2 (0.4.0): Dwarf and Gnome Priests no longer wait in Kharanos for level 10 for Maxan Anvol's letters
	// (5637, 94824): they take their trainers' own copies (5639 Rohan, 94817 Mims) and hand them straight back on the
	// Ironforge Mystic Ward stop, reached past level 13, so no accept is offered below its minimum level.
	for (const [file, own, letter] of [
		['forever/alliance/dwarf/01-dun-morogh.guide', 5639, 5637],
		['forever/alliance/gnome/01-dun-morogh.guide', 94817, 94824],
	]) {
		const list = goals(file);
		assert.ok(!list.some(({ goal }) => is('accept', letter)(goal)), `${file}: Maxan Anvol's letter ${letter} is not taken`);
		assert.ok(!list.some(({ goal }) => goal.t === 'level' && /priest/i.test(JSON.stringify(goal.only))), `${file}: no Priest level wait`);
		const take = at(list, `${file}: accept ${own}`, is('accept', own));
		assert.equal(list[take].s, step(list, 'turnin', own), `${file}: ${own} taken and handed in on one step`);
		assert.equal(list[take].goal.map, 1455, `${file}: ${own} in Ironforge`);
	}
	for (const side of ['alliance', 'horde']) {
		gated(`forever/${side}/skyborne/01-zephras-isle.guide`, 94003, 10, 'Warrior');
		gated(`forever/${side}/skyborne/01-zephras-isle.guide`, 94978, 10, 'Hunter');
	}
	gated('forever/horde/skyborne/01-zephras-isle.guide', 97243, 10, 'Shaman');
	gated('forever/horde/tauren/01-mulgore.guide', 264, 12);
	const tirisfal = goals('forever/horde/undead/01-tirisfal-glades.guide');
	assert.equal(step(tirisfal, 'accept', 91208), step(tirisfal, 'turnin', 3902), 'Coming to Terms after Scavenging Deathknell');
	assert.ok(step(tirisfal, 'accept', 91209) >= step(tirisfal, 'turnin', 91208), 'Continue Your Training once Coming to Terms is handed in');
	const all = headers();
	// Since 0.4.0 the Riverglades come before Feralas, and every start enters Tanaris at 48.91 (it was 45.96).
	assert.ok(all['forever/horde/40-50/04-tanaris'].min <= 48, 'Tanaris starts at 48: every start enters it at 48.91');
	assert.ok(all['forever/horde/02-the-barrens'].min <= 14, 'the Barrens start at 14: Orc and Troll Rogues, Mages and Priests enter them at 13.99');
});

// FlyHifiGuy's report (#1327): on Trial of the Lake (28/29, a 30-minute quest timer) a teleport reset the trial, and the
// trial's step opened with "Cast Teleport: Moonglade" for the whole step. The arrow plans no Hearthstone or class
// teleport while a quest timer runs (Nav/Travel.lua; forge-addontest travel-transit.rs). The guides: every trial step
// says no teleport or Hearthstone until Tajarri has it (the leveling guides' tips are guide-fixes records, so a build
// writes them again, and no longer say to cast the teleport: the step before does), and no guide puts a `hearth` goal
// between a timed quest's accept and its hand-in.
test("FlyHifiGuy's report (#1327): no teleport or Hearthstone while Trial of the Lake runs, no hearth goal inside a timed quest", { skip: skip || needs('mechanics.json') }, () => {
	const fixes = JSON.parse(fs.readFileSync(path.join(ROOT, 'data', 'guide-fixes.json'), 'utf8')).fixes;
	for (const [file, q, record] of [
		['forever/alliance/03-darkshore.guide', 29, 'upstairs-dendrite-starblaze-turnin-26'],
		['forever/horde/02-the-barrens.guide', 28, 'upstairs-dendrite-starblaze-turnin-27'],
		['forever/class/druid/aquatic-form.guide', 29, null],
		['forever/class/druid/aquatic-form.guide', 28, null],
	]) {
		const tips = stepTips(file, new RegExp(`^\\s+accept ${q}\\b`));
		assert.match(tips.join(' '), /no teleport or Hearthstone until Tajarri has it/, `${file}: quest ${q}'s step`);
		if (!record) continue;
		const rec = fixes.find((f) => f.id === record);
		assert.deepEqual(tips, [rec.tip], `${file}: the step's tip is the record's`);
		assert.doesNotMatch(rec.tip, /Cast Teleport/, `${file}: the step before casts it`);
	}
	const read = (f) => JSON.parse(fs.readFileSync(path.join(DATA, f), 'utf8'));
	const quests = read('quests.json');
	const timed = new Set((Array.isArray(quests) ? quests : Object.values(quests)).filter((q) => q.limit > 0).map((q) => q.id));
	for (const [id, m] of Object.entries(read('mechanics.json').quests || {})) {
		if ((m.params || []).some((p) => p.kind === 'timed' && p.what === 'quest timer' && p.seconds > 0)) timed.add(Number(id));
	}
	assert.ok(timed.has(28) && timed.has(29), 'Trial of the Lake is timed in the data');
	let windows = 0;
	for (const file of allGuides()) {
		const open = new Map(); // timed quest -> line of its accept
		fs.readFileSync(path.join(OFFICIAL_DIR, file), 'utf8').split('\n').forEach((line, i) => {
			const m = line.match(/^\s+(accept|turnin|complete|hearth)\b\s*(\d+)?/);
			if (!m) return;
			const q = Number(m[2]);
			if (m[1] === 'accept' && timed.has(q)) {
				open.set(q, i + 1);
				windows++;
			} else if ((m[1] === 'turnin' || m[1] === 'complete') && open.has(q)) {
				open.delete(q);
			} else if (m[1] === 'hearth') {
				assert.equal(open.size, 0, `${file}:${i + 1}: a hearth while timed quest ${[...open.keys()].join(', ')} runs (accepted at line ${[...open.values()].join(', ')})`);
			}
		});
	}
	assert.ok(windows >= 30, `the timed accepts are found (${windows})`);
});

// --- Windshear Mine (Emil, #1370): Gerenzo's Orders is Piznik's five-minute defence at the bottom of the mine,
// with kobold waves (19-23) and a fail when he dies. Players lost it alone at 23 and 25; both routes reach it at
// 20-23. It is asked as a group quest in both guides, with what the defence is, Ziz's hand-in of the follow-up
// with it; Super Reaper 6000 (1093) and the crag's quests stay for everyone, and the Alliance arrow into
// Stonetalon no longer leads into the mine.
test("Emil's report (#1370): Gerenzo's Orders is asked as a group quest; Windshear Crag's other quests are not", { skip }, () => {
	for (const guide of [ASHENVALE, BARRENS]) {
		const list = goals(guide);
		const gerenzo = list.filter(({ goal }) => goal.quest === 1090 || goal.quest === 1092);
		assert.deepEqual(gerenzo.map(({ goal }) => `${goal.t} ${goal.quest}`).sort(), ['accept 1090', 'accept 1092', 'complete 1090', 'turnin 1090', 'turnin 1092'], `${guide}: Gerenzo's Orders' goals`);
		for (const { step, goal } of gerenzo) {
			assert.ok((step.when || []).some((p) => p.k === 'group' && [p.q].flat().includes(1090) && !p.neg), `${guide}: ${goal.t} ${goal.quest} is under when group 1090`);
			if (goal.quest === 1090) assert.equal(step.title, 'Piznik', `${guide}: ${goal.t} 1090 on Piznik's step`);
		}
		assert.match(stepTips(guide, /^step Piznik$/).join(' '), /grouping up is encouraged[\s\S]*If he dies, the quest fails/, `${guide}: the step says what the defence is`);
		const reaper = list.filter(({ goal }) => goal.quest === 1093);
		assert.ok(reaper.length >= 2, `${guide}: Super Reaper 6000 is still taken`);
		for (const { step, goal } of reaper) assert.ok(!(step.when || []).some((p) => p.k === 'group'), `${guide}: ${goal.t} 1093 is for everyone`);
	}
	const ally = goals(ASHENVALE);
	const into = ally[at(ally, 'goto Windshear Crag', ({ t, text }) => t === 'goto' && /Windshear Crag/.test(text || ''))].goal;
	assert.ok(Math.hypot(into.x - 71.9, into.y - 60.0) > 10, `the Stonetalon arrow (${into.x},${into.y}) is not Piznik's spot in the mine`);
});

// #1357 (MrBackus, Skyborne Shaman 30): Hillsbrad & Arathi's Orgrimmar training step came up while he
// stood in the Barrens by Ratchet, and the Engine took the Shaman trainer nearest him, Shikrik in the
// Valley of Trials. The Undercity training step of the Arathi guide comes up at Orgrimmar's zeppelin tower
// the same way. A `train class` goal carries its step's zone, whose trainers the Engine ranks first
// wherever the player stands: each of these steps names its town, and the town has a trainer of every
// class the step trains.
test('#1357: a training step carries its town, and the town has a trainer of each class it trains', { skip }, () => {
	const cases = [
		['forever/horde/30-40/01-hillsbrad-foothills.guide', /^Train$/, 1454],
		['forever/horde/30-40/05-arathi-highlands.guide', /^(Undercity|\{zone:1458\}) trainers$/, 1458],
		['forever/alliance/02-westfall.guide', /^Shaman training$/, 1455],
		['forever/alliance/50-60/01-burning-steppes.guide', /^Darnassus$/, 1457],
	];
	for (const [guide, title, town] of cases) {
		const list = goals(guide).filter(({ step, goal }) => title.test(step.title) && goal.t === 'train' && goal.class);
		assert.ok(list.length > 0, `${guide}: the "${title}" step trains`);
		for (const { step, goal } of list) {
			assert.equal(goal.zone, town, `${guide}, "${title}": the step's town`);
			const classes = (goal.only && goal.only.classes) || (step.only && step.only.classes) || [];
			for (const cls of classes) {
				const side = guide.includes('/horde/') ? 'H' : 'A';
				const there = goal.candidates.filter((c) => c.map === town && (c.faction === side || c.faction === 'AH') && (c.classes || []).includes(cls.toUpperCase()));
				assert.ok(there.length > 0, `${guide}, "${title}": a ${cls} trainer in the town`);
			}
		}
	}
});

// Fyurie's report (#1458): Kodo Roundup (5561) was written `kill 4700 quest 5561.1`, so the guide window said "Kill
// Aged Kodo"; the kodos are tamed with Smeed's Kodo Kombobulator (13892) and counted when the tamed kodo is talked to
// at Smeed's camp (players' recordings: every tick at 60-61,62 with the kodo's window). The same class, swept over
// every guide (~/work/maintainer/kill-for-use-sweep): a kill goal whose objective is a use, tame, cure, scare or capture
// names the action.
test("Fyurie's report (#1458): Kodo Roundup uses the Kombobulator and counts at Smeed's camp, never 'Kill Aged Kodo'", { skip }, () => {
	for (const guide of ['forever/alliance/30-40/02-desolace.guide', 'forever/horde/30-40/02-thousand-needles.guide']) {
		const list = goals(guide);
		assert.ok(!list.some(({ goal }) => goal.t === 'kill' && goal.quest === 5561), `${guide}: no kill goal for 5561`);
		const use = at(list, 'use 13892', (g) => g.t === 'use' && g.item === 13892);
		const talk = at(list, 'talk 4700 quest 5561.1', (g) => g.t === 'talk' && g.quest === 5561);
		assert.ok(use < talk, `${guide}: the Kombobulator, then the tamed kodo at the camp`);
		const g = list[talk].goal;
		assert.ok(g.map === 1443 && Math.abs(g.x - 60.6) < 1 && Math.abs(g.y - 61.6) < 1, `${guide}: at Smeed's camp (${g.x},${g.y})`);
	}
	const src = (f) => fs.readFileSync(path.join(OFFICIAL_DIR, f), 'utf8');
	for (const [f, re] of [
		['forever/horde/02-the-barrens.guide', /kill 12296 quest 6129\.1 "Cure Sickly Gazelle"/],
		['forever/alliance/03-darkshore-return.guide', /kill 12298 quest 6124\.1 "Cure Sickly Deer"/],
		['forever/reputation/orgrimmar.guide', /kill 10556 x5 quest 5441\.1 "Wake Lazy Peon"/],
		['forever/alliance/dwarf/01-dun-morogh.guide', /quest 6661\.1 @78\.0,51\.4 "Catch Deeprun Rat"/],
	]) assert.match(src(f), re, `${f} names the action`);
});

// Quest volume, Felwood (both sides, 0.3.6 plan): the Deadwood Ritual Totem (8470, 5.65k XP) drops from the Felpaw
// Village furbolgs (Den Watchers, Avengers, Shamans, about one kill in thirty) that Deadwood of the North (8461) and
// the level top-up there already kill by the dozen. The Felpaw step goes on until it drops and takes the quest;
// Kernda takes it on the next pass of Timbermaw Hold, or by the cave right away if the Timbermaw are Neutral then.
test('Felwood, both sides: the Deadwood Ritual Totem is worked in the Felpaw Village step and handed in to Kernda on the later pass', { skip }, () => {
	for (const [felwood, later] of [
		['forever/alliance/50-60/02-felwood.guide', 'forever/alliance/50-60/06-silithus.guide'],
		['forever/horde/50-60/02-felwood.guide', 'forever/horde/50-60/07-felwood.guide'],
	]) {
		const list = goals(felwood);
		const totem = list[at(list, `${felwood}: collect 20741`, (g) => g.t === 'collect' && g.item === 20741)];
		assert.ok(!totem.goal.optional, `${felwood}: the totem holds the step until it drops`);
		const kills = list.filter(({ s, goal }) => s === totem.s && goal.t === 'kill' && goal.quest === 8461).map(({ goal }) => goal.npc);
		assert.deepEqual(kills.sort(), [7156, 7157, 7158], `${felwood}: in the Felpaw step with Deadwood of the North's kills`);
		const accept = list[at(list, `${felwood}: accept 8470`, is('accept', 8470))];
		assert.ok(accept.s === totem.s && !accept.goal.optional, `${felwood}: the totem's quest is taken in the same step`);
		const turnin = goals(later).find(({ goal }) => is('turnin', 8470)(goal));
		assert.ok(turnin && !turnin.goal.optional, `${later}: Kernda takes the totem on the later pass`);
		assert.ok(turnin.step.when.some((p) => p.k === 'onquest' && !p.neg), `${later}: only while the totem's quest is still in the log`);
	}
});

// Final route review 0.3.6, Alliance 38-39 Desolace: the Book of the Ancients (6027) was a bare collect with a tip calling
// Lord Kragaru "a centaur chieftain" who "camps" on the coast. He is the naga lord the Gem of the Serpent (15766, the
// quest's source item) summons at the Serpent Statue on Ranazjar Isle. Horde level tidy (2026-11-15): the Horde
// guide left the quest out (Kragaru, 38, at about 34 on its only Desolace coast walk), with a route-fixes skip.
test('Desolace, both sides: the Book of the Ancients uses the Gem of the Serpent at the statue first', { skip }, () => {
	for (const guide of ['forever/alliance/30-40/06b-desolace.guide']) {
		const list = goals(guide);
		const use = at(list, `${guide}: use 15766`, (g) => g.t === 'use' && g.item === 15766 && g.quest === 6027);
		const book = at(list, `${guide}: collect 15803`, (g) => g.t === 'collect' && g.item === 15803);
		assert.ok(use <= book, `${guide}: the gem before the book`);
		const g = list[use].goal;
		assert.ok(g.map === 1443 && Math.abs(g.x - 28.2) < 1 && Math.abs(g.y - 6.7) < 1, `${guide}: at the Serpent Statue (${g.x},${g.y})`);
	}
	assert.equal(goals('forever/horde/30-40/02-thousand-needles.guide').filter(({ goal }) => goal.quest === 6027).length, 0, 'Horde: no Book of the Ancients');
	const fixes = JSON.parse(fs.readFileSync(path.join(ROOT, 'data', 'route-fixes.json'), 'utf8'));
	assert.ok(fixes.overrides.skip.some((s) => s.q === 6027 && s.faction === 'Horde'), 'Horde: a skip the build keeps');
	assert.doesNotMatch(fs.readFileSync(path.join(OFFICIAL_DIR, 'forever/alliance/30-40/06b-desolace.guide'), 'utf8'), /Kragaru, a centaur/, 'Kragaru is no centaur');
});

// Review (0.3.6): the `when group` steps at Nesingwary's camp were titled after the wrong hunter (Panther
// Mastery is Sir S. J. Erlgadin's, Raptor Mastery and Big Game Hunter are Hemet Nesingwary's). Class guard over every
// leveling guide: a step of only accepts and hand-ins, titled with an NPC's name, talks to that NPC.
test('Leveling guides: a step titled with an NPC\'s name takes or hands in at least one quest at that NPC', { skip }, () => {
	const bad = [];
	for (const f of allGuides().filter((g) => /^forever\/(alliance|horde)\//.test(g))) {
		const names = new Map();
		for (const step of compiled(f).steps) {
			const qs = step.goals.filter((g) => g.t === 'accept' || g.t === 'turnin');
			if (!qs.length || qs.length !== step.goals.length || !qs.every((g) => g.npc)) continue;
			if (!names.has(step.title)) names.set(step.title, Object.values(refData().npcs).some((n) => n.name === step.title));
			if (names.get(step.title) && !qs.some((g) => refData().npcs[g.npc] && refData().npcs[g.npc].name === step.title)) bad.push(`${f}: ${step.title}`);
		}
	}
	assert.deepEqual(bad, []);
});

// Quest-gated loot sweep (0.3.6, every guide stands on its own): four `use` lines for an item a quest
// from an earlier guide gives (the Beacon Torch, Umi's Mechanical Yeti, Yeh'kinya's Bramble) named no quest, so a
// player who loads the guide fresh without that quest was shown "Use <item>" to tick by hand. Each is bound to its
// objective now and goes with its quest.
test('use lines for an earlier guide\'s quest item are bound to the objective', { skip }, () => {
	for (const [guide, item, quest] of [
		['forever/alliance/50-60/04-western-plaguelands.guide', 12815, 5097],
		['forever/alliance/50-60/04-western-plaguelands.guide', 12928, 5163],
		['forever/horde/40-50/03-feralas.guide', 10699, 3520],
		['forever/horde/50-60/06-silithus.guide', 12815, 5098],
	]) {
		const uses = goals(guide).filter(({ goal }) => goal.t === 'use' && goal.item === item);
		assert.ok(uses.length > 0, `${guide}: use ${item}`);
		for (const { goal } of uses) assert.equal(goal.quest, quest, `${guide}: use ${item} goes with quest ${quest}`);
	}
});

// Position sweep (0.3.6, class B2): elites that walk a path from the step's point (Forever TDB waypoint paths):
// Gammerita walks the Hinterlands shore up to 319 yd away, Grel'borg the Ruins of Alterac up to 217 yd. Their
// group steps say so.
test('Walking elites: Gammerita\'s and Grel\'borg\'s steps say where they walk', { skip }, () => {
	const src = (f) => fs.readFileSync(path.join(OFFICIAL_DIR, f), 'utf8');
	for (const f of ['forever/alliance/50-60/01-burning-steppes.guide', 'forever/horde/40-50/05-the-hinterlands.guide']) assert.match(src(f), /tip Gammerita walks the [^\n]*shore below the Overlook Cliffs/, f);
	assert.match(src('forever/alliance/30-40/05-arathi-highlands.guide'), /tip Grel'borg walks from the arrow north-east/);
});

// Travel sweep (0.3.6, displaced binds): four binds the route never hearthed to replaced one it would have used next
// (addon planner over the Warrior/Mage/Druid walks, sweep-travel/displaced_binds.py): Alliance 50-60/04's Cenarion
// Hold (Ratchet's hearth at 05's start, 5.8 min), 50-60/06's Cenarion Hold (Ratchet's hearth to Talrendis Point,
// 3.8 min), 04-redridge's Lakeshire (Darkshire's hearth in 05-duskwood, 2.9 min) and Horde 03-silverpine's Sepulcher
// (Razor Hill's hearth to Orgrimmar for Orcs and Trolls, 2.3 min). They are gone.
test('leveling guides: no unused bind that displaces the one the route hearths to next', { skip }, () => {
	for (const [guide, place] of [
		['forever/alliance/50-60/04-western-plaguelands.guide', 'Cenarion Hold'],
		['forever/alliance/50-60/06-silithus.guide', 'Cenarion Hold'],
		['forever/alliance/04-redridge-mountains.guide', 'Lakeshire'],
		['forever/horde/03-silverpine-forest.guide', 'The Sepulcher'],
	]) {
		assert.ok(!goals(guide).some(({ goal }) => goal.t === 'sethome' && goal.location === place), `${guide}: no bind at ${place}`);
	}
	assert.ok(goals('forever/alliance/04-redridge-mountains.guide').some(({ goal }) => goal.t === 'sethome' && goal.location === 'Darkshire'), 'Darkshire is still bound');
});

// Review (0.3.6), class "a required action never named" (after the review's Videre Elixir and Book of
// the Ancients): steps whose objective needs an item the step never mentioned. Durnholde's locks need the jailors'
// keys (The Rescue 498), the Scytheclaw nests need Sunscale Feathers (905), the flying machine needs Gann's
// Explosive Stick (849), and the Scrying Bowl only appears once the Phial of Scrying is used (944).
test('Steps name the item their objective needs (jailor keys, feathers, explosive stick, phial)', { skip }, () => {
	const src = (f) => fs.readFileSync(path.join(OFFICIAL_DIR, f), 'utf8');
	assert.match(src('forever/horde/06-hillsbrad-foothills.guide'), /Jailor Eston carries the Dull Iron Key and Jailor Marlgen the Burnished Gold Key/);
	assert.match(src('forever/horde/02-the-barrens.guide'), /step Raptor nests\n  tip [^\n]*Sunscale Feather/);
	assert.match(src('forever/horde/04-the-barrens.guide'), /step The flying machine\n  tip [^\n]*Explosive Stick of Gann/);
	assert.match(src('forever/alliance/03-darkshore-return.guide'), /step The Master's Glaive\n  tip [^\n]*Phial of Scrying/);
});

// rockzors (#1614): "Kodo Roundup: the target button only names Aged Kodo; Dying and Ancient Kodos also give
// credit when tamed." The quest's objective credits all three (the data's credit list), and the Kodo
// Kombobulator it hands over works on each: the `use` goal names them (`fromNpcs`), so the button does.
test('Desolace: Kodo Roundup: the Kodo Kombobulator step names the Aged, Dying and Ancient Kodos it tames (#1614)', { skip }, () => {
	for (const file of ['forever/horde/30-40/02-thousand-needles.guide', 'forever/alliance/30-40/02-desolace.guide']) {
		const list = goals(file);
		const { goal } = list[at(list, 'use 13892', (g) => g.t === 'use' && g.item === 13892)];
		assert.deepEqual((goal.fromNpcs || []).map((n) => n.npc).sort((a, b) => a - b), [4700, 4701, 4702], `${file}: the Kombobulator's kodos`);
	}
});

// rockzors (#1616): "Centaur Bounty: the arrow moves through all the centaur camps but the target button names
// the same five everywhere (Magram Scout and four Kolkar)." Centaur Ears drop from every tribe in Desolace and the
// collect's spots run through all their camps: the goal now says which mobs spawn at each spot (`fromNpcsAt`), and
// the button names the spot the arrow takes. A camp of each tribe names its own centaurs first and no other tribe's.
test('Desolace: Centaur Bounty: each spot of the Centaur Ear collect names its own camp\'s centaurs (#1616)', { skip }, () => {
	const TRIBES = ['Kolkar', 'Magram', 'Gelkis', 'Maraudine'];
	for (const [file, quest] of [['forever/horde/30-40/04-dustwallow-marsh.guide', 1366], ['forever/alliance/30-40/02-desolace.guide', 1387]]) {
		const list = goals(file);
		const { goal } = list[at(list, `collect 6067 quest ${quest}`, (g) => g.t === 'collect' && g.item === 6067 && g.quest === quest)];
		assert.equal(typeof goal.fromNpcsAt, 'string', `${quest}: the goal lists each spot's mobs`);
		const groups = goal.fromNpcsAt.split(';').map((s) => (s ? s.split(',').map((k) => goal.fromNpcs[Number(k) - 1].npcName) : []));
		assert.equal(groups.length, goal.spots.length, `${quest}: a list per spot`);
		for (const t of TRIBES) {
			const others = TRIBES.filter((o) => o !== t);
			const own = groups.some((names) => names.length && names[0].startsWith(t) && !names.some((n) => others.some((o) => n.startsWith(o))));
			assert.ok(own, `${quest}: a spot at a ${t} camp names its ${t} centaurs and no other tribe's`);
		}
		// rockzors' follow-up: at Magram Village it is the Magram Windchaser (4641), not the Kolkar one; the Magram
		// Wrangler (4640) stands there too.
		const ids = goal.fromNpcsAt.split(';').map((s) => (s ? s.split(',').map((k) => goal.fromNpcs[Number(k) - 1].npc) : []));
		const magram = ids.some((l) => l.includes(4641) && l.includes(4640) && !l.some((id) => id >= 4632 && id <= 4637));
		assert.ok(magram, `${quest}: a Magram Village spot names the Magram Windchaser and Wrangler, no Kolkar`);
	}
});

test("creazy231's report (#1660): a player who did the 22-25 Hillsbrad guide sees none of the catch-up", { skip }, () => {
	// The 22-25 guide hands in 527, 528 and 498; 529 is this guide's.
	const out = hillsbradChains('w.complete({ 527, 528, 498 })');
	assert.deepEqual(Object.values(out.hidden), []);
	// Not in the guide, or in a step that does not apply to them ("na").
	for (const q of ['527', '528', '498']) assert.ok([undefined, 'na', 'na,na'].includes(out.accepts[q]), `no ${q} step for them: ${out.accepts[q]}`);
	for (const q of ['529', '532']) assert.ok(!/skipped|na/.test(out.accepts[q]), `${q} is open: ${out.accepts[q]}`);
});

for (const sv of SECOND_VISITS) {
	const name = sv.guide.replace(/^forever\/|\.guide$/g, '');
	test(`second visits (#2635): ${name} brings back ${sv.starters.join(', ')} for a character who started the route after the first visit`, { skip }, () => {
		const list = goals(sv.guide);
		// Every catch-up accept waits on the character lacking the chain.
		const takes = list.filter(({ goal }) => goal.t === 'accept' && sv.starters.includes(goal.quest));
		assert.ok(takes.length >= sv.starters.length, 'the starters are taken in the guide');
		for (const { step, goal } of takes) assert.ok((step.when || []).some((p) => p.k === 'turnedin' && p.neg), `accept ${goal.quest}: only without the chain handed in`);
		const out = acceptStatuses(sv, '');
		// The follow-ups are not left out (a step that waits on the starter with `when` shows once it is handed in).
		for (const q of sv.opens) {
			assert.ok(!(Object.values(out.hidden) || []).includes(q), `${q} is not left out`);
			assert.ok(out.accepts[q] && !/skipped/.test(out.accepts[q]), `${q} is not skipped: ${out.accepts[q]}`);
		}
		for (const q of sv.starters) assert.ok(out.accepts[q] && /active|pending/.test(out.accepts[q]), `${q} is taken here: ${out.accepts[q]}`);
	});
	test(`second visits (#2635): ${name} shows none of the catch-up to a character who did the first visit`, { skip }, () => {
		const out = acceptStatuses(sv, sv.done);
		for (const q of sv.starters) assert.ok([undefined, 'na', 'na,na'].includes(out.accepts[q]), `no ${q} step for them: ${out.accepts[q]}`);
		for (const q of sv.opens) assert.ok(out.accepts[q] && !/skipped|na/.test(out.accepts[q]), `${q} is open: ${out.accepts[q]}`);
	});
}

// #1556's follow-up (#1797's triage): an item whose only sources are one or two creatures (no object, no vendor) names
// them whatever their drop chance. Kron's Amulet (4891, 10% from the two Dreadmaw Crocolisks), Rackmore's Silver Key
// (15878, 15% from the Drysnap Crawlers and Pincers) and the Pristine Yeti Horn (12367, 10% from the Ice Thistle
// Matriarch and Patriarch) read "Collect" with no source under the 20% bar.
test("#1556's follow-up: an item only one or two creatures drop names them at any chance", { skip }, () => {
	for (const [guide, item, ids] of [
		['forever/horde/orc/01-durotar.guide', 4891, [3110, 3231]],
		['forever/horde/30-40/02-thousand-needles.guide', 15878, [11562, 11563]],
		['forever/alliance/50-60/03-winterspring.guide', 12367, [7459, 7460]],
	]) {
		const list = goals(guide);
		const { goal } = list[at(list, `${guide}: collect ${item}`, (g) => g.t === 'collect' && g.item === item)];
		assert.equal(goal.fromKind, 'npc', `${guide}: ${item} names its droppers`);
		assert.deepEqual([goal.fromId, goal.fromAlsoId].filter((x) => x != null).sort((a, b) => a - b), ids.filter((id) => refData().spawns('npc', id).length), `${guide}: ${item} names every located dropper`);
	}
});

test('#1867: every start guide\'s Camping 101 step waits only while its camp item is unknown', { skip }, () => {
	const starts = allGuides().filter((f) => /\/01-[a-z-]+\.guide$/.test(f) && /forever\/(alliance|horde)\/[a-z]+\//.test(f));
	let n = 0;
	for (const file of starts) {
		for (const { step, goal } of goals(file)) {
			if (goal.t !== 'accept' || !/^Camping 101: (?!Cooking)/.test(goal.title || '')) continue;
			n += 1;
			const when = step.when || [];
			assert.ok(when.some((p) => p.k === 'skill' && !p.neg), `${file}: accept ${goal.quest} keeps its skill condition`);
			assert.ok(when.some((p) => p.k === 'knows' && p.neg), `${file}: accept ${goal.quest} waits only while the camp item is unknown`);
		}
	}
	assert.ok(n >= 70, `${n} Camping 101 accepts found`);
});

// The same report in the hand-written guides (reputation, class, legacy): quests a player holds finished at their
// hand-in (a delivery of an item the quest hands over or starts from, a "speak with" errand, or one whose objectives
// the guide asks with goals that hold) were handed in only by an `optional` goal, so a player who had one walked past
// its ender carrying it. The route writer keeps such a hand-in a goal that holds in the leveling guides (an
// item-started quest's beside other work at its NPC); these hold now too, hidden for anyone without the quest. A hand-in
// whose quest may still be unfinished there (raid drops, a reputation to reach, objectives the guide asks optionally)
// or a repeatable done in a loop stays optional. The pattern, over every hand-written guide: no hand-in of a delivery
// started from an item (its only objective that item, not repeatable) is optional.
test("jaff's report, hand-written guides: a quest held finished is handed in by a goal that holds", { skip }, () => {
	const R = (g) => `forever/reputation/${g}.guide`;
	const holds = [
		['forever/class/druid/bear-form.guide', [5925, 5928]],
		['forever/class/hunter/taming-the-beast-alliance.guide', [94007]],
		['forever/class/hunter/taming-the-beast-horde.guide', [94007]],
		['forever/class/mage/celestial-orb.guide', [2861]],
		['forever/class/mage/staff-or-orb-alliance.guide', [93791]],
		['forever/legacy/legacy-challenges.guide', [8997, 8998]],
		[R('brood-of-nozdormu'), [8575, 8577, 8597, 8598, 8599, 8584, 8587, 8733, 8734, 8741, 8801]],
		[R('cenarion-circle'), [8275, 8276, 8307, 8313, 8308, 1000, 1047, 6761, 1123, 6762, 1124, 6844, 6845, 8800, 9415, 9416, 8331, 8349, 8343, 8351, 8791]],
		[R('darkspear-trolls'), [97281]],
		[R('orgrimmar'), [97281, 4882]],
		[R('darnassus'), [2159]],
		[R('stormwind'), [35]],
		[R('gnomeregan-exiles'), [96408]],
		[R('ironforge'), [96408]],
		[R('hydraxian-waterlords'), [7486]],
		[R('thorium-brotherhood'), [7704, 3801]],
		[R('thunder-bluff'), [781, 98424]],
		[R('zandalar-tribe'), [8183]],
	];
	for (const [guide, quests] of holds) {
		for (const q of quests) {
			const turnins = goals(guide).filter(({ goal }) => is('turnin', q)(goal));
			assert.ok(turnins.length > 0, `${guide}: turnin ${q} is in the guide`);
			for (const { goal } of turnins) assert.ok(!goal.optional, `${guide}: turnin ${q} is a goal that holds`);
		}
	}
	refData();
	const generated = new Set(Object.keys(JSON.parse(fs.readFileSync(path.join(OFFICIAL_DIR, 'GENERATED.json'), 'utf8')).files));
	for (const file of allGuides().filter((f) => !generated.has(f))) {
		for (const { goal } of goals(file)) {
			if (goal.t !== 'turnin' || !goal.optional || goal.direct) continue;
			const q = refData().quest(goal.quest);
			if (!q || q.repeatable) continue;
			const start = q.start || {};
			const fromItem = (start.item || []).length > 0 && !(start.npc || []).length && !(start.object || []).length;
			const own = new Set([...(start.item || []), q.sourceItem].filter(Boolean));
			const delivery = (q.objectives || []).every((o) => o.type === 'item' && own.has(o.id)) && (q.requiredItems || []).every((i) => own.has(i));
			assert.ok(!(fromItem && delivery), `${file}: turnin ${goal.quest} (${q.title}) is optional, but a player holding it has it finished`);
		}
	}
});

// Fyurie's report (#1791): Solution to Doom's Ancient Chest (126260, one spawn) lies just inside Uldaman's cave
// mouth, 17-18 yd from Magregan Deepshadow and the Obsidian Golems (38, elite), where a level 39 warrior met them on
// the solo route. Recordings: 2 people looted it (a rogue and a druid, both able to stealth), and the rogue died at
// the chest. The quest is asked as a group quest in both Badlands 30-40 guides, accept to turn-in and the follow-up,
// and the chest's goal says "Elite: group advised" (the compiler's object-among-elites rule, #1778).
test("Fyurie's report (#1791): Solution to Doom is a group quest in the Badlands, its chest marked elite", { skip }, () => {
	for (const [guide, next] of [
		['forever/alliance/30-40/06-badlands.guide', 727],
		['forever/horde/30-40/06-badlands.guide', 728],
	]) {
		const mine = goals(guide).filter(({ goal }) => goal.quest === 709 || (goal.t === 'accept' && goal.quest === next));
		assert.deepEqual(mine.map(({ goal }) => `${goal.t} ${goal.quest}`), ['accept 709', 'collect 709', 'turnin 709', `accept ${next}`], `${guide}: accepted, done, handed in, then the follow-up`);
		for (const { step, goal } of mine) {
			assert.ok((step.when || []).some((p) => p.k === 'group' && [p.q].flat().includes(709) && !p.neg), `${guide}: ${goal.t} ${goal.quest} is under when group 709`);
		}
		const chest = mine.find(({ goal }) => goal.t === 'collect').goal;
		assert.deepEqual(chest.group, { kind: 'elite', rank: 1, lvl: 38, near: true }, `${guide}: the chest's goal says the elites`);
	}
});

// The new zones are part of the Alliance route instead of being offered beside it. The Riverglades come
// after Stranglethorn Vale (about 42.7 by the level model, the level of their port and Western Front; 1,160 -> ~300
// minutes of grinding in 40-50), Shen'dralas after the Badlands & Hinterlands, then Feralas; no Choose-your-path card
// for either. Shen'dralas players come into Feralas from Desolace, so the Feralas guide's Barrens/Thalanaar opening is
// theirs to skip and Thalanaar's flight path is picked up at the end.
test('Alliance route: Stranglethorn -> Riverglades -> Badlands & Hinterlands -> Shen\'dralas -> Feralas, no cards for them', () => {
	const G = path.join(ROOT, 'guides', 'forever');
	const head = (rel) => fs.readFileSync(path.join(G, rel), 'utf8').split('\n# ')[0];
	const nexts = (rel) => head(rel).split('\n').filter((l) => l.startsWith('next ')).map((l) => l.slice(5).trim());
	assert.deepEqual(nexts('alliance/30-40/06-badlands.guide'), ['forever/alliance/30-40/06b-desolace']);
	assert.deepEqual(nexts('alliance/40-50/01-stranglethorn-vale.guide'), ['forever/alliance/40-50/01b-riverglades']);
	assert.deepEqual(nexts('alliance/40-50/01b-riverglades.guide'), ['forever/alliance/40-50/02-badlands']);
	assert.deepEqual(nexts('alliance/40-50/02-badlands.guide'), ['forever/40-50/shendralas']);
	assert.ok(nexts('40-50/shendralas.guide').includes('forever/alliance/40-50/03-feralas'));
	const retired = JSON.parse(fs.readFileSync(path.join(ROOT, 'guides', 'retired.json'), 'utf8'));
	for (const id of ['polestar-experimental/riverglades-alliance-1', 'polestar-experimental/shendralas']) assert.ok(retired.includes(id), `${id}: a saved tab opens its successor`);
	const feralas = fs.readFileSync(path.join(G, 'alliance/40-50/03-feralas.guide'), 'utf8').split(/\n(?=step\b)/);
	for (const title of ['Into The Barrens', 'Thalanaar flight master']) {
		assert.ok(feralas.find((s) => s.startsWith(`step ${title}\n`)).includes('\n  when !turnedin 93394\n'), `${title}: not for a player coming from Shen'dralas`);
	}
	assert.ok(feralas.some((s) => s.includes('\n  when !taxi "Thalanaar"\n') && s.includes('getfp "Thalanaar"')), 'Thalanaar\'s flight path for those who have not learnt it');
});

// #1984: Captain Garran Vimes never offers Vimes's Report (1288) after The Deserters (1287): at least 10 recorded
// hand-ins of 1287 and no run of 1288 at all. The 40-50 Alliance Theramore steps waited on its accept; the route
// leaves it out (the 0.4.0 rebuild applies the record).
test('route-fixes leaves Vimes\'s Report out on the Alliance side (#1984)', () => {
	const { overrides } = JSON.parse(fs.readFileSync(path.join(ROOT, 'data', 'route-fixes.json'), 'utf8'));
	assert.ok(overrides.skip.some((r) => r.q === 1288 && r.faction === 'Alliance'), 'route-fixes leaves 1288 out on the Alliance side');
});

// #2493 (the same report as #1984, 0.3.7.2): the guides themselves still waited on the accept at Theramore; no Alliance
// guide asks for Vimes's Report (20 people in players' recordings handed in The Deserters, none was offered 1288).
test('no Alliance guide waits on Vimes\'s Report (#1984, #2493)', { skip }, () => {
	for (const g of allGuides().filter((f) => f.startsWith('forever/alliance/'))) {
		assert.ok(!goals(g).some(({ goal }) => goal.quest === 1288), `${g}: no Vimes's Report`);
	}
});
for (const run of fs.existsSync(path.join(ROOT, 'data', 'dungeon-runs.json')) ? DUNGEON_RUNS() : []) {
	test(`dungeons in the route: ${run.dungeon} (${run.faction}): the recorded pick-ups, the guarded run at the door and the hand-ins are in the guides`, { skip }, () => {
		const steps = (guide) => compiled(`${guide}.guide`).steps;
		const runs = steps(run.run.guide).filter((s) => whenDungeonOf(s, run.dungeon) && s.goals.some((g) => g.t === 'enter'));
		assert.equal(runs.length, 1, `${run.run.guide}: one run step`);
		const [step] = runs;
		for (const quest of run.run.objectives) assert.ok(whenQuestOf(step, ['onquest'], quest), `the run waits for a quest of it held (${quest}): no empty trip to the door`);
		const enter = step.goals.find((g) => g.t === 'enter');
		assert.equal(enter.map, run.run.entrance.map, 'the run enters on the entrance\'s map');
		assert.ok(Math.hypot(enter.x - run.run.entrance.x, enter.y - run.run.entrance.y) < 1, `at the entrance (${enter.x},${enter.y})`);
		const pickups = [...(run.pickups || []).map((p) => [p.quest, (p.after && p.after.guide) || p.guide]), ...(run.runStop || []).map((q) => [q, run.run.guide])];
		for (const [quest, guide] of pickups) {
			assert.ok(steps(guide).some((s) => whenDungeonOf(s, run.dungeon) && s.goals.some(is('accept', quest))), `${guide}: ${quest} is picked up only by a character who chose ${run.dungeon}`);
		}
		for (const h of run.handins || []) {
			const ends = steps(h.guide).filter((s) => s.goals.some(is('turnin', h.quest)));
			assert.ok(ends.length >= 1, `${h.guide}: ${h.quest} is handed in`);
			for (const s of ends) {
				assert.ok(whenQuestOf(s, ['complete', 'onquest'], h.quest), `${h.guide}: the hand-in of ${h.quest} waits for the quest (complete or held)`);
				assert.ok(whenDungeonOf(s, run.dungeon), `${h.guide}: the hand-in of ${h.quest} is behind \`when dungeon\`: a character who skips ${run.dungeon} keeps the solo route's steps`);
			}
		}
		// Fitz, 2026-11-13: never a dungeon too low. A record with gates: the run applies from the dungeon's floor (its
		// `gate`, the Codex's floor, which forge guide lint checks), each pick-up from the floor less the levels the
		// route plans before the run (its own `gate`), and a pick-up at the run's own stop with the run. A quest picked up
		// on several stops of a guide (Mebok's at each Raptor Horns hand-in, then the Ratchet catch-up) has a record
		// entry per stop: each of its steps carries one of their gates, and each gate is on a step.
		if (run.run.gate != null) {
			assert.equal(lowestLevel(step), run.run.gate, `${run.run.guide}: the run is gated \`when level>=${run.run.gate}\``);
			const gated = new Map();
			for (const [quest, guide, gate] of [...(run.pickups || []).map((p) => [p.quest, (p.after && p.after.guide) || p.guide, p.gate]), ...(run.runStop || []).map((q) => [q, run.run.guide, run.run.gate])]) {
				assert.ok(gate != null, `${guide}: the pick-up of ${quest} has its gate in the record`);
				const key = `${guide}|${quest}`;
				if (!gated.has(key)) gated.set(key, { quest, guide, gates: new Set() });
				gated.get(key).gates.add(gate);
			}
			for (const { quest, guide, gates } of gated.values()) {
				const on = steps(guide).filter((x) => whenDungeonOf(x, run.dungeon) && x.goals.some(is('accept', quest))).map(lowestLevel);
				for (const g of on) assert.ok(gates.has(g), `${guide}: the pick-up of ${quest} is gated \`when level>=${g}\`, which its record doesn't give (${[...gates].join(', ')})`);
				for (const g of gates) assert.ok(on.includes(g), `${guide}: no pick-up of ${quest} is gated \`when level>=${g}\`, as its record says`);
			}
			// And never under the level its quests ask for: the game refuses an accept under its quest's minimum, and the
			// route comes back to the step once the character gets there (the Ruins of Lordaeron's Silverpine pick-up).
			for (const guide of new Set(pickups.map(([, g]) => g))) {
				for (const s of steps(guide).filter((x) => whenDungeonOf(x, run.dungeon) && x.goals.some((g) => g.t === 'accept'))) {
					const asks = Math.max(0, ...s.goals.filter((g) => g.t === 'accept' && g.minLevel).map((g) => g.minLevel));
					assert.ok(lowestLevel(s) >= asks, `${guide}: "${s.title}" is gated \`when level>=${lowestLevel(s)}\`, under the level its quests ask for (${asks})`);
				}
			}
		}
	});
}

// The dungeons measured and left out of the route (data/dungeon-runs.json `notInRoute`): each says why, none of them
// also has a run recorded for that side, and no leveling guide of that side has a step for it.
test('dungeons in the route: the dungeons left out say why and have no steps in the leveling guides', { skip }, () => {
	const file = JSON.parse(fs.readFileSync(path.join(ROOT, 'data', 'dungeon-runs.json'), 'utf8'));
	const sides = (f) => (f === 'Both' ? ['Alliance', 'Horde'] : [f]);
	for (const n of file.notInRoute || []) {
		assert.ok(n.dungeon && n.why && n.why.length > 20, `${n.dungeon}: a reason`);
		for (const faction of sides(n.faction)) {
			assert.ok(!file.runs.some((r) => r.faction === faction && dungeonKey(r.dungeon) === dungeonKey(n.dungeon)), `${n.dungeon} (${faction}) is both run and left out`);
			const dir = faction.toLowerCase();
			for (const guide of allGuides().filter((g) => g.startsWith(`forever/${dir}/`))) {
				const text = fs.readFileSync(path.join(OFFICIAL_DIR, guide), 'utf8');
				for (const m of text.matchAll(/^\s*when dungeon "([^"]+)"/gm)) assert.notEqual(dungeonKey(m[1]), dungeonKey(n.dungeon), `${guide}: a step for ${n.dungeon}, which is left out`);
			}
		}
	}
});

// The other way round: every `when dungeon` step of the leveling guides belongs to a recorded run (its dungeon
// recorded for that guide's faction, and that guide named in the record), so no injected step is left without the
// record a Forge round needs. Gnomeregan stays out of the route: its pick-up and hand-in guides on its Dungeons page
// cover it, so no leveling guide has a step for it.
test('dungeons in the route: every `when dungeon` step of the leveling guides is explained by data/dungeon-runs.json', { skip }, () => {
	const runs = DUNGEON_RUNS();
	assert.ok(!runs.some((r) => dungeonKey(r.dungeon) === 'gnomeregan'), 'no Gnomeregan run is recorded');
	const bad = [];
	for (const guide of allGuides().filter((g) => /^forever\/(alliance|horde)\//.test(g))) {
		const id = guide.replace(/\.guide$/, '');
		const faction = guide.startsWith('forever/alliance/') ? 'Alliance' : 'Horde';
		const text = fs.readFileSync(path.join(OFFICIAL_DIR, guide), 'utf8');
		for (const m of text.matchAll(/^\s*when dungeon "([^"]+)"/gm)) {
			const name = dungeonKey(m[1]);
			const ok = runs.some((r) => r.faction === faction && dungeonKey(r.dungeon) === name &&
				[r.run.guide, ...(r.pickups || []).map((p) => (p.after && p.after.guide) || p.guide), ...(r.handins || []).map((h) => h.guide)].includes(id));
			if (!ok) bad.push(`${id}: ${m[1]}`);
		}
	}
	assert.deepEqual([...new Set(bad)], []);
});

// sesgoe (#227): Moon Priestess Amara rides up and down the road west of Dolanaar, and the arrow pointed at one spot
// of it with nothing saying she moves; the same check found Private Thorsen, who walks the Rebel Camp's path down to
// the road and back. Every step at either of them says they move: the Darnassus reputation guide's Dolanaar hub, added
// after the fix, took and handed in The Road to Darnassus with no word of it until its tips said so.
test('Walking givers (#227): every step at Moon Priestess Amara or Private Thorsen says they move along their road', { skip }, () => {
	const walkers = { 2151: 'Moon Priestess Amara', 738: 'Private Thorsen' };
	for (const [npc, name] of Object.entries(walkers)) assert.equal(refData().npc(Number(npc)).name, name, `npc ${npc} is ${name}`);
	const moves = /\b(patrols?|walks?|wanders?|roams?|rides?)\b/i;
	const silent = stepsHolding((g) => walkers[g.npc] && ['accept', 'turnin', 'talk'].includes(g.t))
		.filter(({ step, goal }) => !moves.test(notesOf(step, goal)))
		.map(({ guide, step, goal }) => `${guide} "${step.title}": ${goal.t} ${goal.quest || ''} at ${walkers[goal.npc]}, with no word that they move`);
	assert.deepEqual(silent, []);
});

// Fitz on Discord (#504): the Kul Tiras Marines round Corporal Adamore, where Trouble in the Valley's Benedict's Orders
// are taken, come as one: pulling one calls the rest. The step that sends you there says so.
test("Trouble in the Valley (#504): the step at Corporal Adamore's camp says his marines come together", { skip }, () => {
	const silent = stepsHolding((g) => g.quest === 95621 && ['collect', 'kill', 'complete'].includes(g.t))
		.filter(({ step, goal }) => !/\blinked\b|pull(?:ing)? one|calls? the rest|come together|pull together/i.test(notesOf(step, goal)))
		.map(({ guide, step, goal }) => `${guide} "${step.title}": ${goal.t} for 95621 with no word that the marines come together`);
	assert.deepEqual(silent, []);
});

// SUBDUBBUB (#874): Tyr's Watch's last hand-in, A Lesson in Divinity to Danitha Morr, came right after Deathguard
// Billmuth downstairs in the keep, and nothing said she is back upstairs (the arrow can't tell the keep's floors apart).
// Any goal at Danitha that follows one at Billmuth says she is upstairs.
test("Tyr's Watch (#874): a goal at Danitha Morr right after Deathguard Billmuth downstairs says she is back upstairs", { skip }, () => {
	const BILLMUTH = 257655;
	const DANITHA = 246378;
	assert.equal(refData().npc(BILLMUTH).name, 'Deathguard Billmuth');
	assert.equal(refData().npc(DANITHA).name, 'Danitha Morr');
	const missing = [];
	for (const guide of allGuides()) {
		const list = goals(guide).filter(located);
		list.forEach((e, i) => {
			if (e.goal.npc !== DANITHA || i === 0 || list[i - 1].goal.npc !== BILLMUTH) return;
			if (!/\bupstairs\b/i.test(notesOf(e.step, e.goal))) missing.push(`${guide} step ${e.s}: ${e.goal.t} ${e.goal.quest} at Danitha Morr after Billmuth, with no word that she is upstairs`);
		});
	}
	assert.deepEqual(missing, []);
});

// Phear (#875), Fyurie (#910): a `use` with no quest before the line that collects what it makes (the Crystal Phial at
// the moonwell, the sample bottle at the Cliffspring River) is a check-off nothing ticks, so the step held after the
// objective was done. Such a use is bound to the collect's quest in every guide (lint only warns).
test('A use before the line that collects for a quest is bound to that quest, in every guide (#875, #910)', { skip }, () => {
	const bare = [];
	for (const guide of allGuides()) {
		for (const step of compiled(guide).steps) {
			step.goals.forEach((goal, i) => {
				const next = step.goals[i + 1];
				if (goal.t !== 'use' || goal.quest != null || goal.optional || !next || next.t !== 'collect' || next.quest == null) return;
				bare.push(`${guide} "${step.title}": use ${goal.item} has no quest, and the next line collects for quest ${next.quest}`);
			});
		}
	}
	assert.deepEqual(bare, []);
});

// Almighty972 (#2151): "Ca n'indique pas le bon endroit pour ramasser les
// étoffe de lin" on the Human Paladin's Tome of Divinity. Only pfQuest lists
// Lisan Pierce (1414), a Stormwind NPC, as a Linen Cloth dropper (100%), so the
// arrow went to her; QuestieDB does not. General Marcus Jonathan (466) is the
// same case for Runecloth. Both are friendly to the Alliance players these
// guides are for (forever-db/corrections/items.json removeDrops). Without them
// the nearest dropper to a city step is still a mob of the wrong level or in
// another city, so the cloth goals in a city point at its Auction House, as
// the steps' tips say (Auctioneer Fitch 8719, Auctioneer Redmuse 8720).
test('#2151: Linen Cloth and Runecloth goals in Alliance guides lead to the Auction House, not to a Stormwind NPC', { skip }, () => {
	const auction = [8719, 8720];
	for (const [guide, quest, item, npc] of [
		['forever/class/paladin/tome-of-divinity.guide', 1644, 2589, 1414],
		['forever/class/paladin/tome-of-divinity.guide', 1648, 2589, 1414],
		['forever/class/mage/manaweave-robe.guide', 1921, 2589, 1414],
		['forever/collectibles/mounts/alliance/paladin-charger.guide', 7642, 14047, 466],
		['forever/alliance/50-60/06-silithus.guide', undefined, 14047, 466],
	]) {
		const found = goals(guide).filter(({ goal }) => goal.t === 'collect' && goal.quest === quest && goal.item === item);
		assert.ok(found.length > 0, `${guide}: the ${item} collect for ${quest} is in the guide`);
		for (const { goal } of found) {
			const ids = (goal.fromNpcs || []).map((n) => n.npc);
			assert.ok(!ids.includes(npc), `${guide} ${quest}: npc ${npc} is not named as a dropper (${ids.join(', ')})`);
			const near = auction.some((a) => {
				const spawn = refData().npcs[a].spawns[goal.map];
				return spawn && yards(goal, { map: goal.map, x: spawn.pts[0][0], y: spawn.pts[0][1] }) <= 15;
			});
			assert.ok(near, `${guide} ${quest}: the arrow at ${goal.map} ${goal.x},${goal.y} is at an Auction House`);
		}
	}
});

// #2311 (kaeldrin-gh, Human Warrior 22): "Complete The Rethban Gauntlet" had no place and nothing placed before it in
// its step, so the arrow showed nothing while the player ran to the Rethban Caverns (the hand-in after it waits for
// the quest). The same pattern, a `complete` with no place leading its step while its objective has one (lint: "the
// arrow has nowhere to point"), in three more guides: The Balance of Light and Shadow (Benediction), How Big a
// Threat? (Darnassus reputation) and Discipline (Undercity reputation). Each now has its objective's place: the
// Rethban Caverns' first fork, where 6 people's recordings tick the objective (14.07-14.35, 25.17-25.45, live), after
// a goto at the cave's mouth where they walk in; the others the quest data's objective points (984: 50+ people tick
// it at 39-40.5, 52.5-54.5; 99134: 100+ around Brill, 58.5-61.5, 51.5-53.5).
test('#2311: a complete that leads its step has a place for the arrow', { skip }, () => {
	for (const [guide, quest, map, x, y] of [
		['forever/class/warrior/fire-hardened-armor.guide', 1699, 1433, 14.2, 25.3],
		['forever/class/priest/benediction.guide', 7622, 1423, 17.42, 12.24],
		['forever/reputation/darnassus.guide', 984, 1439, 39.9, 53.9],
		['forever/reputation/undercity.guide', 99134, 1420, 60.7, 52.0],
	]) {
		const list = goals(guide);
		const i = at(list, `${guide}: complete ${quest}`, is('complete', quest));
		const { goal } = list[i];
		assert.ok(located(list[i]), `${guide}: complete ${quest} has a place`);
		assert.equal(goal.map, map, `${guide}: complete ${quest} on map ${map}`);
		assert.ok(Math.hypot(goal.x - x, goal.y - y) < 0.05, `${guide}: complete ${quest} at ${x},${y} (got ${goal.x},${goal.y})`);
	}
	const list = goals('forever/class/warrior/fire-hardened-armor.guide');
	const i = at(list, 'complete 1699', is('complete', 1699));
	const mouth = list[i - 1];
	assert.equal(mouth.step, list[i].step, 'the cave mouth is in the same step');
	assert.equal(mouth.goal.t, 'goto', 'a goto at the Rethban Caverns before the fork inside');
	assert.ok(Math.hypot(mouth.goal.x - 15.0, mouth.goal.y - 27.3) < 0.05 && mouth.goal.f !== 'e', `the mouth at 15.0,27.3, live frame (got ${mouth.goal.x},${mouth.goal.y} ${mouth.goal.f})`);
});

// Quests their givers do not offer on Forever stay out of every guide: Vimes's Report (#1926: Captain Garran Vimes
// never offers it) and Awaiting Word (#2148: Watcher Dodds never offers it, though the map showed it).
test('#1926, #2148: Vimes\'s Report and Awaiting Word, which their givers do not offer on Forever, are in no guide', { skip }, () => {
	const out = { 1288: '#1926', 1289: '#1926', 236: '#2148' };
	const found = [];
	for (const guide of allGuides()) {
		for (const { goal } of goals(guide)) if (goal.quest in out && goal.t === 'accept') found.push(`${guide}: accept ${goal.quest} (${out[goal.quest]})`);
	}
	assert.deepEqual(found, []);
});
test('#2612: quests handed in at an object are never handed in to their giver', { skip }, () => {
	const corrections = JSON.parse(fs.readFileSync(path.join(ROOT, 'forever-db', 'corrections', 'quests.json'), 'utf8'));
	for (const [quest, object] of Object.entries(OBJECT_ENDERS)) {
		assert.deepEqual(corrections[quest].set.end, { npc: [], object: [object] }, `${quest}: ended by object ${object} alone`);
	}
	let seen = 0;
	for (const guide of allGuides()) {
		const text = fs.readFileSync(path.join(OFFICIAL_DIR, guide), 'utf8');
		if (!Object.keys(OBJECT_ENDERS).some((q) => new RegExp(`^\\s+turnin ${q}\\b`, 'm').test(text))) continue;
		for (const { goal } of goals(guide)) {
			const object = goal.t === 'turnin' && OBJECT_ENDERS[goal.quest];
			if (!object) continue;
			seen++;
			assert.equal(goal.npc, undefined, `${guide}: turnin ${goal.quest} goes to no NPC`);
			assert.equal(goal.object, object, `${guide}: turnin ${goal.quest} at object ${object}`);
		}
	}
	assert.ok(seen >= 10, `the guides' hand-ins of these quests were checked (${seen})`);
});
