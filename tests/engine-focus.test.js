'use strict';
// Engine "Focus: one person at a time": a step's goals grouped by who they are
// done with, the focus on the first open group, the waypoint following it,
// and Engine.GuideFocus. Real Core manifest, stub world.

const { test } = require('node:test');
const assert = require('node:assert/strict');
const { runAddon } = require('./helpers/lua');
const { TEST_PACK, TEST_SOURCE } = require('./helpers/packs');

const CORE = { name: 'Polestar', files: ['Core/Core.xml'] };

const WORLD = `
local w = stub.world
w.addMap(1413, { name = "The Barrens", c = 1, left = 1000, right = -1000, top = 1000, bottom = -3000 })
w.moveTo(1413, 52, 31)
w.race, w.faction, w.class, w.className, w.level = "Orc", "Horde", "WARRIOR", "Warrior", 12
`;

// The Crossroads: Thork (3429) twice, Gazrog (3464), Zargh (3489), then a
// field step, then accept/kill/turn-in at one NPC.
const GUIDE = `
Polestar.RegisterGuide({ id = "test/xr", pack = "test", title = "Crossroads", faction = "Horde", minLevel = 10, maxLevel = 20, zone = 1413, steps = {
	{ title = "The Crossroads", goals = {
		{ t = "turnin", quest = 840, title = "Conscript of the Horde", npc = 3429, npcName = "Thork", map = 1413, x = 51.5, y = 30.3 },
		{ t = "accept", quest = 842, title = "Crossroads Conscription", npc = 3429, npcName = "Thork", map = 1413, x = 51.5, y = 30.3 },
		{ t = "accept", quest = 869, title = "Raptor Thieves", npc = 3464, npcName = "Gazrog", map = 1413, x = 51.9, y = 30.8 },
		{ t = "accept", quest = 845, title = "The Zhevra", npc = 3489, npcName = "Zargh", map = 1413, x = 52.2, y = 31.0 },
		{ t = "note", text = "Mages: talk to someone else.", only = { classes = { "MAGE" } }, npc = 9999 },
		{ t = "accept", quest = 871, title = "Disrupt the Attacks", npc = 3489, npcName = "Zargh", map = 1413, x = 52.2, y = 31.0 },
	} },
	{ title = "Field", goals = {
		{ t = "goto", map = 1413, x = 45, y = 20, text = "Raptor grounds" },
		{ t = "kill", target = "Sunscale Lashtail", count = 7, quest = 869, oi = 1 },
		{ t = "collect", item = 5062, itemName = "Raptor Head", count = 12, quest = 869, oi = 2 },
	} },
	{ title = "Gazrog", goals = {
		{ t = "accept", quest = 870, title = "The Forgotten Pools", npc = 3464, npcName = "Gazrog", map = 1413, x = 51.9, y = 30.8 },
		{ t = "kill", target = "Bristleback Quilboar", count = 4, quest = 870, oi = 1, map = 1413, x = 55, y = 40 },
		{ t = "turnin", quest = 870, title = "The Forgotten Pools", npc = 3464, npcName = "Gazrog", map = 1413, x = 51.9, y = 30.8 },
	} },
} })
`;

function run({ before = '', guides = GUIDE, script }) {
	return runAddon({
		stubs: ['stub_world.lua'],
		before: WORLD + before,
		addons: [CORE],
		script: `${TEST_PACK}
${TEST_SOURCE}
			${guides}
			E = Polestar.Engine
			function flush() stub.advance(0.25) end
			function groups(i)
				local v = E.GetStepView(i)
				local out = {}
				for k, g in ipairs(v.groups) do
					out[k] = table.concat({ g.kind, tostring(g.name), table.concat(g.goals, "+"), g.done and "done" or ("open" .. g.pending) }, " ")
				end
				return { groups = out, focus = v.focus or false }
			end
			stub.login()
			E.SetGuide("test/xr")
			Polestar.Set("behavior.autoAccept", false)
			Polestar.Set("behavior.autoTurnin", false)
			${script}`,
	}).emitted;
}

