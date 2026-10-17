'use strict';
// The player's own word over the guide (addon/Polestar/Core/Engine.lua):
// › and ‹ look ahead and back without changing anything, Skip is the only
// way a step is skipped (and Unskip undoes it), every goal ticks done and
// back, optional goals skip with one click, all of it saved and honoured by a
// reload; the arrow follows the current goal. Real Core manifest, stub world.

const { test } = require('node:test');
const assert = require('node:assert/strict');
const { runAddon } = require('./helpers/lua');
const { TEST_PACK, TEST_SOURCE } = require('./helpers/packs');
const { luaValue } = require('../tools/lib/playtest');

const CORE = { name: 'Polestar', files: ['Core/Core.xml'] };

// Elwynn: 3000 x 2000 yards, so 1% is 30 yd across and 20 yd down.
const WORLD = `
local w = stub.world
w.addMap(1429, { name = "Elwynn Forest", c = 0, left = 1500, right = -1500, top = 500, bottom = -1500 })
w.moveTo(1429, 48, 42)
w.titles[783] = "A Threat Within"; w.titles[7] = "Kobold Camp Cleanup"
`;

// A Northshire-shaped route for a Warrior: step 5 is Mage-only.
const ROUTE = `
Polestar.RegisterGuide({
	id = "test/route", pack = "test", title = "Route", minLevel = 1, maxLevel = 10,
	steps = {
		{ title = "Deputy Willem", goals = {
			{ t = "accept", quest = 783, title = "A Threat Within", npc = 823, npcName = "Deputy Willem", map = 1429, x = 48.2, y = 42.0 },
		} },
		{ title = "Marshal McBride", goals = {
			{ t = "turnin", quest = 783, title = "A Threat Within", npc = 197, npcName = "Marshal McBride", map = 1429, x = 48.9, y = 41.6 },
			{ t = "accept", quest = 7, title = "Kobold Camp Cleanup", npc = 197, npcName = "Marshal McBride", map = 1429, x = 48.9, y = 41.6 },
		} },
		{ title = "Kobold camp", goals = {
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
			{ t = "level", level = 4 },
		} },
	},
})
`;

const HELPERS = `
E = Polestar.Engine
function flush() stub.advance(0.25) end
-- A table's keys, sorted and joined ("1:1,3"; "" for none).
function keys(t)
	local out = {}
	for k in pairs(t or {}) do out[#out + 1] = tostring(k) end
	table.sort(out)
	return table.concat(out, ",")
end
`;

function run({ guides = ROUTE, before = '', saved, script }) {
	return runAddon({
		stubs: ['stub_world.lua'],
		before: WORLD + before,
		addons: [CORE],
		saved: saved ? { Polestar: saved } : undefined,
		script: `${TEST_PACK}
${TEST_SOURCE}\n${guides}\n${HELPERS}\nstub.login()\nstub.fire("QUEST_LOG_UPDATE"); stub.advance(0.6)\n${script}`,
	}).emitted;
}

// SavedVariables as the client writes them at a reload: the script ends with
// stub.fire("PLAYER_LOGOUT") and emits PolestarCharDB; this turns it back
// into the chunk the next session loads.
function reloadOf(charDB) {
	return `PolestarCharDB = ${luaValue(charDB)}`;
}

const AT_CAMP = `w.complete({ 783 }); w.onQuest(7, { 10 })`; // the kobolds are the live step (3)

