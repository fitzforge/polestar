'use strict';
// Engine scenarios (addon/Polestar/Core/Engine.lua + Guides.lua + Commands.lua)
// against the stub world in tests/lua/stub_world.lua, loading the real Core
// manifest.

const { test } = require('node:test');
const assert = require('node:assert/strict');
const { runAddon } = require('./helpers/lua');
const { TEST_PACK, TEST_SOURCE } = require('./helpers/packs');

const CORE = { name: 'Polestar', files: ['Core/Core.xml'] };

const WORLD = `
local w = stub.world
w.addMap(1429, { name = "Elwynn Forest", c = 0, left = 1500, right = -1500, top = 500, bottom = -1500 })
w.addMap(1453, { name = "Stormwind City", c = 0, left = 3000, right = 1500, top = 1500, bottom = 500 })
w.addMap(1411, { name = "Durotar", c = 1, left = 0, right = -3000, top = 0, bottom = -3000 })
w.moveTo(1429, 48, 42)
w.titles[783] = "A Threat Within"; w.titles[7] = "Kobold Camp Cleanup"
`;

// A Northshire-shaped route: accept -> turn in -> accept -> goto + kill ->
// class training (one step per class) -> turn in + level.
const NORTHSHIRE = `
Polestar.RegisterGuide({
	id = "test/01-northshire", pack = "test", title = "Northshire Valley",
	faction = "Alliance", races = { "Human" }, minLevel = 1, maxLevel = 6,
	zone = 1429, next = "test/02-elwynn",
	steps = {
		{ title = "Deputy Willem", goals = {
			{ t = "accept", quest = 783, title = "A Threat Within", npc = 823, npcName = "Deputy Willem", map = 1429, x = 48.2, y = 42.0 },
		} },
		{ title = "Marshal McBride", goals = {
			{ t = "turnin", quest = 783, title = "A Threat Within", npc = 197, npcName = "Marshal McBride", map = 1429, x = 48.9, y = 41.6 },
			{ t = "accept", quest = 7, title = "Kobold Camp Cleanup", npc = 197, npcName = "Marshal McBride", map = 1429, x = 48.9, y = 41.6 },
		} },
		{ title = "Kobold camp", note = "Pull one at a time.", goals = {
			{ t = "goto", map = 1429, x = 47.6, y = 35.1, text = "Kobold camp", r = 10 },
			{ t = "kill", target = "Kobold Vermin", npc = 6, count = 10, quest = 7, oi = 1, map = 1429, x = 47.6, y = 35.1 },
		} },
		{ title = "Warrior training", only = { classes = { "WARRIOR" } }, goals = {
			{ t = "train", npc = 911, npcName = "Llane Beshere" },
		} },
		{ title = "Mage training", only = { classes = { "MAGE" } }, goals = {
			{ t = "train", npc = 198, npcName = "Khelden Bremen" },
		} },
		{ title = "Back to the abbey", goals = {
			{ t = "turnin", quest = 7, title = "Kobold Camp Cleanup", npc = 197, npcName = "Marshal McBride", map = 1429, x = 48.9, y = 41.6 },
			{ t = "note", text = "Dwarves: talk to Grelin.", only = { races = { "Dwarf" } } },
			{ t = "level", level = 5, only = { races = { "Gnome" } } },
			{ t = "level", level = 4 },
		} },
	},
})
`;

const ELWYNN = `
Polestar.RegisterGuide({
	id = "test/02-elwynn", pack = "test", title = "Elwynn Forest",
	faction = "Alliance", minLevel = 5, maxLevel = 12, zone = 1429,
	steps = {
		{ goals = { { t = "accept", quest = 60, title = "Kobold Candles", npc = 253, npcName = "William Pestle" } } },
		{ goals = { { t = "level", level = 12 } } },
	},
})
`;

// Records the Engine's messages as "NAME arg" strings, in order.
const RECORDER = `
LOG = {}
for _, m in ipairs({ "GUIDE_CHANGED", "STEP_CHANGED", "STEP_UPDATED", "WAYPOINT_CHANGED", "GUIDE_COMPLETED" }) do
	Polestar.On(m, function(a)
		local v = a
		if m == "WAYPOINT_CHANGED" then v = a and (a.stepIndex .. ":" .. a.goalIndex) or "nil" end
		LOG[#LOG + 1] = m .. " " .. tostring(v)
	end)
end
function flush() stub.advance(0.25) end
function takeLog() local l = LOG; LOG = {}; return l end
function activeTickers()
	local n = 0
	for _, t in ipairs(stub.timers) do if t.handle and not t.cancelled then n = n + 1 end end
	return n
end
E = Polestar.Engine
`;

function run({ guides = NORTHSHIRE, before = '', saved, script, login = true }) {
	return runAddon({
		stubs: ['stub_world.lua'],
		before: WORLD + before,
		addons: [CORE],
		saved,
		script: `${TEST_PACK}
${TEST_SOURCE}\n${guides}\n${RECORDER}\n${login ? 'stub.login()' : ''}\n${script}`,
	}).emitted;
}

test('accept, objectives and turn-in advance the steps and fire messages in order', () => {
	const [log, view3, wp] = run({
		script: `
			local w = stub.world
			w.accept(783, {}); flush()
			w.turnIn(783); flush()
			w.accept(7, { 10 }); flush()
			w.progress(7, 1, 3); flush()
			local v = E.GetStepView(3)
			local wp = E.GetWaypoint()
			w.progress(7, 1, 10); flush()
			w.trainer(911); flush()
			w.close()
			w.turnIn(7); flush()
			w.setLevel(4); flush()
			emit(takeLog())
			emit(v)
			emit(wp)
		`,
	});
	assert.deepEqual(log, [
		'GUIDE_CHANGED test/01-northshire', 'STEP_CHANGED 1', 'WAYPOINT_CHANGED 1:1',
		'STEP_CHANGED 2', 'WAYPOINT_CHANGED 2:1',
		'STEP_UPDATED 2', 'WAYPOINT_CHANGED 2:2',
		'STEP_CHANGED 3', 'WAYPOINT_CHANGED 3:2',
		'STEP_UPDATED 3',
		'STEP_CHANGED 4', 'WAYPOINT_CHANGED nil',
		'STEP_CHANGED 6', 'WAYPOINT_CHANGED 6:1',
		'STEP_UPDATED 6', 'WAYPOINT_CHANGED nil',
		'STEP_CHANGED nil', 'GUIDE_COMPLETED test/01-northshire',
	]);
	assert.equal(view3.status, 'current');
	assert.equal(view3.note, 'Pull one at a time.');
	assert.deepEqual(
		view3.goals.map((g) => [g.status, g.text, g.verb, g.subject, g.subjectKind, g.detail ?? null, g.manual]),
		[
			['active', 'Go to Kobold camp', 'Go to', 'Kobold camp', 'place', 'Elwynn Forest', false],
			['active', 'Kill Kobold Vermin', 'Kill', 'Kobold Vermin', 'npc', 'for Kobold Camp Cleanup', false],
		],
	);
	assert.deepEqual(view3.goals[1].progress, { cur: 3, max: 10, kind: 'count' });
	assert.equal(view3.goals[1].quest, 7);
	// Which objective of the quest it is (the party line reads it).
	assert.equal(view3.goals[1].oi, 1);
	assert.equal(view3.goals[1].npc, 6);
	// The camp's Go to names the step (its header): the arrow leads to the kobolds.
	assert.deepEqual(wp, { map: 1429, x: 47.6, y: 35.1, label: 'Kill Kobold Vermin', stepIndex: 3, goalIndex: 2, kind: 'kill', r: 8 });
});

