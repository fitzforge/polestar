'use strict';
// Class-training reminder (Engine "Smart logic"): with the shipped
// Core/ClassTrainers.lua, a character whose guide does not send them to
// their class trainer is reminded, with the nearest trainer of their class
// and faction. Real Core manifest, stub world.

const { test } = require('node:test');
const assert = require('node:assert/strict');
const { runAddon } = require('./helpers/lua');
const { TEST_PACK, TEST_SOURCE } = require('./helpers/packs');

const CORE = { name: 'Polestar', files: ['Core/Core.xml'] };

// An Undead Warrior at the Crossroads (Era frame of the Barrens).
const WORLD = `
local w = stub.world
w.addMap(1413, { name = "The Barrens", c = 1, left = 2622.917, right = -7510.417, top = 1612.5, bottom = -5139.583 })
w.addMap(1412, { name = "Mulgore", c = 1, left = 2047.917, right = -3089.583, top = -272.917, bottom = -3697.917 })
w.race, w.raceName, w.faction, w.class = "Scourge", "Undead", "Horde", "WARRIOR"
w.level = 12
w.moveTo(1413, 51.9, 30.4)
`;

// The Barrens guide trains Orcs and Trolls in Orgrimmar; nothing for an Undead.
const GUIDES = `
Polestar.RegisterGuide({ id = "test/barrens", pack = "test", title = "The Barrens", faction = "Horde", minLevel = 10, maxLevel = 20, steps = {
	{ goals = { { t = "accept", quest = 870, title = "The Forgotten Pools", map = 1413, x = 52, y = 31 } } },
	{ only = { races = { "Orc", "Troll" } }, goals = { { t = "train", npc = 3353, npcName = "Grezz Ragefist", only = { classes = { "WARRIOR" } } } } },
	{ goals = { { t = "level", level = 20 } } },
} })
Polestar.RegisterGuide({ id = "test/trains", pack = "test", title = "Trains soon", faction = "Horde", minLevel = 10, maxLevel = 20, steps = {
	{ goals = { { t = "accept", quest = 870, title = "The Forgotten Pools", map = 1413, x = 52, y = 31 } } },
	{ goals = { { t = "train", class = true, candidates = { { npc = 3353, npcName = "Grezz Ragefist", map = 1454, x = 79.8, y = 31.4, f = "e", faction = "H", classes = { "WARRIOR" } } } } } },
	{ goals = { { t = "level", level = 20 } } },
} })
-- Heads south-west to Mulgore: the nearest trainer from the Crossroads lies the other way.
Polestar.RegisterGuide({ id = "test/route", pack = "test", title = "To Mulgore", faction = "Horde", minLevel = 10, maxLevel = 20, steps = {
	{ goals = { { t = "accept", quest = 870, title = "The Forgotten Pools", map = 1413, x = 52, y = 31 } } },
	{ goals = { { t = "goto", map = 1413, x = 45, y = 58 } } },
	{ goals = { { t = "goto", map = 1412, x = 47, y = 60 } } },
	{ goals = { { t = "level", level = 20 } } },
} })
-- Dun Morogh: from the trogg tunnel on to Kharanos (the report in #664).
Polestar.RegisterGuide({ id = "test/tunnel", pack = "test", title = "The tunnel", faction = "Alliance", minLevel = 1, maxLevel = 20, steps = {
	{ goals = { { t = "accept", quest = 2160, title = "Supplies to Tannok", map = 1426, x = 33.9, y = 72.2 } } },
	{ goals = { { t = "goto", map = 1426, x = 47.2, y = 52.4 } } },
	{ goals = { { t = "goto", map = 1426, x = 47.3, y = 52.9 } } },
	{ goals = { { t = "level", level = 20 } } },
} })
-- A Dwarf near the tunnel with Coldridge work still ahead: Anvilmar, then the tunnel, then Kharanos.
Polestar.RegisterGuide({ id = "test/coldridge", pack = "test", title = "Coldridge", faction = "Alliance", minLevel = 1, maxLevel = 20, steps = {
	{ goals = { { t = "goto", map = 1426, x = 28.8, y = 66.2 } } },
	{ goals = { { t = "goto", map = 1426, x = 26.9, y = 80.0 } } },
	{ goals = { { t = "goto", map = 1426, x = 28.8, y = 66.2 } } },
	{ goals = { { t = "goto", map = 1426, x = 33.9, y = 72.2 } } },
	{ goals = { { t = "goto", map = 1426, x = 47.2, y = 52.4 } } },
	{ goals = { { t = "level", level = 20 } } },
} })
-- Grik'nir's cave, then (or not) a stop in Anvilmar, the tunnel and Kharanos.
Polestar.RegisterGuide({ id = "test/cave-anvilmar", pack = "test", title = "Cave, Anvilmar", faction = "Alliance", minLevel = 1, maxLevel = 20, steps = {
	{ goals = { { t = "goto", map = 1426, x = 26.9, y = 80.0 } } },
	{ goals = { { t = "goto", map = 1426, x = 28.8, y = 66.2 } } },
	{ goals = { { t = "goto", map = 1426, x = 33.9, y = 72.2 } } },
	{ goals = { { t = "goto", map = 1426, x = 47.2, y = 52.4 } } },
	{ goals = { { t = "level", level = 20 } } },
} })
Polestar.RegisterGuide({ id = "test/cave-direct", pack = "test", title = "Cave, tunnel", faction = "Alliance", minLevel = 1, maxLevel = 20, steps = {
	{ goals = { { t = "goto", map = 1426, x = 26.9, y = 80.0 } } },
	{ goals = { { t = "goto", map = 1426, x = 33.9, y = 72.2 } } },
	{ goals = { { t = "goto", map = 1426, x = 47.2, y = 52.4 } } },
	{ goals = { { t = "level", level = 20 } } },
} })
-- The trainer is the sixth step: past the reminder's reach from step 1.
Polestar.RegisterGuide({ id = "test/trains-far", pack = "test", title = "Trains far", faction = "Horde", minLevel = 10, maxLevel = 20, steps = {
	{ goals = { { t = "goto", map = 1413, x = 20, y = 20 } } },
	{ goals = { { t = "goto", map = 1413, x = 21, y = 20 } } },
	{ goals = { { t = "goto", map = 1413, x = 22, y = 20 } } },
	{ goals = { { t = "goto", map = 1413, x = 23, y = 20 } } },
	{ goals = { { t = "goto", map = 1413, x = 24, y = 20 } } },
	{ goals = { { t = "train", class = true, candidates = { { npc = 3353, npcName = "Grezz Ragefist", map = 1454, x = 79.8, y = 31.4, f = "e", faction = "H", classes = { "WARRIOR" } } } } } },
	{ goals = { { t = "level", level = 20 } } },
} })
`;