test('› looks ahead and ‹ back without skipping anything; Skip skips the step shown and Unskip undoes it', () => {
	const [out] = run({
		before: AT_CAMP,
		saved: 'PolestarCharDB = { schema = 1, guide = "test/route" }',
		script: `
			local trail = {}
			local function mark(label) trail[#trail + 1] = label .. "=" .. tostring(E.GetStepIndex()) .. "/" .. tostring(E.GetLiveStep()) end
			mark("start")
			E.Next(); flush(); mark("next")
			local ahead = { E.GetStepView(4).status, E.GetStepView(3).status }
			E.Next(); flush(); mark("next")
			E.Next(); flush(); mark("end")
			E.Prev(); flush(); mark("prev")
			E.Prev(); flush(); mark("prev")
			local untouched = keys(PolestarCharDB.skipped["test/route"])
			E.Skip(); flush(); mark("skip")
			local skipped = keys(PolestarCharDB.skipped["test/route"])
			local view3 = E.GetStepView(3)
			local undone = E.Unskip(3); flush(); mark("unskip")
			emit({ trail = trail, ahead = ahead, untouched = untouched, skipped = skipped, skippedView = { view3.status, view3.skipped },
				undone = undone, after = keys(PolestarCharDB.skipped["test/route"]) })
		`,
	});
	assert.deepEqual(out.trail, ['start=3/3', 'next=4/3', 'next=6/3', 'end=6/3', 'prev=4/3', 'prev=3/3', 'skip=4/4', 'unskip=3/3']);
	assert.deepEqual(out.ahead, ['current', 'upcoming'], 'looking ahead: the live step is still to do, not skipped');
	assert.equal(out.untouched, '', '› and ‹ never skip');
	assert.equal(out.skipped, '3');
	assert.deepEqual(out.skippedView, ['skipped', true]);
	assert.equal(out.undone, true);
	assert.equal(out.after, '');
});

test('looking ahead at an accept: taking the quest moves on to its objective step even while the log has not filled in the objectives yet (regression: Barak Kodobane passed for the Kolkar Leaders turn-in)', () => {
	const guides = `
		Polestar.RegisterGuide({ id = "test/kolkar", pack = "test", title = "Kolkar", minLevel = 1, maxLevel = 30, steps = {
			{ title = "Sergra", goals = { { t = "accept", quest = 3261, title = "Jorn Skyseer", npc = 3338 } } },
			{ title = "Regthar", goals = { { t = "accept", quest = 850, title = "Kolkar Leaders", npc = 3389 } } },
			{ title = "Barak", goals = { { t = "collect", item = 5022, itemName = "Barak's Head", count = 1, quest = 850, oi = 1 } } },
			{ title = "Regthar", goals = { { t = "turnin", quest = 850, title = "Kolkar Leaders", npc = 3389 } } },
		} })`;
	const [out] = run({
		guides,
		saved: 'PolestarCharDB = { schema = 1, guide = "test/kolkar" }',
		script: `
			local w = stub.world
			Polestar.Set("behavior.autoAccept", false)
			E.Goto(2); flush()
			local r = { looking = E.GetStepIndex() }
			w.accept(850, {}); flush() -- in the log, its objectives not there yet
			r.accepted = E.GetStepIndex()
			w.log[850].objectives = { { text = "Barak's Head: 0/1", type = "item", numFulfilled = 0, numRequired = 1, finished = false } }
			stub.fire("QUEST_LOG_UPDATE"); flush()
			r.filled = { E.GetStepIndex(), E.GetLiveStep(), E.GetStepView(3).status }
			emit(r)
		`,
	});
	assert.equal(out.looking, 2);
	assert.equal(out.accepted, 3, 'the head is still to get');
	assert.deepEqual(out.filled, [3, 1, 'current']);
});

test('Skip while looking ahead skips the step shown and moves on from it, leaving the live step alone', () => {
	const [out] = run({
		before: AT_CAMP,
		saved: 'PolestarCharDB = { schema = 1, guide = "test/route" }',
		script: `
			E.Next(); flush()
			E.Skip(); flush()
			emit({ at = E.GetStepIndex(), live = E.GetLiveStep(), skipped = keys(PolestarCharDB.skipped["test/route"]) })
		`,
	});
	assert.deepEqual(out, { at: 6, live: 3, skipped: '4' });
});

