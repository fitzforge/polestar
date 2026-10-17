'use strict';
// Engine "Smart logic": candidate NPCs picked by travel cost, profession and
// class training, `sethome nearest`, Scourge == Undead, context-aware
// Suggest, GUIDE_OUTLEVELED and behavior.skipGrey. Real Core manifest, stub world.

const { test } = require('node:test');
const assert = require('node:assert/strict');
const { runAddon } = require('./helpers/lua');
const { TEST_PACK, TEST_SOURCE } = require('./helpers/packs');

const CORE = { name: 'Polestar', files: ['Core/Core.xml'] };

// Kalimdor (continent 1): the Barrens, Durotar, Orgrimmar. Eastern Kingdoms
// (continent 0): Tirisfal, Stormwind.
const WORLD = `
local w = stub.world
w.addMap(1413, { name = "The Barrens", c = 1, left = 1000, right = -1000, top = 1000, bottom = -3000 })
w.addMap(1411, { name = "Durotar", c = 1, left = -1000, right = -3000, top = 0, bottom = -2000 })
w.addMap(1454, { name = "Orgrimmar", c = 1, left = -1500, right = -2000, top = 2000, bottom = 1500 })
w.addMap(1420, { name = "Tirisfal Glades", c = 0, left = 3000, right = 0, top = 3000, bottom = 1000 })
w.addMap(1453, { name = "Stormwind City", c = 0, left = -1000, right = -2000, top = -1000, bottom = -2000 })
w.race, w.raceName, w.faction, w.class, w.className = "Scourge", "Undead", "Horde", "MAGE", "Mage"
w.level = 20
w.moveTo(1413, 60, 30)
w.zone, w.subzone = "The Barrens", "The Crossroads"
`;

// First Aid trainers: Durotar (Razor Hill), Orgrimmar, Tirisfal (Undead
// only), Stormwind (Alliance).
const TRAINERS = `{
	{ npc = 3373, npcName = "Arnok", map = 1411, x = 50, y = 50, faction = "H" },
	{ npc = 5943, npcName = "Rawrk", map = 1454, x = 50, y = 50, faction = "H" },
	{ npc = 2798, npcName = "Nurse Neela", map = 1420, x = 50, y = 50, faction = "H", races = { "Undead" } },
	{ npc = 5150, npcName = "Nissa Firestone", map = 1453, x = 50, y = 50, faction = "A" },
}`;

const GUIDE = `
Polestar.RegisterGuide({ id = "test/fa", pack = "test", title = "First Aid", category = "Professions", minLevel = 1, maxLevel = 60, steps = {
	{ goals = { { t = "train", skill = "First Aid", skillLine = 129, rank = 2, candidates = ${TRAINERS} } } },
	{ goals = { { t = "train", class = true, candidates = {
		{ npc = 4568, npcName = "Anastasia Hartwell", map = 1420, x = 40, y = 40, faction = "H", classes = { "MAGE" } },
		{ npc = 5885, npcName = "Deino", map = 1454, x = 40, y = 40, faction = "H", classes = { "MAGE" } },
		{ npc = 3047, npcName = "Archmage Shymm", map = 1454, x = 60, y = 60, faction = "H", classes = { "MAGE" } },
		{ npc = 5497, npcName = "Jennea Cannon", map = 1453, x = 40, y = 40, faction = "A", classes = { "MAGE" } },
	} } } },
	{ goals = { { t = "sethome", npc = nil, candidates = {
		{ npc = 3934, npcName = "Innkeeper Boorand", map = 1413, x = 52, y = 30, faction = "H" },
		{ npc = 6930, npcName = "Innkeeper Firebrew", map = 1453, x = 60, y = 60, faction = "A" },
	} } } },
	{ goals = { { t = "level", level = 60 } } },
} })
`;

function run({ before = '', guides = GUIDE, saved, script, login = true }) {
	return runAddon({
		stubs: ['stub_world.lua'],
		before: WORLD + before,
		addons: [CORE],
		saved,
		script: `${TEST_PACK}
${TEST_SOURCE}
${guides}
			E = Polestar.Engine
			function flush() stub.advance(0.25) end
			${login ? 'stub.login()' : ''}
			${script}`,
	}).emitted;
}