function run({ saved, pre = '', script, addons = [CORE] }) {
	return runAddon({
		stubs: ['stub_world.lua'],
		before: WORLD,
		addons,
		saved,
		script: `${TEST_PACK}
${TEST_SOURCE}
${GUIDES}
DUE = {}
Polestar.On("TRAIN_DUE", function(level, t) DUE[#DUE + 1] = { level = level, npc = t.npc, map = t.map, faction = t.faction, warrior = (function() for _, c in ipairs(t.classes) do if c == "WARRIOR" then return true end end return false end)() } end)
Polestar.On("CLASS_TRAINED", function(level) DUE[#DUE + 1] = { trained = level } end)
${pre}
stub.login()
${script}`,
	}).emitted;
}

const TRAINED_AT_10 = { Polestar: 'PolestarCharDB = { schema = 1, classTrainLevel = 10 }' };

test('an Undead in the Barrens is reminded at 12, with the nearest Horde warrior trainer; training clears it', () => {
	const [out] = run({
		saved: TRAINED_AT_10,
		script: `
			Polestar.Engine.SetGuide("test/barrens"); stub.advance(0.5)
			local first = DUE[1]
			-- Once per level: more evaluations do not repeat it.
			stub.advance(0.5); Polestar.Engine.RequestUpdate(); stub.advance(0.5)
			local count = #DUE
			stub.world.trainer(first.npc); stub.advance(0.5)
			emit({ first = first, count = count, trained = DUE[#DUE], saved = PolestarCharDB.classTrainLevel })`,
	});
	assert.equal(out.first.level, 12);
	assert.equal(out.first.faction, 'H');
	assert.equal(out.first.warrior, true);
	// Kalimdor, near the Crossroads: Orgrimmar or Durotar, never Undercity.
	assert.ok([1411, 1454].includes(out.first.map), `trainer on map ${out.first.map}`);
	assert.equal(out.count, 1);
	assert.deepEqual(out.trained, { trained: 12 });
	assert.equal(out.saved, 12);
});