test('an alt with quests already done starts at the first step that is not done', () => {
	const [out] = run({
		before: `w.complete({ 783 }); w.onQuest(7, { { required = 10, fulfilled = 4 } })`,
		script: `
			local s = {}
			for i = 1, E.GetStepCount() do s[i] = E.GetStepView(i).status end
			local done, total = E.GetProgress()
			emit({ index = E.GetStepIndex(), statuses = s, progress = E.GetStepView(3).goals[2].progress, done = done, total = total,
				log = takeLog() })
		`,
	});
	assert.deepEqual(out, {
		index: 3,
		statuses: ['done', 'done', 'current', 'upcoming', 'na', 'upcoming'],
		progress: { cur: 4, max: 10, kind: 'count' },
		done: 2,
		total: 5,
		log: ['GUIDE_CHANGED test/01-northshire', 'STEP_CHANGED 3', 'WAYPOINT_CHANGED 3:2'],
	});
});

test('`only` on steps and goals filters by class and race', () => {
	const [out] = run({
		before: `w.class = "MAGE"; w.className = "Mage"; w.level = 4
			w.complete({ 783 }); w.onQuest(7, { { required = 10, fulfilled = 10 } })`,
		script: `
			local at = E.GetStepIndex()
			local v4, v6 = E.GetStepView(4), E.GetStepView(6)
			stub.world.trainer(198); flush()
			local g = {}
			for i, goal in ipairs(v6.goals) do g[i] = goal.status end
			emit({ at = at, s4 = v4.status, s4goal = v4.goals[1].status, s6 = v6.status, goals6 = g,
				after = E.GetStepIndex(), total = select(2, E.GetProgress()) })
		`,
	});
	assert.deepEqual(out, {
		at: 5,
		s4: 'na',
		s4goal: 'na',
		s6: 'upcoming',
		goals6: ['pending', 'na', 'na', 'done'],
		after: 6,
		total: 5,
	});
});

test('goto completes on arrival via the ticker, which runs only while a goto is active', () => {
	const [out] = run({
		before: `w.complete({ 783 }); w.onQuest(7, { 10 })`,
		script: `
			local w = stub.world
			takeLog()
			local before = activeTickers()
			stub.advance(2)
			local stillActive = E.GetStepView(3).goals[1].status
			w.moveTo(1429, 47.7, 35.3) -- about 5 yards from the camp, r = 10
			stub.advance(0.6)
			emit({ before = before, stillActive = stillActive, after = E.GetStepView(3).goals[1].status,
				wp = E.GetWaypoint().goalIndex, tickers = activeTickers(), log = takeLog() })
		`,
	});
	// The arrow is on the kobolds from the start (the camp's Go to is the
	// step's header), so arriving moves nothing.
	assert.deepEqual(out, {
		before: 1,
		stillActive: 'active',
		after: 'done',
		wp: 2,
		tickers: 0,
		log: ['STEP_UPDATED 3'],
	});
});

test('goto is done once a later goal in its step is done, without arriving', () => {
	const [out] = run({
		before: `w.complete({ 783 }); w.onQuest(7, { { required = 10, fulfilled = 9 } })`,
		script: `
			stub.world.progress(7, 1, 10); flush()
			emit({ index = E.GetStepIndex(), goto = E.GetStepView(3).goals[1].status, s3 = E.GetStepView(3).status })
		`,
	});
	assert.deepEqual(out, { index: 4, goto: 'done', s3: 'done' });
});

test('a goto that leads into the next step is done once that step\'s quest work is, so work done ahead never sends the player back to the cave mouth (#240)', () => {
	// Durotar's Burning Blade Coven: the mouth in a step of its own, then the
	// Medallion inside. Gruko had the Medallion already and was sent back to
	// the mouth. A mouth ending a step of other work counts the same way; a
	// goto ahead of a step with no quest work (training, a level) still holds,
	// and so does one with optional work after it in its own step (the
	// Wailing Caverns mound), which is where that work is.
	const COVEN = `
Polestar.RegisterGuide({ id = "test/coven", pack = "test", title = "Coven", zone = 1429, steps = {
	{ title = "Zureetha", goals = { { t = "accept", quest = 7, title = "Kobold Camp Cleanup", npc = 197, map = 1429, x = 48.9, y = 41.6 } } },
	{ title = "Burning Blade Coven", goals = { { t = "goto", map = 1429, x = 20, y = 20, text = "Burning Blade Coven" } } },
	{ title = "Yarrog", goals = { { t = "kill", target = "Kobold Vermin", npc = 6, count = 10, quest = 7, oi = 1, map = 1429, x = 22, y = 18 } } },
	{ title = "Familiars", goals = {
		{ t = "accept", quest = 783, title = "A Threat Within", npc = 823, map = 1429, x = 48.2, y = 42.0 },
		{ t = "goto", map = 1429, x = 20, y = 20, text = "Burning Blade Coven" },
	} },
	{ title = "Pick", goals = { { t = "turnin", quest = 783, title = "A Threat Within", npc = 197, map = 1429, x = 22, y = 18 } } },
	{ title = "Trainer", goals = { { t = "goto", map = 1429, x = 80, y = 80, text = "Trainer" } } },
	{ title = "Level", goals = { { t = "level", level = 1 } } },
	{ title = "Mound", goals = {
		{ t = "goto", map = 1429, x = 60, y = 60, text = "Mound" },
		{ t = "kill", target = "Defias Bandit", npc = 116, map = 1429, x = 60, y = 60, optional = true },
	} },
	{ title = "Regthar", goals = { { t = "turnin", quest = 783, title = "A Threat Within", npc = 197, map = 1429, x = 62, y = 60 } } },
	{ goals = { { t = "level", level = 60 } } },
} })
`;
	const [out] = run({
		guides: COVEN,
		script: `
			local w = stub.world
			E.SetGuide("test/coven"); flush()
			w.accept(7, { 10 }); flush()
			local mouth = E.GetStepIndex()
			w.progress(7, 1, 10); flush()
			local medallion = { index = E.GetStepIndex(), goto = E.GetStepView(2).goals[1].status }
			w.accept(783, {}); flush()
			local familiars = E.GetStepIndex()
			w.turnIn(783); flush()
			emit({ mouth = mouth, medallion = medallion, familiars = familiars, trainer = E.GetStepIndex(),
				mound = E.GetStepView(8).goals[1].status })
		`,
	});
	assert.deepEqual(out, {
		mouth: 2, // the Medallion not yet in the bags: the mouth holds
		medallion: { index: 4, goto: 'done' },
		familiars: 4,
		trainer: 6,
		mound: 'pending',
	});
});