test('a reload keeps the position: a skipped step stays skipped even with its quest under way', () => {
	// The kobolds (step 3) were skipped with Kobold Camp Cleanup in the log and
	// some kills done; the route went on to training.
	const [out] = run({
		before: `w.complete({ 783 }); w.onQuest(7, { { required = 10, fulfilled = 4 } })`,
		saved: 'PolestarCharDB = { schema = 1, tabs = { "test/route" }, activeTab = 1, skipped = { ["test/route"] = { [3] = true } } }',
		script: `emit({ at = E.GetStepIndex(), skipped = keys(PolestarCharDB.skipped["test/route"]) })`,
	});
	assert.deepEqual(out, { at: 4, skipped: '3' });
});

test('a reload or a relog at a new level keeps the position: quests their giver did not offer stay passed until the giver offers them (#161)', () => {
	const GUIDE = `
		Polestar.RegisterGuide({ id = "test/xr", pack = "test", title = "Crossroads", minLevel = 10, maxLevel = 20, steps = {
			{ title = "Thork", goals = {
				{ t = "accept", quest = 870, title = "The Forgotten Pools", npc = 3429, npcName = "Thork", map = 1429, x = 51, y = 30 },
				{ t = "accept", quest = 869, title = "Raptor Thieves", npc = 3464, npcName = "Gazrog", map = 1429, x = 52, y = 30 },
			} },
			{ title = "Raptors", goals = { { t = "collect", item = 5062, itemName = "Raptor Head", count = 12, quest = 869, oi = 1, map = 1429, x = 45, y = 20 } } },
			{ goals = { { t = "level", level = 30 } } },
		} })
	`;
	const before = 'w.level = 12';
	const [first] = run({
		guides: GUIDE,
		before,
		saved: 'PolestarDB = { schema = 1, settings = { behavior = { autoAccept = false } } }; PolestarCharDB = { schema = 1, guide = "test/xr" }',
		script: `
			local w = stub.world
			w.gossip(3429, { available = {} }); w.close(); flush()
			w.gossip(3464, { available = { { questID = 869 } } }); w.close(); w.accept(869, { 12 }); flush()
			local at = E.GetStepIndex()
			stub.fire("PLAYER_LOGOUT")
			emit({ at = at, db = PolestarCharDB })
		`,
	});
	assert.equal(first.at, 2);
	const script = `emit({ at = E.GetStepIndex(), status = E.GetStepView(1).goals[1].status, why = E.GetStepView(1).goals[1].unavailable or false })`;
	const [reload] = run({ guides: GUIDE, before: `${before}; w.onQuest(869, { 12 })`, saved: reloadOf(first.db), script });
	assert.deepEqual(reload, { at: 2, status: 'skipped', why: 'offer' }, 'the reload keeps the player at the raptors');
	const asked = `
		local w = stub.world
		local r = { at = E.GetStepIndex(), why = E.GetStepView(1).goals[1].unavailable or false }
		w.gossip(3429, { available = { { questID = 870 } } }); flush()
		r.offered = E.GetStepIndex()
		emit(r)
	`;
	const [levelled] = run({ guides: GUIDE, before: `w.level = 13; w.onQuest(869, { 12 })`, saved: reloadOf(first.db), script: asked });
	assert.deepEqual(levelled, { at: 2, why: 'offer', offered: 1 }, 'a level later the guide stays at the raptors; Thork offering it takes it back');
	// Saves from before kept the level the quest was refused at.
	const older = reloadOf({ ...first.db, offers: { 870: 12 } });
	const [old] = run({ guides: GUIDE, before: `w.level = 13; w.onQuest(869, { 12 })`, saved: older, script: asked });
	assert.deepEqual(old, { at: 2, why: 'offer', offered: 1 });
});

