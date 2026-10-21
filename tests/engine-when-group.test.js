'use strict';
// `when group <quest>` during play (addon/Polestar/Core/Engine.lua): the
// player answers "do this group quest?" once per quest, per character
// (CharState().groupQuests, Engine.AnswerGroup). Unanswered, the step
// applies but is not done, so the route waits there and automation leaves
// the quest alone; "skip" makes `when group` fail (its turn-in goes with it,
// orphaned) and `when !group` hold, "do" the other way round. The answer is
// never guessed from the quest log. Real Core manifest, stub world (a level 1
// Human Warrior in Elwynn Forest, A Threat Within 783 in the log), as
// tests/engine-when-dungeon.test.js.

const { test } = require('node:test');
const assert = require('node:assert/strict');
const { runAddon } = require('./helpers/lua');
const { TEST_PACK, TEST_SOURCE } = require('./helpers/packs');
const { luaValue } = require('../tools/lib/playtest');

const CORE = { name: 'Polestar', files: ['Core/Core.xml'] };

const WORLD = `
local w = stub.world
w.addMap(1429, { name = "Elwynn Forest", c = 0, left = 1500, right = -1500, top = 500, bottom = -1500 })
w.moveTo(1429, 48, 42)
w.titles[783] = "A Threat Within"
w.titles[7] = "Kobold Camp Cleanup"
w.onQuest(783, {})
`;

// Step 1 offers group quest 7 (Kobold Camp Cleanup, standing in for a group
// quest), step 2 hands it in, step 3 hands in A Threat Within.
const GROUP_GUIDE = `
Polestar.RegisterGuide({
	id = "test/group", pack = "test", title = "Group", minLevel = 1, maxLevel = 10,
	steps = {
		{ title = "Group quest", when = { { k = "group", q = 7 } }, goals = {
			{ t = "accept", quest = 7, title = "Kobold Camp Cleanup", npc = 197, npcName = "Marshal McBride", map = 1429, x = 48.9, y = 41.6 },
		} },
		{ title = "Hand it in", goals = {
			{ t = "turnin", quest = 7, title = "Kobold Camp Cleanup", npc = 197, npcName = "Marshal McBride", map = 1429, x = 48.9, y = 41.6 },
		} },
		{ title = "Marshal McBride", goals = {
			{ t = "turnin", quest = 783, title = "A Threat Within", npc = 197, npcName = "Marshal McBride", map = 1429, x = 48.9, y = 41.6 },
		} },
	},
})
`;

// A solo and a group way to the same objective of A Threat Within, already in
// the log: step 1 for those who skip, step 2 for those who group.
const PAIR_GUIDE = `
Polestar.RegisterGuide({
	id = "test/group", pack = "test", title = "Group", minLevel = 1, maxLevel = 10,
	steps = {
		{ title = "The solo way", when = { { k = "group", q = 783, neg = true } }, goals = { { t = "task", text = "Pull one at a time" } } },
		{ title = "With a group", when = { { k = "group", q = 783 } }, goals = { { t = "task", text = "Clear the camp" } } },
		{ title = "Marshal McBride", goals = {
			{ t = "turnin", quest = 783, title = "A Threat Within", npc = 197, npcName = "Marshal McBride", map = 1429, x = 48.9, y = 41.6 },
		} },
	},
})
`;

const HELPERS = `
E = Polestar.Engine
function flush() stub.advance(0.25) end
function at() return E.GetLiveStep() end
`;

function run({ guide = GROUP_GUIDE, saved = { schema: 1, guide: 'test/group' }, script }) {
	return runAddon({
		stubs: ['stub_world.lua'],
		before: WORLD,
		addons: [CORE],
		saved: { Polestar: `PolestarCharDB = ${luaValue(saved)}` },
		script: `${TEST_PACK}
${TEST_SOURCE}\n${guide}\n${HELPERS}\nstub.login()\nstub.fire("QUEST_LOG_UPDATE"); stub.advance(0.6)\n${script}`,
	}).emitted;
}