test('an Undead Horde player in the Barrens is sent to the nearest Horde trainer, never an Alliance one; cycling walks the ranking', () => {
	const [out] = run({
		script: `
			E.SetGuide("test/fa")
			local function g() local v = E.GetStepView(1).goals[1]; return { v.npc, v.npcName, v.map, v.x, v.y, v.alternatives } end
			local first, wp = g(), E.GetWaypoint()
			local cycled = {}
			for i = 1, 3 do E.CycleCandidate(1, 1); cycled[i] = g()[2] end
			emit({ first = first, wp = { wp.map, wp.x, wp.y, wp.label }, cycled = cycled, wpAfter = E.GetWaypoint().map,
				text = E.GetStepView(1).goals[1].text, detail = E.GetStepView(1).goals[1].detail })
		`,
	});
	assert.deepEqual(out.first, [3373, 'Arnok', 1411, 50, 50, 2]);
	assert.deepEqual(out.wp, [1411, 50, 50, 'Train First Aid']);
	assert.deepEqual(out.cycled, ['Rawrk', 'Nurse Neela', 'Arnok']);
	assert.equal(out.wpAfter, 1411);
	assert.equal(out.text, 'Train First Aid');
	assert.equal(out.detail, 'at Arnok');
});

test('candidates are re-picked on zone change and landing, not on every move; Nav.EstimateTravel wins when present', () => {
	const [out] = run({
		script: `
			local w = stub.world
			E.SetGuide("test/fa")
			local function npc() return E.GetStepView(1).goals[1].npc end
			local at = { npc() }
			w.moveTo(1420, 52, 52) -- teleported into Tirisfal, no event yet
			flush()
			at[2] = npc()
			w.setZone("Tirisfal Glades", "Brill"); flush()
			at[3] = npc()
			-- A flight lands in Orgrimmar; Nav's travel model prefers it.
			Polestar.Nav = { EstimateTravel = function(from, to) return to.map == 1454 and 10 or 1000 end }
			w.moveTo(1454, 45, 45)
			stub.fire("PLAYER_CONTROL_GAINED"); flush()
			at[4] = npc()
			emit(at)
		`,
	});
	assert.deepEqual(out, [3373, 3373, 2798, 5943]);
});

test('a profession train completes from the skill cap at any trainer; a trainer window alone does not', () => {
	const [out] = run({
		script: `
			local w = stub.world
			E.SetGuide("test/fa")
			local r = { manual = E.GetStepView(1).goals[1].manual }
			w.trainer(5943); w.close(); flush()
			r.afterWindow = E.GetStepIndex()
			w.learnSkill(129, "First Aid", 60, 75); flush()
			r.apprentice = E.GetStepIndex()
			w.skillUp(129, 75, 150); flush()
			r.journeyman = E.GetStepIndex()
			emit(r)
		`,
	});
	assert.deepEqual(out, { manual: false, afterWindow: 1, apprentice: 1, journeyman: 2 });
});

test('train class completes on any candidate trainer window during the step; sethome nearest on binding', () => {
	const [out] = run({
		before: 'stub.world.learnSkill(129, "First Aid", 75, 150)',
		script: `
			local w = stub.world
			E.SetGuide("test/fa")
			local r = { start = E.GetStepIndex(), classNpc = E.GetStepView(2).goals[1].npcName, alts = E.GetStepView(2).goals[1].alternatives }
			w.trainer(1234); w.close(); flush()   -- some other trainer
			r.other = E.GetStepIndex()
			w.trainer(5885); w.close(); flush()   -- a mage trainer, not the chosen one
			r.mage = E.GetStepIndex()
			r.inn = { E.GetStepView(3).goals[1].npcName, E.GetStepView(3).goals[1].text }
			w.bind("The Crossroads"); flush()
			r.bound = E.GetStepIndex()
			emit(r)
		`,
	});
	assert.deepEqual(out, {
		start: 2,
		classNpc: 'Archmage Shymm',
		alts: 2,
		other: 2,
		mage: 3,
		inn: ['Innkeeper Boorand', 'Set your home at Innkeeper Boorand'],
		bound: 4,
	});
});

