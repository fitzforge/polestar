'use strict';
// "Pick up the quests" for a dungeon (addon/Polestar/Dungeons/Pickup.lua over
// Lookup's guide machinery): which of a page's quests this character can take
// before the run, their open prerequisites first, the givers on a travel route
// from where the player stands, the entrance last; the guide opens in a new
// tab, comes back after /reload, and plays to the end in the real engine.
// Each quest's giver link points at the first prerequisite still to do.
//
// The Codex and the page are the synthetic tests/fixtures/codex/dungeon-pickup.json:
// Shadowfang Keep (levels 22-30) for a Horde character with
//   1098 Deathstalkers in Shadowfang   Hadrec, Silverpine (done in most runs)
//   1740 The Orb of Soran'ruk          Doan Karhan, The Barrens, Warlock only
//   1013 The Book of Ur                Keeper Bel'dugur, Undercity (in the log)
//   1014 Arugal Must Die               Dalar, Silverpine, after 1011, which needs one
//                                      of 1009 (Alliance) or 1010 (Bethor Iceshard,
//                                      Undercity, turned in to Renferrel, Silverpine)
//   1016 Return to Dalar               a follow-up of 1014: taken after the run
//   1999 Wolves at the Wall            Tauren only
//   1806 The Test of Righteousness     Alliance Paladin

const { test, before, after } = require('node:test');
const assert = require('node:assert/strict');
const fs = require('node:fs');
const path = require('node:path');
const { runAddon } = require('./helpers/lua');
const { writeCodexPack } = require('./helpers/codex');
const { SIMULATE, luaValue } = require('../tools/lib/playtest');
const { buildJournal, emitJournal } = require('../tools/lib/codex/journal');

const { codex, inputs } = JSON.parse(fs.readFileSync(path.join(__dirname, 'fixtures', 'codex', 'dungeon-pickup.json'), 'utf8'));
const ADDON = { name: 'Polestar', files: ['Core/Core.xml', 'Lookup/Lookup.xml', 'Dungeons/Dungeons.xml'] };
const KEY = 'shadowfang-keep';
const GID = `lookup/pickup/${KEY}`;
const UNDERCITY = [1458, 66, 44];
const BARRENS = [1413, 50, 57];

// The stub world draws the fixture's maps with the bounds of their Era frames.
const MAPS = Object.entries(codex.frames)
	.map(([id, f]) => `w.addMap(${id}, { name = ${JSON.stringify(codex.zones[id].name)}, c = ${f.c}, left = ${f.left}, right = ${f.right}, top = ${f.top}, bottom = ${f.bottom} })`)
	.join('\n');

let pack;
before(() => {
	pack = writeCodexPack(codex, { extraFiles: emitJournal(buildJournal(inputs, codex)) });
});
after(() => pack && pack.cleanup());

// The guide's steps as { title, goals: "verb:quest ..." }.
const DESCRIBE = `
local function describe(g)
	local out = {}
	for i, s in ipairs(g and g.steps or {}) do
		local verbs = {}
		for j, goal in ipairs(s.goals) do verbs[j] = goal.t .. (goal.quest and (":" .. goal.quest) or "") end
		out[i] = { title = s.title, goals = table.concat(verbs, " ") }
	end
	return out
end
local function tabIds()
	local ids = {}
	for i, t in ipairs(Polestar.Engine.GetTabs()) do ids[i] = t.guideId end
	return ids
end
`;

function run(script, { level = 21, race = 'Scourge', faction = 'Horde', cls = 'WARLOCK', at = UNDERCITY, done = [1098], log = [1013], ready = [], saved, codexPack = pack } = {}) {
	return runAddon({
		stubs: ['stub_world.lua'],
		before: `${codexPack.stubLua}
local w = stub.world
${MAPS}
w.level, w.race, w.raceName, w.faction = ${level}, ${JSON.stringify(race)}, ${JSON.stringify(race)}, ${JSON.stringify(faction)}
w.class, w.className = ${JSON.stringify(cls)}, ${JSON.stringify(cls)}
${at ? `w.moveTo(${at.join(', ')})` : ''}
w.complete(${luaValue(done)})
for _, q in ipairs(${luaValue(log)}) do w.onQuest(q, { 1 }) end
for _, q in ipairs(${luaValue(ready)}) do w.onQuest(q, {}) end`,
		addons: [ADDON],
		saved: saved ? { Polestar: saved } : undefined,
		login: true,
		script: `${DESCRIBE}\nlocal D = Polestar.Dungeons\n${script}`,
	}).emitted;
}

