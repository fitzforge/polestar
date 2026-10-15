'use strict';
// Phase 5, Task 5.3: `level <L>.<frac>` and `level <L>+<XP>` goals (RXP's
// `.xp`): reach a point inside a level. Compiled to { t = "level", level = L,
// frac = f }; a pack using `frac` is format 2. The Engine counts the goal done
// at level L with XP/XPMax >= f, or any higher level.

const { test } = require('node:test');
const assert = require('node:assert/strict');
const { compile, guideText, plain } = require('./helpers/dsl');
const { packFormat } = require('../tools/lib/dsl/project');
const { runAddon } = require('./helpers/lua');
const { TEST_SOURCE } = require('./helpers/packs');

const goalsOf = (lines) => {
	const r = compile(guideText(lines));
	assert.deepEqual(r.errors, [], r.text);
	return { goals: plain(r.guides[0].steps.flatMap((s) => s.goals)), guides: r.guides };
};
const errorsOf = (lines) => compile(guideText(lines)).errors.join('\n');

test('level with a fraction or with +XP compiles to level + frac; plain level is unchanged', () => {
	const { goals, guides } = goalsOf(['step One', '  level 3.5', 'step Two', '  level 12+5050', 'step Three', '  level 13']);
	assert.deepEqual(goals[0], { t: 'level', level: 3, frac: 0.5 });
	assert.deepEqual(goals[1], { t: 'level', level: 12, frac: 0.5 });
	assert.deepEqual(goals[2], { t: 'level', level: 13 });
	assert.equal(packFormat(guides), 2);
	assert.equal(packFormat(goalsOf(['step One', '  level 13']).guides), 1);
});

test('level fraction errors', () => {
	assert.match(errorsOf(['step One', '  level 12+99999']), /more XP than level 12 needs/);
	assert.match(errorsOf(['step One', '  level 0.5']), /malformed level/);
	assert.match(errorsOf(['step One', '  level 12.5x']), /malformed level/);
	assert.match(errorsOf(['step One', '  level 60.5']), /malformed level/);
});

const CORE = { name: 'Polestar', files: ['Core/Core.xml'] };
const PACK2 = 'Polestar.RegisterPack({ addon = "Polestar_Test", id = "test", format = 2, title = "Test", author = "Test", version = "1", license = "MIT" })';
const GUIDE = `
Polestar.RegisterGuide({
	id = "test/01-xp", pack = "test", title = "XP", faction = "Alliance", races = { "Human" }, minLevel = 1, maxLevel = 6,
	steps = {
		{ title = "Half of 3", goals = { { t = "level", level = 3, frac = 0.5 } } },
		{ title = "End", goals = { { t = "level", level = 6 } } },
	},
})`;

test('the Engine counts a fractional level goal by XP within the level', () => {
	const { emitted } = runAddon({
		stubs: ['stub_world.lua'],
		before: 'stub.world.addMap(1429, { name = "Elwynn Forest", c = 0, left = 1500, right = -1500, top = 500, bottom = -1500 }); stub.world.moveTo(1429, 48, 42)',
		addons: [CORE],
		script: `${PACK2}\n${TEST_SOURCE}\n${GUIDE}\nstub.login()
			local w, E = stub.world, Polestar.Engine
			local function flush() stub.advance(0.25) end
			local function xp(n) w.xp = n; stub.fire("PLAYER_XP_UPDATE", "player"); flush() end
			flush()
			w.setLevel(3); w.xpMax = 1400; flush()
			xp(100); emit(E.GetStepIndex())
			emit(E.GetStepView(1).goals[1].subject)
			xp(700); emit(E.GetStepIndex())`,
	});
	assert.deepEqual(emitted, [1, '3 (50%)', 2]);
});

test('a later level counts too', () => {
	const { emitted } = runAddon({
		stubs: ['stub_world.lua'],
		before: 'stub.world.addMap(1429, { name = "Elwynn Forest", c = 0, left = 1500, right = -1500, top = 500, bottom = -1500 }); stub.world.moveTo(1429, 48, 42)',
		addons: [CORE],
		script: `${PACK2}\n${TEST_SOURCE}\n${GUIDE}\nstub.login()
			local w, E = stub.world, Polestar.Engine
			stub.advance(0.25)
			w.setLevel(4); w.xp = 0; stub.advance(0.25)
			emit(E.GetStepIndex())`,
	});
	assert.deepEqual(emitted, [2]);
});
