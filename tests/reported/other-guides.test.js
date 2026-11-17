'use strict';
// Player-reported guide fixes: the profession, reputation, collectible, miscellaneous and legacy guides, and Shen'dralas.
// tests/reported/helpers.js says what the cases check and where a new one goes.

const { test } = require('node:test');
const assert = require('node:assert/strict');
const fs = require('node:fs');
const path = require('node:path');
const {
	allGuides, at, CENTAURS, compiled, dist, engineRun, goals, is, makeProjector, needs, OFFICIAL_DIR, refData, runAddon,
	skip, SOURCES, TAUREN_WARRIOR_40, yards,
} = require('./helpers');

const { loadWeb } = require('../../tools/lib/codex/web');

// The same pattern everywhere: where the zone maps overlap, the data spawns an
// NPC or object at one spot on both maps, and the step's zone picks the map.
// A goal on the map of a zone Forever's quest data does not list it in, while
// the data has it at that spot on a map of one it lists, routes the player
// standing beside it through the crossing to the other zone and back (the
// travel planner takes the target's zone from its map). Drops count when no
// dropper is listed in the goal's zone. Needs Forever's list cache
// (data/sources/web/codex, `polestar codex build`).
const NEIGHBOUR_MAP = new Set([
	// The optional hand-in at Garush shares a step with the Alliance's at Pureheart in Western Plaguelands.
	'forever/reputation/argent-dawn.guide talk npc 10839',
]);
const webLists = fs.existsSync(path.join(SOURCES, 'web', 'codex', 'lists', 'npc.json'));

// --- Raider's Bow (Lyngtoft, #289): the Durotar guide sent the arrow 124 yd
// south-west of the bow, to where QuestieDB 1.0.5 had it; 1.0.6 moved it to
// 59.4,56.4, where the player found it. A quest item that lies on the ground
// at a few fixed spots is collected where one of them is: the arrow leads
// within 1 map unit of its object's spawn, both points in the same map frame
// (Augustus' Receipt Book, #423: the Un'Goro guide's 17.4,31.1 is the Era
// frame's name for the spawn the data gives as 14.04,24.22 live).
const AWAY_FROM_ITS_OBJECTS = new Set([
	// Fish from pools: the schools drift along the shore, and the step points at a stretch of it.
	'forever/professions/fishing.guide 16968',
	'forever/professions/fishing.guide 16969',
	'forever/professions/fishing.guide 16970',
]);

// --- "Ride through SW? (I am lvl 12)" (Pynte, #404): riding comes at level
// 40 (tools/lib/nav/move.js MOUNT_LEVEL), so a guide that starts below it
// never tells the player to ride somewhere. Riding a boat, zeppelin, tram,
// lift, airship, flight or Zephras Isle's wind currents is fine ("ride it"
// names the transport just before). A step gated to level 40 or more
// (`when level>=40`), or any step after a `level` goal of 40 or more, is
// played with riding learned, so it may say ride.
const RIDING_LEVEL = 40;
const RIDE_TRANSPORT = /\bride (?:it\b|(?:the |a |on the |up a |down the )?(?:boat|ferry|zeppelin|tram|Deeprun Tram|lift|elevator|airship|flight|hippogryph|gryphon|wind rider|wind current|bat|taxi))/gi;
// The title of the live step once the clan's quests are taken and the totems handed in (`before`: the world).
function centaurLive(before) {
	return engineRun(CENTAURS, TAUREN_WARRIOR_40, {
		before: `w.complete({ 93225 }); ${before}`,
		// The quest log read (a jump waits for it), then the clan task ticked.
		after: `stub.fire("QUEST_LOG_UPDATE"); stub.advance(0.6)
			for g, v in ipairs(E.GetStepView(1).goals) do if v.t == "task" then E.ToggleGoal(1, g) end end`,
		script: 'emit({ live = E.GetGuide().steps[E.GetLiveStep()].title })',
	}).live;
}