// From the Undercity: Bethor's errand there, on to Renferrel and Dalar in
// Silverpine (the chain in its order, Dalar's quest once it is behind), then
// the Barrens for the Warlock's quest, the entrance last with the quest
// already in the log listed, and the way to the hand-in guide after the run.
const FROM_UNDERCITY = [
	{ title: 'Orders from the Undercity', goals: 'accept:1010 turnin:1010' },
	{ title: 'The Dalaran Inquiry', goals: 'accept:1011 turnin:1011' },
	{ title: 'Dalar Dawnweaver', goals: 'accept:1014' },
	{ title: 'Doan Karhan', goals: 'accept:1740' },
	{ title: 'Shadowfang Keep', goals: 'note goto note' },
];

test('a Horde Warlock: the quests that apply, open prerequisites first in chain order, the givers on a route from the Undercity, the entrance last', () => {
	const [out] = run(`
local plan = D.PickupPlan("${KEY}")
local take, carried = {}, {}
for i, t in ipairs(plan.take) do take[i] = t.quest.id end
for i, q in ipairs(plan.carried) do carried[i] = q.id end
local def = D.PickupGuide("${KEY}")
local last = def.steps[#def.steps]
emit({ take = take, carried = carried, title = def.title, steps = describe(def), note = last.goals[1].text,
	entrance = { last.goals[2].map, last.goals[2].x, last.goals[2].y, last.goals[2].text }, after = last.goals[3].text })`);
	assert.deepEqual(out.take, [1740, 1014], 'not done 1098, Tauren-only 1999, Alliance 1806, follow-up 1016, carried 1013');
	assert.deepEqual(out.carried, [1013]);
	assert.equal(out.title, 'Shadowfang Keep: pick up the quests');
	assert.deepEqual(out.steps, FROM_UNDERCITY);
	assert.equal(out.note, 'In your log already: The Book of Ur');
	assert.deepEqual(out.entrance, [1421, 44.8, 67.8, 'Enter Shadowfang Keep']);
	assert.equal(out.after, "After the run: open this dungeon's page (/polestar dungeons Shadowfang Keep) and choose Hand in the quests.");
});

test('the route starts where the player stands; another class gets no class quest', () => {
	const [barrens] = run(`emit(describe(D.PickupGuide("${KEY}")))`, { at: BARRENS });
	assert.deepEqual(barrens, [FROM_UNDERCITY[3], ...FROM_UNDERCITY.slice(0, 3), FROM_UNDERCITY[4]], 'Doan Karhan first from the Barrens');
	const [mage] = run(`emit(describe(D.PickupGuide("${KEY}")))`, { cls: 'MAGE' });
	assert.deepEqual(mage, [...FROM_UNDERCITY.slice(0, 3), FROM_UNDERCITY[4]]);
});

test("a quest several NPCs of both sides give (Tabetha's Task): the character's side's giver nearest the player, never the other side's, though the page names the first", () => {
	const c = structuredClone(codex);
	const i = structuredClone(inputs);
	const npc = (id, name, faction, map, x, y) => ({ id, name, level: 50, levelMax: null, faction, rare: false, elite: false, boss: false, instance: null, roles: [], spawns: [{ map, x, y, f: 'e' }] });
	c.npcs[9001] = npc(9001, 'Anastasia Hartwell', 'H', 1458, 70, 40);
	c.npcs[9002] = npc(9002, 'Barrens Trainer', 'A', 1413, 60, 30);
	c.npcs[9003] = npc(9003, 'Silverpine Trainer', 'A', 1421, 60, 60);
	const quest = (id, title, givers) => ({
		id, title, level: 25, minLevel: 18, faction: null, races: null, classes: null,
		start: { npc: givers, object: [], item: [] }, end: { npc: givers, object: [] },
		objectives: [], pre: [], zone: 1421, rewards: [], choices: [], preAny: [],
	});
	c.quests[90200] = quest(90200, "Tabetha's Task", [9001, 9002, 9003]);
	c.quests[90201] = quest(90201, 'Alliance Errand', [9002]);
	i.forever.quests[90200] = { area: 209 };
	i.forever.quests[90201] = { area: 209 };
	const page = buildJournal(i, c).dungeons[KEY].quests.find((q) => q.id === 90200);
	assert.equal(page.start.name, 'Anastasia Hartwell', 'the page keeps the first giver');
	const own = writeCodexPack(c, { extraFiles: emitJournal(buildJournal(i, c)) });
	try {
		const script = `
local plan = D.PickupPlan("${KEY}")
local g = {}
for _, t in ipairs(plan.take) do if t.quest.id >= 90200 then g[#g + 1] = t.quest.id .. ":" .. t.giver.name end end
local p = D.GiverTarget("${KEY}", 90200)
emit({ take = g, target = p and p.name or false })`;
		const human = { race: 'Human', faction: 'Alliance', cls: 'MAGE', codexPack: own };
		const [barrens] = run(script, { ...human, at: BARRENS });
		assert.deepEqual(barrens, { take: ["90200:Barrens Trainer", '90201:Barrens Trainer'], target: 'Barrens Trainer' });
		const [silverpine] = run(script, { ...human, at: [1421, 50, 50] });
		assert.deepEqual(silverpine.take, ['90200:Silverpine Trainer', '90201:Barrens Trainer'], 'the nearest of its side');
		const [horde] = run(script, { cls: 'MAGE', at: BARRENS, codexPack: own });
		assert.deepEqual(horde, { take: ['90200:Anastasia Hartwell'], target: 'Anastasia Hartwell' }, 'the Alliance trainer next door is not for the Horde, nor a quest only an Alliance NPC gives');
	} finally {
		own.cleanup();
	}
});