test('a warlock at the Crossroads is reminded with Strahad Farsan in Ratchet, not Orgrimmar', () => {
	const [out] = run({
		saved: { Polestar: 'PolestarCharDB = { schema = 1, classTrainLevel = 16 }' },
		pre: 'stub.world.race, stub.world.raceName, stub.world.class, stub.world.level = "Orc", "Orc", "WARLOCK", 18',
		script: `
			Polestar.Engine.SetGuide("test/barrens"); stub.advance(0.5)
			emit({ npc = DUE[1] and DUE[1].npc, trainer = Polestar.Engine.IsClassTrainer(6251) })`,
	});
	assert.deepEqual(out, { npc: 6251, trainer: true });
});

test('no reminder when the guide trains the class within its next steps, on odd levels, on first sight, or when off', () => {
	// The open guide sends warriors to their trainer two steps ahead.
	const soon = run({
		saved: { Polestar: 'PolestarCharDB = { schema = 1, classTrainLevel = 10, tabs = { "test/trains" }, activeTab = 1 }' },
		script: 'stub.advance(0.5); emit({ due = #DUE, guide = Polestar.Engine.GetGuide().id })',
	})[0];
	assert.deepEqual(soon, { due: 0, guide: 'test/trains' });

	const odd = run({ saved: TRAINED_AT_10, pre: 'stub.world.level = 11', script: 'stub.advance(0.5); emit({ due = #DUE })' })[0];
	assert.equal(odd.due, 0);

	// No stored level (new install, or lost saved variables): counts as trained now.
	const fresh = run({ script: 'stub.advance(0.5); emit({ due = #DUE, saved = PolestarCharDB.classTrainLevel })' })[0];
	assert.deepEqual(fresh, { due: 0, saved: 12 });

	const off = run({ saved: TRAINED_AT_10, pre: 'Polestar.Set("behavior.trainReminder", "off")', script: 'stub.advance(0.5); emit({ due = #DUE })' })[0];
	assert.equal(off.due, 0);
});

test('the reminder names the trainer on the guide\'s route, not the nearest one behind it (#664)', () => {
	const near = run({ saved: TRAINED_AT_10, script: 'stub.advance(0.5); emit({ map = DUE[1].map })' })[0];
	// With no guide open the nearest trainer is east, in Durotar or Orgrimmar.
	assert.ok([1411, 1454].includes(near.map), `trainer on map ${near.map}`);
	const route = run({
		saved: { Polestar: 'PolestarCharDB = { schema = 1, classTrainLevel = 10, tabs = { "test/route" }, activeTab = 1 }' },
		script: 'stub.advance(0.5); emit({ map = DUE[1].map, npc = DUE[1].npc })',
	})[0];
	assert.ok([1412, 1456].includes(route.map), `trainer on map ${route.map}, npc ${route.npc}`);
});

test('the route never leads to a trainer in a zone far above the character', () => {
	const [out] = run({
		saved: { Polestar: 'PolestarCharDB = { schema = 1, classTrainLevel = 10, tabs = { "test/route" }, activeTab = 1 }' },
		addons: [{ name: 'Polestar', files: ['Core/Core.xml', 'Maps/Maps.lua', 'Maps/WorldMap.lua'] }],
		pre: 'Polestar.Maps.RegisterZoneLevels({ [1413] = { 10, 25, 50, 50 }, [1411] = { 1, 10, 50, 50 }, [1454] = { 1, 20, 50, 50 }, [1412] = { 55, 60, 50, 50 }, [1456] = { 55, 60, 50, 50 } })',
		script: 'stub.advance(0.5); emit({ map = DUE[1].map })',
	});
	assert.ok([1411, 1454].includes(out.map), `trainer on map ${out.map}`);
});

test('a trainer close by line but far by the route planner (a mountain between) loses to one that is reachable', () => {
	const pick = (planner) => run({
		saved: { Polestar: 'PolestarCharDB = { schema = 1, classTrainLevel = 10, tabs = { "test/route" }, activeTab = 1 }' },
		pre: planner ? `Polestar.Nav = { EstimateTravel = function(a, b)
			if a.npc == 3063 or b.npc == 3063 then return 2500 end -- Krang Stonehoof: over the ridge
			return a.map == b.map and 100 or 1000
		end }` : '',
		script: 'stub.advance(0.5); emit({ npc = DUE[1].npc })',
	})[0].npc;
	assert.equal(pick(false), 3063);
	// Harutt Thunderhorn, the next Mulgore trainer.
	assert.equal(pick(true), 3059);
});