// Mouchoir (#2018, Tailoring 75-150 in Stormwind): the vendor goods step sent a player standing beside Alexandra
// Bolero (Tailoring Supplies, Mage Quarter, by the trainers) to Edna Mullby in the Trade District, 235 yards away.
// `buy … nearest` kept one seller per 250 yards, one for the whole city; on a capital city's map each district keeps
// its own, so the arrow can pick the one beside the player.
test('forever/professions/tailoring.guide: #2018, the 75-150 vendor goods can be bought from Alexandra Bolero in the Mage Quarter', { skip }, () => {
	const buys = goals('forever/professions/tailoring.guide').filter(({ goal }) => goal.t === 'buy' && [2321, 2324, 2604].includes(goal.item));
	assert.ok(buys.length >= 3, 'the Fine Thread, Bleach and Red Dye buys');
	for (const { goal } of buys) {
		const stormwind = (goal.candidates || []).filter((c) => c.map === 1453).map((c) => c.npc);
		assert.ok(stormwind.includes(1347), `item ${goal.item}: Alexandra Bolero (Mage Quarter) is one to pick: ${stormwind}`);
		assert.ok(stormwind.includes(1286), `item ${goal.item}: Edna Mullby (Trade District) stays one: ${stormwind}`);
	}
});
// The Archivist (5251) has two lines, both in Stratholme: kill Archivist Galford and burn the Scarlet Archive
// (players' recordings list "monster x1 slain; object x1 Archive Burned" at the accept). The guide worked only the
// kill, so its window went from Galford to the hand-in with the archive still to burn (lint `handin-unworked`).
test('forever/reputation/argent-dawn.guide: The Archivist burns the Scarlet Archive with Galford, before the hand-in', { skip }, () => {
	const list = goals('forever/reputation/argent-dawn.guide');
	const galford = at(list, 'kill 10811 (5251.1)', (g) => g.t === 'kill' && g.quest === 5251 && g.npc === 10811);
	const archive = at(list, 'interact 176245 (5251.2)', (g) => g.t === 'interact' && g.quest === 5251 && g.object === 176245);
	assert.equal(list[archive].s, list[galford].s, 'in the Stratholme step');
	assert.ok(archive < at(list, 'turnin 5251', is('turnin', 5251)), 'before the hand-in');
});
// Partially Digested Collar (93568) is started by the collar and counts the collar as its objective: the accept
// leaves it in the bags (players' recordings: 10 people, "item x1 Partially Digested Collar" at the accept, handed
// in to Liranne). So the Liranne step may wait on the collar and hold the accept and the hand-in together; the
// lint's gate-consumed check reads the objective and lets it be.
test('forever/40-50/shendralas.guide: Liranne\'s step keeps the collar, the objective of the quest it starts, through the hand-in', { skip }, () => {
	const st = compiled('forever/40-50/shendralas.guide').steps.find((s) => s.goals.some(is('accept', 93568)));
	assert.ok(refData().quests[93568].objectives.some((o) => o.type === 'item' && o.id === 259461), 'the collar is the quest\'s objective');
	assert.ok(st.goals.findIndex(is('accept', 93568)) < st.goals.findIndex(is('turnin', 93568)), 'accept, then the hand-in, in one step');
});

// --- Level sweep over the guides the level model doesn't play (2026-11-08): the centaur reputation guide
// opens at level 30, and its clans reach Honored on quests from level 30 and tradeable totems, but Valley of Bones and
// every quest after it (Gelkis 93034..., Magram 92841...) need level 35 (Forever's quest data and the page agree). The
// steps took them at Honored alone, so a level 30-34 player stood at a giver who offered nothing.
test('forever/reputation/centaur-clans.guide: no accept comes before the guide waits for its quest\'s level', { skip }, () => {
	const G = 'forever/reputation/centaur-clans.guide';
	let reached = compiled(G).minLevel || 1;
	for (const { goal } of goals(G)) {
		if (goal.t === 'level') reached = Math.max(reached, goal.level);
		if (goal.t === 'accept') assert.ok((goal.minLevel || 1) <= reached, `accept ${goal.quest} (from level ${goal.minLevel}) comes after the guide waits for that level (${reached})`);
	}
});

test('legacy-challenges: Return to Bodley is turned in before Back to the Beginning is taken', { skip }, () => {
	const list = goals('forever/legacy/legacy-challenges.guide');
	const bodley = at(list, 'turnin 8996', (g) => g.t === 'turnin' && g.quest === 8996);
	for (const quest of [8997, 8998]) assert.ok(bodley < at(list, `accept ${quest}`, (g) => g.t === 'accept' && g.quest === quest), `8996 before ${quest}`);
});