test('Scourge and Undead are the same race in only, guide races and candidates', () => {
	const [out] = run({
		guides: `
			Polestar.RegisterGuide({ id = "test/u", pack = "test", title = "Undead", faction = "Horde", races = { "Undead" }, minLevel = 1, maxLevel = 60, steps = {
				{ only = { races = { "Undead" } }, goals = { { t = "level", level = 30 } } },
				{ goals = { { t = "level", level = 60, only = { races = { "!Undead" } } }, { t = "level", level = 50 } } },
			} })
		`,
		script: `
			local v1 = E.GetStepView(1)
			emit({ suggest = Polestar.Guides.Suggest(), s1 = v1.status, g2 = E.GetStepView(2).goals[1].status,
				m = { Polestar.Guides.Matches({ races = { "Scourge" } }, { race = "Undead" }), Polestar.Guides.Matches({ races = { "Undead" } }, { race = "Scourge" }) } })
		`,
	});
	assert.deepEqual(out, { suggest: 'test/u', s1: 'current', g2: 'na', m: [true, true] });
});

test('Suggest prefers the current zone, then the nearest by travel; race chains win ties', () => {
	const guides = `
		local function g(id, zone, x, races)
			Polestar.RegisterGuide({ id = id, pack = "test", title = id, faction = "Horde", races = races, minLevel = 15, maxLevel = 25, zone = zone, steps = {
				{ goals = { { t = "goto", map = zone, x = x, y = 50 } } },
			} })
		end
		g("test/silverpine", 1420, 50, { "Undead" })   -- the race's own chain, other continent
		g("test/stonetalon", 1411, 50, nil)            -- same continent, ~1970 yd
		g("test/barrens", 1413, 50, nil)               -- the player's zone
		g("test/barrens-undead", 1413, 52, { "Scourge" })
	`;
	const [inZone] = run({ guides, login: false, script: 'emit(Polestar.Guides.Suggest())' });
	assert.equal(inZone, 'test/barrens-undead'); // in zone; travel tie; race chain first
	const [nearest] = run({ guides, login: false, before: 'stub.world.moveTo(1454, 50, 100); stub.world.zone = "Orgrimmar"', script: 'emit(Polestar.Guides.Suggest())' });
	assert.equal(nearest, 'test/stonetalon');
	const [home] = run({ guides, login: false, before: 'stub.world.moveTo(1420, 50, 50); stub.world.zone = "Tirisfal Glades"', script: 'emit(Polestar.Guides.Suggest())' });
	assert.equal(home, 'test/silverpine');
});

test('GUIDE_OUTLEVELED fires once per guide when the level passes maxLevel + 2, unless the guide catches up', () => {
	const args = {
		before: 'stub.world.level = 5',
		guides: `
			Polestar.RegisterGuide({ id = "test/low", pack = "test", title = "Low", faction = "Horde", minLevel = 1, maxLevel = 6, steps = { { goals = { { t = "level", level = 60 } } } } })
			Polestar.RegisterGuide({ id = "test/mid", pack = "test", title = "Mid", faction = "Horde", minLevel = 7, maxLevel = 20, steps = { { goals = { { t = "level", level = 60 } } } } })
		`,
		script: `
			local fired = {}
			Polestar.On("GUIDE_OUTLEVELED", function(id, s) fired[#fired + 1] = id .. ">" .. tostring(s) end)
			local w = stub.world
			w.setLevel(7); flush()
			local at7 = #fired
			w.setLevel(8); flush()
			w.setLevel(9); flush()
			emit({ at7 = at7, fired = fired, guide = E.GetGuide().id })
		`,
	};
	const [out] = run({ ...args, saved: { Polestar: 'PolestarDB = { schema = 1, settings = { behavior = { skipGrey = false } } }' } });
	assert.deepEqual(out, { at7: 0, fired: ['test/low>test/mid'], guide: 'test/low' });
	// A leveling guide that catches up (the default) manages itself: no banner.
	const [catchesUp] = run(args);
	assert.equal(Object.keys(catchesUp.fired).length, 0);
});