test('PickUp opens the guide in a new tab and it plays to the end; the giver link points at the first prerequisite still to do', () => {
	const [opened, links, out] = run(`
Polestar.Set("behavior.autoNextGuide", false)
local before = #Polestar.Engine.GetTabs()
local function target(id)
	local p, label, first, turnIn = D.GiverTarget("${KEY}", id)
	return { p and p.map or false, label or false, first or false, turnIn or false }
end
local links = { arugal = target(1014), orb = target(1740) }
local id, why = D.PickUp("${KEY}")
emit({ id = id or false, why = why or false, tabs = tabIds(), before = before, active = Polestar.Engine.GetGuide() and Polestar.Engine.GetGuide().id or false })
stub.world.accept(1010, { 1 })
links.arugalAfter = target(1014)
stub.world.abandon(1010)
emit(links)
stub.advance(0.6)
${SIMULATE}`);
	assert.equal(opened.id, GID, `built (${opened.why})`);
	assert.equal(opened.active, GID);
	assert.deepEqual(links.arugal, [1458, 'Bethor Iceshard', 'Orders from the Undercity', false], "Arugal Must Die: Bethor's errand comes first");
	assert.deepEqual(links.arugalAfter, [1421, 'Apothecary Renferrel', 'Orders from the Undercity', true], 'in the log: where it is turned in');
	assert.deepEqual(links.orb, [1413, 'Doan Karhan', false, false], 'no prerequisite: the giver');
	assert.ok(!out.stuck, `stuck: ${JSON.stringify(out.stuck)}`);
	assert.equal(out.done, true);
	assert.deepEqual(out.missing, {}, 'every accept and turn-in has a location');
	assert.equal(out.visited, FROM_UNDERCITY.length);
	assert.deepEqual([opened.tabs.length, opened.tabs[opened.tabs.length - 1]], [opened.before + 1, GID], 'in a new tab of its own');
});

test('the tab survives /reload: rebuilt before the Engine reopens it, in the same route without a position', () => {
	const [first] = run(`
D.PickUp("${KEY}")
local s = Polestar.CharState()
emit({ tabs = s.tabs, order = s.dungeonPickup and s.dungeonPickup["${KEY}"] or false, steps = describe(Polestar.Guides.Get("${GID}")) })`);
	assert.ok(Array.isArray(first.order) && first.order.length > 0, 'the route is kept');
	const saved = `PolestarCharDB = { schema = 1, tabs = ${luaValue(first.tabs)}, activeTab = ${first.tabs.length}, dungeonPickup = { [${JSON.stringify(KEY)}] = ${luaValue(first.order)} } }`;
	const [after] = run(`emit({ tabs = tabIds(), active = Polestar.Engine.GetGuide() and Polestar.Engine.GetGuide().id or false, steps = describe(Polestar.Guides.Get("${GID}")) })`,
		{ at: null, saved });
	assert.deepEqual(after.tabs, first.tabs);
	assert.equal(after.active, GID);
	assert.deepEqual(after.steps, first.steps);
	assert.deepEqual(after.steps, FROM_UNDERCITY);
});

