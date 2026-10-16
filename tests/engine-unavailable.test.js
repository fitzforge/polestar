'use strict';
// Engine "Smart logic": accepts found unavailable at their giver (with
// reasons, dependent goals skipped, marks cleared on level-up / turn-in), and
// farm-spot ranking for `collect … nearest`. Real Core manifest, stub world.

const { test } = require('node:test');
const assert = require('node:assert/strict');
const { runAddon } = require('./helpers/lua');
const { TEST_PACK, TEST_SOURCE } = require('./helpers/packs');

const CORE = { name: 'Polestar', files: ['Core/Core.xml'] };

const WORLD = `
local w = stub.world
w.addMap(1413, { name = "The Barrens", c = 1, left = 1000, right = -1000, top = 1000, bottom = -3000 })
w.moveTo(1413, 50, 30)
w.race, w.faction, w.class, w.className, w.level = "Orc", "Horde", "WARRIOR", "Warrior", 12
w.titles[871] = "Disrupt the Attacks"; w.titles[872] = "Supplies for the Crossroads"; w.titles[870] = "The Forgotten Pools"
`;

// Quest 872 needs 871 done (pre), 880 needs level 14, 870 is simply not
// offered (another chain), all from Thork (3429) at the Crossroads.
const GUIDE = `
Polestar.RegisterGuide({ id = "test/xr", pack = "test", title = "Crossroads", faction = "Horde", minLevel = 10, maxLevel = 20, steps = {
	{ title = "Thork", goals = {
		{ t = "accept", quest = 872, title = "Supplies for the Crossroads", npc = 3429, npcName = "Thork", pre = { 871 }, map = 1413, x = 51, y = 30 },
		{ t = "accept", quest = 880, title = "Altered Beings", npc = 3429, npcName = "Thork", minLevel = 14 },
		{ t = "accept", quest = 870, title = "The Forgotten Pools", npc = 3429, npcName = "Thork" },
		{ t = "accept", quest = 869, title = "Raptor Thieves", npc = 3464, npcName = "Gazrog" },
	} },
	{ title = "Raptors", goals = {
		{ t = "kill", target = "Sunscale Lashtail", count = 7, quest = 872, oi = 1, map = 1413, x = 45, y = 20 },
		{ t = "collect", item = 5062, itemName = "Raptor Head", count = 12, quest = 869, oi = 1 },
	} },
	{ title = "Back", goals = {
		{ t = "turnin", quest = 872, title = "Supplies for the Crossroads", npc = 3429, npcName = "Thork" },
		{ t = "turnin", quest = 869, title = "Raptor Thieves", npc = 3464, npcName = "Gazrog" },
	} },
	{ goals = { { t = "level", level = 30 } } },
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
			function brief(i)
				local out = {}
				for g, v in ipairs(E.GetStepView(i).goals) do out[g] = v.status .. ":" .. tostring(v.unavailable) .. ":" .. tostring(v.unavailableText) end
				return out
			end
			stub.login()
			E.SetGuide("test/xr")
			Polestar.Set("behavior.autoAccept", false) -- the tests take quests themselves
			${script}`,
	}).emitted;
}

test('accepts their giver does not offer are skipped with a reason; the same quest\'s later goals too', () => {
	const [out] = run({
		script: `
			local w = stub.world
			local r = {}
			w.gossip(3429, { available = {} }); w.close(); flush()
			r.at = E.GetStepIndex()
			w.gossip(3464, { available = { { questID = 869 } } }); w.close(); w.accept(869, { 12 }); flush()
			r.step1 = brief(1)
			r.atAfter = E.GetStepIndex()
			r.step2 = brief(2)
			r.step3 = brief(3)
			r.wp = E.GetWaypoint() and E.GetWaypoint().goalIndex or false
			emit(r)
		`,
	});
	assert.deepEqual(out.step1, [
		'skipped:pre:Requires Disrupt the Attacks first',
		'skipped:level:Requires level 14',
		'skipped:offer:Not offered by Thork',
		'done:nil:nil',
	]);
	assert.equal(out.at, 1); // Gazrog's accept still open
	assert.equal(out.atAfter, 2);
	assert.deepEqual(out.step2, ['skipped:pre:Requires Disrupt the Attacks first', 'active:nil:nil']);
	assert.deepEqual(out.step3, ['skipped:pre:Requires Disrupt the Attacks first', 'pending:nil:nil']);
});