test('a pack update that moves steps keeps check-offs, skips and the place the player was looking at', () => {
	const v1 = `
		Polestar.RegisterGuide({ id = "test/mv", pack = "test", title = "Moves", minLevel = 1, maxLevel = 60, steps = {
			{ goals = { { t = "accept", quest = 901, title = "One", npc = 1 } } },
			{ goals = { { t = "accept", quest = 902, title = "Two", npc = 2 } } },
			{ goals = { { t = "accept", quest = 903, title = "Three", npc = 3 } } },
			{ goals = { { t = "accept", quest = 904, title = "Four", npc = 4 } } },
			{ goals = { { t = "level", level = 60 } } },
		} })
	`;
	// The update puts a new step in front.
	const v2 = v1.replace('steps = {', 'steps = {\n\t\t\t{ goals = { { t = "level", level = 1 } } },');
	const [first] = run({
		guides: v1,
		saved: 'PolestarCharDB = { schema = 1, guide = "test/mv" }',
		script: `
			E.ToggleGoal(1, 1); flush()
			E.Skip(); flush()
			E.Next(); flush()
			local at = { E.GetStepIndex(), E.GetLiveStep() }
			stub.fire("PLAYER_LOGOUT")
			emit({ at = at, db = PolestarCharDB })
		`,
	});
	assert.deepEqual(first.at, [4, 3]);
	const [updated] = run({
		guides: v2,
		saved: reloadOf(first.db),
		script: `emit({ at = { E.GetStepIndex(), E.GetLiveStep() }, manual = keys(PolestarCharDB.manual["test/mv"]), skipped = keys(PolestarCharDB.skipped["test/mv"]) })`,
	});
	assert.deepEqual(updated, { at: [5, 4], manual: '2:1', skipped: '3' });
});

test('a look-ahead survives a reload, and a step left behind by the guide releases it', () => {
	const [first] = run({
		before: AT_CAMP,
		saved: 'PolestarCharDB = { schema = 1, guide = "test/route" }',
		script: `E.Next(); E.Next(); flush(); stub.fire("PLAYER_LOGOUT"); emit({ at = E.GetStepIndex(), db = PolestarCharDB })`,
	});
	assert.equal(first.at, 6);
	const [reload] = run({ before: AT_CAMP, saved: reloadOf(first.db), script: 'emit({ E.GetStepIndex(), E.GetLiveStep() })' });
	assert.deepEqual(reload, [6, 3]);
	const [caughtUp] = run({
		before: AT_CAMP,
		saved: reloadOf(first.db),
		script: `
			local w = stub.world
			w.progress(7, 1, 10); flush()
			w.trainer(911); w.close(); flush()
			emit({ E.GetStepIndex(), E.GetLiveStep() })
		`,
	});
	assert.deepEqual(caughtUp, [6, 6], 'the guide reached the step looked at');
});

test('every goal ticks done and back; ticks are saved, place the guide after a reload and count in its progress', () => {
	const [first] = run({
		before: AT_CAMP,
		saved: 'PolestarCharDB = { schema = 1, guide = "test/route" }',
		script: `
			local r = {}
			local d0 = E.GetProgress()
			r.ok = E.ToggleGoal(3, 2); flush()
			local v = E.GetStepView(3)
			r.view = { v.goals[2].status, v.goals[2].ticked, v.goals[1].status }
			r.at = E.GetStepIndex()
			r.progress = E.GetProgress() - d0
			r.saved = PolestarCharDB.manual["test/route"]["3:2"]
			stub.fire("PLAYER_LOGOUT")
			r.db = PolestarCharDB
			emit(r)
		`,
	});
	assert.equal(first.ok, true);
	assert.deepEqual(first.view, ['done', true, 'done'], 'the kill ticked, the camp header with it');
	assert.equal(first.at, 4);
	assert.equal(first.progress, 1);
	assert.equal(first.saved, 'tick');
	const [reload] = run({
		before: AT_CAMP,
		saved: reloadOf(first.db),
		script: `
			local at = E.GetStepIndex()
			E.ToggleGoal(3, 2); flush()
			emit({ at = at, untick = E.GetStepIndex(), saved = keys(PolestarCharDB.manual["test/route"]) })
		`,
	});
	// The camp's Go to stays latched: the route passed it.
	assert.deepEqual(reload, { at: 4, untick: 3, saved: '3:1' });
});