test('a goto ahead of a step done only through class quests, a skipped step or unavailable quests still holds (#240)', () => {
	// What counts as the player having been through the next step is what
	// placement counts (anchorStep): its own quest work. A Warrior who took The
	// Islander anywhere is not in Orgrimmar (Arathi's zeppelin, Sorek's accept
	// `only Warrior`); a step the player skipped or one whose only quest the
	// giver will never offer proves nothing either. The last pair is the control.
	const STEPS = `
Polestar.RegisterGuide({ id = "test/evidence", pack = "test", title = "Evidence", zone = 1429, steps = {
	{ title = "Hold", goals = { { t = "level", level = 60 } } },
	{ title = "Zeppelin", goals = { { t = "goto", map = 1429, x = 20, y = 20, text = "Zeppelin" } } },
	{ title = "Sorek", goals = { { t = "turnin", quest = 783, title = "A Threat Within", npc = 197, map = 1429, x = 22, y = 20, only = { classes = { "WARRIOR" } } } } },
	{ title = "Path", goals = { { t = "goto", map = 1429, x = 30, y = 20, text = "Path" } } },
	{ title = "Warrior trainer", only = { classes = { "WARRIOR" } }, goals = { { t = "turnin", quest = 783, title = "A Threat Within", npc = 197, map = 1429, x = 32, y = 20 } } },
	{ title = "Cave", goals = { { t = "goto", map = 1429, x = 40, y = 20, text = "Cave" } } },
	{ title = "Skipped", goals = { { t = "turnin", quest = 7, title = "Kobold Camp Cleanup", npc = 197, map = 1429, x = 42, y = 20 } } },
	{ title = "Dock", goals = { { t = "goto", map = 1429, x = 50, y = 20, text = "Dock" } } },
	{ title = "Closed", goals = { { t = "accept", quest = 60, title = "Kobold Candles", npc = 253, map = 1429, x = 52, y = 20, closedBy = { 783 } } } },
	{ title = "Mouth", goals = { { t = "goto", map = 1429, x = 60, y = 20, text = "Mouth" } } },
	{ title = "Inside", goals = { { t = "turnin", quest = 7, title = "Kobold Camp Cleanup", npc = 197, map = 1429, x = 62, y = 20 } } },
	{ goals = { { t = "level", level = 60 } } },
} })
`;
	const [out] = run({
		guides: STEPS,
		script: `
			local w = stub.world
			E.SetGuide("test/evidence"); flush()
			E.Goto(7); E.Skip(); flush()
			w.accept(783, {}); w.turnIn(783); w.accept(7, {}); w.turnIn(7); flush()
			emit({ skipped = PolestarCharDB.skipped["test/evidence"][7] == true,
				gotos = { E.GetStepView(2).goals[1].status, E.GetStepView(4).goals[1].status, E.GetStepView(6).goals[1].status,
				E.GetStepView(8).goals[1].status, E.GetStepView(10).goals[1].status } })
		`,
	});
	assert.equal(out.skipped, true, 'the turn-in after the cave was skipped');
	assert.deepEqual(out.gotos.map((st) => st === 'done'), [false, false, false, false, true], 'only the goto ahead of quest work everyone does is done');
});

test('a kill goal with spawn areas points at the area nearest the player, switching only once another is clearly nearer', () => {
	// Elwynn here is 30 yd per map percent across: the two areas are 600 yd apart, radius 30.
	const SPOTS = `
Polestar.RegisterGuide({ id = "test/spots", pack = "test", title = "Spots", zone = 1429, steps = {
	{ goals = { { t = "kill", target = "Kobold Vermin", npc = 6, count = 10, quest = 7, oi = 1, map = 1429, x = 40, y = 50,
		spots = { { x = 40, y = 50, r = 30, n = 5 }, { x = 60, y = 50, r = 30, n = 4 } } } } },
	{ goals = { { t = "level", level = 60 } } },
} })
`;
	const [out] = run({
		guides: SPOTS,
		before: `w.onQuest(7, { 10 }); w.moveTo(1429, 38, 50)`,
		script: `
			local w = stub.world
			E.SetGuide("test/spots"); flush()
			local seen = {}
			local function snap()
				local wp = E.GetWaypoint()
				seen[#seen + 1] = { wp.x, wp.area, wp.r, E.GetStepView(1).goals[1].x }
			end
			snap()
			takeLog()
			-- midpoint, just past it (30 yd nearer the east edge), well past it, back just past the midpoint, home
			for _, x in ipairs({ 50, 50.5, 52, 49.5, 38 }) do
				w.moveTo(1429, x, 50)
				stub.advance(1)
				snap()
			end
			emit({ seen = seen, log = takeLog() })
		`,
	});
	assert.deepEqual(out.seen, [
		[40, 30, 8, 40], // inside the west area
		[40, 30, 8, 40], // midpoint: both edges 270 yd away
		[40, 30, 8, 40], // east edge 30 yd nearer: not enough to switch
		[60, 30, 8, 60], // east edge 120 yd nearer: switched
		[60, 30, 8, 60], // back past the midpoint by 15 yd: no flap
		[40, 30, 8, 40],
	]);
	assert.deepEqual(out.log.filter((l) => l.startsWith('WAYPOINT_CHANGED')), ['WAYPOINT_CHANGED 1:1', 'WAYPOINT_CHANGED 1:1']);
});

// An area objective: three spots along y = 50 (Elwynn here: 30 yd per map
// percent across), radius 30 each.
const SEARCH = `
Polestar.RegisterGuide({ id = "test/search", pack = "test", title = "Search", zone = 1429, steps = {
	{ goals = { { t = "collect", item = 5062, itemName = "Raptor Head", count = 12, quest = 7, oi = 1, map = 1429, x = 20, y = 50, spread = true,
		spots = { { x = 20, y = 50, r = 30, n = 3 }, { x = 40, y = 50, r = 30, n = 2 }, { x = 80, y = 50, r = 30, n = 1 } } } } },
	{ goals = { { t = "level", level = 60 } } },
} })
`;

test('an area objective walks a circuit: a visited spot is skipped for a while, the next is the nearest not visited', () => {
	const [out] = run({
		guides: SEARCH,
		before: `w.onQuest(7, { 12 }); w.moveTo(1429, 20, 50)`,
		script: `
			local w = stub.world
			E.SetGuide("test/search"); flush()
			local seen = {}
			local function at(x)
				w.moveTo(1429, x, 50)
				stub.advance(1)
				local wp = E.GetWaypoint()
				seen[#seen + 1] = { x, wp.x, wp.spot }
			end
			local wp = E.GetWaypoint()
			local first = { wp.x, wp.search, #wp.spots, wp.spot, wp.area }
			at(20.8) -- still inside the first spot (24 yd from its centre)
			at(30)   -- left it: the nearest not visited
			at(40)   -- searching the second
			at(60)   -- left it: the third (the first was visited)
			at(80)   -- searching the third
			at(50)   -- all visited: the one visited longest ago
			stub.advance(400)
			at(55)   -- visits forgotten: the nearest again
			local v = E.GetStepView(1).goals[1]
			emit({ first = first, seen = seen, view = { v.spots, v.spread, v.x } })
		`,
	});
	assert.deepEqual(out.first, [20, true, 3, 1, 30]);
	assert.deepEqual(out.seen, [
		[20.8, 20, 1],
		[30, 40, 2],
		[40, 40, 2],
		[60, 80, 3],
		[80, 80, 3],
		[50, 20, 1],
		[55, 40, 2],
	]);
	assert.deepEqual(out.view, [3, true, 40]);
});