test('another NPC\'s window never marks an accept, and an offered quest is not marked', () => {
	const [out] = run({
		script: `
			local w = stub.world
			w.gossip(9999, { available = {} }); w.close(); flush()
			local other = brief(1)
			w.gossip(3429, { available = { { questID = 872 }, { questID = 880 }, { questID = 870 } } }); w.close(); flush()
			emit({ other = other, offered = brief(1), at = E.GetStepIndex() })
		`,
	});
	assert.deepEqual(out.other, ['active:nil:nil', 'active:nil:nil', 'active:nil:nil', 'active:nil:nil']);
	assert.deepEqual(out.offered, ['active:nil:nil', 'active:nil:nil', 'active:nil:nil', 'active:nil:nil']);
	assert.equal(out.at, 1);
});

test('a detail window opened from the giver\'s list says nothing about the others; a direct one does', () => {
	const [out] = run({
		script: `
			local w = stub.world
			-- The list offers everything; picking 870 opens its detail window.
			w.gossip(3429, { available = { { questID = 872 }, { questID = 880 }, { questID = 870 } } })
			w.questDetail(3429, 870); w.close(); flush()
			local fromList = brief(1)
			stub.advance(60)
			-- Later, Thork opens a detail window directly: only 870 is offered.
			w.questDetail(3429, 870); w.close(); flush()
			-- An item-started quest says nothing about Thork.
			w.questDetail(3429, 999, { startItem = 1234 }); w.close(); flush()
			emit({ fromList = fromList, direct = brief(1) })
		`,
	});
	assert.deepEqual(out.fromList, ['active:nil:nil', 'active:nil:nil', 'active:nil:nil', 'active:nil:nil']);
	assert.deepEqual(out.direct, [
		'skipped:pre:Requires Disrupt the Attacks first',
		'skipped:level:Requires level 14',
		'active:nil:nil',
		'active:nil:nil',
	]);
});

test('the follow-up a turn-in pops up says nothing about the giver\'s other quests, however long the reward was read (regression: Jorn Skyseer passed at Sergra Darkthorn)', () => {
	const [out] = run({
		before: 'w.onQuest(903, { 1 })',
		script: `
			local w = stub.world
			-- Thork offers the guide's quests and takes in 903, which is not in the guide.
			w.gossip(3429, { available = { { questID = 872 }, { questID = 880 }, { questID = 870 } }, active = { { questID = 903, isComplete = true } } })
			w.questComplete(3429, 903); flush()
			stub.advance(45) -- reading the reward panel
			w.turnIn(903); flush()
			-- The client then shows 903's follow-up straight away; the player takes it.
			w.questDetail(3429, 904); flush()
			w.accept(904, { 1 }); w.close(); flush()
			emit({ step = brief(1), at = E.GetStepIndex() })
		`,
	});
	assert.deepEqual(out.step, ['active:nil:nil', 'active:nil:nil', 'active:nil:nil', 'active:nil:nil']);
	assert.equal(out.at, 1);
});

test('the marks clear on level-up and on any turn-in, and the guide goes back to them', () => {
	const [out] = run({
		script: `
			local w = stub.world
			w.gossip(3429, { available = {} }); w.close()
			w.gossip(3464, { available = { { questID = 869 } } }); w.close(); w.accept(869, { 12 }); flush()
			local r = { before = E.GetStepIndex() }
			w.setLevel(13); flush()
			r.levelUp = { E.GetStepIndex(), brief(1) }
			w.gossip(3429, { available = {} }); w.close(); flush()
			r.again = E.GetStepIndex()
			w.complete({ 871 }); w.turnIn(500); flush()
			r.turnIn = { E.GetStepIndex(), brief(1)[1] }
			emit(r)
		`,
	});
	assert.equal(out.before, 2);
	assert.deepEqual(out.levelUp, [1, ['active:nil:nil', 'active:nil:nil', 'active:nil:nil', 'done:nil:nil']]);
	assert.equal(out.again, 2);
	assert.deepEqual(out.turnIn, [1, 'active:nil:nil']);
});