test('nothing left to pick up: PickUp says so and builds no guide', () => {
	const [out] = run(`
local before = tabIds()
local id, why = D.PickUp("${KEY}")
emit({ id = id or false, why = why or false, guide = Polestar.Guides.Get("${GID}") ~= nil, same = #tabIds() == #before, carried = #D.PickupPlan("${KEY}").carried })`,
	{ done: [1098, 1740, 1014, 1016], log: [1013] });
	assert.deepEqual(out, { id: false, why: 'nothing', guide: false, same: true, carried: 1 });
});

test('a follow-up of a dungeon quest is picked up once that quest is done', () => {
	const [out] = run(`emit(describe(D.PickupGuide("${KEY}")))`, { done: [1098, 1740, 1014], log: [1013] });
	assert.deepEqual(out, [{ title: 'Dalar Dawnweaver', goals: 'accept:1016' }, FROM_UNDERCITY[4]]);
});

test('a breadcrumb is not picked up once the quest it leads to is turned in or in the log (#368 Rawbowke: Klockmort\'s Essentials after Essential Artificials)', () => {
	const c = structuredClone(codex);
	const i = structuredClone(inputs);
	const quest = (id, title, giver) => ({
		id, title, level: 25, minLevel: 18, faction: 'H', races: null, classes: null,
		start: { npc: [giver], object: [], item: [] }, end: { npc: [6247], object: [] },
		objectives: [], pre: [], zone: 1458, rewards: [], choices: [], preAny: [],
	});
	// Two breadcrumbs to Doan Karhan's The Orb of Soran'ruk (1740): one naming
	// it as its breadcrumbFor, one only named by 1740's own `breadcrumbs`.
	c.quests[90300] = quest(90300, "Doan's Summons", 2934);
	c.quests[90301] = quest(90301, 'Word for Doan', 1498);
	i.forever.quests[90300] = { area: 209, breadcrumbFor: 1740 };
	i.forever.quests[90301] = { area: 209 };
	i.forever.quests[1740] = { ...i.forever.quests[1740], breadcrumbs: [90301] };
	const own = writeCodexPack(c, { extraFiles: emitJournal(buildJournal(i, c)) });
	try {
		const script = `
local plan = D.PickupPlan("${KEY}")
local take = {}
for k, t in ipairs(plan.take) do take[k] = t.quest.id end
table.sort(take)
local closedBy = {}
for _, s in ipairs((D.PickupGuide("${KEY}") or { steps = {} }).steps) do
	for _, g in ipairs(s.goals) do
		if g.t == "accept" and g.quest >= 90300 then closedBy[tostring(g.quest)] = table.concat(g.closedBy or {}, ",") end
	end
end
emit({ take = take, closedBy = closedBy })`;
		const [open] = run(script, { codexPack: own });
		assert.deepEqual(open.take, [1014, 1740, 90300, 90301], 'Doan\'s quest not taken yet: its breadcrumbs are offered');
		assert.deepEqual(open.closedBy, { 90300: '1740', 90301: '1740' }, 'each accept knows the quest that closes it, so the Engine passes it once that is taken');
		const [turnedIn] = run(script, { codexPack: own, done: [1098, 1740] });
		assert.deepEqual(turnedIn.take, [1014], 'Doan\'s quest turned in: no giver offers its breadcrumbs any more');
		const [carried] = run(script, { codexPack: own, log: [1013, 1740] });
		assert.deepEqual(carried.take, [1014], 'Doan\'s quest in the log: neither');
	} finally {
		own.cleanup();
	}
});