test('CycleSpot moves an area objective on by hand, to the next spot or a chosen one, which holds until reached', () => {
	const [out] = run({
		guides: SEARCH,
		before: `w.onQuest(7, { 12 }); w.moveTo(1429, 20, 50)`,
		script: `
			E.SetGuide("test/search"); flush()
			local r = {}
			r.next = E.CycleSpot(1, 1)
			r.afterNext = E.GetWaypoint().x
			stub.advance(2)
			r.held = E.GetWaypoint().x       -- standing in the first spot: the pick holds
			r.chosen = E.CycleSpot(1, 1, 3)
			stub.advance(2)
			r.afterChosen = E.GetWaypoint().x
			r.none = E.CycleSpot(1, 2) or false
			emit(r)
		`,
	});
	assert.deepEqual(out, { next: 2, afterNext: 40, held: 40, chosen: 3, afterChosen: 80, none: false });
});

test('another place the target spawns (alt) is never picked on its own; moving on by hand reaches it and every other place', () => {
	// Camps at 40 and 60 along y = 50, and another place at 30 (alt), radius 30 each. The player stands inside the alt.
	const ALT = `
Polestar.RegisterGuide({ id = "test/alt", pack = "test", title = "Alt", zone = 1429, steps = {
	{ goals = { { t = "kill", target = "Kobold Vermin", npc = 6, count = 10, quest = 7, oi = 1, map = 1429, x = 40, y = 50,
		spots = { { x = 40, y = 50, r = 30, n = 5 }, { x = 60, y = 50, r = 30, n = 4 }, { x = 30, y = 50, r = 30, n = 1, alt = true } } } } },
	{ goals = { { t = "level", level = 60 } } },
} })
`;
	const [out] = run({
		guides: ALT,
		before: `w.onQuest(7, { 10 }); w.moveTo(1429, 29, 50)`,
		script: `
			local w = stub.world
			E.SetGuide("test/alt"); flush()
			local r = {}
			r.start = E.GetWaypoint().x
			stub.advance(1)
			r.still = E.GetWaypoint().x
			r.walk = {}
			for i = 1, 3 do
				local index = E.CycleSpot(1, 1)
				r.walk[i] = { index, E.GetWaypoint().x }
			end
			E.CycleSpot(1, 1, 3)
			stub.advance(2)
			r.held = E.GetWaypoint().x
			w.moveTo(1429, 40, 50)
			stub.advance(1)
			r.back = E.GetWaypoint().x
			r.count = E.GetStepView(1).goals[1].spots
			emit(r)
		`,
	});
	assert.equal(out.start, 40, 'the nearest camp, though the player stands in the alt');
	assert.equal(out.still, 40);
	assert.deepEqual(out.walk, [[3, 30], [2, 60], [1, 40]], 'by hand: the alt (nearest), the far camp, then the one visited longest ago');
	assert.equal(out.held, 30, 'a place picked by hand holds while the player is there');
	assert.equal(out.back, 40, 'walking on, the arrow returns to the camps');
	assert.equal(out.count, 3);
});

test('a circuit of waypoints in one step costs one pass over the step, and a later arrival covers the earlier ones', () => {
	// Gathering guides loop a dozen or more waypoints in one step until a skill
	// rank: checking each goto against the goals after it once (not through
	// their own later goals again) keeps that linear.
	const n = 22;
	const gotos = Array.from({ length: n }, (_, i) => `{ t = "goto", map = 1429, x = ${10 + i * 3}, y = 70, r = 5 }`).join(',\n');
	const guide = `
		Polestar.RegisterGuide({ id = "test/circuit", pack = "test", title = "Circuit", minLevel = 1, maxLevel = 60, steps = {
			{ goals = { ${gotos}, { t = "level", level = 3 } } },
			{ goals = { { t = "level", level = 60 } } },
		} })
	`;
	const [out] = run({
		guides: guide,
		before: 'w.moveTo(1429, 90, 90)',
		script: `
			local t0 = os.clock()
			E.SetGuide("test/circuit")
			stub.advance(1)
			local open = 0
			for _, g in ipairs(E.GetStepView(1).goals) do if g.status == "active" then open = open + 1 end end
			stub.world.moveTo(1429, ${10 + 9 * 3}, 70) -- waypoint 10
			stub.advance(1)
			local view = E.GetStepView(1)
			local s = {}
			for i = 1, ${n} do s[i] = view.goals[i].status end
			stub.world.setLevel(3)
			stub.advance(1)
			emit({ open = open, early = s[9], at = s[10], late = s[11], step = E.GetStepIndex(), seconds = os.clock() - t0 })
		`,
	});
	assert.equal(out.open, n + 1, 'every waypoint and the level are open at the start');
	assert.deepEqual({ early: out.early, at: out.at, late: out.late, step: out.step }, { early: 'done', at: 'done', late: 'active', step: 2 });
	assert.ok(out.seconds < 0.5, `took ${out.seconds.toFixed(2)} s of CPU`);
});

test('Era-frame goto coordinates convert through the registered Era bounds', () => {
	const guide = `
		Polestar.RegisterMapFrames({ era = { [1429] = { c = 0, left = 1600, right = -1400, top = 600, bottom = -1400 } } }, "guides")
		Polestar.RegisterGuide({ id = "test/era", pack = "test", title = "Era", minLevel = 1, maxLevel = 60, steps = {
			{ goals = { { t = "goto", map = 1429, x = 50, y = 50, f = "e" } } },
			{ goals = { { t = "level", level = 60 } } },
		} })
	`;
	const [out] = run({
		guides: guide,
		before: 'w.moveTo(1429, 50, 50)',
		script: `
			stub.advance(1)
			local atSamePercent = E.GetStepIndex()
			stub.world.moveTo(1429, 46.67, 45) -- the same world spot in the live frame
			stub.advance(1)
			emit({ atSamePercent = atSamePercent, after = E.GetStepIndex() })
		`,
	});
	assert.deepEqual(out, { atSamePercent: 1, after: 2 });
});

test('check-offs are stored per guide, survive recomputes and a reload, and toggle off; any goal ticks, not only manual ones', () => {
	const guide = `
		Polestar.RegisterGuide({ id = "test/manual", pack = "test", title = "Manual", minLevel = 1, maxLevel = 10, steps = {
			{ goals = { { t = "talk", npc = 197, npcName = "Marshal McBride" } } },
			{ goals = { { t = "kill", target = "Young Wolf", count = 5 }, { t = "level", level = 2 } } },
			{ goals = { { t = "hearth", location = "Goldshire" } } },
		} })
	`;
	const [first] = run({
		guides: guide,
		script: `
			local w = stub.world
			local levelTick = E.ToggleGoal(2, 2)
			local ok = E.ToggleGoal(1, 1)
			local afterTalk = E.GetStepIndex()
			local view = E.GetStepView(2)
			E.ToggleGoal(2, 1)
			w.setLevel(2); flush()
			w.accept(5, { 1 }); w.addItem(1, 1); flush() -- unrelated recomputes
			emit({ levelTick = levelTick, ok = ok, afterTalk = afterTalk, manualFlags = { view.goals[1].manual, view.goals[2].manual },
				index = E.GetStepIndex(), saved = PolestarCharDB.manual["test/manual"] })
		`,
	});
	assert.deepEqual(first, {
		levelTick: true, // a level goal ticks like any other
		ok: true,
		afterTalk: 2,
		manualFlags: [true, false],
		index: 3,
		saved: { '1:1': 'tick', '2:1': 'tick', '2:2': 'tick' },
	});

	const [second] = run({
		guides: guide,
		before: 'w.level = 2',
		saved: { Polestar: `PolestarCharDB = { schema = 1, guide = "test/manual", manual = { ["test/manual"] = { ["1:1"] = true, ["2:1"] = true } } }` },
		script: `
			local resumed = E.GetStepIndex()
			E.ToggleGoal(1, 1)
			emit({ resumed = resumed, untoggled = E.GetStepIndex(), saved = PolestarCharDB.manual["test/manual"] })
		`,
	});
	assert.deepEqual(second, { resumed: 3, untoggled: 1, saved: { '2:1': true } });
});