test('#246: no NPC or object goal is on a neighbouring zone\'s map where the two maps overlap', { skip: skip || (!webLists && 'no Forever list cache (data/sources/web/codex/lists)') }, () => {
	const wh = loadWeb(SOURCES).listed;
	refData();
	const area = (map) => refData().zone(map) && refData().zone(map).areaId;
	const world = (map, x, y, f) => {
		const fr = (f === 'e' ? refData().mapFrames.era : refData().mapFrames.forever || {})[map] || refData().eraFrame(map);
		return fr && { c: fr.c, wx: fr.top + ((fr.bottom - fr.top) * y) / 100, wy: fr.left + ((fr.right - fr.left) * x) / 100 };
	};
	const listedIn = (kind, id) => (wh[kind] && wh[kind][id] && wh[kind][id].location) || [];
	const offenders = [];
	for (const guide of allGuides()) {
		for (const { step, goal } of goals(guide)) {
			if (goal.map == null || goal.x == null) continue;
			let sources = ['npc', 'object'].filter((k) => typeof goal[k] === 'number').map((k) => [k, goal[k]]);
			if (!sources.length && goal.t === 'collect' && goal.item) {
				const drops = (refData().item(goal.item) || {}).drops || {};
				sources = ['npc', 'object'].flatMap((k) => Object.keys(drops[k] || {}).map((id) => [k, Number(id)]));
			}
			const zone = area(goal.map);
			if (!sources.length || sources.some(([k, id]) => listedIn(k, id).length === 0 || listedIn(k, id).includes(zone))) continue;
			const points = [goal, ...(goal.spots || [])].map((p) => world(goal.map, p.x, p.y, goal.f)).filter(Boolean);
			const elsewhere = sources.some(([k, id]) => refData().spawns(k, id).some((s) => s.map !== goal.map && listedIn(k, id).includes(area(s.map))
				&& s.pts.some((p) => {
					const w = world(s.map, p[0], p[1], s.f);
					return w && points.some((g) => g.c === w.c && Math.hypot(g.wx - w.wx, g.wy - w.wy) <= 60);
				})));
			const key = `${guide} ${goal.t} ${sources.length === 1 ? sources[0].join(' ') : `item ${goal.item}`}`;
			if (elsewhere && !NEIGHBOUR_MAP.has(key)) offenders.push(`${key} (step ${step.title}, map ${goal.map})`);
		}
	}
	assert.deepEqual([...new Set(offenders)], [], 'goals on the map of a zone Forever\'s quest data does not place them in');
});
test("#289: a quest item picked up from objects is collected at one of the objects' spawns", { skip }, () => {
	refData();
	const { point } = makeProjector(refData().mapFrames);
	const offenders = [];
	for (const guide of allGuides()) {
		for (const { step, goal } of goals(guide)) {
			if (goal.t !== 'collect' || goal.map == null || goal.x == null) continue;
			const item = refData().item(goal.item);
			if (!item || !item.questItem || !item.drops) continue;
			const objects = Object.keys(item.drops.object || {});
			if (!objects.length || Object.keys(item.drops.npc || {}).length) continue;
			const pts = objects.flatMap((id) => refData().spawns('object', Number(id)).filter((s) => s.map === goal.map).flatMap((s) => s.pts.map((p) => point(s.map, p[0], p[1], s.f))));
			if (!pts.length) continue;
			const near = Math.min(...[goal, ...(goal.spots || [])].flatMap((g) => {
				const q = point(goal.map, g.x, g.y, goal.f || 'l');
				return pts.map((p) => Math.hypot(p.x - q.x, p.y - q.y));
			}));
			if (near > 1 && !AWAY_FROM_ITS_OBJECTS.has(`${guide} ${goal.item}`)) offenders.push(`${guide} collect ${goal.item} @${goal.x},${goal.y} (step ${step.title}) is ${near.toFixed(2)} from its objects`);
		}
	}
	assert.deepEqual(offenders, [], 'quest items collected away from the objects that hold them');
});
test("Pynte's report (#404): guides played below riding level never tell you to ride somewhere", { skip }, () => {
	const offenders = [];
	for (const guide of allGuides()) {
		if (guide.startsWith('forever/collectibles/')) continue;
		const g = compiled(guide);
		if (!(g.minLevel < RIDING_LEVEL)) continue;
		let mounted = false;
		for (const step of g.steps) {
			const gated = (step.when || []).some((p) => p.k === 'level' && p.op === '>=' && !p.neg && p.n >= RIDING_LEVEL);
			if (!mounted && !gated) {
				for (const text of [step.note, ...step.goals.map((goal) => goal.note)]) {
					if (typeof text !== 'string') continue;
					if (/\b(?:ride|rides|riding|rode)\b/i.test(text.replace(RIDE_TRANSPORT, ''))) offenders.push(`${guide} (from level ${g.minLevel}), step ${step.title}: ${text}`);
				}
			}
			if (step.goals.some((goal) => goal.t === 'level' && goal.level >= RIDING_LEVEL)) mounted = true;
		}
	}
	assert.deepEqual(offenders, [], 'travel by riding in a guide played before level 40');
});

// dgc1980 (#563), Alliance: on Cozy Sleeping Bag's Stonetalon step the arrow
// pointed straight from the Barrens (1413 42.08,32.49) at the path into the
// Stonetalon hills, a line through Honor's Stand, the Horde post on the road
// west. Since #1813 Alliance come in from the north (the Talondeep Path), and
// every straight arrow of theirs from that waypoint to the path keeps out of
// Honor's Stand and Sun Rock Retreat, the shipped walking maps' hostile hubs.