test('a hub step reads person by person, and the focus walks them in order', () => {
	const [out] = run({
		before: 'stub.world.onQuest(840, {})',
		script: `
			local w = stub.world
			local r = { start = groups(1), goalGroups = {} }
			for g, v in ipairs(E.GetStepView(1).goals) do r.goalGroups[g] = v.group end
			r.wp = { E.GetWaypoint().goalIndex }
			w.turnIn(840); flush()
			r.afterTurnin = groups(1).focus
			w.accept(842, {}); flush()
			r.thorkDone = groups(1).focus
			r.wp[2] = E.GetWaypoint().goalIndex
			w.accept(869, { 7, 12 }); flush()
			r.gazrogDone = groups(1).focus
			r.wp[3] = E.GetWaypoint().goalIndex
			w.accept(845, {}); flush()
			r.zarghHalf = groups(1).focus
			w.accept(871, {}); flush()
			r.stepAfter = E.GetStepIndex()
			emit(r)
		`,
	});
	assert.deepEqual(out.start, {
		groups: ['npc Thork 1+2 open2', 'npc Gazrog 3 open1', 'npc Zargh 4+5+6 open2'],
		focus: 1,
	});
	assert.deepEqual(out.goalGroups, [1, 1, 2, 3, 3, 3]);
	assert.deepEqual(out.wp, [1, 3, 4]);
	assert.equal(out.afterTurnin, 1);
	assert.equal(out.thorkDone, 2);
	assert.equal(out.gazrogDone, 3);
	assert.equal(out.zarghHalf, 3);
	assert.equal(out.stepAfter, 2);
});

test('a field step stays one group; accept, kill and turn-in at one NPC make three groups in order', () => {
	const [out] = run({
		script: 'emit({ field = groups(2), gazrog = groups(3) })',
	});
	assert.deepEqual(out.field, { groups: ['here nil 1+2+3 open3'], focus: 1 });
	assert.deepEqual(out.gazrog, {
		groups: ['npc Gazrog 1 open1', 'here nil 2 open1', 'npc Gazrog 3 open1'],
		focus: 1,
	});
});

// Teldrassil "The Balance of Nature" (#102), Badlands' cages, Silithus'
// braziers: objects clicked for a quest objective are field work beside the
// kills, not a person met after them. A plain click (no quest) is a visit.
test('a quest interact stays in the field group; a plain interact is its own group', () => {
	const FIELD = `
Polestar.RegisterGuide({ id = "test/xr", pack = "test", title = "Woods", faction = "Horde", minLevel = 10, maxLevel = 20, zone = 1413, steps = {
	{ title = "Woods", goals = {
		{ t = "kill", target = "Gnarlpine Ursa", count = 4, quest = 456, oi = 1, map = 1413, x = 55, y = 44 },
		{ t = "collect", item = 3297, itemName = "Fel Moss", count = 8, quest = 459, oi = 1, map = 1413, x = 55, y = 45 },
		{ t = "interact", quest = 97977, object = 668482, objName = "Gnarlpine Totem", oi = 1, map = 1413, x = 56, y = 46,
			spots = { { x = 56, y = 46, r = 15, n = 1 }, { x = 55.2, y = 44.2, r = 36, n = 2 } } },
	} },
	{ title = "Shrine", goals = {
		{ t = "kill", target = "Gnarlpine Ursa", count = 4, quest = 456, oi = 1, map = 1413, x = 55, y = 44 },
		{ t = "interact", quest = 97978, object = 668499, objName = "Old Shrine", oi = 1, map = 1413, x = 57, y = 47 },
		{ t = "interact", object = 668500, objName = "Moonwell", map = 1413, x = 58, y = 47 },
	} },
} })
`;
	const [out] = run({
		before: 'stub.world.onQuest(456, { 4 }); stub.world.onQuest(459, { 8 }); stub.world.onQuest(97977, { 4 }); stub.world.onQuest(97978, { 1 })',
		guides: FIELD,
		script: 'emit({ woods = groups(1), shrine = groups(2) })',
	});
	assert.deepEqual(out.woods, { groups: ['here nil 1+2+3 open3'], focus: 1 });
	assert.deepEqual(out.shrine, { groups: ['here nil 1+2 open2', 'object Moonwell 3 open1'], focus: 1 });
});

test('doing a later person first marks that group done but leaves the focus on the first', () => {
	const [out] = run({
		before: 'stub.world.onQuest(840, {})',
		script: `
			local w = stub.world
			w.accept(869, { 7, 12 }); w.accept(845, {}); flush()
			local r = groups(1)
			r.wp = E.GetWaypoint().goalIndex
			emit(r)
		`,
	});
	assert.deepEqual(out, {
		groups: ['npc Thork 1+2 open2', 'npc Gazrog 3 done', 'npc Zargh 4+5+6 open1'],
		focus: 1,
		wp: 1,
	});
});