// Wogi's report: a Human at 20 in Darkshore (16-21) was sent to grey quests.
// With the setting on, a grey quest turned in later in the guide is left out
// with its turn-in; a grey quest stays when a quest down the chain that is not
// grey needs it, directly or through other grey quests.
test('skipGrey skips grey accepts and their turn-ins unless a quest worth doing needs them, and never auto-accepts them', () => {
	const guides = `
		Polestar.RegisterGuide({ id = "test/g1", pack = "test", title = "G1", faction = "Horde", minLevel = 1, maxLevel = 30, next = "test/g2", steps = {
			{ goals = { { t = "accept", quest = 101, title = "Grey alone", qlvl = 2 } } },
			{ goals = { { t = "accept", quest = 102, title = "Grey turned in", qlvl = 3 } } },
			{ goals = { { t = "accept", quest = 103, title = "Grey prerequisite", qlvl = 4 } } },
			{ goals = { { t = "accept", quest = 104, title = "Current", qlvl = 19 } } },
			{ goals = { { t = "turnin", quest = 102, title = "Grey turned in" } } },
			{ goals = { { t = "accept", quest = 106, title = "Grey chain start", qlvl = 5 } } },
			{ goals = { { t = "turnin", quest = 106, title = "Grey chain start" }, { t = "accept", quest = 107, title = "Grey chain middle", qlvl = 6, pre = { 106 } } } },
			{ goals = { { t = "turnin", quest = 107, title = "Grey chain middle" }, { t = "accept", quest = 108, title = "Chain end worth it", qlvl = 18, pre = { 107 } } } },
			{ goals = { { t = "accept", quest = 109, title = "Grey dead end start", qlvl = 5 } } },
			{ goals = { { t = "accept", quest = 110, title = "Grey dead end", qlvl = 6, preAll = { 109 } } } },
			{ goals = { { t = "turnin", quest = 110, title = "Grey dead end" } } },
		} })
		Polestar.RegisterGuide({ id = "test/g2", pack = "test", title = "G2", faction = "Horde", minLevel = 20, maxLevel = 30, steps = {
			{ goals = { { t = "accept", quest = 105, title = "Follow-up", qlvl = 20, pre = { 103 } } } },
		} })
	`;
	const script = `
		E.SetGuide("test/g1")
		-- Each step's last goal: the accept, where a step first hands in its prerequisite.
		local function statuses()
			local s = {}
			for i = 1, #E.GetGuide().steps do
				local goals = E.GetStepView(i).goals
				s[i] = goals[#goals].status
			end
			return s
		end
		local s = statuses()
		local w = stub.world
		w.questDetail(1, 101); w.close()
		local out = { statuses = s, at = E.GetStepIndex(), accepted101 = w.log[101] ~= nil, grey = E.GetStepView(1).goals[1].skippedGrey or false }
		-- Taken by hand anyway: its accept and turn-in are back.
		w.accept(102, {}, "Grey turned in"); flush()
		local again = statuses()
		out.byHand = { again[2], again[5] }
		emit(out)
	`;
	const [on] = run({ guides, saved: { Polestar: 'PolestarDB = { schema = 1, settings = { behavior = { skipGrey = true } } }' }, script });
	assert.deepEqual(on, {
		statuses: ['na', 'na', 'active', 'pending', 'na', 'pending', 'pending', 'pending', 'na', 'na', 'na'],
		at: 3, accepted101: false, grey: true, byHand: ['done', 'pending'],
	});
	const [off] = run({ guides, saved: { Polestar: 'PolestarDB = { schema = 1, settings = { behavior = { skipGrey = false } } }' }, script });
	assert.equal(off.statuses.filter((s) => s === 'na').length, 0, JSON.stringify(off.statuses));
	assert.deepEqual([off.at, off.accepted101, off.grey], [1, true, false]);
});