test('unanswered, the route waits at the group step and asks about its quest', () => {
	const [rows] = run({ script: 'local q, title = E.GroupQuestion(); emit({ at = at(), q = q, title = title, answer = E.GroupAnswer(7) or false })' });
	assert.deepEqual(rows, { at: 1, q: 7, title: 'Kobold Camp Cleanup', answer: false });
});

test('a step whose goals are done still waits for the answer', () => {
	// Step 1 asks about A Threat Within, already in the log: its accept is done.
	const guide = GROUP_GUIDE.replace('{ k = "group", q = 7 }', '{ k = "group", q = 783 }').replace('{ t = "accept", quest = 7, title = "Kobold Camp Cleanup"', '{ t = "accept", quest = 783, title = "A Threat Within"');
	const [waiting, answered] = run({ guide, script: 'emit(at()); E.AnswerGroup(783, "do"); flush(); emit(at())' });
	assert.equal(waiting, 1);
	assert.equal(answered, 3);
});

test('"skip" passes the step and its turn-in goes with it; "do" keeps the quest on the route', () => {
	const [skipped, db] = run({ script: 'E.AnswerGroup(7, "skip"); flush(); emit({ at = at(), s1 = E.GetStepView(1).status, q = E.GroupQuestion() or false }); stub.fire("PLAYER_LOGOUT"); emit(PolestarCharDB.groupQuests)' });
	assert.deepEqual(skipped, { at: 3, s1: 'skipped', q: false });
	assert.deepEqual(db, { 7: 'skip' });
	const [done] = run({ script: 'E.AnswerGroup(7, "do"); flush(); emit({ at = at(), s1 = E.GetStepView(1).status, q = E.GroupQuestion() or false })' });
	assert.deepEqual(done, { at: 1, s1: 'current', q: false });
});

test('the answer is kept per character and asked for no more', () => {
	const [rows] = run({ saved: { schema: 1, guide: 'test/group', groupQuests: { 7: 'skip' } }, script: 'emit({ at = at(), q = E.GroupQuestion() or false })' });
	assert.deepEqual(rows, { at: 3, q: false });
});

test('a solo alternative: unanswered waits at the first; "skip" takes the solo way, "do" the group way', () => {
	const [waiting] = run({ guide: PAIR_GUIDE, script: 'emit({ at = at(), q = E.GroupQuestion() or false })' });
	assert.deepEqual(waiting, { at: 1, q: 783 });
	const [solo] = run({ guide: PAIR_GUIDE, script: 'E.AnswerGroup(783, "skip"); flush(); emit({ at = at(), s2 = E.GetStepView(2).status })' });
	assert.deepEqual(solo, { at: 1, s2: 'na' });
	const [group] = run({ guide: PAIR_GUIDE, script: 'E.AnswerGroup(783, "do"); flush(); emit({ at = at(), s1 = E.GetStepView(1).status })' });
	assert.deepEqual(group, { at: 2, s1: 'skipped' });
});

test('automation takes no unanswered group quest; after "do" it does', () => {
	const [before, after] = run({ script: 'emit(E.WantsQuest("accept", 7)); E.AnswerGroup(7, "do"); flush(); emit(E.WantsQuest("accept", 7))' });
	assert.equal(before, false);
	assert.equal(after, true);
});

test('an unknown answer is ignored; once the route has passed the step, a new answer leaves its stored outcome', () => {
	const [rows] = run({ script: 'E.AnswerGroup(7, "skip"); flush(); E.AnswerGroup(7, "maybe"); local kept = E.GroupAnswer(7); E.AnswerGroup(7, "do"); flush(); emit({ kept = kept, at = at(), s1 = E.GetStepView(1).status })' });
	assert.deepEqual(rows, { kept: 'skip', at: 3, s1: 'skipped' });
});