test('an accept ticked without taking the quest drops its later goals; taking it brings them back', () => {
	const [out] = run({
		saved: 'PolestarCharDB = { schema = 1, guide = "test/route" }',
		script: `
			local r = {}
			E.ToggleGoal(1, 1); flush()
			r.ticked = { E.GetStepView(2).goals[1].status, E.GetStepView(2).goals[2].status, E.GetStepIndex() }
			stub.world.accept(783, {}, "A Threat Within"); flush()
			r.taken = { E.GetStepView(2).goals[1].status, E.GetStepIndex() }
			emit(r)
		`,
	});
	assert.deepEqual(out.ticked, ['na', 'active', 2], "the turn-in of a quest never taken is not work; the step's other accept is");
	assert.deepEqual(out.taken, ['active', 2]);
});

// Issue #108: Distracting Jarven (308) is handed in straight from Jarven
// Thunderbrew's window, with no accept. `turnin ... direct` is that goal; the
// client never flags such a quest completed when it repeats, so the hand-in is
// stored like the Engine's other latched results.
const DIRECT = (direct) => `
	Polestar.RegisterGuide({ id = "test/direct", pack = "test", title = "Direct", minLevel = 1, maxLevel = 60, steps = {
		{ title = "Jarven Thunderbrew", goals = {
			{ t = "turnin", quest = 308, title = "Distracting Jarven", ${direct ? 'direct = true, ' : ''}npc = 1373, npcName = "Jarven Thunderbrew", map = 1429, x = 49.0, y = 42.0 },
		} },
		{ title = "The barrel", goals = { { t = "level", level = 5 } } },
	} })`;

test('#108: a `direct` turn-in is work without an accept, and the hand-in is saved even when the quest is never flagged completed', () => {
	const [out] = run({
		guides: DIRECT(true),
		saved: 'PolestarCharDB = { schema = 1, guide = "test/direct" }',
		script: `
			local r = { before = E.GetStepView(1).goals[1].status, at = E.GetStepIndex() }
			-- The hand-in itself: no accept, and a repeatable leaves no completed flag.
			stub.fire("QUEST_TURNED_IN", 308); flush()
			r.after = E.GetStepView(1).goals[1].status
			r.flagged = stub.world.completed[308] == true
			r.saved = PolestarCharDB.manual["test/direct"]["1:1"]
			r.moved = E.GetStepIndex()
			stub.fire("PLAYER_LOGOUT")
			r.db = PolestarCharDB
			emit(r)
		`,
	});
	assert.equal(out.before, 'active', 'a direct turn-in has no accept, so it must not read as orphaned');
	assert.equal(out.at, 1);
	assert.equal(out.after, 'done');
	assert.equal(out.flagged, false, 'the quest repeats: the client flags nothing');
	assert.equal(out.saved, true);
	assert.equal(out.moved, 2);

	// The reload the issue describes: without the stored hand-in the goal would
	// be open again, since nothing in the client remembers it.
	const [reload] = run({
		guides: DIRECT(true),
		saved: reloadOf(out.db),
		script: 'emit({ at = E.GetStepIndex(), status = E.GetStepView(1).goals[1].status })',
	});
	assert.deepEqual(reload, { at: 2, status: 'done' });
});

test('#108: the same turn-in without `direct` reads as another route\'s work, and its hand-in is forgotten at a reload', () => {
	const [out] = run({
		guides: DIRECT(false),
		saved: 'PolestarCharDB = { schema = 1, guide = "test/direct" }',
		script: `
			local before = E.GetStepView(1).goals[1].status
			stub.fire("QUEST_TURNED_IN", 308); flush()
			local r = { before = before, after = E.GetStepView(1).goals[1].status, saved = PolestarCharDB.manual["test/direct"] }
			stub.fire("PLAYER_LOGOUT")
			r.db = PolestarCharDB
			emit(r)
		`,
	});
	assert.equal(out.before, 'na', 'a turn-in with no accept is orphaned');
	// The Engine remembers the turn-in for the session, so the goal does tick;
	// nothing is stored, because only a direct turn-in is latched.
	assert.equal(out.after, 'done');
	assert.equal(out.saved, undefined);
	const [reload] = run({
		guides: DIRECT(false),
		saved: reloadOf(out.db),
		script: 'emit(E.GetStepView(1).goals[1].status)',
	});
	assert.equal(reload, 'na', 'the hand-in is gone: a repeatable would come back as undone');
});