// #216 (XooVe): a grey accept the setting keeps names the nearest quest down
// its chain that is still worth doing. The Darkshore Buzzbox chain, at its
// real levels (10, 12, 14, 16): grey from 16, 18, 21 and 23.
test('skipGrey: a grey accept kept for its chain names the nearest open quest it leads to', () => {
	const guides = `
		Polestar.RegisterGuide({ id = "test/buzz", pack = "test", title = "Buzzbox", faction = "Horde", minLevel = 16, maxLevel = 21, steps = {
			{ goals = { { t = "accept", quest = 983, title = "Buzzbox 827", qlvl = 10 } } },
			{ goals = { { t = "turnin", quest = 983, title = "Buzzbox 827" }, { t = "accept", quest = 1001, title = "Buzzbox 411", qlvl = 12, pre = { 983 } } } },
			{ goals = { { t = "turnin", quest = 1001, title = "Buzzbox 411" }, { t = "accept", quest = 1002, title = "Buzzbox 323", qlvl = 14, pre = { 1001 } } } },
			{ goals = { { t = "turnin", quest = 1002, title = "Buzzbox 323" }, { t = "accept", quest = 1003, title = "Buzzbox 525", qlvl = 16, pre = { 1002 } } } },
			{ goals = { { t = "turnin", quest = 1003, title = "Buzzbox 525" } } },
		} })
	`;
	const script = `
		E.SetGuide("test/buzz")
		local out = {}
		for _, level in ipairs({ 20, 22, 23 }) do
			stub.world.setLevel(level); flush()
			local first = E.GetStepView(1).goals[1]
			local accepts = {}
			for i = 2, 4 do
				local g = E.GetStepView(i).goals[2]
				accepts[#accepts + 1] = g.keptGrey or (g.skippedGrey and "skipped") or "open"
			end
			out[#out + 1] = { level = level, kept = first.keptGrey or false, text = first.keptGreyText or false,
				skipped = first.skippedGrey or false, accepts = accepts }
		end
		emit(out)
	`;
	const [on] = run({ guides, saved: { Polestar: 'PolestarDB = { schema = 1, settings = { behavior = { skipGrey = true } } }' }, script });
	assert.deepEqual(on, [
		// 1002 still worth doing: 827 and 411 lead to it.
		{ level: 20, kept: 1002, text: 'Grey, kept: opens Buzzbox 323', skipped: false, accepts: [1002, 'open', 'open'] },
		// Only 525 left: the grey chain before it names it.
		{ level: 22, kept: 1003, text: 'Grey, kept: opens Buzzbox 525', skipped: false, accepts: [1003, 1003, 'open'] },
		// All grey: the chain is left out, nothing to explain.
		{ level: 23, kept: false, text: false, skipped: true, accepts: ['skipped', 'skipped', 'skipped'] },
	]);
	const [off] = run({ guides, saved: { Polestar: 'PolestarDB = { schema = 1, settings = { behavior = { skipGrey = false } } }' }, script });
	assert.deepEqual(off.map((r) => [r.kept, r.text, r.skipped]), [[false, false, false], [false, false, false], [false, false, false]]);
});

test('learn goals with candidates point at the nearest usable trainer and complete when the spell is known', () => {
	const [out] = run({
		guides: `
			Polestar.RegisterGuide({ id = "test/lr", pack = "test", title = "Learn", category = "Professions", minLevel = 1, maxLevel = 60, steps = {
				{ goals = { { t = "learn", spell = 3275, spellName = "Linen Bandage", skillLine = 129, candidates = ${TRAINERS} } } },
				{ goals = { { t = "level", level = 60 } } },
			} })
		`,
		script: `
			E.SetGuide("test/lr")
			local v = E.GetStepView(1).goals[1]
			local r = { npc = v.npc, detail = v.detail, alts = v.alternatives, wp = E.GetWaypoint().map }
			stub.world.learnRecipe(3275); flush()
			r.after = E.GetStepIndex()
			emit(r)
		`,
	});
	assert.deepEqual(out, { npc: 3373, detail: 'from Arnok', alts: 2, wp: 1411, after: 2 });
});

const CRAFT = `
	Polestar.RegisterGuide({ id = "test/cook", pack = "test", title = "Cooking", category = "Professions", minLevel = 1, maxLevel = 60, steps = {
		{ goals = { { t = "collect", item = 769, itemName = "Chunk of Boar Meat", count = 4 } } },
		{ goals = {
			{ t = "collect", item = 2672, itemName = "Stringy Wolf Meat", count = 10 },
			{ t = "craft", spell = 2540, spellName = "Roasted Boar Meat", untilSkill = 50, skillLine = 185 },
		} },
		{ goals = { { t = "level", level = 60 } } },
	} })
`;