test("forever/miscellaneous/cozy-sleeping-bag.guide: dgc1980's report (#563): Alliance keep out of Honor's Stand on the way to Stonetalon, Horde go straight", { skip }, () => {
	const list = goals('forever/miscellaneous/cozy-sleeping-bag.guide');
	const hills = at(list, 'the path into the hills', (g) => g.t === 'goto' && g.map === 1442);
	const step = list[hills].s;
	// The way in is its own step just before the hills since #1496 (skipped once in Stonetalon).
	const before = list.filter(({ s, goal }, i) => (s === step || s === step - 1) && i < hills && goal.t === 'goto');
	const side = (faction) => ({ step: st, goal }) => [st.only, goal.only].every((o) => !o || !o.factions || o.factions.includes(faction));
	const alliance = before.filter(side('Alliance'));
	const horde = before.filter(side('Horde'));
	const [hubs] = runAddon({
		stubs: ['stub_encoding.lua'],
		addons: ['Polestar_Nav'],
		script: `
local out = {}
for _, h in ipairs(PolestarPathData[1].hubs) do
	if h.id == "horde-honors-stand" or h.id == "horde-sun-rock-retreat" then
		for _, d in ipairs(h.disks) do out[#out + 1] = { d[1], d[2], d[3], h.id } end
	end
end
emit(out)`,
	}).emitted;
	for (const id of ['horde-honors-stand', 'horde-sun-rock-retreat']) assert.ok(hubs.some((d) => d[3] === id), `the walking maps know ${id}`);
	// A map point in the world frame the maps use: x north, y west.
	const world = ({ map, x, y }) => {
		const f = refData().eraFrame(map);
		return { x: f.top + ((f.bottom - f.top) * y) / 100, y: f.left + ((f.right - f.left) * x) / 100 };
	};
	// How far (yd) the line from a to b stays outside the hubs' disks.
	const clear = (a, b) => {
		const [p, q] = [world(a), world(b)];
		const dx = q.x - p.x;
		const dy = q.y - p.y;
		const l2 = dx * dx + dy * dy;
		return Math.min(...hubs.map(([x, y, r]) => {
			const t = Math.max(0, Math.min(1, ((x - p.x) * dx + (y - p.y) * dy) / l2));
			return Math.hypot(p.x + dx * t - x, p.y + dy * t - y) - r;
		}));
	};
	assert.ok(alliance.length > 0, 'Alliance get a waypoint before the path');
	const stops = [...alliance.map(({ goal }) => goal), list[hills].goal];
	for (let i = 1; i < stops.length; i++) {
		const [a, b] = [stops[i - 1], stops[i]];
		const off = clear(a, b);
		assert.ok(off > 50, `the arrow from ${a.x},${a.y} (map ${a.map}) to ${b.x},${b.y} (map ${b.map}) passes ${Math.round(off)} yd outside Honor's Stand and Sun Rock Retreat`);
	}
	assert.equal(horde.length, 0, 'Horde get none');
});

// #1813 (Alliance, Cozy Sleeping Bag): the Barrens' way into Stonetalon runs through Honor's Stand, and the road
// on to the hills past Malaka'jin and Sun Rock Retreat. Players' recordings of Stepping Stones (79192, Alliance):
// about 40 runs, most entering Stonetalon from the Barrens at 83.5,97, 7 people dead at Honor's Stand (one of them
// after the old "North of Honor's Stand" detour) and one in Sun Rock; the 3 runs by the Talondeep Path and the 3
// off the Stonetalon Peak flight lost nobody there. Alliance now come in from the north: the Talondeep Path's
// Ashenvale mouth, with no waypoint left in the Barrens.
test("forever/miscellaneous/cozy-sleeping-bag.guide: #1813: Alliance come into Stonetalon from the north, by the Talondeep Path", { skip }, () => {
	const list = goals('forever/miscellaneous/cozy-sleeping-bag.guide');
	const hills = at(list, 'the path into the hills', (g) => g.t === 'goto' && g.map === 1442);
	const plank = at(list, 'accept 79192 at the Barrens plank', (g) => is('accept', 79192)(g) && g.object === 417072);
	const alliance = list.filter(({ step, goal }, i) => i > plank && i < hills && goal.t === 'goto' && [step.only, goal.only].some((o) => o && o.factions && o.factions.includes('Alliance')));
	assert.ok(!alliance.some(({ goal }) => goal.map === 1413), 'no Alliance waypoint in the Barrens');
	const talondeep = alliance.find(({ goal }) => goal.map === 1440 && yards(goal, { map: 1440, x: 42.4, y: 71.0 }) <= 40);
	assert.ok(talondeep, "Alliance go by the Talondeep Path's Ashenvale mouth");
	assert.ok((talondeep.step.when || []).some((p) => p.k === 'zone' && p.neg && p.name === 'Stonetalon Mountains'), 'only while the character is not yet in Stonetalon');
	assert.match([].concat(talondeep.step.note || []).join(' '), /Stonetalon Peak/, 'the tip names the Stonetalon Peak flight');
});