test('a Dwarf Shaman who dings 6 in the trogg tunnel is sent on to Kharanos, not back to Anvilmar (#664)', () => {
	const [out] = run({
		saved: { Polestar: 'PolestarCharDB = { schema = 1, classTrainLevel = 4, tabs = { "test/tunnel" }, activeTab = 1 }' },
		pre: `local w = stub.world
			w.addMap(1426, { name = "Dun Morogh", c = 0, left = 1802.083, right = -3122.917, top = -3877.083, bottom = -7160.417 })
			w.race, w.raceName, w.faction, w.class, w.level = "Dwarf", "Dwarf", "Alliance", "SHAMAN", 6
			w.moveTo(1426, 36.5, 71.5)`,
		script: 'stub.advance(0.5); emit({ due = #DUE, npc = DUE[1] and DUE[1].npc })',
	});
	// 257446 Teo Hammerstorm (Anvilmar), 258113 Ingrid Dunwald (Kharanos).
	assert.deepEqual(out, { due: 1, npc: 258113 });
});

test('near the tunnel with Coldridge work still ahead, the reminder keeps to Anvilmar (#664)', () => {
	const [out] = run({
		saved: { Polestar: 'PolestarCharDB = { schema = 1, classTrainLevel = 2, tabs = { "test/coldridge" }, activeTab = 1 }' },
		pre: `local w = stub.world
			w.addMap(1426, { name = "Dun Morogh", c = 0, left = 1802.083, right = -3122.917, top = -3877.083, bottom = -7160.417 })
			w.race, w.raceName, w.faction, w.class, w.level = "Dwarf", "Dwarf", "Alliance", "SHAMAN", 4
			w.moveTo(1426, 36.5, 71.5)`,
		script: 'stub.advance(0.5); emit({ step = Polestar.Engine.GetStepIndex(), npc = DUE[1] and DUE[1].npc })',
	});
	// 257446 Teo Hammerstorm (Anvilmar).
	assert.deepEqual(out, { step: 1, npc: 257446 });
});

test('a stop in Anvilmar on the way out of the cave keeps the reminder there; without it Kharanos wins (#664)', () => {
	const pick = (guide) => run({
		saved: { Polestar: `PolestarCharDB = { schema = 1, classTrainLevel = 4, tabs = { "${guide}" }, activeTab = 1 }` },
		pre: `local w = stub.world
			w.addMap(1426, { name = "Dun Morogh", c = 0, left = 1802.083, right = -3122.917, top = -3877.083, bottom = -7160.417 })
			w.race, w.raceName, w.faction, w.class, w.level = "Dwarf", "Dwarf", "Alliance", "SHAMAN", 6
			w.moveTo(1426, 27.5, 79.0)`,
		script: 'stub.advance(0.5); emit({ npc = DUE[1] and DUE[1].npc })',
	})[0].npc;
	// 257446 Teo Hammerstorm (Anvilmar), 258113 Ingrid Dunwald (Kharanos).
	assert.equal(pick('test/cave-anvilmar'), 257446);
	assert.equal(pick('test/cave-direct'), 258113);
});

test('the reminder follows the live step, not the step on screen (#664)', () => {
	// Trained at 12 and at 12 now: nothing due until the level-up to 14 below.
	const levelUp = (guide, view) => run({
		saved: { Polestar: `PolestarCharDB = { schema = 1, classTrainLevel = 12, tabs = { "${guide}" }, activeTab = 1 }` },
		script: `stub.advance(0.5)
			Polestar.Engine.Goto(${view}); stub.advance(0.5)
			stub.world.level = 14
			Polestar.Engine.RequestUpdate(); stub.advance(0.5)
			emit({ due = #DUE, step = Polestar.Engine.GetStepIndex() })`,
	})[0];
	// Live step 1, trainer at 6: out of reach, so it is due, though step 6 is on screen.
	assert.deepEqual(levelUp('test/trains-far', 6), { due: 1, step: 6 });
	// Live step 1, trainer at 2: within reach, so held back, though step 3 is on screen.
	assert.deepEqual(levelUp('test/trains', 3), { due: 0, step: 3 });
});