test('the focus move fires STEP_UPDATED and WAYPOINT_CHANGED', () => {
	const [out] = run({
		before: 'stub.world.complete({ 840 })',
		script: `
			local log = {}
			Polestar.On("STEP_UPDATED", function(i) log[#log + 1] = "U" .. i end)
			Polestar.On("WAYPOINT_CHANGED", function(wp) log[#log + 1] = "W" .. (wp and wp.goalIndex or "nil") end)
			stub.world.accept(842, {}); flush()
			emit(log)
		`,
	});
	assert.deepEqual(out, ['U1', 'W3']);
});

test('skipped and unavailable goals do not hold the focus', () => {
	const [out] = run({
		before: 'stub.world.onQuest(840, {})',
		script: `
			local w = stub.world
			-- Thork does not offer 842 (unavailable), and the turn-in is done: Thork's group is done.
			w.turnIn(840); flush()
			w.gossip(3429, { available = {} }); w.close(); flush()
			local r = groups(1)
			r.status = E.GetStepView(1).goals[2].status
			emit(r)
		`,
	});
	assert.deepEqual(out, {
		groups: ['npc Thork 1+2 done', 'npc Gazrog 3 open1', 'npc Zargh 4+5+6 open2'],
		focus: 2,
		status: 'skipped',
	});
});

// Camp Taurajo after the Bristleback camps (04-the-barrens step 31): Mangletooth's
// chain, then optional item quests, then a note.
const TAURAJO = `
	Polestar.RegisterGuide({ id = "test/tj", pack = "test", title = "Taurajo", faction = "Horde", minLevel = 10, maxLevel = 30, steps = {
		{ title = "Camp Taurajo", goals = {
			{ t = "turnin", quest = 878, title = "Tribes at War", npc = 3430, npcName = "Mangletooth", map = 1413, x = 44.8, y = 59.1 },
			{ t = "accept", quest = 879, title = "Betrayal from Within", npc = 3430, npcName = "Mangletooth", map = 1413, x = 44.8, y = 59.1 },
			{ t = "collect", item = 5102, itemName = "Owatanka's Tailspike", count = 1, optional = true, map = 1413, x = 49, y = 60 },
			{ t = "note", text = "Mangletooth trades more Blood Shards for blessings." },
		} },
		{ title = "Field of Giants", goals = {
			{ t = "level", level = 25 },
			{ t = "goto", map = 1413, x = 44.7, y = 70.7, text = "Field of Giants" },
		} },
		{ title = "Blackthorn Ridge", goals = { { t = "accept", quest = 900, title = "Later", npc = 3431, npcName = "Someone", map = 1413, x = 40, y = 80 } } },
	} })
`;

test('a done step viewed with Prev has no focus and no waypoint, even with an optional goal left open', () => {
	const [out] = run({
		guides: TAURAJO,
		before: 'stub.world.complete({ 878 }); stub.world.onQuest(879, { 1 })',
		script: `
			E.SetGuide("test/tj")
			local r = { at = E.GetStepIndex() }
			E.Prev(); flush()
			local v = E.GetStepView(E.GetStepIndex())
			r.prev = { E.GetStepIndex(), v.focus or false, E.GetWaypoint() or false }
			emit(r)
		`,
	});
	assert.deepEqual(out, { at: 2, prev: [1, false, false] });
});

test('the waypoint never leaves the focus group: an unlocated focus points nowhere', () => {
	const [out] = run({
		guides: TAURAJO,
		before: 'stub.world.complete({ 878 }); stub.world.onQuest(879, { 1 })',
		script: `
			E.SetGuide("test/tj")
			local r = { at = E.GetStepIndex() }
			r.wp = E.GetWaypoint() or false
			emit(r)
		`,
	});
	// "here" holds the level goal and the goto: the goto is in the focus.
	assert.equal(out.at, 2);
	assert.equal(out.wp.goalIndex, 2);

	const [split] = run({
		guides: `
			Polestar.RegisterGuide({ id = "test/sp", pack = "test", title = "Split", faction = "Horde", minLevel = 1, maxLevel = 60, steps = { { goals = {
				{ t = "turnin", quest = 840, title = "Conscript of the Horde", npc = 3429, npcName = "Thork" },
				{ t = "accept", quest = 869, title = "Raptor Thieves", npc = 3464, npcName = "Gazrog", map = 1413, x = 51.9, y = 30.8 },
			} } } })
		`,
		before: 'stub.world.onQuest(840, {})',
		script: 'E.SetGuide("test/sp"); emit({ focus = groups(1).focus, wp = E.GetWaypoint() or false })',
	});
	// Thork has no location here: the arrow must not jump to Gazrog, whom the window does not show yet.
	assert.deepEqual(split, { focus: 1, wp: false });
});