test('prerequisites: every `preAll` must be done, one `pre` suffices; the text names the missing one', () => {
	// 890 needs 871 and 873 (preAll); 891 needs 871 or 873 (pre). Only 871 is done.
	const guide = `
	Polestar.RegisterGuide({ id = "test/xr", pack = "test", title = "Crossroads", faction = "Horde", minLevel = 10, maxLevel = 20, steps = {
		{ title = "Thork", goals = {
			{ t = "accept", quest = 890, title = "Both First", npc = 3429, npcName = "Thork", preAll = { 871, 873 }, preTitles = { [873] = "The Other Errand" } },
			{ t = "accept", quest = 891, title = "Either First", npc = 3429, npcName = "Thork", pre = { 871, 873 } },
		} },
		{ goals = { { t = "level", level = 30 } } },
	} })`;
	const [out] = run({
		before: 'stub.world.complete({ 871 })',
		guides: guide,
		script: `
			local w = stub.world
			w.gossip(3429, { available = {} }); w.close(); flush()
			emit(brief(1))
		`,
	});
	assert.deepEqual(out, ['skipped:pre:Requires The Other Errand first', 'skipped:offer:Not offered by Thork']);
});

test('an accept closed for good (its breadcrumb target or an exclusive quest taken or done) is skipped before any visit, with the quest\'s later goals', () => {
	// 1483 leads to 1093 (a breadcrumb); 1507 is exclusive with 1472 (the
	// Undercity version of the chain).
	const guide = `
	Polestar.RegisterGuide({ id = "test/xr", pack = "test", title = "Ratchet", faction = "Horde", minLevel = 10, maxLevel = 30, steps = {
		{ title = "Givers", goals = {
			{ t = "accept", quest = 1483, title = "Ziz Fizziks", npc = 3442, npcName = "Sputtervalve", closedBy = { 1093 }, preTitles = { [1093] = "Super Reaper 6000" }, map = 1413, x = 62, y = 37 },
			{ t = "accept", quest = 1507, title = "Devourer of Souls", npc = 5875, npcName = "Gan'rul Bloodeye", closedBy = { 1472 }, preTitles = { [1472] = "Devourer of Souls" } },
		} },
		{ title = "Ziz", goals = { { t = "turnin", quest = 1483, title = "Ziz Fizziks", npc = 4201, npcName = "Ziz Fizziks" } } },
		{ goals = { { t = "level", level = 30 } } },
	} })`;
	const script = 'emit({ at = E.GetStepIndex(), step1 = brief(1), step2 = brief(2), wp = E.GetWaypoint() and E.GetWaypoint().stepIndex or false })';
	const [closed] = run({ guides: guide, before: 'stub.world.complete({ 1093 }); stub.world.onQuest(1472, {}, "Devourer of Souls")', script });
	assert.deepEqual(closed, {
		at: 3,
		step1: ['skipped:closed:No longer offered: you took Super Reaper 6000', 'skipped:closed:No longer offered: you took Devourer of Souls'],
		step2: ['skipped:closed:No longer offered: you took Super Reaper 6000'],
		wp: false,
	});
	const [open] = run({ guides: guide, script });
	assert.deepEqual(open.step1, ['active:nil:nil', 'active:nil:nil']);
	assert.equal(open.at, 1);
});

test('when a mark moves the guide on, the guide window says which quest was skipped and why; a normal completion says nothing', () => {
	const guide = `
	Polestar.RegisterGuide({ id = "test/xr", pack = "test", title = "Crossroads", faction = "Horde", minLevel = 10, maxLevel = 30, steps = {
		{ title = "Thork", goals = { { t = "accept", quest = 870, title = "The Forgotten Pools", npc = 3429, npcName = "Thork", map = 1413, x = 51.5, y = 30.3 } } },
		{ title = "Gazrog", goals = { { t = "accept", quest = 869, title = "Raptor Thieves", npc = 3464, npcName = "Gazrog", map = 1413, x = 51.9, y = 30.8 } } },
		{ goals = { { t = "level", level = 30 } } },
	} })`;
	const [out] = runAddon({
		stubs: ['stub_world.lua'],
		before: WORLD,
		addons: ['Polestar'],
		script: `${TEST_PACK}
${TEST_SOURCE}
${guide}
			local E, w = Polestar.Engine, stub.world
			local B = Polestar.UI.GuideFrame.parts.banner
			local function banner() return B:IsShown() and B.Text:GetText() or false end
			stub.login()
			E.SetGuide("test/xr")
			stub.fire("QUEST_LOG_UPDATE") -- the client fills the quest log after login
			Polestar.Set("behavior.autoAccept", false)
			stub.advance(0.5)
			local r = { before = banner() }
			w.gossip(3429, { available = {} }); w.close(); stub.advance(0.5)
			r.skipped = { E.GetStepIndex(), banner() }
			w.accept(869, {}); stub.advance(0.5)
			r.completed = { E.GetStepIndex(), banner() }
			emit(r)`,
	}).emitted;
	assert.deepEqual(out, {
		before: false,
		skipped: [2, 'Skipped The Forgotten Pools  \u00b7  Not offered by Thork'],
		completed: [3, false],
	});
});