test('errands on the page before a dungeon quest are done on the way (#519: Hamuul Runetotem and Nara Wildmane before Leaders of the Fang)', () => {
	const c = structuredClone(codex);
	const i = structuredClone(inputs);
	const npc = (id, name, map, x, y) => ({
		id, name, level: 30, levelMax: null, faction: 'H', rare: false, elite: false, boss: false,
		instance: null, roles: [], spawns: [{ map, x, y, f: 'e' }],
	});
	c.npcs[90410] = npc(90410, 'Giver One', 1421, 40, 40);
	c.npcs[90411] = npc(90411, 'Giver Two', 1421, 45, 45);
	c.npcs[90412] = npc(90412, 'Giver Three', 1421, 50, 50);
	const quest = (id, title, giver, ender, pre, objectives) => ({
		id, title, level: 25, minLevel: 18, faction: 'H', races: null, classes: null,
		start: { npc: [giver], object: [], item: [] }, end: { npc: [ender], object: [] },
		objectives: objectives || [], pre: pre || [], zone: 1421, rewards: [], choices: [], preAny: [],
	});
	// A: off the page, with objectives, already done. B and C: errands on
	// the page (no objectives), each turned in at the next giver. D: the
	// dungeon quest itself, with objectives, after C.
	c.quests[90400] = quest(90400, 'An Earlier Errand', 90410, 90410, [], [{ type: 'kill', id: 90420, count: 1, text: 'Test Mob' }]);
	c.quests[90401] = quest(90401, 'Hamuul Runetotem', 90410, 90411, [90400], []);
	c.quests[90402] = quest(90402, 'Nara Wildmane', 90411, 90412, [90401], []);
	c.quests[90403] = quest(90403, 'Leaders of the Fang', 90412, 90412, [90402], [{ type: 'item', id: 90421, count: 1, text: 'Gem of Test' }]);
	i.forever.quests[90401] = { area: 209 };
	i.forever.quests[90402] = { area: 209 };
	i.forever.quests[90403] = { area: 209 };
	const own = writeCodexPack(c, { extraFiles: emitJournal(buildJournal(i, c)) });
	const script = `
local plan = D.PickupPlan("${KEY}")
local take, carried = {}, {}
for _, t in ipairs(plan.take) do if t.quest.id >= 90400 then take[#take + 1] = t.quest.id end end
for _, q in ipairs(plan.carried) do if q.id >= 90400 then carried[#carried + 1] = q.id end end
local pre = {}
for _, t in ipairs(plan.take) do
	if t.quest.id == 90403 then for _, r in ipairs(t.pre) do pre[#pre + 1] = r.id end end
end
local def = D.PickupGuide("${KEY}")
local steps, notes = {}, {}
for _, s in ipairs(def.steps) do
	local verbs = {}
	for _, g in ipairs(s.goals) do
		if g.quest and g.quest >= 90400 then verbs[#verbs + 1] = g.t .. ":" .. g.quest end
		if g.t == "note" then notes[#notes + 1] = g.text end
	end
	if #verbs > 0 then steps[#steps + 1] = table.concat(verbs, " ") end
end
emit({ take = take, carried = carried, pre = pre, steps = steps, notes = notes })`;
	try {
		const [open] = run(script, { codexPack: own, done: [1098, 90400] });
		assert.deepEqual(open.take, [90403], 'the errands ahead of it are not takes of their own');
		assert.deepEqual(open.pre, [90401, 90402], "Leaders of the Fang's open prerequisites: Hamuul Runetotem, Nara Wildmane");
		assert.deepEqual(open.steps, ['accept:90401 turnin:90401', 'accept:90402 turnin:90402', 'accept:90403'],
			'both errands done on the way, then the giver of Leaders of the Fang, before the entrance');

		const [withLog] = run(script, { codexPack: own, done: [1098, 90400], log: [1013, 90401] });
		assert.deepEqual(withLog.take, [90403]);
		assert.deepEqual(withLog.carried, {}, 'Hamuul Runetotem is done on the way, not carried');
		assert.ok(!withLog.notes.some((n) => n.includes('Hamuul Runetotem')), 'no "In your log already" note for it at the entrance');

		// A variant where Nara Wildmane's turn-in has no spawn (inside): it no
		// longer qualifies as an errand, so it blocks Leaders of the Fang again.
		const c2 = structuredClone(c);
		c2.npcs[90413] = npc(90413, 'Inside NPC', 1421, 50, 50);
		c2.npcs[90413].spawns = [];
		c2.quests[90402] = quest(90402, 'Nara Wildmane', 90411, 90413, [90401], []);
		const inside = writeCodexPack(c2, { extraFiles: emitJournal(buildJournal(i, c2)) });
		try {
			const [blocked] = run(script, { codexPack: inside, done: [1098, 90400] });
			assert.deepEqual(blocked.take, [90402], 'Nara Wildmane turns in nowhere reachable: it no longer clears the way for Leaders of the Fang, though it is still takeable on its own');
		} finally {
			inside.cleanup();
		}

		// A variant where an item starts Nara Wildmane (as Nefarian's head
		// starts The Lord of Blackrock), a giver listed beside it: no errand
		// either, though it asks for nothing, so it still blocks Leaders of
		// the Fang.
		const c3 = structuredClone(c);
		c3.quests[90402].start = { npc: [90411], object: [], item: [90422] };
		const byItem = writeCodexPack(c3, { extraFiles: emitJournal(buildJournal(i, c3)) });
		try {
			const [blocked] = run(script, { codexPack: byItem, done: [1098, 90400] });
			assert.ok(!blocked.take.includes(90403), 'an item starts Nara Wildmane: Leaders of the Fang is left for after the run');
		} finally {
			byItem.cleanup();
		}

		// A variant where Nara Wildmane needs Honored (as Strength of Mount
		// Mugamba needs Zandalar standing): no errand for a character below
		// it, one for a character who has it.
		const c4 = structuredClone(c);
		c4.quests[90402].repFaction = 270;
		c4.quests[90402].repStanding = 6;
		const byRep = writeCodexPack(c4, { extraFiles: emitJournal(buildJournal(i, c4)) });
		try {
			const [friendly] = run(`stub.world.setRep(270, "Zandalar Tribe", 5, 3000, 3000, 9000)\n${script}`, { codexPack: byRep, done: [1098, 90400] });
			assert.ok(!friendly.take.includes(90403), 'Friendly, not Honored: Leaders of the Fang is left for after the run');
			const [honored] = run(`stub.world.setRep(270, "Zandalar Tribe", 6, 9000, 9000, 21000)\n${script}`, { codexPack: byRep, done: [1098, 90400] });
			assert.deepEqual(honored.take, [90403], 'Honored: Nara Wildmane is an errand again');
		} finally {
			byRep.cleanup();
		}
	} finally {
		own.cleanup();
	}
});