// The cloth donations: Additional Runecloth (7796) repeats, a `turnin 7796
// direct` in each step. The session's memory of a turn-in must not close the
// later steps' goals: one hand-in is one goal.
test('#108: one hand-in of a repeatable `direct` quest checks off one goal, not every later one', () => {
	const GUIDE = `
		Polestar.RegisterGuide({ id = "test/cloth", pack = "test", title = "Cloth", minLevel = 1, maxLevel = 60, steps = {
			{ title = "First", goals = { { t = "turnin", quest = 7796, title = "Additional Runecloth", direct = true, npc = 14722, npcName = "Clavicus Knavingham", map = 1429, x = 49.0, y = 42.0 } } },
			{ title = "Second", goals = { { t = "turnin", quest = 7796, title = "Additional Runecloth", direct = true, npc = 14722, npcName = "Clavicus Knavingham", map = 1429, x = 49.0, y = 42.0 } } },
		} })`;
	const [out] = run({
		guides: GUIDE,
		before: 'w.repeatable[7796] = true',
		saved: 'PolestarCharDB = { schema = 1, guide = "test/cloth" }',
		script: `
			stub.world.turnIn(7796); flush()
			emit({ E.GetStepView(1).goals[1].status, E.GetStepView(2).goals[1].status, E.GetStepIndex() })
		`,
	});
	assert.deepEqual(out, ['done', 'active', 2]);
});

test('optional goals skip with one click, are saved, and come back with another', () => {
	const GUIDE = `
		Polestar.RegisterGuide({ id = "test/og", pack = "test", title = "Optional", minLevel = 1, maxLevel = 60, steps = {
			{ title = "Field", goals = {
				{ t = "collect", item = 10621, itemName = "Runed Scroll", count = 1, optional = true, map = 1429, x = 20, y = 20 },
				{ t = "kill", target = "Kobold Vermin", count = 10, quest = 7, oi = 1, map = 1429, x = 30, y = 30 },
			} },
			{ goals = { { t = "level", level = 60 } } },
		} })
	`;
	const [out] = run({
		guides: GUIDE,
		before: 'w.onQuest(7, { 10 })',
		saved: 'PolestarCharDB = { schema = 1, guide = "test/og" }',
		script: `
			local r = {}
			r.blocking = E.SkipGoal(1, 2)
			r.ok = E.SkipGoal(1, 1); flush()
			local g = E.GetStepView(1).goals[1]
			r.skipped = { g.status, g.dismissed }
			r.saved = keys(PolestarCharDB.skipped["test/og"])
			E.SkipGoal(1, 1); flush()
			r.back = E.GetStepView(1).goals[1].status
			r.after = keys(PolestarCharDB.skipped["test/og"])
			emit(r)
		`,
	});
	assert.deepEqual(out, { blocking: false, ok: true, skipped: ['skipped', true], saved: '1:1', back: 'active', after: '' });
});

// The Field of Giants (04-the-barrens): the step's Go to names the field; the
// Runed Scroll drops from Aean Swiftriver at 46,70, south-east of it.
const FIELD = `
	Polestar.RegisterGuide({ id = "test/fog", pack = "test", title = "Southern Barrens", minLevel = 1, maxLevel = 60, steps = {
		{ title = "Field of Giants", goals = {
			{ t = "goto", map = 1429, x = 44.7, y = 70.7, text = "Field of Giants" },
			{ t = "collect", item = 10621, itemName = "Runed Scroll", count = 1, optional = true, map = 1429, x = 46.0, y = 70.0, note = "Aean Swiftriver" },
			{ t = "accept", quest = 3513, title = "The Runed Scroll", item = 10621, itemName = "Runed Scroll", optional = true },
			{ t = "accept", quest = 79192, title = "The Burned-Out Remains", object = 600001, objName = "Burned-Out Remains", map = 1429, x = 46.3, y = 73.9 },
		} },
		{ title = "Camp", goals = {
			{ t = "goto", map = 1429, x = 30, y = 30, text = "Camp" },
			{ t = "kill", target = "Kobold Vermin", count = 10, quest = 7, oi = 1 },
		} },
		{ goals = { { t = "level", level = 60 } } },
	} })
`;

