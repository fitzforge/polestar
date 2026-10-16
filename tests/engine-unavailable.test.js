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

test('another NPC\'s window never marks an accept, and the giver offering a quest clears even a missing prerequisite', () => {
	const [out] = run({
		script: `
			local w = stub.world
			w.gossip(9999, { available = {} }); w.close(); flush()
			local other = brief(1)
			w.gossip(3429, { available = { { questID = 872 }, { questID = 880 }, { questID = 870 } } }); w.close(); flush()
			emit({ other = other, offered = brief(1), at = E.GetStepIndex() })
		`,
	});
	// 872's prerequisite (871) is missing and the guide never turns it in:
	// known before any visit. Thork's window offering it has the last word.
	assert.deepEqual(out.other, ['skipped:pre:Requires Disrupt the Attacks first', 'active:nil:nil', 'active:nil:nil', 'active:nil:nil']);
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

test('#161: in a step the guide has moved past, a level-up or a turn-in brings back what the data says has opened (level, prerequisite), never what the giver refused', () => {
	const [out] = run({
		script: `
			local w = stub.world
			w.gossip(3429, { available = {} }); w.close()
			w.gossip(3464, { available = { { questID = 869 } } }); w.close(); w.accept(869, { 12 }); flush()
			local r = { before = E.GetStepIndex() }
			w.setLevel(13); flush()
			r.level13 = { E.GetStepIndex(), brief(1) }
			w.setLevel(14); flush()
			r.level14 = { E.GetStepIndex(), brief(1) }
			w.gossip(3429, { available = { { questID = 880 } } }); w.accept(880, {}); w.close(); flush()
			r.taken = E.GetStepIndex()
			w.complete({ 871 }); w.turnIn(500); flush()
			r.turnIn = { E.GetStepIndex(), brief(1) }
			emit(r)
		`,
	});
	assert.equal(out.before, 2);
	assert.deepEqual(out.level13, [2, [
		'skipped:pre:Requires Disrupt the Attacks first',
		'skipped:level:Requires level 14',
		'skipped:offer:Not offered by Thork',
		'done:nil:nil',
	]], 'still at the raptors: 880 still needs level 14');
	assert.deepEqual(out.level14, [1, [
		'skipped:pre:Requires Disrupt the Attacks first',
		'active:nil:nil',
		'skipped:offer:Not offered by Thork',
		'done:nil:nil',
	]], 'level 14: back to Thork for 880; 870, which he refused, stays passed');
	assert.equal(out.taken, 2);
	assert.deepEqual(out.turnIn, [1, [
		'active:nil:nil',
		'done:nil:nil',
		'skipped:offer:Not offered by Thork',
		'done:nil:nil',
	]], '871 done: back to Thork for 872; 870 stays passed');
});

test('#161: a level-up or a turn-in clears the marks of the step at hand, so its giver is asked again', () => {
	const [out] = run({
		script: `
			local w = stub.world
			w.gossip(3429, { available = {} }); w.close(); flush()
			local r = { before = { E.GetStepIndex(), brief(1) } }
			w.setLevel(14); flush()
			r.levelUp = { E.GetStepIndex(), brief(1) }
			w.gossip(3429, { available = {} }); w.close(); flush()
			w.complete({ 871 }); w.turnIn(500); flush()
			r.turnIn = { E.GetStepIndex(), brief(1) }
			emit(r)
		`,
	});
	// Gazrog's 869 is still to take: Thork's step is the one at hand.
	assert.deepEqual(out.before, [1, [
		'skipped:pre:Requires Disrupt the Attacks first',
		'skipped:level:Requires level 14',
		'skipped:offer:Not offered by Thork',
		'active:nil:nil',
	]]);
	// 872 keeps its missing prerequisite (known from the data) until 871 is done.
	assert.deepEqual(out.levelUp, [1, ['skipped:pre:Requires Disrupt the Attacks first', 'active:nil:nil', 'active:nil:nil', 'active:nil:nil']]);
	assert.deepEqual(out.turnIn, [1, ['active:nil:nil', 'active:nil:nil', 'active:nil:nil', 'active:nil:nil']]);
});

test('#161: a quest the giver refused although the data allows it (a server level gate the data lacks) is re-offered when the route next meets that giver', () => {
	// Dalar (1938) at the Sepulcher: 98299's data says level 9, the server
	// wants more. The route comes back to Dalar later for a turn-in.
	const guides = `
	Polestar.RegisterGuide({ id = "test/xr", pack = "test", title = "Silverpine", faction = "Horde", minLevel = 10, maxLevel = 20, steps = {
		{ title = "The Sepulcher", goals = {
			{ t = "accept", quest = 98299, title = "Stop the Spread", npc = 1938, npcName = "Dalar Dawnweaver", minLevel = 9 },
		} },
		{ title = "Ambermill", goals = {
			{ t = "collect", item = 5062, itemName = "Raptor Head", count = 12, quest = 869, oi = 1 },
		} },
		{ title = "Back to the Sepulcher", goals = {
			{ t = "turnin", quest = 869, title = "Raptor Thieves", npc = 1938, npcName = "Dalar Dawnweaver" },
		} },
		{ goals = { { t = "level", level = 30 } } },
	} })`;
	const [out] = run({
		guides,
		before: 'w.onQuest(869, { 12 })',
		script: `
			local w = stub.world
			Polestar.Set("behavior.autoTurnin", false) -- the player hands 869 in themselves
			w.gossip(1938, { available = {} }); w.close(); flush()
			local r = { refused = E.GetStepIndex() }
			w.setLevel(13); flush()
			r.levelUp = { E.GetStepIndex(), brief(1)[1] }
			w.turnIn(500); flush()
			r.turnIn = E.GetStepIndex()
			w.progress(869, 1, 12); flush()
			r.back = E.GetStepIndex()
			w.gossip(1938, { available = { { questID = 98299 } }, active = { { questID = 869, isComplete = true } } }); flush()
			r.offered = E.GetStepIndex()
			w.accept(98299, {}); w.close(); flush()
			r.taken = E.GetStepIndex()
			emit(r)
		`,
	});
	assert.equal(out.refused, 2);
	assert.deepEqual(out.levelUp, [2, 'skipped:offer:Not offered by Dalar Dawnweaver'], 'the level-up keeps the guide at Ambermill');
	assert.equal(out.turnIn, 2, 'so does a turn-in elsewhere');
	assert.equal(out.back, 3);
	assert.equal(out.offered, 1, 'Dalar offers it now: the guide goes back to it, the player standing at Dalar');
	assert.equal(out.taken, 3);
});

test('#127: a quest the giver\'s window lists as active is taken, not refused, before the log has it; accepting clears a mark', () => {
	const [out] = run({
		script: `
			local w = stub.world
			local r = {}
			-- After Accept, the gossip comes back with 870 active a moment before the quest log has it.
			w.gossip(3429, { available = {}, active = { { questID = 870 } } }); flush()
			r.refresh = brief(1)[3]
			w.close(); w.accept(870, {}); flush()
			w.abandon(870); flush()
			r.abandoned = brief(1)[3]
			-- A mark set earlier goes when the quest is accepted, and is not saved while it is in the log.
			w.gossip(3429, { available = {} }); w.close(); flush()
			r.marked = brief(1)[3]
			w.accept(870, {}); flush()
			w.abandon(870); flush()
			r.reaccepted = brief(1)[3]
			emit(r)
		`,
	});
	assert.equal(out.refresh, 'active:nil:nil');
	assert.equal(out.abandoned, 'active:nil:nil');
	assert.equal(out.marked, 'skipped:offer:Not offered by Thork');
	assert.equal(out.reaccepted, 'active:nil:nil');
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

// Issue #70 (The Barrens 19-24, step 9): Sergra Darkthorn's Jorn Skyseer
// (3261) needs The Angry Scytheclaws (905), the end of her chain in the
// earlier Barrens guide. Jorn's Ishamuhale (882) follows Jorn Skyseer.
const CROSSROADS = `
Polestar.RegisterGuide({ id = "test/xr", pack = "test", title = "The Barrens", faction = "Horde", minLevel = 19, maxLevel = 24, steps = {
	{ title = "The Crossroads", goals = {
		{ t = "accept", quest = 899, title = "Consumed by Hatred", npc = 3432, npcName = "Mankrik", map = 1413, x = 51.95, y = 31.58 },
		{ t = "accept", quest = 3261, title = "Jorn Skyseer", npc = 3338, npcName = "Sergra Darkthorn", pre = { 905 }, preTitles = { [905] = "The Angry Scytheclaws" }, map = 1413, x = 52.23, y = 31.01 },
		{ t = "accept", quest = 3281, title = "Stolen Silver", npc = 3464, npcName = "Gazrog", map = 1413, x = 51.93, y = 30.32 },
	} },
	{ title = "Camp Taurajo", goals = {
		{ t = "turnin", quest = 3261, title = "Jorn Skyseer", npc = 3387, npcName = "Jorn Skyseer", map = 1413, x = 44.86, y = 59.14 },
		{ t = "accept", quest = 882, title = "Ishamuhale", npc = 3387, npcName = "Jorn Skyseer", pre = { 3261 }, map = 1413, x = 44.86, y = 59.14 },
	} },
	{ goals = { { t = "level", level = 30 } } },
} })`;

const AT_SERGRA = `
	local w = stub.world
	local function look()
		local wp = E.GetWaypoint()
		return { E.GetStepIndex(), E.GetStepView(E.GetStepIndex()).focus or false, wp and wp.goalIndex or false }
	end
	-- Placed at the Crossroads (the quest log is read): from here on, live play.
	stub.fire("QUEST_LOG_UPDATE"); flush()
	w.accept(899, {}); flush()
	local r = { mankrikDone = look(), step1 = brief(1), step2 = brief(2) }
	w.accept(3281, {}); flush()
	r.gazrogDone = look()
`;

test('#70: an accept whose prerequisite is missing does not hold the focus or the arrow, with or without a visit; done, it does', () => {
	const [missing] = run({
		guides: CROSSROADS,
		script: `${AT_SERGRA}
			-- A turn-in that opens nothing here does not bring it back.
			w.turnIn(500); flush()
			r.unrelated = look()
			-- The Angry Scytheclaws handed in: Sergra's quest is live again.
			w.onQuest(905, {}); w.turnIn(905); flush()
			r.preDone = { look(), brief(1)[2] }
			emit(r)`,
	});
	// Mankrik, Sergra, Gazrog: the focus and the arrow go from Mankrik to Gazrog.
	assert.deepEqual(missing.mankrikDone, [1, 3, 3]);
	assert.deepEqual(missing.step1, ['done:nil:nil', 'skipped:pre:Requires The Angry Scytheclaws first', 'active:nil:nil']);
	// Jorn Skyseer's turn-in goes with it, and so does the quest after it.
	assert.deepEqual(missing.step2, ['skipped:pre:Requires The Angry Scytheclaws first', 'skipped:pre:Requires Jorn Skyseer first']);
	assert.deepEqual(missing.gazrogDone, [3, 1, false]);
	assert.deepEqual(missing.unrelated, [3, 1, false]);
	assert.deepEqual(missing.preDone, [[1, 2, 2], 'active:nil:nil']);

	const [done] = run({ before: 'stub.world.complete({ 905 })', guides: CROSSROADS, script: `${AT_SERGRA} emit(r)` });
	assert.deepEqual(done.mankrikDone, [1, 2, 2]);
	assert.deepEqual(done.step1, ['done:nil:nil', 'active:nil:nil', 'active:nil:nil']);
	assert.deepEqual(done.step2, ['pending:nil:nil', 'pending:nil:nil']);
	assert.deepEqual(done.gazrogDone, [1, 2, 2]);
});

test('a missing prerequisite the guide still turns in, before the accept or after it, leaves the accept to its giver; skipping that turn-in does not', () => {
	// Thork's 872 needs 871 (pre). Taken before 871 is handed in (against
	// lint's order: a data error or a guide's), then 5041 after it, by the
	// rule.
	const guide = `
	Polestar.RegisterGuide({ id = "test/xr", pack = "test", title = "Crossroads", faction = "Horde", minLevel = 10, maxLevel = 20, steps = {
		{ title = "Thork", goals = {
			{ t = "accept", quest = 871, title = "Disrupt the Attacks", npc = 3429, npcName = "Thork", map = 1413, x = 51, y = 30 },
			{ t = "accept", quest = 872, title = "Supplies for the Crossroads", npc = 3429, npcName = "Thork", pre = { 871 }, map = 1413, x = 51, y = 30 },
		} },
		{ title = "Back", goals = {
			{ t = "turnin", quest = 871, title = "Disrupt the Attacks", npc = 3429, npcName = "Thork", map = 1413, x = 51, y = 30 },
			{ t = "accept", quest = 5041, title = "Supplies for the Crossroads", npc = 3429, npcName = "Thork", pre = { 871 }, map = 1413, x = 51, y = 30 },
		} },
		{ goals = { { t = "level", level = 30 } } },
	} })`;
	const [out] = run({
		guides: guide,
		script: `
			local w = stub.world
			-- Placed at Thork (the quest log is read), then 871 is taken.
			stub.fire("QUEST_LOG_UPDATE"); flush()
			w.accept(871, {}); flush()
			local r = { step1 = brief(1), step2 = brief(2), wp = E.GetWaypoint().goalIndex }
			-- The player skips the step that hands 871 in.
			E.Next(); E.Skip(); flush()
			r.skipped = { E.GetLiveStep(), brief(1) }
			emit(r)`,
	});
	assert.deepEqual(out.step1, ['done:nil:nil', 'active:nil:nil']);
	assert.deepEqual(out.step2, ['pending:nil:nil', 'pending:nil:nil']);
	assert.equal(out.wp, 2);
	// Nothing left to do at Thork: the guide goes past the skipped step.
	assert.deepEqual(out.skipped, [3, ['done:nil:nil', 'skipped:pre:Requires Disrupt the Attacks first']]);
});

test('a prerequisite the guide has only for other characters is another version of the chain: the accept stays open for the giver to decide', () => {
	// The paladin charger: Emphasis on Sacrifice (7637) names the Human Lord
	// Grayson Shadowbreaker (7638) only; the Dwarf's (7670) is missing from the
	// data. Here the character is an Orc, and 7670 stands for their own version.
	const guide = `
	Polestar.RegisterGuide({ id = "test/xr", pack = "test", title = "Charger", minLevel = 10, maxLevel = 60, steps = {
		{ title = "Grayson", goals = {
			{ t = "accept", quest = 7638, title = "Lord Grayson Shadowbreaker", npc = 1, npcName = "Duthorian Rall", only = { races = { "Human" } }, map = 1413, x = 51, y = 30 },
			{ t = "turnin", quest = 7638, title = "Lord Grayson Shadowbreaker", npc = 2, npcName = "Lord Grayson", only = { races = { "Human" } }, map = 1413, x = 51, y = 30 },
			{ t = "turnin", quest = 7670, title = "Lord Grayson Shadowbreaker", npc = 2, npcName = "Lord Grayson", only = { races = { "Orc" } }, map = 1413, x = 51, y = 30 },
			{ t = "accept", quest = 7637, title = "Emphasis on Sacrifice", npc = 2, npcName = "Lord Grayson", pre = { 7638 }, map = 1413, x = 51, y = 30 },
		} },
		{ goals = { { t = "level", level = 60 } } },
	} })`;
	const [out] = run({ before: 'stub.world.onQuest(7670, {})', guides: guide, script: 'stub.fire("QUEST_LOG_UPDATE"); flush(); emit(brief(1))' });
	assert.deepEqual(out, ['na:nil:nil', 'na:nil:nil', 'active:nil:nil', 'active:nil:nil']);
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
	const [closed] = run({ guides: guide, before: 'stub.world.complete({ 1093 }); stub.world.onQuest(1472, {})', script });
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