// shatteredeagle (#1496), Alliance: the "North of Honor's Stand" safe spot was the first goal of
// the Stonetalon step, so a character already in Stonetalon (on foot or off the Stonetalon Peak
// flight) was sent 3,114 yd back to the Barrens. The way in (since #1813 the Talondeep Path) is its
// own Alliance step that applies only while the character is not yet in the Stonetalon Mountains.
test("forever/miscellaneous/cozy-sleeping-bag.guide: shatteredeagle's report (#1496): the Alliance way in only applies before Stonetalon", { skip }, () => {
	const list = goals('forever/miscellaneous/cozy-sleeping-bag.guide');
	const way = list[at(list, 'the Alliance way into Stonetalon', (g) => g.t === 'goto' && g.map === 1440)];
	const hills = list[at(list, 'the path into the hills', (g) => g.t === 'goto' && g.map === 1442)];
	assert.notEqual(way.s, hills.s, 'the way in is not a goal of the Stonetalon step');
	assert.ok((way.step.when || []).some((p) => p.k === 'zone' && p.neg && p.name === 'Stonetalon Mountains'), 'its step applies only outside the Stonetalon Mountains');
	assert.deepEqual((way.step.only || way.goal.only || {}).factions, ['Alliance'], 'Alliance only');
	assert.ok(!(hills.step.when || []).some((p) => p.k === 'zone'), 'the Stonetalon step itself applies wherever the character is');
});

// Schenkee (#1982), Orc Warlock 19 on the Savage Coast (Stranglethorn 23.52,21.41): the arrow to Westfall's
// twin note led north through Stranglethorn's level 30+ jungle and Duskwood. Players' recordings: 20 Horde
// followed Stranglethorn's west coast into Westfall, 16 took the road through Duskwood; from Grom'gol the coast is
// the shorter walk too. Horde now get a goto on the coast (about 12.5,12.7) before the Westfall hand-in, only while
// they are not in Westfall yet.
test("forever/miscellaneous/cozy-sleeping-bag.guide: Schenkee's report (#1982): Horde go to Westfall along Stranglethorn's west coast", { skip }, () => {
	const list = goals('forever/miscellaneous/cozy-sleeping-bag.guide');
	const twin = at(list, 'turnin 79007 in Westfall', is('turnin', 79007));
	const coast = list.findIndex(({ goal }) => goal.t === 'goto' && goal.map === 1434 && yards(goal, { map: 1434, x: 12.5, y: 12.7 }) <= 40);
	assert.ok(coast >= 0, "a goto on Stranglethorn's west coast");
	const way = list[coast];
	assert.equal(way.s, list[twin].s - 1, 'the step right before the Westfall hand-in');
	assert.deepEqual((way.step.only || way.goal.only || {}).factions, ['Horde'], 'Horde only');
	assert.ok((way.step.when || []).some((p) => p.k === 'zone' && p.neg && p.name === 'Westfall'), 'only while the character is not in Westfall yet');
});

test("forever/professions: Schpune's report (#620): Skinning, Mining and Herbalism are learned at level 1, from the Junior trainers in the starting zones too", { skip: skip || needs('professions.json') }, () => {
	// Junior trainers in Northshire Valley and The Den, by profession guide.
	const juniors = { skinning: [247227, 267327], mining: [247226, 267328], herbalism: [247223, 267329] };
	for (const [file, npcs] of Object.entries(juniors)) {
		const guide = `forever/professions/${file}.guide`;
		const learn = compiled(guide).steps[0];
		assert.match(learn.title, /^Learn /, `${guide}: the first step learns the profession`);
		assert.ok(!learn.goals.some((g) => g.t === 'level'), `${guide}: no level goal before Apprentice`);
		const train = learn.goals.find((g) => g.t === 'train');
		assert.equal(train.rank, 1, `${guide}: Apprentice`);
		const ids = train.candidates.map((c) => c.npc);
		for (const npc of npcs) assert.ok(ids.includes(npc), `${guide}: Junior trainer ${npc} is a candidate`);
	}
});

