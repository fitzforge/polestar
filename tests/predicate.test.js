'use strict';
// Core/Predicate.lua: the closed, declarative condition language a format-2
// guide uses in `when` lines. Predicates are plain Lua tables in prefix form
// (never code); Validate rejects anything outside the whitelist and Eval
// answers them against the live character through ns.Compat.

const { test } = require('node:test');
const assert = require('node:assert/strict');
const { runAddon } = require('./helpers/lua');

const CORE = { name: 'Polestar', files: ['Core/Init.lua', 'Core/Compat.lua', 'Core/Predicate.lua'] };

function run(script, before = '') {
	return runAddon({
		stubs: ['stub_world.lua'],
		before,
		addons: [CORE],
		script,
	}).emitted;
}

// Init.lua sets the global `Polestar` to the addon namespace, so
// `ns.Predicate` is reachable as `Polestar.Predicate`.
function evalAll(cases, before = '') {
	const body = cases.map((c) => `emit(Polestar.Predicate.Eval(${c}))`).join('\n');
	return run(body, before);
}

test('Predicate module is published on the Polestar global', () => {
	const [t] = run('emit(type(Polestar.Predicate) == "table" and type(Polestar.Predicate.Eval) == "function" and type(Polestar.Predicate.Validate) == "function")');
	assert.equal(t, true);
});

test('quest state atoms: onquest, ready, turnedin', () => {
	const out = evalAll(
		[
			'{ "onquest", 7 }',
			'{ "onquest", 8 }',
			'{ "ready", 7 }',
			'{ "turnedin", 783 }',
			'{ "turnedin", 7 }',
		],
		'stub.world.accept(7, { 10 }); stub.world.completed[783] = true',
	);
	assert.deepEqual(out, [true, false, false, true, false]);
});

test('ready is true once every objective is done', () => {
	const out = evalAll(['{ "ready", 7 }'], 'stub.world.accept(7, { 2 }); stub.world.progress(7, 1, 2)');
	assert.deepEqual(out, [true]);
});

test('item counts compare with an operator', () => {
	const out = evalAll(
		[
			'{ "item", 750, ">=", 3 }',
			'{ "item", 750, ">=", 4 }',
			'{ "item", 750, "==", 3 }',
			'{ "item", 750, "<", 1 }',
			'{ "item", 999, "==", 0 }',
		],
		'stub.world.addItem(750, 3)',
	);
	assert.deepEqual(out, [true, false, true, false, true]);
});

test('level compares with every operator', () => {
	const out = evalAll(
		[
			'{ "level", ">=", 10 }',
			'{ "level", ">", 10 }',
			'{ "level", "<=", 10 }',
			'{ "level", "<", 10 }',
			'{ "level", "==", 10 }',
			'{ "level", "~=", 10 }',
		],
		'stub.world.level = 10',
	);
	assert.deepEqual(out, [true, false, true, false, true, false]);
});

test('character atoms: class, race, faction', () => {
	const out = evalAll([
		'{ "class", { "WARRIOR", "MAGE" } }',
		'{ "class", { "MAGE" } }',
		'{ "race", { "Human" } }',
		'{ "race", { "Orc", "Troll" } }',
		'{ "faction", "Alliance" }',
		'{ "faction", "Horde" }',
	]);
	assert.deepEqual(out, [true, false, true, false, true, false]);
});

test('zone matches the current zone name, case-insensitively', () => {
	const out = evalAll(['{ "zone", "Elwynn Forest" }', '{ "zone", "elwynn forest" }', '{ "zone", "Westfall" }']);
	assert.deepEqual(out, [true, true, false]);
});

test('skill rank compares; an unknown profession counts as rank 0', () => {
	const out = evalAll(
		['{ "skill", 186, ">=", 50 }', '{ "skill", 186, ">=", 51 }', '{ "skill", 182, "==", 0 }'],
		'stub.world.learnSkill(186, "Mining", 50, 75)',
	);
	assert.deepEqual(out, [true, false, true]);
});