test('the arrow leads to the current goal\'s own place; the step\'s Go to only when that goal has none', () => {
	const [out] = run({
		guides: FIELD,
		before: 'w.onQuest(7, { 10 }); w.moveTo(1429, 40, 60)',
		saved: 'PolestarCharDB = { schema = 1, guide = "test/fog" }',
		script: `
			local r = {}
			local wp = E.GetWaypoint()
			r.first = { wp.goalIndex, wp.x, wp.y }
			r.current = E.GetStepView(1).current
			-- At Aean Swiftriver: the field is reached, though not its centre.
			stub.world.moveTo(1429, 46.0, 70.0); stub.advance(1)
			r.header = E.GetStepView(1).goals[1].status
			E.SkipGoal(1, 2); flush()
			r.afterSkip = { E.GetWaypoint().goalIndex, E.GetStepView(1).current }
			r.paired = E.GetStepView(1).goals[3].dismissed or false
			E.Goto(2); flush()
			r.noPlace = { E.GetWaypoint().goalIndex, E.GetStepView(2).current }
			emit(r)
		`,
	});
	assert.deepEqual(out.first, [2, 46, 70], 'the Runed Scroll at Aean Swiftriver, not the field\'s centre');
	assert.equal(out.current, 2);
	assert.equal(out.header, 'done', 'reaching the scroll\'s place reaches the field');
	assert.deepEqual(out.afterSkip, [4, 4], 'scroll skipped: the Burned-Out Remains');
	assert.equal(out.paired, true, 'the scroll\'s quest skips with it: one thing to do');
	assert.deepEqual(out.noPlace, [1, 2], 'the kobolds have no place: the camp\'s Go to');
});

test('choosing the next spot of a goal the arrow is not on moves the arrow to that spot', () => {
	const GUIDE = `
		Polestar.RegisterGuide({ id = "test/sp", pack = "test", title = "Spots", minLevel = 1, maxLevel = 60, steps = {
			{ title = "Hills", goals = {
				{ t = "kill", target = "Kobold Vermin", count = 10, quest = 7, oi = 1, map = 1429, x = 20, y = 50,
					spots = { { x = 20, y = 50, r = 30, n = 3 }, { x = 25, y = 50, r = 30, n = 2 } } },
				{ t = "collect", item = 5058, itemName = "Silithid Egg", count = 12, quest = 868, oi = 1, map = 1429, x = 60, y = 50, spread = true,
					spots = { { x = 60, y = 50, r = 30, n = 3 }, { x = 70, y = 50, r = 30, n = 2 }, { x = 80, y = 50, r = 30, n = 1 } } },
			} },
			{ goals = { { t = "level", level = 60 } } },
		} })
	`;
	const [out] = run({
		guides: GUIDE,
		before: 'w.onQuest(7, { 10 }); w.onQuest(868, { 12 }); w.moveTo(1429, 20, 50)',
		saved: 'PolestarCharDB = { schema = 1, guide = "test/sp" }',
		script: `
			local before = E.GetWaypoint().goalIndex
			E.CycleSpot(1, 2, 3)
			local wp = E.GetWaypoint()
			emit({ before = before, after = { wp.goalIndex, wp.x, wp.spot } })
		`,
	});
	assert.equal(out.before, 1);
	assert.deepEqual(out.after, [2, 80, 3]);
});