test('ghost-only quest givers are not included in the pickup route (#558: Franclorn Forgewright)', () => {
	const c = structuredClone(codex);
	const i = structuredClone(inputs);
	const ghostNpc = {
		id: 90500, name: 'Ghost Giver', level: 50, levelMax: null, faction: 'AH',
		rare: false, elite: false, boss: false, ghostOnly: true,
		instance: null, roles: [], spawns: [{ map: 1428, x: 29, y: 29, f: 'e' }],
	};
	c.npcs[90500] = ghostNpc;
	c.quests[90500] = {
		id: 90500, title: 'Ghost Quest', level: 50, minLevel: 48, faction: 'AH',
		races: null, classes: null,
		start: { npc: [90500], object: [], item: [] }, end: { npc: [90500], object: [] },
		objectives: [], pre: [], zone: 1428, rewards: [], choices: [], preAny: [],
	};
	i.forever.quests[90500] = { area: 209 };
	const own = writeCodexPack(c, { extraFiles: emitJournal(buildJournal(i, c)) });
	try {
		const [plan] = run(`
local plan = D.PickupPlan("${KEY}")
local inRoute = false
for _, t in ipairs(plan.take) do if t.quest.id == 90500 then inRoute = true end end
emit({ inRoute = inRoute })
`, { codexPack: own, done: [1098] });
		assert.equal(plan.inRoute, false, 'ghost-only quest giver is not in the pickup route');
	} finally {
		own.cleanup();
	}
});


// Travel between the fixture's zones by the way a player goes (seconds):
// Undercity and Silverpine are next door, the Barrens a zeppelin away.
const ZONE_TRAVEL = `
local ZONES = { [1458] = "uc", [1421] = "sp", [1413] = "b" }
local COST = { ["uc-sp"] = 120, ["uc-b"] = 250, ["sp-b"] = 370 }
Polestar.TravelCost = function(a, b)
	local za, zb = ZONES[a.map], ZONES[b.map]
	if not (za and zb) then return nil end
	if za == zb then return 20 + math.abs(a.x - b.x) + math.abs(a.y - b.y) end
	return COST[za .. "-" .. zb] or COST[zb .. "-" .. za]
end`;

test('the route plans toward the entrance: from the Undercity the Barrens come first, so the Silverpine chain ends next to the keep', () => {
	const [out] = run(`${ZONE_TRAVEL}\nemit(describe(D.PickupGuide("${KEY}")))`);
	// A nearest-next walk took Bethor first (next door), went on through
	// Silverpine, then to the Barrens and all the way back to the keep.
	assert.deepEqual(out, [FROM_UNDERCITY[3], ...FROM_UNDERCITY.slice(0, 3), FROM_UNDERCITY[4]]);
});

// Dungeons.PlanStops on its own: cities as points, travel by city pair.
const PLAN = `
local CITY = { tb = { tb = 30, og = 300, uc = 450 }, og = { tb = 300, og = 30, uc = 200 }, uc = { tb = 450, og = 200, uc = 30 } }
local function at(city, name) return { city = city, name = name } end
local function travel(a, b) return CITY[a.city][b.city] end
local function names(stops, order)
	local out = {}
	for i, s in ipairs(order) do out[i] = stops[s].inP.name end
	return out
end
`;