test('a crafting step completes even when crafting uses up the reagents its collect goal gathered', () => {
	const [out] = run({
		guides: CRAFT,
		before: 'stub.world.learnSkill(185, "Cooking", 1, 75); stub.world.items[769] = 4',
		script: `
			local w = stub.world
			E.SetGuide("test/cook")
			local r = { start = E.GetStepIndex() }
			w.addItem(2672, 10); flush()
			r.collected = E.GetStepView(2).goals[1].status
			w.items[2672] = 0; w.addItem(1, 1); w.skillUp(185, 30); flush()
			r.consumed = { E.GetStepIndex(), E.GetStepView(2).goals[1].status }
			w.skillUp(185, 50); flush()
			r.done = E.GetStepIndex()
			emit(r)
		`,
	});
	assert.deepEqual(out, { start: 2, collected: 'done', consumed: [2, 'done'], done: 3 });
});

test('the in-step latch survives a reload and is cleared when the step is left backwards', () => {
	const [first] = run({
		guides: CRAFT,
		before: 'stub.world.learnSkill(185, "Cooking", 1, 75); stub.world.items[769] = 4',
		script: `
			E.SetGuide("test/cook")
			stub.world.addItem(2672, 10); flush()
			emit(PolestarCharDB.manual["test/cook"])
		`,
	});
	assert.deepEqual(first, { '1:1': true, '2:1': true }); // step 1 passed, step 2 in-step

	const [reloaded] = run({
		guides: CRAFT,
		// Reloaded with the meat already cooked away.
		before: 'stub.world.learnSkill(185, "Cooking", 30, 75); stub.world.items[769] = 4',
		saved: { Polestar: 'PolestarCharDB = { schema = 1, tabs = { "test/cook" }, activeTab = 1, manual = { ["test/cook"] = { ["2:1"] = true } } }' },
		script: `
			local r = { at = E.GetStepIndex(), collect = E.GetStepView(2).goals[1].status }
			E.Prev(); flush()
			r.prev = E.GetStepIndex()
			r.latch = PolestarCharDB.manual["test/cook"]["2:1"] or false
			E.Next(); flush()
			r.back = { E.GetStepIndex(), E.GetStepView(2).goals[1].status }
			emit(r)
		`,
	});
	assert.deepEqual(reloaded, { at: 2, collect: 'done', prev: 1, latch: false, back: [2, 'active'] });
});

// Candidates as the compiler emits them for `train First Aid`, on a world
// laid out like Azeroth: Tirisfal, Elwynn, Westfall and Stormwind on one
// continent; Durotar and Teldrassil on the other.
const AZEROTH = `
local w = stub.world
w.maps = {}
w.addMap(1415, { name = "Eastern Kingdoms", mapType = 2 })
w.addMap(1414, { name = "Kalimdor", mapType = 2 })
w.addMap(1420, { name = "Tirisfal Glades", c = 0, top = 3000, bottom = 1000, left = 1000, right = -1000, parent = 1415 })
w.addMap(1429, { name = "Elwynn Forest", c = 0, top = -8000, bottom = -10000, left = 500, right = -1500, parent = 1415 })
w.addMap(1436, { name = "Westfall", c = 0, top = -9500, bottom = -12000, left = 2500, right = 500, parent = 1415 })
w.addMap(1453, { name = "Stormwind City", c = 0, top = -8000, bottom = -9500, left = 1500, right = 500, parent = 1429 })
w.addMap(1411, { name = "Durotar", c = 1, top = 0, bottom = -2000, left = -3000, right = -5000, parent = 1414 })
w.addMap(1438, { name = "Teldrassil", c = 1, top = 11000, bottom = 9000, left = 2500, right = 0, parent = 1414 })
`;

function firstAid(frame) {
	const f = frame ? ', f = "e"' : '';
	return `
		Polestar.RegisterGuide({ id = "test/fa2", pack = "test", title = "First Aid", category = "Professions", minLevel = 1, maxLevel = 60, steps = {
			{ goals = { { t = "train", skill = "First Aid", skillLine = 129, rank = 1, candidates = {
				{ npc = 3373, npcName = "Rawrk", map = 1411, x = 54, y = 42, faction = "H"${f} },
				{ npc = 4211, npcName = "Byancie", map = 1438, x = 55, y = 57, faction = "A"${f} },
				{ npc = 2798, npcName = "Nurse Neela", map = 1420, x = 61, y = 52, faction = "H"${f} },
				{ npc = 5150, npcName = "Shaina Fuller", map = 1453, x = 64, y = 48, faction = "A"${f} },
				{ npc = 2329, npcName = "Michelle Belle", map = 1429, x = 39, y = 48, faction = "A"${f} },
			} } } },
			{ goals = { { t = "level", level = 60 } } },
		} })
	`;
}