test('nil SavedVariables at login still resume the right step from live quest state', () => {
	const [cold] = run({
		guides: NORTHSHIRE + ELWYNN,
		before: 'w.level = 2; w.complete({ 783 }); w.onQuest(7, { 10 })',
		saved: { Polestar: 'PolestarDB = nil; PolestarCharDB = nil' },
		script: `emit({ guide = E.GetGuide().id, index = E.GetStepIndex(), stored = PolestarCharDB.guide })`,
	});
	assert.deepEqual(cold, { guide: 'test/01-northshire', index: 3, stored: 'test/01-northshire' });

	const [warm] = run({
		guides: NORTHSHIRE + ELWYNN,
		before: 'w.level = 2',
		saved: { Polestar: 'PolestarCharDB = { schema = 1, guide = "test/02-elwynn" }' },
		script: `emit({ guide = E.GetGuide().id, index = E.GetStepIndex() })`,
	});
	assert.deepEqual(warm, { guide: 'test/02-elwynn', index: 1 });

	const [off] = run({
		guides: NORTHSHIRE,
		saved: { Polestar: 'PolestarDB = { schema = 1, settings = { behavior = { autoSelectGuide = false } } }' },
		script: `emit({ guide = E.GetGuide() == nil, index = E.GetStepIndex() == nil })`,
	});
	assert.deepEqual(off, { guide: true, index: true });
});

test('Suggest matches faction, race and class, then level, preferring specific and narrow guides', () => {
	const guides = `
		local function g(id, t) t.id = "test/" .. id; t.pack = "test"; t.title = id; t.steps = { { goals = { { t = "level", level = 60 } } } }; Polestar.RegisterGuide(t) end
		g("human-1", { faction = "Alliance", races = { "Human" }, minLevel = 1, maxLevel = 6 })
		g("dwarf-1", { faction = "Alliance", races = { "Dwarf", "Gnome" }, minLevel = 1, maxLevel = 6 })
		g("alliance-5", { faction = "Alliance", minLevel = 5, maxLevel = 12 })
		g("alliance-10", { faction = "Alliance", minLevel = 10, maxLevel = 20 })
		g("warrior-10", { faction = "Alliance", classes = { "WARRIOR" }, minLevel = 10, maxLevel = 30 })
		g("horde-1", { faction = "Horde", minLevel = 1, maxLevel = 10 })
		g("profession", { minLevel = 1, maxLevel = 60, category = "Professions" })
	`;
	const [out] = run({
		guides,
		login: false,
		script: `
			local w = stub.world
			local function s(race, class, faction, level)
				w.race, w.class, w.faction, w.level = race, class, faction, level
				return Polestar.Guides.Suggest()
			end
			emit({
				s("Human", "MAGE", "Alliance", 1), s("Dwarf", "MAGE", "Alliance", 3), s("Human", "MAGE", "Alliance", 6),
				s("Human", "MAGE", "Alliance", 7), s("Human", "MAGE", "Alliance", 11), s("Human", "WARRIOR", "Alliance", 11),
				s("Orc", "WARRIOR", "Horde", 4), s("Human", "MAGE", "Alliance", 25), s("Orc", "WARRIOR", "Horde", 40),
			})
		`,
	});
	assert.deepEqual(out, [
		'test/human-1', 'test/dwarf-1', 'test/human-1', 'test/alliance-5', 'test/alliance-5', 'test/warrior-10', 'test/horde-1', 'test/alliance-10', 'test/horde-1',
	]);
});

// The Home tab lists Suggestions(): every guide that fits the character's
// level, best first, never a guide for another faction, race or class or a
// non-leveling one; when nothing fits, the nearest upcoming guide alone.
test('Suggestions lists every leveling guide for the level, best first; else the nearest upcoming one', () => {
	const guides = `
		local function g(id, t) t.id = "test/" .. id; t.pack = "test"; t.title = id; t.steps = { { goals = { { t = "level", level = 60 } } } }; Polestar.RegisterGuide(t) end
		g("human-1", { faction = "Alliance", races = { "Human" }, minLevel = 1, maxLevel = 6 })
		g("alliance-5", { faction = "Alliance", minLevel = 5, maxLevel = 12 })
		g("alliance-wide", { faction = "Alliance", minLevel = 1, maxLevel = 20 })
		g("dwarf-1", { faction = "Alliance", races = { "Dwarf" }, minLevel = 1, maxLevel = 6 })
		g("horde-1", { faction = "Horde", minLevel = 1, maxLevel = 10 })
		g("profession", { minLevel = 1, maxLevel = 60, category = "Professions" })
		g("alliance-30", { faction = "Alliance", minLevel = 30, maxLevel = 40 })
	`;
	const [out] = run({
		guides,
		login: false,
		script: `
			local w = stub.world
			local function s(level)
				w.race, w.class, w.faction, w.level = "Human", "MAGE", "Alliance", level
				return Polestar.Guides.Suggestions()
			end
			emit({ s(5), s(25) })
		`,
	});
	assert.deepEqual(out, [['test/human-1', 'test/alliance-5', 'test/alliance-wide'], ['test/alliance-30']]);
});

// A quest that starts from an item the player must first get (here a rare
// elite's drop) reads as the quest, not as "Collect" + "Accept": the view
// says which of the two rows stands for both, and how the item is got.
test('a quest started by a dropped item is one line: the collect stands for it, then the accept; a Go to naming the step is its header', () => {
	const guides = `
		Polestar.RegisterGuide({ id = "test/fog", pack = "test", title = "Field", faction = "Horde", minLevel = 10, maxLevel = 20, steps = {
			{ title = "Field of Giants", goals = {
				{ t = "goto", text = "Field of Giants", map = 1429, x = 44.7, y = 70.7 },
				{ t = "collect", item = 10621, itemName = "Runed Scroll", count = 1, map = 1429, x = 46, y = 70, note = "Aean Swiftriver",
					from = "Aean Swiftriver", fromKind = "npc", fromRank = 2, fromFaction = "A" },
				{ t = "accept", quest = 3513, title = "The Runed Scroll", item = 10621, itemName = "Runed Scroll", note = "Keep it" },
				{ t = "level", level = 20 },
			} },
		} })
	`;
	const [out] = run({
		guides,
		before: 'stub.world.faction = "Horde"; stub.world.race = "Undead"; stub.world.class = "WARLOCK"; stub.world.level = 18',
		script: `
			E.SetGuide("test/fog"); flush()
			local function shape()
				local v = E.GetStepView(1)
				local c, a = v.goals[2], v.goals[3]
				local s = c.starter or a.starter
				return { header = v.goals[1].header or false, cFolded = c.folded or false, aFolded = a.folded or false,
					starterOf = c.starterOf or false, cT = c.t, held = s and s.held or false, item = s and s.item,
					source = s and s.source and { s.source.name, s.source.rank, s.source.enemy } or false }
			end
			local r = { fresh = shape() }
			stub.world.addItem(10621, 1); flush()
			r.held = shape()
			stub.world.accept(3513, {}); flush()
			r.taken = shape()
			emit(r)
		`,
	});
	assert.deepEqual(out.fresh, { header: true, cFolded: false, aFolded: true, starterOf: 3, cT: 'collect', held: false, item: 'Runed Scroll', source: ['Aean Swiftriver', 2, true] }, 'the collect row stands for the quest; an Alliance NPC is one to kill');
	assert.deepEqual(out.held, { header: true, cFolded: true, aFolded: false, starterOf: false, cT: 'collect', held: true, item: 'Runed Scroll', source: ['Aean Swiftriver', 2, true] }, 'with the item in the bags the accept stands alone');
	assert.equal(out.taken.held, false, 'taken: nothing left to right-click');
	assert.equal(out.taken.cFolded, true);
});