test('a class trainer is one the registry holds for the character\'s class; riding trainers and other classes\' are not', () => {
	const [out] = run({
		script: `
			local E = Polestar.Engine
			emit({ warrior = E.IsClassTrainer(2119), mage = E.IsClassTrainer(198), riding = E.IsClassTrainer(4732), none = E.IsClassTrainer(nil) })`,
	});
	// Dannal Stern (warrior, Tirisfal), Khelden Bremen (mage, Northshire), Randal Hunter (riding, Elwynn).
	assert.deepEqual(out, { warrior: true, mage: false, riding: false, none: false });
});

test('every class trainer counts, not only the reminder\'s one per town: capital trainers the guides use; pet and weapon trainers do not', () => {
	// Xor'juul (hunter, Orgrimmar), Mirket (warlock, Orgrimmar), Dink (mage,
	// Ironforge), Fenthwick (rogue, Ironforge), Grezz Ragefist and Ander
	// Germaine (warriors, Orgrimmar and Stormwind).
	const cases = [
		['HUNTER', 3406],
		['WARLOCK', 3325],
		['MAGE', 7312],
		['ROGUE', 5167],
		['WARRIOR', 3353],
		['WARRIOR', 914],
	];
	for (const [cls, npc] of cases) {
		const [out] = run({ pre: `stub.world.class = "${cls}"`, script: `emit({ yes = Polestar.Engine.IsClassTrainer(${npc}) })` });
		assert.equal(out.yes, true, `${cls} ${npc}`);
	}
	// Pet trainer (Nalesette Wildbringer), weapon master (Hanashi), riding
	// (Randal Hunter), and Ariyell Skyshadow, a Darnassus weapon merchant.
	const [out] = run({
		pre: 'stub.world.class = "HUNTER"',
		script: 'local E = Polestar.Engine emit({ pet = E.IsClassTrainer(543), weapon = E.IsClassTrainer(2704), riding = E.IsClassTrainer(4732), merchant = E.IsClassTrainer(4203) })',
	});
	assert.deepEqual(out, { pet: false, weapon: false, riding: false, merchant: false });
});

// Grezz trains warriors in step 1; step 2 holds the route; step 3 trains again.
const AGAIN = `
local grezz = { { npc = 3353, npcName = "Grezz Ragefist", map = 1454, x = 79.8, y = 31.4, f = "e", faction = "H", classes = { "WARRIOR" } } }
Polestar.RegisterGuide({ id = "test/again", pack = "test", title = "Trains again", faction = "Horde", minLevel = 10, maxLevel = 20, steps = {
	{ goals = { { t = "train", class = true, candidates = grezz } } },
	{ goals = { { t = "accept", quest = 870, title = "The Forgotten Pools", map = 1413, x = 52, y = 31 } } },
	{ goals = { { t = "train", class = true, candidates = grezz } } },
	{ goals = { { t = "level", level = 20 } } },
} })
Polestar.Engine.SetGuide("test/again")
`;

test('train class asks nothing when there is nothing new: trained at this level, or at the even level below an odd one', () => {
	const at = (level, visit, extra = '') => run({
		saved: { Polestar: `PolestarCharDB = { schema = 1, classTrainLevel = ${visit ?? level}${visit ? `, classTrainVisit = ${visit}` : ''} }` },
		pre: `stub.world.level = ${level}`,
		script: `${AGAIN} stub.advance(0.5) ${extra} emit({ step = Polestar.Engine.GetStepIndex() })`,
	})[0].step;
	assert.equal(at(12, 12), 2, 'trained at 12, still 12');
	assert.equal(at(13, 12), 2, 'trained at 12, now 13: classes learn on even levels');
	assert.equal(at(14, 12), 1, 'trained at 12, now 14: new spells');
	assert.equal(at(13, 11), 1, 'trained at 11, now 13: 12 brought spells');
	// Only a visit counts: a level stored on first sight (no visit) does not.
	assert.equal(at(12, null), 1, 'no visit recorded');
	// Done and passed stays done: the next level does not send the player back.
	assert.equal(at(13, 12, 'stub.world.setLevel(14) stub.advance(0.5)'), 2, 'passed at 13, then 14');
});

test('opening a class trainer records the visit\'s level; a first sight does not', () => {
	const [out] = run({
		script: `
			stub.advance(0.5)
			local before = PolestarCharDB.classTrainVisit
			stub.world.trainer(3353); stub.advance(0.5)
			emit({ before = before or false, visit = PolestarCharDB.classTrainVisit })`,
	});
	assert.deepEqual(out, { before: false, visit: 12 });
});
