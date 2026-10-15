'use strict';
// Format-2 `along` steps at runtime:
// an along step never holds up the route; its open goals are listed by
// Engine.GetAlong() while the route is past it and, with `until`, before the
// labelled step. Core/Guides.lua validates `label` and `along`.

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

// 1 accept 7 · 2 along until "back": kill 10 vermin (quest 7) and hold 2
// candles (item 750) · 3 along (no until): hold 1 linen (item 2589) ·
// 4 accept 783 · 5 "back": turn in 7 · 6 level 6
const GUIDE = `
Polestar.RegisterGuide({
	id = "test/01-along", pack = "test", title = "Along",
	faction = "Alliance", races = { "Human" }, minLevel = 1, maxLevel = 6, zone = 1429,
	steps = {
		{ title = "McBride", goals = { { t = "accept", quest = 7, title = "Kobold Camp Cleanup", npc = 197, npcName = "Marshal McBride", map = 1429, x = 48.9, y = 41.6 } } },
		{ title = "Kobolds on the way", along = "back", goals = {
			{ t = "kill", target = "Kobold Vermin", npc = 6, count = 10, quest = 7, oi = 1, map = 1429, x = 47.6, y = 35.1 },
			{ t = "collect", item = 750, itemName = "Candle", count = 2 },
		} },
		{ title = "Linen", along = true, goals = { { t = "collect", item = 2589, itemName = "Linen Cloth", count = 1 } } },
		{ title = "Willem", goals = { { t = "accept", quest = 783, title = "A Threat Within", npc = 823, npcName = "Deputy Willem", map = 1429, x = 48.2, y = 42.0 } } },
		{ title = "Back to McBride", label = "back", goals = { { t = "turnin", quest = 7, title = "Kobold Camp Cleanup", npc = 197, npcName = "Marshal McBride", map = 1429, x = 48.9, y = 41.6 } } },
		{ title = "End", goals = { { t = "level", level = 6 } } },
	},
})
`;

const HELPERS = `
function flush() stub.advance(0.25) end
E = Polestar.Engine
-- { "<step>:<goal>:<status>[:cur]", ... } of Engine.GetAlong()
function along()
	local out = {}
	for _, s in ipairs(E.GetAlong()) do
		for _, g in ipairs(s.goals) do
			out[#out + 1] = s.index .. ":" .. g.index .. ":" .. g.status .. (g.progress and (":" .. g.progress.cur) or "")
		end
	end
	return out
end
`;

// The Lua stub encodes an empty table as {}; read it as an empty list.
const norm = (v) => (v && typeof v === 'object' && !Array.isArray(v) && Object.keys(v).length === 0 ? [] : v);

function run(script, guides = GUIDE) {
	return runAddon({
		stubs: ['stub_world.lua'],
		before: WORLD,
		addons: [CORE],
		script: `${PACK2}\n${TEST_SOURCE}\n${guides}\n${HELPERS}\nstub.login()\n${script}`,
	}).emitted.map(norm);
}

test('along steps never become the current step; their goals are listed until done or until the label', () => {
	const out = run(`
		local w = stub.world
		flush()
		emit(E.GetStepIndex()); emit(along())                      -- before reaching them: nothing along
		w.accept(7, { 10 }); flush()
		emit(E.GetStepIndex()); emit(along())                      -- route jumps to step 4; 2 and 3 are along
		w.progress(7, 1, 4); flush()
		emit(along())                                              -- progress shows
		w.progress(7, 1, 10); w.addItem(750, 2); flush()
		emit(along())                                              -- step 2's goals done: gone
		w.accept(783, {}); flush()
		emit(E.GetStepIndex()); emit(along())                      -- step 5 "back": step 2 would end here anyway; 3 stays
		w.addItem(2589, 1); flush()
		emit(along())                                              -- step 3 done
	`);
	assert.deepEqual(out, [
		1, [],
		4, ['2:1:active:0', '2:2:active:0', '3:1:active:0'],
		['2:1:active:4', '2:2:active:0', '3:1:active:0'],
		['3:1:active:0'],
		5, ['3:1:active:0'],
		[],
	]);
});

test('`until`: reaching the labelled step ends the along step even with goals open', () => {
	const out = run(`
		local w = stub.world
		flush()
		w.accept(7, { 10 }); flush()
		w.accept(783, {}); flush()
		emit(E.GetStepIndex()); emit(along())
	`);
	assert.deepEqual(out, [5, ['3:1:active:0']]);
});

test('an along step that does not apply (when / only) is never listed', () => {
	const g = GUIDE.replace('along = true,', 'along = true, when = { "level", ">=", 50 },').replace('along = "back",', 'along = "back", only = { classes = { "MAGE" } },');
	const out = run(`
		local w = stub.world
		flush()
		w.accept(7, { 10 }); flush()
		emit(E.GetStepIndex()); emit(along())
	`, g);
	assert.deepEqual(out, [4, []]);
});

test('GetStepView exposes along and label; the entry carries the step title', () => {
	const out = run(`
		flush()
		stub.world.accept(7, { 10 }); flush()
		emit(E.GetStepView(2).along); emit(E.GetStepView(3).along); emit(E.GetStepView(5).label); emit(E.GetStepView(4).along == nil)
		emit(E.GetAlong()[1].title)
	`);
	assert.deepEqual(out, ['back', true, 'back', true, 'Kobolds on the way']);
});

test('Guides.Validate checks label and along', () => {
	const out = run(`
		local function def(steps) return { id = "test/x", pack = "test", title = "X", steps = steps } end
		local G = { { t = "level", level = 2 } }
		emit(Polestar.Guides.Validate(def({ { along = "b", goals = G }, { label = "b", goals = G } })) == nil)
		emit(Polestar.Guides.Validate(def({ { along = true, goals = G } })) == nil)
		emit(Polestar.Guides.Validate(def({ { label = 5, goals = G } })))
		emit(Polestar.Guides.Validate(def({ { label = "a", goals = G }, { label = "a", goals = G } })))
		emit(Polestar.Guides.Validate(def({ { along = "nowhere", goals = G } })))
		emit(Polestar.Guides.Validate(def({ { label = "b", goals = G }, { along = "b", goals = G } })))
		emit(Polestar.Guides.Validate(def({ { along = 3, goals = G } })))
	`);
	assert.equal(out[0], true);
	assert.equal(out[1], true);
	assert.match(out[2], /^step 1: bad label/);
	assert.match(out[3], /^step 2: duplicate label/);
	assert.match(out[4], /^step 1: bad along/);
	assert.match(out[5], /^step 2: bad along/);
	assert.match(out[6], /^step 1: bad along/);
});