test('Ragefire Chasm from Thunder Bluff: the givers in Thunder Bluff, the Undercity, then Orgrimmar next to the entrance', () => {
	const [out] = run(`${PLAN}
local stops = {
	{ inP = at("tb", "Thunder Bluff giver"), outP = at("tb"), deps = {} },
	{ inP = at("og", "Orgrimmar giver"), outP = at("og"), deps = {} },
	{ inP = at("uc", "Undercity giver"), outP = at("uc"), deps = {} },
}
local order, cost = D.PlanStops(stops, at("tb"), at("og", "entrance"), travel)
emit({ route = names(stops, order), cost = cost })`);
	assert.deepEqual(out.route, ['Thunder Bluff giver', 'Undercity giver', 'Orgrimmar giver']);
	assert.equal(out.cost, 30 + 450 + 200 + 30, 'not 30 + 300 + 200 + 200 (Orgrimmar, the Undercity and back)');
});

test('PlanStops keeps every stop after the ones it waits on, and a giver\'s visits fall together where they can', () => {
	const [out] = run(`${PLAN}
-- A chain: a prerequisite from the Undercity turned in at Orgrimmar, then a
-- second one from Orgrimmar; the Orgrimmar giver has one quest open now and
-- one that waits on the chain.
local stops = {
	{ inP = at("uc", "first link"), outP = at("og"), deps = {} },
	{ inP = at("og", "second link"), outP = at("og"), deps = { 1 } },
	{ inP = at("og", "giver, open now"), outP = at("og"), deps = {} },
	{ inP = at("og", "giver, after the chain"), outP = at("og"), deps = { 2 } },
}
local order = D.PlanStops(stops, at("og"), at("og", "entrance"), travel)
-- Above the exact size: the improved nearest-next order still honours every dependency.
local many, from = {}, at("tb")
for i = 1, 14 do
	local city = ({ "tb", "og", "uc" })[i % 3 + 1]
	many[i] = { inP = at(city, "s" .. i), outP = at(city), deps = i > 1 and i % 4 == 0 and { i - 1 } or {} }
end
local big = D.PlanStops(many, from, at("og", "entrance"), travel)
local pos, ok = {}, #big == 14
for p, i in ipairs(big) do pos[i] = p end
for i, s in ipairs(many) do for _, d in ipairs(s.deps) do ok = ok and pos[d] < pos[i] end end
emit({ route = names(stops, order), big = ok })`);
	// The chain in its order; the giver's two visits fall together after it,
	// one stop instead of two trips.
	assert.deepEqual(out.route, ['first link', 'second link', 'giver, open now', 'giver, after the chain']);
	assert.equal(out.big, true);
});

// After the run (Dungeons/Handin.lua): Arugal Must Die is finished, The Book
// of Ur is not; Return to Dalar opens when Arugal Must Die is turned in to
// Dalar, who gives it.
const AFTER_RUN = { done: [1098, 1740, 1011], log: [1013], ready: [1014] };

test('after the run: a finished quest routes to its turn-in, the follow-up it opens is taken there, an unfinished one is a note', () => {
	const [out] = run(`
local plan = D.HandinPlan("${KEY}")
local def = D.HandinGuide("${KEY}")
local ids = function(list, f) local o = {} for i, x in ipairs(list) do o[i] = f(x) end return o end
local last = def.steps[#def.steps]
emit({ hand = ids(plan.hand, function(h) return h.quest.id end), ender = { plan.hand[1].ender.name, plan.hand[1].ender.map },
	unfinished = ids(plan.unfinished, function(q) return q.id end),
	follow = ids(D.HandinFollowUps(plan), function(f) return f.rec.id end),
	title = def.title, steps = describe(def), note = last.goals[#last.goals].text, turnin = { last.goals[1].npcName, last.goals[1].map, last.goals[1].x } })`, AFTER_RUN);
	assert.deepEqual(out.hand, [1014]);
	assert.deepEqual(out.ender, ['Dalar Dawnweaver', 1421]);
	assert.deepEqual(out.unfinished, [1013]);
	assert.deepEqual(out.follow, [1016], 'Return to Dalar, given by the NPC Arugal Must Die is turned in to');
	assert.equal(out.title, 'Shadowfang Keep: hand in the quests');
	assert.deepEqual(out.steps, [{ title: 'Dalar Dawnweaver', goals: 'turnin:1014 accept:1016 note' }]);
	assert.equal(out.note, 'Not finished yet: The Book of Ur');
	assert.deepEqual(out.turnin, ['Dalar Dawnweaver', 1421, 44.2]);
});

