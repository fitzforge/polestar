'use strict';
// The catch-up: a character who already did part of the route opens a
// leveling guide and it resumes where they are, as placement does, leaving
// out what is too low to be worth it: grey quests anywhere, green ones behind
// the last quest progress, the way to them, and a whole guide they are past
// (it chains to the next one). A low quest a later quest worth doing needs is
// kept. Guides that are not leveling ones, a guide whose author says
// `skip none`, and a guide the player sets to every step do every step.
// Real Core manifest, stub world.

const { test } = require('node:test');
const assert = require('node:assert/strict');
const { runAddon } = require('./helpers/lua');
const { TEST_PACK, TEST_SOURCE } = require('./helpers/packs');

const CORE = { name: 'Polestar', files: ['Core/Core.xml'] };

// A level-20 Human: grey at 13 and below, green from 14 to 17, yellow from 18.
const WORLD = `
local w = stub.world
w.addMap(1429, { name = "Elwynn Forest", c = 0, left = 1500, right = -1500, top = 500, bottom = -1500 })
w.moveTo(1429, 50, 50)
w.race, w.raceName, w.faction, w.class, w.className = "Human", "Human", "Alliance", "WARRIOR", "Warrior"
w.level = 20
`;

// test/low (1-12): grey for them, done in part, with a grey quest handed in
// with no accept (`turnin ... direct`, as Distracting Jarven in Dun
// Morogh). test/mid (15-22): a trip to a green quest behind their progress, a grey quest a yellow one needs, a
// green quest still in the log behind it (kept: they chose it), and the last
// quest they did.
const GUIDES = `
Polestar.RegisterGuide({ id = "test/low", pack = "test", title = "Low", faction = "Alliance", minLevel = 1, maxLevel = 12, next = "test/mid", steps = {
	{ goals = { { t = "accept", quest = 101, title = "Grey done", qlvl = 5 } } },
	{ goals = { { t = "goto", map = 1429, x = 10, y = 10, label = "Farm" } } },
	{ goals = { { t = "accept", quest = 102, title = "Grey not done", qlvl = 6 } } },
	{ goals = { { t = "turnin", quest = 102, title = "Grey not done" }, { t = "turnin", quest = 101, title = "Grey done" } } },
	{ goals = { { t = "turnin", quest = 104, title = "Grey direct", direct = true, qlvl = 7 } } },
	{ goals = { { t = "fly", location = "Stormwind City" } } },
} })
Polestar.RegisterGuide({ id = "test/mid", pack = "test", title = "Mid", faction = "Alliance", minLevel = 15, maxLevel = 22, steps = {
	{ goals = { { t = "goto", map = 1429, x = 20, y = 20, label = "Town" } } },
	{ goals = { { t = "accept", quest = 201, title = "Green behind", qlvl = 15 } } },
	{ goals = { { t = "goto", map = 1429, x = 30, y = 30, label = "Camp" } } },
	{ goals = { { t = "turnin", quest = 201, title = "Green behind" } } },
	{ goals = { { t = "accept", quest = 202, title = "Grey needed", qlvl = 12 } } },
	{ goals = { { t = "turnin", quest = 202, title = "Grey needed" }, { t = "accept", quest = 203, title = "Yellow", qlvl = 19, pre = { 202 } } } },
	{ goals = { { t = "accept", quest = 206, title = "Green in the log", qlvl = 14 } } },
	{ goals = { { t = "turnin", quest = 206, title = "Green in the log" } } },
	{ goals = { { t = "accept", quest = 204, title = "Done", qlvl = 16 } } },
	{ goals = { { t = "accept", quest = 205, title = "Ahead", qlvl = 20 } } },
	{ goals = { { t = "turnin", quest = 203, title = "Yellow" } } },
} })
`;