function pickFrom({ race, faction, map, x, y, eraWithoutFrames }) {
	const [out] = run({
		before: `${AZEROTH}
			w.race, w.faction = "${race}", "${faction}"
			w.moveTo(${map}, ${x}, ${y})`,
		guides: firstAid(eraWithoutFrames),
		script: 'E.SetGuide("test/fa2"); emit(E.GetStepView(1).goals[1].npcName)',
	});
	return out;
}

for (const eraWithoutFrames of [false, true]) {
	const how = eraWithoutFrames ? 'with no frames registered for the candidate maps' : 'with placeable candidates';
	test(`the pick follows the player's position, ${how}`, () => {
		assert.equal(pickFrom({ race: 'Scourge', faction: 'Horde', map: 1420, x: 60, y: 52, eraWithoutFrames }), 'Nurse Neela'); // Brill
		assert.equal(pickFrom({ race: 'Orc', faction: 'Horde', map: 1411, x: 52, y: 43, eraWithoutFrames }), 'Rawrk'); // Razor Hill
		const westfall = pickFrom({ race: 'Human', faction: 'Alliance', map: 1436, x: 56, y: 47, eraWithoutFrames }); // Sentinel Hill
		assert.ok(['Shaina Fuller', 'Michelle Belle'].includes(westfall), westfall);
	});
}

test('a vendor in a zone far above the character comes after every other choice; still there to cycle to, and first again once in range', () => {
	// South Darkshore, level 18: Chagrak Hammerstrike in Mount Hyjal (56-60) is
	// nearer by straight line than Naram Longclaw in Auberdine.
	const pick = (level) => runAddon({
		stubs: ['stub_world.lua'],
		before: `
			local w = stub.world
			w.addMap(1439, { name = "Darkshore", c = 1, left = 1000, right = -1000, top = 3000, bottom = 0 })
			w.addMap(2482, { name = "Mount Hyjal", c = 1, left = 200, right = -1800, top = 1000, bottom = -1000 })
			w.race, w.raceName, w.faction, w.class = "NightElf", "Night Elf", "Alliance", "PRIEST"
			w.level = ${level}
			w.moveTo(1439, 41.77, 83.55)`,
		addons: [{ name: 'Polestar', files: ['Core/Core.xml', 'Maps/Maps.lua', 'Maps/WorldMap.lua'] }],
		script: `${TEST_PACK}
${TEST_SOURCE}
			Polestar.Maps.RegisterZoneLevels({ [1439] = { 10, 20, 50, 50 }, [2482] = { 56, 60, 50, 50 } })
			Polestar.RegisterGuide({ id = "test/darkshore", pack = "test", title = "Darkshore", faction = "Alliance", minLevel = 10, maxLevel = 20, steps = {
				{ goals = { { t = "vendor", candidates = {
					{ npc = 4183, npcName = "Naram Longclaw", map = 1439, x = 37.57, y = 40.35, faction = "A" },
					{ npc = 265883, npcName = "Chagrak Hammerstrike", map = 2482, x = 13.4, y = 52.4, faction = "AH" },
				} } } },
				{ goals = { { t = "level", level = 60 } } },
			} })
			stub.login()
			local E = Polestar.Engine
			E.SetGuide("test/darkshore")
			local first = E.GetStepView(1).goals[1].npcName
			E.CycleCandidate(1, 1)
			emit({ first = first, cycled = E.GetStepView(1).goals[1].npcName })`,
	}).emitted[0];
	assert.deepEqual(pick(18), { first: 'Naram Longclaw', cycled: 'Chagrak Hammerstrike' });
	assert.deepEqual(pick(50), { first: 'Chagrak Hammerstrike', cycled: 'Naram Longclaw' });
});