// --- Cozy Sleeping Bag (Hotline, #698): every quest of the chain needs level
// 14, and a level 13 Horde Paladin was sent to the Barrens for a note it could
// not take yet. Polestar holds back only Class guides at their gate by itself,
// so the guide waits for the level before each faction sets out.
test(`Hotline's report (#698): the Cozy Sleeping Bag chain waits for level 14 before either faction sets out`, { skip }, () => {
	const list = goals('forever/miscellaneous/cozy-sleeping-bag.guide');
	for (const faction of ['Alliance', 'Horde']) {
		const mine = list.filter(({ step, goal }) => [step.only, goal.only].every((o) => !o || !o.factions || o.factions.includes(faction)));
		let reached = 1;
		let accepts = 0;
		for (const { goal } of mine) {
			if (goal.t === 'level') reached = Math.max(reached, goal.level);
			if (goal.t !== 'accept') continue;
			accepts++;
			assert.ok((goal.minLevel || 1) <= reached, `${faction}: accept ${goal.quest} (from level ${goal.minLevel}) comes after the guide waits for that level`);
			reached = Math.max(reached, goal.minLevel || 1);
		}
		assert.ok(accepts > 0, `${faction}: the chain is offered`);
		assert.ok(reached >= 14, `${faction}: the chain's level 14 is reached before it starts`);
	}
});

test(`Hotline's report (#718): the Undead's Silverpine fishing step leads to Lordamere Lake, not the Great Sea coast`, { skip }, () => {
	const list = goals('forever/professions/fishing.guide');
	const arrow = list.find(({ step, goal }) => step.title === 'Fishing: Silverpine Forest (50-125)' && goal.t === 'goto');
	assert.ok(arrow, 'the Silverpine step has a waypoint');
	const { point } = makeProjector(refData().mapFrames);
	const [x, y] = refData().npcs[6570].spawns[1421].pts[0];
	const ferry = point(1421, x, y, refData().npcs[6570].spawns[1421].f);
	assert.ok(dist(point(arrow.goal.map, arrow.goal.x, arrow.goal.y, arrow.goal.f || 'l'), ferry) < 80, 'within 80 yards of Fenwick Thatros at the Decrepit Ferry on the lake');
});

// Players' recordings (2026-11-09 pull): after Eagle's Fist (79975) on the Stonewrought Dam's ledge, most players drop
// into the river below it and follow the arrow north; 22 contributors died at its waterfall (Wetlands about 65.0,77.4),
// while those who left the river on its west bank lived and took the road over Thandol Span. The step that is live
// on the way, the next note's, says so.
test("forever/miscellaneous/cozy-sleeping-bag.guide: the step after the dam's note warns of the waterfall below it and gives the way out", { skip }, () => {
	const guide = 'forever/miscellaneous/cozy-sleeping-bag.guide';
	const list = goals(guide);
	const dam = at(list, 'accept 79975', is('accept', 79975));
	const next = list.find(({ s }) => s === list[dam].s + 1);
	assert.ok(next, 'a step follows the dam');
	const tip = [].concat(next.step.note || []).join(' ');
	assert.match(tip, /waterfall/, tip);
	assert.match(tip, /west bank/, tip);
	assert.match(tip, /Thandol Span/, tip);
});

// The same recordings (the 0.3.7 audit's waterfall row): the tip alone left players following the arrow down the
// river, and they kept dying at the waterfall (Wetlands about 65.0,77.4 and 66.7,75.1). The survivors' tracks leave
// the river at about 64.4,79.4 and go on along the west bank by 62.2,76.8; those who died turned back north-east
// into the river there. The step after the dam's note now walks that bank before the road north.
test("forever/miscellaneous/cozy-sleeping-bag.guide: off the dam's ledge the arrow leads out of the river on its west bank, before the waterfall", { skip }, () => {
	const guide = 'forever/miscellaneous/cozy-sleeping-bag.guide';
	const list = goals(guide);
	const dam = at(list, 'accept 79975', is('accept', 79975));
	const cart = at(list, 'the fallen cart', (g) => g.t === 'goto' && /cart/i.test(g.text || ''));
	const bank = list.slice(dam + 1, cart).filter(({ goal }) => goal.t === 'goto' && goal.map === 1437);
	assert.equal(bank.length, 2, 'two gotos on the Wetlands bank before the cart');
	assert.ok(yards(bank[0].goal, { map: 1437, x: 64.4, y: 79.4 }) <= 20, 'first where the survivors leave the river');
	assert.ok(yards(bank[1].goal, { map: 1437, x: 62.2, y: 76.8 }) <= 20, 'then along the west bank');
	for (const fall of [{ map: 1437, x: 65.0, y: 77.4 }, { map: 1437, x: 66.7, y: 75.1 }]) {
		for (const { goal } of bank) assert.ok(goal.x < fall.x, `${goal.x},${goal.y} lies west of the waterfall at ${fall.x},${fall.y}`);
	}
});