function run({ before = '', guides = GUIDES, saved, script }) {
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
			PLACED = {}
			Polestar.On("GUIDE_PLACED", function(id, step, chain)
				PLACED[#PLACED + 1] = { id = id, step = step or false, chain = table.concat(chain or {}, ",") }
			end)
			stub.login()
			stub.fire("QUEST_LOG_UPDATE"); stub.advance(0.6)
			${script}`,
	}).emitted;
}

const DONE = 'stub.world.complete({ 101, 204 }); stub.world.onQuest(206, {})';
const OFF = { Polestar: 'PolestarDB = { schema = 1, settings = { behavior = { skipGrey = false } } }' };

// Each step's status, as the guide window shows it ("na": left out).
const STATUSES = `
	local function statuses()
		local out = {}
		for i = 1, #E.GetGuide().steps do
			local goals = E.GetStepView(i).goals
			out[i] = goals[#goals].status
		end
		return out
	end
`;

test('a level-20 character opening a grey guide is taken through it to the next, and resumes at the grey quest a yellow one needs', () => {
	const [out] = run({
		before: DONE,
		script: `${STATUSES}
			E.SetGuide("test/low"); flush()
			emit({ guide = E.GetGuide().id, at = E.GetStepIndex(), placed = PLACED[#PLACED], statuses = statuses() })
		`,
	});
	assert.equal(out.guide, 'test/mid');
	assert.equal(out.at, 5, 'the grey quest Yellow needs, after the trip to the green quest left behind');
	assert.deepEqual(out.placed, { id: 'test/mid', step: 5, chain: 'test/low' });
	// Green behind and its turn-in are left out, the trips pass; the quest in the log keeps its turn-in.
	assert.deepEqual(out.statuses.slice(0, 9), ['done', 'na', 'done', 'na', 'active', 'pending', 'done', 'pending', 'done']);
});

// Yendi at 30 in Duskwood (25-27): Gather Rot Blossoms (24) and The Night
// Watch (26) in the log, neither done. In the log by the same rules as a quest
// not taken: too low and not done, it goes; done, it stays to be handed in.
test('a low quest in the log goes while it is not done, and stays once it only has to be handed in', () => {
	const duskwood = `
		Polestar.RegisterGuide({ id = "test/dusk", pack = "test", title = "Duskwood", faction = "Alliance", minLevel = 25, maxLevel = 27, next = "test/mid", steps = {
			{ goals = { { t = "accept", quest = 57, title = "The Night Watch", qlvl = 26 } } },
			{ goals = { { t = "accept", quest = 156, title = "Gather Rot Blossoms", qlvl = 24 } } },
			{ goals = { { t = "collect", item = 1598, itemName = "Rot Blossom", quest = 156, oi = 1, count = 8 } } },
			{ goals = { { t = "kill", target = "Skeletal Horror", npc = 202, quest = 57, oi = 1, count = 15 } } },
			{ goals = { { t = "turnin", quest = 156, title = "Gather Rot Blossoms" }, { t = "turnin", quest = 57, title = "The Night Watch" } } },
		} })
	` + GUIDES;
	const night = 'stub.world.onQuest(57, { { required = 15, fulfilled = 1 } })';
	const script = 'E.SetGuide("test/dusk"); flush(); emit({ guide = E.GetGuide().id, at = E.GetStepIndex() })';
	const [notDone] = run({
		before: `stub.world.level = 30
			stub.world.onQuest(156, { { type = "item", required = 8, fulfilled = 0 } })
			${night}`,
		guides: duskwood,
		script,
	});
	assert.equal(notDone.guide, 'test/mid', 'both too low and not done: the guide passes');
	const [ready] = run({
		before: `stub.world.level = 30
			stub.world.onQuest(156, { { type = "item", required = 8, fulfilled = 8 } })
			${night}`,
		guides: duskwood,
		script,
	});
	assert.deepEqual(ready, { guide: 'test/dusk', at: 5 }, 'the blossoms gathered: the guide takes them to hand in');
});

test('without "Skip grey quests" the guide is placed as before: the first quest not done, in the first guide', () => {
	const [out] = run({
		before: DONE,
		saved: OFF,
		script: 'E.SetGuide("test/low"); flush(); emit({ guide = E.GetGuide().id, at = E.GetStepIndex() })',
	});
	assert.deepEqual(out, { guide: 'test/low', at: 3 }, 'the trip to the farm is behind a quest turned in');
});

test('a leveling guide set to every step, by its player or by its author, keeps its grey quests and what lies behind', () => {
	const [mine] = run({
		before: DONE,
		script: `
			E.SetGuide("test/mid"); flush()
			local caught = E.GetStepIndex()
			local before = { E.GetEveryStep("test/mid") }
			E.SetEveryStep("test/mid", true); flush()
			local all = E.GetStepIndex()
			E.SetEveryStep("test/mid", false); flush()
			emit({ caught = caught, before = before, all = all, again = E.GetStepIndex(), saved = PolestarCharDB.everyStep or false })
		`,
	});
	// Every step: back to the green quest behind (the trip before it was already passed).
	assert.deepEqual(mine, { caught: 5, before: [false, true], all: 2, again: 5, saved: false });

	const author = GUIDES.replace('title = "Mid",', 'title = "Mid", everyStep = true,');
	const [theirs] = run({
		before: DONE,
		guides: author,
		script: 'E.SetGuide("test/mid"); flush(); emit({ at = E.GetStepIndex(), every = { E.GetEveryStep("test/mid") }, set = E.SetEveryStep("test/mid", false) })',
	});
	assert.deepEqual(theirs, { at: 2, every: [true, false], set: false });
});

test('a guide that is not a leveling one does every step: an item guide keeps its quests grey or not', () => {
	const item = `
		Polestar.RegisterGuide({ id = "test/bag", pack = "test", title = "Bag", category = "Collectibles", minLevel = 14, maxLevel = 60, steps = {
			{ goals = { { t = "accept", quest = 301, title = "First clue", qlvl = 8 } } },
			{ goals = { { t = "turnin", quest = 301, title = "First clue" } } },
			{ goals = { { t = "accept", quest = 302, title = "Second clue", qlvl = 9 } } },
		} })
	`;
	const [out] = run({
		guides: item,
		script: `${STATUSES}
			E.SetGuide("test/bag"); flush()
			emit({ at = E.GetStepIndex(), statuses = statuses(), every = { E.GetEveryStep("test/bag") } })
		`,
	});
	assert.deepEqual(out, { at: 1, statuses: ['active', 'pending', 'pending'], every: [true, false] });
});

test('a quest left out comes back when the player takes it by hand, and a level the guide waits for keeps it from passing whole', () => {
	const [byHand] = run({
		before: DONE,
		script: `${STATUSES}
			E.SetGuide("test/mid"); flush()
			stub.world.accept(201, {}, "Green behind"); flush()
			local s = statuses()
			emit({ accept = s[2], turnin = s[4] })
		`,
	});
	assert.deepEqual(byHand, { accept: 'done', turnin: 'active' }, 'its turn-in is the step now');

	// test/low with a quest for level 21: the guide is not passed whole.
	const waiting = GUIDES.replace('{ goals = { { t = "fly", location = "Stormwind City" } } },',
		'{ goals = { { t = "accept", quest = 103, title = "Later", qlvl = 21, minLevel = 21 } } },');
	const [held] = run({
		before: DONE,
		guides: waiting,
		script: 'E.SetGuide("test/low"); flush(); emit(E.GetGuide().id)',
	});
	assert.equal(held, 'test/low');
});

test('a reload places the guide again at the same step; with nothing behind the player, the guide is placed as before', () => {
	const [reload] = run({
		before: DONE,
		saved: { Polestar: 'PolestarCharDB = { schema = 1, tabs = { "test/mid" }, activeTab = 1 }' },
		script: 'emit({ at = E.GetStepIndex(), placed = PLACED[#PLACED] })',
	});
	assert.deepEqual(reload, { at: 5, placed: { id: 'test/mid', step: 5, chain: '' } });

	const [fresh] = run({
		script: 'E.SetGuide("test/mid"); flush(); emit(E.GetStepIndex())',
	});
	assert.equal(fresh, 1, 'nothing done: the guide starts at its first step');
});

// Yendi: the first time, the guide starts from the race's first guide and
// goes through every guide to where the character is, for them to see.
test('with no guide open at login, the catch-up starts from the first guide and goes through to where the character is', () => {
	const [out] = run({
		before: DONE,
		saved: { Polestar: 'PolestarCharDB = nil' },
		script: 'emit({ guide = E.GetGuide().id, at = E.GetStepIndex(), placed = PLACED[#PLACED], first = Polestar.Guides.FirstGuide(), suggest = Polestar.Guides.Suggest(), start = E.StartingGuide() })',
	});
	// The guide window's and the welcome's Start guide open E.StartingGuide() too.
	assert.deepEqual(out, { guide: 'test/mid', at: 5, placed: { id: 'test/mid', step: 5, chain: 'test/low' }, first: 'test/low', suggest: 'test/mid', start: 'test/low' });

	// Without the catch-up, the guide for their level, as before.
	const [off] = run({ before: DONE, saved: { Polestar: 'PolestarDB = { schema = 1, settings = { behavior = { skipGrey = false } } }; PolestarCharDB = nil' }, script: 'emit(E.GetGuide().id)' });
	assert.equal(off, 'test/mid');
});

// Yendi at 30 in Darkshore (15-18): The Tower of Althalaxx, grey and green
// there, leads to four quests at 28 and 31 in Ashenvale. In a guide the
// character is past, a low chain is worth the detour only when at least three
// quests from yellow up need it.
test('in a guide the character is past, a low chain stays only when three quests from yellow up need it', () => {
	const guides = (worth) => `
		Polestar.RegisterGuide({ id = "test/dark", pack = "test", title = "Darkshore", faction = "Alliance", minLevel = 10, maxLevel = 15, next = "test/ashen", steps = {
			{ goals = { { t = "accept", quest = 401, title = "Tower 1", qlvl = 12 } } },
			{ goals = { { t = "turnin", quest = 401, title = "Tower 1" }, { t = "accept", quest = 402, title = "Tower 2", qlvl = 14, pre = { 401 } } } },
			{ goals = { { t = "turnin", quest = 402, title = "Tower 2" } } },
			{ goals = { { t = "accept", quest = 403, title = "Lone low", qlvl = 12 } } },
			{ goals = { { t = "turnin", quest = 403, title = "Lone low" } } },
		} })
		Polestar.RegisterGuide({ id = "test/ashen", pack = "test", title = "Ashenvale", faction = "Alliance", minLevel = 18, maxLevel = 25, steps = {
			{ goals = { { t = "accept", quest = 410, title = "Tower 3", qlvl = 19, pre = { 402 } } } },
			{ goals = { { t = "turnin", quest = 410, title = "Tower 3" }, { t = "accept", quest = 411, title = "Tower 4", qlvl = 20, pre = { 410 } } } },
			${worth ? '{ goals = { { t = "turnin", quest = 411, title = "Tower 4" }, { t = "accept", quest = 412, title = "Tower 5", qlvl = 21, pre = { 411 } } } },' : ''}
			{ goals = { { t = "accept", quest = 420, title = "After the lone one", qlvl = 19, pre = { 403 } } } },
			{ goals = { { t = "accept", quest = 430, title = "Ashenvale", qlvl = 20 } } },
		} })
	`;
	const script = `${STATUSES}
		E.SetGuide("test/dark"); flush()
		emit({ guide = E.GetGuide().id, at = E.GetStepIndex() or false, statuses = E.GetGuide().id == "test/dark" and statuses() or false })`;
	const [three] = run({ guides: guides(true), saved: { Polestar: 'PolestarCharDB = nil' }, script });
	assert.deepEqual(three, { guide: 'test/dark', at: 1, statuses: ['active', 'pending', 'pending', 'na', 'na'] }, 'three quests from yellow up: the chain stays, the lone low quest goes');
	const [two] = run({ guides: guides(false), saved: { Polestar: 'PolestarCharDB = nil' }, script });
	assert.equal(two.guide, 'test/ashen', 'two only: not worth the detour, the guide passes');
});

// Yendi: the guide list's check means every quest of the guide is done; a
// guide the catch-up passed with grey quests never done is not checked. A
// guide all done, opened by the player, stays open, finished.
test('a guide is done for the list only once all its quests are; one all done, opened by hand, stays open', () => {
	const allDone = 'stub.world.complete({ 101, 102, 104, 204 }); stub.world.onQuest(206, {})';
	const [passed] = run({
		before: DONE,
		script: 'E.SetGuide("test/low"); flush(); emit({ guide = E.GetGuide().id, low = E.GetGuideState("test/low") })',
	});
	assert.deepEqual(passed, { guide: 'test/mid', low: 'started' }, 'passed with a grey quest never done: not done');
	const [opened] = run({
		before: allDone,
		script: 'E.SetGuide("test/low"); flush(); emit({ guide = E.GetGuide().id, at = E.GetStepIndex() or false, low = E.GetGuideState("test/low") })',
	});
	assert.deepEqual(opened, { guide: 'test/low', at: false, low: 'done' }, 'all done and opened by hand: it stays, finished');
});

// Yendi: a catch-up stopped at the end of a guide ("Guide complete, Up next")
// on a second try in the session (the next guide had finished on the first),
// and on a quest whose prerequisite was a grey one it left out.
test('a catch-up goes on to the next guide silently: on a second try, and past a quest whose prerequisite it left out', () => {
	const guides = GUIDES.replace('maxLevel = 12, next = "test/mid"', 'maxLevel = 12, next = "test/low2"') + `
		Polestar.RegisterGuide({ id = "test/low2", pack = "test", title = "Low 2", faction = "Alliance", minLevel = 8, maxLevel = 14, next = "test/mid", steps = {
			{ goals = { { t = "accept", quest = 150, title = "Grey start", qlvl = 8 } } },
			{ goals = { { t = "turnin", quest = 150, title = "Grey start" }, { t = "accept", quest = 152, title = "Yellow after it", qlvl = 19, pre = { 150 } } } },
			{ goals = { { t = "turnin", quest = 152, title = "Yellow after it" } } },
		} })
	`;
	const [out] = run({
		before: DONE,
		guides,
		saved: { Polestar: 'PolestarCharDB = nil' },
		script: `
			local first = { E.GetGuide().id, PLACED[#PLACED].chain }
			E.SetGuide("test/low"); flush()
			emit({ first = first, again = { E.GetGuide().id, PLACED[#PLACED].chain } })`,
	});
	assert.deepEqual(out.first, ['test/mid', 'test/low,test/low2'], 'the first run goes through both');
	assert.deepEqual(out.again, ['test/mid', 'test/low,test/low2'], 'a second try in the session too');
});

// Yendi: Start guide with no guide open stopped on "Guide complete" at the
// end of Dun Morogh, every quest of it done: it goes on to the next guide,
// as the login's pick does. The list's own open keeps a finished guide.
test('Start guide goes on through guides with every quest done; the list keeps such a guide open', () => {
	const allDone = 'stub.world.complete({ 101, 102, 104, 204 }); stub.world.onQuest(206, {})';
	const saved = { Polestar: 'PolestarDB = { schema = 1, settings = { behavior = { autoSelectGuide = false } } }; PolestarCharDB = nil' };
	const [start] = run({ before: allDone, saved, script: 'local none = E.GetGuide() == nil; E.StartGuide(); flush(); emit({ none = none, guide = E.GetGuide().id, at = E.GetStepIndex() or false })' });
	assert.deepEqual(start, { none: true, guide: 'test/mid', at: 5 });
	const [list] = run({ before: allDone, saved, script: 'E.OpenTab("test/low"); flush(); emit({ guide = E.GetGuide().id, at = E.GetStepIndex() or false })' });
	assert.deepEqual(list, { guide: 'test/low', at: false });
});