test('the next spot reaches the arrow itself (Engine and Nav together), over a point picked by hand too', () => {
	const GUIDE = `
		Polestar.RegisterGuide({ id = "test/sp", pack = "test", title = "Spots", minLevel = 1, maxLevel = 60, steps = {
			{ title = "Hills", goals = {
				{ t = "kill", target = "Kobold Vermin", count = 10, quest = 7, oi = 1, map = 1429, x = 20, y = 50,
					spots = { { x = 20, y = 50, r = 30, n = 3 }, { x = 25, y = 50, r = 30, n = 2 } } },
				{ t = "collect", item = 5058, itemName = "Silithid Egg", count = 12, quest = 868, oi = 1, map = 1429, x = 60, y = 50, spread = true,
					spots = { { x = 60, y = 50, r = 30, n = 3 }, { x = 70, y = 50, r = 30, n = 2 }, { x = 80, y = 50, r = 30, n = 1 } } },
			} },
			{ goals = { { t = "level", level = 60 } } },
		} })
	`;
	const [out] = runAddon({
		stubs: ['stub_world.lua'],
		before: `${WORLD}; w.onQuest(7, { 10 }); w.onQuest(868, { 12 }); w.moveTo(1429, 20, 50)`,
		addons: [{ name: 'Polestar', files: ['Core/Core.xml', 'Theme/Theme.xml', 'Nav/Nav.xml'] }],
		saved: { Polestar: 'PolestarCharDB = { schema = 1, guide = "test/sp" }' },
		script: `${TEST_PACK}
${TEST_SOURCE}\n${GUIDE}\n${HELPERS}\nstub.login()\nstub.fire("QUEST_LOG_UPDATE"); stub.advance(0.6)
			local Nav = Polestar.Nav
			local r = { first = Nav.GetTarget().x }
			-- The eggs' next spot, from the row's button: the arrow goes there.
			E.CycleSpot(1, 2, 2); flush()
			r.cycled = { Nav.GetTarget().x, Nav.GetTarget().goalIndex }
			-- A click on the arrow walks on to the eggs' next spot.
			Nav.NextSpot(); flush()
			r.arrow = Nav.GetTarget().x
			-- A point picked by hand holds until the window lets it go.
			Nav.SetTarget(1429, 10, 10, "By hand")
			E.CycleSpot(1, 2, 2); flush()
			r.held = Nav.GetTarget().label
			Nav.ReleaseTarget()
			r.released = Nav.GetTarget().x
			emit(r)`,
	}).emitted;
	assert.deepEqual(out, { first: 20, cycled: [70, 2], arrow: 80, held: 'By hand', released: 70 });
});

test('a spawn spot holds while the player is on another continent, and is picked afresh from where they stand at the step start', () => {
	const GUIDE = `
		Polestar.RegisterGuide({ id = "test/sc", pack = "test", title = "Spots", minLevel = 1, maxLevel = 60, steps = {
			{ goals = { { t = "accept", quest = 5, title = "First", npc = 1, map = 1429, x = 10, y = 50 } } },
			{ title = "Hills", goals = {
				{ t = "kill", target = "Kobold Vermin", count = 10, quest = 7, oi = 1, map = 1429, x = 20, y = 50,
					spots = { { x = 20, y = 50, r = 30, n = 3 }, { x = 60, y = 50, r = 30, n = 2 }, { x = 80, y = 50, r = 30, n = 1 } } },
			} },
			{ goals = { { t = "level", level = 60 } } },
		} })
	`;
	const [out] = run({
		guides: GUIDE,
		before: 'w.addMap(1411, { name = "Durotar", c = 1, left = 0, right = -3000, top = 0, bottom = -3000 }); w.onQuest(7, { 10 }); w.moveTo(1411, 50, 50)',
		saved: 'PolestarCharDB = { schema = 1, guide = "test/sc" }',
		script: `
			local r = {}
			E.GetStepView(2) -- shown ahead ("Then:"): its spot is picked from Durotar
			stub.world.moveTo(1429, 80, 50)
			stub.world.accept(5, {}); flush()
			r.start = E.GetWaypoint().x -- the step starts: picked from where the player stands
			stub.world.moveTo(1411, 50, 50)
			local seen = {}
			for i = 1, 4 do stub.advance(0.6); seen[i] = E.GetWaypoint().x end
			r.away = seen
			emit(r)
		`,
	});
	assert.equal(out.start, 80);
	assert.deepEqual(out.away, [80, 80, 80, 80]);
});