// Schenkee (#1994): a Horde player walks east through Hillsbrad to the Stonewrought Dam, and the chain ends at
// Thoradin's Wall, a short ride from Tarren Mill; the walk back from the dam crosses the Wetlands and Arathi. Horde
// bind at Tarren Mill on the way, unless already bound there or past it; the arrow then hearths back.
test("forever/miscellaneous/cozy-sleeping-bag.guide: #1994: Horde bind at Tarren Mill on the way to the dam", { skip }, () => {
	const list = goals('forever/miscellaneous/cozy-sleeping-bag.guide');
	const home = at(list, 'the Tarren Mill bind', (g) => g.t === 'sethome' && g.location === 'Tarren Mill');
	assert.ok(home > at(list, 'accept 79974', is('accept', 79974)) && home < at(list, 'turnin 79974', is('turnin', 79974)), 'between Wet Job\'s accept and the dam');
	const { step, goal } = list[home];
	assert.deepEqual(step.only, { factions: ['Horde'] });
	assert.equal(goal.npc, 2388, 'Innkeeper Shay');
	const when = step.when.map((w) => `${w.neg ? '!' : ''}${w.k} ${w.name}`);
	assert.deepEqual(when, ['!bound Tarren Mill', '!zone Loch Modan', '!zone Wetlands']);
});

test('Centaur reputation: Buying Friendship of either clan alone picks the clan, Gelkis first, and the totems come first', { skip }, () => {
	const list = goals(CENTAURS);
	for (const [totems, bf] of [[93224, 93226], [93224, 93227], [93225, 94872], [93225, 94873]]) {
		assert.ok(at(list, `turnin ${totems}`, is('turnin', totems)) < at(list, `accept ${bf}`, is('accept', bf)), `${totems} before ${bf}`);
	}
	assert.equal(centaurLive('w.onQuest(94872, {})'), 'Magram Village: Warug and Gorhak', 'Buying Friendship: Magram alone');
	assert.equal(centaurLive('w.complete({ 1367 })'), 'Magram Village: Warug and Gorhak', 'Magram Alliance handed in');
	// Gelkis Buying Friendship without the choice quest: the Gelkis half asks for Gelkis Alliance first, which
	// Uthek's quests need (the playtest stuck at the Kolkar camps without it).
	assert.equal(centaurLive('w.onQuest(94872, {}); w.onQuest(94873, {})'), 'Gelkis: the choice quest', 'both clans: the Gelkis');
	assert.equal(centaurLive('w.onQuest(94873, {})'), 'Gelkis: the choice quest', 'Buying Friendship: Gelkis alone');
	assert.equal(centaurLive('w.onQuest(1368, {})'), 'Gelkis Village: Uthek and Molkar');
});

test('Centaur reputation: a Gelkis player at the end of the Gelkis half goes to the recipes, not the Magram half', { skip }, () => {
	const list = goals(CENTAURS);
	const router = list.find(({ step }) => step.title === 'Gelkis done').step;
	const to = (q) => router.skipto.some((k) => k.to === 'recipes' && [].concat(k.when.q).includes(q));
	for (const q of [1382, 93227, 1368, 94873]) assert.ok(to(q), `${q} handed in or carried: the recipes`);
	assert.ok(list.findIndex(({ step }) => step === router) < list.findIndex(({ step }) => step.label === 'magram'), 'before the Magram half');
});