test('reputation compares the standing id (1 Hated .. 8 Exalted); unknown faction is false', () => {
	const out = evalAll(
		['{ "rep", 72, ">=", 5 }', '{ "rep", 72, ">=", 6 }', '{ "rep", 999, ">=", 1 }'],
		'stub.world.setRep(72, "Stormwind", 5, 100)',
	);
	assert.deepEqual(out, [true, false, false]);
});

test('combinators all, any, not', () => {
	const out = evalAll(
		[
			'{ "all", { "level", ">=", 5 }, { "class", { "WARRIOR" } } }',
			'{ "all", { "level", ">=", 5 }, { "class", { "MAGE" } } }',
			'{ "any", { "class", { "MAGE" } }, { "faction", "Alliance" } }',
			'{ "any", { "class", { "MAGE" } }, { "faction", "Horde" } }',
			'{ "not", { "faction", "Horde" } }',
			'{ "all" }',
			'{ "any" }',
		],
		'stub.world.level = 6',
	);
	assert.deepEqual(out, [true, false, true, false, true, true, false]);
});

test('Eval returns a strict boolean and never throws on a bad node', () => {
	const out = evalAll(['{ "bogus", 1 }', 'nil', '"onquest"']);
	assert.deepEqual(out, [false, false, false]);
});

test('one env caches lookups across a pass: Eval(node, env) reuses it', () => {
	const [calls, a, b] = run(`
		local n = 0
		local real = C_QuestLog.IsOnQuest
		C_QuestLog.IsOnQuest = function(q) n = n + 1; return real(q) end
		local P = Polestar.Predicate
		local env = P.NewEnv()
		local a = P.Eval({ "onquest", 7 }, env)
		local b = P.Eval({ "all", { "onquest", 7 }, { "not", { "onquest", 7 } } }, env)
		emit(n); emit(a); emit(b)
	`, 'stub.world.accept(7, { 1 })');
	assert.equal(calls, 1);
	assert.equal(a, true);
	assert.equal(b, false);
});

test('Validate accepts every well-formed node', () => {
	const nodes = [
		'{ "onquest", 7 }', '{ "ready", 7 }', '{ "turnedin", 7 }',
		'{ "item", 750, ">=", 3 }', '{ "level", "<", 10 }',
		'{ "class", { "WARRIOR" } }', '{ "race", { "Human", "Dwarf" } }', '{ "faction", "Horde" }',
		'{ "zone", "Elwynn Forest" }', '{ "skill", 186, ">=", 1 }', '{ "rep", 72, ">=", 5 }',
		'{ "all", { "onquest", 7 }, { "not", { "any", { "level", ">=", 2 } } } }',
	];
	const out = run(nodes.map((n) => `emit(Polestar.Predicate.Validate(${n}) == true)`).join('\n'));
	assert.deepEqual(out, nodes.map(() => true));
});

test('Validate rejects malformed nodes with a message', () => {
	const bad = [
		'nil',
		'{}',
		'{ "bogus", 1 }',
		'{ "onquest" }',
		'{ "onquest", "7" }',
		'{ "onquest", 7, 8 }',
		'{ "item", 750, "=>", 3 }',
		'{ "item", 750, ">=" }',
		'{ "level", ">=", 1.5 }',
		'{ "class", "WARRIOR" }',
		'{ "class", {} }',
		'{ "faction", "Neutral" }',
		'{ "rep", 72, ">=", 9 }',
		'{ "not" }',
		'{ "not", { "onquest", 7 }, { "onquest", 8 } }',
		'{ "all", { "bogus" } }',
		'{ "all", 5 }',
	];
	const out = run(
		bad.map((n) => `do local ok, err = Polestar.Predicate.Validate(${n}); emit({ ok = ok == true, msg = type(err) == "string" and #err > 0 }) end`).join('\n'),
	);
	assert.deepEqual(out, bad.map(() => ({ ok: false, msg: true })));
});

test('Validate rejects nesting deeper than 16 levels', () => {
	const [r] = run(`
		local n = { "onquest", 7 }
		for i = 1, 17 do n = { "not", n } end
		local ok = Polestar.Predicate.Validate(n)
		emit(ok == true)
	`);
	assert.equal(r, false);
});