// The game's objective names only the item ("Fel Moss: 0/8"); the goal line
// says where it comes from.
test('a collect with a known source names it: kill an enemy for the item, collect from a friend or an object', () => {
	const guides = `
		Polestar.RegisterGuide({ id = "test/src", pack = "test", title = "Src", faction = "Alliance", minLevel = 1, maxLevel = 10, steps = {
			{ title = "Woods", goals = {
				{ t = "collect", quest = 459, title = "The Woodland Protector", item = 3297, itemName = "Fel Moss", count = 8, oi = 1, map = 1438, x = 56, y = 45,
					from = "Grell", fromAlso = "Grellkin", fromKind = "npc", fromFaction = "H" },
				{ t = "collect", item = 159, itemName = "Refreshing Spring Water", count = 2, map = 1429, x = 40, y = 40,
					from = "Innkeeper Farley", fromKind = "npc", fromFaction = "A" },
				{ t = "collect", quest = 36, title = "Westfall Stew", item = 1, itemName = "Oats", count = 1, oi = 1, map = 1436, x = 50, y = 30,
					from = "Sack of Oats", fromKind = "object" },
				{ t = "collect", quest = 36, title = "Westfall Stew", item = 2, itemName = "Peacebloom", count = 1, oi = 2, map = 1436, x = 50, y = 30,
					from = "Peacebloom", fromKind = "object" },
				{ t = "collect", quest = 36, title = "Westfall Stew", item = 3, itemName = "Runed Scroll", count = 1, oi = 3, map = 1436, x = 50, y = 30,
					from = "Aean Swiftriver", fromKind = "npc", fromRank = 2, fromFaction = "A", text = "Get the scroll" },
			} },
		} })
	`;
	const [out] = run({
		guides,
		before: 'stub.world.faction = "Alliance"; stub.world.race = "NightElf"; stub.world.class = "DRUID"; stub.world.level = 5',
		script: `
			E.SetGuide("test/src"); flush()
			local v = E.GetStepView(1)
			local r = {}
			for i = 1, 5 do local g = v.goals[i]; r[i] = { g.text, g.source and g.source.inText or false } end
			emit(r)
		`,
	});
	assert.deepEqual(out, [
		['Kill Grell or Grellkin for Fel Moss', true],
		['Collect Refreshing Spring Water from Innkeeper Farley', true],
		['Collect Oats from Sack of Oats', true],
		['Collect Peacebloom', false],
		['Get the scroll', false],
	]);
});

test('RegisterGuide rejects malformed guides with a debug message instead of erroring', () => {
	const [out] = run({
		guides: '',
		login: false,
		script: `
			Polestar.debug = true
			local results = {}
			local function try(def) local ok, err = Polestar.RegisterGuide(def); results[#results + 1] = ok and "ok" or err end
			try("nope")
			try({ title = "No id", steps = { { goals = { { t = "level", level = 2 } } } } })
			try({ id = "test/a", pack = "test", title = "No steps", steps = {} })
			try({ id = "test/b", pack = "test", title = "Empty step", steps = { { goals = {} } } })
			try({ id = "test/c", pack = "test", title = "Bad verb", steps = { { goals = { { t = "dance" } } } } })
			try({ id = "test/d", pack = "test", title = "Missing quest", steps = { { goals = { { t = "accept", title = "X" } } } } })
			try({ id = "test/e", pack = "test", title = "Bad coords", steps = { { goals = { { t = "goto", map = 1, x = 120, y = 5 } } } } })
			try({ id = "test/f", pack = "test", title = "Good", minLevel = 1, maxLevel = 2, steps = { { goals = { { t = "note", text = "hi", extra = 1 } } } } })
			local ids = {}
			for i, h in ipairs(Polestar.Guides.List()) do ids[i] = h.id .. ":" .. h.stepCount .. ":" .. tostring(h.steps) end
			emit({ results = results, ids = ids, debugLines = #stub.messages })
		`,
	});
	assert.deepEqual(out.results, [
		'guide is not a table',
		'missing id',
		'no steps',
		'step 1 has no goals',
		'step 1 goal 1: unknown verb dance',
		'step 1 goal 1: accept needs quest',
		'step 1 goal 1: coordinates outside 0-100',
		'ok',
	]);
	assert.deepEqual(out.ids, ['test/f:1:nil']);
	assert.equal(out.debugLines, 7);
});

test('completing a guide chains to `next` when autoNextGuide is on, and not when it is off', () => {
	const guides = `
		Polestar.RegisterGuide({ id = "test/a", pack = "test", title = "A", minLevel = 1, maxLevel = 2, next = "test/b", steps = { { goals = { { t = "level", level = 2 } } } } })
		Polestar.RegisterGuide({ id = "test/b", pack = "test", title = "B", minLevel = 2, maxLevel = 3, steps = { { goals = { { t = "level", level = 3 } } } } })
	`;
	const [on] = run({
		guides,
		script: `takeLog(); stub.world.setLevel(2); flush()
			emit({ log = takeLog(), guide = E.GetGuide().id, stored = PolestarCharDB.guide, index = E.GetStepIndex() })`,
	});
	assert.deepEqual(on, {
		log: ['STEP_CHANGED nil', 'GUIDE_COMPLETED test/a', 'GUIDE_CHANGED test/b', 'STEP_CHANGED 1'],
		guide: 'test/b',
		stored: 'test/b',
		index: 1,
	});

	const [off] = run({
		guides,
		saved: { Polestar: 'PolestarDB = { schema = 1, settings = { behavior = { autoNextGuide = false } } }' },
		script: `takeLog(); stub.world.setLevel(2); flush()
			emit({ log = takeLog(), guide = E.GetGuide().id })`,
	});
	assert.deepEqual(off, { log: ['STEP_CHANGED nil', 'GUIDE_COMPLETED test/a'], guide: 'test/a' });

	const [atLogin] = run({
		guides,
		before: 'w.level = 2',
		saved: { Polestar: 'PolestarCharDB = { schema = 1, guide = "test/a" }' },
		script: `emit({ log = takeLog(), guide = E.GetGuide().id })`,
	});
	assert.deepEqual(atLogin, {
		log: ['GUIDE_CHANGED test/a', 'GUIDE_COMPLETED test/a', 'GUIDE_CHANGED test/b', 'STEP_CHANGED 1'],
		guide: 'test/b',
	});

	// Picking a finished guide by hand reports it complete but stays on it.
	const [picked] = run({
		guides,
		before: 'w.level = 2',
		saved: { Polestar: 'PolestarDB = { schema = 1, settings = { behavior = { autoSelectGuide = false } } }' },
		script: `takeLog(); E.SetGuide("test/a")
			emit({ log = takeLog(), guide = E.GetGuide().id })`,
	});
	assert.deepEqual(picked, { log: ['GUIDE_CHANGED test/a', 'GUIDE_COMPLETED test/a'], guide: 'test/a' });
});