test('an along step does not wait for an answer', () => {
	const guide = GROUP_GUIDE.replace('{ title = "Group quest", when', '{ title = "Group quest", along = true, when');
	const [rows] = run({ guide, script: 'emit({ at = at(), q = E.GroupQuestion() or false })' });
	assert.deepEqual(rows, { at: 2, q: false });
});

test('Guides.Validate takes `group` with one quest id on a step, and refuses it on a `next` option or a `skipto`', () => {
	const [rows] = runAddon({
		stubs: ['stub_world.lua'],
		addons: [CORE],
		script: `
			local V = Polestar.Guides.Validate
			local function g(step, extra) local d = { id = "t/v", pack = "test", title = "V", minLevel = 1, maxLevel = 10, steps = { step, { label = "end", goals = { { t = "note", text = "y" } } } } }; for k, v in pairs(extra or {}) do d[k] = v end; return d end
			local note = { { t = "note", text = "x" } }
			emit({
				ok = V(g({ when = { { k = "group", q = 7, neg = true } }, goals = note })) or "ok",
				noQuest = V(g({ when = { { k = "group" } }, goals = note })) or "ok",
				skipto = V(g({ skipto = { { to = "end", when = { k = "group", q = 7 } } }, goals = note })) or "ok",
				nextWhen = V(g({ goals = note }, { next = "t/w", nextChoices = { "t/w" }, nextWhen = { ["t/w"] = { { k = "group", q = 7 } } } })) or "ok",
			})
		`,
	}).emitted;
	assert.equal(rows.ok, 'ok');
	assert.match(rows.noQuest, /bad when/);
	assert.match(rows.skipto, /bad skipto/);
	assert.match(rows.nextWhen, /bad nextWhen/);
});

test('GroupQuests lists the group quests of this character\'s guides, once each; the Options tab answers them', () => {
	// An Alliance Warrior: the Horde guide's quest and the Mage-only step's are not listed.
	const guides = `
Polestar.RegisterGuide({ id = "test/a", pack = "test", title = "A", faction = "Alliance", minLevel = 1, maxLevel = 10, steps = {
	{ when = { { k = "group", q = 7 } }, goals = { { t = "accept", quest = 7, title = "Kobold Camp Cleanup", npc = 197, map = 1429, x = 48.9, y = 41.6 } } },
	{ when = { { k = "group", q = 7, neg = true } }, goals = { { t = "note", text = "Solo" } } },
	{ only = { classes = { "MAGE" } }, when = { { k = "group", q = 9 } }, goals = { { t = "note", text = "Mages" } } },
} })
Polestar.RegisterGuide({ id = "test/h", pack = "test", title = "H", faction = "Horde", minLevel = 1, maxLevel = 10, steps = {
	{ when = { { k = "group", q = 8 } }, goals = { { t = "note", text = "Horde" } } },
} })
`;
	const [list, tab] = runAddon({
		stubs: ['stub_world.lua'],
		before: WORLD,
		addons: [{ name: 'Polestar', files: ['Core/Core.xml', 'Theme/Theme.xml', 'Dungeons/Dungeons.xml'] }],
		script: `${TEST_PACK}
${TEST_SOURCE}\n${guides}\nstub.login()
			emit(Polestar.Engine.GroupQuests())
			local out = {}
			for _, spec in ipairs(Polestar.Widgets.OptionsRegistry) do
				if spec.page == "Discovery" and spec.tab == "Group quests" then
					for _, c in ipairs(spec.controls) do
						local before = c.get()
						c.set(true)
						out[#out + 1] = { label = c.label(), before = before, after = Polestar.Engine.GroupAnswer(7) }
						c.set(false)
						out[#out].off = Polestar.Engine.GroupAnswer(7)
					end
				end
			end
			emit(out)
		`,
	}).emitted;
	assert.deepEqual(list, [{ quest: 7, title: 'Kobold Camp Cleanup' }]);
	assert.deepEqual(tab, [{ label: 'Kobold Camp Cleanup', before: false, after: 'do', off: 'skip' }]);
});
