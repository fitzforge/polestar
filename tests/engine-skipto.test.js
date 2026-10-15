'use strict';
// Phase 3, Task 3.3: `skipto` jumps and the `done` atom at runtime. When the
// route arrives at a step whose `skips` entry holds, the steps from it up to
// (not including) the labelled step are skipped for the character, saved as
// "jump" in CharState().skipped, so the jump does not undo itself when the
// condition later turns false. `done <label>` is true when the labelled step
// is done and was not skipped.

const { test } = require('node:test');
const assert = require('node:assert/strict');
const { runAddon } = require('./helpers/lua');
const { TEST_SOURCE } = require('./helpers/packs');

const CORE = { name: 'Polestar', files: ['Core/Core.xml'] };
const PACK2 = 'Polestar.RegisterPack({ addon = "Polestar_Test", id = "test", format = 2, title = "Test", author = "Test", version = "1", license = "MIT" })';

const WORLD = `
local w = stub.world
w.addMap(1429, { name = "Elwynn Forest", c = 0, left = 1500, right = -1500, top = 500, bottom = -1500 })
w.moveTo(1429, 48, 42)
w.titles[783] = "A Threat Within"; w.titles[7] = "Kobold Camp Cleanup"
`;

// 1 accept 7, jump to "end" while holding a candle · 2 kill vermin · 3 "mid":
// accept 783 · 4 "end": level 4 (a turn-in of a quest never taken would be passed over) · 5 only when "mid" is done: level 5 · 6 level 6
const GUIDE = `
Polestar.RegisterGuide({
	id = "test/01-jump", pack = "test", title = "Jump",
	faction = "Alliance", races = { "Human" }, minLevel = 1, maxLevel = 6, zone = 1429,
	steps = {
		{ title = "McBride", skips = { { to = "end", when = { "item", 750, ">=", 1 } } },
			goals = { { t = "accept", quest = 7, title = "Kobold Camp Cleanup", npc = 197, npcName = "Marshal McBride", map = 1429, x = 48.9, y = 41.6 } } },
		{ title = "Kobolds", goals = { { t = "kill", target = "Kobold Vermin", npc = 6, count = 10, quest = 7, oi = 1, map = 1429, x = 47.6, y = 35.1 } } },
		{ title = "Willem", label = "mid", goals = { { t = "accept", quest = 783, title = "A Threat Within", npc = 823, npcName = "Deputy Willem", map = 1429, x = 48.2, y = 42.0 } } },
		{ title = "Level 4", label = "end", goals = { { t = "level", level = 4 } } },
		{ title = "If Willem", when = { "done", "mid" }, goals = { { t = "level", level = 5 } } },
		{ title = "End", goals = { { t = "level", level = 6 } } },
	},
})
`;

const HELPERS = `
function flush() stub.advance(0.25) end
E = Polestar.Engine
function jumps()
	local sk = Polestar.CharState().skipped["test/01-jump"] or {}
	local out = {}
	for s = 1, 6 do out[#out + 1] = tostring(sk[s]) end
	return out
end
`;

function run(script, before = '') {
	return runAddon({
		stubs: ['stub_world.lua'],
		before: WORLD + before,
		addons: [CORE],
		script: `${PACK2}\n${TEST_SOURCE}\n${GUIDE}\n${HELPERS}\nstub.login()\n${script}`,
	}).emitted;
}

test('no jump: the route runs in order, and `done mid` makes step 5 apply', () => {
	const out = run(`
		local w = stub.world
		flush(); emit(E.GetStepIndex())
		w.accept(7, { 10 }); flush(); emit(E.GetStepIndex())
		w.progress(7, 1, 10); flush(); emit(E.GetStepIndex())
		w.accept(783, {}); flush(); emit(E.GetStepIndex())
		w.setLevel(4); flush(); emit(E.GetStepIndex())
		emit(jumps())
	`);
	assert.deepEqual(out, [1, 2, 3, 4, 5, ['nil', 'nil', 'nil', 'nil', 'nil', 'nil']]);
});

test('a jump that holds on arrival skips up to the label, saved as "jump"; a jumped-over label is not done', () => {
	const out = run(`
		local w = stub.world
		flush(); emit(E.GetStepIndex())
		emit(jumps())
		emit(E.GetStepView(2).skipped)
		w.setLevel(4); flush(); emit(E.GetStepIndex())
	`, 'stub.world.addItem(750, 1)');
	assert.deepEqual(out, [4, ['jump', 'jump', 'jump', 'nil', 'nil', 'nil'], true, 6]);
});

test('a jump fires only when the route is at its step, and stays when the condition turns false', () => {
	const out = run(`
		local w = stub.world
		flush(); emit(E.GetStepIndex())
		w.addItem(750, 1); flush(); emit(E.GetStepIndex())    -- the route is at step 1: it jumps now
		w.items[750] = nil; stub.fire("BAG_UPDATE_DELAYED"); flush()
		emit(E.GetStepIndex())                                 -- still 4: the jump is saved
	`);
	assert.deepEqual(out, [1, 4, 4]);
});

test('Guides.Validate checks skips', () => {
	const out = run(`
		local function def(steps) return { id = "test/x", pack = "test", title = "X", steps = steps } end
		local G = { { t = "level", level = 2 } }
		local ok = { "level", ">=", 2 }
		emit(Polestar.Guides.Validate(def({ { skips = { { to = "b", when = ok } }, goals = G }, { label = "b", goals = G } })) == nil)
		emit(Polestar.Guides.Validate(def({ { skips = { { to = "b", when = { "bogus" } } }, goals = G }, { label = "b", goals = G } })))
		emit(Polestar.Guides.Validate(def({ { skips = { { to = "nowhere", when = ok } }, goals = G } })))
		emit(Polestar.Guides.Validate(def({ { label = "b", goals = G }, { skips = { { to = "b", when = ok } }, goals = G } })))
		emit(Polestar.Guides.Validate(def({ { skips = "b", goals = G }, { label = "b", goals = G } })))
		emit(Polestar.Guides.Validate(def({ { skips = { { to = "b" } }, goals = G }, { label = "b", goals = G } })))
	`);
	assert.equal(out[0], true);
	for (let i = 1; i < out.length; i++) assert.match(out[i], /^step [12]: bad skipto/, `case ${i}: ${out[i]}`);
});