test('after the run: a follow-up from a giver next door is a stop of its own; one far away, or one this character cannot take, is left out; a finished delivery is handed in', () => {
	const [barrens, near, far, low, both] = run(`
local function follow() local o = {} for i, f in ipairs(D.HandinFollowUps(D.HandinPlan("${KEY}"))) do o[i] = f.rec.id end return o end
emit(follow())
-- Held, so the Codex keeps this record while its giver is moved.
local dalar = Polestar.Codex.Quest(1016)
dalar.start.npc = { 1952 } -- High Executor Hadrec, next to Dalar
emit(describe(D.HandinGuide("${KEY}")))
dalar.start.npc = { 6247 } -- Doan Karhan, in the Barrens
emit(#follow())
dalar.start.npc = { 1938 }
stub.world.level = 17
emit(#follow())
stub.world.level = 21
stub.world.finish(1013)
emit(describe(D.HandinGuide("${KEY}")))`, { ...AFTER_RUN, at: BARRENS });
	assert.deepEqual(barrens, [1016], 'nearness is measured from the turn-in, not from where the player stands');
	assert.deepEqual(near, [{ title: 'Dalar Dawnweaver', goals: 'turnin:1014' }, { title: 'High Executor Hadrec', goals: 'accept:1016 note' }]);
	assert.equal(far, 0);
	assert.equal(low, 0, 'Return to Dalar needs level 18');
	assert.deepEqual(both.map((s) => s.goals).sort(), ['turnin:1013', 'turnin:1014 accept:1016']);
});

test('nothing to hand in: HandIn says so and builds no guide; the text names what is not finished', () => {
	const [out] = run(`
local before = tabIds()
local id, why = D.HandIn("${KEY}")
emit({ id = id or false, why = why or false, guide = Polestar.Guides.Get("lookup/handin/${KEY}") ~= nil, same = #tabIds() == #before,
	text = D.HandinText(D.HandinPlan("${KEY}")) })
stub.world.abandon(1013)
emit(D.HandinText(D.HandinPlan("${KEY}")))`);
	assert.deepEqual(out, { id: false, why: 'nothing', guide: false, same: true, text: 'Not finished yet: The Book of Ur.' });
});

test('HandIn takes the place of the pick-up guide once that one is at the entrance, comes back after /reload, and plays to the end', () => {
	const [first, out] = run(`
Polestar.Set("behavior.autoNextGuide", false)
-- Return to Dalar is all that is left to pick up: its step, then the entrance.
D.PickUp("${KEY}")
Polestar.Engine.OpenTab("lookup/pickup/${KEY}")
local early = { D.HandIn("${KEY}") }
local kept = tabIds()
stub.world.accept(1016, { 1 })
stub.advance(0.6)
local id = D.HandIn("${KEY}")
local s = Polestar.CharState()
emit({ early = early[1] or false, kept = kept, id = id or false, tabs = tabIds(), active = Polestar.Engine.GetGuide().id,
	order = s.dungeonHandin and s.dungeonHandin["${KEY}"] or false, saved = s.tabs })
stub.advance(0.6)
${SIMULATE}`, { done: [1098, 1740, 1011, 1014], log: [], ready: [1013] });
	assert.equal(first.early, 'lookup/handin/shadowfang-keep', 'built while the pick-up guide still has a quest to take');
	assert.deepEqual(first.kept, ['lookup/pickup/shadowfang-keep', 'lookup/handin/shadowfang-keep'], 'then both stay open');
	assert.equal(first.id, 'lookup/handin/shadowfang-keep');
	assert.deepEqual(first.tabs, ['lookup/handin/shadowfang-keep'], 'at its last step the pick-up guide gives up its tab');
	assert.equal(first.active, 'lookup/handin/shadowfang-keep');
	assert.deepEqual(first.order, ['enpc2934']);
	assert.ok(!out.stuck, `stuck: ${JSON.stringify(out.stuck)}`);
	assert.equal(out.done, true);
	assert.deepEqual(out.missing, {});
	const saved = `PolestarCharDB = { schema = 1, tabs = ${luaValue(first.saved)}, activeTab = 1, dungeonHandin = { [${JSON.stringify(KEY)}] = ${luaValue(first.order)} } }`;
	const [after] = run(`emit({ tabs = tabIds(), steps = describe(Polestar.Guides.Get("lookup/handin/${KEY}")) })`,
		{ at: null, saved, done: [1098, 1740, 1011, 1014], log: [], ready: [1013] });
	assert.deepEqual(after, { tabs: ['lookup/handin/shadowfang-keep'], steps: [{ title: "Keeper Bel'dugur", goals: 'turnin:1013' }] });
});
