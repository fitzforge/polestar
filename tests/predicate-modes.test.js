'use strict';
// Phase 5, Task 5.1: play-mode and XP atoms in Core/Predicate.lua.
//   { "mode", key }        a player setting (modes.<key>) is on; key is one of
//                          hardcore, ssf, ah, group
//   { "xprate", op, n }    the player's XP-rate setting (modes.xprate, default 1)
//   { "xp", op, v }        level + XP progress through it (12.5 = halfway through 12)
// Defaults: hardcore, ssf and group off, ah on, xprate 1.

const { test } = require('node:test');
const assert = require('node:assert/strict');
const { runAddon } = require('./helpers/lua');

const CORE = { name: 'Polestar', files: ['Core/Init.lua', 'Core/Compat.lua', 'Core/Predicate.lua'] };

function run(script, before = '') {
	return runAddon({ stubs: ['stub_world.lua'], before, addons: [CORE], script }).emitted;
}
const evalAll = (cases, setup = '', before = '') =>
	run(`${setup}\n${cases.map((c) => `emit(Polestar.Predicate.Eval(${c}))`).join('\n')}`, before);

test('mode defaults: hardcore, ssf, group off; ah on; xprate 1', () => {
	const out = evalAll(['{ "mode", "hardcore" }', '{ "mode", "ssf" }', '{ "mode", "group" }', '{ "mode", "ah" }', '{ "xprate", "==", 1 }']);
	assert.deepEqual(out, [false, false, false, true, true]);
	const [d] = run('emit({ Polestar.GetDefault("modes.hardcore"), Polestar.GetDefault("modes.ah"), Polestar.GetDefault("modes.xprate") })');
	assert.deepEqual(d, [false, true, 1]);
});

test('modes follow the player settings live', () => {
	const out = evalAll(
		['{ "mode", "hardcore" }', '{ "mode", "ah" }', '{ "not", { "mode", "ah" } }', '{ "xprate", ">", 1 }', '{ "xprate", "<", 1.5 }', '{ "xprate", ">=", 2 }'],
		'Polestar.Set("modes.hardcore", true); Polestar.Set("modes.ah", false); Polestar.Set("modes.xprate", 1.25)',
	);
	assert.deepEqual(out, [true, false, true, true, true, false]);
});

test('xp: level plus the fraction of the level done', () => {
	// level 12, 1300 of 10100 XP into it -> 12.1287...
	const out = evalAll(
		['{ "xp", ">=", 12 }', '{ "xp", ">=", 12.1 }', '{ "xp", ">=", 12.2 }', '{ "xp", "<", 13 }', '{ "xp", ">", 11.99 }'],
		'',
		'stub.world.level = 12; stub.world.xp = 1300; stub.world.xpMax = 10100',
	);
	assert.deepEqual(out, [true, true, false, true, true]);
});

test('xp with no XP bar (xpMax 0, e.g. max level) counts as the level itself', () => {
	const out = evalAll(['{ "xp", ">=", 60 }', '{ "xp", ">", 60 }'], '', 'stub.world.level = 60; stub.world.xp = 0; stub.world.xpMax = 0');
	assert.deepEqual(out, [true, false]);
});

test('Validate: mode keys are a closed list; xprate and xp take a non-negative number', () => {
	const good = ['{ "mode", "hardcore" }', '{ "mode", "ssf" }', '{ "mode", "ah" }', '{ "mode", "group" }', '{ "xprate", ">=", 1.5 }', '{ "xp", ">=", 12.5 }', '{ "xp", "<", 7 }'];
	const bad = ['{ "mode", "season" }', '{ "mode" }', '{ "mode", 1 }', '{ "xprate", ">=", -1 }', '{ "xprate", "=>", 1 }', '{ "xp", ">=" }', '{ "xp", ">=", "12" }', '{ "xp", ">=", 12, 1 }'];
	const out = run([...good, ...bad].map((n) => `do local ok, e = Polestar.Predicate.Validate(${n}); emit({ ok = ok == true, msg = type(e) == "string" }) end`).join('\n'));
	assert.deepEqual(out.slice(0, good.length), good.map(() => ({ ok: true, msg: false })));
	assert.deepEqual(out.slice(good.length), bad.map(() => ({ ok: false, msg: true })));
});