// Farm spots for `collect 2589 x20 nearest` (Linen Cloth).
const FARM = (spots) => `
	Polestar.RegisterGuide({ id = "test/farm", pack = "test", title = "Linen", category = "Professions", minLevel = 1, maxLevel = 60, steps = {
		{ goals = { { t = "collect", item = 2589, itemName = "Linen Cloth", count = 20, candidates = { ${spots} } } } },
		{ goals = { { t = "level", level = 60 } } },
	} })
`;

function farmPick(spots, before = '') {
	const [out] = runAddon({
		stubs: ['stub_world.lua'],
		before: WORLD + before,
		addons: [CORE],
		script: `${TEST_PACK}
${TEST_SOURCE}
${FARM(spots)}
			E = Polestar.Engine
			stub.login()
			E.SetGuide("test/farm")
			local v = E.GetStepView(1).goals[1]
			emit({ name = v.npcName or false, lvl = v.lvl or false, alts = v.alternatives, detail = v.detail or false })`,
	}).emitted;
	return out;
}

test('farm spots: a near spot at the right level beats a far one and a red one', () => {
	const near = '{ npcName = "Near Quilboar", map = 1413, x = 52, y = 32, faction = "AH", lvl = { 11, 13 }, rate = 0.3, spawns = 10 }';
	const far = '{ npcName = "Far Quilboar", map = 1413, x = 50, y = 95, faction = "AH", lvl = { 11, 13 }, rate = 0.3, spawns = 10 }';
	const red = '{ npcName = "Red Raptors", map = 1413, x = 50, y = 31, faction = "AH", lvl = { 15, 17 }, rate = 0.9, spawns = 20 }';
	const out = farmPick([far, red, near].join(', '));
	assert.deepEqual(out, { name: 'Near Quilboar', lvl: [11, 13], alts: 1, detail: 'from Near Quilboar' });
});

test('farm spots: drop rate, spawn density and grey mobs weigh against distance', () => {
	// Same place: the better drop rate wins.
	const rich = '{ npcName = "Rich", map = 1413, x = 55, y = 30, faction = "AH", lvl = { 12, 12 }, rate = 0.6, spawns = 8 }';
	const poor = '{ npcName = "Poor", map = 1413, x = 51, y = 30, faction = "AH", lvl = { 12, 12 }, rate = 0.1, spawns = 8 }';
	assert.equal(farmPick(`${poor}, ${rich}`).name, 'Rich');
	// Sparse spawns are slower to farm.
	const sparse = '{ npcName = "Sparse", map = 1413, x = 51, y = 30, faction = "AH", lvl = { 12, 12 }, rate = 0.3, spawns = 1 }';
	const dense = '{ npcName = "Dense", map = 1413, x = 56, y = 30, faction = "AH", lvl = { 12, 12 }, rate = 0.3, spawns = 12 }';
	assert.equal(farmPick(`${sparse}, ${dense}`).name, 'Dense');
	// Grey mobs die fast: at level 30 the grey spot beats an even-level one with the same rate.
	const grey = '{ npcName = "Grey", map = 1413, x = 56, y = 30, faction = "AH", lvl = { 10, 12 }, rate = 0.3, spawns = 8 }';
	const even = '{ npcName = "Even", map = 1413, x = 51, y = 30, faction = "AH", lvl = { 29, 31 }, rate = 0.3, spawns = 8 }';
	assert.equal(farmPick(`${even}, ${grey}`, 'stub.world.level = 30').name, 'Grey');
	// Only too-high spots: still a target, the smallest level gap first, then farm cost.
	const higher = '{ npcName = "Higher", map = 1413, x = 51, y = 30, faction = "AH", lvl = { 25, 27 }, rate = 0.9, spawns = 20 }';
	const high = '{ npcName = "High", map = 1413, x = 52, y = 90, faction = "AH", lvl = { 18, 20 }, rate = 0.2, spawns = 4 }';
	const alliance = '{ npcName = "Alliance only", map = 1413, x = 51, y = 31, faction = "A", lvl = { 12, 12 }, rate = 0.9, spawns = 8 }';
	const onlyRed = farmPick(`${higher}, ${alliance}, ${high}`);
	assert.deepEqual(onlyRed, { name: 'High', lvl: [18, 20], alts: 1, detail: 'from High' });
});