test('smart candidates group by the chosen NPC', () => {
	const guides = `
		Polestar.RegisterGuide({ id = "test/sm", pack = "test", title = "Smart", faction = "Horde", minLevel = 1, maxLevel = 60, steps = { { goals = {
			{ t = "train", skill = "First Aid", skillLine = 129, rank = 1, candidates = {
				{ npc = 3373, npcName = "Arnok", map = 1413, x = 52, y = 31, faction = "H" },
				{ npc = 5943, npcName = "Rawrk", map = 1413, x = 20, y = 80, faction = "H" },
			} },
			{ t = "learn", spell = 3275, spellName = "Linen Bandage", candidates = {
				{ npc = 3373, npcName = "Arnok", map = 1413, x = 52, y = 31, faction = "H" },
				{ npc = 5943, npcName = "Rawrk", map = 1413, x = 20, y = 80, faction = "H" },
			} },
			{ t = "buy", item = 159, itemName = "Water", candidates = {
				{ npc = 3934, npcName = "Innkeeper Boorand", map = 1413, x = 52, y = 30, faction = "H" },
			} },
		} } } })
	`;
	const [out] = run({
		guides,
		script: `
			E.SetGuide("test/sm")
			local r = { near = groups(1) }
			E.CycleCandidate(1, 2) -- the learn goes to Rawrk now
			r.cycled = groups(1)
			emit(r)
		`,
	});
	assert.deepEqual(out.near, {
		groups: ['npc Arnok 1+2 open2', 'npc Innkeeper Boorand 3 open1'],
		focus: 1,
	});
	assert.deepEqual(out.cycled, {
		groups: ['npc Arnok 1 open1', 'npc Rawrk 2 open1', 'npc Innkeeper Boorand 3 open1'],
		focus: 1,
	});
});

test('GuideFocus gives the live-frame position of the first goal on the guide zone', () => {
	const [out] = run({
		guides: GUIDE + `
			Polestar.RegisterMapFrames({ era = { [1413] = { c = 1, left = 1100, right = -900, top = 1100, bottom = -2900 } } }, "test")
			Polestar.RegisterGuide({ id = "test/era", pack = "test", title = "Era", faction = "Horde", minLevel = 1, maxLevel = 60, zone = 1413, steps = {
				{ goals = { { t = "goto", map = 1411, x = 10, y = 10 }, { t = "goto", map = 1413, x = 50, y = 50, f = "e" } } } } })
		`,
		script: `
			local x, y = E.GuideFocus("test/xr")
			local ex, ey = E.GuideFocus("test/era")
			emit({ { x, y }, { math.floor(ex * 100 + 0.5) / 100, math.floor(ey * 100 + 0.5) / 100 }, E.GuideFocus("nope") or false })
		`,
	});
	assert.deepEqual(out, [[51.5, 30.3], [45, 47.5], false]);
});

test('GuideFocus follows the current step of a guide open in a tab, and its start otherwise', () => {
	const [out] = run({
		guides: GUIDE + `
			Polestar.RegisterGuide({ id = "test/away", pack = "test", title = "Away", faction = "Horde", minLevel = 10, maxLevel = 20, zone = 1413, steps = {
				{ goals = { { t = "goto", map = 1413, x = 40, y = 60 } } },
				{ goals = { { t = "goto", map = 1411, x = 10, y = 10 } } },
			} })
		`,
		script: `
			local function at(id) local x, y = E.GuideFocus(id); return { x or false, y or false } end
			local r = { first = at("test/xr") }
			E.Goto(2); flush()
			r.field = at("test/xr")
			E.Goto(3); flush()
			r.gazrog = at("test/xr")
			E.OpenTab("test/away")
			E.Goto(2); flush()
			r.awayElsewhere = at("test/away")
			E.CloseTab(1); flush()
			r.closed = at("test/xr")
			emit(r)
		`,
	});
	assert.deepEqual(out, {
		first: [51.5, 30.3], field: [45, 20], gazrog: [51.9, 30.8],
		// The current step is on another map: where the guide starts.
		awayElsewhere: [40, 60],
		closed: [51.5, 30.3],
	});
});