test('Prev, Next, Skip and Goto move the current step; only Skip saves a skip, Goto ahead looks without skipping', () => {
	const [out] = run({
		before: `w.complete({ 783 }); w.onQuest(7, { 10 })`,
		script: `
			local trail = {}
			local function mark(label) trail[#trail + 1] = label .. "=" .. tostring(E.GetStepIndex()) end
			mark("start")
			E.Prev(); mark("prev")
			local pinnedStatus = E.GetStepView(2).status
			E.Next(); mark("next")
			E.Skip(); mark("skip")
			local skippedStatus = E.GetStepView(3).status
			local stored = PolestarCharDB.skipped["test/01-northshire"][3]
			E.Goto(3); mark("goto3")
			E.Goto(6); mark("goto6")
			local jumped = { E.GetStepView(3).status, E.GetStepView(4).status, E.GetStepView(5).status, E.GetLiveStep() }
			E.Prev(); mark("prev")
			E.Next(); mark("next")
			SlashCmdList.POLESTAR("reset")
			mark("reset")
			emit({ trail = trail, pinnedStatus = pinnedStatus, skippedStatus = skippedStatus, stored = stored, jumped = jumped,
				skipped = PolestarCharDB.skipped["test/01-northshire"] == nil })
		`,
	});
	assert.deepEqual(out, {
		trail: ['start=3', 'prev=2', 'next=3', 'skip=4', 'goto3=3', 'goto6=6', 'prev=4', 'next=6', 'reset=3'],
		pinnedStatus: 'current',
		skippedStatus: 'skipped',
		stored: true,
		jumped: ['upcoming', 'upcoming', 'na', 3],
		skipped: true,
	});
});

test('Prev walks back over every applicable step, done or skipped, and Next walks the same steps forward without touching skips', () => {
	const guides = `
		local function accept(q, extra)
			local goal = { t = "accept", quest = q, title = "Quest " .. q }
			local step = { goals = { goal } }
			for k, v in pairs(extra or {}) do step[k] = v end
			return step
		end
		Polestar.RegisterGuide({ id = "test/walk", pack = "test", title = "Walk", minLevel = 1, maxLevel = 60, steps = {
			accept(901),                                 -- done (turned in)
			accept(902),                                 -- open, skipped earlier
			accept(903, { only = { classes = { "MAGE" } } }), -- not for a Warrior
			accept(904),                                 -- done (in the log)
			accept(905),                                 -- open: the computed step
			accept(906),
		} })
	`;
	const [out] = run({
		guides,
		before: 'w.complete({ 901 }); w.onQuest(904, {})',
		saved: { Polestar: 'PolestarCharDB = { schema = 1, guide = "test/walk", skipped = { ["test/walk"] = { [2] = true } } }' },
		script: `
			local back, forward = {}, {}
			local start = E.GetStepIndex()
			for k = 1, 4 do E.Prev(); flush(); back[k] = E.GetStepIndex() .. ":" .. E.GetStepView(E.GetStepIndex()).goals[1].status end
			for k = 1, 3 do E.Next(); flush(); forward[k] = E.GetStepIndex() end
			local skips = {}
			for s in pairs(PolestarCharDB.skipped["test/walk"]) do skips[#skips + 1] = s end
			table.sort(skips)
			E.Next(); flush()
			local after = {}
			for s in pairs(PolestarCharDB.skipped["test/walk"]) do after[#after + 1] = s end
			emit({ start = start, back = back, forward = forward, skips = skips, skipNext = E.GetStepIndex(), live = E.GetLiveStep(), after = after })
		`,
	});
	assert.deepEqual(out, {
		start: 5,
		// Step 3 is Mage-only; the skipped step 2 is shown, not un-skipped.
		back: ['4:done', '2:active', '1:done', '1:done'],
		forward: [2, 4, 5],
		skips: [2],
		skipNext: 6, // Next on the live step looks ahead...
		live: 5,
		after: [2], // ...and skips nothing
	});
});

test('talk, sethome, getfp, fly, vendor, buy, collect and hearth complete from interactions', () => {
	const guide = `
		Polestar.RegisterGuide({ id = "test/actions", pack = "test", title = "Actions", minLevel = 1, maxLevel = 10, steps = {
			{ goals = { { t = "talk", npc = 197, npcName = "Marshal McBride" } } },
			{ goals = { { t = "sethome", location = "Goldshire", npc = 295, npcName = "Innkeeper Farley" } } },
			{ goals = { { t = "getfp", location = "Stormwind", npc = 352, npcName = "Dungar Longdrink" } } },
			{ goals = { { t = "fly", location = "Stormwind City" } } },
			{ goals = { { t = "vendor", npc = 54, npcName = "Corina Steele" } } },
			{ goals = { { t = "buy", item = 159, itemName = "Refreshing Spring Water", count = 5 } } },
			{ goals = { { t = "collect", item = 750, itemName = "Tough Wolf Meat", count = 3 } } },
			{ goals = { { t = "hearth", location = "Goldshire" } } },
			{ goals = { { t = "level", level = 99 } } },
		} })
	`;
	const [out] = run({
		guides: guide,
		script: `
			local w = stub.world
			local trail = {}
			local function mark(label) trail[#trail + 1] = label .. "=" .. tostring(E.GetStepIndex()) end
			w.merchant(54); w.close(); flush(); mark("early-vendor")
			w.gossip(198); w.close(); flush(); mark("wrong-npc")
			w.gossip(197); flush(); w.close(); mark("talk")
			w.bind("Goldshire"); flush(); mark("bind")
			w.taxi(352, "Stormwind, Elwynn", { "Sentinel Hill, Westfall" }); w.close(); flush(); mark("fp")
			w.setZone("Stormwind City", "Trade District"); flush(); mark("fly")
			w.merchant(54); w.close(); flush(); mark("vendor")
			w.addItem(159, 5); flush(); mark("buy")
			w.addItem(750, 2); flush(); mark("collect-2")
			local progress = E.GetStepView(7).goals[1].progress
			w.addItem(750, 1); flush(); mark("collect-3")
			w.setZone("Elwynn Forest", "Goldshire"); flush(); mark("hearth")
			-- Conditions that stop holding later do not reopen passed steps.
			w.bind("Stormwind City"); w.items[159] = 0; w.items[750] = 0; w.addItem(1, 1)
			w.setZone("Westfall", "Sentinel Hill"); flush(); mark("moved-on")
			local texts = {}
			for i = 1, 8 do texts[i] = E.GetStepView(i).goals[1].text end
			emit({ trail = trail, fp = PolestarCharDB.flags.fp, progress = progress, texts = texts })
		`,
	});
	assert.deepEqual(out.trail, [
		'early-vendor=1', 'wrong-npc=1', 'talk=2', 'bind=3', 'fp=4', 'fly=5', 'vendor=6', 'buy=7', 'collect-2=7', 'collect-3=8', 'hearth=9', 'moved-on=9',
	]);
	assert.deepEqual(out.fp, { 'Stormwind, Elwynn': true });
	assert.deepEqual(out.progress, { cur: 2, max: 3, kind: 'count' });
	assert.deepEqual(out.texts, [
		'Talk to Marshal McBride',
		'Set your home to Goldshire',
		'Get the flight path at Stormwind',
		'Fly to Stormwind City',
		'Sell and repair at Corina Steele',
		'Buy Refreshing Spring Water',
		'Collect Tough Wolf Meat',
		'Hearth to Goldshire',
	]);
});