// Plan audit D36: the Darkspear Islands bases each have the side's mark taker beside the portal. The Horde Warbringer
// stands at the Merchant Coast (64.77,35.1, QuestieDB 1.0.14; 23 people met him on the map, 8 opened his window
// there); the Alliance Brigadier General at Northwatch Hold (63.64,58.64, the npcs correction: 4 people and the
// collector). The data had neither, so the arrow went to Mor'shan and Refuge Pointe and the tips named those.
test('Darkspear Islands Reputation: the mark quests point at the Warbringer and the Brigadier General beside each base\'s portal', { skip }, () => {
	const G = 'forever/reputation/darkspear-islands.guide';
	const list = goals(G);
	for (const [npc, quests, x, y] of [
		[15350, [98887, 98889, 98891, 98893], 64.8, 35.1],
		[15351, [98895, 98897, 98899, 98901], 63.6, 58.6],
	]) {
		const at = list.filter(({ goal }) => (['accept', 'turnin'].includes(goal.t) && quests.includes(goal.quest)) || (goal.t === 'talk' && goal.npc === npc));
		assert.equal(at.length, 12, `npc ${npc}: 4 accepts, 4 turn-ins and 4 reputation talks`);
		for (const { goal } of at) {
			assert.ok(goal.map === 1413 && Math.abs(goal.x - x) < 0.5 && Math.abs(goal.y - y) < 0.5, `npc ${npc} ${goal.t} ${goal.quest || ''}: at the base (${goal.map} ${goal.x},${goal.y})`);
		}
	}
	const src = fs.readFileSync(path.join(OFFICIAL_DIR, G), 'utf8');
	assert.doesNotMatch(src, /The nearest stand at Mor'shan/);
	assert.equal((src.match(/One stands here at the Merchant Coast, beside the portal/g) || []).length, 4);
	assert.equal((src.match(/One stands here at Northwatch Hold, beside the portal/g) || []).length, 4);
});

// Profession guides built on Forever's own recipe and trainer data. Conjure and Piggyslam (#190, #297): Minor Healing
// Potion is a First Aid recipe on Forever, so Alchemy 1-75 is Elixir of Minor Defense. twisted (#1958): Thick Leather is
// taught from 175; the guide crafted it from 155, and it is gathered or bought instead. Quiz (#1808): Enchant Boots -
// Lesser Agility (160) is taught by the Expert trainers only, Kitta Firewind and Hgarth.
test('#190, #297, #1958, #1808: profession guides craft and learn what Forever\'s trainers teach', { skip }, () => {
	const alchemy = goals('forever/professions/alchemy.guide');
	assert.ok(!alchemy.some(({ goal }) => goal.spell === 2330), 'no Minor Healing Potion in Alchemy');
	const first = alchemy.find(({ goal }) => goal.t === 'craft' && goal.untilSkill);
	assert.equal(first.goal.spell, 7183, 'Alchemy 1-75 is Elixir of Minor Defense');
	const leather = goals('forever/professions/leatherworking.guide');
	assert.ok(!leather.some(({ goal }) => goal.t === 'craft' && goal.item === 4304), 'Thick Leather is never crafted');
	const enchanting = goals('forever/professions/enchanting.guide');
	const { goal } = enchanting[at(enchanting, 'learn 13637', (g) => g.t === 'learn' && g.spell === 13637)];
	assert.deepEqual(goal.candidates.map((c) => c.npc).sort((a, b) => a - b), [11072, 11074], 'Kitta Firewind and Hgarth only');
});

// Item-started quests whose item comes from an earlier step (the "lost item" persona sweep, 0.4.1): a player who
// skipped that step, or lost or sold the item, was held at an accept nothing at that place can start. The accept is
// a step of its own, shown only with the item in the bags; the quest's later goals there need it, so they drop out by
// its prerequisite. The accept uses the item up, so nothing follows it in its step.
for (const [guide, quest, item] of [
	['forever/collectibles/pets/mechanical-chicken.guide', 2766, 8705],
	['forever/collectibles/pets/mechanical-chicken.guide', 351, 8623],
	['forever/collectibles/pets/mechanical-chicken.guide', 485, 8704],
	['forever/reputation/stormwind.guide', 91741, 247834],
]) {
	test(`${guide}: the item-started accept of ${quest} shows only with item ${item} in the bags`, { skip }, () => {
		const { steps } = compiled(guide);
		const at = steps.filter((st) => st.goals.some(is('accept', quest)));
		assert.equal(at.length, 1, `one accept of ${quest}`);
		const [st] = at;
		assert.ok((st.when || []).some((p) => p.k === 'has' && !p.neg && p.item === item), `"${st.title}" shows only with item ${item}`);
		assert.deepEqual(st.goals.map((g) => `${g.t} ${g.quest}`), [`accept ${quest}`], `"${st.title}" holds only the accept`);
		const rest = steps.find((s) => s !== st && s.goals.some(is('turnin', quest)));
		assert.ok(rest && !(rest.when || []).some((p) => p.k === 'has'), `${quest}'s hand-in step needs no item gate: it needs the accept`);
	});
}
// Companion pets from a quest (0.4.1 persona sweep): a player who did the quest before the guide, or used the cage
// right after the hand-in, was held at "Collect <pet>". The hand-in step shows only while the quest is not handed in;
// the Mechanical Chicken's only with the three rescues handed in, since An OOX of Your Own needs them.
for (const [guide, quest, pet, needs] of [
	['forever/collectibles/pets/mechanical-chicken.guide', 3721, 10398, [2767, 648, 836]],
	['forever/collectibles/pets/smolderweb-carrier.guide', 4862, 12529, []],
	['forever/collectibles/pets/worg-carrier.guide', 4729, 12264, []],
	['forever/collectibles/pets/spectral-bear-cub.guide', 96383, 277714, []],
]) {
	test(`${guide}: the pet's step shows only while ${quest} is still to hand in`, { skip }, () => {
		const { steps } = compiled(guide);
		const st = steps.find((s) => s.goals.some((g) => g.t === 'collect' && g.item === pet));
		assert.ok(st && st.goals.some(is('turnin', quest)), 'the pet is collected on its quest\'s hand-in step');
		const when = st.when || [];
		assert.ok(when.some((p) => p.k === 'turnedin' && p.neg && [].concat(p.q).includes(quest)), `only while ${quest} is not handed in`);
		for (const q of needs) assert.ok(when.some((p) => p.k === 'turnedin' && !p.neg && [].concat(p.q).includes(q)), `and only once ${q} is`);
	});
}
