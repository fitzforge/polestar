'use strict';
// forever-db/corrections: a correction that gives a quest its
// prerequisites must leave the quest blocked by them. QuestieDB's split
// fields win over pfQuest's `pre` once either is present (prereqs.js), so a
// `set` with `pre` and an empty `preAny` but no `preAll` blocks nothing.

const { test } = require('node:test');
const assert = require('node:assert/strict');
const fs = require('node:fs');
const os = require('node:os');
const path = require('node:path');

const { loadCorrections, loadPublicCorrections, overlayCorrections, PUBLIC_DIR, SECTIONS, SOURCE_KINDS } = require('../tools/lib/data/corrections');

const corrections = loadPublicCorrections();
const { blockingPrereqs, closedByOf } = require('../tools/lib/data/prereqs');

test('every public correction names an independent source, and its note cites no web page', () => {
	const bad = [];
	for (const section of SECTIONS) {
		for (const [id, entry] of Object.entries(corrections[section] || {})) {
			const sources = [].concat(entry.source || []);
			if (!sources.length || !sources.every((s) => SOURCE_KINDS.includes(s.kind) && typeof s.ref === 'string' && s.ref)) bad.push(`${section} ${id}: source`);
			if (typeof entry.note !== 'string' || /https?:|\[race=|snapshot/i.test(entry.note)) bad.push(`${section} ${id}: note`);
		}
	}
	assert.deepEqual(bad, []);
});

test('the corrections are one file per section in forever-db/corrections', () => {
	for (const s of SECTIONS) assert.ok(fs.existsSync(path.join(PUBLIC_DIR, `${s}.json`)), `${s}.json`);
	assert.ok(!fs.existsSync(path.join(__dirname, '..', 'tools', 'lib', 'data', 'corrections.json')), 'the old single file is gone');
});

test('the overlay takes mechanics flat or under quests; mechanics 603 and 1064 stay private', () => {
	const out = overlayCorrections({ mechanics: {} }, { mechanics: { quests: { 603: { note: 'nested' } }, 1064: { note: 'flat' } } });
	assert.deepEqual(Object.keys(out.mechanics).sort(), ['1064', '603']);
	assert.ok(!('603' in corrections.mechanics) && !('1064' in corrections.mechanics));
});

test('the private overlay adds its entries and merges shared ones field by field', () => {
	const pub = { _about: 'public', quests: { 1: { set: { start: { npc: [2] } }, source: { kind: 'tdb', ref: 'x' }, note: 'a' } }, npcs: {} };
	const priv = { _about: 'private', quests: { 1: { set: { races: 8 }, note: 'b' }, 3: { set: { xp: 10 }, note: 'c' } }, objects: { 4: { addSpawns: {}, note: 'd' } } };
	assert.deepEqual(overlayCorrections(pub, priv), {
		_about: 'public',
		quests: { 1: { set: { start: { npc: [2] }, races: 8 }, source: { kind: 'tdb', ref: 'x' }, note: 'b' }, 3: { set: { xp: 10 }, note: 'c' } },
		npcs: {},
		objects: { 4: { addSpawns: {}, note: 'd' } },
	});
	assert.deepEqual(pub.quests[1].set, { start: { npc: [2] } }, 'the public corrections stay as they were');
});

test('data build reads the overlay from data/local only when it is there, or the file it is given', () => {
	const root = fs.mkdtempSync(path.join(os.tmpdir(), 'polestar-corr-'));
	assert.deepEqual(loadCorrections({ root }), corrections, 'no overlay: the public corrections alone');
	fs.mkdirSync(path.join(root, 'data', 'local'), { recursive: true });
	const file = path.join(root, 'data', 'local', 'corrections-private.json');
	fs.writeFileSync(file, JSON.stringify({ quests: { 1: { set: { xp: 1 }, note: 'private' } } }));
	assert.deepEqual(loadCorrections({ root }).quests[1], { set: { xp: 1 }, note: 'private' });
	assert.deepEqual(loadCorrections({ root, privateFile: false }), corrections, '--no-corrections-private');
	assert.deepEqual(loadCorrections({ privateFile: file }).quests[1].note, 'private', '--corrections-private <file>');
	fs.rmSync(root, { recursive: true, force: true });
});

test('every prerequisite correction blocks the quest until its prerequisites are turned in', () => {
	const dead = [];
	for (const [id, entry] of Object.entries(corrections.quests || {})) {
		const set = entry && entry.set;
		if (!set || !['pre', 'preAll', 'preAny'].some((k) => Array.isArray(set[k]) && set[k].length > 0)) continue;
		const { all, any } = blockingPrereqs({ id: Number(id), start: { npc: [1] }, ...set });
		if (all.length === 0 && any.length === 0) dead.push(id);
	}
	assert.deepEqual(dead, [], `corrections that set prerequisites but block nothing: ${dead.join(', ')}`);
});

// A timed quest's `limit` (seconds once taken): the Forever TDB's TimeAllowed through the data build's KB step, a
// Forever quest's from a correction. Dynamic Questing takes a timed quest early only when the walk still fits.
test('Grace of An\'she and Mu\'sha allows ten minutes; a time limit is a whole number of seconds', () => {
	assert.equal(corrections.quests[95805].set.limit, 600);
	const bad = Object.entries(corrections.quests).filter(([, e]) => e.set && 'limit' in e.set && !(Number.isInteger(e.set.limit) && e.set.limit > 0));
	assert.deepEqual(bad.map(([id]) => id), []);
});

test('A Void Path allows four minutes from the accept: the game times it (players\' recordings), its text says how long', () => {
	const entry = corrections.quests[98252];
	assert.equal(entry.set.limit, 240);
	assert.ok([].concat(entry.source).some((s) => s.kind === 'recording' && /timer/.test(s.ref)), 'a recording source for the timer');
});

test('the release data carries time limits: 95805 600 s, Scalding Mornbrew Delivery the TDB\'s 300 s, none on an untimed quest', (t) => {
	const file = path.join(__dirname, '..', 'data', 'forever', 'quests.json');
	if (!fs.existsSync(file)) return t.skip('no data/forever');
	const quests = JSON.parse(fs.readFileSync(file, 'utf8'));
	if (!Object.values(quests).some((q) => q.limit)) return t.skip('data/forever was built without the KB step (no time limits)');
	assert.deepEqual([quests[95805].limit, quests[3364].limit, quests[755].limit], [600, 300, undefined]);
});

test('Highland Hides waits for Young Crocolisk Skins, not Daily Delivery (#533)', () => {
	const { all, any } = blockingPrereqs({ id: 98815, start: { npc: [2094] }, ...corrections.quests[98815].set });
	assert.deepEqual({ all, any }, { all: [], any: [484] });
});

test('The Wrath of Rath\'mael waits for the second Rear Guard Patrol, which waits for the first (#849)', () => {
	const { all, any } = blockingPrereqs({ id: 92422, start: { npc: [251001] }, ...corrections.quests[92422].set });
	assert.deepEqual({ all, any }, { all: [], any: [99156] });
	assert.deepEqual(corrections.quests[99156].set.preAny, [356]);
});

test('A Void Path waits for Never Coming Back, handed in to the same giver (#1002, #984)', () => {
	const entry = corrections.quests[98252];
	assert.ok(entry, 'a correction for A Void Path');
	const { all, any } = blockingPrereqs({ id: 98252, start: { npc: [267214] }, ...entry.set });
	assert.deepEqual({ all, any }, { all: [], any: [98251] });
});

test('Moonbrook Espionage waits for Murloc Gills as well as The State of the Mines (#991)', () => {
	const { all, any } = blockingPrereqs({ id: 92747, start: { npc: [253092] }, ...corrections.quests[92747].set });
	assert.deepEqual({ all, any }, { all: [92744], any: [92745] });
});

test('The State of the Mines waits for both Testing the Wells and Murloc Gills (dungeon pre-quest sweep)', () => {
	const { all, any } = blockingPrereqs({ id: 92745, start: { npc: [253092] }, ...corrections.quests[92745].set });
	assert.deepEqual({ all, any }, { all: [92742, 92744], any: [] });
});

test('the Moonsilver Blade chain before Old Fire-Eye is taken in order (dungeon pre-quest sweep)', () => {
	const chain = [[95036, 259620, 95034], [95111, 248840, 95036], [95125, 3539, 95111], [95126, 3539, 95125]];
	for (const [id, npc, pre] of chain) {
		const entry = corrections.quests[id];
		assert.ok(entry, `a correction for ${id}`);
		assert.deepEqual(blockingPrereqs({ id, start: { npc: [npc] }, ...entry.set }), { all: [], any: [pre] }, `${id} after ${pre}`);
	}
});

test('The New Plague waits for the A Recipe For Death chain, handed in to its last part (#867)', () => {
	const entry = corrections.quests[95216];
	assert.ok(entry, 'a correction for The New Plague');
	const { all, any } = blockingPrereqs({ id: 95216, start: { npc: [11835] }, ...entry.set });
	assert.deepEqual({ all, any }, { all: [], any: [451] });
});

test('Crocs of the Sky waits for Apprentice\'s Duties, and The Shamed Lieutenant for A Friend of the Family (#872 sweep)', () => {
	const blocks = (id, npc) => {
		const entry = corrections.quests[id];
		assert.ok(entry, `a correction for ${id}`);
		return blockingPrereqs({ id, start: { npc: [npc] }, ...entry.set });
	};
	assert.deepEqual(blocks(98072, 2094), { all: [], any: [471] }, 'James Halloran, Menethil Harbor');
	assert.deepEqual(blocks(98219, 928), { all: [], any: [98191] }, 'Lord Grayson Shadowbreaker, Stormwind');
});

// Bennistrov (#1354): Highlord Bolvar Fordragon's A Friend of the Family (98191) is offered only once Captain
// Stoutfist's (98190) is handed in to him. Without the prerequisite the guide still sent a player who had skipped
// 98190 to Bolvar for 98191. The follow-up sweep (players' recordings: taken only after the quest before, refused
// before it; a second source agreeing) found the same gap in these chains.
test('Follow-ups wait for the quest before them, so a skipped one takes its follow-up with it (#1354 sweep)', () => {
	const blocks = (id, npc) => {
		const entry = corrections.quests[id];
		assert.ok(entry, `a correction for ${id}`);
		return blockingPrereqs({ id, start: { npc: [npc] }, ...entry.set });
	};
	for (const [id, npc, any, who] of [
		[98191, 1748, [98190], 'Highlord Bolvar Fordragon, Stormwind (#1354)'],
		[98394, 11802, [98393], 'Dendrite Starblaze, Moonglade (Druid cat form)'],
		[98396, 11957, [98394], 'the Great Cat Spirit'],
		[98731, 11957, [98396], 'the Great Cat Spirit'],
		[98397, 11802, [98731, 98738], 'Dendrite Starblaze: either blessing'],
		[78089, 3663, [78088], 'Delgren the Purifier (Paladin cloak)'],
		[78090, 5492, [78089], 'Katherine the Pure'],
		[78091, 5495, [78090], 'Ursula Deline: Earning Your Salt'],
		[78092, 5495, [78091], 'Ursula Deline'],
		[91859, 248840, [91858], 'Trevan Rol (Lumina Windsinger chain)'],
		[91860, 259611, [91859], 'Deathguard Baldren'],
		[96204, 248755, [91862], 'Lumina Windsinger'],
		[95034, 259620, [96204], 'Lumina Windsinger'],
		[96264, 259023, [94789], 'Veyric Thunderhame (Shaman Call of Air)'],
		[92519, 12920, [97539], 'Doctor Gregory Victor, Hammerfall'],
		[92457, 269127, [92432], 'Image of Archmage Modera (Kirin Tor)'],
		[95770, 2519, [95748], 'Kin\'weelay: Locating the Lost City after The Gurubashi Legends of Old'],
	]) assert.deepEqual(blocks(id, npc), { all: [], any }, who);
	const fenris = corrections.quests[91861];
	assert.ok(fenris, 'a correction for 91861');
	assert.deepEqual(blockingPrereqs({ id: 91861, start: { object: [566037] }, ...fenris.set }), { all: [], any: [91860] }, 'the Charred Remains');
});

test('Seeking Caitlin is closed by Lost in the Thicket Things, its breadcrumb target (#533)', () => {
	const quests = { 95737: { id: 95737, ...corrections.quests[95737].set }, 95647: { id: 95647 } };
	assert.deepEqual(closedByOf(95737, quests), [95647]);
});

test('Daily Delivery is closed by Young Crocolisk Skins, its breadcrumb target (#615)', () => {
	const quests = { 469: { id: 469, ...corrections.quests[469].set }, 484: { id: 484 } };
	assert.deepEqual(closedByOf(469, quests), [484]);
});

// J's report (#1643): Connor Rivers stops offering James Hyal once They Call Him Smiling Jim is handed in (the world
// DB's quest conditions), so the correction closes it on 1282 as well as on the quest it leads to.
test('James Hyal is closed by They Call Him Smiling Jim as well as by its second part (#1643)', () => {
	const quests = { 1301: { id: 1301, breadcrumbFor: 1302, ...corrections.quests[1301].set }, 1302: { id: 1302, breadcrumbs: [1301], excl: [1282] }, 1282: { id: 1282, excl: [1302] } };
	assert.deepEqual(closedByOf(1301, quests), [1302, 1282]);
});

test('Benedict\'s Chest opens with Benedict\'s Key (#467)', () => {
	assert.deepEqual(corrections.objects[3239].set.lock, { item: 4882 });
});

// #2014: Forever moved Henrig Lonebrow's Journal about 110 yd south of its old spot (every recorded loot since
// 2026-11-10 lies there); the Razorfen Kraul pick-up guide's collect step pointed at the old one.
test("Henrig Lonebrow's Journal lies where players loot it now, its old spot gone (#2014)", () => {
	assert.deepEqual(corrections.objects[19861].set.spawns, { 1441: { f: 'e', pts: [[31.29, 28.05]] } });
});

// #1992, #2007: Archmage Tervosh and Lady Jaina Proudmoore show at Sentry Point and North Point Tower only to players on
// The Missing Diplomat; the corrections had made those spots their spawns, so the Maraudon pick-up guide sent everyone to
// North Point Tower for Shadowshard Fragments. Their spawns are Theramore's tower; the chain's steps keep their own spots.
test('Archmage Tervosh and Lady Jaina stand in Theramore\'s tower; the Missing Diplomat spots are no spawns of theirs (#1992)', () => {
	assert.deepEqual(corrections.npcs[4967].set.spawns, { 1445: { f: 'e', pts: [[66.42, 49.26]] } }, 'Archmage Tervosh');
	assert.deepEqual(corrections.npcs[4968].set.spawns, { 1445: { f: 'e', pts: [[66.27, 49.04]] } }, 'Lady Jaina Proudmoore');
});

// The 0.4.0 moved-object sweep (players' recorded loot spots against the data's spawns, in world yards through each
// map's own frame): quest objects every player loots where the data had no place, or only one place of several.
test('quest objects stand where players loot them: Krom\'zar\'s Banner, the coffers, the Magenta Caps, the Box of Assorted Parts', () => {
	const at = (id, map) => corrections.objects[id].addSpawns[map];
	assert.deepEqual(at(164690, 1413), { f: 'e', pts: [[44.44, 28.15]] }, "Krom'zar's Banner, which had no place (12 people loot it there)");
	assert.equal(at(103574, 1458).pts.length, 7, 'the Undercity coffers, which had no place');
	const caps = at(128293, 1418).pts;
	for (const p of [[37.57, 15.25], [38.22, 17.03], [41.01, 15.01], [34.04, 24.42]]) assert.ok(caps.some((q) => q[0] === p[0] && q[1] === p[1]), `Magenta Cap Clusters at ${p}`);
	const box = at(19019, 1436).pts;
	for (const p of [[43.98, 67.79], [44.9, 71.1], [26.46, 72.78]]) assert.ok(box.some((q) => q[0] === p[0] && q[1] === p[1]), `Box of Assorted Parts at ${p}`);
	assert.ok(at(19019, 1413).pts.some((q) => q[0] === 61.92 && q[1] === 3.62), 'and in the Barrens where players loot it');
});

test('The Glowing Shard\'s one line is to speak with Sputtervalve in Ratchet, so its hand-in guide goes there first (#1326)', () => {
	assert.deepEqual(corrections.quests[6981].set.objectives, [{ type: 'talk', id: 3442, count: 1, text: 'Speak with someone in Ratchet about the Glowing Shard' }]);
});

test('dungeon turn-in NPCs the data placed nowhere stand where players hand in to them (#1326 sweep)', () => {
	assert.deepEqual(corrections.npcs[13155].set.spawns, { 1437: { f: 'e', pts: [[51.41, 59.23]] } }, 'Deathstalker Agent: Dragonmaw Rumors and Open the Maw, Wetlands');
	// Stormwind City's spots in the frame of the map the game shows (live, with the harbour): read in the older map's
	// frame they lie about 100 yd south, toward the Trade District, and the arrow led away from her (#1870).
	assert.deepEqual(corrections.npcs[15991].set.spawns, { 1453: { f: 'l', pts: [[68.15, 29], [70.18, 29.86]] } }, 'Lady Dena Kennedy: Crest of Lordaeron, Stormwind City');
});

test('the Dalaran traitors stand in the camp south of their Classic spot, where players kill them (#1633)', () => {
	const at = (id) => corrections.npcs[id].set.spawns;
	assert.deepEqual(at(2414), { 1416: { f: 'l', pts: [[16.8, 89.4]] }, 1424: { f: 'l', pts: [[23.6, 26.7]] } }, 'Kegan Darkmar: Bloodstone Oval');
	assert.deepEqual([2411, 2412, 2413].map((id) => at(id)[1416].pts), [[[19.5, 90]], [[19.6, 90.9]], [[19.3, 91.5]]], 'Ricter, Alina and Dermot');
	for (const id of [2411, 2412, 2413, 2414]) assert.ok(at(id)[1424], `npc ${id}: its Hillsbrad Foothills spot moves too`);
});

test('dungeon quests started or handed in inside the dungeon name the NPC there, and the instance it stands in', () => {
	const q = (id) => corrections.quests[id] && corrections.quests[id].set;
	const inst = (id) => corrections.npcs[id] && corrections.npcs[id].set.instances;
	assert.deepEqual([q(95250).start.npc, q(95250).end.npc, inst(265701)], [[265701], [265701], [2999]], 'Abominable Creatures: Captain Truman, Ruins of Lordaeron');
	assert.deepEqual([q(96987).start.npc, q(96987).end.npc, inst(268743)], [[268743], [268743], [2959]], 'Opportunistic Education: Rexxie Copperclutch, City of Dalaran');
	assert.deepEqual([q(95647).end.npc, q(95647).objectives, inst(262681)], [[262681], [{ type: 'talk', id: 262681, count: 1, text: 'Ardin Grassman' }], [2998]], 'Lost in the Thicket Things: handed in to Ardin Grassman inside, not Caitlin');
	assert.deepEqual([q(95772).end.npc, inst(262465)], [[262465], [2998]], 'Songblade Search: handed in to Daewyn Songblade inside, not Dorin');
	assert.deepEqual(blockingPrereqs({ id: 95795, ...q(95795) }), { all: [], any: [95772] }, 'Fallen in the Fen: from Daewyn, after Songblade Search');
	assert.deepEqual(q(95795).start.npc, [262465]);
	assert.deepEqual(blockingPrereqs({ id: 95809, ...q(95809) }), { all: [], any: [95647] }, 'Heartwoven: from Ardin, after Lost in the Thicket Things');
	assert.deepEqual(q(95809).start.npc, [262681]);
	assert.deepEqual(q(98824).objectives, [{ type: 'item', id: 287959, count: 1, text: 'Titan Relic' }], "Prehistoric Prism: the relic Whelgar hands over, not Lost Relic Carry's");
});

test('Dalaran Patrols waits for both Prison Break In and Key to the City, Shrewd Negotiations for Heart of Disruption (#1837)', () => {
	const blocks = (id) => blockingPrereqs({ id, start: { npc: [2410] }, ...corrections.quests[id].set });
	assert.deepEqual(blocks(545), { all: [544, 93680], any: [] }, 'Magus Wordeen Voidglare: Dalaran Patrols');
	assert.deepEqual(blocks(97287), { all: [], any: [96984] }, 'Magus Wordeen Voidglare: Shrewd Negotiations');
});

test('Daniel Stitchsong stands at the reported Three Corners spot in live coordinates (#1966)', () => {
	assert.deepEqual(corrections.npcs[256734]?.addSpawns, {
		1433: { f: 'l', pts: [[9.96, 72.71]] },
	}, 'replace the old Redridge point rather than keeping it as another destination');
});

// rockzors (#1235), JonnyDisco (#1250): Image of Archmage Modera offers Heart of Disruption only once the level 30 lead-in
// is handed in to her: An Alarming Request (92432) for the Alliance, Blood in the Streets (92434) for the Horde. The data
// had the lead-ins as optional, so the City of Dalaran pick-up guide sent level 28 characters to Silverpine for nothing.
test('Heart of Disruption waits for An Alarming Request (Alliance) and Blood in the Streets (Horde) (#1235, #1250)', () => {
	const blocks = (id) => blockingPrereqs({ id, start: { npc: [269127] }, ...corrections.quests[id].set });
	assert.deepEqual(blocks(92458), { all: [], any: [92432] }, 'Alliance: after An Alarming Request');
	assert.deepEqual(blocks(96984), { all: [], any: [92434] }, 'Horde: after Blood in the Streets');
});

test('class quests the data left open are locked to their class, and Magma or Lava? is open to everyone (class-quest card)', () => {
	const classes = (id) => corrections.quests[id] && corrections.quests[id].set.classes;
	assert.deepEqual([78261, 78307].map(classes), [8, 8], 'The Horn of Xelthos: Rogue');
	assert.equal(classes(93797), 128, 'Boughs in the Wind: Mage');
	assert.deepEqual([98341, 98404, 98738].map(classes), [1024, 1024, 1024], 'the Great Windborne Cat Spirit chain: Druid');
	const lava = corrections.quests[84396].set;
	assert.ok('classes' in lava && lava.classes === null, 'Magma or Lava?: no class limit');
	assert.ok('races' in lava && lava.races === null, 'Magma or Lava?: no race limit');
	assert.deepEqual(lava.end, { npc: [5497, 7825], object: [] }, 'its enders stay');
});

// #1490: The Great Outdoors' corrections gave it The Adventurer as its prerequisite, but the quest data also names The
// Adventurer as its breadcrumb (The Great Outdoors' `breadcrumbs`, The Adventurer's `breadcrumbFor`), and a breadcrumb
// never blocks, so the Codex had no prerequisite. Players' recordings: every Great Outdoors giver refuses it until The
// Adventurer is handed in. The corrections clear both breadcrumb links, so the prerequisite stands over the data's.
test('The Great Outdoors waits for The Adventurer, whatever breadcrumb links the data has (#1490)', () => {
	const pairs = { 95998: 96627, 96101: 96638, 96604: 96652, 96605: 96659, 96606: 96630, 96607: 96656, 96608: 96628 };
	for (const [g, a] of Object.entries(pairs).map(([g, a]) => [Number(g), a])) {
		const ge = corrections.quests[g];
		const ae = corrections.quests[a];
		assert.ok(ge && ae, `corrections for ${g} and ${a}`);
		// The records as the merged data has them (questie: breadcrumb links both ways), with the corrections applied.
		const quest = { id: g, start: { npc: [1] }, breadcrumbs: [a], ...ge.set };
		const adventurer = { id: a, start: { npc: [2] }, breadcrumbFor: g, ...ae.set };
		const { all, any } = blockingPrereqs(quest, (id) => (id === a ? adventurer : null));
		assert.deepEqual({ all, any }, { all: [], any: [a] }, `${g} after ${a}`);
	}
});

// Gnomeregan's pick-up guide (a Discord report, 2026-11-13): The Day After came into the log but was never handed in,
// so Ozzie Togglevolt had no Gnogaine to give. The quest data names The Day After as Gnogaine's prerequisite and as its
// breadcrumb, and a breadcrumb never blocks; players' recordings: all 28 people who took Gnogaine handed The Day After
// in first. The corrections clear the breadcrumb links, so the prerequisite stands and the guide hands it in on the way.
test('Gnogaine waits for The Day After, whatever breadcrumb links the data has (Gnomeregan pick-up)', () => {
	const quest = { id: 2926, start: { npc: [1268] }, pre: [2927], breadcrumbs: [2927], ...corrections.quests[2926].set };
	const dayAfter = { id: 2927, start: { npc: [6569] }, breadcrumbFor: 2926, ...corrections.quests[2927].set };
	const { all, any } = blockingPrereqs(quest, (id) => (id === 2927 ? dayAfter : null));
	assert.deepEqual({ all, any }, { all: [], any: [2927] });
});

// The 1.0.13 quest database's trace XP against our data (2026-11-08): 45 quests differed, every one confirmed by
// players' recorded hand-ins at a full-XP level, but for Harvesting the Harvesters (92911): one hand-in in the 2026-11-08
// count and none in the recordings archive now, so it stays as the data has it until a second source agrees. The corrections hold the recorded values, so the level model gets them.
test('quest XP the recordings confirm is held by the corrections (1.0.13 trace XP check)', () => {
	const xp = {
		91723: 525, 91732: 320, 91740: 875, 91745: 25, 91758: 35, 91772: 360, 92750: 120, 92751: 120, 95495: 140, 95507: 1000,
		95508: 1350, 95805: 360, 96130: 340, 96139: 1400, 96241: 2350, 96259: 2350, 96260: 1750, 96825: 550, 96874: 850, 97242: 110,
		97246: 110, 97249: 110, 97253: 1050, 97282: 850, 97326: 550, 97914: 625, 97926: 625, 97944: 270, 98094: 1000, 98251: 1400,
		98252: 925, 98298: 1150, 98319: 350, 99048: 80, 99049: 390, 99052: 1100, 99080: 875, 99082: 90, 99108: 270, 99127: 480,
		99131: 65, 99143: 480, 99159: 350, 99160: 525,
	};
	const got = Object.fromEntries(Object.keys(xp).map((q) => [q, corrections.quests[q] && corrections.quests[q].set.xp]));
	assert.deepEqual(got, Object.fromEntries(Object.entries(xp).map(([q, v]) => [q, v])));
});

test('Call of Fire has its third giver, The Horn of Xelthos its horn, and A Simmering Storm\'s chain stays Horde only (1.0.13 review)', () => {
	assert.deepEqual(corrections.quests[94449].set.start.npc, [258098, 258113, 257446], 'Teo Hammerstorm in Dun Morogh gives Call of Fire too');
	assert.deepEqual(corrections.quests[78261].set.objectives, [{ type: 'item', id: 210183, count: 1, text: 'Horn of Xelthos' }]);
	for (const q of [97281, 97282]) assert.equal(corrections.quests[q] && corrections.quests[q].set.races, 8589934770, `${q}: Horde races`);
});

test('QuestieDB 1.0.14 race lists narrower than the server keep the server\'s races: Zephras Isle, both Skyborne, the Horde Skyborne village, Call of Fire, the Horde Shaman chain', () => {
	const races = (id) => (corrections.quests[id] && 'races' in corrections.quests[id].set ? corrections.quests[id].set.races : undefined);
	const SKYBORNE = 2 ** 32 + 2 ** 33;
	const HORDE = 2 + 16 + 32 + 128 + 2 ** 33;
	const ALLIANCE = 1 + 4 + 8 + 64 + 2 ** 32;
	const zephras = [92460, 92461, 92462, 92463, 92472, 92516, 92550, 92553, 92682, 92685, 93160, 93165, 93317, 93320, 93926, 93951, 94486, 94489, 94568, 94897, 96101];
	assert.deepEqual(zephras.filter((id) => races(id) !== null), [], 'the Zephras Isle quests both Skyborne starts take have no race limit');
	assert.deepEqual([92474, 94003, 94006, 98404].map(races), [SKYBORNE, SKYBORNE, SKYBORNE, SKYBORNE], 'Alliance and Horde Skyborne');
	assert.deepEqual([92514, 92595].map(races), [HORDE, HORDE], "Welcome to Shen'dar Village and The Windshapers: the Horde, not Tauren only");
	assert.deepEqual([94449, 94466, 94467, 94468, 97916].map(races), [ALLIANCE, ALLIANCE, ALLIANCE, ALLIANCE, ALLIANCE], 'Call of Fire and Camping 101: Blacksmithing: the Alliance');
	assert.deepEqual([79361, 79442, 79365].map(races), [HORDE, HORDE, HORDE], 'the Horde Shaman Call of Air chain: Horde Skyborne Shamans too');
});

// #1832: The Drowned City's quests came with QuestieDB 1.0.14, some givers and enders only through Factoruide; players'
// recordings agree on every one, so the corrections hold them (a later quest data scrape can't drop them).
test("The Drowned City's quests keep the givers and enders players use (#1832)", () => {
	const ends = (id) => {
		const entry = corrections.quests[id];
		assert.ok(entry, `a correction for ${id}`);
		return [entry.set.start.npc, entry.set.end.npc];
	};
	for (const [id, giver, ender, who] of [
		[95775, 2519, 2519, "Kin'weelay: The Drowned City"],
		[95776, 2464, 2464, "Commander Aggro'gosh: The Only Good Brinescale..."],
		[95786, 739, 2277, 'Brother Nimetz to Loremaster Dibbs: An Acquaintance in Southshore'],
		[95787, 2277, 2277, 'Loremaster Dibbs: Take Two With Water'],
		[95788, 2277, 2277, 'Loremaster Dibbs: Magics of the Drowned City'],
		[95789, 773, 773, 'Krazek: Shady Saltseers'],
		[95791, 773, 773, 'Krazek: The Saltseer Captain'],
		[96774, 264074, 264074, "Mazu'kon: Ancient Gurubashi Idol"],
		[97130, 31439, 31439, 'Archmage Timear: Ancient Gurubashi Secrets'],
	]) assert.deepEqual(ends(id), [[giver], [ender]], who);
});

// #1832: players are offered Loremaster Dibbs's two Drowned City quests only once they hand him An Acquaintance in
// Southshore, which Brother Nimetz offers when Troll Witchery is handed in; The Only Good Brinescale... only once
// Enemies in the Water is handed in. Without them the pick-up guide sent players to givers who don't offer the quest.
test("The Drowned City's quests wait for their lead-ins, so the pick-up guide takes those first (#1832)", () => {
	const blocks = (id, npc) => {
		const entry = corrections.quests[id];
		assert.ok(entry, `a correction for ${id}`);
		return blockingPrereqs({ id, start: { npc: [npc] }, ...entry.set });
	};
	for (const [id, npc, any, who] of [
		[95786, 739, [205], 'An Acquaintance in Southshore after Troll Witchery'],
		[95787, 2277, [95786], 'Take Two With Water after An Acquaintance in Southshore'],
		[95788, 2277, [95786], 'Magics of the Drowned City after An Acquaintance in Southshore'],
		[95776, 2464, [95773], 'The Only Good Brinescale... after Enemies in the Water'],
	]) assert.deepEqual(blocks(id, npc), { all: [], any }, who);
});

// The Drowned City's follow-ups (QuestieDB 1.0.16): players are offered them only when they hand the dungeon quest
// in, never while it is still in the log. Without the prerequisite the dungeon's hand-in guide, which looks for the
// quests a hand-in opens, never offered them at the turn-in.
test("The Drowned City's follow-ups come with the dungeon quests' hand-ins, so the hand-in guide offers them", () => {
	const blocks = (id, npc) => {
		const entry = corrections.quests[id];
		assert.ok(entry, `a correction for ${id}`);
		return blockingPrereqs({ id, start: { npc: [npc] }, ...entry.set });
	};
	for (const [id, npc, any, who] of [
		[96078, 2519, [95775], "A Tale Spun Around the Fire after The Drowned City (Kin'weelay)"],
		[95798, 2277, [95788], 'The Web of Magic after Magics of the Drowned City (Loremaster Dibbs)'],
		[95799, 2277, [95787], "Findings for the Explorer's League after Take Two With Water (Loremaster Dibbs)"],
	]) assert.deepEqual(blocks(id, npc), { all: [], any }, who);
});

// Strange Pylons (Shen'dralas, QuestieDB 1.0.16): the quest log lists one line per pylon, the western one first;
// the merged data had only the temple's, as line 1, so a goal tied to line 1 would count the western pylon.
test("Strange Pylons keeps the quest log's three pylon lines in their order (Shen'dralas)", () => {
	const entry = corrections.quests[92914];
	assert.ok(entry, 'a correction for 92914');
	const lines = entry.set.objectives;
	assert.deepEqual(lines.map((o) => o.text), ['Western pylon found', 'Eastern pylon found', 'Temple pylon found']);
	assert.ok(lines.every((o) => o.type === 'event' && o.count === 1 && o.map === 2652), 'three events on the Shen\'dralas map');
});

test('Open the Maw waits for Dragonmaw Rumors, so the Excavation Site pick-up guide takes Zaruk\'s lead-in first (#1939)', () => {
	const entry = corrections.quests[95682];
	assert.ok(entry, 'a correction for 95682');
	assert.deepEqual(blockingPrereqs({ id: 95682, start: { npc: [13155] }, ...entry.set }), { all: [], any: [95663] });
});

test('every Camping 101 profession quest asks for the skill at 20, not a talk with the trainer (#1952)', () => {
	const ids = [96031, 96044, 96045, 96046, 96047, 96050, 96055, 96056, 96057, 96058, 96059, 96102, 97899, 97900, 97901, 97902, 97903,
		97904, 97905, 97906, 97907, 97908, 97915, 97916, 97917, 97918, 97919, 97920, 97921, 97922, 97923, 97924, 97925, 97927, 97928,
		97929, 97930, 97931, 97932, 97933, 97934, 97935, 97936, 97937, 97938, 97939, 97940, 97941, 97942, 97943, 97944, 97946, 97948,
		97949, 97950, 97951, 97952, 97953, 97954, 97955, 97956, 97957, 97958, 97959, 97960, 97961, 97963, 97964, 97965, 97967, 97968,
		97969, 97970, 97971, 97972, 97973, 98284, 98285, 98286, 98287];
	const bad = ids.filter((id) => {
		const objs = corrections.quests[id] && corrections.quests[id].set.objectives;
		return !(objs && objs.length === 1 && objs[0].type === 'event' && /^Raise your [a-z ]+ skill to 20$/.test(objs[0].text));
	});
	assert.deepEqual(bad, []);
});

// The 0.3.8 XP review (players' recorded hand-ins at a full-XP level, builds 70790-70888): three quests whose
// data value no recorded hand-in pays. The Grand Betrayal's earlier correction held the 70170 build's value.
test('quest XP the recordings confirm is held by the corrections (0.3.8 XP review)', () => {
	const xp = { 421: 875, 2929: 6200, 96261: 3050 };
	const got = Object.fromEntries(Object.keys(xp).map((q) => [q, corrections.quests[q] && corrections.quests[q].set.xp]));
	assert.deepEqual(got, Object.fromEntries(Object.entries(xp).map(([q, v]) => [q, v])));
	assert.deepEqual(corrections.quests[96261].set.preAny, [96259], "The Broodmother's prerequisite stays");
});

// #1820: Nearby services' "Bows & guns" at Grom'gol led to Innkeeper Thulbek (5814), who sells food, drink and
// fish only (the Forever TDB's vendor list, 4 people's recorded merchant windows). pfQuest alone listed him as a
// vendor of Hunter's Boomstick (2511) and a repairer. Sweep over every Codex `sells:ranged` and `repair` NPC
// (TDB, QuestieDB 1.0.14, recorded windows): he is the only spawned one.
test('Innkeeper Thulbek sells no bow or gun and does not repair (#1820)', () => {
	assert.deepEqual(corrections.items[2511].removeVendors, [5814]);
	assert.deepEqual(corrections.npcs[5814].set.roles, ['innkeeper', 'vendor']);
});

test('the release data and Codex give Innkeeper Thulbek no Bows & guns or repair role (#1820)', (t) => {
	const dir = path.join(__dirname, '..', 'data', 'forever');
	if (!fs.existsSync(path.join(dir, 'items.json'))) return t.skip('no data/forever');
	const read = (f) => JSON.parse(fs.readFileSync(path.join(dir, f), 'utf8'));
	assert.ok(!read('items.json')[2511].vendors.includes(5814), "Hunter's Boomstick: not sold by him");
	assert.deepEqual(read('npcs.json')[5814].roles, ['innkeeper', 'vendor']);
	const codex = path.join(dir, 'codex', 'npcs.json');
	if (fs.existsSync(codex)) assert.deepEqual(JSON.parse(fs.readFileSync(codex, 'utf8'))[5814].roles, ['innkeeper', 'sells:food', 'vendor']);
});

// #1997: Lightforge Ingots (526) follows The Lost Ingots (324). The merged data listed 526 in 324's `excl`, so 324
// blocked nothing and the Codex gave 526 no prerequisite: Lookup's pick-up guide sent players to Glorin Steelbrow
// before the chain. The Forever TDB has no exclusive group for either.
test('Lightforge Ingots waits for The Lost Ingots, which does not close it (#1997)', () => {
	const lost = { id: 324, start: { object: [2734] }, preAny: [321], excl: [526], ...corrections.quests[324].set };
	const ingots = { id: 526, start: { npc: [1217] }, ...corrections.quests[526].set };
	assert.deepEqual(blockingPrereqs(ingots, (id) => (id === 324 ? lost : null)), { all: [], any: [324] });
});

// #2010: Nearby's stable master search named one on another continent to a Skyborne Hunter on Zephras Isle. Seven
// Forever NPCs whose title reads Stable Master (Genn Fairweather at the Fairweather Stables in Valanaar among them)
// had no stable master role in the merged data. Sweep: every spawned NPC titled stable master in data/forever.
test('every stable master by title has the stable master role (#2010)', () => {
	for (const id of [43408, 256410, 256673, 259190, 259859, 260525, 265756]) {
		assert.ok(corrections.npcs[id] && corrections.npcs[id].set.roles.includes('stablemaster'), `npc ${id}`);
	}
	assert.deepEqual(corrections.npcs[265756].set.roles, ['repair', 'stablemaster', 'trainer', 'vendor'], 'Genn Fairweather keeps his other roles');
});

// #2199: Fiery Menace! counts npc 5858, which the game calls the Searing Lava Spider ("Searing Lava Spider slain" in the
// quest log, each tick a kill of 5858); the merged data kept its Classic name, Greater Lava Spider, so the step named a
// spider no one sees. Sweep (the names of quest NPCs where the client's own name differs from the data's): Velarok
// Windblade (8479), whose Divine Retribution reads "Velarok Story", was still Kalaran Windblade on his goals.
test('the Searing Lava Spider and Velarok Windblade have the names the game shows (#2199)', () => {
	assert.equal(corrections.npcs[5858].set.name, 'Searing Lava Spider');
	assert.equal(corrections.npcs[8479].set.name, 'Velarok Windblade');
	assert.ok(!corrections.npcs[5857], 'npc 5857 keeps its own name');
});

// #1575 (danger gate census): QuestieDB places Infernal 278863, a level 30 elite, at 133 points in the starting zones
// and capitals. No player has met it or died to it there, while 337 people's recordings logged other creatures within
// 40 yd of those points; the danger gate flagged the starting zones' quests, and the compiler's "Elite: group advised"
// (an object's work among hostile elites) would mark For Honor and An Enticing Offer. It stands nowhere.
test('Infernal 278863 stands nowhere players go: no spawns (#1575)', () => {
	assert.deepEqual(corrections.npcs[278863].set, { spawns: {} });
});