test('a step that hearths and then flies completes when the flight lands: the hearth counts as done once a later goal is', () => {
	const guide = `
		Polestar.RegisterGuide({ id = "test/travel", pack = "test", title = "Travel", minLevel = 1, maxLevel = 10, steps = {
			{ goals = { { t = "hearth", location = "Goldshire" }, { t = "fly", location = "Stormwind City" } } },
			{ goals = { { t = "level", level = 99 } } },
		} })
	`;
	const [out] = run({
		guides: guide,
		script: `
			local w = stub.world
			w.setZone("Elwynn Forest", "Goldshire"); flush()
			local atInn = { E.GetStepIndex(), E.GetStepView(1).goals[1].status, E.GetStepView(1).goals[2].status }
			w.setZone("Stormwind City", "Trade District"); flush()
			emit({ atInn = atInn, landed = E.GetStepIndex() })
		`,
	});
	// At the inn the flight is still to do; once it lands the inn is behind
	// the player, yet the step is done and the guide moves on.
	assert.deepEqual(out, { atInn: [1, 'done', 'active'], landed: 2 });
});

test('bursts of quest events are coalesced to at most 10 evaluations per second', () => {
	const [out] = run({
		script: `
			local n = 0
			local real = Polestar.Compat.GetPlayerInfo
			Polestar.Compat.GetPlayerInfo = function() n = n + 1; return real() end
			for i = 1, 100 do
				stub.fire("QUEST_LOG_UPDATE")
				stub.advance(0.01)
			end
			emit(n)
		`,
	});
	assert.ok(out >= 5 && out <= 11, `evaluations: ${out}`);
});

test('slash commands drive the engine and report status', () => {
	const [out] = run({
		guides: NORTHSHIRE + ELWYNN,
		before: `w.complete({ 783 }); w.onQuest(7, { { required = 10, fulfilled = 4 } })`,
		script: `
			stub.messages = {}
			SlashCmdList.POLESTAR("status")
			local status = stub.messages
			stub.messages = {}
			SlashCmdList.POLESTAR("skip")
			local afterSkip = E.GetStepIndex()
			SlashCmdList.POLESTAR("prev")
			local afterPrev = E.GetStepIndex()
			SlashCmdList.POLESTAR("guide nope")
			SlashCmdList.POLESTAR("guide test/02-elwynn")
			local exact = E.GetGuide().id
			SlashCmdList.POLESTAR("guide test/01-northshire")
			SlashCmdList.POLESTAR("guide Test/02-Elwynn")
			emit({ status = status, afterSkip = afterSkip, afterPrev = afterPrev, exact = exact, guide = E.GetGuide().id, msgs = stub.messages,
				header = BINDING_HEADER_POLESTAR, binding = BINDING_NAME_POLESTAR_NEXT })
		`,
	});
	assert.deepEqual(out.status, [
		'|cff4fd1c5Polestar|r: Northshire Valley: step 3 of 6 (2/5 done)',
		'  [ ] Go to Kobold camp',
		'  [ ] Kill Kobold Vermin (4/10)',
	]);
	assert.equal(out.afterSkip, 4);
	assert.equal(out.afterPrev, 3);
	assert.equal(out.exact, 'test/02-elwynn');
	// A mixed-case id finds the lower-case guide.
	assert.equal(out.guide, 'test/02-elwynn');
	assert.deepEqual(out.msgs, [
		"|cff4fd1c5Polestar|r: Unknown guide 'nope'.",
		'|cff4fd1c5Polestar|r: Guide: Elwynn Forest',
		'|cff4fd1c5Polestar|r: Guide: Northshire Valley',
		'|cff4fd1c5Polestar|r: Guide: Elwynn Forest',
	]);
	assert.equal(out.header, 'Polestar');
	assert.equal(out.binding, 'Next step');
});

// A `complete` goal counts its quest's objectives from the log (summed, so the
// window redraws on every loot or kill) and, for a quest with several, lists
// the open ones in the game's words under the goal (a player's report: The
// Hunt Begins showed no x of y).
const HUNT = `
Polestar.RegisterGuide({
	id = "test/hunt", pack = "test", title = "Camp Narache", faction = "Alliance", minLevel = 1, maxLevel = 4, zone = 1429,
	steps = {
		{ title = "The Hunt Begins", goals = {
			{ t = "complete", quest = 747, title = "The Hunt Begins" },
			{ t = "complete", quest = 752, title = "A Humble Task" },
		} },
		{ title = "Grull Hawkwind", goals = {
			{ t = "turnin", quest = 747, title = "The Hunt Begins", npc = 2980, npcName = "Grull Hawkwind" },
		} },
	},
})
`;

test('a quest to complete shows its objectives\' count, and the open ones when it has several', () => {
	const [log, start, meat, fed] = run({
		guides: NORTHSHIRE + HUNT,
		before: `w.onQuest(747, { { text = "Plainstrider Meat", required = 7 }, { text = "Plainstrider Feathers: 0/7", required = 7, type = "item" } })
			w.onQuest(752, { { text = "Water Pitcher", required = 1, type = "item" } })`,
		script: `
			local w = stub.world
			E.SetGuide("test/hunt"); flush(); takeLog()
			local function goals()
				local v = E.GetStepView(1)
				return { v.goals[1].progress, v.goals[1].objectives or false, v.goals[2].progress or false, v.goals[2].objectives or false }
			end
			local start = goals()
			w.progress(747, 1, 3); flush()
			local meat = goals()
			w.progress(747, 1, 9); flush()
			local fed = goals()
			emit(takeLog()); emit(start); emit(meat); emit(fed)
		`,
	});
	assert.deepEqual(start, [{ cur: 0, max: 14, kind: 'count' }, ['Plainstrider Meat 0/7', 'Plainstrider Feathers: 0/7'], { cur: 0, max: 1, kind: 'count' }, false]);
	assert.deepEqual(meat, [{ cur: 3, max: 14, kind: 'count' }, ['Plainstrider Meat 3/7', 'Plainstrider Feathers: 0/7'], { cur: 0, max: 1, kind: 'count' }, false]);
	// Looting past the need counts the need; a finished objective leaves the list.
	assert.deepEqual(fed, [{ cur: 7, max: 14, kind: 'count' }, ['Plainstrider Feathers: 0/7'], { cur: 0, max: 1, kind: 'count' }, false]);
	assert.deepEqual(log, ['STEP_UPDATED 1', 'STEP_UPDATED 1'], 'each count change redraws the step');
});
